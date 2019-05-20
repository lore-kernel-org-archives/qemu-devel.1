Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A375C04AAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:19:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 702692171F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 702692171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43419 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSrYf-0005GB-Je
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 19:19:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrR1-0007c3-PM
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrR0-0008BR-KT
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:11 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]:41336)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hSrQz-0008AR-7S
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:10 -0400
Received: by mail-qk1-f173.google.com with SMTP id m18so92067qki.8
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 16:11:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=oan5kE2o33xzffypseyYQl7lDvbN5Ab+0RzaGZ/vQ6w=;
	b=FjElzXAj/Hr45xfRkQah6irTk4t90ew0Lz2TDlt5HU8yXcH0mGuZVsnge8H419Xfz9
	97vT7v4aHIElGce4Sn8aueDVYAxdDS9VcjBqTfdmui5mi6cA0SxggbL6kFZ15BMxvbVm
	S3+1ie9ExaL4e5Nb9JgfEJ08l3i09z+mPH7UW2runPE6NMLeCfoHNhscocZbNLbXKR7d
	UIe0UMRBzKYy6dlnNWfcJFm7nAMc0cLUC7Y2DlWR3rxNe+L1z/zeRDSu7eqKAWFvdNt9
	s7ufvulG8JWwzuFQxMDQYOxML4tQvcjubLW/3cHDKezs0MgCygk3prkmUMSedhZt0Efi
	A3Eg==
X-Gm-Message-State: APjAAAW5h0evly5KXlixebh//+VvODJ+JOaORvh5mAdKDJ7yGbVnRSbT
	jeA8280tNmOAUXXURv/Di37DDh7Crl4=
X-Google-Smtp-Source: APXvYqyvRGDhIuU9jSDizXPQxZVTkaNBXoaYdT2bHpVdMPMlUt7YNofS+U/O4+ax0KnS7k03kFpBxQ==
X-Received: by 2002:a37:7f02:: with SMTP id a2mr29908409qkd.124.1558393867101; 
	Mon, 20 May 2019 16:11:07 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	124sm8457029qkj.59.2019.05.20.16.11.05
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 20 May 2019 16:11:06 -0700 (PDT)
Date: Mon, 20 May 2019 19:11:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190420091016.213160-1-fengli@smartx.com>
References: <20190520231008.20140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190520231008.20140-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.173
Subject: [Qemu-devel] [PULL v2 19/36] libvhost-user: fix bad vu_log_write
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
	Zhang Yu <zhangyu31@baidu.com>, Li Feng <fengli@smartx.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	=?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
	Xie Yongji <xieyongji@baidu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190520231105.MrhIa99QadI0orDDFIjF5-yF7WFaZmVlpccaqKV7TN8@z>

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
index 74d42177c5..3825b1cacf 100644
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


