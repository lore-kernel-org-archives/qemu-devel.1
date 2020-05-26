Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E7CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 17:27:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 394DE204EF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 17:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeXrjD2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394DE204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jddMh-0004ak-EM
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 13:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jddJg-0006fb-Ov; Tue, 26 May 2020 13:24:40 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:35193)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jddJf-0004Oo-UE; Tue, 26 May 2020 13:24:40 -0400
Received: by mail-ej1-x641.google.com with SMTP id y13so2738358eju.2;
 Tue, 26 May 2020 10:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xD1F0Crj0tTgMdXFMSpwQeLXu3Am6SzZrlFvxBhJ1Vo=;
 b=IeXrjD2BOatUygJ+ulV/wns+oAgBRzOCA0KpeZ/FkTPUQZu72bqsawXLTPVuAjMMog
 tUGk/hsS0oU6q0mh9JRiG84gU1aGspgivt1CjXpbodA1Mo8WOMQJ1njFmL600by792Kf
 0O7E5f87ciVz39TJ5jz+x8FytpdBGn7r1wHB4zDqhu04bR/r8s+0D0mioBY7oYOmd05F
 Vw12XHQqutF+V6H1h4a2Yxus2QRKRtO4z55XC0wcQx0W1nDYtRaRnlzNTW3el21fwuiY
 +84t4PNWtMLTwO1x3LssWHxMD5gZEzDhVEiFwK0XyA2isCawWH+snwVfPrJKoUBKW5P0
 D0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=xD1F0Crj0tTgMdXFMSpwQeLXu3Am6SzZrlFvxBhJ1Vo=;
 b=CS7CIsw+n8DumppcJkNqHAwJIEEg+5cJH9HhgcW7tsVaA0xIM+YujZ3Kxt/g8F2rzl
 qc24EO1alsH9+VQRaMBF7AS/edjykWUQWmGL4BY7pl9djj8NSD3O7qrnzORMhWtV/nRQ
 uSL1BEL208W6Vo8t1rHPlb0egG1dC6lUg0pXtBMRc8Z6YMOcUr2lePhsvXWJ8Ao9C8KA
 wjucKHm8U1p/AsE50Dpk6aUedAd8WShhGC0rXRiwA0jl90BcsKYnhtivOicYyGoldKYA
 HxNTzSpsOzF1xbA0C8OSBte161yV5M+jFGU2h6JdQJEhZwZ7Qsr3biHiDokcR7ZPjA2x
 rC5g==
X-Gm-Message-State: AOAM5308GVyh4jYHYO3wYvRwKePwL/TYzzL1AmHEGanBOkAqsYopb8YP
 oCiJgaZ8mQJ/2T8bG8x2PLFp9EMOFXs=
X-Google-Smtp-Source: ABdhPJxppiXRNKxsvfWoUwG0mSxbaomcaqkEeAxC9aNhTBlgTB4SzCn+aw6WFu5ZFEgCR3Og1G+p1Q==
X-Received: by 2002:a17:906:f198:: with SMTP id
 gs24mr1983093ejb.547.1590513877491; 
 Tue, 26 May 2020 10:24:37 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id bf15sm421357edb.46.2020.05.26.10.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 10:24:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/7] target/s390x: Only compile decode_basedisp() on
 system-mode
Date: Tue, 26 May 2020 19:24:25 +0200
Message-Id: <20200526172427.17460-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526172427.17460-1-f4bug@amsat.org>
References: <20200526172427.17460-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x641.google.com
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
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Roman Bolshakov <r.bolshakov@yadro.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The decode_basedisp*() methods are only used in ioinst.c,
which is only build in system-mode emulation.

I/O instructions are privileged, and other S instructions
are decoded elsewhere.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/s390x/internal.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index 8c95c734db..c1678dc6bc 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -204,6 +204,8 @@ enum cc_op {
     CC_OP_MAX
 };
 
+#ifndef CONFIG_USER_ONLY
+
 static inline hwaddr decode_basedisp_s(CPUS390XState *env, uint32_t ipb,
                                        uint8_t *ar)
 {
@@ -225,6 +227,8 @@ static inline hwaddr decode_basedisp_s(CPUS390XState *env, uint32_t ipb,
 /* Base/displacement are at the same locations. */
 #define decode_basedisp_rs decode_basedisp_s
 
+#endif /* CONFIG_USER_ONLY */
+
 /* arch_dump.c */
 int s390_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
                               int cpuid, void *opaque);
-- 
2.21.3


