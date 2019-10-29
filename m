Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB38CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 23:07:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED5A220862
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 23:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5A220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPaZu-0005Yh-Qt
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 19:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iPaTg-0008QG-GC
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:00:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iPaTf-0003bG-Co
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:00:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47169)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iPaTf-0003a2-6T
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:00:39 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 58316C0127FB
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 23:00:38 +0000 (UTC)
Received: by mail-qk1-f199.google.com with SMTP id d127so291799qkc.1
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 16:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=jMtSsx03QX/IIDbH0Kx4Noyi/+UwhkaQ02RrknqXoEc=;
 b=t8O8l5Xm7iDMyl7So2MeYyMrGi9vXWPDy0OAnZjxt1HqUiPx+wulHsa7UU9/ysTMCi
 KblFgHyaz0Wldq3brwJ5FolaYMDm9SfJXPdwjk5aUtq8g1B/ahXWIXbEUKodS06/g8y6
 m36Am66aeddTADdPK4mDXswh393j/kaFpm9OZeWmCU5kbZtZ/pLFKPSKC3BU6+yfgXdW
 RKySpuQqO9YARGqsKcBldCV5IsHYjmoDdvbuq1JaeWaJx6ysJV8hnZBol1xbGTrPOeJ+
 CN/wFfcS93fCnLXAMymAQrzHh2G0IG+4vHHqufT6PGhvpfdC1UP3t2A2M/OmoY/k1VXh
 pHCw==
X-Gm-Message-State: APjAAAUDqC56NPcdvXfWFzJQ6F+USoc1dBmUqssk9s06KqenGCVS4dQP
 XtAT8yKqCSWGrmMTG15eM2/Uv1y9Fm6aQN4UaCtDHH1OHCzj3N3SWFlRLj6wQJvvDhhj+DofOuo
 NaW5Q69GDJXapUPs=
X-Received: by 2002:ac8:8f3:: with SMTP id y48mr1875825qth.269.1572390037060; 
 Tue, 29 Oct 2019 16:00:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyCB8AfTvh9fzezZpg0MNlunKDv83RjMIo9N0JTBANHgwSnnm0aAuGikG43wAalCoqhwaQjdw==
X-Received: by 2002:ac8:8f3:: with SMTP id y48mr1875800qth.269.1572390036813; 
 Tue, 29 Oct 2019 16:00:36 -0700 (PDT)
Received: from redhat.com (94.222.26.109.rev.sfr.net. [109.26.222.94])
 by smtp.gmail.com with ESMTPSA id r2sm248653qtc.28.2019.10.29.16.00.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2019 16:00:36 -0700 (PDT)
Date: Tue, 29 Oct 2019 19:00:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/14] qapi: add failover negotiated event
Message-ID: <20191029225932.14585-7-mst@redhat.com>
References: <20191029225932.14585-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029225932.14585-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 Jens Freimann <jfreimann@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jens Freimann <jfreimann@redhat.com>

This event is sent to let libvirt know that VIRTIO_NET_F_STANDBY feature
is enabled. The primary device this virtio-net (standby) device is
associated with, is now hotplugged by the virtio-net device.

Signed-off-by: Jens Freimann <jfreimann@redhat.com>
Message-Id: <20191029114905.6856-7-jfreimann@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/net.json | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/qapi/net.json b/qapi/net.json
index 4c96137811..335295be50 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -735,3 +735,22 @@
 ##
 { 'command': 'announce-self', 'boxed': true,
   'data' : 'AnnounceParameters'}
+
+##
+# @FAILOVER_NEGOTIATED:
+#
+# Emitted when VIRTIO_NET_F_STANDBY was enabled during feature negotiation.
+# Failover primary devices which were hidden (not hotplugged when requested)
+# before will now be hotplugged by the virtio-net standby device.
+#
+# device-id: QEMU device id of the unplugged device
+# Since: 4.2
+#
+# Example:
+#
+# <- { "event": "FAILOVER_NEGOTIATED",
+#      "data": "net1" }
+#
+##
+{ 'event': 'FAILOVER_NEGOTIATED',
+  'data': {'device-id': 'str'} }
-- 
MST


