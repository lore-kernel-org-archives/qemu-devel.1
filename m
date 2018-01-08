Received: from eggs.gnu.org ([2001:4830:134:3::10]:33621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbEd-00083N-1c
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:29:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbEc-0008Pm-7r
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:29:19 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:46339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbEc-0008PE-3j
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:29:18 -0500
Received: by mail-qk0-x241.google.com with SMTP id l12so14750630qke.13
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 09:29:18 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 Jan 2018 14:28:54 -0300
Message-Id: <20180108172904.8772-3-f4bug@amsat.org>
In-Reply-To: <20180108172904.8772-1-f4bug@amsat.org>
References: <20180108172904.8772-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 02/12] slirp: struct icmp/ethhdr ARE packed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 slirp/ip6_icmp.h | 6 +++---
 slirp/ip_icmp.h  | 2 +-
 slirp/slirp.h    | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/slirp/ip6_icmp.h b/slirp/ip6_icmp.h
index b3378b17b5..a4ccc69974 100644
--- a/slirp/ip6_icmp.h
+++ b/slirp/ip6_icmp.h
@@ -17,20 +17,20 @@
 struct icmp6_echo { /* Echo Messages */
     uint16_t id;
     uint16_t seq_num;
-};
+} QEMU_PACKED;
 
 union icmp6_error_body {
     uint32_t unused;
     uint32_t pointer;
     uint32_t mtu;
-};
+} QEMU_PACKED;
 
 /*
  * NDP Messages
  */
 struct ndp_rs {     /* Router Solicitation Message */
     uint32_t reserved;
-};
+} QEMU_PACKED;
 
 struct ndp_ra {     /* Router Advertisement Message */
     uint8_t chl;    /* Cur Hop Limit */
diff --git a/slirp/ip_icmp.h b/slirp/ip_icmp.h
index d88ab34c1b..e53242bdd8 100644
--- a/slirp/ip_icmp.h
+++ b/slirp/ip_icmp.h
@@ -88,7 +88,7 @@ struct icmp {
 #define	icmp_ip		icmp_dun.id_ip.idi_ip
 #define	icmp_mask	icmp_dun.id_mask
 #define	icmp_data	icmp_dun.id_data
-};
+} QEMU_PACKED;
 
 /*
  * Lower bounds on packet lengths for various types.
diff --git a/slirp/slirp.h b/slirp/slirp.h
index 9f29b52610..9a7287e7cc 100644
--- a/slirp/slirp.h
+++ b/slirp/slirp.h
@@ -103,7 +103,7 @@ struct ethhdr {
     unsigned char  h_dest[ETH_ALEN];   /* destination eth addr */
     unsigned char  h_source[ETH_ALEN]; /* source ether addr    */
     unsigned short h_proto;            /* packet type ID field */
-};
+} QEMU_PACKED;
 
 struct slirp_arphdr {
     unsigned short ar_hrd;      /* format of hardware address */
-- 
2.15.1
