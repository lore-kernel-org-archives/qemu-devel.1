Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176F9C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:20:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE2AC206CA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nm7RClVB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE2AC206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwf4-0001lU-0W
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLc-0004TB-OL; Thu, 03 Sep 2020 17:00:44 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43289)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLa-0007kB-O3; Thu, 03 Sep 2020 17:00:44 -0400
Received: by mail-oi1-x241.google.com with SMTP id i17so4497639oig.10;
 Thu, 03 Sep 2020 14:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aFXlKroXX9PZfDrZJYi+g7t/+H6Gi17j+AWN8w9Ef+w=;
 b=Nm7RClVBy0aE0za/FeXkR32oswAuJoDh6+tPXlgPu48N13ZGdeixiNLNApnnZZ81VW
 xZt/RhLysbsjE49kKDNGKrID7thKLFlp5K/qSFQ9tDZXnVWB2/s4X2bdBvPi0jHBURs+
 0F1Ci93ZLiyYTPU1KWBlIIKU279d5kmWDjp0JU4v2aeg7LIY0QSm0C38zcikEVrDEsfJ
 e6BzOtNGH8oUimgvFU+1VHEV9KQUw6I6dMRAA2SmrlT6LqCsT/RtnQ8tMCVvCkWfM2Ct
 uFq+NRz4qOHipRoOKnkSwuxhAqymrQehIezkH/qJT01/8gDxoX39RBheCN9pqDjVcGrz
 O7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=aFXlKroXX9PZfDrZJYi+g7t/+H6Gi17j+AWN8w9Ef+w=;
 b=TIpzGlO+A/iR3TnkMbRkF1drjX/D9RwHMSwJ0o+I9rlhsXqNn9LR2ygxODE5vppbjf
 m5oVM9YPVHmAnP5+Te4ppjopNBpK6kQ9gBWwwmfGHSL6TVby25BOzBXKOhiUmW2VZNZ/
 wTB2QqAgkd2Oqbt+mR1KXMALlh8KcItZ8h2M2aSMRYmV85KhgWQ2XxSj6l4ylHPkrd8/
 dQQcsTHpvMVmjce3O7cVadS1N8QCJkZmXH/2vf1STXCVQHdxWKnyzXR7QEFH634z7Mzz
 9T3Us/Xnp000wSqkL4d2W5Y9dwUkCxl3LJzhxKcmVuOa5T/wvQZVjZ0/8KRFtJtpx5V+
 0z/g==
X-Gm-Message-State: AOAM5325ZXCzeMbgZXgeUhrql3QYIj2dPJgV16ZDtwQ7UJbARmPeoqwf
 BHqw9apYp+BpC5vZFqKqzPeaR/z9Xic=
X-Google-Smtp-Source: ABdhPJwbNxC9B5yMu5eeSA4PVYpgTPmk2aSAdUOx9z0QLgP9MDB80u/73FtACuwPmrbv6rmzQW8bDw==
X-Received: by 2002:aca:413:: with SMTP id 19mr3405785oie.149.1599166840933;
 Thu, 03 Sep 2020 14:00:40 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id r6sm798219otc.0.2020.09.03.14.00.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:40 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 45/77] docs/orangepi: Add instructions for resizing SD image
 to power of two
Date: Thu,  3 Sep 2020 15:59:03 -0500
Message-Id: <20200903205935.27832-46-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
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
(cherry picked from commit 1c2329b5d644bad16e888d095e2021ad682201d9)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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
2.17.1


