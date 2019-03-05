Received: from eggs.gnu.org ([209.51.188.92]:43339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1h14Fc-0002bw-Gx
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 02:12:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1h14Fb-0000Uc-2S
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 02:12:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1h14FY-0000Op-0r
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 02:12:29 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Tue,  5 Mar 2019 15:12:08 +0800
Message-Id: <1551769940-22739-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1551769940-22739-1-git-send-email-jasowang@redhat.com>
References: <1551769940-22739-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL V2 01/13] net/colo-compare.c: Remove duplicated
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>

From: Zhang Chen <chen.zhang@intel.com>

Fix duplicated code:
https://bugs.launchpad.net/qemu/+bug/1811499

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/colo-compare.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 3e515f3..bf10526 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -294,14 +294,6 @@ static bool colo_mark_tcp_pkt(Packet *ppkt, Packet *=
spkt,
             return true;
         }
     }
-    if (ppkt->tcp_seq =3D=3D spkt->tcp_seq && ppkt->seq_end =3D=3D spkt-=
>seq_end) {
-        if (colo_compare_packet_payload(ppkt, spkt,
-                                        ppkt->header_size, spkt->header_=
size,
-                                        ppkt->payload_size)) {
-            *mark =3D COLO_COMPARE_FREE_SECONDARY | COLO_COMPARE_FREE_PR=
IMARY;
-            return true;
-        }
-    }
=20
     /* one part of secondary packet payload still need to be compared */
     if (!after(ppkt->seq_end, spkt->seq_end)) {
--=20
2.5.0
