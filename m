Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D54C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:29:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A9782078A
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJUWdTFU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9782078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jni2u-0001qz-MN
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 08:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jnhpe-0003x7-KB
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 08:15:18 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:39169)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jnhpc-0005PK-VU
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 08:15:18 -0400
Received: by mail-pl1-x643.google.com with SMTP id s14so4958808plq.6
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 05:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=s86m9QR9XH2+L+0t/tALqLg6HeZ7JcYjE1HlQ17u9Fc=;
 b=OJUWdTFUn0kbKfBsfJJPxlwaG0BzENtk0MKs/cK1Tsu7JFoKknxlAfW7/obqg7L4Qo
 3qGkhpSEuoEjzdv4aWlZNpEqodeUBou0RpTEsFMjZ9VFtG2UF8udrjLyexDmmeJUPT+Z
 AK9EcihgkOm/spIJIexjFjvrP93psCXnDVhPIZ2MYYv97UTjz5UGZtDao1FD95BapiL/
 Z8FF/mXVUfYcLEAVnvJptk8dQoS9adNHb3E8dtztIupSxX6Lf8vboHKDJLVNL+T6LhH4
 fz5IJZGmUDRQ8TSnCuKcwhdqvAd8BoXYAfyA/KoiMQPs5HOPnt4SRdh36z4TdF8wMwY2
 12mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=s86m9QR9XH2+L+0t/tALqLg6HeZ7JcYjE1HlQ17u9Fc=;
 b=tDy2zQuAM9dSV3v1IdmxrhqdtLDtu6YfhQ4AA8n04diKgQ4g0WaFnJLz4IgXYEQ1SJ
 oMx22rUDQqrPGYCjGq38JJG03eAlLsTyI4QT1Tx4fmZhC9MlDnLbuN7NDT55v822Agc/
 3fyjOM7N8O9ShIY1Xv10jLCTftYlSH7DS/T5dxwUtfW/ky6WHQwdKzEvySYtcuiX89bY
 6hNINPAWC2pBqC28mfWP+LBCihe4C6EMuTVIo3DM1PdL0QRsf5JyD1/yk1NHNdbvm5D1
 pXqnGm96G9HZ24BnWGxcYbiDi47ZvYXMT208lgBQs6wlqH2MSSsmtXkQA3hp0dXZYyp0
 QsNA==
X-Gm-Message-State: AOAM533eN3o43+xjS6UILdRmbbQwb6FLgjAa44ZkqmLTduK1VhSQaUp6
 47LEkFyQutkCCdASBVBD820=
X-Google-Smtp-Source: ABdhPJzveoE9aRsBdPDRr91FEikh/DIscVv0kkU0MKJEkgygxtuST4A85TAy2zRPwH7f0Mlb+Xzasg==
X-Received: by 2002:a17:90a:e384:: with SMTP id
 b4mr21115965pjz.134.1592914515438; 
 Tue, 23 Jun 2020 05:15:15 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id m18sm17022782pfo.173.2020.06.23.05.15.12
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Jun 2020 05:15:14 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH for-5.1 V5 4/4] MAINTAINERS: Add Loongson-3 maintainer and
 reviewer
Date: Tue, 23 Jun 2020 20:13:58 +0800
Message-Id: <1592914438-30317-5-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1592914438-30317-1-git-send-email-chenhc@lemote.com>
References: <1592914438-30317-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add myself as a maintainer of Loongson-3 virtual platform, and also add
Jiaxun Yang as a reviewer.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f0cb1fd..293188e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1095,6 +1095,12 @@ F: hw/isa/vt82c686.c
 F: hw/pci-host/bonito.c
 F: include/hw/isa/vt82c686.h
 
+Loongson-3 Virtual Platform
+M: Huacai Chen <chenhc@lemote.com>
+R: Jiaxun Yang <jiaxun.yang@flygoat.com>
+S: Maintained
+F: hw/mips/loongson3_virt.c
+
 Boston
 M: Paul Burton <pburton@wavecomp.com>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
-- 
2.7.0


