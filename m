Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38665C282E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 20:46:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05A2520645
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 20:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omd2HmvH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A2520645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43095 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTubp-0007Rl-8R
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 16:46:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hTuZr-00064V-Er
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:44:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hTuZp-00035s-It
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:44:39 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:35350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hTuZn-000333-KJ
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:44:37 -0400
Received: by mail-yb1-xb42.google.com with SMTP id s69so2620303ybi.2
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 13:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=DWaxu9uiHa4VqUgpO4mPbqlseFRB8XqATreonAM1ocs=;
	b=omd2HmvHUWB31GaHLP728PLGg48qZ7ELwgtPgcYJXYiFNo97N0QqsmQEubo0DpUtqw
	WWa1jv1zeCpavvHRCHBbjK29hAf0fEqzCdJGb+wOoJyzkDBKj2FLrTLTMpRuYD/nelnf
	VHsscQ5hnrc8d6o8F/Yzq24apajNtgmSlsQRcBVw8xxrWYshQXNJLOcgy+2gbTJzNBPl
	BeKg95dtY3HS0yTU2a7XQL2r2CY0CzCygVBFHGBwCnQ43O0Jk2YP0m2Dyog+MklQ9q4n
	azOyJk/bzMMk7N5NJzBU+GE/cN24CpYkZprFZgR0g2kUPCOuXj8PfND8eS+GVrb7clxH
	myHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=DWaxu9uiHa4VqUgpO4mPbqlseFRB8XqATreonAM1ocs=;
	b=eS7oGA2KmDmznwaFRcbHzz8I936xUaevsA8MpmroQfdjX3vu3Ko16b/61GVyhShKE7
	tXM0Pj2eGaCWDQrN069XazAVytD07Tzuj7NuWsRppxATcqWmvD4VwoRg8TDUA4QbgH8y
	doAI0gwQPoFwdqhP2mXrPD19F6yzSpjiyhNJHELHk2d6CZZrKNwQn3sczgclgcRv3Vwb
	Cb2pwj5yOIWSEUrkID3R/+rkhlRdsE9t/GdVBHyGzpTTGrWFGKGe4ejcYF+O4cmyBOPG
	aYUNzFvQWrFrFnjZvz7V8jMGpFZzDDkgS580CWC4hvFD7o+EoS1j2/fkvj/b+KqEBeAa
	Cnzw==
X-Gm-Message-State: APjAAAXE04dfz49CqwWCFZdXb8nf4aydXi/JLSbfghYxEFJX2hBMaLGe
	siEp/Pe3EpytUOQHeOBidPFXWibl
X-Google-Smtp-Source: APXvYqzntVuupXDMaMa1iu+UoYxRRIOmiHWXUfxIbYzIRk+GIObfiwnwuYPkXyT/G/XJwCldK1lLjw==
X-Received: by 2002:a25:cb43:: with SMTP id b64mr24063415ybg.509.1558644273827;
	Thu, 23 May 2019 13:44:33 -0700 (PDT)
Received: from dionysus.attlocal.net
	(69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
	by smtp.gmail.com with ESMTPSA id p12sm87590ywg.72.2019.05.23.13.44.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 13:44:33 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 16:44:04 -0400
Message-Id: <20190523204409.21068-7-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523204409.21068-1-jan.bobek@gmail.com>
References: <20190523204409.21068-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b42
Subject: [Qemu-devel] [RISU v3 06/11] risu_i386: remove old unused code
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The code being removed is a remnant of the past implementation; it has
since been replaced by its more powerful, architecture-independent
counterpart in reginfo.c.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 risu_i386.c | 58 -----------------------------------------------------
 1 file changed, 58 deletions(-)

diff --git a/risu_i386.c b/risu_i386.c
index 06d95e5..9962b8f 100644
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
@@ -57,54 +50,3 @@ uintptr_t get_pc(struct reginfo *ri)
 {
     return ri->gregs[REG_E(IP)];
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


