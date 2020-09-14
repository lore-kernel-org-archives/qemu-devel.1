Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB29C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:18:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDE9721548
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LkkUH0t0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE9721548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHil1-0000eA-Py
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 03:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHik1-0007Xw-Be
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 03:17:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50282)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHijy-000217-HV
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 03:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600067849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JZdohivG8OwPaekS7kZwOMGmQnOEdRQq9UPoCkczNfM=;
 b=LkkUH0t0o1pQv3MO05ZnpCdhtZkSXX2+D7sw66HRLfFhEXfWGN+bGUUxSvasK/TPS5oZHH
 0nAgSykcLiHqfz3uZsp6WAeVWE/lgkl7qXS46Yzgz6qVL4VUO7xbNgMMnPOLRHAFrD0PHc
 kYlE9IOdyH7WRVuJSdIhdzL6Mxfkmhk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-BC9tfZD4P-GU1oZ8ZbgjHw-1; Mon, 14 Sep 2020 03:17:24 -0400
X-MC-Unique: BC9tfZD4P-GU1oZ8ZbgjHw-1
Received: by mail-wm1-f71.google.com with SMTP id b14so2898997wmj.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 00:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JZdohivG8OwPaekS7kZwOMGmQnOEdRQq9UPoCkczNfM=;
 b=T8fiNSZLgsmAL+yZ9wmX6DjPuqXVtrROaCM3SFhIDAxgJPuWyo+qurgUlgecDvl/+B
 kYq07P7WU9VA0vFQX14W2KnIRugDWUKOZrYjzEpKGWMl6AXqn0xiiIcbhA4MsT1O2C8a
 8fxkilJNr7JZtq/r1XwoZbVn767mZFGRwsiGKIGXXM/9tEWh1DATwhxaNP+4s/nm0HG9
 EhUp49NuZQ7/WZuoDk5tZv2bp5m4R4OfVsTNd8o6/LE++acYUZipmSk/1DTBz+01cI86
 175fk9aml4aq+SEwoZF3Y0k6tUFp6+rKJkfeaE5PHMdvm8rPQA4KI0Gi+ZmzTCSt/UNv
 VFuA==
X-Gm-Message-State: AOAM533ZmzILwEZ1dQJ0pTRu3Lm5xfe5rCEnc0XBjs6ZFjYlERov3qLf
 c3czLkVTkqP8pFvo/qRPGriEbHyRbESueclwtCCs+EW3xMWJkh74lJzDRqHWMMPFiFgpbLB83fn
 nxoy7t0e5dDhx0qU=
X-Received: by 2002:adf:ef45:: with SMTP id c5mr13887811wrp.37.1600067842616; 
 Mon, 14 Sep 2020 00:17:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFpQuiVCqi9PXUzY1WA59wm7FBhBivers5jKIDr5YCRZ9muz3ZP60tS7fHI64vFOL/8PA1yg==
X-Received: by 2002:adf:ef45:: with SMTP id c5mr13887785wrp.37.1600067842376; 
 Mon, 14 Sep 2020 00:17:22 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id v9sm22640343wrv.35.2020.09.14.00.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 00:17:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/10] EDK2 firmware: Adopt the edk2-stable202008 release
Date: Mon, 14 Sep 2020 09:17:10 +0200
Message-Id: <20200914071720.1099898-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:10:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 3d9f371b01067d9cec4d592920013012119397c8:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-fixes-100920-1' into staging (2020-09-12 22:54:32 +0100)

are available in the Git repository at:

  https://gitlab.com/philmd/qemu.git tags/edk2-next-20200914

for you to fetch changes up to 8fa3b7029f3c9f901cd6bb01004114c003432d9b:

  tests: acpi: update "virt/SSDT.memhp" for edk2-stable202008 (2020-09-13 23:03:15 +0200)

----------------------------------------------------------------
EDK2 firmware: Adopt the edk2-stable202008 release

Note from Laszlo Ersek [1] while addressing LP#1852196 [2]:

Consume the following upstream edk2 releases:

  https://github.com/tianocore/edk2/releases/tag/edk2-stable201908
  https://github.com/tianocore/edk2/releases/tag/edk2-stable201911
  https://github.com/tianocore/edk2/releases/tag/edk2-stable202002
  https://github.com/tianocore/edk2/releases/tag/edk2-stable202005
  https://github.com/tianocore/edk2/releases/tag/edk2-stable202008

Worth mentioning (in random order):

- various CVE fixes (see [2] and shortlog)
- OpenSSL-1.1.1g
- UEFI HTTPS Boot for ARM/AARCH64
- TPM2 for ARM/AARCH64
- VCPU hotplug with SMI
- support for Linux v5.7+ initrd and mixed mode loading
- Fusion-MPT SCSI driver in OVMF
- VMware PVSCSI driver in OVMF
- PXEv4 / PXEv6 boot possible to disable on the QEMU command line
- SEV-ES support

The IA32 and X64 binaries are now smaller -- the reason is that Laszlo
built them with DevToolSet 9 (gcc-9) on RHEL7, and so this is the first
time they've undergone LTO (with the GCC5 edk2 toolchain settings).

CI jobs results:
  https://gitlab.com/philmd/qemu/-/pipelines/189394120
  https://travis-ci.org/github/philmd/qemu/builds/726842542
  https://app.shippable.com/github/philmd/qemu/runs/866/summary/console

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg738173.html
[2] https://bugs.launchpad.net/qemu/+bug/1852196

----------------------------------------------------------------

Laszlo Ersek (10):
  Makefile: remove obsolete edk2 exception from "clean" rule
  roms/efirom, tests/uefi-test-tools: update edk2's own submodules first
  roms/Makefile.edk2: prepare for replacing TPM2*_ENABLE macros
  tests: acpi: tolerate "virt/SSDT.memhp" mismatch temporarily
  roms/edk2: update submodule from edk2-stable201905 to
    edk2-stable202008
  roms/Makefile.edk2: complete replacing TPM2*_ENABLE macros
  roms/Makefile.edk2: enable new ARM/AARCH64 flags up to
    edk2-stable202008
  pc-bios: refresh edk2 build artifacts for edk2-stable202008
  pc-bios: update the README file with edk2-stable202008 information
  tests: acpi: update "virt/SSDT.memhp" for edk2-stable202008

 Makefile                               |   1 -
 pc-bios/README                         |   4 ++--
 pc-bios/edk2-aarch64-code.fd.bz2       | Bin 1178070 -> 1507722 bytes
 pc-bios/edk2-arm-code.fd.bz2           | Bin 1172752 -> 1503187 bytes
 pc-bios/edk2-i386-code.fd.bz2          | Bin 1736199 -> 1646741 bytes
 pc-bios/edk2-i386-secure-code.fd.bz2   | Bin 1943949 -> 1860546 bytes
 pc-bios/edk2-x86_64-code.fd.bz2        | Bin 1717094 -> 1680164 bytes
 pc-bios/edk2-x86_64-secure-code.fd.bz2 | Bin 1958037 -> 1912112 bytes
 roms/Makefile                          |   1 +
 roms/Makefile.edk2                     |  26 +++++++++++++++----------
 roms/edk2                              |   2 +-
 tests/data/acpi/virt/SSDT.memhp        | Bin 736 -> 736 bytes
 tests/uefi-test-tools/Makefile         |   1 +
 13 files changed, 21 insertions(+), 14 deletions(-)

-- 
2.26.2


