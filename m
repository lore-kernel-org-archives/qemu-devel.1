Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CB4C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 12:01:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8A9A21019
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 12:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bF+aqG+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A9A21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho56D-0008Az-Nk
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 08:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33136)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ho561-0007lu-P9
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 08:01:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ho560-0000TY-Q4
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 08:01:13 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55941)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ho55y-0000Ni-Hq
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 08:01:10 -0400
Received: by mail-wm1-x342.google.com with SMTP id a15so25305467wmj.5
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 05:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=rjf4sVTYWwceznA09gU3q1WrdJs4URLDPRg7ZvAEwUQ=;
 b=bF+aqG+L2/7arp9QZzkuFGKp1jpqu8q1p2MyerSCiA1bnz4+lzhNBSA/5pdvDwtbUg
 jdB7t1k9IB7YUpC2KuETI9g2s1L0Dsvqm9rnqcj9uxabC6mo4SEdBlwqkOriOV9DOtFY
 QSH1gOgFG7brhec1Z3RDP0vIur1RC+WHCWdtKM15PuulDZxMGtYoEAnKPSOH7n3A+3WZ
 GMbOicYyvpmqwy3si6Yc1Q+t3uiJmrHWmpNdKZoDfZSSzbB3oA/3D9ty9cGLgzC3xsdD
 kt2Xt2I6ZLvlOh8lEn9eL1+J9Bu/C8jjLXgQ3PicTriyeswtDKc1kYnA04Sj9EhyQB+L
 NIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=rjf4sVTYWwceznA09gU3q1WrdJs4URLDPRg7ZvAEwUQ=;
 b=fkrAtM6lijpsvYxQX7ANXU3WOgewSJv3LAUi639ZcIy6aIaR2FtnupVg/jFCqJMnP2
 6ZFm2t4lUHbfjbGZ4QT2Lnt//TtWL0A8Xo0l+URHQUvDd2HzWZg3ekIo7SoImutDqY02
 7OvNSLpuZ9xrb+wXhusD+5uXHHc3ys5SjvNApFU3RHhExtZDsPPrb75UcoTt1HxGDq3W
 P5XBSVpe6NRbTJHYt/Yc78y9SHoVKHAtwmFG7f8zjwQn0VN2G+XEUzRa0pcD61zFBCcS
 ok+b+whMLivc7kblVioFooBXKOD3+OBRGIsY7DzBVm5l4Fv3jInBIq72fEJtVZ960tsD
 Rrkg==
X-Gm-Message-State: APjAAAX5NxykMBchZCiCYNke5gEpY8adU4evuzNzWZ7Sf7TEBi+xaW6E
 lrSm//EFgg1XL8NYqo4sFQqvdXrfG9Q=
X-Google-Smtp-Source: APXvYqzoXGLwjN+IwV/MwIvM3C16Vpo+hq/Yk4YZ70f7E8LeFL4hlYcE2wV9RlTTyrX3B4LliMiOEw==
X-Received: by 2002:a1c:c747:: with SMTP id x68mr42247337wmf.138.1563451265717; 
 Thu, 18 Jul 2019 05:01:05 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id x24sm27239965wmh.5.2019.07.18.05.01.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Jul 2019 05:01:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 18 Jul 2019 14:01:04 +0200
Message-Id: <1563451264-46176-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH] curses: assert get_wch return value is okay
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This prevents the compiler from reporting a possible uninitialized use
of maybe_keycode in function curses_refresh.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 ui/curses.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ui/curses.c b/ui/curses.c
index a6e260e..a3ec9b5 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -225,6 +225,8 @@ static wint_t console_getch(enum maybe_keycode *maybe_keycode)
     case ERR:
         ret = -1;
         break;
+    default:
+	abort();
     }
     return ret;
 }
-- 
1.8.3.1


