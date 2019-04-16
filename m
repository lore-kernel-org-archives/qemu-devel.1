Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B4EC10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 18:48:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAE52206BA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 18:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE52206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40949 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGT8C-0002XK-VE
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 14:48:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.streetman@canonical.com>) id 1hGT6V-0001fc-7F
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:46:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.streetman@canonical.com>) id 1hGT6U-0005dp-6B
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:46:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dan.streetman@canonical.com>)
	id 1hGT6T-0005Zp-Tf
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:46:46 -0400
Received: from mail-yw1-f72.google.com ([209.85.161.72])
	by youngberry.canonical.com with esmtps
	(TLS1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <dan.streetman@canonical.com>) id 1hGT6S-00007J-TV
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 18:46:45 +0000
Received: by mail-yw1-f72.google.com with SMTP id g140so16214059ywb.12
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 11:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=hrTL3dZnHK74VlB2j2ilreuanyT4P+9dLL2Aizt0BCY=;
	b=O/s+b6qfY6aQHakbnW4TJQiKgSQsdTY4J2OyBi5X2Lame+8eZ9HxkmUBy9Tsdb7ipE
	cg6AlRL4OXzcwtYpgJnENLwy9QWAmGWjZs66vaOulRe45LFSTfIchRiKXR9tIropCq9X
	TZs9LBqa2C2+lrg5D0Ki6DW4YDorPlrVMAkscBDEQpECsLQC5Zs4OL+epGqEEWrtoS1Y
	PtrFWz2+BksQQytFWqwNwqMdBtLdtI+/ACmSe1P/gfm5liIv4pPMBjESA7jIWalun2ze
	V1NHJGl6xaW/Bk0q0Ik5ooVT6UEedysUTpus7IxLzXZvslTfmHvhW1vaPCnNcEJ5o5ou
	9zPQ==
X-Gm-Message-State: APjAAAVzvy1wBS+As1YskMs5ANflg95ygGwHOwZvh3ZfxWmVC5Bd1cQ3
	BjZ47zGd2196VLHtEQedJoMh6fr6MuPhVs0CgffJ1ZUifSG+4EYb78Ce4CBDYrtZceT4Xh9TDqQ
	MTbAYhouJ0CRnfsmFZ+7Le/cTSB+8Ycnz
X-Received: by 2002:a81:4f10:: with SMTP id d16mr65360375ywb.184.1555440404003;
	Tue, 16 Apr 2019 11:46:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxeCrXLAscbb7wcqKwiWcP5pkJ5JsWcDZjXB4Bk8/j9G+D0bU/sJvFlt4+sXlPDjVAbYoiMvg==
X-Received: by 2002:a81:4f10:: with SMTP id d16mr65360351ywb.184.1555440403742;
	Tue, 16 Apr 2019 11:46:43 -0700 (PDT)
Received: from thorin.lan (45-27-90-188.lightspeed.rlghnc.sbcglobal.net.
	[45.27.90.188]) by smtp.gmail.com with ESMTPSA id
	c205sm17554833ywc.10.2019.04.16.11.46.43
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 11:46:43 -0700 (PDT)
From: Dan Streetman <dan.streetman@canonical.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	qemu-devel@nongnu.org, qemu-stable@nongnu.org
Date: Tue, 16 Apr 2019 14:46:24 -0400
Message-Id: <20190416184624.15397-3-dan.streetman@canonical.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416184624.15397-1-dan.streetman@canonical.com>
References: <20190416184624.15397-1-dan.streetman@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 91.189.89.112
Subject: [Qemu-devel] [PATCH 2/2] do not call vhost_net_cleanup() on running
 net from char user event
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190416184624.GwEmLUSU8HZP6x8Zl38CG4HPsCA_yQ8cdbIKA5SwD6I@z>

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
2.20.1


