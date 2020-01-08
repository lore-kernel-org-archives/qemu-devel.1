Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A685C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:55:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9236206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRYRp0rU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9236206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipAre-0001Tp-0W
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 07:55:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60665)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWj-0004Ic-4u
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWi-0004Yy-3g
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:33 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:44181)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipAWh-0004YT-Ty
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:32 -0500
Received: by mail-wr1-x435.google.com with SMTP id q10so3146282wrm.11
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 04:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0DFURfcrdlZMFc5Cww9NVOEhGZMTURpWj94rU1e8DFs=;
 b=bRYRp0rUZJU0nvnAn06ZCG5z1UKtS9nM1be8EcEJaEb5qi6TKcEzq8PgH94Sjpz/X4
 /e6WiB8K7V9WntAYFkj2ZrbF/aPwAIl7rsTz9U1Cf+U1q3atHyOYQyKMfr2Y3OoitQKB
 HZIGdr5+G8rLIIGJsYOeCkyPzSh2IalEeXYCyvYniXB+RM3nQIjg1aOx/wSRbahqwYqW
 jTtpWaqQwybpqXMyQRBSCDfhZhaDzyAjyjKMEExDrhDRIA/Pso0UjngkH4MiF8qxV/BE
 MWBjnzPu/OJkJZPH00HJ2tnjOa/aXqf6vqHuIJzZZ1C1oukUvJnqiWr7FsfUei9aLkgz
 BvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0DFURfcrdlZMFc5Cww9NVOEhGZMTURpWj94rU1e8DFs=;
 b=Qd8nf5POYxpkxsLr4VZlZLNexBjXI9faXktT0XjGz4Mb5RBq0cQdPsUZXidkDWzZiR
 6ydddV7+zvCNM7N+QqESq7t45GIaI2tHBv4hqXesLudCWLJweDOt9g/elJsMZtJOU/g9
 XlZzDAfYqkSvtf8m+oLG2OMZRPdEOn48HdN4yp6/G2YGg6qg+5m/otXbzuwaVVA3aQYy
 yMsBJ/n+BA4qRq9aPg5ylbeAmt3Yz0Z+xVoa9/4rtNcsAFs52kpih1xBSvMVAwR869Dn
 GXDVzV3UnSV1X5t7/3uH+JPO7hjy1uCdqoNH+6WjcOGzmirgB4ds53fqavmJvmUlcTpC
 6GRg==
X-Gm-Message-State: APjAAAVirjqP/MSoIduaAuhAjFfmMiPFBdsIaFYgGVakFON5/a1LNcl7
 9Hb3uNZtDIeKKnyqrtyUtSYowQER
X-Google-Smtp-Source: APXvYqyBHVFY5D7Fk19GnkeaVc3yyQtNrJfcNMJ/IX5p5l/o+WgSgkZgxZ+z62uNJsFNxpiS1gdTEA==
X-Received: by 2002:adf:f1d0:: with SMTP id z16mr4194631wro.209.1578486810188; 
 Wed, 08 Jan 2020 04:33:30 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id o4sm4037750wrw.97.2020.01.08.04.33.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 04:33:29 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 31/38] vhost-user-net: Explicit we ignore few QEMUChrEvent in
 IOEventHandler
Date: Wed,  8 Jan 2020 13:32:48 +0100
Message-Id: <1578486775-52247-32-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
References: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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

    CC      net/vhost-user.o
  net/vhost-user.c: In function ‘net_vhost_user_event’:
  net/vhost-user.c:269:5: error: enumeration value ‘CHR_EVENT_BREAK’ not handled in switch [-Werror=switch]
    269 |     switch (event) {
        |     ^~~~~~
  net/vhost-user.c:269:5: error: enumeration value ‘CHR_EVENT_MUX_IN’ not handled in switch [-Werror=switch]
  net/vhost-user.c:269:5: error: enumeration value ‘CHR_EVENT_MUX_OUT’ not handled in switch [-Werror=switch]
  cc1: all warnings being treated as errors

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20191218172009.8868-9-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 net/vhost-user.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/vhost-user.c b/net/vhost-user.c
index 014199d..c54c9c7 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -294,6 +294,11 @@ static void net_vhost_user_event(void *opaque, int event)
             aio_bh_schedule_oneshot(ctx, chr_closed_bh, opaque);
         }
         break;
+    case CHR_EVENT_BREAK:
+    case CHR_EVENT_MUX_IN:
+    case CHR_EVENT_MUX_OUT:
+        /* Ignore */
+        break;
     }
 
     if (err) {
-- 
1.8.3.1



