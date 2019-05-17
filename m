Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E59C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 22:23:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E74A2166E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 22:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rW9a0FsR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E74A2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54456 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRlGB-0004Dg-R0
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 18:23:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kumar.gala@linaro.org>) id 1hRkFD-0004wu-Q5
	for qemu-devel@nongnu.org; Fri, 17 May 2019 17:18:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kumar.gala@linaro.org>) id 1hRkFC-0005Bj-QJ
	for qemu-devel@nongnu.org; Fri, 17 May 2019 17:18:23 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:43710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kumar.gala@linaro.org>)
	id 1hRkFB-00059k-IH
	for qemu-devel@nongnu.org; Fri, 17 May 2019 17:18:22 -0400
Received: by mail-oi1-x235.google.com with SMTP id t187so6160000oie.10
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 14:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=JaZpasU5CpUK6qq8mRcZdxOWtWzK03H7UDQhpXUaq6w=;
	b=rW9a0FsRSZHwDEinext4Y427fZ9YAmYk4ynMerFgM2lApu8fRKqX+K9n7OIBOVspgk
	y2hyjzsdFBa+VR9Nn9P3jSnW3iBBfmuz40L1S0rNv9TzcXvdSYVlJe6NInV39cnonwWy
	1jhUml8YYDpy6TsJ0Cpz7PDSG/xReJbLlQeOgDimMGjflp0zcrci71ZEveY2dK3OU/FU
	syJvoxujzed77+/azRIDvowIW6Xt3v34zDHjuFh2qC5Bibut95zY//4vzMjZ+2gXb1p7
	o0w+1nTas63qdvuBJESaF8GB69d2dtKFuYRwFyENLdvTBrVL1FEu7BV2wPH8wJxEMiPV
	gP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=JaZpasU5CpUK6qq8mRcZdxOWtWzK03H7UDQhpXUaq6w=;
	b=rxDVoKnOZoaXPwgR0zfRgM0rOw8MKdKJSP7jpBNF2THtcdKySqkzSZw0GkcYe5joOs
	IEyRt8LyF2ssw4MQldW0JNSwg0j57E22HIsjecyIsnCtm4QteiCHslJRY5UZeQISqpUC
	2pdF5/DwNglOwB8UbFoyZJ8JOcHFG/Ts7s2wzKoanEL3S6W3Scvq8RERGz/BnNbKkK1a
	DX08QpDP177/Kv24gj2Yx5dL6jhNLULRDgGHnJ/d5mG8kYcbWvRK5LnF3KtlOZytME++
	BqYe9fsv42vai8NUD38FUMEvImxNWmhrVC1xn7GPwlWL7/LZifMqzC1Jg8yNusgGu6tc
	9wIg==
X-Gm-Message-State: APjAAAXti9+VXJYqAIsMa1jNWfJ1c5d0kIALvt2gAN1CFM5db+qRSqIT
	BEJOIzX/akHCp9wZoU7y8/O/rwpXA04ggA==
X-Google-Smtp-Source: APXvYqw6rYzN7sMbuqY4+gKjLBbYvxRiGd7jV1uV/2jFL+htSXHui/AQOFzo+OHZVw6Y+duN+hwNHA==
X-Received: by 2002:aca:4c83:: with SMTP id z125mr15213057oia.60.1558127897989;
	Fri, 17 May 2019 14:18:17 -0700 (PDT)
Received: from localhost.localdomain
	(108-248-84-146.lightspeed.austtx.sbcglobal.net. [108.248.84.146])
	by smtp.gmail.com with ESMTPSA id
	t14sm3137973otm.15.2019.05.17.14.18.17
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 17 May 2019 14:18:17 -0700 (PDT)
From: Kumar Gala <kumar.gala@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 16:18:05 -0500
Message-Id: <20190517211805.31918-1-kumar.gala@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::235
X-Mailman-Approved-At: Fri, 17 May 2019 18:22:11 -0400
Subject: [Qemu-devel] [PATCH] configure: Only enable iconv if curses is
 enabled
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
Cc: peter.maydell@linaro.org, Kumar Gala <kumar.gala@linaro.org>,
	kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

iconv is only used with if curses is enabled, there's no need to do any
configure checking for iconv, if curses is disabled.  Also, ignore
--enable-iconv if curses is already disabled.

Signed-off-by: Kumar Gala <kumar.gala@linaro.org>
---
 configure | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index d2fc346302..a1b60fa977 100755
--- a/configure
+++ b/configure
@@ -1235,13 +1235,18 @@ for opt do
   ;;
   --disable-stack-protector) stack_protector="no"
   ;;
-  --disable-curses) curses="no"
+  --disable-curses)
+      curses="no"
+      iconv="no"
   ;;
   --enable-curses) curses="yes"
   ;;
   --disable-iconv) iconv="no"
   ;;
-  --enable-iconv) iconv="yes"
+  --enable-iconv)
+      if test "$curses" != "no" ; then
+	  iconv="yes"
+      fi
   ;;
   --disable-curl) curl="no"
   ;;
-- 
2.20.1


