Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2236DC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 21:04:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB23220879
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 21:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naeemU+B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB23220879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54128 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQeax-0003d8-2y
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 17:04:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hQeV3-0007lR-Lb
	for qemu-devel@nongnu.org; Tue, 14 May 2019 16:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hQeIj-0007XG-3n
	for qemu-devel@nongnu.org; Tue, 14 May 2019 16:45:30 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:46154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1hQeId-0007Rh-Km
	for qemu-devel@nongnu.org; Tue, 14 May 2019 16:45:28 -0400
Received: by mail-lj1-x244.google.com with SMTP id h21so458588ljk.13
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 13:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=TNwKj3NK4xpLU3quun8/1/87vC9zwSKuxU85t6b9WuA=;
	b=naeemU+B3Dsr9Pb9887eyk9hKazrAQqLIV+zE8jsRV/UhSUadUFy0KyFnlfRBpaCal
	cH5oBrYFH9kZHO4qk1Ylhs+GdZzJ3+izuEaT+3SaJ74WucyLnkYyh8xdIuhr6X6Hmlzk
	JEsGweJwKd+4iCVEQvos2czMF0zpB7Qt2ih5U+Q/yEgeiDO0ybkIhQfhp6oJOh7DcolC
	wPFvw5VTQaIoHsHEatmfGLT8y64nMk4iAgTm9WAZtIJdo0mpCPcY8mBu/FqGAktC672a
	kJSYp6Qfv3272bPzlQi9hubtMYdoBFPCo85QGI6PcBbhlZiIckFyvjjCwARCGADdJzjQ
	VDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=TNwKj3NK4xpLU3quun8/1/87vC9zwSKuxU85t6b9WuA=;
	b=eZUESdFylfK1LIxPo6sBUzoLB4rQAfeUTlzaBpRDLyMTD5cmseHePEbX1e0dlYSrBJ
	6cw8jeEyVllOZIaqduLpH+Byb3qt43jADzfdikXWhDuB9hn2zh6a/2J4fI6BZBrGBVBx
	yg94oUmBFUg3i73Fp4kDEdIUB4znN47ldAgJc7SCu3bZj+a7k1xxhcKzqRkbznT98HOy
	IvgZlaMgNffYmb97AYYeWhwj2Xz9WiZlH1CYt2VoyQqSm0x6gtSOCat56TVz8PR5X6c+
	COQLZQheCtRqDvuuKL81okSzfM8PcXdkk0tmo2JMEK+Nwd98SCgIQ3RAYgHG0Vx+wkjE
	iKNQ==
X-Gm-Message-State: APjAAAXMWbKAuZyjpcvLw3q5Qt9Yu7g7rNAS6Gw7uk5kxSx7XdiR3wgv
	riREi7sPYGAHb/LQw59mtoQFlrAkT24=
X-Google-Smtp-Source: APXvYqyyEJ5GTQ6YtPzM+dXpqNHh6PtiJL6IchaRThMLl/uTogIYxWtOkLS8WrcnXck1CHXzchdDNg==
X-Received: by 2002:a2e:28d:: with SMTP id y13mr17667712lje.177.1557866720808; 
	Tue, 14 May 2019 13:45:20 -0700 (PDT)
Received: from octofox.cadence.com
	(jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
	by smtp.gmail.com with ESMTPSA id 78sm4011lje.81.2019.05.14.13.45.18
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 13:45:20 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 13:44:44 -0700
Message-Id: <20190514204447.17486-7-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190514204447.17486-1-jcmvbkbc@gmail.com>
References: <20190514204447.17486-1-jcmvbkbc@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::244
Subject: [Qemu-devel] [PATCH 6/9] target/xtensa: implement DIWBUI.P opcode
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a recent addition to the set of data cache opcodes.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h          |  1 +
 target/xtensa/overlay_tool.h |  1 +
 target/xtensa/translate.c    | 10 ++++++++++
 3 files changed, 12 insertions(+)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index d6e6bf6ca183..ba4ef2b6a729 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -466,6 +466,7 @@ struct XtensaConfig {
 
     unsigned icache_ways;
     unsigned dcache_ways;
+    unsigned dcache_line_bytes;
     uint32_t memctl_mask;
 
     XtensaMemory instrom;
diff --git a/target/xtensa/overlay_tool.h b/target/xtensa/overlay_tool.h
index b61c92539861..4925b21f0edf 100644
--- a/target/xtensa/overlay_tool.h
+++ b/target/xtensa/overlay_tool.h
@@ -425,6 +425,7 @@
 #define CACHE_SECTION \
     .icache_ways = XCHAL_ICACHE_WAYS, \
     .dcache_ways = XCHAL_DCACHE_WAYS, \
+    .dcache_line_bytes = XCHAL_DCACHE_LINESIZE, \
     .memctl_mask = \
         (XCHAL_ICACHE_SIZE ? MEMCTL_IUSEWAYS_MASK : 0) | \
         (XCHAL_DCACHE_SIZE ? \
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 782f2ec62099..24eb70d619d5 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1620,6 +1620,12 @@ static void translate_depbits(DisasContext *dc, const OpcodeArg arg[],
                         arg[2].imm, arg[3].imm);
 }
 
+static void translate_diwbuip(DisasContext *dc, const OpcodeArg arg[],
+                              const uint32_t par[])
+{
+    tcg_gen_addi_i32(arg[0].out, arg[0].in, dc->config->dcache_line_bytes);
+}
+
 static bool test_ill_entry(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
@@ -3098,6 +3104,10 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_nop,
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
+        .name = "diwbui.p",
+        .translate = translate_diwbuip,
+        .op_flags = XTENSA_OP_PRIVILEGED,
+    }, {
         .name = "dpfl",
         .translate = translate_dcache,
         .op_flags = XTENSA_OP_PRIVILEGED,
-- 
2.11.0


