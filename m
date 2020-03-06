Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96219C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:38:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61DF72072A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S380BV/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61DF72072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGv9-0000nQ-GM
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 12:37:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jAGbm-0000aN-Em
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:17:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jAGbl-0007vT-6t
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:17:58 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:36179)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jAGbl-0007tZ-00
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:17:57 -0500
Received: by mail-wm1-x32e.google.com with SMTP id i14so3194984wmb.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 09:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=vrW9XF6BLQAnIhvTlU5HbFtHoyw3EceDEO0yqvg7TFQ=;
 b=S380BV/+pCVYsEPPtZ1nkWRHqHspAj4EN2Xa4dVV17/hKQf5CDTniObVMlkhp229lY
 EDm0ixeL8YzfjuFnH8JsUgH98eoHYP5u6joh27Mzun6Pzuy4YP5I5revvJxL4X7QapV1
 vgqgls9Ua2lPS7PRC2abb7F6UARCO0/7wQXKTYwEusFW+Mu/5KvDFga6CP4vMRHG4NEB
 qBP0U7zfo5lAekdgXxD53TezQR8SiwGsCflTTcbCuVvYzUAhIRzrJpKjEjO7M12UAKm+
 mpWXXrxwFGvnuIsNtssqLJoNe88r6eUSpoaFVT0u2r7QvpCsEFGr1VTmWCgCtlWYcnGw
 bwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vrW9XF6BLQAnIhvTlU5HbFtHoyw3EceDEO0yqvg7TFQ=;
 b=XqOB7puLl4dZlWQUDNX7FG6AwrwyR0PjQhoN11r8C8IkQTWIiV7c6N1Z8wNFUYURQH
 o4OWv8zhmEzPAuKDlVzKDjBCuH74JyORZafrBSUCj836memQN7aCD+knrzaLftatx7+z
 bs2Ge4iTEhIm7ZRUpcboT996odCR8Y20MzCe8BpGBQIkg1NXcs5dOhoH9xeSibqc849l
 pWamQrB7zXA0x3vsPWY8LfQ43MkUC3Hg9GBAg2axOr1ratON/+ja1PUnmvXXRuPp3i6L
 37MhABGgrJG80Ev1fRK1swfVPSZo1gOOxzJ5KgvtkBTFwuywCKGA17TzypUPtz2cnABh
 5IhQ==
X-Gm-Message-State: ANhLgQ0HWl42ZF+ySLcxaRPkWsmDEiOeGn4Abp7Wa8R1aPGHje8XqCD0
 exvYQp2ukYakQxFmNiHtOc4v8oE133vOzA==
X-Google-Smtp-Source: ADFU+vvdSykBeY5TH0fq2JmoCyaJzn3xd6NycMX5Q1lRpGY3T11IZrRcBaIfjosW9MHJ62VQY+RP8g==
X-Received: by 2002:a7b:ce18:: with SMTP id m24mr4998902wmc.123.1583515075734; 
 Fri, 06 Mar 2020 09:17:55 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f8sm6948346wmf.20.2020.03.06.09.17.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 09:17:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/7] docs/sphinx/hxtool.py: Remove STEXI/ETEXI support
Date: Fri,  6 Mar 2020 17:17:46 +0000
Message-Id: <20200306171749.10756-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200306171749.10756-1-peter.maydell@linaro.org>
References: <20200306171749.10756-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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

Now that none of our input .hx files have STEXI/ETEXI blocks,
we can remove the code in the Sphinx hxtool extension that
supported parsing them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/sphinx/hxtool.py | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/docs/sphinx/hxtool.py b/docs/sphinx/hxtool.py
index 7dd223fe362..fb0649a3d5b 100644
--- a/docs/sphinx/hxtool.py
+++ b/docs/sphinx/hxtool.py
@@ -37,13 +37,11 @@ else:
 
 __version__ = '1.0'
 
-# We parse hx files with a state machine which may be in one of three
-# states: reading the C code fragment, inside a texi fragment,
-# or inside a rST fragment.
+# We parse hx files with a state machine which may be in one of two
+# states: reading the C code fragment, or inside a rST fragment.
 class HxState(Enum):
     CTEXT = 1
-    TEXI = 2
-    RST = 3
+    RST = 2
 
 def serror(file, lnum, errtext):
     """Raise an exception giving a user-friendly syntax error message"""
@@ -110,31 +108,13 @@ class HxtoolDocDirective(Directive):
 
                 if directive == 'HXCOMM':
                     pass
-                elif directive == 'STEXI':
-                    if state == HxState.RST:
-                        serror(hxfile, lnum, 'expected ERST, found STEXI')
-                    elif state == HxState.TEXI:
-                        serror(hxfile, lnum, 'expected ETEXI, found STEXI')
-                    else:
-                        state = HxState.TEXI
-                elif directive == 'ETEXI':
-                    if state == HxState.RST:
-                        serror(hxfile, lnum, 'expected ERST, found ETEXI')
-                    elif state == HxState.CTEXT:
-                        serror(hxfile, lnum, 'expected STEXI, found ETEXI')
-                    else:
-                        state = HxState.CTEXT
                 elif directive == 'SRST':
                     if state == HxState.RST:
                         serror(hxfile, lnum, 'expected ERST, found SRST')
-                    elif state == HxState.TEXI:
-                        serror(hxfile, lnum, 'expected ETEXI, found SRST')
                     else:
                         state = HxState.RST
                 elif directive == 'ERST':
-                    if state == HxState.TEXI:
-                        serror(hxfile, lnum, 'expected ETEXI, found ERST')
-                    elif state == HxState.CTEXT:
+                    if state == HxState.CTEXT:
                         serror(hxfile, lnum, 'expected SRST, found ERST')
                     else:
                         state = HxState.CTEXT
-- 
2.20.1


