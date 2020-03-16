Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B75C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 13:50:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ED152051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 13:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jrnnz7Rw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED152051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDq8X-0001U6-TS
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 09:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48136)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDoQj-0004ix-Uw
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:01:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDoQh-00071J-3s
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:01:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60123
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDoQg-0006se-TL
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584360070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DLPiAX2bS0yJ/o6Ul6dOfCdkj+XchPfLfsZYZ76kWqI=;
 b=Jrnnz7RwjN7Cljsllrn4+KATYbs5cuX4r5pYmFI9vVFV7BPj9HUM0M2iruxfQ/fNt4187p
 K96rV9i34uj4sWficbT4X4LA5Vz2R1qg/YBuba3D74POWB1VsZw+HrO+NVnCGKufT9MtM2
 AYKFBKpdlKQpNZUgR4vc/TJoHtKxju8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-zOldhb79PAe5fglDSrZWFA-1; Mon, 16 Mar 2020 08:00:54 -0400
X-MC-Unique: zOldhb79PAe5fglDSrZWFA-1
Received: by mail-wr1-f69.google.com with SMTP id b11so8897857wru.21
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 05:00:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CYiiNY5eJKwC2YtizFQnNmy2IsEKnaPczaT0HOXDhMM=;
 b=XZt4mly+5R5mCHci82GK0wbTaHgcqrNWIrJBV32aLMY8P2Y/wencXvZdW6g/7MLsJL
 wGG3Ztsh9VgX8uw0EFC/2adieTGeyq9cwBQn/GNbehSHrNXhJ4j5GAT8EoYNBA0FaMkP
 d3m5PlPbV+CB2IV7Vl5tWhghuCZrixuleklbo7RyDgXzL+yZdgKTOe7hDbRT52MQtAL5
 eXigb4DMDiPHe4OmLpmFg3O2BpIEaH4xvXuKcxig3k0swW9wD4zPSl0gjxTJgNLb1ucZ
 NX/qQOnhuXtaEMthFRTpDr3Bt1wrFAvk3vJRJUCoUJE4UKaOwZckbpUqDyhYkBOfKhwW
 f6BQ==
X-Gm-Message-State: ANhLgQ3MVCtmi9yjWPO1aYmoFtrJWdi/pJ5s8p+pARBkWNSodHcPFo1a
 V5XC7Nvf2ByPkpt3V7W7G1Tz4Ye5SdhKWeY9Urzg9yLajCf3JFhSAS0gL/0plvTRVQzcdISqu0+
 h1ExNKISPEvss03Q=
X-Received: by 2002:a5d:698c:: with SMTP id g12mr28374178wru.382.1584360052964; 
 Mon, 16 Mar 2020 05:00:52 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vspzF8QpWLHfPSx+4HJMIVwNg8X8kuk0Sha2UbgfxXhHA6vjwfS7Jnd97G6wTztrPBogtRo1w==
X-Received: by 2002:a5d:698c:: with SMTP id g12mr28374137wru.382.1584360052682; 
 Mon, 16 Mar 2020 05:00:52 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id i12sm1591668wro.46.2020.03.16.05.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 05:00:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/11] accel: Allow targets to use Kconfig,
 disable semihosting by default
Date: Mon, 16 Mar 2020 13:00:38 +0100
Message-Id: <20200316120049.11225-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series include generic patches I took of the KVM/ARM
specific series which will follow.

- List orphan accelerators in MAINTAINERS
- Add accel/Kconfig
- Allow targets to use their how Kconfig
- Enforce semihosting on ARM/LM32/MIPS, disable it elsewhere

Previous RFC for semihosting posted earlier:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg631218.html

Philippe Mathieu-Daud=C3=A9 (11):
  MAINTAINERS: Fix KVM path expansion glob
  MAINTAINERS: Add an 'overall' entry for accelerators
  MAINTAINERS: Add an entry for the HAX accelerator
  MAINTAINERS: Add an entry for the HVF accelerator
  Makefile: Write MINIKCONF variables as one entry per line
  accel/Kconfig: Extract accel selectors into their own config
  accel/Kconfig: Add the TCG selector
  target/Kconfig: Allow targets to use Kconfig
  target/mips: Always enable CONFIG_SEMIHOSTING
  target/arm: Always enable CONFIG_SEMIHOSTING
  hw/semihosting: Make the feature depend of TCG, and allow to disable
    it

 Makefile                                      | 10 ++++++--
 default-configs/aarch64-linux-user-common.mak |  4 ++++
 default-configs/aarch64-linux-user.mak        |  2 ++
 default-configs/aarch64_be-linux-user.mak     |  2 ++
 default-configs/arm-linux-user-common.mak     |  4 ++++
 default-configs/arm-linux-user.mak            |  2 ++
 default-configs/arm-softmmu.mak               |  4 +++-
 default-configs/armeb-linux-user.mak          |  2 ++
 default-configs/mips-linux-user-common.mak    |  4 ++++
 default-configs/mips-linux-user.mak           |  2 ++
 default-configs/mips64-linux-user.mak         |  2 ++
 default-configs/mips64el-linux-user.mak       |  2 ++
 default-configs/mipsel-linux-user.mak         |  2 ++
 default-configs/mipsn32-linux-user.mak        |  2 ++
 default-configs/mipsn32el-linux-user.mak      |  2 ++
 Kconfig.host                                  |  7 ------
 MAINTAINERS                                   | 23 ++++++++++++++++++-
 accel/Kconfig                                 |  9 ++++++++
 hw/semihosting/Kconfig                        |  4 +++-
 target/Kconfig                                |  1 +
 20 files changed, 78 insertions(+), 12 deletions(-)
 create mode 100644 default-configs/aarch64-linux-user-common.mak
 create mode 100644 default-configs/arm-linux-user-common.mak
 create mode 100644 default-configs/mips-linux-user-common.mak
 create mode 100644 accel/Kconfig
 create mode 100644 target/Kconfig

--=20
2.21.1


