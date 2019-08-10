Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C576C32751
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:26:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BD0D217F4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3av3WtZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD0D217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwIx5-0001JS-85
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 00:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34863)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIl2-0006A6-Me
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIl1-0004RC-O5
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:32 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41269)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hwIl1-0004R3-Ju
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:31 -0400
Received: by mail-ot1-x341.google.com with SMTP id o101so5584481ota.8
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 21:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=z9grixh37d7b2RJWqW6FqjUKRalgRN8iH6PjGzbqJZ8=;
 b=O3av3WtZWKp+sWQTo1aDD+J4wlsCVOSLg1rClKA7oPLhO9AS4cAIMjAz3Oi1xwGBK9
 yIriHvnCLH9BZ4KOniam793Mu8xodztRmPwAhXd6P2pb2aipwb+0YCmdiHuKPzYSJkaA
 xFH+bhoxz8RWRNL6fIpN7W25Bh+kwCxbZs6vViTQ6sigy44e3Gzhn6OHq66ZpvYQJ+wl
 cmraHbSrYFTW+mtxBygVNrpL4M8yKB+hdPHQ3RRXOb+Ox+XyEYMI5L/LGme73+lkBlYz
 SybUzczUlEQuQQPaDZ7OCXUqZ23sYA/48xAxMBGhkMvo+iboir4VKP2z3Kcy5/XGOhr1
 SnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=z9grixh37d7b2RJWqW6FqjUKRalgRN8iH6PjGzbqJZ8=;
 b=uPT3NR9ujRpmZxOunEErNlEwZ7WgK6yokewGMjrzbfGdP7xbbAolwJ2bKKKiaIduZc
 F1rgfk80yKXFa2VHzIfu0L4kiHVvtMM0PqEc5zP2+Vxy/cFGjMFKGOooup+3Q9ZcYgLv
 KCRvy1n670txrsAEQh29l6Xtna/Ct0jwrVvXzSIqY0BLUdKEkhFwbrrZZsOgsASo4C/d
 INvx7nLlfcTlIv/xIgfRk/VqNZP2b2ubZsPGz4b878QbzX0HGsiNC7qYDxZSLjAfSeS5
 vDFJqc5+LUBDMd7nEI3s4dpP5xXQ/pAbKVQNXBorT6RGAC3/Kexf7LSyY9G0ci2vg6+O
 VB1w==
X-Gm-Message-State: APjAAAVe8IIk35IEPVlGuTEiAP3weQx2qGt4mZgKYxj/4+Z+hoAiluzb
 x6V+aYrxk2jydxQw2bVmjE2HFPp+
X-Google-Smtp-Source: APXvYqyTbnv8vzaw3FESp6gtza+8bPSlv+VGNDhH9ePUZy7KSxNwRrKRfkhWyaN14fSshgzjUx3B5A==
X-Received: by 2002:aca:5e06:: with SMTP id s6mr8573717oib.171.1565410410911; 
 Fri, 09 Aug 2019 21:13:30 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id f84sm33383540oig.43.2019.08.09.21.13.30
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 21:13:30 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Sat, 10 Aug 2019 00:12:40 -0400
Message-Id: <20190810041255.6820-25-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190810041255.6820-1-jan.bobek@gmail.com>
References: <20190810041255.6820-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: [Qemu-devel] [RFC PATCH v2 24/39] target/i386: introduce Ib
 (immediate) operand
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce the immediate-byte operand, which loads a byte from the
instruction stream and passes its value as the operand.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 0da064d5fd..b8e6eaebb4 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4697,6 +4697,14 @@ static int ck_cpuid(CPUX86State *env, DisasContext *s, int ck_cpuid_feat)
             insnop_finalize(opTrm)(env, s, modrm, &rm);                 \
         } while (0))
 
+/*
+ * Immediate operand
+ */
+INSNOP(Ib, int8_t,                              \
+       INSNOP_INIT_OK(*op),                     \
+       (*op = x86_ldub_code(env, s)),           \
+       INSNOP_FINALIZE_INVALID)
+
 /*
  * Code generators
  */
-- 
2.20.1


