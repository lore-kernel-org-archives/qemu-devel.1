Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D11C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:52:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCBED2084E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCBED2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUTmG-0004XV-VT
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 05:52:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iUTlM-0003id-Bg
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:51:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iUTlL-0002WH-6b
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:51:08 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:54397)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iUTlK-0002Ve-UD
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:51:07 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MNcYX-1iEsiV0Pb1-00P3wn; Tue, 12 Nov 2019 11:51:00 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user: fix missing break
Date: Tue, 12 Nov 2019 11:50:55 +0100
Message-Id: <20191112105055.32269-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:feQOa5mrAbJkb8xmIdg7mAdrMydTVb5ufSlSBYOxGMpDREW2WbB
 NuSeqzlfS53aHocRBRoTdG2moEVyHxEwZRbVgLA8zbLAwRmwTd8xj0Jv5ZFvHuypYm6bDZD
 2HBf4lPi3G2QodQWvLVitHGR8+ldn3mT3h3qa1LKCnU5pmckGfWujdHGQMLm7AsSZzeJYSD
 hdXNEnVdsTD7tl4Al7Kpw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x7XhYMi6zpg=:kfyeapW/d964Lohz2rcPHZ
 lPubeQUe75qTzEqV9htyTV2QYAWPYJFqZ68oHA3XeNzF4ML8919nIShpdukN29UdQ2/9oGWB2
 vJKZf1ZGhtAvyFEyudgboqEOuFltCVwYfpbf3aLs02a39l0AmUBrErwHVrbQNFpnxxdaBIVH+
 0IPol0yNiYbogh+O0IO+W6YXFM60xmlHujjAqnnqSo5D97AU4aFMR7gYDq5Iohl/RbV66aXd+
 oo6OY6Lxr4nqB9/h8LStug+lLdfhW40YwB8RNFV6Y50WsaGm7goqKoLTQghJ8fGQSVccLTXhu
 i/tkAW6YIo9oCJgIDPB6HdyI9nJ84vlR4oapJrGJUlAVdndACYp4kq5aTbWGvVqaboXy996E4
 EsJoqXUtxrAve71Sm2y7c3n5ntKi38GGyaMlalz6ilM3/ws5HeSIjBuDGixurm7595zoX/jgs
 s4xUJ5gmg696paIIeR7pVQqe9No4Y+G1ZvszruzeAX+yXfhnIUOilMbRxm51QoE54N+fefVIu
 z+h3k6350vNehHilcxUoWlFQifbj42C8sDTEfqYYXEaAr6GVCDiT3tgzc7qeZFvxo3PzE7bhW
 4a+q01P23160RdpZIt9HfP1Spb+Thr7U0X7RTA4QDR/8bI1tYeB6eXtYnEhJ+f9wXPqkpZ7Fb
 bb+VX7/1Rvky9HTGxolo3B5VxE/ppOAmawZX4T79RZqBwgzaCeFbDx15pBeqJQ0lNtxbz1mm8
 mrptW9dKd6mykEi4pmAuagjKAT2E3eMCg6mI13HmezzDJQCOcDjY0Mf4J6ndaZKd1c4rqiQwT
 0hQiy20dLI/UY/ZXSB1Ei5g7ZCkc+8gQ5lPAGjdGDhHRfkI+rZuZF2ixKVqoBm+7EEI8N4ZXz
 DttwNT8MxdlPVEioT7wg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.74
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
Cc: Josh Kunz <jkz@google.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reported by Coverity (CID 1407221)
Fixes: a2d866827bd8 ("linux-user: Support for NETLINK socket options")
cc: Josh Kunz <jkz@google.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ab9d933e53af..4e97bcf1e5a9 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2632,6 +2632,7 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
         default:
             goto unimplemented;
         }
+        break;
 #endif /* SOL_NETLINK */
     default:
     unimplemented:
-- 
2.21.0


