Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BCDC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 16:51:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2A6120722
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 16:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYtQqsqo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A6120722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqJTi-0002p6-Om
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 12:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqJPh-0007HY-TO
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 12:47:19 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:46184)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqJPe-0007z6-0n
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 12:47:17 -0400
Received: by mail-ej1-x644.google.com with SMTP id p20so21301751ejd.13
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 09:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=haSXnoSPhrD17lX5ZndWujBCjWLu9wT1A4Vj0WAoOl4=;
 b=JYtQqsqooFHrOaEIe93LpGTq+BBiDtvar4jhcsiKaEATVqmrz1W1LJF65KbwIGQrzL
 YOpaTfvMHQoZhGD8oOQSSCpn86bPpvrDBYHsIjVXbgtTZ/Tj8aKXT5fPNt4Es+8AncCq
 oeUv7mvlHSTWE5zLzgw2ciXWXrJibEcKVhU/Zt9UXEZH2iSKQpoyPiSU9nLgZ/cHrzxo
 Pg7LukT0Tg3KsGSFCMAkLIismCptXFItXJvVqaQ74Kt4yjsmYmaSqQcGnYpsIFEBFgZ0
 wrBkWDAv92I518ObPfqKcOXMCoZb0/87Jb4iywJwa/cY78zzouPpSSN3gtA/Lu3fje6E
 Neaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=haSXnoSPhrD17lX5ZndWujBCjWLu9wT1A4Vj0WAoOl4=;
 b=UuN6jPz0NhcI4elRTOtPakZ9MVC+6eP9HV4Gwyuxo8rFPnBm5R0fmfEiYB3cYsO26j
 Ck6yRsALgcqSs3/RG6wR4akWigPFMJOao4Hc+51fMpr4+GDEgeuzMcR2LuYuiM3ehMuS
 Qrt0dnpncbJbBIGjEbBq/FAf1NZRToBhQypidDzoSl6hF2bL29adffi80Zy0hkX46+5i
 PfCENf1xsDUyiNP+dpQPTwEIsr1LFqahtrAAgoByqhFdKu6yF7mxTw8Y4BQutg/Y2YFy
 3X8HuMOitELe1MFp6ItL2hOGz5StfSW1siuGfRwe+uPCS7R7TonJRiUN3AgXw6vThyfu
 pQUg==
X-Gm-Message-State: AOAM530nIaUjPSbL3loi7a1V714g7l/6XNx5KdC+udArV9OswGRj2f0y
 FkMauJXXn5N4vQU1AngSiOW+L6gF
X-Google-Smtp-Source: ABdhPJyUNHj5luGIPMVXK9Xez4q31MLdzoDo7Q+Erdq4OsRHOBRUpgGOmMoOEr6lvPyYWPS3efh7Wg==
X-Received: by 2002:a17:906:abc9:: with SMTP id
 kq9mr19376522ejb.493.1593535632601; 
 Tue, 30 Jun 2020 09:47:12 -0700 (PDT)
Received: from localhost.localdomain ([109.245.225.97])
 by smtp.gmail.com with ESMTPSA id d26sm3233096edz.93.2020.06.30.09.47.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 09:47:12 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] target/mips: Remove identical if/else branches
Date: Tue, 30 Jun 2020 18:46:51 +0200
Message-Id: <20200630164653.24880-2-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200630164653.24880-1-aleksandar.qemu.devel@gmail.com>
References: <20200630164653.24880-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

Remove the segment:

      if (other_tc == other->current_tc) {
          tccause = other->CP0_Cause;
      } else {
          tccause = other->CP0_Cause;
      }

Original contributor can't remember what was his intention.

Bug: 1885718
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 target/mips/cp0_helper.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/target/mips/cp0_helper.c b/target/mips/cp0_helper.c
index bbf12e4a97..de64add038 100644
--- a/target/mips/cp0_helper.c
+++ b/target/mips/cp0_helper.c
@@ -375,16 +375,9 @@ target_ulong helper_mftc0_entryhi(CPUMIPSState *env)
 target_ulong helper_mftc0_cause(CPUMIPSState *env)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
-    int32_t tccause;
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
 
-    if (other_tc == other->current_tc) {
-        tccause = other->CP0_Cause;
-    } else {
-        tccause = other->CP0_Cause;
-    }
-
-    return tccause;
+    return other->CP0_Cause;
 }
 
 target_ulong helper_mftc0_status(CPUMIPSState *env)
-- 
2.20.1


