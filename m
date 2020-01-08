Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DE9C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:03:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEEF320643
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkLcqMYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEEF320643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipAzv-0004DL-MU
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 08:03:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60748)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWo-0004Rm-15
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWn-0004cV-22
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:37 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:36962)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipAWm-0004bq-SM
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:37 -0500
Received: by mail-wm1-x333.google.com with SMTP id f129so2321303wmf.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 04:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=n98xC83HGR1EyrVTal/VnLJiWwmzPPe4kCosA3uE+Sg=;
 b=FkLcqMYqcCyzbNoKqkYIO+VQj9dCjTD+g7WsUS7tdRSQSvG5qeuJNQjCRQ8o/zxQhZ
 bObDlxyiiN23L1qde9WYic81BsdYdWsqUqR14vTuoWVMZVRCnAVUTu4403yfHk303tI7
 RjgsVMgkFzeRqkcB1TJvmB872SmX8XINGSh6UOYLShxvds2hPvL9hUJQWNySq7oD6GoH
 AlJM4QihDcI3pfPoKRfxWWUiGAgZeUpSkQIouhTRusvL0xEup7cE0A3Fe+c3FnZ950xJ
 HGIJ4su/FbfUVMpqk/jitLBCxCA4GPlSSHA1/7dJQausaAoqx7RFic5YRIIhURUyVKGi
 SoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=n98xC83HGR1EyrVTal/VnLJiWwmzPPe4kCosA3uE+Sg=;
 b=SWzSYyQltuhqJY4EGbQaKdqSiFvwgHf9eCdmCGabInAiHYga8ABKcHT0YRliQUUYOM
 82aZMjyuVjbNrGcjgeFQSM69Hc65tkRF9QdTkMWazSqDZV/EBwplVF50pl+fpNmGHp5v
 ptz5zAXlZhDoluAhIn5slMfstn2bKEq1l0S8JuOngIfvg5Fs9RDe1zOo4o52JFoBD9dV
 89pvVTN9hmqiCDZTwLc4q2Rf9eFZEgfbkQ7GTrP1T5f+nMzKD/RVqjZmBNS21xCuS4fH
 F7cF3GTk8QW2ttO5hhtamnMxBuyqZ2v9Yu7S3996dXww4HYTbN1yhjMy+O30sF4ew5zM
 RCZQ==
X-Gm-Message-State: APjAAAW7cQ4JZF7fVxjPzjY6dbDs9FJgSuSxHcZZjRbdssfF+YScjlKZ
 SiFVmkIURT5fLejws+GRbDp+asvK
X-Google-Smtp-Source: APXvYqy7snbyfEYUnr1hwHlU2wXU33NMddA/f75NmId8r28y/QMgLp85MrqgqfXrLUmrLZtgQ4RazA==
X-Received: by 2002:a7b:c956:: with SMTP id i22mr3631039wml.67.1578486815801; 
 Wed, 08 Jan 2020 04:33:35 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id o4sm4037750wrw.97.2020.01.08.04.33.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 04:33:35 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 36/38] chardev/char: Explicit we ignore some QEMUChrEvent in
 IOEventHandler
Date: Wed,  8 Jan 2020 13:32:53 +0100
Message-Id: <1578486775-52247-37-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
References: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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

  chardev/char.c: In function ‘qemu_chr_be_event’:
  chardev/char.c:65:5: error: enumeration value ‘CHR_EVENT_BREAK’ not handled in switch [-Werror=switch]
     65 |     switch (event) {
        |     ^~~~~~
  chardev/char.c:65:5: error: enumeration value ‘CHR_EVENT_MUX_IN’ not handled in switch [-Werror=switch]
  chardev/char.c:65:5: error: enumeration value ‘CHR_EVENT_MUX_OUT’ not handled in switch [-Werror=switch]
  cc1: all warnings being treated as errors

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20191218172009.8868-14-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/chardev/char.c b/chardev/char.c
index 7b6b2cb..739da11 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -69,6 +69,11 @@ void qemu_chr_be_event(Chardev *s, int event)
         case CHR_EVENT_CLOSED:
             s->be_open = 0;
             break;
+    case CHR_EVENT_BREAK:
+    case CHR_EVENT_MUX_IN:
+    case CHR_EVENT_MUX_OUT:
+        /* Ignore */
+        break;
     }
 
     CHARDEV_GET_CLASS(s)->chr_be_event(s, event);
-- 
1.8.3.1



