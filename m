Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25ABC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:15:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E7062071E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tde2CATV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E7062071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuf8K-0002Z3-8d
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:15:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrV-00059Q-DL
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrU-0003dp-Cr
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:33 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:32914)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucrU-0003bQ-6U
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:32 -0500
Received: by mail-wr1-x432.google.com with SMTP id b6so3193706wrq.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kxEhjtEiGmz3JhKefGP6i9CMB+/OyKskAJ9ppHwR4AA=;
 b=tde2CATV/AmzKhBEGnx/NvDvcAKpIhm8SOFlQELRr47kL6SKdwP6NdgSl5BuFH7dhE
 Mnf6+H7k8wP8udSMVikFuEZ8zhKyDNzggPLdkBUb0jPCmutsAcHmPPzIHVU0ho/e/rAZ
 5JMFQJAhOCq6V3cyYPzcB/SqtHCYDfV+fY43nVWBfQxE33rxCfavq7Gxs6Lk/Rgle0wq
 2L1srQtNk3CrUEFXeKXLJHR18X4mYpl5Wxb5c0tmmwnLP08L6ZFUwUxNLNG7+FdAJnMW
 JuAvHz1sYai+tWULzOWf1TcWLiOAeK7hYJcM4F5hC56EbeipLUKmiSk/Tn37WSW+MPzn
 s6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=kxEhjtEiGmz3JhKefGP6i9CMB+/OyKskAJ9ppHwR4AA=;
 b=q0bpYFTNyODJyDRcCqol71xOE+QYVpJgz6Y6nz/MRN4PCtkXPZ3Nx1yEplnkcNh5RI
 diTXoiEYHnUGx1Km6X+Gcy3zWvmc6MTdiyR5CEQTWyVfrz8SYRXUpRuZJtd5ewfRVj4h
 J1eIbjCNjC1K6OlM+O6M/Kq8n+JuEg6w62R58WOFJZ2SuMidiqYu8xppbpWd/wuulxAX
 FU/tttuRcT4RWmLzDW3zgtBDcm0UupA0dxI7ofdLQWSpg9Lkysjoij9iI9/bNmtMkXeZ
 xbyUGOhf/TsS0cBlFFJLpBeZq4nv73woQKEPWIVzmZFQxxdc1xxoLM8F8NBvLUby/Ebq
 BsQw==
X-Gm-Message-State: APjAAAWvSXA/LtEZNj9fjZ3iSLiwDIyJohEEfJuesv6+OzpI8G1KyMAZ
 csjqw4TmeVWiJBmVKDhai1a/AD8L
X-Google-Smtp-Source: APXvYqyRDq0QrH4BKXg8dN08K58gOGxaSkPRa/rF45H3B4dP12rQZtjRs4LtC23dD26wJwzM/8TU5w==
X-Received: by 2002:adf:ee82:: with SMTP id b2mr17037429wro.194.1579787370954; 
 Thu, 23 Jan 2020 05:49:30 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:30 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 27/59] qom/object: Display more helpful message when a parent
 is missing
Date: Thu, 23 Jan 2020 14:48:30 +0100
Message-Id: <1579787342-27146-28-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

QEMU object model is scarse in documentation. Some calls are
recursive, and it might be hard to figure out even trivial issues.

We can avoid developers to waste time in a debugging session by
displaying a simple error message.

This commit is also similar to e02bdf1cecd2 ("Display more helpful
message when an object type is missing").

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200121110349.25842-7-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qom/object.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/qom/object.c b/qom/object.c
index 36123fb..90155fa 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -173,7 +173,11 @@ static TypeImpl *type_get_parent(TypeImpl *type)
 {
     if (!type->parent_type && type->parent) {
         type->parent_type = type_get_by_name(type->parent);
-        g_assert(type->parent_type != NULL);
+        if (!type->parent_type) {
+            fprintf(stderr, "Type '%s' is missing its parent '%s'\n",
+                    type->name, type->parent);
+            abort();
+        }
     }
 
     return type->parent_type;
-- 
1.8.3.1



