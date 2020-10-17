Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB50C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:12:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA35820704
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVCEkciR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA35820704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTmx0-0005LG-VB
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmoH-0001vK-P3
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:03:49 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:46726)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmoG-0003kt-8Y
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:03:49 -0400
Received: by mail-wr1-x436.google.com with SMTP id n6so6529999wrm.13
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QVmCBzAijqIxVbHfMUmSPN/CpI6hZqRTxfcmVPbu0NA=;
 b=KVCEkciRTE7Jpa3bDmrfXZ/fBHouFmR5oJYG38COqNnNBEapA9epwsy0rUjWswoVYL
 e9YMWblt3k8VPQpZz6uSdVhzuxAcxuMjfhgBKvvSSGwOH2Wb5G01+T6nxWxTipPopDlu
 cNP+73uG1Hlwsho26PBRvlVXk8BCtgK4B2RAWFx0P3H7KqzHGZNtWwnfOeDdk5d0IfoG
 AHafDmTQazEMecfOwTa8gQM9XllRjYTfvBMaPxM7Ri3D2+WyJ6uos/cO9DSh0nF5wBzp
 tPAr3xEYFH5BaRWlOQqxOMJG/uBfecbF+ZHpb3HtIZ2BsCuBLQ+eCHoIbVT9H/qh4Nix
 9rJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=QVmCBzAijqIxVbHfMUmSPN/CpI6hZqRTxfcmVPbu0NA=;
 b=TpjDlSb3haemBKoxyfzZ4iuY+8979BvFOeJBCFtlb651C0s8rv3rXaDasvnNxjBkdH
 RY/kEUQu66aNpG0eJaYe8wwPB969+cT8nwZNn36DpZKxJ/Z/ljPEL1FXNJ9Fz54Jwpxq
 Ot3B3T9RKbIkeTdWlkHBHCXCADTK29NE9Dkfe9iV6GP+rcq52EyW27q0migNMvoPO9b3
 sJtXciuHY7WGhMN2R8vVauDBa8LAxol8/qF+CiH9VCzbgaWdJfyc0s7U2M5wu3jM516p
 kqunT8DMP321jR46rXl5NbMszTvAPwlcdChaTzxKrpmitUsGlQfAzRif12FUnPlfx+m1
 rIYA==
X-Gm-Message-State: AOAM531mF1yFQG6fCtywFRumOrsnFsK7o+VTD4PqM2Wjos8wJeofXR8p
 801yIDmraPIsKYhkrSQbT2lJ6HZ8V0Q=
X-Google-Smtp-Source: ABdhPJwkqIqa9dMANp6emE7laWWkLuj4iweTq0EA3lDHIX8v+ibZe5ZSK5KwjUqTxFZhzfUKIxZDwQ==
X-Received: by 2002:adf:e3cb:: with SMTP id k11mr10346246wrm.341.1602943426613; 
 Sat, 17 Oct 2020 07:03:46 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id g5sm7492870wmi.4.2020.10.17.07.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:03:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/44] target/mips/op_helper: Log unimplemented cache opcode
Date: Sat, 17 Oct 2020 16:02:12 +0200
Message-Id: <20201017140243.1078718-14-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
References: <20201017140243.1078718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paul Burton <paulburton@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In case the guest uses a cache opcode we are not expecting,
log it to give us a chance to notice it, in case we should
actually do something.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-Id: <20200813181527.22551-4-f4bug@amsat.org>
---
 target/mips/op_helper.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 2496d1dd718..0050d0616b6 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -1574,6 +1574,13 @@ void helper_msa_st_d(CPUMIPSState *env, uint32_t wd,
 void helper_cache(CPUMIPSState *env, target_ulong addr, uint32_t op)
 {
 #ifndef CONFIG_USER_ONLY
+    static const char *const type_name[] = {
+        "Primary Instruction",
+        "Primary Data or Unified Primary",
+        "Tertiary",
+        "Secondary"
+    };
+    uint32_t cache_type = extract32(op, 0, 2);
     uint32_t cache_operation = extract32(op, 2, 3);
     target_ulong index = addr & 0x1fffffff;
 
@@ -1592,6 +1599,8 @@ void helper_cache(CPUMIPSState *env, target_ulong addr, uint32_t op)
         /* no-op */
         break;
     default:
+        qemu_log_mask(LOG_UNIMP, "cache operation:%u (type: %s cache)\n",
+                      cache_operation, type_name[cache_type]);
         break;
     }
 #endif
-- 
2.26.2


