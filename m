Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B2FC433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 18:16:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AF7520791
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 18:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKVongum"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF7520791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6HmV-000870-AZ
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 14:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6HlG-0006rc-6B
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 14:15:34 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55355)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6HlE-0005yB-Oc
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 14:15:33 -0400
Received: by mail-wm1-x341.google.com with SMTP id 9so5459600wmj.5
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 11:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=j9GDX3AzwLrTPKd/a6Iu2AywVyzyfLUmvNotg0xMMvE=;
 b=WKVongumjoDoIZpKQhX8WJK7uhKPsqnaxmFpoT8NEHcyE/DQhsNxEJB1vIOnE48HpX
 lBdd5xADH8xkqSFf9xd2GN2LF6kSTON7aY9ow3d28D8l4RT9MaoVjM2aO5eSaZx2CurA
 XlNUVFfKmBBLfJdN50oslxkJMRUPr/cLxl1Kx70bR2X4EIBexEdtQMd/iqXrrER1bVo2
 FQjFRJKFa9QDkR++WSBG35lVfxACEeau2nivSOvCyapy8687SEiZy+qIibZmuKvNTVlA
 QgTHv57U8/YnQ1kfYwn5k1lvFE7DH29QBbc8DQQVoSyGTJzfbDeSWxONDZMKke9sszKQ
 FCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=j9GDX3AzwLrTPKd/a6Iu2AywVyzyfLUmvNotg0xMMvE=;
 b=j5XM4cmK5oW467G3yDhelHaoGugKlofZ/KQEqTVaHJkA7kQu4sNo1AoFyupVFHBsls
 OcA4oQbrsIlkrj5EtcDeI7EIYWkdkae0DJsY3G54mCaepR5lgdkP6alYOV/xK5/y7bwa
 V+taY/mgmEzijdjtW8nKXnIGzs0tUk4oVRWDeoepiMPsenbLd6JwE5jx8NflE0tN8TPi
 VAcxepSZMeYAPAkQ/8xCNcpYOZjo5OkornUtln8/hX5kBCogD9EyFPGToNSCpzb+Qz7h
 x3Tq1EFuoljwcTszvRYuKKOXwj80tDRTpepsurwY1yY5SlCeCl0f8RHT2ajTYygZhUI3
 NjTA==
X-Gm-Message-State: AOAM5303ztqDLf1ekTizGd9LR+KaehAc3ywGH5I5Ucawi1+THvnizLb5
 RT9gkDndsHGnuSmKgxU2cH6EPAPG
X-Google-Smtp-Source: ABdhPJzumBfUyBxOxYCs/Hqe0JrWt3d932pQ57FnBmhPnhuKd3I9dLCssB8fe090vgTqLAqfjCSDpQ==
X-Received: by 2002:a1c:8195:: with SMTP id c143mr5574166wmd.85.1597342531035; 
 Thu, 13 Aug 2020 11:15:31 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id h14sm10039926wml.30.2020.08.13.11.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2020 11:15:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 1/3] target/mips/op_helper: Convert multiple if() to
 switch case
Date: Thu, 13 Aug 2020 20:15:25 +0200
Message-Id: <20200813181527.22551-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200813181527.22551-1-f4bug@amsat.org>
References: <20200813181527.22551-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The cache operation is encoded in bits [20:18] of the instruction.
The 'op' argument of helper_cache() contains the bits [20:16].
Extract the 3 bits and parse them using a switch case. This allow
us to handle multiple cache types (the cache type is encoded in
bits [17:16]).

Previously the if() block was only checking the D-Cache (Primary
Data or Unified Primary). Now we also handle the I-Cache (Primary
Instruction), S-Cache (Secondary) and T-Cache (Terciary).

Reported-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/op_helper.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 9552b280e0..92c399d8d4 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -1574,15 +1574,22 @@ void helper_msa_st_d(CPUMIPSState *env, uint32_t wd,
 void helper_cache(CPUMIPSState *env, target_ulong addr, uint32_t op)
 {
 #ifndef CONFIG_USER_ONLY
+    uint32_t cache_operation = extract32(op, 2, 3);
     target_ulong index = addr & 0x1fffffff;
-    if (op == 9) {
+
+    switch (cache_operation) {
+    case 0b010:
         /* Index Store Tag */
         memory_region_dispatch_write(env->itc_tag, index, env->CP0_TagLo,
                                      MO_64, MEMTXATTRS_UNSPECIFIED);
-    } else if (op == 5) {
+        break;
+    case 0b001:
         /* Index Load Tag */
         memory_region_dispatch_read(env->itc_tag, index, &env->CP0_TagLo,
                                     MO_64, MEMTXATTRS_UNSPECIFIED);
+        break;
+    default:
+        break;
     }
 #endif
 }
-- 
2.21.3


