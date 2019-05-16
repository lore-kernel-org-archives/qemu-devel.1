Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50A9C04AB4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:21:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9923D20833
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9923D20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53753 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRFO2-0001qn-Pe
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 08:21:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFM5-0000Vo-Bn
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:19:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFM2-0001uR-5P
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:19:25 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:44409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hRFM2-0001uI-2j
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:19:22 -0400
Received: by mail-qt1-f172.google.com with SMTP id f24so3512626qtk.11
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 05:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=GEBbw5yBYMAQw8+9J5YyvTBzIi99r+JtCnmq4U1dRRs=;
	b=h+YxrALXwnCc5cVC8ePo4UwK0dDRWuNJ15JyZQRVsneHN8Bu+Jg8lXHNZ/5dDuUS48
	eVCtB4mHqfsINvQ5eMwOsawJvBJlyJAulXaT51MQhRftMWGZRFN/5CREPONv+PWrlGEE
	4PN4OUH2AezxZvDqPMc04EJVbKh1bStyPxVDP9Ll202nRBb6F6W9TsrdJrxHzB/UJl6C
	+u8pjkDBbtVrPfmukPfZCvM6XpGN9hQxmfcjD2UA4hAPahJfHRnmBT0OUkvkxc3cCGlR
	3ZDeqP+0IJI1CM+open22K/NVxCS9H/b1o8BvSisnUvZEKNYxcdYnlAty8hLhT/n38uZ
	UcQA==
X-Gm-Message-State: APjAAAUFwv9d+Js25SFc9iGoqr4HbxANNLrKpVYEHFfX6jKuzoZimaTl
	iVJfRBtFCg1UBgPw4a6UAYN9ZpBJuDs=
X-Google-Smtp-Source: APXvYqwztD8Dle4kuh7AEP2hkVfoMq4sByoI6Qj+z6cey3NzTRtv6IL05JiKdQNnjoOcqBxN/NPrkg==
X-Received: by 2002:a0c:9542:: with SMTP id m2mr23480022qvm.108.1558009161411; 
	Thu, 16 May 2019 05:19:21 -0700 (PDT)
Received: from redhat.com ([185.54.206.10]) by smtp.gmail.com with ESMTPSA id
	124sm2348926qkj.59.2019.05.16.05.19.19
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 16 May 2019 05:19:20 -0700 (PDT)
Date: Thu, 16 May 2019 08:19:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190416184624.15397-3-dan.streetman@canonical.com>
References: <20190515121146.7248-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190515121146.7248-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.172
Subject: [Qemu-devel] [PULL 15/37] do not call vhost_net_cleanup() on
 running net from char user event
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
Cc: Dan Streetman <ddstreet@canonical.com>,
	Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190516121918.kr-TVtgGC6vbxKi9ppkMZK3oRTlibhSYI-ZDHe2Js70@z>

From: Dan Streetman <ddstreet@canonical.com>

Buglink: https://launchpad.net/bugs/1823458

Currently, a user CHR_EVENT_CLOSED event will cause net_vhost_user_event()
to call vhost_user_cleanup(), which calls vhost_net_cleanup() for all
its queues.  However, vhost_net_cleanup() must never be called like
this for fully-initialized nets; when other code later calls
vhost_net_stop() - such as from virtio_net_vhost_status() - it will try
to access the already-cleaned-up fields and fail with assertion errors
or segfaults.

The vhost_net_cleanup() will eventually be called from
qemu_cleanup_net_client().

Signed-off-by: Dan Streetman <ddstreet@canonical.com>
Message-Id: <20190416184624.15397-3-dan.streetman@canonical.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-user.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/vhost-user.c b/net/vhost-user.c
index 5a26a24708..51921de443 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -236,7 +236,6 @@ static void chr_closed_bh(void *opaque)
     s = DO_UPCAST(NetVhostUserState, nc, ncs[0]);
 
     qmp_set_link(name, false, &err);
-    vhost_user_stop(queues, ncs);
 
     qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, net_vhost_user_event,
                              NULL, opaque, NULL, true);
-- 
MST


