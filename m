Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772FDC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:49:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE47D22447
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NTob9/nV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE47D22447
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZxd9-0006ul-Te
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 09:49:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxP6-0005OH-V8
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:35:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58198)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxP3-0006ej-As
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:35:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604414116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=APdAnMGOimWpi0/lmUkQSWdNUl1kK18oif2GgMOHc/o=;
 b=NTob9/nV/jdls7qUfEFYyHigmUGCLRwmfJskk5YG1at3AryajlErEqlRx2OPhx+nC1o/T6
 zGbeHcXRPs77NQnOg17I7hmQTZEHXWt2vmJDkNAgRD7eH47uzMprKevYRDXDaoTIRir9fZ
 4uZGuFh6VSr/1osP+XIsmIfWjLMfI8k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-l0nhv9nZMQ-ds_GTRLbxQA-1; Tue, 03 Nov 2020 09:35:15 -0500
X-MC-Unique: l0nhv9nZMQ-ds_GTRLbxQA-1
Received: by mail-wm1-f72.google.com with SMTP id z62so18603wmb.1
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 06:35:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=APdAnMGOimWpi0/lmUkQSWdNUl1kK18oif2GgMOHc/o=;
 b=gQuBTpmuvma+Zi9uiLBgCxxx4Utu50L3Vlk634BlVgTXKxy6IRXc6snf/8uzcF0TAU
 EbzcYBNi3WYZzmtEw8qEGyMjkLiITJuiYxqU4N9p7RR0775Cve06a9GzbhW1dyjtZ5gF
 KUxhz8JDF3DlmHo2NdFPd3fbhl1Iec75w6eiBvter4jCuWQMj63q1TS/vDIYN6NtKSgY
 07ClaLc1pEwEPtRAEHcGTHoXY5bIYLzA5M1XItnn8dcfML+S9psoG8Y+rPLoF5HVfuqZ
 awR1JaefnrPnLvT+ZTDa2N5ncsv3B8KAJoqtJ4gUIreAbzGrqwd8Pdp991MRaFNYEdEJ
 lecA==
X-Gm-Message-State: AOAM533K8vczVG+fKachjmEEdAjiz3v+K4GRiI+f6xPJQyB8ME8eXeEi
 h7O1aM5VfS+tA+osH4bdI0bzszhWSBBfvlT2MkzowjP5eja9Ehl/0DCgJEUUUeCtfU1HnVeUMmc
 txM9+Awc80wsPJsU=
X-Received: by 2002:a5d:4409:: with SMTP id z9mr26083329wrq.236.1604414113245; 
 Tue, 03 Nov 2020 06:35:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxZR2kKqcuddZ/U6aOOxHKUCf2fG112fCduIj9t2zuR4ymWycluttXqA0FkMzP7RA0aJ63HAw==
X-Received: by 2002:a5d:4409:: with SMTP id z9mr26083314wrq.236.1604414113101; 
 Tue, 03 Nov 2020 06:35:13 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id c17sm3016007wml.14.2020.11.03.06.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 06:35:12 -0800 (PST)
Date: Tue, 3 Nov 2020 09:35:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 27/38] libvhost-user: follow QEMU comment style
Message-ID: <20201103142306.71782-28-mst@redhat.com>
References: <20201103142306.71782-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201103142306.71782-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20201027173528.213464-2-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/libvhost-user/libvhost-user.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index 3bbeae8587..a1539dbb69 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -392,7 +392,8 @@ struct VuDev {
     bool broken;
     uint16_t max_queues;
 
-    /* @read_msg: custom method to read vhost-user message
+    /*
+     * @read_msg: custom method to read vhost-user message
      *
      * Read data from vhost_user socket fd and fill up
      * the passed VhostUserMsg *vmsg struct.
@@ -409,15 +410,19 @@ struct VuDev {
      *
      */
     vu_read_msg_cb read_msg;
-    /* @set_watch: add or update the given fd to the watch set,
-     * call cb when condition is met */
+
+    /*
+     * @set_watch: add or update the given fd to the watch set,
+     * call cb when condition is met.
+     */
     vu_set_watch_cb set_watch;
 
     /* @remove_watch: remove the given fd from the watch set */
     vu_remove_watch_cb remove_watch;
 
-    /* @panic: encountered an unrecoverable error, you may try to
-     * re-initialize */
+    /*
+     * @panic: encountered an unrecoverable error, you may try to re-initialize
+     */
     vu_panic_cb panic;
     const VuDevIface *iface;
 
-- 
MST


