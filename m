Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16794C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:03:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4BED22453
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4jiROp4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4BED22453
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvLXK-0003po-3k
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 10:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvLRu-000438-RX; Tue, 14 Jul 2020 09:58:22 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41563)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvLRt-0003Qi-7M; Tue, 14 Jul 2020 09:58:22 -0400
Received: by mail-wr1-x444.google.com with SMTP id z15so21775498wrl.8;
 Tue, 14 Jul 2020 06:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1zbwVDvuZ7/26jlVLyPOL1ByHC3nT9XTQJpiModFvqA=;
 b=r4jiROp4BABhc85r21GW9xjQabF7Y8WY25Tqix/Cz42xHWqEOyRf9nqUYYu99t8118
 xeUSUqFimHskY2up063/92iSDjrzeTUNiALHlAOgTUaU2C3kaiZkpAR2xSGJ09hkH44J
 UC2xzjmMz5gRkOu1ow3GzAR3/YlU6TDNCK9tgDz0jZag6mkB6lGH0og76qvTOLVHRci+
 qpO2T3SP6lNB+P3e88P+DDtbGaOvknYoMI7bVTdErVoeL5tuebVqktYr/weplW2ctdBi
 aJZnLgq72jXL4hy3IXI40NTfI5+ySI6Eo2Hvpm5ASi9R5YDZ9jlpk5gtu3l9VqkSVgUl
 1+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=1zbwVDvuZ7/26jlVLyPOL1ByHC3nT9XTQJpiModFvqA=;
 b=asOLEYGivqZQRS7HSJr4+hr/QRR6XtbvRZiFcoomNJD/vyVXoYzTl5EIbK5PVmCiW8
 Bybj3jc3lCk2OXsFvYLNRyWimcLwE1I8LftBZc/a3t6mz1ssQjPKTgoVwfxvdrNpjIp3
 qFdy4RNRWKRo1bFOKe695jIRVKRt6iq/kpPyS06eqEXSPmYoy8KWugTxUjmoVvvH8jLO
 Pqgt7r5xbWX+ooMiKmYm+HI8qh/KoLgzkLPCtkyM66sdMDZgo1n6nwyqr1aRmKOMNGH7
 QiZFpvlS5GlEZ57rIsJ+Pbgol7jwCOQVEtIrechEohw3BsJ9oUXSEjsqY4uKiqDQZ0Kl
 UZEA==
X-Gm-Message-State: AOAM533dbt71tNlfmmorrVRBYkMVOrAbfnixXBCwLjV1rhQhc3apuxYt
 zrSZtp1ikfskPm1zpUJcRVSMYHD0io8=
X-Google-Smtp-Source: ABdhPJzj9zOciYtVY4dMT41Tu1FJ0mUYI1Zk5PmqoMM+GcepPDnjMvT38rLMWtLAAQs+6AGxa2cWIg==
X-Received: by 2002:a5d:5381:: with SMTP id d1mr5764165wrv.177.1594735099336; 
 Tue, 14 Jul 2020 06:58:19 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id k14sm29145343wrn.76.2020.07.14.06.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 06:58:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/9] docs/orangepi: Add instructions for resizing SD image to
 power of two
Date: Tue, 14 Jul 2020 15:58:07 +0200
Message-Id: <20200714135814.19910-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200714135814.19910-1-f4bug@amsat.org>
References: <20200714135814.19910-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Prasad J Pandit <ppandit@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Niek Linnenbank <nieklinnenbank@gmail.com>

SD cards need to have a size of a power of two.
Update the Orange Pi machine documentation to include
instructions for resizing downloaded images using the
qemu-img command.

Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200712183708.15450-1-nieklinnenbank@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 docs/system/arm/orangepi.rst | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/docs/system/arm/orangepi.rst b/docs/system/arm/orangepi.rst
index c41adad488..6f23907fb6 100644
--- a/docs/system/arm/orangepi.rst
+++ b/docs/system/arm/orangepi.rst
@@ -127,6 +127,16 @@ can be downloaded from:
 Alternatively, you can also choose to build you own image with buildroot
 using the orangepi_pc_defconfig. Also see https://buildroot.org for more information.
 
+When using an image as an SD card, it must be resized to a power of two. This can be
+done with the qemu-img command. It is recommended to only increase the image size
+instead of shrinking it to a power of two, to avoid loss of data. For example,
+to prepare a downloaded Armbian image, first extract it and then increase
+its size to one gigabyte as follows:
+
+.. code-block:: bash
+
+  $ qemu-img resize Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.img 1G
+
 You can choose to attach the selected image either as an SD card or as USB mass storage.
 For example, to boot using the Orange Pi PC Debian image on SD card, simply add the -sd
 argument and provide the proper root= kernel parameter:
@@ -213,12 +223,12 @@ Next, unzip the NetBSD image and write the U-Boot binary including SPL using:
   $ dd if=/path/to/u-boot-sunxi-with-spl.bin of=armv7.img bs=1024 seek=8 conv=notrunc
 
 Finally, before starting the machine the SD image must be extended such
-that the NetBSD kernel will not conclude the NetBSD partition is larger than
-the emulated SD card:
+that the size of the SD image is a power of two and that the NetBSD kernel
+will not conclude the NetBSD partition is larger than the emulated SD card:
 
 .. code-block:: bash
 
-  $ dd if=/dev/zero bs=1M count=64 >> armv7.img
+  $ qemu-img resize armv7.img 2G
 
 Start the machine using the following command:
 
-- 
2.21.3


