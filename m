Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941A8C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:26:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EF3E21734
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ik1UDyf+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF3E21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufJN-0003HZ-4n
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:26:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51800)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrh-0005T3-OK
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrg-0004Je-S9
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:45 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:44796)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucrg-0004Ij-Lu
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:44 -0500
Received: by mail-wr1-x42f.google.com with SMTP id q10so3117983wrm.11
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uOLwVK1PbKn7a23VxrQddoHkt+lkpXaQ8CGs7D10ELc=;
 b=Ik1UDyf+lS1zGOKwIDDAtQoKwbjVlJSOzNBvDAqky6Fj+ekqJrSogwQg23ZHiLGu61
 ZbWBqxrGADwZ9bA8DWOWbiuW4VNJltrE6ndR9tg8jS5meLrSI+BfONsQWp1lpPnEB+Io
 F6jgdpFFMMm5kpjP7G/frFYYjSEbxWP8sgjg45VxY1pgdqA5HzUYk9iKlMddknKsyRwt
 gw4lE/+vZGK+RvdxMBlLd5AFf2OfyegLO7yjIXeJgd5znZtre5lNqV3JH8mwpqns7etd
 Ac7HVhvpg6EZLcKevEw7ZvpG3h7IX1caFP5ie+omaTWUYwrYrw1lfhc8E13Hb1amprbX
 lQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=uOLwVK1PbKn7a23VxrQddoHkt+lkpXaQ8CGs7D10ELc=;
 b=Z5c/0EhjbD9HodsCXOKk5Ui9x6dlFp4HF3u684HQ+XOM5K/MGwHkjvRcoU0IXAXIGM
 gOBCCEIw9IzLzUXYAKbKFedrdLu8leX/ZHYgXxS1tccim9Hvx8EBsNieNZjZgOTmIjdA
 Xu3QWGS64YhzI6WKuPr4GRWKKHlrO7MwAqKBefy0PLgteJemmrz/IRnMYGbC+MSssnQE
 JYXZKTsRQ1E6NpemXMcMgD0iKiAvaykdUK6CO/B7pDaYy8VXxTyGNa2tA+TOeWMh3DPt
 L3oS3sXUrQJ++WC1E8KE5U/g7va2ZyqQku4hYsdNkbfcztdUamJMwipzhN1Pwy9VlTJk
 vWMQ==
X-Gm-Message-State: APjAAAUMO8ojesM3fGMCmFBqRzMNJ4TAsXskylue0xpBiWxyETadXek6
 V/3Iu4OEkinfbYNLBeeu3/zHNcD7
X-Google-Smtp-Source: APXvYqxzy8vp3SmSskHB9ems4kNS2XQAF4hYqiTWVQgOUzwR+ezT7Wly0QLzppxdDRpgKmTDVD5vOA==
X-Received: by 2002:adf:c145:: with SMTP id w5mr18139475wre.205.1579787383581; 
 Thu, 23 Jan 2020 05:49:43 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:43 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 42/59] object: check strong flag with &
Date: Thu, 23 Jan 2020 14:48:45 +0100
Message-Id: <1579787342-27146-43-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The following patch is going to introduce more flags.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200110153039.1379601-13-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qom/object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qom/object.c b/qom/object.c
index 30c4f82..fb80013 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1822,7 +1822,7 @@ static void object_set_link_property(Object *obj, Visitor *v,
     }
 
     *child = new_target;
-    if (prop->flags == OBJ_PROP_LINK_STRONG) {
+    if (prop->flags & OBJ_PROP_LINK_STRONG) {
         object_ref(new_target);
         object_unref(old_target);
     }
-- 
1.8.3.1



