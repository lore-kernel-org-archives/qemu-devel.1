Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D45CC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:13:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07DAE217F4
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07DAE217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSL7Q-0005Nc-37
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 08:13:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36505)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iSKzx-0003ZE-JQ
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iSKzw-0002zW-9w
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:21 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:54809)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iSKzv-0002xK-Vv
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:20 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N7iKo-1ho2SX3WhW-014kzH; Wed, 06 Nov 2019 14:05:08 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 02/13] scripts/qemu-binfmt-conf: Update for sparc64
Date: Wed,  6 Nov 2019 14:04:45 +0100
Message-Id: <20191106130456.6176-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191106130456.6176-1-laurent@vivier.eu>
References: <20191106130456.6176-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:29FaE8sJaX1qozk7sgHcC/zAlzd/QEjuyGuOCJjSD0qBg4hPMah
 L6ga9223uRSC/1JR96+W2yGjOq5ZLkswTE5s1frALs6BE6s8ZLe7MqbhEciI9O07cTcPC0e
 FsUldhk0pWFoctaVadxMpP31tWQLmeg2CjB7E2ZQXfQWvkjXPA3rfEt+CJKmDdqwK5x3SVH
 AjxS+t2ZNcgcysGQfnMCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DeOFobTDgto=:g7so14xaY974d6zD1lwhIY
 Bn5K9O06EP013HubIqxmopL7no3Vl+uafarvxkWerUkDeGpDEXgJ2BYn+f4a07HFH2H/tJr1f
 sU36CfSJJjXUf0Yzx5SleqBme8Amb3iMbM+3/grNjoZrVlCQ1nDZb1ZzBIJX9i8TS/u//vr0A
 udCvMPVJUbuPPFabduKBcKcUVtZ9ljL2LvN2mUcrp7ET65dzdAXqA8sIV+v09oCZpLujpKV7W
 ChiyXp5TwcxSroe8Ia2zTg82cP08/KQ37nwC7f/HJt/qw11v0cbvhfx1YFGbL+pHydsrS7CLA
 YWRPpUCp9OVLHrvHN75MrfBlOz/cLSvZR+o2/Z/Q7+tSdVMm352zjq7amHsFkF6YrKuowMxvA
 g1YyDrzGY5YWQk6GRSYksWwB78CQd2hwHUPrJW9aR35yMXv9NtvhPH0lb1lC3F1cRZ3aSxSmb
 MXGYVKrBomIpyuIjbt5uJKcEIvX/pgVPCfAI5pmCaid9ADnmhfgEew+/UX8ooT9x+zHRaQY3+
 vzjCGZG5FqOIb3Kmq98KGPR9FI/io1OFTV3HjPUmC1eOvNfAe7FZoI7xVM+UczkPne0HLYQfH
 rBcep3rYDAMvl90sbulVKwi1MqM7QLTbe1UyfWLp/gTi9IP8nqV7w/VeqBuJ44z46Pe4PZQeD
 e5ve8wpIq0bVRCizrN4A2J8Rclph09ZUjLZBXPt3sgEvgJ/9LCF7G8KsuvT4aTSadkr3dBkQn
 L8H9Y5vCfddgAq4/BNoFUvujULAJ4s9QEfuAF98oQqhz7g+/JhdfOCGCTgv21NS9UaNXeIN3o
 QnwB3tn4gpldltQdJwl8FRGtehhTzMWXdjeUAGt0q/yT3LwbAsI1j+/CWR/lS7BC8wz40PGvI
 DPaPNl2PzBzqFg9WBRBA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.135
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Also note that we were missing the qemu_target_list entry
for plain sparc; fix that at the same time.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20191106113318.10226-2-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 scripts/qemu-binfmt-conf.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index b5a16742a149..9f1580a91c7d 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -1,8 +1,8 @@
 #!/bin/sh
 # Enable automatic program execution by the kernel.
 
-qemu_target_list="i386 i486 alpha arm armeb sparc32plus ppc ppc64 ppc64le m68k \
-mips mipsel mipsn32 mipsn32el mips64 mips64el \
+qemu_target_list="i386 i486 alpha arm armeb sparc sparc32plus sparc64 \
+ppc ppc64 ppc64le m68k mips mipsel mipsn32 mipsn32el mips64 mips64el \
 sh4 sh4eb s390x aarch64 aarch64_be hppa riscv32 riscv64 xtensa xtensaeb \
 microblaze microblazeel or1k x86_64"
 
@@ -38,6 +38,10 @@ sparc32plus_magic='\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x
 sparc32plus_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
 sparc32plus_family=sparc
 
+sparc64_magic='\x7fELF\x02\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x2b'
+sparc64_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
+sparc64_family=sparc
+
 ppc_magic='\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x14'
 ppc_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
 ppc_family=ppc
-- 
2.21.0


