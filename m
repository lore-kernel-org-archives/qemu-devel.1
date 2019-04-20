Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B33AC282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 09:11:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E3202183F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 09:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fc9i2d2b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E3202183F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39044 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHm1z-00036b-AV
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 05:11:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifeng1519@gmail.com>) id 1hHm1D-0002jB-3x
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 05:10:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifeng1519@gmail.com>) id 1hHm1C-0001T3-0q
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 05:10:43 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37265)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lifeng1519@gmail.com>)
	id 1hHm1B-0001PB-Pi
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 05:10:41 -0400
Received: by mail-pg1-x544.google.com with SMTP id e6so3668321pgc.4
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 02:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=5HrqeiwXIQa72xBBRsa4fZ0l3INrKVRzQJH+HcOO1Z8=;
	b=fc9i2d2bOagarOIibMizy7HKykVvAEf1de5sp4oeJU0MtTSTgjRW3bAhgWmX801FJr
	0RQGDRbqp/Bi+GgGRSbOfqhHNfbK9i+SsWdBR6WYFmw/l9IVMruvtkpn/XC8aaho+h1/
	/pOtJI+Xh+q+ndln/RZ6x37PKGrUBtXZQ4eNdLT30BJsqt9UsELVSzyCwKIqBtM50eRE
	lOEuLobDNbvy5X26RfJ8MVasfd8DeTBKSUrKXqsL3+6CRToBOVGj6/KogbdMxWbG85FT
	qIQVF/Nhzh92gyuSV3+cm3w9TxnH8jZ+SLwlqbVMQLXPf/Rj+cl6kEtF6UvUkZYjBOoD
	WAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=5HrqeiwXIQa72xBBRsa4fZ0l3INrKVRzQJH+HcOO1Z8=;
	b=nqrxD3ao1sUFSJqUCPHQcJeDcWzErrJ8dm4c+spE9pjk0BK5kEquHfA1eBNqDwD8zR
	vdonfhT4F8o1wuroN+WnhJpRxE8FMZqPl9W8ETXzLBT39yJRMiwBIPKZ8mb90guDY3Dm
	pGkqnX0/I5VDBVhCs+5DfZ5TvJhg2DzkTcn15Aw7GqWQxwTZaSuBrcMj16hOCKAyMBB0
	o1xnj/bIpqqknVnIbaUyCqvx6D+6rco/Is20Xq90iBUYJVvxIgQjGYQai3mJ4vYZeUXI
	aQrX56Ii6gZj0RZ4Q+PbC74QZP+7pTMNGkkv0wQIjPT9Ly7xdpnm13LUubog9oAdD0tj
	vspQ==
X-Gm-Message-State: APjAAAXjggk261IQInl2PzFB10O8c64RPdDVVXVk3J79bGeL+/YOHiAn
	296/QS9erDXoGB/wpaYUeMPfnKoaaYEa0g==
X-Google-Smtp-Source: APXvYqxLDWlZQM5ZObxceDVquqpVE7FlXyBWbsAFeYW1SmElanq8JIbWJY0wMyb+2mfkshEUXAKAQw==
X-Received: by 2002:a65:648c:: with SMTP id e12mr8338757pgv.346.1555751439224; 
	Sat, 20 Apr 2019 02:10:39 -0700 (PDT)
Received: from azure-smartx-hk-02.localdomain ([13.70.26.245])
	by smtp.gmail.com with ESMTPSA id
	s85sm12012636pfa.23.2019.04.20.02.10.36
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 20 Apr 2019 02:10:37 -0700 (PDT)
From: Li Feng <lifeng1519@gmail.com>
X-Google-Original-From: Li Feng <fengli@smartx.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com
Date: Sat, 20 Apr 2019 17:10:16 +0800
Message-Id: <20190420091016.213160-1-fengli@smartx.com>
X-Mailer: git-send-email 2.11.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH] libvhost-user: fix bad vu_log_write
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
Cc: fengli@smartx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190420091016.pp8Hsa1rzbG9qz6wPi-yn4uxLIHCRqxqicenHiggXC8@z>

Mark dirty as page, the step of each call is 1.

Signed-off-by: Li Feng <fengli@smartx.com>
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
2.11.0


