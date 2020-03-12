Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D357C4CECE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 11:47:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FC3E2073E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 11:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vTmwaRAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC3E2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCMIt-0000QF-Gm
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 07:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCMGA-0003Um-7d
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:44:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCMG9-00022i-0I
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:44:18 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:35935)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCMG8-00021q-QG
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:44:16 -0400
Received: by mail-wm1-x332.google.com with SMTP id g62so5922283wme.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 04:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=8Ns4C0QWDYdgHc/0sLmGsAuNfWOgxN1irF3iygAMeMI=;
 b=vTmwaRAizjlAyPZa7dZRNHLHmiZsjReJpVJIRFds1SzfNHaT+S6khBsci5GqZKGJlM
 l3xrDMEDpkv3eNo3pYh7IbxDh10MoLNKrEDyRmtze9NIY+FQuw1FdV7qATCCn/NfKCep
 QcdC/ijeZI0VaSx+Fpk9W8XAXhm1eKqXiQxuLrLTz/vfeueIYjfHnQRS5TtEZKcaBkU4
 J4zCzP5uQRJ0dylsfANex2CMIoFlZI4qOBnRkfwQTpjfu+gkXt5f5cwp6y9sN6l1j8M9
 f2AaProS8mEOkMSd3YAT2HGH7vFiQr4CjruwzAUgwrnRgAwG9b/C9fd+lGgSZYH3iHZ0
 7eiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8Ns4C0QWDYdgHc/0sLmGsAuNfWOgxN1irF3iygAMeMI=;
 b=bjmyUV1b8tR9RmjAGbeV+/Zud0C1692RVGw05g7/RxiDz6oVjBcuE78H/bT1jAelVJ
 C3xEfbyqP+AI1w05SAwK8bJabeLlMhVyWYPaC2/9RW/GRsk7+S+BzytiUGqIbJW1xibq
 Y3Jgyy7y4MRfv+fTnDUQ3iHWEdBvv3WUBk3wwsJgOU+tiWXQMhtYftFirWKqZY+faxQG
 D25NFgRPpPa7dwbDvdKSW4Nli2EPx+1j+pxfQS47v+/GvWGriCLPWwCtT1SnJ27JF9to
 kp7k4iTYBs0hl8yZ+0yyS8ye2NhkJ+uoEapF9WNx8tjUwgmFSR0nhNNz/3b0hGk5uL36
 2zuA==
X-Gm-Message-State: ANhLgQ1NqEfWx+dgP1qqA6zrEX7KSaQX5Q47+Uj0nAy6JdCQ/JAPmVpL
 gDuc2XOFqathXnbIbdUntK8dfcpUqvryJw==
X-Google-Smtp-Source: ADFU+vtXdZKJwBQAbo685mkkT9Jfau7WPZugN4FA4ahIx9Ure4UQvbYHuNUuQrli1y0gQnMeySxjnQ==
X-Received: by 2002:a1c:63c4:: with SMTP id x187mr4478014wmb.124.1584013455582; 
 Thu, 12 Mar 2020 04:44:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p16sm2688564wmg.22.2020.03.12.04.44.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 04:44:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/12] docs/sphinx/hxtool.py: Remove STEXI/ETEXI support
Date: Thu, 12 Mar 2020 11:44:00 +0000
Message-Id: <20200312114408.16891-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312114408.16891-1-peter.maydell@linaro.org>
References: <20200312114408.16891-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200306171749.10756-5-peter.maydell@linaro.org
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


