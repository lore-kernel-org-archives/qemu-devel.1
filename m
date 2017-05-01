Received: from eggs.gnu.org ([2001:4830:134:3::10]:35915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d5BOL-00013Q-Cj
	for qemu-devel@nongnu.org; Mon, 01 May 2017 09:29:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d5BOG-0007QM-CX
	for qemu-devel@nongnu.org; Mon, 01 May 2017 09:29:29 -0400
Received: from indium.canonical.com ([91.189.90.7]:42925)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d5BOG-0007Pz-6b
	for qemu-devel@nongnu.org; Mon, 01 May 2017 09:29:24 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d5BOE-0006uc-W4
	for <qemu-devel@nongnu.org>; Mon, 01 May 2017 13:29:23 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F10882E80C4
	for <qemu-devel@nongnu.org>; Mon,  1 May 2017 13:29:22 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 May 2017 13:16:18 -0000
From: Thomas Huth <961757@bugs.launchpad.net>
Reply-To: Bug 961757 <961757@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120321231146.16169.41826.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170501131618.2931.99359.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 961757] Re: wrong error for blockdev-snapshot-sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Which version of QEMU was this? Is this still a problem with the latest
version of QEMU?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/961757

Title:
  wrong error for blockdev-snapshot-sync

Status in QEMU:
  Incomplete

Bug description:
  From Laszlo Ersek:

  >> +    proto_drv =3D bdrv_find_protocol(snapshot_file);
  >>      if (!proto_drv) {
  >> -        qerror_report(QERR_INVALID_BLOCK_FORMAT, format);
  >> -        ret =3D -1;
  >> -        goto out;
  >> +        error_set(errp, QERR_INVALID_BLOCK_FORMAT, format);
  >> +        return;
  >>      }
  > =

  > I don't understand the logic here (based on the error message). We
  > specified "format" for the case when a completely new snapshot file has
  > to be created. If the file exists already, then bdrv_find_protocol()
  > tries to find the driver for it. If that fails, then we must report an
  > error indeed, but instead of referring to "format", we'd have to report
  > the "scheme" from the beginning of "snapshot_file".

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/961757/+subscriptions
