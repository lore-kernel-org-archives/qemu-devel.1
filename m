Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD41FC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 18:35:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A954920855
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 18:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xp4EM/1c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A954920855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57173 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDZ6m-000372-He
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 14:35:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hDZ0O-0007bf-Dl
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:28:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hDZ0N-0007Dy-Ei
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:28:28 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hDZ0N-0007Di-8Y
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:28:27 -0400
Received: by mail-ot1-x344.google.com with SMTP id e80so13118371ote.5
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 11:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=ixDla5yG69dYcjSXMRxEhIxmDIvMKdt+9KxqZIdYFH4=;
	b=Xp4EM/1caaJyewiCheEs/t0w9jLBDYYz1KpnwuUi7COJoSo6d5vhNfyktZ+vyf2Os8
	txfqcUuLTnXfIlabXWdTZHzqPKfmnaEVVFRp8hMb3OFV8AXZtNgRGivhvPGq7gPOo8ZA
	9Pk0IBNf1MoaBymu8S909cePYlv6Mkjme+K4YQfIt9cJX7f8dBFi43WPl3XCLUIUV3ZH
	QI5YDjE62XgBm1i6razzZzZhuKLFScrhDElpkOb9PAKrItVx6jw6lu5+a4RJDz7O1cgp
	jArjcfd4lPSqIe356woYgGjk4qdkbXKDXAwEju11JDEqY+5XNTzoeVPad4EO2vvfkdZH
	FK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=ixDla5yG69dYcjSXMRxEhIxmDIvMKdt+9KxqZIdYFH4=;
	b=J2eV6XUblhvt85bOaxIeQgC3iJHO4sW5WDpjC0duisXr+3o4CeByPavc5vencoVLUB
	OxzqPMZYgpwGBmt1GAzWRulqKDNhqK1abaOIy6KQWXsZPC8axLrvIBK704tm2WQXpVQp
	7r+DO9unyChBAgQQ2uGaethWng6doIT1SWBkJ23Gy3KZtdsZiLYm2jqFl7quJCNrPry3
	9D++J/e+5lJ3EyIKdhVXRBHQsYvndCT83Z0c08ZM1Gls2DwTDvItBEkHgHCqL4tSfZB1
	kuEI1FKcsseIcUKMUXHCa8oT73MX1vK+BtsXdkgz0btAeep67BbaK6++RGAQRgimlOZ9
	JT4w==
X-Gm-Message-State: APjAAAWEbauaVvfUBIwmz1mKfOLMIQIxfOJa89YjEfCxgkKaE+98gOj0
	b/fHJgPtPcOHVaAB/4ccCAuy9qDPASw=
X-Google-Smtp-Source: APXvYqxVht55Rh2lEdhJEJ2cR6PvuYxq23w9Fzb7t2xra9A9EET335ygASoTEi1Z3JOURmCXKWWPGw==
X-Received: by 2002:a9d:7ac2:: with SMTP id m2mr20107963otn.239.1554748106416; 
	Mon, 08 Apr 2019 11:28:26 -0700 (PDT)
Received: from dionysus.attlocal.net
	(69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
	by smtp.gmail.com with ESMTPSA id
	r133sm9940295oib.21.2019.04.08.11.28.25
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 08 Apr 2019 11:28:25 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 14:27:48 -0400
Message-Id: <20190408182748.1238-6-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190408182748.1238-1-jan.bobek@gmail.com>
References: <20190408182748.1238-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: [Qemu-devel] [RISU PATCH 5/5] risu_i386: remove old unused code
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Jan Bobek <jan.bobek@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190408182748.4bsXA5U94vU5M5l66f_09xA_eaOzkWlVOE8Gq4CyGuA@z>

The code being removed is a remnant of the past implementation; it has
since been replaced by its more powerful, architecture-independent
counterpart in reginfo.c.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 risu_i386.c | 58 -----------------------------------------------------
 1 file changed, 58 deletions(-)

diff --git a/risu_i386.c b/risu_i386.c
index eb4dff4..14b0db3 100644
--- a/risu_i386.c
+++ b/risu_i386.c
@@ -16,13 +16,6 @@
 #include "risu.h"
 #include "risu_reginfo_i386.h"
 
-struct reginfo master_ri, apprentice_ri;
-
-static int insn_is_ud2(uint32_t insn)
-{
-    return ((insn & 0xffff) == 0x0b0f);
-}
-
 void advance_pc(void *vuc)
 {
     ucontext_t *uc = (ucontext_t *) vuc;
@@ -61,54 +54,3 @@ uintptr_t get_pc(struct reginfo *ri)
 {
     return ri->gregs[REG_EIP];
 }
-
-int send_register_info(int sock, void *uc)
-{
-    struct reginfo ri;
-    fill_reginfo(&ri, uc);
-    return send_data_pkt(sock, &ri, sizeof(ri));
-}
-
-/* Read register info from the socket and compare it with that from the
- * ucontext. Return 0 for match, 1 for end-of-test, 2 for mismatch.
- * NB: called from a signal handler.
- */
-int recv_and_compare_register_info(int sock, void *uc)
-{
-    int resp;
-    fill_reginfo(&master_ri, uc);
-    recv_data_pkt(sock, &apprentice_ri, sizeof(apprentice_ri));
-    if (memcmp(&master_ri, &apprentice_ri, sizeof(master_ri)) != 0) {
-        /* mismatch */
-        resp = 2;
-    } else if (insn_is_ud2(master_ri.faulting_insn)) {
-        /* end of test */
-        resp = 1;
-    } else {
-        /* either successful match or expected undef */
-        resp = 0;
-    }
-    send_response_byte(sock, resp);
-    return resp;
-}
-
-/* Print a useful report on the status of the last comparison
- * done in recv_and_compare_register_info(). This is called on
- * exit, so need not restrict itself to signal-safe functions.
- * Should return 0 if it was a good match (ie end of test)
- * and 1 for a mismatch.
- */
-int report_match_status(void)
-{
-    fprintf(stderr, "match status...\n");
-    fprintf(stderr, "master reginfo:\n");
-    dump_reginfo(&master_ri);
-    fprintf(stderr, "apprentice reginfo:\n");
-    dump_reginfo(&apprentice_ri);
-    if (memcmp(&master_ri, &apprentice_ri, sizeof(master_ri)) == 0) {
-        fprintf(stderr, "match!\n");
-        return 0;
-    }
-    fprintf(stderr, "mismatch!\n");
-    return 1;
-}
-- 
2.20.1


