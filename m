Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656FDC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:48:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CB6C2175B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB6C2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38071 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTp16-00081l-H6
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:48:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTowz-0004Ja-KM
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:44:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTowy-0006Lp-GQ
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:44:09 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:46945)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hTowy-0006L1-7i
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:44:08 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA
	(Nemesis)
	id 1N3bnP-1gTqaZ16Jv-010gql; Thu, 23 May 2019 16:43:44 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 16:43:31 +0200
Message-Id: <20190523144336.13960-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523144336.13960-1-laurent@vivier.eu>
References: <20190523144336.13960-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fIEHQdd0xLK6m76XJQ2KhMZcRti/qRyWCnr5W8HvJUbSHd5u++D
	vjWkW1hlXmmXSjAP5XQcbX1ylBXrX8v9Fwy6bOTeoyIMwhz0jI7/kYSkpbTB8u8+rr/52go
	/37KkzRC3qFCsEPhNoyDASRKt7Z+Xv4wQGzwmYTWwJlPzp1tZfs9dWZL+EHQ9+GJzvxCnem
	udHo2gBPM1ijtz9sGtNcA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9HCEEhfrL18=:FofsW3m17SvLq8lJsk2umn
	+upCSqr3L6oF3FdboCgTbqlYhVsScsYBP/uEiD4GMolt2GOhh+OV7Sok4azni3RW/Bu+nXkai
	b+Ap6L2POSzo9PLiJqUTOPxjApESJ6GBYIMxpahtKUGrVJed+JmYpnllhbKgRWiKt2KbkwSRL
	4nDHX/uQVUrSA7Uv+EeRZvW0w05zBM7a7zQFvNaLBp9YgX6PfqB34q+qJP1Eggfl6aKMrQXrp
	DXANhMWk3yfWHqzPMsUmfpOwnH8rp2Bp4pn2+NgC3Wcy1roxkVpDLX479D89FIckRAK3NGvWf
	SF9uw42FQvdQSruCKUc/A/+iKkdJ5/MgEJWWgnkIbe356M89FHS+O9IlP4SD4ZeKXjVTuByS4
	A3xWH44sZF7KO5i4LniMl0OkZ8549COJSh5zRpP6Aemsk+cWg1jAyMmzcHITKaQj/YQe7vO0C
	5XMZlMMaMjS/tIs6Z5A5Yf24MXCJPOX5W4ClCluEhUeekNaQwG4R4aZch0q6ZWoP+RFbmqDMU
	mOxxwERHk2z4dsR5z7XGH+9SQB8V2TjtdhE0d64FIpGYCmS9/WTTu21QAg9Ok0IAbfDkC/lgz
	LMutEdiTDQFGmDiKUoYRbroRLfG0Kzy6wZ/Yiyy0QKg1jVRVbF3/3fmuaZsF7XU1mEdvDaUfs
	5cSKK6CCaPzyb93Q4vTkC6z7LF71AeWG9TEYD1reuiodb1ZLesIP/rMHQxCCIO6XN6cD0EClV
	0EwK/8ZUM3iMYmeuiIHsw5+3kzFvB4wqf9Ql1g==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
Subject: [Qemu-devel] [PULL 05/10] linux-user: Add support for
 SIOC<G|S>IFPFLAGS ioctls for all targets
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>,
	Laurent Vivier <laurent@vivier.eu>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Neng Chen <nchen@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Neng Chen <nchen@wavecomp.com>

Add support for getting and setting extended private flags of a
network device via SIOCSIFPFLAGS and SIOCGIFPFLAGS ioctls.

The ioctl numeric values are platform-independent and determined by
the file include/uapi/linux/sockios.h in Linux kernel source code:

  #define SIOCSIFPFLAGS 0x8934
  #define SIOCGIFPFLAGS	0x8935

These ioctls get (or set) the field ifr_flags of type short in the
structure ifreq. Such functionality is achieved in QEMU by using
MK_STRUCT() and MK_PTR() macros with an appropriate argument, as
it was done for existing similar cases.

Signed-off-by: Neng Chen <nchen@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1554839486-3527-1-git-send-email-aleksandar.markovic@rt-rk.com>
Message-Id: <1558282527-22183-4-git-send-email-aleksandar.markovic@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h       | 2 ++
 linux-user/syscall_defs.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 99ed9d982568..5e84dc7c3a77 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -206,6 +206,8 @@
   IOCTL(SIOCADDMULTI, IOC_W, MK_PTR(MK_STRUCT(STRUCT_sockaddr_ifreq)))
   IOCTL(SIOCDELMULTI, IOC_W, MK_PTR(MK_STRUCT(STRUCT_sockaddr_ifreq)))
   IOCTL(SIOCGIFINDEX, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_int_ifreq)))
+  IOCTL(SIOCSIFPFLAGS, IOC_W, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
+  IOCTL(SIOCGIFPFLAGS, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
   IOCTL(SIOCSIFLINK, 0, TYPE_NULL)
   IOCTL_SPECIAL(SIOCGIFCONF, IOC_W | IOC_R, do_ioctl_ifconf,
                 MK_PTR(MK_STRUCT(STRUCT_ifconf)))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 9470a5ce965b..cb40620114f8 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -782,6 +782,8 @@ struct target_pollfd {
 #define TARGET_SIOCADDMULTI    0x8931          /* Multicast address lists      */
 #define TARGET_SIOCDELMULTI    0x8932
 #define TARGET_SIOCGIFINDEX    0x8933
+#define TARGET_SIOCSIFPFLAGS   0x8934          /* set extended flags          */
+#define TARGET_SIOCGIFPFLAGS   0x8935          /* get extended flags          */
 
 /* Bridging control calls */
 #define TARGET_SIOCGIFBR       0x8940          /* Bridging support             */
-- 
2.20.1


