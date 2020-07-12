Return-Path: <SRS0=QItv=AX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26365C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 18:38:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0DE42063A
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 18:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A59dvRbO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0DE42063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jugrW-0007kM-2y
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 14:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jugqm-0007BE-0W; Sun, 12 Jul 2020 14:37:20 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:45150)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jugqk-0007gU-9T; Sun, 12 Jul 2020 14:37:19 -0400
Received: by mail-ej1-x644.google.com with SMTP id a1so12358371ejg.12;
 Sun, 12 Jul 2020 11:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uYh31q18n0yhSjGPF3WvIufvZ+mvdDfDZdJIQvzgChk=;
 b=A59dvRbOpFxQCuMLxQ5ZrdarROSgpMonGWew5d6DwaFK6wBURVPAMmNlD/eCmj6aT0
 DFU0tgiXkxzXv/ZmJ7BCkGX5DDiSvj79ancyWqK9mLig+TJvA12s1VOty6u9RLQNcMUY
 YrmYKIJgslmvR43W9zX09bR4vlZr9bcHf/uwJbUJRSq4mNMXSRnN2NFRDFh6gt+HaUYp
 UlW+szaB9F0T6rZtw/vauXDN8++TzKF1dqh/cg8gjuAdHmoTTPdSTKYoSteFW053LgFY
 vThJEiK4u3WJrpzO5YT+mVmAuVlO58GyCQGlC1EpAzd5iHoxz0ANsYwtYAVkktIVH/fS
 RWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uYh31q18n0yhSjGPF3WvIufvZ+mvdDfDZdJIQvzgChk=;
 b=KyLS8ESxDbxLg5u051FcSSdhgTUc2vMcYinDMq2DLSs5d+9th/YmBRHtkVGpfm/xrR
 yosnMMT7I7s3yQcAg7aZFxZhkFlXz0jP6SlSyMgzD9vk8A9d4tNofMbs/+zDQsLViS4P
 3OeGsRrQmEHJ3DoemqQYbU3Gh2N3tg0Z+KoX6goiPxNq6mig9Kn1A2CnCW3tfwC2Z1UK
 8/7HYuiSzDJjKkHsKcf1tEIIucLsyMeWAysYJitgg+9FT4oc0dp+HLy660rQdmo2WuyZ
 /ESd108sNYLbqvS8zfAQfgN0Ckq9HyBRHhpZApieOpX9JjbDLloXruOOx3207OBwv1pe
 fh5A==
X-Gm-Message-State: AOAM531zSBdmMUaqc4WMNiJp28yp14n4TMDX8+xguTA8Kp32jnHWEqnP
 nehOy3kUrEQeGDnbtD67lgl5z8j2c8g=
X-Google-Smtp-Source: ABdhPJx5WpFoncBGSrboyG650iolPjUAChi7M+VJpmv4jGrDbssxiDvoKXkZLYLqS/FoaFnJvMN/Ag==
X-Received: by 2002:a17:906:d78f:: with SMTP id
 pj15mr74497612ejb.283.1594579035521; 
 Sun, 12 Jul 2020 11:37:15 -0700 (PDT)
Received: from tuf.home ([2a02:a456:6be8:1:8915:e711:6eb4:bfca])
 by smtp.gmail.com with ESMTPSA id be2sm9549347edb.92.2020.07.12.11.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2020 11:37:14 -0700 (PDT)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org,
	philmd@redhat.com,
	f4bug@amsat.org
Subject: [PATCH] docs/system/arm/orangepi: add instructions for resizing SD
 image to power of two
Date: Sun, 12 Jul 2020 20:37:08 +0200
Message-Id: <20200712183708.15450-1-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, Niek Linnenbank <nieklinnenbank@gmail.com>,
 qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SD cards need to have a size of a power of two. This commit updates
the Orange Pi machine documentation to include instructions for
resizing downloaded images using the qemu-img command.

Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
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
2.25.1


