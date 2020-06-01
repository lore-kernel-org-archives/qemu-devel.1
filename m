Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB4EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:47:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE3D820679
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rdLFkJlm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3D820679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfjqG-0002J5-3s
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 08:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jfjmu-00069L-3S
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:43:35 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:42030)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jfjmt-00055s-C4
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:43:31 -0400
Received: by mail-wr1-x42f.google.com with SMTP id p5so5429960wrw.9
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 05:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=//oQPQNfOG3Cowa0+33C2vqPBy/QAFTT+RnBfWuuERs=;
 b=rdLFkJlmdO4KvA141V/SnaEgJwdxO0WwkFocYeZ8ATYV2xSlE8bCvL3RPD7+Ozw3s2
 EJzHmENaBIZXh7lKmBVpD3r3IBklAqNxLejsnWtIWb9RVc5hZE3bP6pMe7XIgDGgtMAJ
 eB6fTjK1msHpkvEuaGKqr5GFlfF49/86Hhpu7V1n8GZ2VUXCe1E86cGr8wyMjfMoIhoI
 qppPLcudlVhLoE/bGCnVRXTV88REOCIjQFL2CFsscOic91AE4I/Y69aOdK3PYEeuFRoE
 ey1ZHdfJx81BADZIBOQlPwejMp6ZWthXYJX/h/nbXbq2SfWuMqql4LHm0lFtp/sk6ex8
 ZEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=//oQPQNfOG3Cowa0+33C2vqPBy/QAFTT+RnBfWuuERs=;
 b=X7LLnUVfjSpzYyd0qiBjjYud8SxYiT1fL7iWrm4wyzRjwmnrcWtl09s//OmHzdPuUW
 EK84i9EqEFlyrGd2moHEgt/9HjJktZpU8X5HRy3K42xT2SJ7vJevRgt1hqSPlCaW36A3
 jrfK+VP55vZiW2dBqHTJHVEOQoQYDxHHucBmoEXns5PaaCUhUVeOrBZLX6vpMkHCShQC
 hV1yGmuqbqrS3t7lCGaI55V50ZsUseDjQ9aQZSVq8WdIcHuOje7m03QG2uujQVfCIvS6
 Tm37a3BTT++EuO6snFsARZQZI3bU9EOJJfpGixfxuq1+aSZaHcQ1EfHsaSeii46NbD5K
 /jtA==
X-Gm-Message-State: AOAM531YawV/r2qsLSJtECXdrB7tBK7DdsQEceKmqC4LcVVj5mIT+miB
 hf33R1TiPVD66wHePOy+b1OxYkyedss=
X-Google-Smtp-Source: ABdhPJwysEuReEscVqp5IvIQT6oVDbcodv/Xy+XNdKbmxxS2R+Sd+YgjvEYL8jvKAJJD5vvzlSwS0Q==
X-Received: by 2002:adf:dd06:: with SMTP id a6mr22554401wrm.142.1591015409998; 
 Mon, 01 Jun 2020 05:43:29 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id n23sm10948474wmc.0.2020.06.01.05.43.29
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jun 2020 05:43:29 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 5/6] target/mips: Support variable page size
Date: Mon,  1 Jun 2020 14:43:24 +0200
Message-Id: <1591015405-19651-6-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591015405-19651-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1591015405-19651-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: peter.maydell@linaro.org, aleksandar.qemu.devel@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Huacai Chen <chenhc@lemote.com>

Traditionally, MIPS use 4KB page size, but Loongson prefer 16KB page
size in system emulator. So, let's define TARGET_PAGE_BITS_VARY and
TARGET_PAGE_BITS_MIN to support variable page size.

Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <1586337380-25217-1-git-send-email-chenhc@lemote.com>
---
 target/mips/cpu-param.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/mips/cpu-param.h b/target/mips/cpu-param.h
index 308660d..9c4a6ea 100644
--- a/target/mips/cpu-param.h
+++ b/target/mips/cpu-param.h
@@ -23,7 +23,12 @@
 #  define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
 #endif
+#ifdef CONFIG_USER_ONLY
 #define TARGET_PAGE_BITS 12
+#else
+#define TARGET_PAGE_BITS_VARY
+#define TARGET_PAGE_BITS_MIN 12
+#endif
 #define NB_MMU_MODES 4
 
 #endif
-- 
2.7.4


