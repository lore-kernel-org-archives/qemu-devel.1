Return-Path: <SRS0=KEGy=6R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85F1C28CBC
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 10:24:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81D5620721
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 10:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6VJgQGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D5620721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVBn2-0000xk-Ou
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 06:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jVBmC-0008Tn-Uf
 for qemu-devel@nongnu.org; Sun, 03 May 2020 06:23:12 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35061)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jVBmB-0006nd-Tl
 for qemu-devel@nongnu.org; Sun, 03 May 2020 06:23:12 -0400
Received: by mail-pg1-x542.google.com with SMTP id t11so7102881pgg.2
 for <qemu-devel@nongnu.org>; Sun, 03 May 2020 03:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=u4m6+vzCc96Nl5shiNMOZfZokMTmk6NsaXZkY+++sic=;
 b=B6VJgQGRrWffj4p7+VWlBqAahNMIXo7SUgev/uGwzHH1SKvtVWjmeDIk8j4AWYoMB/
 yfd8SoKdo54kyxoIMBNNIEcmnyo+RhWMBuRsWTlUlGqbguFRUfPs3rIOfEX/Yb2f+Iyw
 XHnp26xH4c3GsB7tYXhrxs1J3DFxwprbmBLP51BJv0NXsmdP4Vv1S1QIbA0J88ByzOoS
 k9D0S5xdw4P/9DGNfDjAlxaga718ezrF4y9b6EvoGj4rPeEfNbJ2c6oKNYkWVhFKeFt8
 ASxn8X0yddaoDpYF1IqGMHTtCGIeV15B+n5/wndawgVSr6J0OciaLtLD0qAxl1g5G/e8
 P/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=u4m6+vzCc96Nl5shiNMOZfZokMTmk6NsaXZkY+++sic=;
 b=E3qvfgKfGFKtsJkokWil4vdRe7/tvI9Jpicon01zsOqf+03RUQ5rtM0Nq03F32Tnya
 ciu3hK6mcBabhV/BbJImxHzF4NvkRI+fGaEOBYIGSE51d+0LuZ/88TsPn5jtoajz6aVh
 8FYd7n5Dob33W4PgzvlGOalAFgE5w+HjSWw2cP705uRZ0lOn135NrtM502okhh7re/RV
 90K6i10Zo2oU5fLQckcVf24JSN9tQn5LO1uZpK9ZNeymc018jQkmuDcicWraxdTsSgTU
 GsCi5nYU1ESMwuHDVd6Or+jzoRTtLgeJbhtdtBY6TUCmbk1n0g2wX5e+CIapWI6tT0St
 8dyw==
X-Gm-Message-State: AGi0PuarHHtv663yJHW619KnNvGrXG8qLju6hZn3fgzecBq48XRIrLk7
 x8MqIFkPWCUvx1iF9REscX4=
X-Google-Smtp-Source: APiQypINM0ufJVBvsbWdiq2pw6kqawELVz9SsMoajPGAv/JgHLc9s/4waKga7ZjKPTJ/l+fEgz868g==
X-Received: by 2002:aa7:9093:: with SMTP id i19mr11979562pfa.152.1588501390074; 
 Sun, 03 May 2020 03:23:10 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id a12sm6173654pfr.28.2020.05.03.03.23.07
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 03 May 2020 03:23:09 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH for-5.1 V3 1/7] configure: Add KVM target support for MIPS64
Date: Sun,  3 May 2020 18:20:15 +0800
Message-Id: <1588501221-1205-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1588501221-1205-1-git-send-email-chenhc@lemote.com>
References: <1588501221-1205-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pg1-x542.google.com
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
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


