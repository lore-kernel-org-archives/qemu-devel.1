Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70849C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:42:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4292621655
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MD+YroMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4292621655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpsFY-00046N-3L
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 06:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39673)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hpsF4-0002PH-1m
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:41:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hpsF1-0004CX-R6
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:41:57 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:47022)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hpsEz-00048f-Nw
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:41:55 -0400
Received: by mail-wr1-x434.google.com with SMTP id z1so42591809wru.13
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 03:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GDOlQg2avM3U9x1HQrrYCutc2wv4Hz+Sy22dYaJ+OrY=;
 b=MD+YroMoTvLg413MMnloRkdiOW2Sh/wBORPDJu3ueOvdzpvgPV10qrp1dhHKYTIgaN
 Wog4FjNH2GFM9jy/y9se/fqQxqaLQldQOJ5jhwZAqX6WkEpl8R3LFbGHShRK+7MNxmel
 pRWNACFV2nVxyhObSjZOKejg7kCrLa0ii+W67iwJ6OFWsJJqExIZNaDj9TKzO4iOXEcf
 zcT38xSDU4ASwrc95sg2Fh4m5M5Wz3zElr/94YEZhiry6Sg+0u/CB/VJW3m58lxXr76j
 3T704B5su5rZay/fI1M4KoI8BKWRm0/ncZACGo3TB+etrn1XhKenadh5u/VZFTh89jPV
 a5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GDOlQg2avM3U9x1HQrrYCutc2wv4Hz+Sy22dYaJ+OrY=;
 b=i/strnuMhwI1VtiWdHOar/zcaxqy9GnYx5j6DiSQFR6lGlmWPBUhDFYvLOsp3EeL+m
 QAANNvTIwbt/1Lxd91JDLdjfTfJsddo45T+UvgnId6ulk/pJL8gR1Ik8p06f8BErvVcC
 vFLjB55w+opPNe6MsqcUA0iuTOEfjfDAO/919ENkKR+qJLlh2xUy+UUpIJsqAovC3HGO
 57Rk/sB1/TCNScPFtM6TKXu/neFzv92/CbNi+8D1xzUzo33A2a8sdC8ezDcgPWaWVT1J
 o/Qi31jPMBJP9Fl5I0YbRT96KKju2g1bwrFVG57Av/884lvpWkuZLlYCH6ya1AtIHwZL
 uwjg==
X-Gm-Message-State: APjAAAXkwILygRBRAGUAYSexuMZGsRitSqSvTL9JBiEOWAA9THn0RbEB
 GBneAO2JgKe+dAS91Bf+6n1wbw==
X-Google-Smtp-Source: APXvYqwvi0jeF9N0DD+EKB+s3+9ey2WoKc/wG4cooLerMIcKS0Fvk+A8DAkB5O1uRpIAkcj9beFycA==
X-Received: by 2002:a5d:4211:: with SMTP id n17mr11293292wrq.137.1563878510848; 
 Tue, 23 Jul 2019 03:41:50 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id n5sm34368758wmi.21.2019.07.23.03.41.48
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 03:41:48 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9B2C11FF8C;
 Tue, 23 Jul 2019 11:36:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 23 Jul 2019 11:36:03 +0100
Message-Id: <20190723103612.5600-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190723103612.5600-1-alex.bennee@linaro.org>
References: <20190723103612.5600-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
Subject: [Qemu-devel] [PULL 14/23] buildsys: The NSIS Windows build requires
 qemu-nsis.bmp installed
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The qemu-nsis.bmp file was not listed with the other blobs, thus
not installed in the ${BINDIR} location.

This fixes:

  $ make installer
  [...]
  (cd /tmp/qemu-nsis; \
           for i in qemu-system-*.exe; do \
             arch=${i%.exe}; \
             arch=${arch#qemu-system-}; \
             echo Section \"$arch\" Section_$arch; \
             echo SetOutPath \"\$INSTDIR\"; \
             echo File \"\${BINDIR}\\$i\"; \
             echo SectionEnd; \
           done \
          ) >/tmp/qemu-nsis/system-emulations.nsh
  makensis -V2 -NOCD \
                  -DCONFIG_DOCUMENTATION="y" \
                   \
                  -DBINDIR="/tmp/qemu-nsis" \
                   \
                  -DSRCDIR="/home/phil/source/qemu" \
                  -DOUTFILE="qemu-setup-4.0.90.exe" \
                  -DDISPLAYVERSION="4.0.90" \
                  /home/phil/source/qemu/qemu.nsi
  File: "/tmp/qemu-nsis\*.bmp" -> no files found.
  Usage: File [/nonfatal] [/a] ([/r] [/x filespec [...]] filespec [...] |
     /oname=outfile one_file_only)
  Error in script "/home/phil/source/qemu/qemu.nsi" on line 122 -- aborting creation process
  Makefile:1077: recipe for target 'qemu-setup-4.0.90.exe' failed
  make: *** [qemu-setup-4.0.90.exe] Error 1

Fixes: https://bugs.launchpad.net/bugs/1836453
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190715174817.18981-8-philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/Makefile b/Makefile
index b3357691cad..cfab1561b9c 100644
--- a/Makefile
+++ b/Makefile
@@ -761,6 +761,7 @@ pxe-pcnet.rom pxe-rtl8139.rom pxe-virtio.rom \
 efi-e1000.rom efi-eepro100.rom efi-ne2k_pci.rom \
 efi-pcnet.rom efi-rtl8139.rom efi-virtio.rom \
 efi-e1000e.rom efi-vmxnet3.rom \
+qemu-nsis.bmp \
 bamboo.dtb canyonlands.dtb petalogix-s3adsp1800.dtb petalogix-ml605.dtb \
 multiboot.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin pvh.bin \
 s390-ccw.img s390-netboot.img \
-- 
2.20.1


