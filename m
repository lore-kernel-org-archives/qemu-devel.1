Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DA6C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:50:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4859C20780
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KlSBwW8v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4859C20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaNrR-0005ah-2J
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 13:50:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNjv-0001kM-Vl
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:42:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37908)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNjr-00026l-FU
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:42:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604515350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MaK8aBvBSiaUINk0iflL/mAr7Ti2mM7e4TQ+bKVJ1uk=;
 b=KlSBwW8vx7VfclMQ44+315m/pIXsLfy7IBUGVxgc7faXyHy/7jWB6QiSqtXW+lsOBhbJvc
 5ZaCpO5sC3GDWjCTdfyh4M7f3wF+wkhvG4S+Iw8Dz9O3P+Pvsa3EWOphogTBUl6dnMAKxy
 0cLcJC2qYXNsQvmHamu4jatzRnHxsd4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-qmCnUhrTMh2nt2-w5ODMNg-1; Wed, 04 Nov 2020 13:42:29 -0500
X-MC-Unique: qmCnUhrTMh2nt2-w5ODMNg-1
Received: by mail-wm1-f72.google.com with SMTP id z62so1478268wmb.1
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 10:42:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MaK8aBvBSiaUINk0iflL/mAr7Ti2mM7e4TQ+bKVJ1uk=;
 b=YuaICchngMntRdPiQNbGH0rVQ88NfgeEpflbUn1LBGVPN0hoSc6XVN6BiL1srUvodF
 ny7CYlifsnaeDmRo3okshOxq1V2rwm566T8bl4+AYVttNOcpj7RVGBzeQo/sy6znZ4ci
 UMzi3kSVCeOUWQSjNjszcFaejtbylemcqwUdXaGX3rcCoowAYUFMfXQ/hibv4MdyEE7y
 /olVFxu4Ma5jXZDtyzarpnE8h3VyeoYLv9ZY2EN9+yToXcxDzm1pUctFbGLDRcwI6g3+
 WhE0sce5QSOeEachdLpSJkKlpW7EcNE2PPcjucPgpsy4OE5KexIcWw0ssuFXj7Nlzq+1
 GXKQ==
X-Gm-Message-State: AOAM530z8G0oUVPpTxluxEzHw6K5+YFu1M72ZyAP31TdLyETnUq+RVrT
 I4zn2Yn1iOp8jx/krJ0ZQV8MhUHEiKtE9+9GyAlE0+pm9hZmtu0R44l1b5jjdJR1CNIbTgXRsuY
 1IZOv0fytb2laEGI=
X-Received: by 2002:a5d:6944:: with SMTP id r4mr33796059wrw.151.1604515347462; 
 Wed, 04 Nov 2020 10:42:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyG9y7VPtZpvzwUoKhVpPyXwx7Hp+NtZ8K+2uCxEy9i0V+D2HqYBbnxL8Shd+aYWGcK4jYFHg==
X-Received: by 2002:a5d:6944:: with SMTP id r4mr33796042wrw.151.1604515347283; 
 Wed, 04 Nov 2020 10:42:27 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id r10sm3415293wmg.16.2020.11.04.10.42.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 10:42:26 -0800 (PST)
Date: Wed, 4 Nov 2020 13:42:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 24/31] net: Add vhost-vdpa in show_netdevs()
Message-ID: <20201104184040.285057-25-mst@redhat.com>
References: <20201104184040.285057-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201104184040.285057-1-mst@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cindy Lu <lulu@redhat.com>

Fix the bug that while Check qemu supported netdev,
there is no vhost-vdpa

Signed-off-by: Cindy Lu <lulu@redhat.com>
Message-Id: <20201016030909.9522-2-lulu@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/net.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/net.c b/net/net.c
index 7a2a0fb5ac..794c652282 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1049,6 +1049,9 @@ static void show_netdevs(void)
 #endif
 #ifdef CONFIG_POSIX
         "vhost-user",
+#endif
+#ifdef CONFIG_VHOST_VDPA
+        "vhost-vdpa",
 #endif
     };
 
-- 
MST


