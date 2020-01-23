Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F62C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:29:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA9DC24125
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:29:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA9DC24125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuXrl-0001ur-8E
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 03:29:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iuXlV-0001NK-EC
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:23:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iuXlU-0003Ay-9K
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:23:01 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:45953)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iuXlU-0003AA-0c
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:23:00 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N3KgE-1jdBtt2N6Y-010IyB; Thu, 23 Jan 2020 09:22:39 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 11/17] linux-user: Add support for TYPE_LONG and TYPE_ULONG in
 do_ioctl()
Date: Thu, 23 Jan 2020 09:22:21 +0100
Message-Id: <20200123082227.2037994-12-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200123082227.2037994-1-laurent@vivier.eu>
References: <20200123082227.2037994-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:eodUeUisqAWTjs8Z6zmqWWfREn5jIMk2MN+z4os6X6525iNoGp2
 7LvDCVFEcM9e9ytPZrQ7rR/GJxcxbadcfPpwWnD5NoMdLbZifmNveNgX/Ng8hY6vTzdKB5y
 asucmhijVP3swoD6sLPf6URHiskM9AilVKBqax2NVvX3vFGGvrOR7o2C3WbqhVq9B0B2ofk
 ZSUGV32eXbXTFxcEabICg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vjhQCSNrnj0=:epYK75BkDWtyB3unix3kVR
 jR0uYmRDDJXW4CgitDGstporfbIqpwS0YlJjKCwPhVayRacLd3Ss8iJIRG9ZRELOUXNZX+sqP
 t0nMaBFBAHsSgYSeEnbaaj/Wo1qQLm6gA9YL9qD5RE8uLOAVJT4DG8APa+j+H6qIjbja9UXIW
 AcXCOYpXp713db0zBkKsQdABH+6tdHcdRKKAKftTImTEMkcLeV0if3CGuLmd4vNiFSFftTLLN
 yMYZ6Chxj04ThvyZgrjvIIGKYnCJ/of4NCjGUo58dkmqB4OOgetou3yovsVK0paJrgNS2rAHz
 wUsRcOWh+XhpC25KySjmvCnYC8pERICBJdDjGBM1dfqpyA/2qc3B5K6Byoyp3+2DP30pkF/tZ
 Q69bwG7DbMIPu4Ndfs9aZBeof2j5jb6mvErOhLf6CxNVFOkWIEeL6eOv9s7eZXxykePeStTjU
 /IuxffiE+vp4nCKad407xe+IeG/ZnC7S6vG4bD6jJw3+UMd8SsWs4MShKFudsaOs7Ky9QGN1T
 KvIL/Ag+Kg565HhCaFXRZAb4aVpkZx5UW7JYx/9/GspICh8xSaPUXg+X0BZFEFWHqNNFBlxyM
 ty1QSEwf1NqiXJgmB9bjkuDu/yWTj+E4+OuMLer8zi8PRssnIO9gKGMqHnn5xP4Al4DqjPtTB
 JUXEwGDS5nfCD5VEPdat2J0iAczC+NsSdWbmAr1NecPLVh5mQ627VMMrfeQ60ay8iZ5OBSurL
 Knc+YMso97lflBZ/CC54kt/hi6nrkp8iijcT1Yr8y5hNJesvM6b3GCQTfyrvimPt7Fjs02Kn7
 NALSXTIxkeJSTxgRF8bQWS3HfJlaccZdzEMxLlVQkgDrmw6NNHT/J+MHBopOFGM6C00AEeT
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
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

Function "do_ioctl()" located in file "syscall.c" was missing
an option for TYPE_LONG and TYPE_ULONG. This caused some ioctls
to not be recognised because they had the third argument that was
of type 'long' or 'unsigned long'.

For example:

Since implemented ioctls RTC_IRQP_SET and RTC_EPOCH_SET
are of type IOW(writing type) that have unsigned long as
their third argument, they were not recognised in QEMU
before the changes of this patch.

Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1579117007-7565-14-git-send-email-Filip.Bozuta@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index c5bda60b45de..bd2436b31007 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5178,6 +5178,8 @@ static abi_long do_ioctl(int fd, int cmd, abi_long arg)
         break;
     case TYPE_PTRVOID:
     case TYPE_INT:
+    case TYPE_LONG:
+    case TYPE_ULONG:
         ret = get_errno(safe_ioctl(fd, ie->host_cmd, arg));
         break;
     case TYPE_PTR:
-- 
2.24.1


