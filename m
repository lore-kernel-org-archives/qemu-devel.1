Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26C5C0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 14:38:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA5F82173E
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 14:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA5F82173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvjZ7-00072r-4V
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 10:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57245)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvjXR-00031I-3X
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 10:37:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvjXQ-0006I5-55
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 10:37:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11114)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvjXP-0006Hd-VR
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 10:37:08 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 336713147B12;
 Thu,  8 Aug 2019 14:37:07 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 58B0B10016E9;
 Thu,  8 Aug 2019 14:37:02 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  8 Aug 2019 16:34:57 +0200
Message-Id: <20190808143457.14111-7-philmd@redhat.com>
In-Reply-To: <20190808143457.14111-1-philmd@redhat.com>
References: <20190808143457.14111-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 08 Aug 2019 14:37:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 6/6] net/eth: Remove the single use of udp_hdr
 structure
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

Commit 75020a70215 introduced 2 very equivalent structures:
udp_header and udp_hdr.

Replace the single use of udp_hdr by udp_header (which has few more
uses in the codebase) and remove the now unused structure.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/net/net_tx_pkt.c | 2 +-
 include/net/eth.h   | 7 -------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index fc4514416c..25148cf01b 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -349,7 +349,7 @@ void net_tx_pkt_build_vheader(struct NetTxPkt *pkt, b=
ool tso_enable,
         case IP_PROTO_UDP:
             pkt->virt_hdr.flags =3D VIRTIO_NET_HDR_F_NEEDS_CSUM;
             pkt->virt_hdr.csum_start =3D pkt->hdr_len;
-            pkt->virt_hdr.csum_offset =3D offsetof(struct udp_hdr, uh_su=
m);
+            pkt->virt_hdr.csum_offset =3D offsetof(struct udp_header, uh=
_sum);
             break;
         default:
             break;
diff --git a/include/net/eth.h b/include/net/eth.h
index 0b2584328a..740ec225fb 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -153,13 +153,6 @@ struct ip6_option_hdr {
     uint8_t len;
 };
=20
-struct udp_hdr {
-  uint16_t uh_sport;           /* source port */
-  uint16_t uh_dport;           /* destination port */
-  uint16_t uh_ulen;            /* udp length */
-  uint16_t uh_sum;             /* udp checksum */
-};
-
 #define ip6_nxt      ip6_ctlun.ip6_un1.ip6_un1_nxt
 #define ip6_ecn_acc  ip6_ctlun.ip6_un3.ip6_un3_ecn
=20
--=20
2.20.1


