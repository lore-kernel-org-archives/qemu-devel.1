Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB7BC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 09:28:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81EDD206D5
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 09:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFVd6Pon"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81EDD206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaFaV-0004Le-PE
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 05:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jaFX8-0004P3-4W
 for qemu-devel@nongnu.org; Sun, 17 May 2020 05:24:34 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:45701)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jaFX6-0001oe-8K
 for qemu-devel@nongnu.org; Sun, 17 May 2020 05:24:33 -0400
Received: by mail-lj1-x242.google.com with SMTP id h4so6610694ljg.12
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 02:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lJgCSZt5mHFIRGTCzDEMalJcIzhFOtdVx1BtWwULXEk=;
 b=CFVd6PontEqbELKqDoBl54WJWW4OQbfNagJQcckHI/21L/u8bRONARD9mvXjarXmjV
 AKHw2lTgPoOOU7eHTwU2Bn5AmvV5T9lcoTq3btOSxo5KO9F/7gGd8hVp8XDIKQ2kulIH
 +qMRPHTvQ/bjjkPm5vvEkZXa+jOHQ65frhZQuAKq/+WXGrN407+WiFso2CTZpf5srqlx
 Goo5vIeH74vsA0vXGd4cnV2Y05YCMBi2Dg0+F3wDISgXiESwSRFnnH8Qp2NbemucgFEC
 Sc6dyi4WoGA4Vhc/6ahkTGp+w9L/uwicQMKEtBifVDW8btD+DjC7kLzG4o4NChVlbn5t
 xWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lJgCSZt5mHFIRGTCzDEMalJcIzhFOtdVx1BtWwULXEk=;
 b=h1Yiccp7sdP6AclTiNClBQGxVVuviqGAvJROr1G4aTKwf5fLvvS1NnEDCoqftG1yA2
 yBge5mW5zzhu5Fabv8a3StG9Qn/kAbIsuRRF1Dz+6bCUvQgt7kbEsNt4igml9gufQTaw
 e/cX+2JqZFxAG3gfhLsooQw7u3N1UK5cSlu8D5KWPACQmVaLg7PqNZW81jO8X5vJcDu7
 j6BxgKJSEsTsO81+/aq7pzLHxjV5zodQ76wOjtvKU3l+JKXSh5PfgaU80NyjdTC7Oogc
 bvsnYgWQPAs0ATTHHEmR/S8IXpRP8c2foKnV69qz/66CATaYX5GIqic3BvNzITMdxAkI
 BxEA==
X-Gm-Message-State: AOAM531Zt9NpX33gLn/Pz83JmoP6u5bb2ueC4U8DEyNfZDGARUFlGPg0
 aMTfFvImyjBRy34Iy5JQ2HpZS2KPhg4=
X-Google-Smtp-Source: ABdhPJynvweKo6U5WCEqyUyMF7v/nFgPHCguvsG4XJZqM0HD8SgStioq8hYsvj79cW4njkcAusHzRA==
X-Received: by 2002:a2e:3e15:: with SMTP id l21mr6044098lja.250.1589707470723; 
 Sun, 17 May 2020 02:24:30 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id l2sm3872138ljg.89.2020.05.17.02.24.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2020 02:24:30 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 14/19] target/mips: fpu: Remove now unused FLOAT_RINT macro
Date: Sun, 17 May 2020 11:23:52 +0200
Message-Id: <20200517092357.1469-15-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200517092357.1469-1-aleksandar.qemu.devel@gmail.com>
References: <20200517092357.1469-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.rikalo@syrmia.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After demacroing RINT.<D|S>, this macro is not needed anymore.

Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index dae1331f23..56ba49104e 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1102,19 +1102,6 @@ uint64_t helper_float_rsqrt1_ps(CPUMIPSState *env, uint64_t fdt0)
     return ((uint64_t)fsth2 << 32) | fst2;
 }
 
-#define FLOAT_RINT(name, bits)                                              \
-uint ## bits ## _t helper_float_ ## name(CPUMIPSState *env,                 \
-                                         uint ## bits ## _t fs)             \
-{                                                                           \
-    uint ## bits ## _t fdret;                                               \
-                                                                            \
-    fdret = float ## bits ## _round_to_int(fs, &env->active_fpu.fp_status); \
-    update_fcr31(env, GETPC());                                             \
-    return fdret;                                                           \
-}
-
-#undef FLOAT_RINT
-
 uint64_t helper_float_rint_d(CPUMIPSState *env, uint64_t fs)
 {
     uint64_t fdret;
-- 
2.20.1


