Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBDCC33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:32:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 427DF2467E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 427DF2467E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuXv7-0005ym-NN
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 03:32:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56059)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iuXlR-0001GB-8b
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iuXlQ-00035N-5j
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:57 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:58937)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iuXlP-00034v-T5
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:56 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N6KpF-1jeYg71cUb-016clM; Thu, 23 Jan 2020 09:22:42 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 17/17] linux-user: Add support for read/clear RTC voltage low
 detector using ioctls
Date: Thu, 23 Jan 2020 09:22:27 +0100
Message-Id: <20200123082227.2037994-18-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200123082227.2037994-1-laurent@vivier.eu>
References: <20200123082227.2037994-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Gr9Cw03uQnZoGOJDZCLFvBQUvTYF5geC4VHLGRbkZhIZgbaW8Zw
 CxlhlXrBt3r5W+Eah86w3RiuRwd/0bof04IpjuYNNrM3ulRXqOh+Xtjf3bXn9ibZVENK0mo
 PDyMhIC+7b5RUgwyPiYifVWEVeHjJXFK6CswFM3bSI8j6ZtdlRt8r0IgqjPhECqOMSOMtwl
 qzf33rdT9C1TEVpHzCGCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jJWSIJ0pyJA=:duqCn3GQrdsWSs9elTiW+/
 qFroFsQk+TKFp1+BevxB3qDj8n32TDvGNxqz9Zs/x4GoO+sH38x7R1VuxtIvGmfp/z0qCZXXd
 MKT7sfnm3Oxy4YpNXkCm9rCmGgNZsCGwDtINgWcABmoPT12gEqjypcKjCfh7ONMeeC4YSEFS2
 8Q5dGYlW7ibek4jAdipAtV6JnIwcVwIcanIN/9aOyOokkM1lrdzu45f27fnp2B/0+zDLH7UuK
 0LrqM5Z3t/4fx1OwuV+5V0lh7RMEbbhRdu5KHQysGIyIJ2mBWR8xobaOxl397+qbgA1E6u8Xn
 4dVXkMkGqFlDghsHerRDcywuh5OsSjomojQo8GcUx0Jdy/h4xg/JqMrITf2BDIzbEfMZI7x6g
 /UBNlh/ciWX2jAQPXDrwuhBVdOE6aOmFgewLWFjaolXP0oqfQ5m7zqdoe8+s1qJfukXFvEvg6
 kYYZJLsSWWELKssvtoe8VvHRAfKTZ+yxBZVAgoy08TJDI5hh7sRsJ7kCJ1yggInec6laQojjB
 Ko4dEhk7wPgiTwUwE+vLIVHmsjAVeh7NLQGRVbhY4Cv6K/wq2DZ5tNPclGuJmx1//3jGb49Rq
 m1Z+3u4ZZikSDAEfz1btJEOgezDpVo/lzN/H7A8BPHtS9GEPgZ7Tm+HuMmwkCp/+ByWb0NfTh
 9n94+pxWKD8ScKkoUKwhl6ZGon8thO5lCVql4iyh0jzP40n6DDNNY06dBuSoLppd43O1ffEFl
 TshczqSykLjlQgiBEZd2BKisLxEJJDvuVQijCgqZi0gkGNQZ6pZ9Tx0Z+sKU++LaCqnmDQEe2
 ogE+c7mbSflbJepULseNw6aLxoQ55H8YnfFhvDRxlvEo64BI3Q=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Filip Bozuta <Filip.Bozuta@rt-rk.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@rt-rk.com>

This patch implements functionalities of following ioctls:

RTC_VL_READ - Read voltage low detection information

    Read the voltage low for RTCs that support voltage low.
    The third ioctl's' argument points to an int in which
    the voltage low is returned.

RTC_VL_CLR - Clear voltage low information

    Clear the information about voltage low for RTCs that
    support voltage low. The third ioctl(2) argument is
    ignored.

Implementation notes:

    Since one ioctl has a pointer to 'int' as its third agrument,
    and another ioctl has NULL as its third argument, their
    implementation was straightforward.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
Message-Id: <1579117007-7565-7-git-send-email-Filip.Bozuta@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h       | 2 ++
 linux-user/syscall_defs.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 789764d11314..73dcc761e642 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -89,6 +89,8 @@
      IOCTL(RTC_WKALM_SET, IOC_W, MK_PTR(MK_STRUCT(STRUCT_rtc_wkalrm)))
      IOCTL(RTC_PLL_GET, IOC_R, MK_PTR(MK_STRUCT(STRUCT_rtc_pll_info)))
      IOCTL(RTC_PLL_SET, IOC_W, MK_PTR(MK_STRUCT(STRUCT_rtc_pll_info)))
+     IOCTL(RTC_VL_READ, IOC_R, MK_PTR(TYPE_INT))
+     IOCTL(RTC_VL_CLR, 0, TYPE_NULL)
 
      IOCTL(BLKROSET, IOC_W, MK_PTR(TYPE_INT))
      IOCTL(BLKROGET, IOC_R, MK_PTR(TYPE_INT))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 9f7aad49c683..9b61ae8547dd 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -796,6 +796,8 @@ struct target_rtc_pll_info {
                                                struct target_rtc_pll_info)
 #define TARGET_RTC_PLL_SET          TARGET_IOW('p', 0x12,                      \
                                                struct target_rtc_pll_info)
+#define TARGET_RTC_VL_READ          TARGET_IOR('p', 0x13, int)
+#define TARGET_RTC_VL_CLR           TARGET_IO('p', 0x14)
 
 #if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_SH4) ||    \
        defined(TARGET_XTENSA)
-- 
2.24.1


