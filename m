Received: from eggs.gnu.org ([209.51.188.92]:41170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJAPl-0005Y0-RM
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:25:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJAPi-00058k-9a
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:25:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:35728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJAPg-0004wT-6Z
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:25:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJAPc-0002Gy-Bo
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 05:25:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4DB0B2E80CD
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 05:25:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Apr 2019 05:19:13 -0000
From: Thomas Huth <1811499@bugs.launchpad.net>
Reply-To: Bug 1811499 <1811499@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154728291472.21076.10443354877272687540.malonedeb@soybean.canonical.com>
Message-Id: <155608315455.14412.14329702719793406651.launchpad@gac.canonical.com>
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

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1811499

Title:
  qemu/net/colo-compare.c:288: possible pointless code duplication ?

Status in QEMU:
  Fix Released

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
