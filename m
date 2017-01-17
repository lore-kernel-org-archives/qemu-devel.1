Received: from eggs.gnu.org ([2001:4830:134:3::10]:60862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTa6V-0005Bw-Ey
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 15:11:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTa6Q-0001XI-DN
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 15:11:39 -0500
Received: from indium.canonical.com ([91.189.90.7]:39280)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cTa6Q-0001Wh-78
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 15:11:34 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cTa6O-0001hv-KC
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 20:11:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 872122E818F
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 20:11:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Jan 2017 19:56:34 -0000
From: Thomas Huth <1655764@bugs.launchpad.net>
Reply-To: Bug 1655764 <1655764@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170111212721.20360.4397.malonedeb@wampee.canonical.com>
Message-Id: <20170117195634.21157.4093.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1655764] Re: qemu-img convert -c compression
 can't decompress
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

When reporting bugs, please always use the latest version of QEMU, old
versions like 2.1 are not supported anymore. I just also noticed that
Stefan Hajnoczi replied to the bug mail on the qemu-devel mailing list
(see https://www.mail-archive.com/qemu-devel@nongnu.org/msg422186.html)
- seems like the bridge did not mirror this to the bug tracker:

"QEMU image compression uses the compression feature available in some
 disk image formats (like qcow2).  This is not the same as compressing a
 file with gzip, bzip2, or similar tools.
 Therefore this error is expected and not a bug."

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1655764

Title:
  qemu-img convert -c compression can't decompress

Status in QEMU:
  Invalid

Bug description:
  Used -c compression option of qemu-img convert to compress qcow2,
  then libvirt mount for compressed image don't work as well as decompressi=
on also
  not working, tried zlib-flate to decompress

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1655764/+subscriptions
