Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79BFC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:35:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBF08205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:35:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBF08205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44419 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDteD-0006K6-SX
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jDsPb-0007tM-Bw
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jDsPa-0007s4-7t
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:19 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:33411)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jDsPZ-0007h1-Ux
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:18 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MFsAJ-1j5L2S47DT-00HMNE; Mon, 16 Mar 2020 17:16:12 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 07/38] linux-user: do prlimit selectively
Date: Mon, 16 Mar 2020 17:15:19 +0100
Message-Id: <20200316161550.336150-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200316161550.336150-1-laurent@vivier.eu>
References: <20200316161550.336150-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PBvRvwT8h/gVXiyEcQJBP5qz+jzTQEtBS5Fi6ReNXn+45syBlAj
 LxsfdQruf8t3dzaOlLpXeIhOWBrtOAenFSBx6fHETRPPjDFzq5BSfxBLwlf8qb3mjWMYDPt
 t6Yod1auUmYteNv/2e/gaV/ipEBsxHcjwV8uMrEAyssRIz+rVzs534C6eGfsWpU9ih07qag
 c9Eln2yhWhMPjO3y/3UPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vnsAgJ3LydU=:PXeKqieMVLroyuytlHb04G
 J4cn9QB+6d10XqeEebvAvtl8OgrhsvnfjKS82RGecIh1xbfGusQKyAVLhtrH2y1/x04REDHY1
 zZXdOut1II6B2iYgMM1oeKpCUVzHCQzb6zYwiibTLo3kNgOPHKFrVdhNKsJG1WrjFXVxuFlYl
 mjHVnjo7t80P6me7XdX178qKCdOOVKc1yJqdLaC203MlBrVPPs8ETQ6A+qGss3Yo1U+r9bbOS
 nKLt5Sn4Xt3KF3oQjkkCxO4vOs9AqU1Uze7GpqICjZY6bPcITsi4yu6huiR8AulM6E8fEAEin
 BQBx4qHte3JTB/7NXPfN8AdDdhvYbF2UmEaAFaUdLgD2N7Q17QZ/cOu9iLnZQKPi63cn0Ti1Y
 n4nsnyCVS0/qmO5QDlWdVKGjkAw9u10ipWSI7ooSMy/1KDOEQVbrYsr7GfG815beC23DWjoKx
 TNs3Ej4ye04ertqxkv0Jtw1Mi8V7bDmeugNZTA2DTp9oZdGCUq+0CFCqUDMI9agJYmLkS5EFr
 CTHEmSymWHQcdInDW6s+HD/tLIisPD5aCH3YbFmF2HX579iNWMQ3USFvcSJrrJIQUEFAN/M6x
 B9OuL+60zqxMJLAzYyglDuhfTppLysxRkbIN8qa9WkQqaH5ioIMolng/AVevsX+hlS8sVa2ZT
 bg9SeUUsjK5x6DWS6/10tFiZnJgUwpbzpjM/lpPxUd3W/4gk4/xfjiG2YS6c0grAc3t4OXiFT
 3v910QnlGYXil7qxj6HU8Uwr4JEXMPqBy5uuckB4OqspLDtmMdGMzbZqr04SVYkuZSQ7u3ZU9
 F13cbcyDeMq6B+CU5G4xj835qNeSaC+VPORvhuEtt5ImScGoD7jBq4/WquhqpFoUb9Pgj3Y
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
 Tobias Koch <tobias.koch@nonterra.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tobias Koch <tobias.koch@nonterra.com>

Analogous to what commit 5dfa88f7 did for setrlimit, this commit
selectively ignores limits for memory-related resources in prlimit64
calls. This is to prevent too restrictive limits from causing QEMU
itself to malfunction.

Signed-off-by: Tobias Koch <tobias.koch@nonterra.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200305202400.27574-1-tobias.koch@nonterra.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 811495c3a0bc..be676c3a4fb4 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11904,7 +11904,10 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         struct target_rlimit64 *target_rnew, *target_rold;
         struct host_rlimit64 rnew, rold, *rnewp = 0;
         int resource = target_to_host_resource(arg2);
-        if (arg3) {
+
+        if (arg3 && (resource != RLIMIT_AS &&
+                     resource != RLIMIT_DATA &&
+                     resource != RLIMIT_STACK)) {
             if (!lock_user_struct(VERIFY_READ, target_rnew, arg3, 1)) {
                 return -TARGET_EFAULT;
             }
-- 
2.24.1


