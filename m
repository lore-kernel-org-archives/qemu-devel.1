Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE977C2D0BF
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:08:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD68A206EC
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTS/parC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD68A206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtrY-00046D-EC
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 12:08:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFT-0005bJ-NO
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFS-0008Mc-PF
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:31 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:36057)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtFS-0008LH-JE
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:30 -0500
Received: by mail-wr1-x42d.google.com with SMTP id z3so514377wru.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=qI31Sr5BEfau7aDI/0J1srKK7YhXgQE1cLHiZE6Vp/I=;
 b=OTS/parCwNrF2TlmQ0yjUAw2H3QlPPKK0fOS30Su5MtOBKitWYfuNZfBRKkW3yupve
 HfaVcA/tFOOVxusw5grNEjKzbcRjHE1LXFQlToK2Uf9ZVLyn4/inJ3MT7sxPVITyr5fF
 6/DbrorkSvJ7kATeNzilCnEPg4WCpb1waPey8S6QvAAPjHWvzMUBZoWuCMqsp+8A36LO
 Qvr62eV1kTa/Knf3o1Yh8XhJHnvoCPQVYi8a28+gpK7tZ92ltWqClIpUJjtYlvq4MN0D
 Z82DijNv1nCMaf83Fy9WRal8BNPKeOagnIBcIQHklPDhuPOsQsrNDyU6NLHp4v+aZ6R+
 M4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=qI31Sr5BEfau7aDI/0J1srKK7YhXgQE1cLHiZE6Vp/I=;
 b=gGQNI3tC3BpzJQzeajvkDfuM2/8zfRG89bMbXYPzslaYpFmio7lLp//Kc4sXZRYYJ+
 KlgMyJqhpLRt97/K16J7+uDPWwJSxcEyg7uN9G6EWt9iXDR/AVIkrsWqfqjOlr/l79e9
 5BUR7weQQ6q45CNbqugKEOsVrXcuoQLr8vM2aihim/VNhYZ3meNO1QBnPgq1GXWQi/C9
 KcPYnMoymI176kRjIwuern4O9Zw1qHfb+DRkmY/AePKk7A45vG0LPC9edbKJj3sKCBbv
 vX9CHmMTmMqDDzTpWyEprASI2ZGmbzhgLCiGas0OMHtDxjIaqSAiREy1h9Ot2BuCVbIX
 oj9A==
X-Gm-Message-State: APjAAAUR8JfI7u3G4c5OpscNz8UKX6eKdBFuwd72z6AdeTavNrka9sEh
 CykApH5Chc/81mgznab8BFC54WaO
X-Google-Smtp-Source: APXvYqwuS2IL4+BBq4x83WtOT40nzDSCMv2wSR473DwG3MckOmnKndf8atuyKmVFES9IDrb1p9/cMw==
X-Received: by 2002:a5d:6206:: with SMTP id y6mr30351583wru.130.1576513769244; 
 Mon, 16 Dec 2019 08:29:29 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:28 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 42/62] configure: set $PYTHON to a full path
Date: Mon, 16 Dec 2019 17:28:26 +0100
Message-Id: <1576513726-53700-43-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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

This will make it possible to replace it in a shebang line.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 394f7f5..bbb8611 100755
--- a/configure
+++ b/configure
@@ -909,7 +909,7 @@ for binary in "${PYTHON-python3}" python python2
 do
     if has "$binary"
     then
-        python="$binary"
+        python=$(command -v "$binary")
         break
     fi
 done
-- 
1.8.3.1



