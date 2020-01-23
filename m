Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29DCC33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:26:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 804E224125
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 804E224125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuXpF-0006L1-1n
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 03:26:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iuXlP-0001Ay-DS
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iuXlO-000348-0f
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:55 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:60511)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iuXlN-00033n-NN
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:53 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MlNcr-1jJk2n4577-00lo5U; Thu, 23 Jan 2020 09:22:41 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 14/17] linux-user: Add support for getting/setting RTC periodic
 interrupt and epoch using ioctls
Date: Thu, 23 Jan 2020 09:22:24 +0100
Message-Id: <20200123082227.2037994-15-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200123082227.2037994-1-laurent@vivier.eu>
References: <20200123082227.2037994-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YZFoyKaAcNQl8z8+8Riz+v/ZSkh1cjwJxiVip/6CFHXtkDTTZQC
 N260pAY+36A3AoOpI71j59jpwdkZezVAfWpqlOERE7l1oLMEYhyDr+A3OBxLHxtut36l+/U
 bVJxBoEa9gnR4FLNvUrRax+ipz1Aqm0Vu6w0D3xH9UkJDVoRdODuXVnvoip7zQjIsjuccDt
 V6rRlmMtmsQL3AEVKn4VA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RslzKrMcYFo=:6+jsLUaUEUptEZVU9oyXHK
 Ukg6s4GSlpp/7D5UDM6SetD0TPsL0ocRRX53IelD0CXlcFsTFGlJYyZTND92+lIDQNomkkGDo
 2TDoT1lFPMuVwJpunY7Rxw3NjMwgCmotjBraFPMSLbFFjJBn6KYDj87+0Gx0zzYAB2BrkIqCk
 W/LEthJZxm/3vJNbIIzaXwDLFqgVz2aGptFEeQ7MtkkQqWt10nrRdELVZgPoZIpkezgkmKJY/
 5gvBOAqCpH4nby9ct5pzeKjgolT3FjPo1HqowLka/GB/aFgwjbor87p/J1X+xeA/kMtXQKIGu
 Xi3+zztpdwSodLi3u/CP7rOXiHRNb2FR5H6JDRch32SQjN/tH7szr790pktjHitZTVlt6yEXu
 y6YrlNGkP4U0X5pdkAkmrsk4I1mGSeAb5rkVZktTGwkWlegzVlLVgsexL29m6N8UbvqoHQSmN
 gDhIjtKMLn0HQbFSJrGJE3/BVQpOa8RdBAi3IByIg01uAolOX5j3i3BtYP6Hqxsy4TtZ3SAyD
 iOLOmB7EzmujW2nEbXg4Zc9nhbUPo9Xs/NNk9xFse0mx8t3FIbNyEy+khHId9s6DaLqhqgR2u
 fYT4gBRo05smkGt/yPLccUEnZ52DOjmkWeOysSD09Lduy97BNBgXuEAt6ihqLyBrnA9FDKWRq
 UoICJzPSudFLBkMNrx6efPM9kkfsULKy+JtUa0ViO49H9tB/MBnsLVnqrcg10/3Wa3/ROSyTk
 1rCVn0XVJyeXbo//9o9DrCZjE57iXbVVe9HtqvuHBh7la0umSKBZrmqe55WEYpsyxYtEMb2Ln
 WEPd/mDr61VE64NZHe9fYzogTP6ugl2yW33LoHsSToqI1T8E78=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
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

RTC_IRQP_READ, RTC_IRQP_SET - Getting/Setting IRQ rate

    Read and set the frequency for periodic interrupts, for RTCs
    that support periodic interrupts. The periodic interrupt must
    be separately enabled or disabled using the RTC_PIE_ON,
    RTC_PIE_OFF requests. The third ioctl's argument is an
    unsigned long * or an unsigned long, respectively. The value
    is the frequency in interrupts per second. The set of allow‐
    able frequencies is the multiples of two in the range 2 to
    8192. Only a privileged process (i.e., one having the
    CAP_SYS_RESOURCE capability) can set frequencies above the
    value specified in /proc/sys/dev/rtc/max-user-freq. (This
    file contains the value 64 by default.)

RTC_EPOCH_READ, RTC_EPOCH_SET - Getting/Setting epoch

    Many RTCs encode the year in an 8-bit register which is either
    interpreted as an 8-bit binary number or as a BCD number. In
    both cases, the number is interpreted relative to this RTC's
    Epoch. The RTC's Epoch is initialized to 1900 on most systems
    but on Alpha and MIPS it might also be initialized to 1952,
    1980, or 2000, depending on the value of an RTC register for
    the year. With some RTCs, these operations can be used to
    read or to set the RTC's Epoch, respectively. The third
    ioctl's argument is an unsigned long * or an unsigned long,
    respectively, and the value returned (or assigned) is the
    Epoch. To set the RTC's Epoch the process must be privileged
    (i.e., have the CAP_SYS_TIME capability).

Implementation notes:

    All ioctls in this patch have a pointer to 'ulong' as their
    third argument. That is the reason why corresponding parts
    of added code in linux-user/syscall_defs.h contain special
    handling related to 'ulong' type: they use 'abi_ulong' type
    to make sure that ioctl's code is calculated correctly for
    both 32-bit and 64-bit targets. Also, 'MK_PTR(TYPE_ULONG)'
    is used for the similar reason in linux-user/ioctls.h.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
Message-Id: <1579117007-7565-4-git-send-email-Filip.Bozuta@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h       | 4 ++++
 linux-user/syscall_defs.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index c39dd0128a60..9e91eaae7705 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -81,6 +81,10 @@
      IOCTL(RTC_ALM_SET, IOC_W, MK_PTR(MK_STRUCT(STRUCT_rtc_time)))
      IOCTL(RTC_RD_TIME, IOC_R, MK_PTR(MK_STRUCT(STRUCT_rtc_time)))
      IOCTL(RTC_SET_TIME, IOC_W, MK_PTR(MK_STRUCT(STRUCT_rtc_time)))
+     IOCTL(RTC_IRQP_READ, IOC_R, MK_PTR(TYPE_ULONG))
+     IOCTL(RTC_IRQP_SET, IOC_W, TYPE_ULONG)
+     IOCTL(RTC_EPOCH_READ, IOC_R, MK_PTR(TYPE_ULONG))
+     IOCTL(RTC_EPOCH_SET, IOC_W, TYPE_ULONG)
 
      IOCTL(BLKROSET, IOC_W, MK_PTR(TYPE_INT))
      IOCTL(BLKROGET, IOC_R, MK_PTR(TYPE_INT))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index dc36dd475112..fcbb2ee9a387 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -776,6 +776,10 @@ struct target_pollfd {
 #define TARGET_RTC_ALM_SET          TARGET_IOW('p', 0x07, struct rtc_time)
 #define TARGET_RTC_RD_TIME          TARGET_IOR('p', 0x09, struct rtc_time)
 #define TARGET_RTC_SET_TIME         TARGET_IOW('p', 0x0a, struct rtc_time)
+#define TARGET_RTC_IRQP_READ        TARGET_IOR('p', 0x0b, abi_ulong)
+#define TARGET_RTC_IRQP_SET         TARGET_IOW('p', 0x0c, abi_ulong)
+#define TARGET_RTC_EPOCH_READ       TARGET_IOR('p', 0x0d, abi_ulong)
+#define TARGET_RTC_EPOCH_SET        TARGET_IOW('p', 0x0e, abi_ulong)
 
 #if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_SH4) ||    \
        defined(TARGET_XTENSA)
-- 
2.24.1


