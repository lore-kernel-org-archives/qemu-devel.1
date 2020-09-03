Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8348BC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:11:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 352A020716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="WpunyQDg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 352A020716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDrpg-0001Al-5W
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 12:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDrmS-0007t0-LZ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:08:08 -0400
Received: from mout.gmx.net ([212.227.17.21]:49707)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDrmQ-0007jo-MP
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1599149271;
 bh=BFlROhqLNa/5mWtTViwWl2vX0zdk1DqFz9BeeEdDis8=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=WpunyQDgri3RYc/4qSKpdQY4bRS3uw68N8xX1tzL+btGUxOk5MmM0Xysm/f5N93dR
 FoYfSgi6SFa2yIHBgrLRcpuhuDSMGg+oiV79BIuTBC0iE+qAmPq4fZ+dUEtt6acei8
 mK13MEQQtSp61KB8Okth5A/s4a+BAOIp8t3U8KQo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.138.28]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHoRK-1kJvmr00c2-00Es4G; Thu, 03
 Sep 2020 18:07:51 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 04/10] hw/hppa: Change fw_cfg port address
Date: Thu,  3 Sep 2020 18:07:40 +0200
Message-Id: <20200903160746.27491-5-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200903160746.27491-1-deller@gmx.de>
References: <20200903160746.27491-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k8RO8z8QxZm8GkBRCPgKP7gXE+t3jKLMPBQgksB11Q4eC3e9dbZ
 Dysz5NBxrupCqBsMgr5NsXR6P2JxmiHjgm2n+CX/tbJWUggErbcmMbugD3JqcF7ymSyGh+n
 25TR9U9ON/DEdzVcCVkSRrd+TOGxtzjJIzjYVE9/UK1CLxQjQ1ZKK15m32KWTCgjaIRdRDy
 OdN6TeK6zs7kmNNtB3byw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CU4jH9Gonw4=:C+JFhUx36N2wod0Gbd+7Mh
 llkv7sB2LfU3SyrTlx+aYOz6RlU9Vi8ZM/kUkNzG8011skyzLy9nmp42EkjwBkTP7x4waDJFq
 HPVeCZ03ERkv5GGd5o7MfPaxSf9Jv91kXWvS5DN/1QuLjHP8LJYbU3N3uuTucmZCUh7vBqg8v
 9thXkzBqwDBCr83SkU95+tgqwqllswoa0tSpGCCc1F7AfU8SsQgjSvuq6VDFhMXSnkYBnrIMw
 GXzdXLJyzBfpegLF9lkBuYSuah2qCT3Dw56WAx04jjMgOCoLsAdJPK/OULMye0i2C3T2qQnVO
 oQIZbAHManecCk4MDXy2MxdINJIGtx0xp/Jz5EIHithzQ//yQzMh7NRvOzIQid487N6G5SXGR
 hmkxoniPO6cZ8dkpUy4kqpp/u7Nmw2nbcZ/sH2UiDtJMH6DLwgYol4LK/AlspwTRMltdsxRNh
 t5XORr85BScQkKVNuJkm9chLzJP0rpFN9VmcQCW1U+tIEcs+uzHqULoGlrrjUSETdp09yzuSl
 Cs7/JMDOEaKcZnfMkfwGG6aSEvi6hnOkaqL2hHX5aDBuzvTeWyrF3B4Bwq+W3XXNbYsyUp2Aj
 53sp4Run3rD+jyvmfaCxJcyozVnY89sg9KX0fZIHLiSGOheWPNhUzu1E6gXlOgAxpB4aJrzrB
 RdTjL8a7E3qvZI4RNbaTrc0PBjwBIvKD2go/WJft8qUxKgLbIYfKlP5MMK8QtDp+Lpso3hIGL
 n6gLkiUWFpzaAUd+SDvkXRQI6gHfmMVmiDKyUYhU3PJ4Qltp0l3x67Y+TWCJln90NgnOZpYOt
 getAQ8Fth/4ysqLkTEtTCrFirdv93dUxxHmgZMRWc0G9j48q5rapwvc49mKw3FhF2jQwXS9g4
 TgrTV+kdOLjEaaEK6a/JQM0puSWeDiz1dAKlfsidCoFaZxMO17SE2FfSuyG4M07q02CBQGRHb
 yiE2lEKVQKAQ0uAcnrzBo5Ey272tv6xR1TPgh74vYey3FGPL3nSLZJ16Wi99nGLi1r9VT6cbo
 Y+tibV8RNT9yU4Yym+qtRaWvGyZVJyZ0EDzSGot2ysP6/X7s74c6zqANuIbwPrUtwmAKUuLz5
 riKdlTcdZpwVPA7/NF+WPsTC2kHH8n/lxW9IK65sIYw29lzSHCzlhWVKyBo586VPXpwN3oQdV
 bnOzCOie5ZrgUvIW7Pwd2xzi7w4XWL40CwcJZTfAtNy48UPipJCQoJIU4rs/E7RYlyHOJc+sS
 dwFelpiN68xLcm8ao
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 12:08:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Devices on hppa occupy at least 4k starting at the HPA, so MEMORY_HPA+4k i=
s
blocked (by Linux) for the memory module.  I noticed this when testing the=
 new
Linux kernel patch to let the fw_cfg entries show up in Linux under /proc.
The Linux kernel driver could not allocate the region for fw_cfg.
This new base address seems to not conflict.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
=2D--
 hw/hppa/hppa_hardware.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/hppa/hppa_hardware.h b/hw/hppa/hppa_hardware.h
index cdb7fa6240..b2fbbc2eec 100644
=2D-- a/hw/hppa/hppa_hardware.h
+++ b/hw/hppa/hppa_hardware.h
@@ -38,8 +38,7 @@
 #define PORT_PCI_CMD    (PCI_HPA + DINO_PCI_ADDR)
 #define PORT_PCI_DATA   (PCI_HPA + DINO_CONFIG_DATA)

-/* QEMU fw_cfg interface port */
-#define QEMU_FW_CFG_IO_BASE     (MEMORY_HPA + 0x80)
+#define QEMU_FW_CFG_IO_BASE     0xfffa0000

 #define PORT_SERIAL1    (DINO_UART_HPA + 0x800)
 #define PORT_SERIAL2    (LASI_UART_HPA + 0x800)
=2D-
2.21.3


