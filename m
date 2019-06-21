Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D608BC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 01:47:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99F222064B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 01:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGnu2BHP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99F222064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54034 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he8eV-00005Q-CO
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 21:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40644)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1he8Za-0006My-CW
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:42:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1he8ZY-00067h-Pi
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:42:38 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:38620)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1he8ZY-00062n-G8
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:42:36 -0400
Received: by mail-wr1-x42b.google.com with SMTP id d18so4878335wrs.5
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 18:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=rF5i6pzq9tNlUQhJFdaXZR//yZxu/EIyRbH8FbNdhFc=;
 b=lGnu2BHPEqEqHNamv8d/nKz63paJvo9uZ7ZuzwBub6GN7vxC7a+z/FtFbmhZofyMns
 D//up6rJikyxhPa0DZAtrx1hrY5gojEPYDIRj1XSRtOjWosqPBmgt4I6OSZuQavHWUzn
 7abXlWBrXp6ReC8D5sivuI1wBfQGuiY7AGL8+RAg3MhESFPvHtd1Z9miqHY0B8zqq8Xp
 yhCYu2qPebE4byV3pvPctDf/C6oUwUbaNrDXKDbtw/wPU1tBLQRe9FJJqZXEdt9PtM0H
 Ox+E/WUy4MQbK2StxVjT4tVdARFHaiY1n6sb/mc5x03efomYgsIe5K+jRTAKg2bWHqO/
 zp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=rF5i6pzq9tNlUQhJFdaXZR//yZxu/EIyRbH8FbNdhFc=;
 b=XmadtQYOHLZ7uGAF6J7eec2HxYXXhr33CqAmN6nhmce7oljnYFEXXvYGyDsyrFsKDz
 XBaN7Hiy5bqF5+nX8s9QQEC1+Y9f/zXUtmOby0TsROkU0nL0ds86MvMAiNJuZbVAq3uo
 Ol70r7xnwXQj8Vn3JbpdkBF3HlExUaINh1fsfb9Ivwf1Bto7mq7mO9F8w9GpsAshMc5v
 fgjz2xdvmIR/NRBjBCIt96ohZHEApLjTUTITuVxHhX0TYx369y5xI+NM+3ZSpniBW3Rd
 WkFNX00Ag4gev83G0PcPyb3YT2EgpQ+NITtHeKPjYoe6/8ockJ/lvIONy7MGAmVZOEz2
 GOjA==
X-Gm-Message-State: APjAAAX3B0u5RQVk80c/qvKHcWyguKDtiOQrfJku/QOG7Bp9F/QzCyMr
 qyQ+DNZW0M6mtGlWec6/X3aglUUj
X-Google-Smtp-Source: APXvYqyxHM7yUMpqXv45P6S3A8q2viegX08LTVyJtmcsGD2+V+9c/2SdrU5v0gOPweGz8QcDCc6lYA==
X-Received: by 2002:a5d:6549:: with SMTP id z9mr30290857wrv.63.1561081352960; 
 Thu, 20 Jun 2019 18:42:32 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id d1sm1123125wru.41.2019.06.20.18.42.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 18:42:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 03:42:06 +0200
Message-Id: <1561081350-3723-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561081350-3723-1-git-send-email-pbonzini@redhat.com>
References: <1561081350-3723-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
Subject: [Qemu-devel] [PULL 01/25] kvm-all: Add/update fprintf's for
 kvm_*_ioeventfd_del
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
Cc: Yury Kotov <yury-kotov@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yury Kotov <yury-kotov@yandex-team.ru>

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
Message-Id: <20190607090830.18807-1-yury-kotov@yandex-team.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index b0c4bed..d2f481a 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -863,8 +863,8 @@ static void kvm_mem_ioeventfd_add(MemoryListener *listener,
                                data, true, int128_get64(section->size),
                                match_data);
     if (r < 0) {
-        fprintf(stderr, "%s: error adding ioeventfd: %s\n",
-                __func__, strerror(-r));
+        fprintf(stderr, "%s: error adding ioeventfd: %s (%d)\n",
+                __func__, strerror(-r), -r);
         abort();
     }
 }
@@ -881,6 +881,8 @@ static void kvm_mem_ioeventfd_del(MemoryListener *listener,
                                data, false, int128_get64(section->size),
                                match_data);
     if (r < 0) {
+        fprintf(stderr, "%s: error deleting ioeventfd: %s (%d)\n",
+                __func__, strerror(-r), -r);
         abort();
     }
 }
@@ -897,8 +899,8 @@ static void kvm_io_ioeventfd_add(MemoryListener *listener,
                               data, true, int128_get64(section->size),
                               match_data);
     if (r < 0) {
-        fprintf(stderr, "%s: error adding ioeventfd: %s\n",
-                __func__, strerror(-r));
+        fprintf(stderr, "%s: error adding ioeventfd: %s (%d)\n",
+                __func__, strerror(-r), -r);
         abort();
     }
 }
@@ -916,6 +918,8 @@ static void kvm_io_ioeventfd_del(MemoryListener *listener,
                               data, false, int128_get64(section->size),
                               match_data);
     if (r < 0) {
+        fprintf(stderr, "%s: error deleting ioeventfd: %s (%d)\n",
+                __func__, strerror(-r), -r);
         abort();
     }
 }
-- 
1.8.3.1



