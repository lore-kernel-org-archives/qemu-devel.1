Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBE3C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 11:27:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3703620675
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 11:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3703620675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52714 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU8MY-0006xy-4F
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 07:27:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hU8Kj-0005Q3-TD
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:25:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hU8Ki-00015b-T7
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:25:57 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:53441)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hU8Ki-00014o-KI
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:25:56 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1M3UhQ-1hTaMV2epO-000dFN; Fri, 24 May 2019 13:25:29 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 13:25:16 +0200
Message-Id: <20190524112520.17684-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524112520.17684-1-laurent@vivier.eu>
References: <20190524112520.17684-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/zoP9ZJIYI3PlOLLxDV8yMn+R9FhkbQovg3b/o8RZYWWz61DxOa
	pj+LzCK0SquhTsrsylKFGskJxbm6+e0/Ul8WASbupDxyH1epnlM1KmzH+OtgP3+7nMXS3gx
	NKAKvYJyLjxBnhC0WMJXlM3dmKvRC9fcVB/us+cKghTF0lEwwwwOSqNgGUwec+3oZCJI7qv
	Bq0qwty2gOl+hE6fEbs/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VGizC32a5xY=:13j2DMITh3JlMUPaB68Uwr
	93jp1ZXSkuQbcucid8lP7xfqXdu42KL5VFvRv7mqIne5ORt4KWBdji4+TRtaEjpWPvVWq3S1N
	X36dKAm9gnsmVa6Fzp47kjmdygzZT7yNnnZPRTAF+2O9SjbyGUB/AsGLXshVlxjEbB6+FbvvS
	HFbj0GQEbE3NXd+68sKbZ4MBpFZmkOBv7MPP+kP5M3T1q7Cg4dc8EriHlSWnrAdkeTrHWqUSG
	uKDgfvy/aVLwjfPJvAKDreWSnA9j4Gapp6h/MT9XH0hiLNjPqXp+2DuY0rJ83dh7FBrku4CrV
	B48dIm6vpZBmMqtZj4So1OuDX/NgN9wIAJ5peGgyphSwyoTWlbxSkdALTRHrvCUDpNkAb2H67
	h/oCS0hakkjPRVKeVYwyXVoPfMpku9PAxxUiLZgjUJ04agk4Q8LdiiHzPBSvRO4hWu93B9UCU
	00RwT1WvE6SX4MJ17y0StsUnVKkHg1a9C2VR1BXpPoICrNlcVFXZoPX0QaJ419W2XqClHBaJV
	6D9jsnldc2O26KKRuH0URiOnWUufp98MiH49U4MEuzHjKMeciMt633dJrKevlbJtiiTgTHCgx
	HpXEVaeigfpWc9hC8jonsDf5YrNF2cU18muaMe0ZqffkcKRKx1wDLKUXNbkyjvRJS2aEf5pse
	X/xzfJsQBoZMFy0NoEcxF+SQZq+sNOb5emjIzLsI2bXszH9ipRpxrAZk2y+DtHFTXRGjewjAi
	dXK27Jltr8ZeD42PQCR3wcHpYR4En5JYEVjcMQ==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
Subject: [Qemu-devel] [PULL v2 5/9] linux-user: Add support for
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


