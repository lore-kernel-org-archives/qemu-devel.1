Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950CFC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 22:50:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DF992133D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 22:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+xj45yM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF992133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54758 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRlgF-0005Ns-GU
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 18:50:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hRlbK-0001KQ-3G
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:45:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hRlbJ-0005Zg-11
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:45:18 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:33290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hRlbI-0005Yg-SC
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:45:16 -0400
Received: by mail-yb1-xb41.google.com with SMTP id k128so1597218ybf.0
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 15:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=7+yQx6OLxf+FYJ6x1tpH2MOMowTuy0Bufj466O5eB5Q=;
	b=B+xj45yMVSCbvtpPUuFWgPhf/Wg7HJ41aW/rDILhKzKJuUhm+QYkeJG/FEMtNs2uiM
	JHcboJQhN2FK2SSl1haLAFrCvwi3yVmL6Fd/R1aIDLymRLNwrBXmHgp8QMxDznWhDl8J
	nVLQh9u+z8yd2+hzg0Rb4PtoiAk6MnjuU7YEkMrVviDbmXBgKGsdjhFF7KAMfswrp36s
	apF4OodbN73piRNIWuVF8J6PeCqAbGFS9VEqz6Vsx0d7qC7HmyeTVrzvTNFkvxXtb/ys
	hnj9SVGlTEYyw5zg+BIuknNFyVikEx3HNxVgnViPDoToas/fVU/3APjyF/HfnZ5SNeQ+
	23vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=7+yQx6OLxf+FYJ6x1tpH2MOMowTuy0Bufj466O5eB5Q=;
	b=VqdKIDUVRffyn5grcx5Qp7AecjdQlsxPaSC3pbVnEjOUSeKiTvOX1XTsNTeI1t0FBC
	2XOXqAc4YF6AsRGjV3eJ3KX0GWcexoPPgU/s4AQgzWXeSEpG+VR+bqHvyIH06tNPnqvM
	mxIQ2BjLAK0PuZ9Jv3SfcojOWqgBZ2Mu8lvbOmxyZWF+3fvdAxAtbSqBLU9nG99jdnAH
	cs0oZLAcuwxLB7jcXI6Dd9LoE5goTpkIUvxDQgUbrJoRtVV3IGY6CGRyQf9yiFLK7CRX
	5Et9mrS+KUVQ5oqFQX8/Jk1GZeolV8phgPoX0gcxEGgwh+c0oTKUgZRsu8qylYUbsFlt
	VvHg==
X-Gm-Message-State: APjAAAVP9V8UTWGrc4uJ3nplLUYV0wK/ZGuWQPMvBFXppSS6qv9fHzDz
	pAWx7a5zTMc+V3DeV4GePgoxMXfkDKhT7w==
X-Google-Smtp-Source: APXvYqzfjpvKZYxPTPIXCjTPpehftjtuaKvuvKNoha09Q1hUkqAJsCreJYThWG5H1W9vaMScZZqK6A==
X-Received: by 2002:a25:ba0c:: with SMTP id t12mr28684641ybg.70.1558133116318; 
	Fri, 17 May 2019 15:45:16 -0700 (PDT)
Received: from dionysus.attlocal.net
	(69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
	by smtp.gmail.com with ESMTPSA id
	u73sm2480260ywf.62.2019.05.17.15.45.15
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 May 2019 15:45:15 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 18:44:45 -0400
Message-Id: <20190517224450.15566-7-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517224450.15566-1-jan.bobek@gmail.com>
References: <20190517224450.15566-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b41
Subject: [Qemu-devel] [RISU v2 06/11] risu_i386: remove old unused code
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


