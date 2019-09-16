Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C293C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:10:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4178F20665
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pAj2TAAJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4178F20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9seM-0001TM-PC
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 11:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53649)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sCs-0006Ow-K2
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sCr-0007Rx-0S
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:22 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:54515)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1i9sCq-0007RF-3E
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:20 -0400
Received: by mail-wm1-x334.google.com with SMTP id p7so59559wmp.4
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E+2MN0bdyQ/s8snWDk5tAnhwggMh7vntuwQ/7buJlTc=;
 b=pAj2TAAJ/t4u1xKJLvN7dUtOPfvCc2EvoLUnGwcqFW1MR9J/X1IL71mqHLPO+ITYEi
 9A2PNdAxZCdYNIYw2mUlAFndEDGm8Xl2H/2v49P0p5kglG7DUS2fch1zfTmHz3n96MTs
 Ol/nW6dTggJu+3+fTSykPviC0+k3uOrEMOFi6crWpv+1oWtaGsAUpoCuO4p0uhvN7qv2
 qqgaW9ei2TJPOYiRHpZe3Sfahr+z7PB+cwJg8jaowmiWwCO0dkiqanF+1Ye9hZlXqON7
 aqNCXML9gPNb4idDFU//P6vs/ROpx5glJ50eAiD7DfB/eaI/R52Kr361S6ShMASN1ybi
 rAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=E+2MN0bdyQ/s8snWDk5tAnhwggMh7vntuwQ/7buJlTc=;
 b=ENPPiWm3C5+Edwby5rKewwH4O95ql8t81qYETBFXCDlYSb280kj0VRlLK3Lf8Hg/GF
 5s+FR7M7kQCT9muDsdmk/f9B/5VybednhvPfV0PeeB5vFlN5wrsFcqRFvO6B/r+5xdpJ
 DifmORvHprWfiKYkT9V4y1PvyzE7fjAfPg9cFUz/t2IYs62NDCUqSG9K5R18z/FnNm+s
 uVFkrL4r1bjB8k44oOvnwCQeCicT9pwgo/nNLJ7tOlmcFWZa0IB7W/EIns5AsMzK1THa
 +0Gh+Fvq9QvdQrLHg/tMismBPte+Rq4z+elB2Ay58DriJqdVgC2EF6iheJApea+69JiU
 XGsQ==
X-Gm-Message-State: APjAAAVx+T0NA9CAWlBAc/bAAYtTRJRY/OXty+gG/jE1OeUDYfYC/yZg
 OtWwb6mxMbbCeGpRI4pTEelyXJhg
X-Google-Smtp-Source: APXvYqwhFYWbg+JSV1g5vTmwBxvsqoxikxCR0ExmPZgdt6VCWXflYS0U7GROgzyyAUGzCCJ90qZI8A==
X-Received: by 2002:a7b:c3c6:: with SMTP id t6mr45589wmj.5.1568644937697;
 Mon, 16 Sep 2019 07:42:17 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id i14sm17024298wra.78.2019.09.16.07.42.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Sep 2019 07:42:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 16:41:47 +0200
Message-Id: <1568644929-9124-8-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
References: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
Subject: [Qemu-devel] [PULL 07/29] win32: fix README file in NSIS installer
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

Adjust after the rST conversion and consequent renaming.

Fixes: 336a7451e8803c21a2da6e7d1eca8cfb8e8b219a
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu.nsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu.nsi b/qemu.nsi
index d0df0f4..0c29ba3 100644
--- a/qemu.nsi
+++ b/qemu.nsi
@@ -119,7 +119,7 @@ Section "${PRODUCT} (required)"
     File "${SRCDIR}\Changelog"
     File "${SRCDIR}\COPYING"
     File "${SRCDIR}\COPYING.LIB"
-    File "${SRCDIR}\README"
+    File "${SRCDIR}\README.rst"
     File "${SRCDIR}\VERSION"
 
     File "${BINDIR}\*.bmp"
@@ -211,7 +211,7 @@ Section "Uninstall"
     Delete "$INSTDIR\Changelog"
     Delete "$INSTDIR\COPYING"
     Delete "$INSTDIR\COPYING.LIB"
-    Delete "$INSTDIR\README"
+    Delete "$INSTDIR\README.rst"
     Delete "$INSTDIR\VERSION"
     Delete "$INSTDIR\*.bmp"
     Delete "$INSTDIR\*.bin"
-- 
1.8.3.1



