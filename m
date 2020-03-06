Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11D1C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:27:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7BFA2072D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qSPyRwf1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7BFA2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAB8K-0001Jz-RO
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 06:27:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40194)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jAAse-0004YW-BM
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:11:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jAAsU-00067T-8j
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:59 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:55356)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jAAsT-000657-W4
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:50 -0500
Received: by mail-wm1-x333.google.com with SMTP id 6so1921439wmi.5
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 03:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ohs9Otf2cvL4qP/fbKtn8DSCDnRv4jYFVg8c3pXFWWM=;
 b=qSPyRwf1u7uFQ0XcDmP1A4URqBLMI7Ew4dYcQwPEtZXTDPTAlw8uYtWTJOiAMHjYWU
 rRD6GnCHKZP0uaC8IcSulrdRcazLHL+qA9HW6OXp/OgJ0crNVqXNrVl0N4tkh4h1Uw68
 MGhORw4HLhBGB/s5aOTlmJC2AYjbnDF/+xkN0tvB97wk5e1pwjzqQ0zxoLRbSuuPmgGN
 6eXsh80dp2qcVBcQzSEXCsAQWNVGe2sSwRje+OjL6fja5bLDWkzUDv2yYXHs+CG35IT3
 RiLqQArgECbJI1FF7PC4ClCBXMqA5kfx7FlwqRr3AfFNpIkpygzT1lG9chUE68LkiodY
 8dhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ohs9Otf2cvL4qP/fbKtn8DSCDnRv4jYFVg8c3pXFWWM=;
 b=nOIBltt65HVaQZrhb1ysAC38DEekTp6RVzzMHlkCDfJ3r4Je6bTJ6asweNAV0C6fAu
 Zjt8EKRAzu6HU8ebu8w0vSVNbCU34QYa81Ye7Q+OWXiundz+O+qwQOO8TXfnXFNFYegR
 rKpn/3jpnYEgWizzwLhxqVKE4qxN0rDdnndWhW8XTeW7KxgdLCRtacsJOIwkqLfnjBOH
 dJ8r/3Cn6a5el4i1RanjSkufG8CxdS3a3jDThBFuhrAe3uWvOig4+zmZ4ArtZYZh+EOD
 e7poudFV8oocMMmoxn3jFSwcizIS6gNGr5MuFSpPh5wGjc4KzIpC78yhd/EuuwMIj7uD
 kaXA==
X-Gm-Message-State: ANhLgQ0e/O5KiTnPO0XfQPpLcJORARmk8bJ16LPluL4QADJNg6g5UxEB
 ITahkzgBygW3RXTS+JpYTTcnTH6sNTqq7g==
X-Google-Smtp-Source: ADFU+vvSTobYbMJv/1aBEoyAIALJQ+OgBisV9Xb913l+qGjScy4VjSKmZBA81RP0JiIwkOj7Y8G9iA==
X-Received: by 2002:a7b:cb93:: with SMTP id m19mr3635698wmi.133.1583493048702; 
 Fri, 06 Mar 2020 03:10:48 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y10sm12553029wma.26.2020.03.06.03.10.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 03:10:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/33] ui/cocoa.m: Update documentation file and pathname
Date: Fri,  6 Mar 2020 11:09:56 +0000
Message-Id: <20200306110959.29461-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200306110959.29461-1-peter.maydell@linaro.org>
References: <20200306110959.29461-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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

We want to stop generating the old qemu-doc.html; first we
must update places that refer to it so they instead go to
our top level index.html documentation landing page.
The Cocoa UI has a menu option to bring up the documentation;
make it point to the new top level index.html instead.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20200228153619.9906-31-peter.maydell@linaro.org
---
 ui/cocoa.m | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 747a70839af..cb556e4e668 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1174,7 +1174,7 @@ QemuCocoaView *cocoaView;
 - (void) openDocumentation: (NSString *) filename
 {
     /* Where to look for local files */
-    NSString *path_array[] = {@"../share/doc/qemu/", @"../doc/qemu/", @"../"};
+    NSString *path_array[] = {@"../share/doc/qemu/", @"../doc/qemu/", @"../docs/"};
     NSString *full_file_path;
 
     /* iterate thru the possible paths until the file is found */
@@ -1198,7 +1198,7 @@ QemuCocoaView *cocoaView;
 {
     COCOA_DEBUG("QemuCocoaAppController: showQEMUDoc\n");
 
-    [self openDocumentation: @"qemu-doc.html"];
+    [self openDocumentation: @"index.html"];
 }
 
 /* Stretches video to fit host monitor size */
-- 
2.20.1


