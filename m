Received: from eggs.gnu.org ([2001:4830:134:3::10]:50149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dThXo-000478-9m
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 00:40:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dThXi-00034X-H0
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 00:40:36 -0400
Received: from indium.canonical.com ([91.189.90.7]:41872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dThXi-00031l-Af
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 00:40:30 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dThXe-0001aZ-66
	for <qemu-devel@nongnu.org>; Sat, 08 Jul 2017 04:40:26 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 27EFA2E80E8
	for <qemu-devel@nongnu.org>; Sat,  8 Jul 2017 04:40:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Jul 2017 04:21:38 -0000
From: Launchpad Bug Tracker <961757@bugs.launchpad.net>
Reply-To: Bug 961757 <961757@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120321231146.16169.41826.malonedeb@chaenomeles.canonical.com>
Message-Id: <149948769886.21585.10233041919043249332.malone@loganberry.canonical.com>
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

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/961757

Title:
  wrong error for blockdev-snapshot-sync

Status in QEMU:
  Expired

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
