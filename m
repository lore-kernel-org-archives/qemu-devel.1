Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C143FC4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:25:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 932242072D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:25:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 932242072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFJWZ-0006ku-OW
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 11:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jFJVa-0005Ic-0I
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:24:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jFJVZ-0007Ud-14
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:24:25 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:49079)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jFJVY-0007U5-P4
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:24:24 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MryOx-1jaL3C2DZN-00nxyZ; Fri, 20 Mar 2020 16:24:15 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v4 01/32] linux-user: Add AT_EXECFN auxval
Date: Fri, 20 Mar 2020 16:23:37 +0100
Message-Id: <20200320152408.182899-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320152408.182899-1-laurent@vivier.eu>
References: <20200320152408.182899-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qv+OFmRHtq79Izov2TaAtAGAIg10glU60rcjElzdfOURvYNVguI
 xB89d4FE+5r8UhMaqbi0ZtQ1whSfr3voXbJT1rSGB5I5FYY3BZLCPmh1Vt0Q5aH61dmRaje
 4mXZEwHsZnVxi04dFn5YTq93DHD5qUpzSlrxU1vdL07azEHD/EKgtrd26vi97BVsDMXJv8H
 hr5xVXJQwgvICTKOUymrw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aWsDIODq7rc=:+rW/JbwBWhiukWLaaqZIpO
 fNADQuv9E7DaFklq9eI4/ANDXWKs3QD+nSiUkL6btGaKmi6a8JzRNW5hCGiIjs9yenHitz3Kf
 b02Fx/cSTAqYDDFQZmRAvqaQG5/SY42EabsE3DoVVGbLFBfYjPuHbEQ30GPzebgDs2lOGLtoD
 8wdOflLZlK9ysQQK69nXTLagooTg5ALWL9MjQnFnK66+nF0DmswtIBq4n/Iab+QBHGExHOu3o
 DlhLF9tAL8HhP+bOEBdKQlnSn8PCiFfUT1NHFTW+0C/y7hKbyniqtFpYgx4/wAUTDk2t4ZmPT
 dTtttbr9+Eobj+bfiFwThNli39vuW2qnJNofWCCeyO/PDCgfU2D+suH0Wo7GK6YzKmtVXng7s
 bfDBFMpaO4f3n12dc2JkINkRVMb6LXD00CsztG4GREywcM49R48dsZt0u+ALhlCHVUZ9unvdU
 587V6cJo6jleRHQU5Y3IJUVfaiPG8eT2ZWhh3c4eXCw6zc5I7w3/AcwpezKxjNCAmvISzE/Kn
 pwaLlDxORKgo/QRkXC/5meVgqPToFxR6PmFGGRXDOtmEh0P15oGVvcG+jZyIAdK/O2WOiH4Vd
 AALVc/fUW0yxRYao8vTQXakgwg4qbWR+YQEnZqnevetmX/IXyyqfKZGTkWQNjMszITV+GHQGE
 HVlHlpeH/2d9BLEswFz5iNczrr2Ln6EHRHwLkwwydGZ7zPGlvDABYDSnScpgxSmb/RgkVBpmE
 0K4OqOT7K+4y64i6V1RR0xVJf248QvtnTyt7V8VPKyDRGE4XlEbz25TInUYfBbd/8bIJOm2yj
 1Cgb8xR7OF1AKkAYjvuc2HSAZVtKVzYew+poMQw5cJYXjg5/QDk++zdRqqbbNzgScuP7Scj
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
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
 Lirong Yuan <yuanzi@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Lirong Yuan <yuanzi@google.com>

This change adds the support for AT_EXECFN auxval.

Signed-off-by: Lirong Yuan <yuanzi@google.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200302193153.66415-1-yuanzi@google.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/elfload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index db748c58775f..8198be044604 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1573,7 +1573,7 @@ struct exec
                                  ~(abi_ulong)(TARGET_ELF_EXEC_PAGESIZE-1))
 #define TARGET_ELF_PAGEOFFSET(_v) ((_v) & (TARGET_ELF_EXEC_PAGESIZE-1))
 
-#define DLINFO_ITEMS 15
+#define DLINFO_ITEMS 16
 
 static inline void memcpy_fromfs(void * to, const void * from, unsigned long n)
 {
@@ -2037,6 +2037,7 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     NEW_AUX_ENT(AT_CLKTCK, (abi_ulong) sysconf(_SC_CLK_TCK));
     NEW_AUX_ENT(AT_RANDOM, (abi_ulong) u_rand_bytes);
     NEW_AUX_ENT(AT_SECURE, (abi_ulong) qemu_getauxval(AT_SECURE));
+    NEW_AUX_ENT(AT_EXECFN, info->file_string);
 
 #ifdef ELF_HWCAP2
     NEW_AUX_ENT(AT_HWCAP2, (abi_ulong) ELF_HWCAP2);
-- 
2.25.1


