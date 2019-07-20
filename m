Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BF4C76188
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 15:20:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 653BD2084C
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 15:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYGEZ9Th"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 653BD2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1horAO-0005mz-Vw
	for qemu-devel@archiver.kernel.org; Sat, 20 Jul 2019 11:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39934)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hor8Z-0006PD-Fb
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 11:19:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hor8Y-0008D6-Dj
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 11:19:03 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:44985)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hor8Y-0008Ck-7G; Sat, 20 Jul 2019 11:19:02 -0400
Received: by mail-wr1-x42d.google.com with SMTP id p17so34986216wrf.11;
 Sat, 20 Jul 2019 08:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l+J1eu/SZQQm+GtTAYitv1nWk4WmFZ80tCb3ExUS/1Q=;
 b=FYGEZ9ThezjDxFUfIwLnLQTbwI+Iha0ngGZGTgzYGPmrsm4Vp4iL/hH12/Kh+kt+Us
 iMlw4OeFTw8NeLSEmAVytBoVh5gVG23zYn/puXnTdIv/HJj8TIGZo3HXXZF0lKUkN3VW
 bJJws3yGrQONjEJ2HrqQf64rkVppHkcXrPY+bmsINyLibanKR/k5rhhPaZzyHNMYPjOk
 YQO9iQ54g7Pn2zdoWBSsi2qtNjPTIGzaWqlGMny1PE30yrWOseeGBw7uPPY5tHUXJOQV
 7iFNmkIA37Lgep05eO/sMX+MLoWzOE8aHFJYUixfyq6GbJWc2zxmz4RVWgLMytsLU1S2
 /Aag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=l+J1eu/SZQQm+GtTAYitv1nWk4WmFZ80tCb3ExUS/1Q=;
 b=oYswCxFxb0FNecx2b+a3FNHnQXfdOtgu3XbcN2EE5KAtluQmazdhUctnzwZr1mvU/k
 QEznrYSPXjNM06XEjDQKjqz4qL8Z/7lKeroT6H6SX5u3Iq9+MyYATFG0t66U+IJ2BMA5
 2iidJ0ohPsN7Xttj7gpLj0fsED9gUzmlnB/KH0v4FIwDbb0/ZHLnruM9w2Oivux3cSIk
 mhv1OqOmAXNn+CgT7MiA3SngQttvRviTyKX2nOsqnlOvUsYLuqk3l4hIak/H9+smUn4a
 6SPfwkmyXato7wn8XRfoQHD7htjmi3KV3/4XyhUEUV38OxmbU9wRyPPgf4FIuLABtoDI
 l4Yw==
X-Gm-Message-State: APjAAAVdoO9YviUuYftPaYFbMCyIcYZ5Vw1zpBddDb6KC+yXoRb/Wal7
 qH0x/Tjw6i78iBlE2dy3Nzsw15vZXrQ=
X-Google-Smtp-Source: APXvYqyLorEFJb1XdL9hYBkyye3rCs1M602bzfRclHmBwjNUXZR7LmJNRHH9HLeMmv18IRdBzcPTKQ==
X-Received: by 2002:adf:df8b:: with SMTP id z11mr7993398wrl.62.1563635940958; 
 Sat, 20 Jul 2019 08:19:00 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:8501:6b03:f18c:74f8])
 by smtp.gmail.com with ESMTPSA id 4sm77517291wro.78.2019.07.20.08.18.59
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 20 Jul 2019 08:19:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 20 Jul 2019 17:18:46 +0200
Message-Id: <20190720151846.7450-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190720151846.7450-1-pbonzini@redhat.com>
References: <20190720151846.7450-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
Subject: [Qemu-devel] [PULL 12/12] target/i386: sev: fix failed message typos
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
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 Brijesh Singh <brijesh.singh@amd.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-trivial@nongnu.org, Jiri Slaby <jslaby@suse.cz>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jiri Slaby <jslaby@suse.cz>

In these multiline messages, there were typos. Fix them -- add a missing
space and remove a superfluous apostrophe.

Inspired by Tom's patch.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-trivial@nongnu.org
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Message-Id: <20190719104118.17735-1-jslaby@suse.cz>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 5ba1384..f1423cb 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -763,7 +763,7 @@ sev_guest_init(const char *id)
                                         "reduced-phys-bits", NULL);
     if (s->reduced_phys_bits < 1) {
         error_report("%s: reduced_phys_bits check failed, it should be >=1,"
-                     "' requested '%d'", __func__, s->reduced_phys_bits);
+                     " requested '%d'", __func__, s->reduced_phys_bits);
         goto err;
     }
 
@@ -783,7 +783,7 @@ sev_guest_init(const char *id)
     ret = sev_platform_ioctl(s->sev_fd, SEV_PLATFORM_STATUS, &status,
                              &fw_error);
     if (ret) {
-        error_report("%s: failed to get platform status ret=%d"
+        error_report("%s: failed to get platform status ret=%d "
                      "fw_error='%d: %s'", __func__, ret, fw_error,
                      fw_error_to_str(fw_error));
         goto err;
-- 
1.8.3.1


