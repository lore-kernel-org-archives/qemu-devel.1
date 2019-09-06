Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D74C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:59:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E77D920693
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZNuEf+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E77D920693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6HZe-0004pE-Vn
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 12:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36884)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcmvbkbc@gmail.com>) id 1i6HYX-0003uo-K9
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcmvbkbc@gmail.com>) id 1i6HYW-0000n9-O7
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:57:53 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:38944)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1i6HYW-0000mN-HM
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:57:52 -0400
Received: by mail-lj1-x243.google.com with SMTP id j16so6653194ljg.6
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 09:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=VaJNiqW+quNrpETxN0MOfS47QXG0sgk28zKeOB7Wyig=;
 b=RZNuEf+3kLV1Z5zzPhw9UyY094Lk8/GKog4MI2QL1bbvwgQHyYEWme+mDOVicFZ+1I
 zYfdALkLBlLZwYgjt8mlVpaSEtGlvIvuysf5GEq3EPemVTjuvbrzguhzZ+w9S6d5hVpD
 20B4n6KapH4Tm2xZpu2Qqhj1WcyFk/S8hnahrGjRbwyyO12j9yaZWWttGsJdPTbS1Imt
 bgy68Hirq2xI7WOFAe2uFXc8fLQ16I0D92eWTljKhLt4nA5u8dAGVkwaMJvR9BlUQvNf
 8arlE5ze/wGx0ig1DEC+QqZB+Mvmn5yHwY05EZSwouLcGlQy0sWrbDWZPI8S4FiXAfFL
 QjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=VaJNiqW+quNrpETxN0MOfS47QXG0sgk28zKeOB7Wyig=;
 b=iEunFQ6A7G1KpQopNy45AKxeg+C7QyY9vJcueV44X/Mk7LZlVkN1NpQe/lXeDrjvcc
 7qE3evARngC6vUHtKyxefc0gvEzsrxNb63Ztl0POqjz6gQF/lK5mpXK82dOOPOS/iP5f
 IICm2wT/PAa4Bo7ucIuPJbxnveiON0OxN312NDNS0OQtOSy0PptZwWEOeGbsmU5FvB3w
 Sheu9am2w0NyPS/H63q4jAHJlHqWwxWCwv1h3yrBtlTpJY05laKgAjNTrxgP9K5IIylt
 uhB2MT5TOKVx17F+hEXKC+V+adwhQdxYC6OCHCY5NhysQ48bf9R7BvXBhVIogsN6ujR+
 Nc8w==
X-Gm-Message-State: APjAAAXbc9u8GfLWEa/4LzJL52xbz4ZVp0nHM/bMS5fsWI1xYYG2vziV
 E9i4+EhZsstkfkOx2E/kFBvRouQ0unI=
X-Google-Smtp-Source: APXvYqwDbOD1ewCRn7i+Jewew/bde7VltKBdJCPsWwh083ZOrlnRJb0271Bnsc2H22b0DxZnIC4IgA==
X-Received: by 2002:a2e:85d7:: with SMTP id h23mr6652554ljj.129.1567789071186; 
 Fri, 06 Sep 2019 09:57:51 -0700 (PDT)
Received: from octofox.cadence.com
 (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
 by smtp.gmail.com with ESMTPSA id g13sm1015296ljj.73.2019.09.06.09.57.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 06 Sep 2019 09:57:50 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri,  6 Sep 2019 09:57:36 -0700
Message-Id: <20190906165736.5612-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.11.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
Subject: [Qemu-devel] [PATCH] linux-user: drop redundant handling of
 environment variables
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU_STRACE and QEMU_RAND_SEED are handled by the parse_args, no need to
do it again in main.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 linux-user/main.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index c9d97d2b1fc6..22ae2b3e65d1 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -701,13 +701,6 @@ int main(int argc, char **argv, char **envp)
 
     thread_cpu = cpu;
 
-    if (getenv("QEMU_STRACE")) {
-        do_strace = 1;
-    }
-
-    if (seed_optarg == NULL) {
-        seed_optarg = getenv("QEMU_RAND_SEED");
-    }
     {
         Error *err = NULL;
         if (seed_optarg != NULL) {
-- 
2.11.0


