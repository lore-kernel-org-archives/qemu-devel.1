Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751A1C31E50
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 21:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4509920679
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 21:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4509920679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43074 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hccxJ-0006Ov-GY
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 17:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40928)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hccoz-0006ca-5L
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:36:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hccox-0006Uj-Am
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:36:16 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:39393)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hccov-0006Px-Ag
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:36:15 -0400
Received: by mail-qt1-f176.google.com with SMTP id i34so3287328qta.6
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 14:36:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=rtaNaknOkXUDzQJW9XqVzJ5jhV7BI2c0EssQ9iN2pR0=;
 b=KcS6/FFDzQcR5RGi2A3nmOn8ymm7amKHloV3ow6j7YEGsCDhp8570E0WM3MkIc1wzS
 SeNXwyuAj85dxAZZN69WU/3QaDRUnrzUmh+nKOAMfcOTTQ6zm/A5H6HN5usdPsesYSIU
 h7mOnFOCumDQfcop86FAPHrYl7Gj/E2hukMoNfK1J2Kzx8ffGOAP18GMcKKoDy/XK9gU
 A+npc9HOok9LBGkceo7pYWi5waX9If9/niWpNfSIFrD3/vCRXerNA1sqJ8Mp0JMwqvtK
 CE5G3SbWxCtdlba3QYmImBq6709meNF8xgI+92k1+doYny4ZBFVzSVqZAxuE8gRSjyyp
 tcmA==
X-Gm-Message-State: APjAAAVZPIeKHqJCz/p6H6gFEVJkzhePcpIfcun03GlL3a2jfsOcGmqk
 2DPuVOIc+CGL5TUbLYT51I0uJ11c2AU=
X-Google-Smtp-Source: APXvYqw2HYqWD7Z1n7JRpGNduY58t6uYK2/FhyadkV8FKx2vfzTn88jn0y7fzfdW57ujwi8zTBAvyQ==
X-Received: by 2002:ac8:1978:: with SMTP id g53mr2084297qtk.3.1560720972457;
 Sun, 16 Jun 2019 14:36:12 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
 [100.0.197.103])
 by smtp.gmail.com with ESMTPSA id z1sm5718263qth.7.2019.06.16.14.36.11
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 16 Jun 2019 14:36:11 -0700 (PDT)
Date: Sun, 16 Jun 2019 17:36:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190605145829.7674-5-marcandre.lureau@redhat.com>
References: <20190616213540.20430-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190616213540.20430-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.176
Subject: [Qemu-devel] [PULL 04/11] vhost-user-input: check ioctl(EVIOCGNAME)
 return value
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190616213610.huGF00ID5c1sclgvlfmFZeiWOU8v7yALXqS4jO7dVDo@z>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

This should fix coverity CID 1401704.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20190605145829.7674-5-marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/vhost-user-input/main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/vhost-user-input/main.c b/contrib/vhost-user-input/main.c
index 54f882602a..8b4e7d2536 100644
--- a/contrib/vhost-user-input/main.c
+++ b/contrib/vhost-user-input/main.c
@@ -342,7 +342,11 @@ main(int argc, char *argv[])
 
     vi.config = g_array_new(false, false, sizeof(virtio_input_config));
     memset(&id, 0, sizeof(id));
-    ioctl(vi.evdevfd, EVIOCGNAME(sizeof(id.u.string) - 1), id.u.string);
+    if (ioctl(vi.evdevfd, EVIOCGNAME(sizeof(id.u.string) - 1),
+              id.u.string) < 0) {
+        g_printerr("Failed to get evdev name: %s\n", g_strerror(errno));
+        exit(EXIT_FAILURE);
+    }
     id.select = VIRTIO_INPUT_CFG_ID_NAME;
     id.size = strlen(id.u.string);
     g_array_append_val(vi.config, id);
-- 
MST


