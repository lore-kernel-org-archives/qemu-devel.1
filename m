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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8BEC32751
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:19:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9154F2085A
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJL0rxJn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9154F2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwIqR-0001qP-PY
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 00:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34746)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIkr-0005Yr-Rc
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIkq-0004Jk-Ss
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:21 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34822)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hwIkq-0004JY-N1
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:20 -0400
Received: by mail-ot1-x344.google.com with SMTP id j19so63823816otq.2
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 21:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cdQ2zHbW0n5vJl74dX5gSkq4IDwwB5HUv7xrl7+M5h4=;
 b=OJL0rxJnhpB3/XnARFLu3HaekUeDLS2G5va7KZGRvM/Ub80os6wAYCMv1jV7+6/A+7
 Ox5s3MRvTlVxEdq8tMNOJUHdohzuZGYMcztZYO1TaW4pUHFsaxyaCtfDXmb8cy9geYuP
 +0cu6kdm+fQztdjJQrLNKBuZ1YCJ/FluC0MrOL8S5i5r+8mJ1rSZNVO5jDJTTwGws7G8
 WnrwrYBdLyerEEbIKsHPSovZFzrcZH95jLM4MZsIkFfMBDeEC5t4LIM/SAFxLXUkRlQ/
 Qzbh2r5ErMIW2OUj92VaqOLcyFBbVRtpVtoLTp+vKFtXjSdjwp4ERI2aBBg188as2gnL
 Gjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cdQ2zHbW0n5vJl74dX5gSkq4IDwwB5HUv7xrl7+M5h4=;
 b=t3xy9vELtUN4ijWB2Fzzj3nWVEWf/Vw6gQok3+8Ht8hsWP/Z4Icv0fozBBTjZJUQUw
 om2ouuHUKgNCtIcK7KtKHDTIwXm63DD8lb8woSx0bS1XNWBUM3R7BtcN2MY6Kxw/q6zg
 G+8iv5CGRxzGejUsnUKDCq/0DzDo2OWyZD7wv5KCJ7qW/Z32aqTITg3PFPNM8M5qopba
 vpRmU1qGowEoo2edq95BaDgFh/8Eq1zCIB6pFSOSpK1m3mxhwzNRtCXOcpjgruh6rTdj
 Ce60Puk4CW3q10bUhkbanqFoCG7k6h/OCnTYcIgDVSS7eoFq5Uih/5ypTo25q1BhLnbp
 6QcQ==
X-Gm-Message-State: APjAAAVwQaDGTOZHW2B7Ha0lzSrMoPWF8JTPY//tP+C//Xg+jOMkHDoQ
 cQTRSBvKTsAc7G8vkO94R+Dn/u1M
X-Google-Smtp-Source: APXvYqyPsA/TllPJq4B6jXcPfgj6zf5PRf07URZU1HoSdzx5xxHtEprx+ckWSioKbcbcdbW6YBuZYA==
X-Received: by 2002:a9d:4902:: with SMTP id e2mr20076436otf.184.1565410400035; 
 Fri, 09 Aug 2019 21:13:20 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id f84sm33383540oig.43.2019.08.09.21.13.19
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 21:13:19 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Sat, 10 Aug 2019 00:12:29 -0400
Message-Id: <20190810041255.6820-14-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190810041255.6820-1-jan.bobek@gmail.com>
References: <20190810041255.6820-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: [Qemu-devel] [RFC PATCH v2 13/39] target/i386: disable unused
 function warning temporarily
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

Some functions added later are generated by preprocessor macros and
end up being unused (e.g. not all operands can serve as a destination
operand). Disable unused function warnings for the new code until I
figure out how I want to solve this particular issue.

Note: This changeset is intended for development only and shall not be
included in the final patch series.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index fbf10b57a2..23550a21d3 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4489,6 +4489,10 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b)
     }
 }
 
+/* XXX TODO get rid of this eventually */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-function"
+
 static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 {
     enum {
@@ -4513,6 +4517,7 @@ static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 
     g_assert_not_reached();
 }
+#pragma GCC diagnostic pop
 
 /* convert one instruction. s->base.is_jmp is set if the translation must
    be stopped. Return the next pc value */
-- 
2.20.1


