Received: from eggs.gnu.org ([209.51.188.92]:41432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gqvGX-0006Dy-Mq
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 02:35:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gqvGV-0004EI-NA
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 02:35:33 -0500
Received: from indium.canonical.com ([91.189.90.7]:54204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gqvGR-0004Bx-P6
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 02:35:29 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gqvGP-0000ub-AE
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 07:35:25 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 481A52E8033
	for <qemu-devel@nongnu.org>; Tue,  5 Feb 2019 07:35:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 Feb 2019 07:21:58 -0000
From: Thomas Huth <1546680@bugs.launchpad.net>
Reply-To: Bug 1546680 <1546680@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160217182116.22366.12898.malonedeb@soybean.canonical.com>
Message-Id: <154935131818.31450.2370032342151552431.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1546680] Re: Incorrect display colors when
 running big endian guest on POWER8 little endian host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

IIRC there were some endianess fixes for this in the past ... can you
still reproduce this issue with the latest version of QEMU and a recent
kernel? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1546680

Title:
  Incorrect display colors when running big endian guest on POWER8
  little endian host

Status in QEMU:
  Incomplete

Bug description:
  When running a big endian CentOS guest on a little endian host system
  the display shows severe color issues, probably due to endianness not
  being properly detected / switched in the emulated display hardware.
  Little endian guests show no display issues on the same host hardware
  and software.

  See attachment for an example of the problem.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1546680/+subscriptions
