Received: from eggs.gnu.org ([209.51.188.92]:36509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gj9Gn-0004ep-1q
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 15:55:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gj9Gl-0002Rc-OW
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 15:55:40 -0500
Received: from indium.canonical.com ([91.189.90.7]:39370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gj9Gl-0002QC-Iw
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 15:55:39 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gj9Gg-0004Os-Dx
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 20:55:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 66E742E80C8
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 20:55:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Jan 2019 20:49:20 -0000
From: =?utf-8?b?0JrQvtGA0LXQvdCx0LXRgNCzINCc0LDRgNC6?=
	<1811720@bugs.launchpad.net>
Reply-To: Bug 1811720 <1811720@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154749896091.8755.12887494017193023179.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1811720] [NEW] storage physical_block_size is
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

Public bug reported:

It is desirable to set -global scsi-hd.physical_block_size=3D4194304 for
RBD-backed storage.

But unfortunatelly, this values is restricted with uint16_t, i.e. 65536
maximum.

For example, scsi-hd.discard_granularity=3D4194304 is not so restricted
(and works as expected)

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1811720

Title:
  storage physical_block_size is restricted to uint16_t

Status in QEMU:
  New

Bug description:
  It is desirable to set -global scsi-hd.physical_block_size=3D4194304 for
  RBD-backed storage.

  But unfortunatelly, this values is restricted with uint16_t, i.e.
  65536 maximum.

  For example, scsi-hd.discard_granularity=3D4194304 is not so restricted
  (and works as expected)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1811720/+subscriptions
