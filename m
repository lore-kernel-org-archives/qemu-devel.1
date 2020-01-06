Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3359EC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:26:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F09E224676
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWJv08rP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F09E224676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioX5P-0003YB-Oy
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:26:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44926)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX3f-0001Mm-Tv
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:24:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX3e-0003dR-Q6
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:24:55 -0500
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:39310)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX3e-0003d3-KO; Mon, 06 Jan 2020 13:24:54 -0500
Received: by mail-qk1-x744.google.com with SMTP id c16so40275737qko.6;
 Mon, 06 Jan 2020 10:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BPtzP3vwdKJDYfiK+1V5sLIQfxo+hk+yi1CNnAf7kDI=;
 b=JWJv08rPQVD7dn31fA27RO0L1TkNs1eZ9KXvmtdm0n7e2b3V2eAIbZttqeAX1H5Rte
 Avc+0JE3rvoP7GzJvhfOJ5ewaz3VJA8JSAMPIEbsKh1adEh4g1QXbfSEVxbQjoFqikk4
 BtI1GUO3uQlj9ymIAnA6TsItIgbn3CABvoQb5Qd3aeGUH+/2fAjRGSSclE99FWzTI1zS
 D7IiLxILsyuC3+Yfx5T6a7s8n1INXpR9QVEZWm2K2cnvrQQtTrSACyBoKJzs8nYrD7Ja
 Tqfhpqa1OHtwL+kO1m+RmsjjWV5ViP3i7YswqofiguV26EAZYI6iOFXTk7q94UMJcUpy
 g37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BPtzP3vwdKJDYfiK+1V5sLIQfxo+hk+yi1CNnAf7kDI=;
 b=LNkij0JqX25hjDF3zASaW8heATGHWZGBMDFdsMaoyIm1NBkd/A5N4WywYMPNv+J2Ev
 aYEniwLzUayM7S/280bJvCFSUwT5CCV6ZevYjcRmC54xKwUwGRLOv/ovJUBligb9R5rZ
 QU5nVvJm7iRuUFGugxetpo/V2qZ2Mdl9EIVI4zXrLFgOUisBeO+8oepvdPS8NbNYpdg+
 hSXDpJAy+hJizn+xaHMXfsY2zNXjuTIz2itK7q1w+nOv3FLMnj2kzS9ZzdgO4J5fa+SY
 dBoM9aBu9glhNtiggpj6swbu9fmUKRzKB7YoBTKveDP2L9Ggi/b/01nsREaUs0WvN8yV
 /1vA==
X-Gm-Message-State: APjAAAUqb+GePkxdx7yVyxDQ1ZikRp4kdbiAeCW28pUjsW3kWChCX+05
 gBFi1C91RC8wiiPRaRRLQi4Qt76s
X-Google-Smtp-Source: APXvYqzSvXtub0j4T5AEHx49CbNdWuauWRDEVcXL7gZSK9eZLojO15sNyMdKc7IVkJTQgyCJfdjIaw==
X-Received: by 2002:a37:48f:: with SMTP id 137mr83913337qke.25.1578335093972; 
 Mon, 06 Jan 2020 10:24:53 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.24.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:24:53 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 01/59] spapr.c: remove 'out' label in spapr_dt_cas_updates()
Date: Mon,  6 Jan 2020 15:23:27 -0300
Message-Id: <20200106182425.20312-2-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
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
Cc: qemu-trivial@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'out' can be replaced by 'return' with the appropriate
return value.

CC: David Gibson <david@gibson.dropbear.id.au>
CC: qemu-ppc@nongnu.org
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/spapr.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f11422fc41..1bfe47337c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -878,7 +878,7 @@ static int spapr_dt_cas_updates(SpaprMachineState *spapr, void *fdt,
         g_assert(smc->dr_lmb_enabled);
         ret = spapr_populate_drconf_memory(spapr, fdt);
         if (ret) {
-            goto out;
+            return ret;
         }
     }
 
@@ -889,11 +889,8 @@ static int spapr_dt_cas_updates(SpaprMachineState *spapr, void *fdt,
             return offset;
         }
     }
-    ret = spapr_ovec_populate_dt(fdt, offset, spapr->ov5_cas,
-                                 "ibm,architecture-vec-5");
-
-out:
-    return ret;
+    return spapr_ovec_populate_dt(fdt, offset, spapr->ov5_cas,
+                                  "ibm,architecture-vec-5");
 }
 
 static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
-- 
2.24.1


