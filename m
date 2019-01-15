Received: from eggs.gnu.org ([209.51.188.92]:45153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gjLl7-00077k-2r
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 05:15:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gjLl6-0006Pp-8D
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 05:15:49 -0500
Received: from indium.canonical.com ([91.189.90.7]:48414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gjLl6-0006OU-1o
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 05:15:48 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gjLl4-0000Jx-0H
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 10:15:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F2F072E80C7
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 10:15:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Jan 2019 10:07:20 -0000
From: =?utf-8?b?0JrQvtGA0LXQvdCx0LXRgNCzINCc0LDRgNC6?=
	<1811720@bugs.launchpad.net>
Reply-To: Bug 1811720 <1811720@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154749896091.8755.12887494017193023179.malonedeb@chaenomeles.canonical.com>
Message-Id: <154754684047.20153.7544079003374097082.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1811720] Re: storage physical_block_size is
 restricted to uint16_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Yes, you are right. Thanks for the response.

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1811720

Title:
  storage physical_block_size is restricted to uint16_t

Status in QEMU:
  Invalid

Bug description:
  It is desirable to set -global scsi-hd.physical_block_size=3D4194304 for
  RBD-backed storage.

  But unfortunatelly, this values is restricted with uint16_t, i.e.
  65536 maximum.

  For example, scsi-hd.discard_granularity=3D4194304 is not so restricted
  (and works as expected)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1811720/+subscriptions
