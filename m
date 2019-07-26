Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C4CC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:03:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE16221842
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l2uVYsyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE16221842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4Yk-0001WM-PX
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 14:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59015)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4NV-0005Wz-Bc
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4NS-0000sh-0f
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:36 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:35667)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4NR-0000oE-Nu
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:33 -0400
Received: by mail-pf1-x42e.google.com with SMTP id u14so24878344pfn.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=wDt/gxXOEruKJVqZkyq92uFSMEbVcSh409biqimT4es=;
 b=l2uVYsyChcSlp0SE+aT5EmxpknN6lP8vdMTXyOHaOGtOP3IPv5s0hGhJ6fer3Yjtir
 CYMcjPuWSPL4/wiznTn2JlwZTedJHqywSb5VzPcfPzF80R23aoySf4wYC7L9xcfjZw4E
 C5xFPl7y+htqkPEKndGiu5Nr/gJNrm2HAuHM8ULNYzAlfmn7knmZhKFfs3t1YkEhXSzA
 t56/NTjFzKtl8/bel1g0TCPFZ145TchN6kJKVv9sJwq+FJoNv9/KrYJ3I1IQ5qU+2JnN
 n/vDamCocGRuScJGVsvYQ7EFh6d1YhRDR0v4AuOHGB7/foJhz+YwKJYgzhYcrMMTFGgW
 bDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=wDt/gxXOEruKJVqZkyq92uFSMEbVcSh409biqimT4es=;
 b=iSO0kMundiFqzqY/8Y1rK2GJm/O1ukvlPSdfBsLwqP2cpFg+/0dLsOjdau+XWoBUc8
 ggBN6dF7MNknQl6LORrDAcWyAZyPy+/rGYcRwUIKBdlDojsjTj3vCx4oEUUUDqbW8H4m
 jkivzZ2b5m/1gElxdm9/hvzth8d8qC4kK0klXFsOUMywz/SFinQneNqJQqdMT20FBa0G
 TIsdzjI25Mr7nqgL2GAFemCrTQt3u90R/Oxncj5Hz9VZKdxg9MxogOxdvc7Wd0AOrTxt
 T8C9q5xAcTvZfN04vKtREAlPW7lsAAbldd9M+KU+OKDSmssyI0HGHBwWB1ij/2LkDfFw
 /mZQ==
X-Gm-Message-State: APjAAAWi2EmNz+sXCfevuTSRjl9vdinFEldONvkvjwire6drjQTQ6O/r
 6KZaKWdkrfeDF4JruTV808rPMr8n094=
X-Google-Smtp-Source: APXvYqyjh5D2v+wVrGKFmXKjS/apWCccoyAa5YCXvG2foKRxmp4v0bNuRxZ02+mvRVRJP0Cf+ZsGfg==
X-Received: by 2002:a63:b904:: with SMTP id z4mr90750276pge.388.1564163491483; 
 Fri, 26 Jul 2019 10:51:31 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.51.30
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:51:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:50:12 -0700
Message-Id: <20190726175032.6769-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42e
Subject: [Qemu-devel] [PATCH 47/67] target/arm: Convert T16 add pc/sp
 (immediate)
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 12 +-----------
 target/arm/t16.decode  |  7 +++++++
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 28f274ca7c..525276ed13 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10758,19 +10758,9 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
     case 7: /* load/store byte immediate offset, in decodetree */
     case 8: /* load/store halfword immediate offset, in decodetree */
     case 9: /* load/store from stack, in decodetree */
+    case 10: /* add PC/SP (immediate), in decodetree */
         goto illegal_op;
 
-    case 10:
-        /*
-         * 0b1010_xxxx_xxxx_xxxx
-         *  - Add PC/SP (immediate)
-         */
-        rd = (insn >> 8) & 7;
-        val = (insn & 0xff) * 4;
-        tmp = add_reg_for_lit(s, insn & (1 << 11) ? 13 : 15, val);
-        store_reg(s, rd, tmp);
-        break;
-
     case 11:
         /* misc */
         op = (insn >> 8) & 0xf;
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index 797e4e7068..568656ecd6 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -23,6 +23,7 @@
 &s_rrr_shr       !extern s rn rd rm rs shty
 &s_rri_rot       !extern s rn rd imm rot
 &s_rrrr          !extern s rd rn rm ra
+&ri              !extern rd imm
 &ldst_rr         !extern p w u rn rt rm shimm shtype
 &ldst_ri         !extern p w u rn rt imm
 
@@ -102,3 +103,9 @@ LDRH_ri         10001 ..... ... ...             @ldst_ri_2
 
 STR_ri          10010 ... ........              @ldst_spec_i rn=13
 LDR_ri          10011 ... ........              @ldst_spec_i rn=13
+
+# Add PC/SP (immediate)
+
+ADR             10100 rd:3 ........             imm=%imm8_0x4
+ADD_rri         10101 rd:3 ........ \
+                &s_rri_rot rn=13 s=0 rot=0 imm=%imm8_0x4  # SP
-- 
2.17.1


