Received: from eggs.gnu.org ([209.51.188.92]:51287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1giF4s-0001sy-77
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 03:55:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1giF4r-0006M1-5Z
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 03:55:38 -0500
Received: from indium.canonical.com ([91.189.90.7]:51388)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1giF4q-0006KU-VQ
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 03:55:37 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1giF4p-0004Ke-13
	for <qemu-devel@nongnu.org>; Sat, 12 Jan 2019 08:55:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 035C72E80C8
	for <qemu-devel@nongnu.org>; Sat, 12 Jan 2019 08:55:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Jan 2019 08:48:34 -0000
From: dcb <1811499@bugs.launchpad.net>
Reply-To: Bug 1811499 <1811499@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154728291472.21076.10443354877272687540.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1811499] [NEW] qemu/net/colo-compare.c:288:
 possible pointless code duplication ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

qemu/net/colo-compare.c:288] -> [qemu/net/colo-compare.c:296]: (style)
The if condition is the same as the previous if condition

Source code is

    if (ppkt->tcp_seq =3D=3D spkt->tcp_seq && ppkt->seq_end =3D=3D spkt->se=
q_end) {
        if (colo_compare_packet_payload(ppkt, spkt,
                                        ppkt->header_size, spkt->header_siz=
e,
                                        ppkt->payload_size)) {
            *mark =3D COLO_COMPARE_FREE_SECONDARY | COLO_COMPARE_FREE_PRIMA=
RY;
            return true;
        }
    }
    if (ppkt->tcp_seq =3D=3D spkt->tcp_seq && ppkt->seq_end =3D=3D spkt->se=
q_end) {
        if (colo_compare_packet_payload(ppkt, spkt,
                                        ppkt->header_size, spkt->header_siz=
e,
                                        ppkt->payload_size)) {
            *mark =3D COLO_COMPARE_FREE_SECONDARY | COLO_COMPARE_FREE_PRIMA=
RY;
            return true;
        }
    }

Maybe the second block was supposed to be different ?

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1811499

Title:
  qemu/net/colo-compare.c:288: possible pointless code duplication ?

Status in QEMU:
  New

Bug description:
  qemu/net/colo-compare.c:288] -> [qemu/net/colo-compare.c:296]: (style)
  The if condition is the same as the previous if condition

  Source code is

      if (ppkt->tcp_seq =3D=3D spkt->tcp_seq && ppkt->seq_end =3D=3D spkt->=
seq_end) {
          if (colo_compare_packet_payload(ppkt, spkt,
                                          ppkt->header_size, spkt->header_s=
ize,
                                          ppkt->payload_size)) {
              *mark =3D COLO_COMPARE_FREE_SECONDARY | COLO_COMPARE_FREE_PRI=
MARY;
              return true;
          }
      }
      if (ppkt->tcp_seq =3D=3D spkt->tcp_seq && ppkt->seq_end =3D=3D spkt->=
seq_end) {
          if (colo_compare_packet_payload(ppkt, spkt,
                                          ppkt->header_size, spkt->header_s=
ize,
                                          ppkt->payload_size)) {
              *mark =3D COLO_COMPARE_FREE_SECONDARY | COLO_COMPARE_FREE_PRI=
MARY;
              return true;
          }
      }

  Maybe the second block was supposed to be different ?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1811499/+subscriptions
