Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A848C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:40:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A4582074B
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BYGVmiRa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4582074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfR0O-0002Kt-JZ
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 12:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfQzD-0000lO-BB
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:38:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23526
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfQzB-0006dr-7e
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590943134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Cqps2Xy/wDwgHeQZtBDDKwWdymxWmUMf4khG6NEjU0s=;
 b=BYGVmiRaOznuTKgWAzaUi/N+rvV/HJj9JneDb++DVfHDn/XJYR7PDQNRq3UjJ+VfpmxqOl
 MhwU6WhVmSBx6p/8E0BCsjO7WDvnqpKyS+mMTDPfeIAcvW34IfQSuphirbOXaG7XIBvdFw
 ugmjBx9JhizzM8/on7WHvXkMtChf2Hk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-gV0PkRh0NxWINclhf0aDRA-1; Sun, 31 May 2020 12:38:51 -0400
X-MC-Unique: gV0PkRh0NxWINclhf0aDRA-1
Received: by mail-wr1-f69.google.com with SMTP id p10so3618867wrn.19
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 09:38:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Cqps2Xy/wDwgHeQZtBDDKwWdymxWmUMf4khG6NEjU0s=;
 b=DNKbqp3wUyMgTjxwIhnBa1pZGMjitfshEYDjaZ5izV+GGrOC4TWnXuvL76KasQh9k3
 OqaaOd4tzBPQkBCaPGAZ3XQzQJR9z5n5TmdJRXIBXpT+zyBQXWUFN4Eb26Z3xm4FY2CP
 w20jWBwVYa7zh0KtkYbPSN423uNvEhjjKu1bxe/fp66pHEPeN7UV323z+QNohJYmQD1K
 kvmcbjCehfu4hUGNq9A2vazhOylQnDjwisnP/MKIgRwvitOtLgjR+XlcNG4VvWaJBJ51
 odJH5/CR5/pTZ+v7hBnyz42ImTYSOjs+SUf/E/d25M+4StqeUAiw+qMsSKWCAeQU/Dq1
 jo6g==
X-Gm-Message-State: AOAM531Xeu3L0lFzHEcbpp87elaeZhIqEHhRFTsdjrKv3LQEYrZ0bJ7a
 bSfsg73BLGqxq9hscLae6UfTLC66pW0Hu2sVx8NLVxIMPfNWzhQdiFG7mS8jYhj8Sn1KWg/8qGY
 pRNSwrbixNHcT3Ss=
X-Received: by 2002:a1c:e914:: with SMTP id q20mr3019038wmc.145.1590943129756; 
 Sun, 31 May 2020 09:38:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyD/VAdm6bALQItTxdHOkN9cmdqlhgWpmq4GftYVKQFfyiuufz0LwlGo+Qn5wNF96G2siY3sg==
X-Received: by 2002:a1c:e914:: with SMTP id q20mr3019016wmc.145.1590943129519; 
 Sun, 31 May 2020 09:38:49 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id 5sm8192953wmd.19.2020.05.31.09.38.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 09:38:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/25] python-next patches for 2020-05-31
Date: Sun, 31 May 2020 18:38:21 +0200
Message-Id: <20200531163846.25363-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 11:09:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit c86274bc2e34295764fb44c2aef3cf29623f9b4b:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-tcg-plugins=
-270520-1' into staging (2020-05-29 17:41:45 +0100)

are available in the Git repository at:

  https://gitlab.com/philmd/qemu.git tags/python-next-20200531

for you to fetch changes up to 1c80c87c8c2489e4318c93c844aa29bc1d014146:

  tests/acceptance: refactor boot_linux to allow code reuse (2020-05-31 18:25=
:31 +0200)

----------------------------------------------------------------
Python queue:

* migration acceptance test fix
* introduce pylintrc & flake8 config
* various cleanups (Python3, style)
* vm-test can set QEMU_LOCAL=3D1 to use locally built binaries
* refactored BootLinuxBase & LinuxKernelTest acceptance classes

https://gitlab.com/philmd/qemu/pipelines/151323210
https://travis-ci.org/github/philmd/qemu/builds/693157969

----------------------------------------------------------------

Dr. David Alan Gilbert (1):
  tests/acceptance/migration.py: Wait for both sides

John Snow (11):
  scripts/qmp: Fix shebang and imports
  python: remove more instances of sys.version_info
  python/qemu/machine: remove logging configuration
  python/qemu: delint and add pylintrc
  python/qemu: delint; add flake8 config
  python/qemu: remove Python2 style super() calls
  python/qemu: fix socket.makefile() typing
  python/qemu: Adjust traceback typing
  python/qemu/qmp: use True/False for non/blocking modes
  python/qemu/qmp: assert sockfile is not None
  python/qemu/qtest: Check before accessing _qtest

Pavel Dovgaluk (3):
  tests/acceptance: allow console interaction with specific VMs
  tests/acceptance: refactor boot_linux_console test to allow code reuse
  tests/acceptance: refactor boot_linux to allow code reuse

Philippe Mathieu-Daud=C3=A9 (6):
  scripts/qemugdb: Remove shebang header
  scripts/qemu-gdb: Use Python 3 interpreter
  scripts/qmp: Use Python 3 interpreter
  scripts/kvm/vmxcap: Use Python 3 interpreter and add pseudo-main()
  scripts/modules/module_block: Use Python 3 interpreter & add
    pseudo-main
  tests/migration/guestperf: Use Python 3 interpreter

Robert Foley (3):
  tests/vm: Pass --debug through for vm-boot-ssh
  tests/vm: Add ability to select QEMU from current build
  tests/vm: allow wait_ssh() to specify command

Vladimir Sementsov-Ogievskiy (1):
  python/qemu/machine: add kill() method

 python/qemu/.flake8                       |  2 +
 python/qemu/accel.py                      |  9 ++-
 python/qemu/machine.py                    | 44 +++++++-----
 python/qemu/pylintrc                      | 58 ++++++++++++++++
 python/qemu/qmp.py                        | 29 +++++---
 python/qemu/qtest.py                      | 83 +++++++++++++++--------
 scripts/analyze-migration.py              |  5 --
 scripts/decodetree.py                     | 25 +++----
 scripts/kvm/vmxcap                        |  7 +-
 scripts/modules/module_block.py           | 29 ++++----
 scripts/qemu-gdb.py                       |  4 +-
 scripts/qemugdb/__init__.py               |  3 +-
 scripts/qemugdb/aio.py                    |  3 +-
 scripts/qemugdb/coroutine.py              |  3 +-
 scripts/qemugdb/mtree.py                  |  4 +-
 scripts/qemugdb/tcg.py                    |  1 -
 scripts/qemugdb/timers.py                 |  1 -
 scripts/qmp/qmp                           |  4 +-
 scripts/qmp/qmp-shell                     |  3 -
 scripts/qmp/qom-fuse                      |  4 +-
 scripts/qmp/qom-get                       |  6 +-
 scripts/qmp/qom-list                      |  6 +-
 scripts/qmp/qom-set                       |  6 +-
 scripts/qmp/qom-tree                      |  6 +-
 tests/acceptance/avocado_qemu/__init__.py | 13 ++--
 tests/acceptance/boot_linux.py            | 49 +++++++------
 tests/acceptance/boot_linux_console.py    | 21 +++---
 tests/acceptance/migration.py             |  4 ++
 tests/docker/docker.py                    |  5 +-
 tests/migration/guestperf-batch.py        |  2 +-
 tests/migration/guestperf-plot.py         |  2 +-
 tests/migration/guestperf.py              |  2 +-
 tests/qemu-iotests/nbd-fault-injector.py  |  5 +-
 tests/vm/Makefile.include                 |  5 ++
 tests/vm/basevm.py                        | 42 ++++++++----
 35 files changed, 317 insertions(+), 178 deletions(-)
 create mode 100644 python/qemu/.flake8
 create mode 100644 python/qemu/pylintrc

--=20
2.21.3


