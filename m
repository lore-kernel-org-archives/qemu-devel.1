Return-Path: <SRS0=KEGy=6R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A1EC28CBC
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 10:14:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D33B320721
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 10:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rf7sJ7XI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D33B320721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVBdj-0005AK-0B
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 06:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1jVBcf-0003Vp-EU
 for qemu-devel@nongnu.org; Sun, 03 May 2020 06:13:21 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:41078)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1jVBce-0002CY-Oo
 for qemu-devel@nongnu.org; Sun, 03 May 2020 06:13:21 -0400
Received: by mail-pl1-x641.google.com with SMTP id x6so907368plv.8
 for <qemu-devel@nongnu.org>; Sun, 03 May 2020 03:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6VYOsM5gqxnJ8Fj9mA3NrZhEPwkpUDOyTXJ2jtRSCA0=;
 b=Rf7sJ7XI6zpCzY+HQMRsyEv2lI3WZ8+8eo9hy+ptXjRGPt+YebdFZQRJ5ry6SoVgM8
 /8MbopWe/+nXPJDYzlVmArZdMCkDoTm43KeOpldKhpQxryMo3BJ1lSNOhUerzUsiFqTt
 h/X1vi9Uu8zO+2jKk9j8gPErpaR4ytjGiWc0ZwT4ImfmsJX6Hg9dqjqXReAoNURBXUsY
 FcljPVvLbndpc/VTLEg/DotlC8+7y0Jkf0ENs9J5TpKAwsJgOykW6ieAyeSBvglOuMCV
 Alk/d4ToOZOeOca4jRiNf643DDCxUAGLD81aE+6uDoOoSm+il+AM1XScT2ZMLMzIHB3f
 sXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=6VYOsM5gqxnJ8Fj9mA3NrZhEPwkpUDOyTXJ2jtRSCA0=;
 b=Hn25Ud9HI+ABdXxjswiYWk4CWMsokX78+Tem3jE56Pz6jlSZnaANiNTv8X/aajDdnG
 v4ppCwp1HxF+ErX9npoFg+I3O84A36+iO8nA5gqOqbJD5JhehYIOcKAah6d+sipX0wzp
 2lhNl7yCcoCqX4wKxl6JNjihNFZajYeFmG3Ez97W9R/pdFyj9M68jZ6Hw9djqxbgsg/W
 Ehz/BhwQ5WILGtGKxrFKh3VlPkHqrQKdxqA0GhtTtzzL9AajPowHxQQieHaJkC46O4kn
 wYqpJTyKJFOU9znOVOTa0odGf9Tw898iw2+RN69GLEwFXWS1RIBx3GAld2TX9KFCTipf
 fmcw==
X-Gm-Message-State: AGi0PuamwjN4lKJBddqdL2UNXyPFOmIQp55BSmCrELTS5nZpcf7q/AQi
 QI9IBRnxiVSxVelj6Exqcfg=
X-Google-Smtp-Source: APiQypKPgjvr2AJSyhutZpYUjv1iT5TowbTMwqWb9qVE78OIwXS0rIgS0FYUofmvX2ixJVRr6RywoA==
X-Received: by 2002:a17:902:fe09:: with SMTP id
 g9mr12648228plj.65.1588500799612; 
 Sun, 03 May 2020 03:13:19 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id r26sm6329902pfq.75.2020.05.03.03.13.16
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 03 May 2020 03:13:19 -0700 (PDT)
From: Huacai Chen <chenhc@lemote.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH V3 08/14] KVM: MIPS: Let indexed cacheops cause guest exit on
 Loongson-3
Date: Sun,  3 May 2020 18:06:01 +0800
Message-Id: <1588500367-1056-9-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1588500367-1056-1-git-send-email-chenhc@lemote.com>
References: <1588500367-1056-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=chenhuacai@gmail.com; helo=mail-pl1-x641.google.com
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
Cc: kvm@vger.kernel.org, Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Fuxin Zhang <zhangfx@lemote.com>, Huacai Chen <chenhc@lemote.com>,
 linux-mips@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Loongson-3's indexed cache operations need a node-id in the address,
but in KVM guest the node-id may be incorrect. So, let indexed cache
operations cause guest exit on Loongson-3.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/kvm/vz.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kvm/vz.c b/arch/mips/kvm/vz.c
index f9fbbc16..ab320f0 100644
--- a/arch/mips/kvm/vz.c
+++ b/arch/mips/kvm/vz.c
@@ -2853,8 +2853,12 @@ static int kvm_vz_hardware_enable(void)
 	write_c0_guestctl0(MIPS_GCTL0_CP0 |
 			   (MIPS_GCTL0_AT_GUEST << MIPS_GCTL0_AT_SHIFT) |
 			   MIPS_GCTL0_CG | MIPS_GCTL0_CF);
-	if (cpu_has_guestctl0ext)
-		set_c0_guestctl0ext(MIPS_GCTL0EXT_CGI);
+	if (cpu_has_guestctl0ext) {
+		if (current_cpu_type() != CPU_LOONGSON64)
+			set_c0_guestctl0ext(MIPS_GCTL0EXT_CGI);
+		else
+			clear_c0_guestctl0ext(MIPS_GCTL0EXT_CGI);
+	}
 
 	if (cpu_has_guestid) {
 		write_c0_guestctl1(0);
-- 
2.7.0


