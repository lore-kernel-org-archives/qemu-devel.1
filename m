Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8641C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 09:34:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91190206A4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 09:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPBabW1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91190206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT0A4-0007ap-Kh
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 05:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zltjiangshi@gmail.com>) id 1jT08k-0005f6-V2
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:33:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <zltjiangshi@gmail.com>) id 1jT08j-0004xe-Q4
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:33:26 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:44830)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jT08j-0004xQ-Al
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:33:25 -0400
Received: by mail-pl1-x641.google.com with SMTP id h11so6783215plr.11
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 02:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=u4m6+vzCc96Nl5shiNMOZfZokMTmk6NsaXZkY+++sic=;
 b=rPBabW1ftrQUWf3qfHV2hIxDlUsctijINgX5iu+kZaT6tVzFuP6Nw82DNAHwzpTiCx
 FrAjnagFmn0lff7Y+6vaR99kKNI71t3cA2AE/i264sAoTwqw/BUeWEJklq0dphvnftiL
 fJGuL+h8jP7IqwjCgW1v7KB8eoF9Lt4bi6sOSmouSS3iRpglrXvzN0qeE0h0xye5Xx4C
 F6upK2Qd/cM+/Qb41Nuncm9SEjVF8tj3DJJZfX6U3OIdfF3P1FddX35Prlfa9Q4t1sy2
 2rZpSrWLDSmPm07zikcOj5Vhf7dQvFuXxVXsHCSlQvv9jSPdJgedDxb/LXjLHjvN5zXT
 Kv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=u4m6+vzCc96Nl5shiNMOZfZokMTmk6NsaXZkY+++sic=;
 b=C+LifyUAqA3Lb0T6MyOk5rTvOuKVXdQYgGcAOE3oT5q3ARYCjvnSYZQPJa0IFJZe6D
 EhSR6LBfCSV2wJ/iA+i24XbtnU4whq6RSHXGG1+qASfSPuBkt6VP0H2FYK1iU4vLfRWG
 RlNVyZIw9pqlV9o0F2RDnK6s6/QcPyNPaG+k0/wNvZ2oDmEEPY3shcMCRZz4+qkuzhNn
 ymiDe4fJ2ut0Zim7tAcC/eHuJY+p+Hz/5EVDrFqvLMvEcIwvwX//EqqBWRF1am5rJGkM
 gV2wb9Msp81kBRUCx4kc25mxw2sHCWZjm8nYMfUyEslW9sLNX0pIuRcZz9eETikDz9pL
 AWMw==
X-Gm-Message-State: AGi0Pua5ewhGiAtftbiPvIGpg0+R+qgV0xLuwJj4WvKIvTbcbD2PUZok
 aaz0iq2z9nGC6SASPpttl98=
X-Google-Smtp-Source: APiQypIivvHCFxMAYkisTIGAPvozCTq7JEX2v0veG01jZqGgIAKK/me3PIokxqggnZfa/UM42J18Dg==
X-Received: by 2002:a17:90a:f689:: with SMTP id
 cl9mr23517308pjb.43.1587980003481; 
 Mon, 27 Apr 2020 02:33:23 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id u9sm11333073pfn.197.2020.04.27.02.33.20
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 27 Apr 2020 02:33:22 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH for-5.1 1/7] configure: Add KVM target support for MIPS64
Date: Mon, 27 Apr 2020 17:33:09 +0800
Message-Id: <1587979995-17717-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Preparing for Loongson-3 virtualization, add KVM target support for
MIPS64 in configure script.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 23b5e93..7581e65 100755
--- a/configure
+++ b/configure
@@ -198,7 +198,7 @@ supported_kvm_target() {
         arm:arm | aarch64:aarch64 | \
         i386:i386 | i386:x86_64 | i386:x32 | \
         x86_64:i386 | x86_64:x86_64 | x86_64:x32 | \
-        mips:mips | mipsel:mips | \
+        mips:mips | mipsel:mips | mips64:mips | mips64el:mips | \
         ppc:ppc | ppc64:ppc | ppc:ppc64 | ppc64:ppc64 | ppc64:ppc64le | \
         s390x:s390x)
             return 0
-- 
2.7.0


