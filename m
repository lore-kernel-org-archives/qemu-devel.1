Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C917DC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:57:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E5F620714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E5F620714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEEah-0007mk-Qk
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 11:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36977)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jEEVK-0004mJ-Db
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jEEVJ-0007EH-5R
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:51:42 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:51517)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jEEVI-00079M-P1
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:51:40 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M7JvO-1jD82u2zDI-007oNM; Tue, 17 Mar 2020 16:51:29 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 06/37] linux-user: Add AT_EXECFN auxval
Date: Tue, 17 Mar 2020 16:50:45 +0100
Message-Id: <20200317155116.1227513-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317155116.1227513-1-laurent@vivier.eu>
References: <20200317155116.1227513-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7Kilwg1l9IsgK+FEbdtGTS5sPxpECCuDHv241Zo5PdMdH0c6SVV
 ds3rUZkaSrsPN6v9UWoMHdP4BjrEp/NzCAgrCIdyYL/pkzWDAhaA8UR1bh7sTK4T6BMEXuA
 gdWPBMdqJzzmjIQ4APT68jYbLS/TrQ+kBB4arorUQsgw0LP5I73lmfL1qdK5AplPSbLB/cO
 A+JgmFuBDsEC9JxFfwKOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Halbe73P018=:CJ8Joq4htcm+TGKBLRkac5
 uFOTO6wmPc/ZkV47UY2aSR6PhlqA0s5WpTsQL2F+vMBYu5aSTRwbsnhZRAhoVnIE6iK8cTrl1
 kUGfr0bWwjbxUpvu50knPJfF6XEHCTSiUWKzw0XVVBI2uicOcQ0ZNx5NQQCUJIkbSzbeNOzQA
 XTSG8+fnhotrTzI+H+C59lmXzT1Y/AO58kFgifgtDfB1qSroGHYgkPfQwH4QLUvR0Z9nBHqMW
 1lWvxwiDFhW6lS/YsOJchE8zq8251YUq4/JnKywsvr3iQkvBF1FwLq2Rb2Rw3aHcJMtFKLlUM
 wmkrhgPrjbnu81Uj8Qam7vSjkkhSoOny2ttClLgq0labqgrEOnQUrT4JNF6Ocbouvj7uJ9XOd
 6jYIReh5RxlA56gZKkUNfhjk7AIugMvl9+lSAmZBEkQwRbTjeBEGqTqSWGSpnL670qgnYFnpz
 bOmTDxkHt5BQ4ofMiTLYrJHc9U+n9VJYpzXMSUp50hV2ILQb582dielkcg4CghQ3M4Y9lnzFF
 PHAVWJRKiLzgqwwHvyqxQn1a8GMc1fuAYHFSFWMU6mDv9grFDDynyCY9+w9r8r2Pm9Zw6dYUb
 7c0V97SUa6UreE0UdY9blksvmWOhmVOQ8oUMvhW0UBZCAca+JQ1JDGkfg5BoGRMA1qCnMTahc
 gQhcKDYjY6Ipl3SkMJw1EuIqDXPNRc1Coj0BxckHbaZOGifimlp/kOgkORn5+zYKgoib7R+1I
 7phjRR50WMjAwJ+Kk2IzEDlObUTeq5nX+i/6zL2zsXMBWBCqqMA5xeYKLucKoXLuYDe2/mqpq
 kmXdVAVzxQcpGvAJL1C1taF61FS87pkmz7cVpF07dN/q8oTNlcDySuetnQTGySOPslexv0b
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
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
2.24.1


