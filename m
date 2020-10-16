Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415F6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 22:19:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7659C221EB
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 22:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIBF/OMk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7659C221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTY47-0008Eu-5U
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 18:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kTXxE-00038K-B3; Fri, 16 Oct 2020 18:12:07 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:45974)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kTXx4-0004HA-Ir; Fri, 16 Oct 2020 18:12:04 -0400
Received: by mail-lf1-x141.google.com with SMTP id r127so5002803lff.12;
 Fri, 16 Oct 2020 15:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+5eiH3n+bCt0Dpm1Jhk3VQr3ezZvJ5rxkkrpSjvz9lY=;
 b=FIBF/OMk0VuCk9kQ9mt+jkxJ7MJ3V8ufhbLOKlvnhzr4UuINDDeY551W/GVp2hepOh
 NmMshQUXujQv0IKQ3I6sXrikPnJ97Y7gIuHBB/FjKcR8jGoiwQJ2WA8Mc0OSgDjDP7zg
 hr9kqir0elvGi/iB6/eJmV2l1pugtHqyrvO1All13L0K2zi3lRjH2aCqxEMExjIh+EDY
 d0qz8i6IhF3d/gaUzmhxJDYkNxtEN65AQg6Wp9PzINFBEhEBtFF7H3I2g52bmAl7eraL
 shW46uqp4/fk8AAUxKlMXbk3uBCw/KRwWhaH06FNEt7NKHaIl2NXCzpDx2XpSEGR0aCF
 LDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+5eiH3n+bCt0Dpm1Jhk3VQr3ezZvJ5rxkkrpSjvz9lY=;
 b=A13t9wz76dPeTDWwlWoVnDUv48kZTfWAk+L+afKqgwgDk2SyyaTcR5G5bmZzWiIbJr
 uf6/EdyZVBrMhyJYB26/EZKwQ9DZiTVsL7FayAL071mmx63vZXqeM7xKuT7i1MhJFZ1j
 a2pyRnJxg7CecnjFIwGiTKO/m583WTkhTUxKlDdgReuYS6GtT+xRQ94gPaUDhoQQ3hD4
 s87hvS95zAmNOe+ruhhXI1Ch3jNrZqnFotfUZAXsgJVKHij2CEX7+K+dL+hQPsyVibbn
 hPMZJQPVYRoEQQBSEYPByNNq+NkvjokxoHDtXPuCC+iS/MWXAPdC7REnOP27NSkhSu3h
 9LmA==
X-Gm-Message-State: AOAM532QB2Zd4nHMWFQc2NaycR/ckf2ziVIW8V8005pdQRzsgJ4GrrMz
 J7u3GE2rgpvXzHZwL9Z3s5U=
X-Google-Smtp-Source: ABdhPJypn/jWwrxi9yUUqSxVwYsxhun1arEvEQLKE1wQ7wHS70l3ngkN2lmINdn9jwoRSyuQVKgDOw==
X-Received: by 2002:a19:8181:: with SMTP id c123mr2018996lfd.51.1602886308003; 
 Fri, 16 Oct 2020 15:11:48 -0700 (PDT)
Received: from neptune.lab ([46.39.229.194])
 by smtp.googlemail.com with ESMTPSA id d6sm1303010lja.63.2020.10.16.15.11.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 15:11:47 -0700 (PDT)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <space.monkey.delivers@gmail.com>
To: 
Subject: [PATCH v3 3/5] [RISCV_PM] Print new PM CSRs in QEMU logs
Date: Sat, 17 Oct 2020 01:11:35 +0300
Message-Id: <20201016221138.10371-4-space.monkey.delivers@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201016221138.10371-1-space.monkey.delivers@gmail.com>
References: <20201016221138.10371-1-space.monkey.delivers@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: baturo.alexey@gmail.com, qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, space.monkey.delivers@gmail.com,
 Alistair.Francis@wdc.com, kupokupokupopo@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexey Baturo <space.monkey.delivers@gmail.com>
---
 target/riscv/cpu.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d63031eb08..6ba3e98508 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -255,6 +255,25 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "htval ", env->htval);
         qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mtval2 ", env->mtval2);
     }
+    if (riscv_has_ext(env, RVJ)) {
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mmte    ", env->mmte);
+        switch (env->priv) {
+        case PRV_U:
+            qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "upmbase ", env->upmbase);
+            qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "upmmask ", env->upmmask);
+            break;
+        case PRV_S:
+            qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "spmbase ", env->spmbase);
+            qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "spmmask ", env->spmmask);
+            break;
+        case PRV_M:
+            qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mpmbase ", env->mpmbase);
+            qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mpmmask ", env->mpmmask);
+            break;
+        default:
+            assert(0 && "Unreachable");
+        }
+    }
 #endif
 
     for (i = 0; i < 32; i++) {
-- 
2.20.1


