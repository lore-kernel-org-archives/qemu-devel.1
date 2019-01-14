Received: from eggs.gnu.org ([209.51.188.92]:36456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gj3oO-0001rB-AP
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:06:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gj3oK-0007Cz-Bx
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:06:00 -0500
Received: from indium.canonical.com ([91.189.90.7]:55982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gj3oK-0007CA-4u
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:05:56 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gj3oH-0001jT-Jv
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 15:05:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 68E212E80D8
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 15:05:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Jan 2019 14:54:09 -0000
From: Zhang Chen <zhangckid@gmail.com>
Reply-To: Bug 1811499 <1811499@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154728291472.21076.10443354877272687540.malonedeb@soybean.canonical.com>
Message-Id: <154747764953.18786.725837638201913266.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1811499] Re: qemu/net/colo-compare.c:288:
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

Have fixed in this patch.
https://lists.nongnu.org/archive/html/qemu-devel/2019-01/msg02859.html

Thanks
Zhang Chen

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
