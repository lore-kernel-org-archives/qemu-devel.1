Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D61C76192
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 09:09:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1519220659
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 09:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="zFJCuL8n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1519220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnJSL-0001b3-Eb
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 05:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49826)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <antonkuchin@yandex-team.ru>) id 1hnJSA-0001Bt-HA
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 05:08:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <antonkuchin@yandex-team.ru>) id 1hnJS9-0000uk-2d
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 05:08:54 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:46202)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <antonkuchin@yandex-team.ru>)
 id 1hnJS8-0000qZ-FB; Tue, 16 Jul 2019 05:08:53 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::301])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 1BEF32E1489;
 Tue, 16 Jul 2019 12:08:48 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net
 [2a02:6b8:0:1472:2741:0:8b6:10])
 by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 4yJEaq2cgi-8liuXbex; Tue, 16 Jul 2019 12:08:48 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1563268128; bh=IAPuz1mCtbeDJgEG2GHY7V+hQF0B0Lrc4TWrQukY4Q4=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=zFJCuL8nbTN95TAYyvKfpD9EKjztcHThDkqVvnCc4D1pOfJ5lpqxXAOFp07gROey6
 i7yY63KS6rIQSutPlRv2fTtdkTQLp/VBYDVm09sYdeyKV1MymC205U7dGFlAlUvzXE
 FMJB3G+ahnS0k8B4j3pBqjQ7PE0uRqdn59FNlhqM=
Authentication-Results: mxbackcorp1o.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:408:250:b6ff:fe97:2682])
 by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
 c0IeHuEGSf-8lwCZ2iK; Tue, 16 Jul 2019 12:08:47 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Anton Kuchin <antonkuchin@yandex-team.ru>
To: qemu-devel@nongnu.org
Date: Tue, 16 Jul 2019 12:08:39 +0300
Message-Id: <20190716090839.19708-1-antonkuchin@yandex-team.ru>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 77.88.29.217
Subject: [Qemu-devel] [PATCH] virtio-net: remove redundant qdev from
 VirtIONet
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
Cc: qemu-trivial@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Anton Kuchin <antonkuchin@yandex-team.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Anton Kuchin <antonkuchin@yandex-team.ru>
---
 hw/net/virtio-net.c            | 3 +--
 include/hw/virtio/virtio-net.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index b9e1cd71cf..16d2ad5927 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -387,7 +387,7 @@ static void rxfilter_notify(NetClientState *nc)
     VirtIONet *n =3D qemu_get_nic_opaque(nc);
=20
     if (nc->rxfilter_notify_enabled) {
-        gchar *path =3D object_get_canonical_path(OBJECT(n->qdev));
+        gchar *path =3D object_get_canonical_path(OBJECT(n));
         qapi_event_send_nic_rx_filter_changed(!!n->netclient_name,
                                               n->netclient_name, path);
         g_free(path);
@@ -2759,7 +2759,6 @@ static void virtio_net_device_realize(DeviceState *=
dev, Error **errp)
     nc->rxfilter_notify_enabled =3D 1;
=20
     QTAILQ_INIT(&n->rsc_chains);
-    n->qdev =3D dev;
 }
=20
 static void virtio_net_device_unrealize(DeviceState *dev, Error **errp)
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-ne=
t.h
index b96f0c643f..4a1b599d48 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -174,7 +174,6 @@ struct VirtIONet {
     uint32_t *vlans;
     virtio_net_conf net_conf;
     NICConf nic_conf;
-    DeviceState *qdev;
     int multiqueue;
     uint16_t max_queues;
     uint16_t curr_queues;
--=20
2.20.1


