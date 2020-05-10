Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574CDC54E8D
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 21:05:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 231BA206F5
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 21:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBtQpJEI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 231BA206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXt8E-00043q-7K
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 17:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXt4s-00076L-Da
 for qemu-devel@nongnu.org; Sun, 10 May 2020 17:01:38 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:34440)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXt4r-00015X-QP
 for qemu-devel@nongnu.org; Sun, 10 May 2020 17:01:38 -0400
Received: by mail-ej1-x642.google.com with SMTP id s9so6209888eju.1
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 14:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=INiH/hiJ+WGtAmJUDmdS9OFn2OmFj310/NQ1BEXJmuM=;
 b=eBtQpJEI8y+EPVT4bZvJ612r7SrP/j8NZ7Wpj2Sej94Xm7r9qyPUMjQWuK1bkObWt+
 JeiS1LQEPxtmBOaqmHdT7ahxTUnN1Y9ujKs2J4KMuPio3xwBEPzo/bongGLfqO5fkgWQ
 JZ2ciQySh9UzaIzGXR2XCw96Qm1Kh+NEPSHxDGIgj/rzGIgYo0N0AKhYgjmsyms6r/vk
 +VwYrASuI7bXQgdBGpmXxfZNzw2KvKNAoKhGss8SIXuujHlt90Pfrbg4NK720+8f8kYJ
 kXbxbLdOZ6P6rOzYrRml322Zg7kR4U9MM4xD9y7Co7aXWkYaO6ORLG/F5r4VsuBhZSPY
 Q7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=INiH/hiJ+WGtAmJUDmdS9OFn2OmFj310/NQ1BEXJmuM=;
 b=cvZ/odkCMh1T39X4BBM5wpIXrpXhFLw8ZY1fgauGQWp6t7gzwMQjOv6YjD7m/4VXK2
 JyanLwtJZnlE0uKuwVZH2kqAcUxmiqjHQbW2ujiS2N+Y5AQuMRD5MJDP1+rWKZROVHt5
 MomZjJy4WHz59lTC93itZlbGgfVCELy2wlrpwMByuZX9OIQPR+KImcmEvbH0q6Jg+HBX
 6qYBgAGJfyb1PrXfBvu2Nm/+MTvp5l6oenRb7+zu1tMVriR8NrDJ9//UbqzKtg2cIC+/
 RnwA5lTg9/vtHHvMJycsmu/2G9YYNE+dkGfjDnQdEoJnm5yg01tKm1sW/g1Jzk4Psigy
 EFRg==
X-Gm-Message-State: AGi0PuYkCSzJrcZ+EO+No7EDpiiq3OATwfXiOYYYOtuEa8cU3CdhglBy
 V4hbsqQ0FB8qiNmT0vMf6qWr8ZgaVhs=
X-Google-Smtp-Source: APiQypIYFmVrFBhF4Mr4GGBHzBLgGzbzSybB5vkCOD8Wm5HPr79ytmmjYoHeLBL5r8QnQQCTrgzb4A==
X-Received: by 2002:a17:906:2b96:: with SMTP id
 m22mr10561807ejg.330.1589144496393; 
 Sun, 10 May 2020 14:01:36 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id d15sm921152ejr.50.2020.05.10.14.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2020 14:01:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/12] hw/mips/fuloong2e: Rename PMON BIOS name
Date: Sun, 10 May 2020 23:01:18 +0200
Message-Id: <20200510210128.18343-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200510210128.18343-1-f4bug@amsat.org>
References: <20200510210128.18343-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm not sure where 'pmon_fulong2e.bin' comes from. As I always
found this bios named 'pmon_2e.bin', rename the definition.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/mips_fulong2e.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index ef02d54b33..f067fa9720 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -69,7 +69,7 @@
  * 2, use "Bonito2edev" to replace "dir_corresponding_to_your_target_hardware"
  * in the "Compile Guide".
  */
-#define FULONG_BIOSNAME "pmon_fulong2e.bin"
+#define FULONG_BIOSNAME "pmon_2e.bin"
 
 /* PCI SLOT in fulong 2e */
 #define FULONG2E_VIA_SLOT        5
-- 
2.21.3


