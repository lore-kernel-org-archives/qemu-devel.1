Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F52C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:53:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42D5F206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYR2dxx0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D5F206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipApr-0007H9-32
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 07:53:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWf-0004DB-Uy
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWe-0004XA-O8
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:29 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:50269)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipAWe-0004Wc-Hj
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:28 -0500
Received: by mail-wm1-x32f.google.com with SMTP id a5so2311985wmb.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 04:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+lLMocRpHqpsswHyjutdtcTIrryPFu7ndbSVvwhceQ8=;
 b=VYR2dxx0CNLpw2VM5q6ELJpaV3J3sJlihoH2Nt9Ir8V/UVG0P3S6YIgrytFSWNj4am
 pCGXCoCmwB2PM34hw0f57aJHlf3NAE4AS2CN8XkWfe5a1sdGie7fUehNA5ablU1KCVR/
 vl4EyA1f0TmYiOEhFzx9GE2p062jVZdzZ1CrFkzHwudGYkYmeIOY0B3uIm/W79HrqTTh
 XOzLmki9OhezwhpLujITuJU560DFemJSHp9XC/r4wBieXlYoKd8V6M/5LysUiOLGLBOf
 lJ7XayO44xtJkNotYuGqXJRz3zuJzuO10ZJJiuuYCsK1+QaHYrQ55t/E1JhFv0OHyxEx
 nhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+lLMocRpHqpsswHyjutdtcTIrryPFu7ndbSVvwhceQ8=;
 b=Rtw4K7Pt7ZC8ZdRGXZwRNK6aHY6hrB/aHm/B11qgrfck2qy9V6gyp+wLFKh6xyJjfz
 ln5g5R3LZ2YAHYWkeoI1qEz1xHvYVhwKAuCDyzZRAV3xVDMFnvaCsScE/hQ6IhJjN/ra
 uLy0iQMqY1vA733W/mvHUm+K1GkUm6Eme2VqswiNNPbpbGZDEZS/hY7dnqBsBbabI8GM
 a3hNxk7y+u7LbEq3S0SyqkVjn3A9kmA6eTud6MD3OHsCpq46Bc84BO2WVyOL8c84cglk
 nMsmchyTfoQqqoAqLngPLreLwyFwcII+VymC9FvpVH6VVyMlAHNCGSECa358pKXQKy8A
 rIPw==
X-Gm-Message-State: APjAAAV992+DnoF3Gk7TRyy0XmGXeIj8GCsV96NAE+3FOYefFn3JkJ1j
 AQ54Cw0/J4tXxmirykjBRI+S1Sqr
X-Google-Smtp-Source: APXvYqwwkoJHfKxsBhAyrfeHxXAFSA8YtDgNHIJPiFZGfYyyI1XWfVw/DY0hTxli9k8eId8fA27NNw==
X-Received: by 2002:a7b:c956:: with SMTP id i22mr3630249wml.67.1578486807379; 
 Wed, 08 Jan 2020 04:33:27 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id o4sm4037750wrw.97.2020.01.08.04.33.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 04:33:26 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 29/38] ccid-card-passthru: Explicit we ignore QEMUChrEvent in
 IOEventHandler
Date: Wed,  8 Jan 2020 13:32:46 +0100
Message-Id: <1578486775-52247-30-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
References: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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

  hw/usb/ccid-card-passthru.c: In function ‘ccid_card_vscard_event’:
  hw/usb/ccid-card-passthru.c:314:5: error: enumeration value ‘CHR_EVENT_MUX_IN’ not handled in switch [-Werror=switch]
    314 |     switch (event) {
        |     ^~~~~~
  hw/usb/ccid-card-passthru.c:314:5: error: enumeration value ‘CHR_EVENT_MUX_OUT’ not handled in switch [-Werror=switch]
  hw/usb/ccid-card-passthru.c:314:5: error: enumeration value ‘CHR_EVENT_CLOSED’ not handled in switch [-Werror=switch]
  cc1: all warnings being treated as errors

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20191218172009.8868-7-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/usb/ccid-card-passthru.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index 267ed9a..e53696c 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -318,6 +318,11 @@ static void ccid_card_vscard_event(void *opaque, int event)
     case CHR_EVENT_OPENED:
         DPRINTF(card, D_INFO, "%s: CHR_EVENT_OPENED\n", __func__);
         break;
+    case CHR_EVENT_MUX_IN:
+    case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_CLOSED:
+        /* Ignore */
+        break;
     }
 }
 
-- 
1.8.3.1



