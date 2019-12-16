Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFDEC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:49:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B1B1205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzXbvxuf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B1B1205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtZ8-00054M-1T
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 11:49:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57074)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFN-0005RS-Uv
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFM-00089Y-Qa
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:25 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:37150)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtFM-000855-KU
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:24 -0500
Received: by mail-wm1-x335.google.com with SMTP id f129so7409078wmf.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=G3GeihMZT3FWsjutpTGVLlWKTkWWsva27E3p012qRdM=;
 b=KzXbvxufQA840q/1TB8VQ7Z4x7UjC7xMOsqydpyuwoo8andOZYZ7WUa1lxwsPrGOVb
 LyicX9bJXzx7EL1NvAdVt7hOSE78ksbVZhdnZtI6imHrDFvcpQHSdVAqcQ5fwGcycjPa
 7OdIYHdv7HdLyG3dJYyLBLjeKqAkz+YawUsEG+sQ1NvbPPoxZJwbKfxxeiUDewkjOLoQ
 URMfCGVqK6HrY220acInEGpDYUoT/J+ydKx3z5b1rWkXvkV2Y3+QwCeY4+ea/Xwd5aQY
 4G59BG1VwSd0a+rCBhNJAjVI1PH5RTn6vYjRZExj/xnFpwRGinyS/aSUcka+vJObudoD
 Oqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=G3GeihMZT3FWsjutpTGVLlWKTkWWsva27E3p012qRdM=;
 b=gy0ScnEACpVgIZ0Vc3lJgPpHRDjiH6YrA/CAOfq3KZk9TpdCNkVTJ3+2/NHoEstVnL
 5g8FNF5RtiDrEkuauyqz+Yc/DKGB9fVeByWI3vJMgtdI8RLeYoKyOTETDOCE4tiXwGWh
 JJRllVIhAPbnsUkqN0rYNtl8QulKu836LuO0YZYXElSdQcnMhVt8sWPyjsW+WoNEKE+z
 wVJ9sTQ9giA3cc6QOYi0WRo+AdLRBDXiFiwze8Q8v4CWZGF9uWjjh1eLWE2IN2UW6J1u
 NPfos+kKO6XWMErFiBLCCbjeD6spYMUzgTW443f97tvSwSVi4NnddkDeb7j5eYseQv4I
 hD3Q==
X-Gm-Message-State: APjAAAWIAHLttbkZOZlfpItVOTuPXrflf8A+E+jV4oFdJLHuV110sh3S
 46myknJZ+bCqIczxB3FfFkD3qAJs
X-Google-Smtp-Source: APXvYqzLi1J6h7gnp7ha6J+RLwMSpxfOQ/kHDGaH0RhRiHzjclL69AyB+L/eM3ps3mG6EBHTcF8PjQ==
X-Received: by 2002:a7b:ce98:: with SMTP id q24mr29471008wmj.41.1576513763492; 
 Mon, 16 Dec 2019 08:29:23 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 36/62] vhost-user-scsi: fix printf format warning
Date: Mon, 16 Dec 2019 17:28:20 +0100
Message-Id: <1576513726-53700-37-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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



