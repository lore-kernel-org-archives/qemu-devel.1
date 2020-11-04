Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2A0C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:55:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA93A20782
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hzvxE2e4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA93A20782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaNwf-0007HH-Kk
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 13:55:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNjq-0001hf-Oz
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:42:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22835)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNjp-00026S-3Y
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:42:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604515348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Try6I8+Gzp362j90+uCp08fdMyiL5wC2Bsqj8twh+n4=;
 b=hzvxE2e4dL+i1++2dLycdR9lpW5vv84F+2QkQjjSw5DKVnih4TU3DJ0YP6uYv/umIaJu+F
 dTuJMIpSFzrUx8TJD75xaBD11ECf8wZaWZsn1y50HVn8TlJXwnknufeHAr6PV9uWs6R5B9
 6LrtRl75Hfv84KeE4E7WWUL9OhDLaxk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-qbCEMJWQOXSge5r4EDebng-1; Wed, 04 Nov 2020 13:42:26 -0500
X-MC-Unique: qbCEMJWQOXSge5r4EDebng-1
Received: by mail-wr1-f72.google.com with SMTP id i1so9580359wrb.18
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 10:42:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Try6I8+Gzp362j90+uCp08fdMyiL5wC2Bsqj8twh+n4=;
 b=t2v14mCS0rDTTQzCSB7leCNEZ54GJsE8bNOgCARJQUvjEGX9RppeJ4YzrA0smGR5Hr
 kWR1Zr6JdFxYINpJOubov53dNxr3ng8wImasAAxzsLT2L+ZUukF4PFXCHIE/I4xrlttC
 mc3daZ19bMPvQHxluCWexB4UnsFsFWAsKCzhQagcRG3mYVFWpaGgH5+ZFNuZ1IRh6sT3
 3NDN09fwxVGPxgwvNjQaBtUIDWEd6B8+ajLMMcwKuvyhE1vrrwL9VpfRKEqhv7y4EytL
 EwRiAX6e3EkhVZ0mBtoCKi3kzwZc5cfqNGaBvUOgpbslo1/Kqi3yoYfl+FG1Cr6cWlkM
 oSXg==
X-Gm-Message-State: AOAM53072nwCN8tOzn9k+b8A0KNpNtpmhcOVYr62ZXLkGTeoQr0037c7
 AvyvnOCZ3jU4RpBR0FOlleDbiUJdjxXkgkuyX1x/vO3JDbby6w/tIjEy7feW7XornfF28mUNBu5
 D9zXYoDYoB0SSMJY=
X-Received: by 2002:adf:dd09:: with SMTP id a9mr34051242wrm.208.1604515344947; 
 Wed, 04 Nov 2020 10:42:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzkTfKeUmM+P7f/sQQduJMEEgzCrQvVQedNk9WCw2hBBLx+hy3QpsT0oBP0sYUWKulR5KSQZA==
X-Received: by 2002:adf:dd09:: with SMTP id a9mr34051224wrm.208.1604515344810; 
 Wed, 04 Nov 2020 10:42:24 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id v6sm3269330wmj.6.2020.11.04.10.42.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 10:42:24 -0800 (PST)
Date: Wed, 4 Nov 2020 13:42:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 23/31] vhost-vdpa: Add qemu_close in vhost_vdpa_cleanup
Message-ID: <20201104184040.285057-24-mst@redhat.com>
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

fix the bug that fd will still open after the cleanup

Signed-off-by: Cindy Lu <lulu@redhat.com>
Message-Id: <20201016030909.9522-1-lulu@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 99c476db8c..fe659ec9e2 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -145,6 +145,10 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
         g_free(s->vhost_net);
         s->vhost_net = NULL;
     }
+     if (s->vhost_vdpa.device_fd >= 0) {
+        qemu_close(s->vhost_vdpa.device_fd);
+        s->vhost_vdpa.device_fd = -1;
+    }
 }
 
 static bool vhost_vdpa_has_vnet_hdr(NetClientState *nc)
-- 
MST


