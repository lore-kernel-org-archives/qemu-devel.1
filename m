Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A36C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 14:38:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C86072173E
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 14:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C86072173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvjYa-0006Ao-5Y
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 10:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57201)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvjXL-0002lK-W0
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 10:37:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvjXK-0006FK-Se
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 10:37:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57820)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvjXK-0006EB-Na
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 10:37:02 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 03A5B6404E;
 Thu,  8 Aug 2019 14:37:02 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 010661001955;
 Thu,  8 Aug 2019 14:36:46 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  8 Aug 2019 16:34:56 +0200
Message-Id: <20190808143457.14111-6-philmd@redhat.com>
In-Reply-To: <20190808143457.14111-1-philmd@redhat.com>
References: <20190808143457.14111-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 08 Aug 2019 14:37:02 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 5/6] net/eth: Remove the unused tcp_hdr
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

Commit 75020a70215 introduced 2 very similar structures:
tcp_header and tcp_hdr.

We replaced the uses of struct tcp_hdr with the equivalent
struct tcp_header. Remove the unused one.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
I prefer the TCP_FLAG_XXX name, but there is only one single use of
TCP_FLAG_ACK vs many use of the other set, so I'm keeping the set.

 include/net/eth.h | 40 ++++++++--------------------------------
 1 file changed, 8 insertions(+), 32 deletions(-)

diff --git a/include/net/eth.h b/include/net/eth.h
index 7f45c678e7..0b2584328a 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -72,7 +72,14 @@ typedef struct tcp_header {
 #define TCP_HEADER_FLAGS(tcp) \
     TCP_FLAGS_ONLY(be16_to_cpu((tcp)->th_offset_flags))
=20
-#define TCP_FLAG_ACK  0x10
+#define TH_FIN  0x01
+#define TH_SYN  0x02
+#define TH_RST  0x04
+#define TH_PUSH 0x08
+#define TH_ACK  0x10
+#define TH_URG  0x20
+#define TH_ECE  0x40
+#define TH_CWR  0x80
=20
 #define TCP_HEADER_DATA_OFFSET(tcp) \
     (((be16_to_cpu((tcp)->th_offset_flags) >> 12) & 0xf) << 2)
@@ -153,37 +160,6 @@ struct udp_hdr {
   uint16_t uh_sum;             /* udp checksum */
 };
=20
-struct tcp_hdr {
-    u_short     th_sport;   /* source port */
-    u_short     th_dport;   /* destination port */
-    uint32_t    th_seq;     /* sequence number */
-    uint32_t    th_ack;     /* acknowledgment number */
-#ifdef HOST_WORDS_BIGENDIAN
-    u_char  th_off : 4,     /* data offset */
-        th_x2:4;            /* (unused) */
-#else
-    u_char  th_x2 : 4,      /* (unused) */
-        th_off:4;           /* data offset */
-#endif
-
-#define TH_ELN  0x1 /* explicit loss notification */
-#define TH_ECN  0x2 /* explicit congestion notification */
-#define TH_FS   0x4 /* fast start */
-
-    u_char  th_flags;
-#define TH_FIN  0x01
-#define TH_SYN  0x02
-#define TH_RST  0x04
-#define TH_PUSH 0x08
-#define TH_ACK  0x10
-#define TH_URG  0x20
-#define TH_ECE  0x40
-#define TH_CWR  0x80
-    u_short th_win;      /* window */
-    u_short th_sum;      /* checksum */
-    u_short th_urp;      /* urgent pointer */
-};
-
 #define ip6_nxt      ip6_ctlun.ip6_un1.ip6_un1_nxt
 #define ip6_ecn_acc  ip6_ctlun.ip6_un3.ip6_un3_ecn
=20
--=20
2.20.1


