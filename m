Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DE6C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:01:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A75D20643
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pw7F6tsj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A75D20643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipAxo-0002EV-Ra
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 08:01:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60649)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWh-0004Fp-Eo
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWg-0004Y1-Bb
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:31 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:37945)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipAWg-0004Xb-5Q
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:30 -0500
Received: by mail-wr1-x434.google.com with SMTP id y17so3205170wrh.5
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 04:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WCjKXrdR/R/3qFo/Ai4yhaPyA8z7tZNg/kZgnvxQquU=;
 b=pw7F6tsjEdudvYspXC+m76pFcZ8orsy7euPPjxvmvhmtHKyRLW9F7YaCgryQ+qWSOg
 hVwR2zpIDJqwowsks/JfHPJWp96FnRiIqAbApJutUWkMHhlLsB9lWTQEnUtXvtZRoohu
 poAzsShmfmi4yCjtk61lLjQT0mqZyws/+58d6uoDPPouFZroNykNLSNGlQD5eEIr0k6s
 n3i0dcoKHM5yq+HJT2xjzPGXgzybI/WY6P6huvKJFYkQODltS7btJuMUpxd76RgtdzBk
 XJdnSXlHL1QyXC2NElOcs3et4gaHSxD9RztwwThrys9Pd16a3ewWzVy2kaz4hYJ/hEYR
 nvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=WCjKXrdR/R/3qFo/Ai4yhaPyA8z7tZNg/kZgnvxQquU=;
 b=kOVHwSRYGjFXhk+UrnFdUN2MY8GTcnUrtgsE4bJ2B3DuG9lZ+3DNF12CrjZymFgZPt
 FA+UM5OZUHR7q1rX5ox1Il50tdGJ5sJz4uxwMWTx0uHoCNWbVICOy6VVTphBca0V0Shk
 tUu2zSyljQzecB76GmKML1ynuOYwFhPZhiqpYPi6Vi323+3/13QsRvQ2ZNBfsrk2+lgo
 Vu7lfaMZ48E7lTJf9675EpZSpsQsodls8RF4VPgrrfvm+6vJkoKSpiw5Z6imPGthcMb2
 29eeFXYfOw0L/bBVn8LLlMx5fmIEa0BLRDpCxA3HAsmdfloNlTn5VTCZqLRZW8+lWqgF
 wq2A==
X-Gm-Message-State: APjAAAVt0LjZ+B7iSXAPWZFMPNrAFgskYKg8YaG+sU48Iqtt2pD67hJK
 fN9jTi8gmfMpEweLWbxQcc/kl2Dy
X-Google-Smtp-Source: APXvYqyH5tjfpK1LtyoG+8aQoS8uKNj6Cb07PiZdgEg6OLVQ6Z+vDHVN/mdxpPf+XkhFSwlLm0hFRg==
X-Received: by 2002:adf:a285:: with SMTP id s5mr4302187wra.118.1578486808982; 
 Wed, 08 Jan 2020 04:33:28 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id o4sm4037750wrw.97.2020.01.08.04.33.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 04:33:27 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 30/38] vhost-user-crypto: Explicit we ignore some QEMUChrEvent
 in IOEventHandler
Date: Wed,  8 Jan 2020 13:32:47 +0100
Message-Id: <1578486775-52247-31-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
References: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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

The Chardev events are listed in the QEMUChrEvent enum. To be
able to use this enum in the IOEventHandler typedef, we need to
explicit all the events ignored by this frontend, to silent the
following GCC warning:

    CC      backends/cryptodev-vhost-user.o
  backends/cryptodev-vhost-user.c: In function ‘cryptodev_vhost_user_event’:
  backends/cryptodev-vhost-user.c:163:5: error: enumeration value ‘CHR_EVENT_BREAK’ not handled in switch [-Werror=switch]
    163 |     switch (event) {
        |     ^~~~~~
  backends/cryptodev-vhost-user.c:163:5: error: enumeration value ‘CHR_EVENT_MUX_IN’ not handled in switch [-Werror=switch]
  backends/cryptodev-vhost-user.c:163:5: error: enumeration value ‘CHR_EVENT_MUX_OUT’ not handled in switch [-Werror=switch]
  cc1: all warnings being treated as errors

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20191218172009.8868-8-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 backends/cryptodev-vhost-user.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
index b344283..f1b4079 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -171,6 +171,11 @@ static void cryptodev_vhost_user_event(void *opaque, int event)
         b->ready = false;
         cryptodev_vhost_user_stop(queues, s);
         break;
+    case CHR_EVENT_BREAK:
+    case CHR_EVENT_MUX_IN:
+    case CHR_EVENT_MUX_OUT:
+        /* Ignore */
+        break;
     }
 }
 
-- 
1.8.3.1



