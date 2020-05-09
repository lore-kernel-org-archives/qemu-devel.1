Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE24BC28CBC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 13:12:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94705214D8
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 13:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvcBFgiQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94705214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXPHf-0003Bm-R2
	for qemu-devel@archiver.kernel.org; Sat, 09 May 2020 09:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXPEW-0004HR-DX; Sat, 09 May 2020 09:09:36 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45337)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXPEV-0004CM-Gc; Sat, 09 May 2020 09:09:36 -0400
Received: by mail-wr1-x442.google.com with SMTP id v12so5106876wrp.12;
 Sat, 09 May 2020 06:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+DgGlmxYDgp0TKp/P6BFoo5PGVwzBhcu5AKwXK50jX8=;
 b=BvcBFgiQIUD1+RziJDhNMsQ7Ucuo0HzKzddEWCkSr5wWeMkPLjf9T3YUgVn7TEZUW8
 BeHtatd35QLZX1SyVZBXps154vdDu6tocL168dUDhvR6IdCcR/lyBozEOsD7vkG7qyXF
 GwQ4iLBTJ8MjVfX6GmIw020VUza87GqXIP2ErisDDxUDaiaV0WTXD+24msJH8VGk6ZZ9
 KgqXgJTJbXg6vRCdSTcREyPVonO1iyvU+21nhXXeCrqDLTbo6JpzO04xrj3l4yq1T0ZP
 4MviTafrpBKVsPxCgh618jx/It7wV31V6+Gz1rx4tYch2/z3kVArsHxues7KCOZvW/Jq
 aPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+DgGlmxYDgp0TKp/P6BFoo5PGVwzBhcu5AKwXK50jX8=;
 b=Hp0HjKAhwObViqI0WIrlAIsgnMbXtX52v7AwDnRrGEx0a7PeFovGC+OuEclqwfLLB9
 ynBND0bTuRuxqV3VB1MU/YHN4xIjatn9el4J8IFqf9j2kGtxK1JN1nqo13rwgkze7Ej+
 T1Bq2hytpK6TuF+58+fCcRDrs8+xooKwrVEusP5+zR2dUCarGgA4p65Azvp8wXBgbTHY
 8Zq3s37gEia1VY3X3GZow7kmppikt3iGezjLCIjl4/A6JyPdBI0VVqHG00I8j0uVpJA7
 Jtu7s4LpUPYRCPF3jAHMc8XrC7asQn46ZfCHPXb1LW9dUUFKwzBizk42p6T+ufEAaaK3
 dT3w==
X-Gm-Message-State: AGi0PuZZDL96Z+15PxPkd1xPxc7IuY/c6JHPztkrMo2zkPDVuBMOo8+J
 TpMIpJ+OzRUqYROAn5bPoDlOlOr2G0o=
X-Google-Smtp-Source: APiQypJmQJFMZiRR9DoMibdtr9JH+Z1Pn1cDFuHjz2glYTE1zO+Rwp2YknwOdohPGFoSiQItW5g6mA==
X-Received: by 2002:a5d:4c86:: with SMTP id z6mr8019146wrs.279.1589029772695; 
 Sat, 09 May 2020 06:09:32 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id m65sm1411410wmm.17.2020.05.09.06.09.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2020 06:09:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/11] target/s390x: Only compile decode_basedisp() on
 system-mode
Date: Sat,  9 May 2020 15:09:05 +0200
Message-Id: <20200509130910.26335-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200509130910.26335-1-f4bug@amsat.org>
References: <20200509130910.26335-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Chris Wulff <crwulff@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Roman Bolshakov <r.bolshakov@yadro.com>,
 Laurent Vivier <laurent@vivier.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The decode_basedisp*() methods are only used in ioinst.c,
which is only build in system-mode emulation.

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


