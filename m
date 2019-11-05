Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A9AC5DF62
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 18:15:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B557121882
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 18:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B557121882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS3MP-0002Kh-AI
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 13:15:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iS3Is-0005yB-D0
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:11:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iS3Iq-0004hb-VL
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:11:42 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:40125)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iS3Iq-0004gQ-Kz
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:11:40 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N3bGP-1hkDxE3pLP-010ZAo; Tue, 05 Nov 2019 19:11:28 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 02/13] scripts/qemu-binfmt-conf: Update for sparc64
Date: Tue,  5 Nov 2019 19:11:08 +0100
Message-Id: <20191105181119.26779-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191105181119.26779-1-laurent@vivier.eu>
References: <20191105181119.26779-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1hQ3nX100RX96hZx8enwA+ZvhdtzI9F57RrS11tUsa3lt4Yz66W
 VKv3/VM8xE/uqzid/UvN9KQVrLGkKqo3KUhkEtiP99gkU59U6rwUIdZLWEFLJ1RIEdLnt3O
 U4rTbxitotTfMijSd9uHZGdpRgDML6jzPiREE3fXEIC9pFVLE8kl0LBCadQA3PmKKCU1/an
 VFVVIMEfZdPwR/J5Bvv/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Bbflqga9EnM=:DG1o574tI/gXTnV795wlIf
 WP5SB6rU0ZfVkfFN8v07csNcyEHGjfrU+m52dI5L61zlJZNA+5jJh7icBw/Oj18qANR9F0ZXJ
 aTucdjbiPDfzYXEC6o32YXLCt7C4v7GSeqD3mI6KQj9hfvtS0JWO+cYuH9n47ttXGxmAd/LHr
 MgnXi6tuqseoZSmumRFTLrCMoyjio6EKbxvuiy1UyvU5hzkUxAVr/a3Wh1l0abRtsnicma9Zr
 9WHoxc/GYuJbAhtFvnXlkkeICp6srNNPYkKQIIvmVuErW/zWw2/upCqk4J5TSkJ/eKY2dk7IF
 HOvDYeglBLKEqDOs7gCAYwsENuWEalHZjWlW4s1VW0Q88Pe1yAK5Zl8BV4gw3MkEYAKIHdx27
 VVmxh4dxnmFCHKWdw5MUx9ePvqu0S76qs2Z+/T3XJOZOHUlP0llEwEQRbX6JyHzD5oBh/N8FW
 Yem7KcNCgCgfXWM0O0oSzodFOaXvgLAaMAuJw6piCpDQI3fRJXx3YTP3I6ZaPlFAMJbbo8Vaa
 pfE3iHAM7VZ0+svT399rhL2U212cswF3Zg+NTSKDLLsrxDNxXeKxy/NcJLSa9BwtImR3fTFPz
 L/mXL/AuaBi7FZeG9qU9Fs4bMa9lzo/eoogPv6MP6+vtjtVf33GDwpQ69ekGyLH6Y0ro0V0hS
 I9VM/C95R/BwwazgIAJr0TvTOiH6S4ClKERkXJ7eNJc+HIzNhPf7topW01pYCBD/pmKK5hFot
 7G99pVCig6cgrn3j1MQqfRKrPWHxSAteed1q0s3pi4FIt2RU5vIZO0zEsIDEPcPWl+93zoyca
 Q1i72N4XT7BoK2qnErYpgEpdQLjxWzjM9VpAlm+RafZTZZix7/0ECC2Pr1SxTGSmpBAelnqUi
 Ua92zgbyI+kAV+Msadng==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.10
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
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
Message-Id: <20191025113921.9412-2-richard.henderson@linaro.org>
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


