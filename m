Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2211C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:29:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 704AF20409
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Osl14Dfy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 704AF20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtY8-0003z4-Ll
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDsGL-00041E-5G
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:06:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDsGJ-00062u-Jb
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:06:45 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:46208)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDsGJ-00060C-GF
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584374803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3mVXcxmK2HMmKZLt5GH7gLyONl4hlaRDhaSU8yeP/yU=;
 b=Osl14Dfy1u9+1eQH+2C37vwny3Vdf7rBehmebyc5fNRlJdz3PTGg6mlz+CdXhocz1BFyM9
 aRF5B1uXQUMpvxyFN4fN+T8bePRts1zuRAb4AciT0Jfi5LrwBn15xWkTDxV2ge7rJDRpU7
 9dUU3YdQ20Eh/JmGeF+yNXJGu2dE/FU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-Nv3wdlnGNTqNkaTwSMFfbw-1; Mon, 16 Mar 2020 12:06:39 -0400
X-MC-Unique: Nv3wdlnGNTqNkaTwSMFfbw-1
Received: by mail-wr1-f69.google.com with SMTP id 94so4575995wrr.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 09:06:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=P5yP2gI3jZwVa/ROqUBqAiUPezN5j8lwPUWA/Pi42tY=;
 b=MXfE/buU5aAEwpBqL8god2TLiiH6PWCgWa4h3vhqaYu4ds8pZHO0ODVbue6VA9gvUz
 nKvqekw/yGu9gJUTeBASWzn3KpmX6CQYzQ3tkPKUtbsHPk1m16VklHM7nylsVYPomTcv
 4xEXqNylhFi7D0Uot6M2StM1iZmP9phlsxhlSF3i34F4B1wtQEGTiT7s6lLWH4ZV+GUh
 /ryc7vD5YsZKFb2fS6CWqCmSruBxwLZOyNJhtLP7o3SAH66T50z4hT0UX7SDPf5dIwZG
 H86u9nN+AEsIsNm6DncfxT/Lgx8QZL4lemuWXjevZ1sthdUVi2AeK+Bky3m4+y+eIbv4
 xi0A==
X-Gm-Message-State: ANhLgQ1hd8rPMsh5M8gnZD5Kw2ALH3yJEuaoqxzxccbAPB2swl0Lgyw8
 yfX23h8chtmTpElAdkgDGtroboDOr6Nt8GfQTQfX29VnH1ko3Vwkpex2OtBKUEerd1AkNSAk1nY
 BUFGV6RhCWiFmgxs=
X-Received: by 2002:adf:a343:: with SMTP id d3mr105748wrb.50.1584374797770;
 Mon, 16 Mar 2020 09:06:37 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt2iuZ7H3FhJLGjMjjY+SMihUpUN452/lUvxyCtpgGQsOh0snwxYqeNt3N03YZvD05ipB9yBA==
X-Received: by 2002:adf:a343:: with SMTP id d3mr105710wrb.50.1584374797395;
 Mon, 16 Mar 2020 09:06:37 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id s7sm478457wri.61.2020.03.16.09.06.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 09:06:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/19] Support disabling TCG on ARM (part 2)
Date: Mon, 16 Mar 2020 17:06:15 +0100
Message-Id: <20200316160634.3386-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cover from Samuel Ortiz from (part 1) [1]:

  This patchset allows for building and running ARM targets with TCG
  disabled. [...]

  The rationale behind this work comes from the NEMU project where we're
  trying to only support x86 and ARM 64-bit architectures, without
  including the TCG code base. We can only do so if we can build and run
  ARM binaries with TCG disabled.

v3 almost 18 months later:
- Rebased
- Addressed Thomas review comments
- Added Travis-CI job to keep building --disable-tcg on ARM

v2 [2]:
- Addressed review comments from Richard and Thomas from v1 [3]

Regards,

Phil.

[1]: https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg02451.html
[2]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg641796.html
[3]: https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg05003.html

Based-on: <20200316120049.11225-1-philmd@redhat.com>
"accel: Allow targets to use Kconfig, disable semihosting by default"
https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg04653.html

Philippe Mathieu-Daud=C3=A9 (15):
  target/arm: Rename KVM set_feature() as kvm_set_feature()
  target/arm: Restrict DC-CVAP instruction to TCG accel
  target/arm: Restric the Address Translate operations to TCG accel
  target/arm: Restrict Virtualization Host Extensions instructions to
    TCG
  target/arm: Move Makefile variable restricted to CONFIG_TCG
  target/arm: Add semihosting stub to allow building without TCG
  target/arm: Move ARM_V7M Kconfig from hw/ to target/
  target/arm: Restrict ARMv4 cpus to TCG accel
  target/arm: Restrict ARMv5 cpus to TCG accel
  target/arm: Restrict ARMv6 cpus to TCG accel
  target/arm: Restrict ARMv7 R-profile cpus to TCG accel
  target/arm: Restrict ARMv7 M-profile cpus to TCG accel
  hw/arm: Automatically select the 'virt' machine on KVM
  hw/arm: Do not build to 'virt' machine on Xen
  .travis.yml: Add a KVM-only Aarch64 job

Samuel Ortiz (1):
  target/arm: Do not build TCG objects when TCG is off

Thomas Huth (3):
  target/arm: Make set_feature() available for other files
  target/arm: Make cpu_register() available for other files
  target/arm: Make m_helper.c optional via CONFIG_ARM_V7M

 default-configs/aarch64-softmmu.mak |   1 -
 default-configs/arm-softmmu.mak     |  30 --
 target/arm/cpu-qom.h                |   9 +-
 target/arm/cpu.h                    |   7 +
 target/arm/internals.h              |  10 +
 target/arm/arm-semi-stub.c          |  13 +
 target/arm/cpu.c                    | 651 +---------------------------
 target/arm/cpu64.c                  |  19 +-
 target/arm/cpu_v4.c                 |  65 +++
 target/arm/cpu_v5.c                 | 266 ++++++++++++
 target/arm/cpu_v6.c                 | 171 ++++++++
 target/arm/cpu_v7m.c                | 207 +++++++++
 target/arm/cpu_v7r.c                |  83 ++++
 target/arm/helper.c                 |  54 +--
 target/arm/kvm32.c                  |  10 +-
 target/arm/kvm64.c                  |  16 +-
 target/arm/m_helper-stub.c          |  59 +++
 .travis.yml                         |  32 ++
 hw/arm/Kconfig                      |  17 +-
 target/Kconfig                      |   2 +-
 target/arm/Kconfig                  |  19 +
 target/arm/Makefile.objs            |  17 +-
 22 files changed, 1016 insertions(+), 742 deletions(-)
 create mode 100644 target/arm/arm-semi-stub.c
 create mode 100644 target/arm/cpu_v4.c
 create mode 100644 target/arm/cpu_v5.c
 create mode 100644 target/arm/cpu_v6.c
 create mode 100644 target/arm/cpu_v7m.c
 create mode 100644 target/arm/cpu_v7r.c
 create mode 100644 target/arm/m_helper-stub.c
 create mode 100644 target/arm/Kconfig

--=20
2.21.1


