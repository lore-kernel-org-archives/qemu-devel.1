Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493F3C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:52:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 937F1206C9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZyp4tmZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 937F1206C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNfLJ-0008BP-7O
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 12:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNfIn-0006Ay-IN
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 12:50:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32285)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNfIk-00071c-Kc
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 12:50:01 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601484597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=b1HyB2KK3+Hgk5NDh7O4u9fRV2lqO+HMfFVi9/M3yBY=;
 b=fZyp4tmZmna/NzsKUT/o1ZvV/P903Q3vCJFfD+7zbMSTXP9/lDE0BhKWd0aAkoxwGrUo70
 T1g82z1b8CHXZ8H3FDtUFl03eJ72YMae+NpzlfzsHiIRSJK4952zpYSKJhW8GX5IKSCjG+
 so55snygVt58i4sU7YgUiyQ+9lPdqnE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-Pj7kFtaUPlygClNRYd-Leg-1; Wed, 30 Sep 2020 12:49:53 -0400
X-MC-Unique: Pj7kFtaUPlygClNRYd-Leg-1
Received: by mail-wr1-f72.google.com with SMTP id l17so818448wrw.11
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 09:49:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=b1HyB2KK3+Hgk5NDh7O4u9fRV2lqO+HMfFVi9/M3yBY=;
 b=p+e5uGJUHfFwZfKUx6oPunD1jBOno+RnEfoeVnCj/kgQJGQF+C4B0kdYMA45wzSali
 OwngFRbQkwF4/a2d7/frIW3jy8ooyGpoplMWDHGms7k/CdLug/J/8kQBhXov25OnkDgr
 G4ugPapvCuWSfyDIcwzcoYX28WiIiOCcsjRGBijl49iE4M0EEqgRX5gPNtRuHevAhhZ7
 6HKHndFR5OjQbrCgAFwfwLyFf4s5Y8QmXgJy8d90VVoQ9VJ21th05nfSYqi7BS/zIZTo
 0wLqIUCNXcIoJTrg/xjCzpHqn2avKDOL6fA6VBtRqUWKdX+wk3wipnGk4AdgT3DIIgvm
 8ztg==
X-Gm-Message-State: AOAM533sgj7g2WvYEdk/jD1Purk0qA+5ZQ1uB8qVG9ILoHGEpwHCu1Fi
 wQI12WYSHrgfuHaKhOvB9vhtyBkisXlcTE5s6PsAMqcXN6tAD0x5pxl+MURqJgy3Z9AIAH4liS6
 /EEYxejXt+igxvtI=
X-Received: by 2002:a1c:9ec1:: with SMTP id h184mr4077157wme.180.1601484591678; 
 Wed, 30 Sep 2020 09:49:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJws4yXiBftNY1MotbrdEqlY4y1OKFoU70TCqYv7Mh9NBUhzDqqTfTT4xW/l57v6ogm2AjWMFg==
X-Received: by 2002:a1c:9ec1:: with SMTP id h184mr4077125wme.180.1601484591473; 
 Wed, 30 Sep 2020 09:49:51 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id g8sm3650302wmd.12.2020.09.30.09.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 09:49:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 00/11] user-mode: Prune build dependencies (part 3)
Date: Wed, 30 Sep 2020 18:49:38 +0200
Message-Id: <20200930164949.1425294-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Peter Lieven <pl@kamp.de>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the third part of a series reducing user-mode
dependencies. By stripping out unused code, the build
and testing time is reduced (as is space used by objects).

Part 3:
- Extract code not related to user-mode from hw/core/qdev-properties.c
- Reduce user-mode QAPI generated files

Since v2:
- Fixed UuidInfo placed in incorrect json
- Rebased on Meson
- Include X86CPUFeatureWord unmerged from part 2

Since v1:
- Addressed Richard and Paolo review comments

Patches missing review: QAPI ones :)
- #1  'qapi: Restrict query-uuid command to block code'
- #11 'qapi: Restrict code generated for user-mode'

Green CI: https://gitlab.com/philmd/qemu/-/pipelines/196505787

v2: https://www.mail-archive.com/qemu-devel@nongnu.org/msg688879.html
v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg688486.html

Philippe Mathieu-Daudé (11):
  qapi: Restrict query-uuid command to block code
  hw/core/qdev-properties: Use qemu_strtol() in set_mac() handler
  hw/core/qdev-properties: Use qemu_strtoul() in set_pci_host_devaddr()
  hw/core/qdev-properties: Fix code style
  hw/core/qdev-properties: Export enum-related functions
  hw/core/qdev-properties: Export qdev_prop_enum
  hw/core/qdev-properties: Export some integer-related functions
  hw/core/qdev-properties: Extract system-mode specific properties
  hw/core: Add qdev stub for user-mode
  target/i386: Restrict X86CPUFeatureWord to X86 targets
  qapi: Restrict code generated for user-mode

 qapi/block.json                  |  30 ++
 qapi/machine-target.json         |  45 ++
 qapi/machine.json                |  72 ---
 hw/core/qdev-prop-internal.h     |  30 ++
 include/hw/qdev-properties.h     |   1 +
 block/iscsi.c                    |   2 +-
 hw/core/qdev-properties-system.c | 687 ++++++++++++++++++++++++++++-
 hw/core/qdev-properties.c        | 735 ++-----------------------------
 stubs/qdev-system.c              |  24 +
 stubs/uuid.c                     |   2 +-
 target/i386/cpu.c                |   2 +-
 target/i386/feature-stub.c       |  23 +
 qapi/meson.build                 |  51 ++-
 stubs/meson.build                |   5 +-
 target/i386/meson.build          |   1 +
 15 files changed, 915 insertions(+), 795 deletions(-)
 create mode 100644 hw/core/qdev-prop-internal.h
 create mode 100644 stubs/qdev-system.c
 create mode 100644 target/i386/feature-stub.c

-- 
2.26.2


