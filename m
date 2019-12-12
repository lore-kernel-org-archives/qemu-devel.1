Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9808DC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 23:16:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ADAC21556
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 23:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEEc8iAn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ADAC21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifXhU-00046p-JI
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 18:16:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcmvbkbc@gmail.com>) id 1ifXgX-0003do-L2
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 18:15:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcmvbkbc@gmail.com>) id 1ifXgW-0003ew-4M
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 18:15:53 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:45377)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1ifXgV-0003dh-Sl
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 18:15:52 -0500
Received: by mail-lj1-x242.google.com with SMTP id d20so496659ljc.12
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 15:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lmVYUN8ZhqaCMZ9YG1JlcS29l66frHCIrNzkl+VlQfw=;
 b=ZEEc8iAn7beYGWde+8OxYhzREBNGf3JXWqspqIbEPVmM29S86JFMQSng3F0I8XOP2d
 p0+1VzUu3EAJ9IzGmq8Uzvjpwgjp6BgYZlyhRyC7lIDMyb1W3/giG5/u9LGcz4igID5s
 VNzDNsKHbIVIN7f/9SxdVHAZVgmy/OgRGDgZhGgg8Axc6kQSbOEOPKhGeVYqzE2+uZrx
 BFLYfdpIhVHGojarG9v1VLUOAVM/77nTbKV2Llj0QX98Z29O/CzmzthA9ztRPIg/WJ25
 Ssy/QTBzxZwYA4rFFz/89YhorwpKqx1dnbbCO0lpjvj0JsYlt+C27o7wNA83iLuWyfJh
 YQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lmVYUN8ZhqaCMZ9YG1JlcS29l66frHCIrNzkl+VlQfw=;
 b=M4S0SP6CCHl4SIErt+xqfS1Xhff7/yqkA+T70+yP9olSv4G4WcyANr0QSyTf78EDQX
 /pVvHiQtUzClOUAf5aHlZevfFurDKEQ4EmzKCqFXVq5biQhk2LA7ej6Qjwxb19EKjOMf
 EP8eGV5Na7pqr2PbvQvPfXrxPrkCfCfo3Eoo7Hw1abZUdZhjI3jrUhDr2M8PtzaNkY43
 L2/ey6hEUd8ooH2mvau5yvSpDcO9gEH/guLwXIKSXxJ5by+yES3QqC4tSryJpgf1Dbfn
 5etPyhGWsWWaRFKGmsxE4rq6KO1LY1nufP3AftRvGwFW/PgA6FqIaV95NdannsY73wbP
 5v1g==
X-Gm-Message-State: APjAAAUit7F6agu/a5Y/5E0QvIladCRzStDCXVU4JKevRVnugoPvtrfn
 RP0Ddkm3GqK39oKDIG0DPbmnsNrB
X-Google-Smtp-Source: APXvYqwl69VI7EXFO2EV+HlsAKjbOV5rwvbyrPTW0EEvX1i6AzUy7ENjeKZ63vT7Qa1lODXN9I5/aA==
X-Received: by 2002:a2e:3a12:: with SMTP id h18mr7626332lja.81.1576192550179; 
 Thu, 12 Dec 2019 15:15:50 -0800 (PST)
Received: from octofox.cadence.com
 (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
 by smtp.gmail.com with ESMTPSA id x12sm3771705ljd.92.2019.12.12.15.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2019 15:15:49 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/xtensa: fix ps.ring use in MPU configs
Date: Thu, 12 Dec 2019 15:15:37 -0800
Message-Id: <20191212231537.2766-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow ps.ring modification by wsr.ps/xsr.ps and use ps.ring value in
xtensa_get_[c]ring on configurations with MPU.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h       | 10 +++++++---
 target/xtensa/translate.c |  3 ++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index b363ffcf1066..75e65df59704 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -645,7 +645,9 @@ static inline int xtensa_get_cintlevel(const CPUXtensaState *env)
 
 static inline int xtensa_get_ring(const CPUXtensaState *env)
 {
-    if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
+    if (xtensa_option_bits_enabled(env->config,
+                                   XTENSA_OPTION_BIT(XTENSA_OPTION_MMU) |
+                                   XTENSA_OPTION_BIT(XTENSA_OPTION_MPU))) {
         return (env->sregs[PS] & PS_RING) >> PS_RING_SHIFT;
     } else {
         return 0;
@@ -654,8 +656,10 @@ static inline int xtensa_get_ring(const CPUXtensaState *env)
 
 static inline int xtensa_get_cring(const CPUXtensaState *env)
 {
-    if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU) &&
-            (env->sregs[PS] & PS_EXCM) == 0) {
+    if (xtensa_option_bits_enabled(env->config,
+                                   XTENSA_OPTION_BIT(XTENSA_OPTION_MMU) |
+                                   XTENSA_OPTION_BIT(XTENSA_OPTION_MPU)) &&
+        (env->sregs[PS] & PS_EXCM) == 0) {
         return (env->sregs[PS] & PS_RING) >> PS_RING_SHIFT;
     } else {
         return 0;
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 4a14fdb3f1db..159bbd404885 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -2713,7 +2713,8 @@ static void translate_wsr_ps(DisasContext *dc, const OpcodeArg arg[],
     uint32_t mask = PS_WOE | PS_CALLINC | PS_OWB |
         PS_UM | PS_EXCM | PS_INTLEVEL;
 
-    if (option_enabled(dc, XTENSA_OPTION_MMU)) {
+    if (option_enabled(dc, XTENSA_OPTION_MMU) ||
+        option_enabled(dc, XTENSA_OPTION_MPU)) {
         mask |= PS_RING;
     }
     tcg_gen_andi_i32(cpu_SR[par[0]], arg[0].in, mask);
-- 
2.20.1


