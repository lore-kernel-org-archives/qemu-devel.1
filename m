Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A1CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 20:20:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0028220760
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 20:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uVPt0TTD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0028220760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrSAU-0001Gl-8R
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 16:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrS9V-0007md-Kb; Fri, 03 Jul 2020 16:19:17 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:41104)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrS9U-0001U2-4j; Fri, 03 Jul 2020 16:19:17 -0400
Received: by mail-wr1-x429.google.com with SMTP id z15so22662477wrl.8;
 Fri, 03 Jul 2020 13:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8+gjIh3aqsjiQ5qFFxXfcFeIU3jnTNHGJqIGbb9HtPY=;
 b=uVPt0TTDuGVy1oaT9fhJMnoi4pjX82ByvA9qh1YFlu/FtrluFKwQtFWtfB0Em8JYzw
 VSUsP/GZ7XfNtEwt+ODdVghpYzKjmhM+KDP7/JYEf8aQgfKmCQFU2+8VrnO6xvlm0n3F
 g/kdaj72nZd5a9DnG/b0yQpwOCcb9IUpZucTxEk0wquBZIb2tNp6XdC2nX3xR8JgDk8G
 uu0c1+0pC1quISQye6M1i/PLCi9/1Mvm0cuGKE5xcgOv+39AuLdGQriVgIpTVL3Fd/s0
 LQUVdRZxVazdm6i6NXpUXHRI0i6ehHK19yznAuCcKak76DX/xHRc3vqkgfr6a1F7pF+1
 cozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=8+gjIh3aqsjiQ5qFFxXfcFeIU3jnTNHGJqIGbb9HtPY=;
 b=Kmp6ip2oY5WTs33nn2f/m0x5TjobsRHnQw2bjeJ9xPkPKycwF+3LmHJMClRgSzy9ut
 vN9G/zTfZD8LRsvDfyCA61LQsU9qCLKZCciLPoc7yGJrVzt4cK2WzqJQsj47XN5eVw5j
 +0k/xBKm2W17BYiszV6rD2kcq30SRLm7qK0pPWJ07ayyhu2WOo9YyHEArfLUQiHihY3Q
 4yXmvfDQfL6M1a7iw4/e14GJsAWiqwfG7R8d/sRdLqR/UI73gldr7qtS9ZAgI7UUSRRj
 ABP5SexQXcI2fMBkf65E4B3yl3mEd+CHh60rXAYBxf+227L10a1/+o1qCNkxmYNcm/0a
 +tpg==
X-Gm-Message-State: AOAM533Bz5lvtnXPmX2Em2OGkn6gF4Bg2QvASXZHW9V1CI9r+LKZujl1
 K/f4ArbiMsrmY8+HBriregMOFdnBabo=
X-Google-Smtp-Source: ABdhPJzEqfacXfz+IGrHORUgbNLoBbwMCQ+pbOgYPPlAdEEukPr15cvv91y2kLUPlu62JQdZ1OSRVQ==
X-Received: by 2002:adf:eecf:: with SMTP id a15mr38485813wrp.83.1593807553269; 
 Fri, 03 Jul 2020 13:19:13 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id u65sm14229625wmg.5.2020.07.03.13.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 13:19:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 00/18] hw: Mark the device with no migratable fields
Date: Fri,  3 Jul 2020 22:18:53 +0200
Message-Id: <20200703201911.26573-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a proof-of-concept after chatting with Peter Maydell
on IRC earlier.

Introduce the vmstate_no_state_to_migrate structure, and
a reference to it: vmstate_qdev_no_state_to_migrate.
Use this reference in devices with no fields to migrate.

This is useful to catch devices missing vmstate, such:
- ads7846
- mcf-uart
- mcf-fec
- versatile_i2c
- ...

I am not sure about:
- gpex-pcihost

Philippe Mathieu-Daudé (18):
  migration/vmstate: Document vmstate_dummy
  migration/vmstate: Introduce vmstate_no_state_to_migrate
  hw/core/qdev: Add vmstate_qdev_no_state_to_migrate
  hw/arm/armv7m: Mark the device with no migratable fields
  hw/arm/aspeed_soc: Mark the device with no migratable fields
  hw/arm/bcm283x: Mark devices with no migratable fields
  hw/arm/msf2-soc: Mark the device with no migratable fields
  hw/core/split-irq: Mark the device with no migratable fields
  hw/cpu/a9mpcore: Mark the device with no migratable fields
  hw/cpu/cluster: Mark the device with no migratable fields
  hw/usb/hcd-ohci: Mark the device with no migratable fields
  hw/intc/arm_gicv2m: Mark the device with no migratable fields
  hw/misc/armsse-cpuid: Mark the device with no migratable fields
  hw/misc/iotkit-sysinfo: Mark the device with no migratable fields
  hw/misc/unimp: Mark the device with no migratable fields
  hw/nubus/mac-nubus-bridge: Mark the device with no migratable fields
  hw/sparc64/sun4u: Mark devices with no migratable fields
  hw/core/qdev: Display warning for devices missing migration state

 configure                    |  9 +++++++++
 hw/usb/hcd-ohci.h            |  2 ++
 include/hw/arm/bcm2836.h     |  7 ++++---
 include/hw/arm/msf2-soc.h    | 11 ++++++-----
 include/hw/cpu/a9mpcore.h    |  3 ++-
 include/hw/qdev-core.h       |  2 ++
 include/migration/vmstate.h  |  3 ++-
 hw/arm/armv7m.c              |  1 +
 hw/arm/aspeed_soc.c          |  1 +
 hw/arm/bcm2835_peripherals.c |  1 +
 hw/arm/bcm2836.c             |  1 +
 hw/arm/msf2-soc.c            |  1 +
 hw/core/qdev.c               |  8 ++++++++
 hw/core/split-irq.c          |  1 +
 hw/cpu/a9mpcore.c            |  1 +
 hw/cpu/cluster.c             |  1 +
 hw/intc/arm_gicv2m.c         |  2 ++
 hw/misc/armsse-cpuid.c       |  1 +
 hw/misc/iotkit-sysinfo.c     |  1 +
 hw/misc/unimp.c              |  1 +
 hw/nubus/mac-nubus-bridge.c  |  1 +
 hw/sparc64/sun4u.c           |  7 ++++++-
 hw/usb/hcd-ohci.c            |  1 +
 migration/vmstate.c          |  7 +++++++
 24 files changed, 63 insertions(+), 11 deletions(-)

-- 
2.21.3


