Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7F9C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:33:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 396622176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFS9oj86"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 396622176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYWX-0005jN-MK
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:33:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3C-0006OX-5p
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3B-0000nq-0j
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:33 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:45269)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY3A-0000jx-PY
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:32 -0500
Received: by mail-wr1-x42e.google.com with SMTP id j42so1972988wrj.12
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=G3GeihMZT3FWsjutpTGVLlWKTkWWsva27E3p012qRdM=;
 b=CFS9oj86sUF7LLkO19IkaBH++BMSH/tS5zPzmnbTWi/nSZ1FNFqbRjJZj/T9AYBctp
 e2TBe2xlsj8BiB9AHXVssQyno5WmQ7cinRWQQOeANh5JT+TVmXZtPJLI39cPzh9Ve/wQ
 bSWCNCKqsQhHTZcyCRGdQyhFCMTNqSobr4UBg2osxzWC7BWDnXeeISyxFQ9bcRvZbys7
 NGnghwQhHRVVmGbRBhhiHGAK1JwDOKUH7q/Lq0iX6bw0aB+mn0KBZZJacqNjz4ORB7xX
 VbB8+mW8q6wJHDQlVWETp0ua+kGu5fQAyFs6ah1mIutWSpBUtH7geWau91zsfz6AmXmi
 mCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=G3GeihMZT3FWsjutpTGVLlWKTkWWsva27E3p012qRdM=;
 b=XY0wvyew5Y0827EZ8MaMxVPKwFVqKsJuXVUmDbUSBJvYc7tHoZYq8/ZOafX8UxphZ/
 AKFdSXItO0/nXVtzTL+6Y2GnoGb5BJKqMQhgGaepcMQ/3kuklDsX7RYK04VmMJ3OKBz+
 Ion8W5jc4YPLixjpOeqyxD7+K47w43oWMZwuqtwD8FUqFCjD4Av99tifsOQ1B/yjH2Cs
 letG2Qy5krBRip9dTwWXtCJu6YXb7appxbmk33LwdRQg/2ot0O+zrn/Yl9EFvmQ6B66E
 iWDqrooGsp3QjxxMeSeE9SATu2fnKOo+u4Azw/bI3bwQF0UYn9XaTCL0uwKi0KyKZyy4
 Diiw==
X-Gm-Message-State: APjAAAX8SsRfMBu0F72TH0K3qkOoIteXHerrUH6cmy/Lw3LCVlUpLxOR
 oIX7YsOx13uKke7NjUknkmD4VqFI
X-Google-Smtp-Source: APXvYqxbXVP6KGME1HcVxEnFzGiQTlOVs+3UObyZ4mUqY6Qs4LcKRpCSACNh3r/9tB1Xae9XbIaBkQ==
X-Received: by 2002:adf:dd52:: with SMTP id u18mr2454929wrm.131.1576670611454; 
 Wed, 18 Dec 2019 04:03:31 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.03.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:03:31 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 36/87] vhost-user-scsi: fix printf format warning
Date: Wed, 18 Dec 2019 13:02:02 +0100
Message-Id: <1576670573-48048-37-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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

Fixes:
../contrib/vhost-user-scsi/vhost-user-scsi.c:118:57: error: format specifies
      type 'unsigned char' but the argument has type 'int' [-Werror,-Wformat]
    g_warning("Unable to determine cdb len (0x%02hhX)", cdb[0] >> 5);

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 contrib/vhost-user-scsi/vhost-user-scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-user-scsi/vhost-user-scsi.c
index 0fc14d7..7a1db16 100644
--- a/contrib/vhost-user-scsi/vhost-user-scsi.c
+++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
@@ -115,7 +115,7 @@ static int get_cdb_len(uint8_t *cdb)
     case 4: return 16;
     case 5: return 12;
     }
-    g_warning("Unable to determine cdb len (0x%02hhX)", cdb[0] >> 5);
+    g_warning("Unable to determine cdb len (0x%02hhX)", (uint8_t)(cdb[0] >> 5));
     return -1;
 }
 
-- 
1.8.3.1



