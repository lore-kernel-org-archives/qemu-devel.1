Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D784EC04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:38:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0A64208C3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVXhUfN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A64208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49135 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVtAQ-0006gM-R0
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 03:38:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1hVsjm-0000bX-LG
	for qemu-devel@nongnu.org; Wed, 29 May 2019 03:11:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1hVsjl-0006SC-PC
	for qemu-devel@nongnu.org; Wed, 29 May 2019 03:11:02 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:34094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1hVsjl-0006Ql-KK
	for qemu-devel@nongnu.org; Wed, 29 May 2019 03:11:01 -0400
Received: by mail-pf1-x442.google.com with SMTP id n19so1028104pfa.1
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 00:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=KCQFP+ZFlVwkBiduDICRQjKoGn++Fs0jXbPk/B+kRlo=;
	b=pVXhUfN13yEkPRGYJVvtc3bqZOUVWl+Ggu18I5ldY/H0W8rkQ74YJfddMKVwNC6eQm
	sAfjiNP+kGUSp2EpQ0NEaeF2jFkFt0u+Ei9huGtoZrwcgxngVhWO6Tpx/5JGSGQphZZL
	qrteWcVdPGSxcsJ4u9LSeHmmsxOmsR3Gp05jVcrRvhMATlcGRMU5l0EbIkTZ2DL8urpE
	cYFsIz5ysJEAqg+U7NkujALgGSQYq31JLc5Tceh2rgJVEgRFOP5ZJ+y6LKr53o/wqJKA
	lSm/Nsj5aqhAPsPd4JeyvQrX+CNCJgde/grMJ0jRfcT04qGg7vupvo6HRxACUq89mTfh
	3INw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=KCQFP+ZFlVwkBiduDICRQjKoGn++Fs0jXbPk/B+kRlo=;
	b=Pg843tk3XTET5I/gPk+2hUyZp6KEacUDUMmSN5+nkxk4QqBROVpwwY0h9ez/HtZho5
	Kreu4QbfHtnRBrHfC9Wl3b21aH4hsDv+mUcdJ/EdF5KrY9JzKfLPSQ6vvkHL85KpiPzF
	nfXO/YkIU6XgusOPoQnavjxWvHxxFUqm6m4FVe4UkgtxI8s5YA+Z5KtJV6GgGexYtl97
	Xr6QL3FhT+eGKn53AckJ2A7JrjCypkSuEO7jJ1HNkI087YN0KH3Sf1UMNoZgLHl4haF9
	WdsoinNdGew7E5VKGQrDQW+xB07Pvkf4m7VZwR0YWW6h0y0s3fEswkZxhmFmp1yc4ecp
	VuVg==
X-Gm-Message-State: APjAAAVTwcxLQ5XqnJOO2YoUiAyhKehZND6srRJYul5vQI1L+BKWHNA9
	Vktg1/sWxdta1UFZxyavwIQ=
X-Google-Smtp-Source: APXvYqyyhGSdqPEvv1BlR4DJGOhel4jLkeN9sbYM++/muzgCF4kRzJDLYhIt6usA/7IMGd86xDA2JA==
X-Received: by 2002:a17:90a:cb0a:: with SMTP id
	z10mr10432703pjt.101.1559113858348; 
	Wed, 29 May 2019 00:10:58 -0700 (PDT)
Received: from localhost ([116.247.112.152]) by smtp.gmail.com with ESMTPSA id
	k6sm16970656pfi.86.2019.05.29.00.10.57
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 29 May 2019 00:10:58 -0700 (PDT)
From: elohimes@gmail.com
X-Google-Original-From: xieyongji@baidu.com
To: mst@redhat.com,
	groug@kaod.org,
	dgilbert@redhat.com
Date: Wed, 29 May 2019 15:09:52 +0800
Message-Id: <20190529070955.25565-3-xieyongji@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190529070955.25565-1-xieyongji@baidu.com>
References: <20190529070955.25565-1-xieyongji@baidu.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH 2/5] virtio: Migrate the "start_on_kick" flag
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
Cc: Xie Yongji <xieyongji@baidu.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xie Yongji <xieyongji@baidu.com>

We should migrate the "start_on_kick" flag so that we
would not miss starting device on kicking at startup
after migration.

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
---
 hw/virtio/virtio.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index fc8fca81ad..4d4ff67791 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1802,6 +1802,13 @@ static bool virtio_started_needed(void *opaque)
     return vdev->started;
 }
 
+static bool virtio_start_on_kick_needed(void *opaque)
+{
+    VirtIODevice *vdev = opaque;
+
+    return vdev->start_on_kick;
+}
+
 static const VMStateDescription vmstate_virtqueue = {
     .name = "virtqueue_state",
     .version_id = 1,
@@ -1941,6 +1948,17 @@ static const VMStateDescription vmstate_virtio_started = {
     }
 };
 
+static const VMStateDescription vmstate_virtio_start_on_kick = {
+    .name = "virtio/start_on_kick",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = &virtio_start_on_kick_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_BOOL(start_on_kick, VirtIODevice),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_virtio = {
     .name = "virtio",
     .version_id = 1,
@@ -1957,6 +1975,7 @@ static const VMStateDescription vmstate_virtio = {
         &vmstate_virtio_broken,
         &vmstate_virtio_extra_state,
         &vmstate_virtio_started,
+        &vmstate_virtio_start_on_kick,
         NULL
     }
 };
-- 
2.17.1


