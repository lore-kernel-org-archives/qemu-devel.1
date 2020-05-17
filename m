Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19EEC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 11:03:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBA522070A
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 11:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2t9ayDx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA522070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaH4O-0005g0-Rb
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 07:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jaH3J-0005Dd-P4
 for qemu-devel@nongnu.org; Sun, 17 May 2020 07:01:53 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36432)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jaH3J-0008Qf-5P
 for qemu-devel@nongnu.org; Sun, 17 May 2020 07:01:53 -0400
Received: by mail-wm1-x344.google.com with SMTP id u188so7138388wmu.1
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 04:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1ma5SumKUNDEJVOb5KgJtWRxqkwLlG4JchYblVLKuoc=;
 b=f2t9ayDxpYcM2d+tpBwxfrQnGhW2JQfBA1xSuTBOCgAms+l0QQN+4aA3ypcjWesa9X
 x8uqXJQrLpnMZMU/5h01b83h3SSzEyfoEP/qGvn+qVvIkJcnd8A0jW5kRiFxsH1ivhf4
 1MRUXehJh3b+NvMNgpYUc9tE/+7XUrZ19/XrVK1lSiWm4icqcWgu3ur0uVmiUGs6OAio
 bikzCrwL0llqLtJSiSr3wJf8vCp7c6y2AR9MXS68IgZ6o7VbU3mHznlPifSiPxA+8XCq
 FMvmH0LEKcpB/KMQdDuyXZM7zUiluGJmZVFg/tX4MtRY1XAABAtXIKWLSyad2lbmtcub
 ZkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=1ma5SumKUNDEJVOb5KgJtWRxqkwLlG4JchYblVLKuoc=;
 b=jXY8wqVOYX+bW/z/6mL6/Ugiq0FIbe/NxQD4YVNfvUc4M1/bfw0JP3zKTmWSEFTeqY
 umUqPYGB1ZDHfwhp1Q3tq/hcPfLeqXBoiZHs0l0cTlbaywgYyfxZAn3SmMyBpo3zuvEv
 NfA3QxCS8/du0e18DhWXJT2FgaqW0Vf66S2ZbkgVvOTjzjYWBVYgjuwks5wkuJqCKde+
 HyqlhV9qFXCfw3T2+8dNcNIGQqHINFjkBTIc1OoAHo7QwXdW7SVg70RmFRh+v35Y6D8W
 uxmzjQ5ubQjXMPJ54AzO+aL9LDZV1n96io2Hhw5rv85fg3E+TVJe63m928YVVFcGFaG6
 1q+A==
X-Gm-Message-State: AOAM531oXl6XFTvzxmB4yh0SmvvWRwSIZVswk63Ke1Gde3s0k2tVe5lw
 0F8hhium9PztO8Xrnwnl6nF+Sibe8mo=
X-Google-Smtp-Source: ABdhPJz1lo3uM5NkD7qDzn6Y/1/p17V4YfYImUd7pAvbCbB8sYpsTyGJPvWkTwaWTzdW34QKkuxQMQ==
X-Received: by 2002:a1c:32c5:: with SMTP id y188mr14794773wmy.16.1589713311511; 
 Sun, 17 May 2020 04:01:51 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id q17sm12149608wmk.36.2020.05.17.04.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2020 04:01:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/i386: Fix OUTL debug output
Date: Sun, 17 May 2020 13:01:47 +0200
Message-Id: <20200517110147.26026-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix OUTL instructions incorrectly displayed as OUTW.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/i386/misc_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/misc_helper.c b/target/i386/misc_helper.c
index 7d61221024..b6b1d41b14 100644
--- a/target/i386/misc_helper.c
+++ b/target/i386/misc_helper.c
@@ -70,7 +70,7 @@ target_ulong helper_inw(CPUX86State *env, uint32_t port)
 void helper_outl(CPUX86State *env, uint32_t port, uint32_t data)
 {
 #ifdef CONFIG_USER_ONLY
-    fprintf(stderr, "outw: port=0x%04x, data=%08x\n", port, data);
+    fprintf(stderr, "outl: port=0x%04x, data=%08x\n", port, data);
 #else
     address_space_stl(&address_space_io, port, data,
                       cpu_get_mem_attrs(env), NULL);
-- 
2.21.3


