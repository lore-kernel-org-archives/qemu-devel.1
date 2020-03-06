Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23CFC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:17:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A97E12073B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SLV2a73B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A97E12073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAAzI-00007P-OM
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 06:17:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jAAsN-0004AV-Gh
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jAAsI-0005fJ-5R
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:39 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:35576)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jAAsH-0005cf-SW
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:38 -0500
Received: by mail-wm1-x331.google.com with SMTP id m3so1937287wmi.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 03:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=nwDKZHHvTc1aVEH0nGRr033YOq+xaIEkMAUFu/T4EaE=;
 b=SLV2a73BLGk64Vok3tBpLicIgp068BbQC7b88H4U2CLdl37REX7pCYCI7kk2tAyqSV
 4mrA7LH4V+WBI/b8ILDxXybOhTmFCeaL8Cv7zeANZqCatKh9bVnS19T56MxJx6NbwDEv
 JDyFecaTjAq70bjo8qzbXdPLzQWBxFGA0nJnKFxNF2iqCWhPmcpYZ9zR3XBHjQ3gY6r2
 9NUqoLHsPGwwR1pdp44Mks+3ETlWjzWdqRGCbRhcYUhlntw/4saJREXLE9IdgMUMkWxU
 NlpbT6Kig95wzTNCnpNiS+FObAdp2F2+JuCOEJhl6AosY80kG0UO4mIXvwev77cVpfRD
 NVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nwDKZHHvTc1aVEH0nGRr033YOq+xaIEkMAUFu/T4EaE=;
 b=YlFqonA71i2xTafIF0vY4qisGUwp5g6Rme4wt5vmtx0e7NxrCtHqhqhkNuhcWbe42G
 sBxcLapCI4cQKbnPtRXbV3iuBB98xVHI6iJz7QoF3TmwYXLiWUyweEceBWGE0sMVtab7
 wguVsuD+33e4W3/dWd+KRRIlLRI3SX+zat0cr046SdqUQ3RiCBLLxkxi8Kd5TYCFXyl6
 82IaLeyT9gVxCyP/XjVUdHNTk9h32PMAttPFy7UNaj9lCsbUiKwzGiU/+TAQ9gCjt67S
 OgCjbnFUhjvsCVgB6ZRjHPa1szwGrN6l9EOILleRvrTJErAyCjgsDoe0eXBRc6RDhPcE
 oBZQ==
X-Gm-Message-State: ANhLgQ0v2mezBlXtpZnZ6JB+EuGpfE3jsmXDt8ghNW9tDqGdCf3K9ezS
 FDhSgsgIABO4JiHg+m/YvKi0GYV82cn2Ig==
X-Google-Smtp-Source: ADFU+vur8Ka+Qo2x/cjBLrzg/Nl2VpwbkcpqF/O2jszYOXUWrIzOlvnbjRXLtWI4IWNtpzCL5To/IQ==
X-Received: by 2002:a1c:8041:: with SMTP id b62mr3413828wmd.76.1583493034579; 
 Fri, 06 Mar 2020 03:10:34 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y10sm12553029wma.26.2020.03.06.03.10.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 03:10:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/33] doc/scripts/hxtool.py: Strip trailing ':' from
 DEFHEADING/ARCHHEADING
Date: Fri,  6 Mar 2020 11:09:48 +0000
Message-Id: <20200306110959.29461-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200306110959.29461-1-peter.maydell@linaro.org>
References: <20200306110959.29461-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

In hxtool files, section headings defined with the DEFHEADING
and ARCHHEADING macros have a trailing ':'
  DEFHEADING(Standard options:)

This is for the benefit of the --help output. For consistency
with the rest of the rST documentation, strip any trailing ':'
when we construct headings with the Sphinx hxtool extension.
This makes the table of contents look neater.

This only affects generation of documentation from qemu-options.hx,
which we will start doing in a later commit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20200228153619.9906-23-peter.maydell@linaro.org
---
 docs/sphinx/hxtool.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/docs/sphinx/hxtool.py b/docs/sphinx/hxtool.py
index 5d6736f3002..7dd223fe362 100644
--- a/docs/sphinx/hxtool.py
+++ b/docs/sphinx/hxtool.py
@@ -60,8 +60,9 @@ def parse_defheading(file, lnum, line):
     # empty we ignore the directive -- these are used only to add
     # blank lines in the plain-text content of the --help output.
     #
-    # Return the heading text
-    match = re.match(r'DEFHEADING\((.*)\)', line)
+    # Return the heading text. We strip out any trailing ':' for
+    # consistency with other headings in the rST documentation.
+    match = re.match(r'DEFHEADING\((.*?):?\)', line)
     if match is None:
         serror(file, lnum, "Invalid DEFHEADING line")
     return match.group(1)
@@ -72,8 +73,9 @@ def parse_archheading(file, lnum, line):
     # though note that the 'some string' could be the empty string.
     # As with DEFHEADING, empty string ARCHHEADINGs will be ignored.
     #
-    # Return the heading text
-    match = re.match(r'ARCHHEADING\((.*),.*\)', line)
+    # Return the heading text. We strip out any trailing ':' for
+    # consistency with other headings in the rST documentation.
+    match = re.match(r'ARCHHEADING\((.*?):?,.*\)', line)
     if match is None:
         serror(file, lnum, "Invalid ARCHHEADING line")
     return match.group(1)
-- 
2.20.1


