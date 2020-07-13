Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3C1C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 18:33:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EB142075D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 18:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oGNSLeFY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB142075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv3GY-0003fz-6D
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 14:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jv3FS-0001wx-0K; Mon, 13 Jul 2020 14:32:18 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:39949)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jv3FQ-0004FX-74; Mon, 13 Jul 2020 14:32:17 -0400
Received: by mail-ed1-x543.google.com with SMTP id b15so14574637edy.7;
 Mon, 13 Jul 2020 11:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uyp96aoYkkNgfFwZ8UhO6hrlMhJXRb1SNh8r9bSD384=;
 b=oGNSLeFYoy0wqXyj6T1ho54TK4QAUEASzjT1eBk64HZhgkvf3HYMfQS1A+bmxVdFb2
 26ttJPWIu5pN2JQMju3b9Iagm44CSd45huqXmLTckZy3eALson1eYmaa8Ndh5KbXk3W4
 O58cPCVO+Af6O7FPsTVXzX4G5OTzCECZ9VsGzKlFywmFoQu44yGgFnLLa41prkduULTx
 4hLcUnp+uUQMRdHSiatQX/8BFwzfCIG7+umYDVchpiqF7N+/H5JNqEc6LD0nFYXdKy0e
 9Q0lMYToSxRJDufkXY/eoajbSVZwTGNjrd4zgitf+3GSRxQtYbg/s4GwHz/F7d+NoKr+
 rX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=uyp96aoYkkNgfFwZ8UhO6hrlMhJXRb1SNh8r9bSD384=;
 b=g2KAE6pLVmqnUGBGmdsYPQ1rhfRiI44Qopthujt7Tnwb9UdRL8ZSsasweYuHopLm59
 f2jFT7bYlNIqrMCFz7WmfD1NYk06M6obYlf3bv+D3QFgvZKBwTrKZjQ6+G1Yp6q7TODJ
 amuylfK4ZWw6QTf9oYHRFHPeM0DgqUNvCtQP8mzFLpR+55kgN8gGNFqFCnQEdoIoWJsL
 QQnB9JU2Hlu2bkRSxANPDH/wvoVbTtJQ0fLR6RewbSa70Ic0c9euCcuPM9/KNU4fBqtH
 levJbk6530ipIzzXbwrfc7a6ZD+qvoTN3i/EAlRRAeMeWdkzsNbyolq7kcO+6pUBdz6w
 pD2A==
X-Gm-Message-State: AOAM5335FRltlL14qDAvmJhMyGJK8im2Ge4J2iJZVXJEyK0vUkd58M7V
 FpuB36WIeV9pA8cS3A/HL5ZbyZxXqF8=
X-Google-Smtp-Source: ABdhPJxkG8aBXH5nMHTp8bVR/0bi+rXLij8SDEfXvTpkanubvbT5pHQtYuVRgqe77E20/ZfyyV4Suw==
X-Received: by 2002:aa7:c54e:: with SMTP id s14mr715323edr.81.1594665134253;
 Mon, 13 Jul 2020 11:32:14 -0700 (PDT)
Received: from x1w.redhat.com (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id ce12sm4353148edb.4.2020.07.13.11.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 11:32:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/9] docs/orangepi: Add instructions for resizing SD image
 to power of two
Date: Mon, 13 Jul 2020 20:32:02 +0200
Message-Id: <20200713183209.26308-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200713183209.26308-1-f4bug@amsat.org>
References: <20200713183209.26308-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x543.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>, qemu-block@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Niek Linnenbank <nieklinnenbank@gmail.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
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


