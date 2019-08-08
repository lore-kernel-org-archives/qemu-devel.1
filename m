Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E19EC433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 14:36:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70199217F4
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 14:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70199217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvjWt-00019n-PA
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 10:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56972)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvjWG-0000GQ-5L
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 10:35:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvjWE-0005dx-5k
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 10:35:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52716)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvjWC-0005dK-85
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 10:35:53 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4DBAB3061524;
 Thu,  8 Aug 2019 14:35:51 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 02A791001B07;
 Thu,  8 Aug 2019 14:35:21 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  8 Aug 2019 16:34:52 +0200
Message-Id: <20190808143457.14111-2-philmd@redhat.com>
In-Reply-To: <20190808143457.14111-1-philmd@redhat.com>
References: <20190808143457.14111-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 08 Aug 2019 14:35:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC PATCH 1/6] hw/net/virtio-net: Use
 TCP_HEADER_FLAGS/TCP_HEADER_DATA_OFFSET macros
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Zhang Chen <chen.zhang@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"net/eth.h" provides convenient macros to avoid manipulating
the TCP header flags/offset bits manually, let's use them.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
RFC: Check the macro uses the correct bits

 hw/net/virtio-net.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index b9e1cd71cf..867f50613e 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -46,9 +46,6 @@
=20
 #define VIRTIO_NET_IP4_ADDR_SIZE   8        /* ipv4 saddr + daddr */
=20
-#define VIRTIO_NET_TCP_FLAG         0x3F
-#define VIRTIO_NET_TCP_HDR_LENGTH   0xF000
-
 /* IPv4 max payload, 16 bits in the header */
 #define VIRTIO_NET_MAX_IP4_PAYLOAD (65535 - sizeof(struct ip_header))
 #define VIRTIO_NET_MAX_TCP_PAYLOAD 65535
@@ -1658,10 +1655,8 @@ static int virtio_net_rsc_tcp_ctrl_check(VirtioNet=
RscChain *chain,
     uint16_t tcp_hdr;
     uint16_t tcp_flag;
=20
-    tcp_flag =3D htons(tcp->th_offset_flags);
-    tcp_hdr =3D (tcp_flag & VIRTIO_NET_TCP_HDR_LENGTH) >> 10;
-    tcp_flag &=3D VIRTIO_NET_TCP_FLAG;
-    tcp_flag =3D htons(tcp->th_offset_flags) & 0x3F;
+    tcp_hdr =3D TCP_HEADER_DATA_OFFSET(tcp);
+    tcp_flag =3D TCP_HEADER_FLAGS(tcp);
     if (tcp_flag & TH_SYN) {
         chain->stat.tcp_syn++;
         return RSC_BYPASS;
--=20
2.20.1


