Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704A1C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 11:49:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4179E2071B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 11:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wr1NbbbY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4179E2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCMKm-0004Qe-De
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 07:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58118)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCMGC-0003Zp-3z
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:44:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCMGA-00023t-UZ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:44:20 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:38146)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCMGA-00023P-O5
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:44:18 -0400
Received: by mail-wm1-x331.google.com with SMTP id h83so2363213wmf.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 04:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=hATFJW6NZ1276fQrQO4mabOqWwY/vRk7Junh7L7ZlU0=;
 b=wr1NbbbY6ptFMD51j5Qh3+1DknZRnIic71ZQl5xQGZSrqRdcm2wF33VOWfyjg2W61F
 3J++0j3rmAWAC3F+LWO5B7lgEe7/Yi9PPUWveGABgSUR99gxwp8m55+xVD9hdtgpxg2S
 RDlIlMf8wrKYFycHVqdZD1TahjScAsyhMiIAu2fzVkZ5U0SpqJP4A5C/OElxQ+i+BZBm
 fR7xlNjbC+5sUrAyjlh4vJ9DT29L7/Kqku23eoc75YBi5MMVbZpr/qGjtiiYPFDmYTvX
 4U9Vl1eH6zx2oyy8JlPHCGEIEdaPZvgTS4LXnN183DmYMyaE6JVk1pLJP6GXM6ewEmRu
 uBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hATFJW6NZ1276fQrQO4mabOqWwY/vRk7Junh7L7ZlU0=;
 b=kZjeSqfJ49ZsrMlR7osU2cjMH+I1QZpF8gZXwv669RmHjHLCMhNMrd46aBOykcNZNV
 ZTQ5QNFbpB0GbULsgFQoan47C/sMflXM9nnY8o9DVfCKxhvxkgccMBSWJv3UirSK87In
 5bSmer/sAQ2kXfST4RHHLJEpSsbuPWSgPyWEP7YJ0eiPf/ljGCiIygRuNy1DhDnuPo2T
 ufaAYq+hB01+irrGirRie86+45p8Ml5NCCAyjtpJdaIpwnPvr0KJhwgj99o3JbTrr/rG
 EaoeUI7pm+TWXThNxYIRjnGEH7LZ6rK/8Srz+p8pe/BvG9JaxMFx4Y1zP6nnuHADeIe9
 iO7g==
X-Gm-Message-State: ANhLgQ2b3+eXxwXHFydF2Tlsv3MAOBmnjRX4JpsDiagWAEDsqJCihcLT
 4ihfJj1GoLUvwnkwZYLJmOFedych5CDivQ==
X-Google-Smtp-Source: ADFU+vvZaD+z8lnJyIXOlVAe385ZdEQK55Iv0kQmz64FdTDj8OZuFqWwda6QhFDVzZjkqw8M9ucULQ==
X-Received: by 2002:a7b:ce81:: with SMTP id q1mr4654088wmj.156.1584013457378; 
 Thu, 12 Mar 2020 04:44:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p16sm2688564wmg.22.2020.03.12.04.44.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 04:44:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/12] docs/index.rst, docs/index.html.in: Reorder manuals
Date: Thu, 12 Mar 2020 11:44:02 +0000
Message-Id: <20200312114408.16891-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312114408.16891-1-peter.maydell@linaro.org>
References: <20200312114408.16891-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that qemu-doc.html is no longer present, the ordering of manuals
within the top-level index page looks a bit odd. Reshuffle so that
the manuals the user is most likely to be interested in are at the
top of the list, and the reference material is at the bottom.

Similarly, we reorder the index.rst file used as the base of
the "all manuals in one" documentation for readthedocs.

The new order is:
 * system
 * user
 * tools
 * interop
 * specs
 * QMP reference (if present)
 * Guest agent protocol reference (if present)
 * devel (if present)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200306171749.10756-7-peter.maydell@linaro.org
---
 docs/index.html.in | 10 +++++-----
 docs/index.rst     |  8 ++++----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/docs/index.html.in b/docs/index.html.in
index cc19aad2ec5..e9a160384cf 100644
--- a/docs/index.html.in
+++ b/docs/index.html.in
@@ -7,13 +7,13 @@
     <body>
         <h1>QEMU @@VERSION@@ Documentation</h1>
         <ul>
-            <li><a href="qemu-qmp-ref.html">QMP Reference Manual</a></li>
-            <li><a href="qemu-ga-ref.html">Guest Agent Protocol Reference</a></li>
+            <li><a href="system/index.html">System Emulation User's Guide</a></li>
+            <li><a href="user/index.html">User Mode Emulation User's Guide</a></li>
+            <li><a href="tools/index.html">Tools Guide</a></li>
             <li><a href="interop/index.html">System Emulation Management and Interoperability Guide</a></li>
             <li><a href="specs/index.html">System Emulation Guest Hardware Specifications</a></li>
-            <li><a href="system/index.html">System Emulation User's Guide</a></li>
-            <li><a href="tools/index.html">Tools Guide</a></li>
-            <li><a href="user/index.html">User Mode Emulation User's Guide</a></li>
+            <li><a href="qemu-qmp-ref.html">QMP Reference Manual</a></li>
+            <li><a href="qemu-ga-ref.html">Guest Agent Protocol Reference</a></li>
         </ul>
     </body>
 </html>
diff --git a/docs/index.rst b/docs/index.rst
index 376dab28850..763e3d0426e 100644
--- a/docs/index.rst
+++ b/docs/index.rst
@@ -10,9 +10,9 @@ Welcome to QEMU's documentation!
    :maxdepth: 2
    :caption: Contents:
 
-   interop/index
-   devel/index
-   specs/index
    system/index
-   tools/index
    user/index
+   tools/index
+   interop/index
+   specs/index
+   devel/index
-- 
2.20.1


