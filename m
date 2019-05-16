Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174B5C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:48:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2F5320815
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F5320815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54445 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRFoK-000844-4C
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 08:48:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFMd-00010k-Vr
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:20:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFMa-0002G4-V2
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:19:59 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:43569)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hRFMa-0002Fq-S5
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:19:56 -0400
Received: by mail-qk1-f174.google.com with SMTP id z6so2055354qkl.10
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 05:19:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=+eM2FgyRZsV3s4dqfvsRgXhvSin1/tjIZceylqJZr/4=;
	b=Cq+5dQo0WPOHncpJ5l8u4AuCD8pd6+dY0e8xH6CtFGBY+/zZgPFLu8ssz5csObUrk4
	JsVkMiyWtEbJ3l+P9oWSbFcWem4nDq3/rQPes6svFyjeJ7EYmzh7aNYCcC0/ZEzBamMc
	2YkOS658jaO4AVYhbeJsBwWmuPwB3es6iC6z9hQ4EL/VcTFT2H3kTckkNjlbhaJEFaUB
	ifoD9pjTchEfXoAL9NnjDYectS0q+1KJLXcIfLgXSwyovBGxmc4Mj9qldTzgW/F6zNNP
	Iy8RT+OyedSdnzLEUTxtLTIbebNzOMQ8rhPYNqU130ugQ8bieWFdTJzOQaUgqBPgFseE
	VLYw==
X-Gm-Message-State: APjAAAXeYHe99676o0gXy+/8RKUW9Dc2phlZtcy/qNDHzcA8L6kFis8h
	dxkaLomIdCj+PwQ0biSCjBrPetu23gk=
X-Google-Smtp-Source: APXvYqxD4V5ysxFeKOxz8tg1xLxRo07yrmf8hWVlOMRtgPJISCqoPQOjCZWixhaABNtN+3h5wCoKbA==
X-Received: by 2002:a37:a6d0:: with SMTP id
	p199mr37494988qke.287.1558009196061; 
	Thu, 16 May 2019 05:19:56 -0700 (PDT)
Received: from redhat.com ([185.54.206.10])
	by smtp.gmail.com with ESMTPSA id d5sm2383705qtj.92.2019.05.16.05.19.53
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 16 May 2019 05:19:55 -0700 (PDT)
Date: Thu, 16 May 2019 08:19:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190420091016.213160-1-fengli@smartx.com>
References: <20190515121146.7248-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190515121146.7248-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.174
Subject: [Qemu-devel] [PULL 20/37] libvhost-user: fix bad vu_log_write
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Li Feng <lifeng1519@gmail.com>, Peter Maydell <peter.maydell@linaro.org>,
	Zhang Yu <zhangyu31@baidu.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Li Feng <fengli@smartx.com>,
	=?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
	Xie Yongji <xieyongji@baidu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190516121952.Xmn0VfYimSTYdcPLdYeCOtFiH_uWcagPouv61mqjSmo@z>

From: Li Feng <lifeng1519@gmail.com>

Mark dirty as page, the step of each call is 1.

Signed-off-by: Li Feng <fengli@smartx.com>
Message-Id: <20190420091016.213160-1-fengli@smartx.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index e08d6c7b97..2689de6d1c 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -433,7 +433,7 @@ vu_log_write(VuDev *dev, uint64_t address, uint64_t length)
     page = address / VHOST_LOG_PAGE;
     while (page * VHOST_LOG_PAGE < address + length) {
         vu_log_page(dev->log_table, page);
-        page += VHOST_LOG_PAGE;
+        page += 1;
     }
 
     vu_log_kick(dev);
-- 
MST


