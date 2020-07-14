Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E94C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:23:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AC302068F
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TPs7x3Zp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC302068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvTKK-0001ZT-DD
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 18:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTJ3-0000B3-DP
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:21:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26937
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTJ0-0004Uu-FQ
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594765300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=omtkizb4M/amnWnpKjXrvbTRB/FuvzwoZzcd22eJfwk=;
 b=TPs7x3ZpYjS/7vTLxYUCFR18e930iTrBJFgv97W/lujHvHIWoLEfuoVumvFtAWXIbrX9Dc
 OhF+Iai4rhX+bMYhmhQyrCRTMuXSsvZjPp3BD7tuD8ZrNQDcrOeV+QXDKVgQB49pjQr+TO
 l0rQL8KkO9HT6UAGv0ExwfbqO4/8b/E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-mJ3SFCKONLqOlWzOyMHl_w-1; Tue, 14 Jul 2020 18:21:36 -0400
X-MC-Unique: mJ3SFCKONLqOlWzOyMHl_w-1
Received: by mail-wm1-f69.google.com with SMTP id e15so88773wme.8
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 15:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=omtkizb4M/amnWnpKjXrvbTRB/FuvzwoZzcd22eJfwk=;
 b=Ro9hOWoDVA81yC6NtYsZfalcBOgcAW67p8CsefgHIZJ4OQcduA7yKKpdxJjNgRNauX
 iIXkAS09ndilaf3nnm3TVmF0K0AmYsDZ3ketxRuAOuIyLd5jaAhPgqL3mF6ae8X/A55a
 KFg3zzLQ6iXV2BJED8V3VzXy1gstfnSXVgi/RN4LnoCDip1WmhVqM4cly/KBfdNPPTb8
 Jk3mcjQHhTjcUNDk9HKeYhlrBn77I0zyY3XEjIkGS/8ttg7/hyJHM/Zq8K4xJPCb9RcH
 sFqqL21Ww0okZREJVhuFMit7CRUw1a+PRjT97loRSZp9seci/Yq0oVV95ovonfwnuztA
 WYgw==
X-Gm-Message-State: AOAM531NX/tSVDemItf70FxtA+A+lasXYYGnRq4i1ZSLPK+jtT4phgb+
 T+6c2UQdzSei8/cx+Qto0c5hangfSsGoh5nLYMHIB2ywkwvAPwOpMCxzvU4zDXkfO5vowY5DrEJ
 B6C3O3oKh9AGOdnM=
X-Received: by 2002:a05:600c:410f:: with SMTP id
 j15mr5681625wmi.128.1594765294512; 
 Tue, 14 Jul 2020 15:21:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXTIzgQIwENxEDAITkhXxUGtlaDAa8n8GIgh8MjCwOZy6kedx6VW+4KgFPdFFHuy5zLabx2Q==
X-Received: by 2002:a05:600c:410f:: with SMTP id
 j15mr5681614wmi.128.1594765294223; 
 Tue, 14 Jul 2020 15:21:34 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id c25sm237097wml.46.2020.07.14.15.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 15:21:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/19] Python patches for 5.1
Date: Wed, 15 Jul 2020 00:21:13 +0200
Message-Id: <20200714222132.10815-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 01:42:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 1a53dfee92284d3016a579ef31d53367e84d9dd8:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2020-07-13' into staging (2020-07-14 13:52:10 +0100)

are available in the Git repository at:

  https://gitlab.com/philmd/qemu.git tags/python-next-20200714

for you to fetch changes up to 84dcdf0887cdaaba7300442482c99e5064865a2d:

  python/qmp.py: add QMPProtocolError (2020-07-14 22:22:22 +0200)

----------------------------------------------------------------
Python patches for 5.1

- Reduce race conditions on QEMUMachine::shutdown()

 1. Remove the "bare except" pattern in the existing shutdown code,
    which can mask problems and make debugging difficult.
 2. Ensure that post-shutdown cleanup is always performed, even when
    graceful termination fails.
 3. Unify cleanup paths such that no matter how the VM is terminated,
    the same functions and steps are always taken to reset the object
    state.
 4. Rewrite shutdown() such that any error encountered when attempting
    a graceful shutdown will be raised as an AbnormalShutdown exception.
    The pythonic idiom is to allow the caller to decide if this is a
    problem or not.

- Modify part of the python/qemu library to comply with:

  . mypy --strict
  . pylint
  . flake8

- Script for the TCG Continuous Benchmarking project that uses
  callgrind to dissect QEMU execution into three main phases:

  . code generation
  . JIT execution
  . helpers execution

CI jobs results:
. https://cirrus-ci.com/build/5421349961203712
. https://gitlab.com/philmd/qemu/-/pipelines/166556001
. https://travis-ci.org/github/philmd/qemu/builds/708102347
----------------------------------------------------------------

Ahmed Karaman (1):
  scripts/performance: Add dissect.py script

John Snow (18):
  python/machine.py: consolidate _post_shutdown()
  python/machine.py: Close QMP socket in cleanup
  python/machine.py: Add _early_cleanup hook
  python/machine.py: Perform early cleanup for wait() calls, too
  python/machine.py: Prohibit multiple shutdown() calls
  python/machine.py: Add a configurable timeout to shutdown()
  python/machine.py: Make wait() call shutdown()
  tests/acceptance: wait() instead of shutdown() where appropriate
  tests/acceptance: Don't test reboot on cubieboard
  python/machine.py: split shutdown into hard and soft flavors
  python/machine.py: re-add sigkill warning suppression
  python/machine.py: change default wait timeout to 3 seconds
  python/qmp.py: Define common types
  iotests.py: use qemu.qmp type aliases
  python/qmp.py: re-absorb MonitorResponseError
  python/qmp.py: Do not return None from cmd_obj
  python/qmp.py: add casts to JSON deserialization
  python/qmp.py: add QMPProtocolError

 python/qemu/machine.py                   | 176 +++++++++++++++++------
 python/qemu/qmp.py                       |  67 +++++++--
 scripts/performance/dissect.py           | 166 +++++++++++++++++++++
 scripts/render_block_graph.py            |   7 +-
 tests/acceptance/boot_linux_console.py   |  14 +-
 tests/acceptance/linux_ssh_mips_malta.py |   2 +
 tests/qemu-iotests/iotests.py            |   9 +-
 7 files changed, 369 insertions(+), 72 deletions(-)
 create mode 100755 scripts/performance/dissect.py

-- 
2.21.3


