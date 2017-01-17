Received: from eggs.gnu.org ([2001:4830:134:3::10]:39316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTaKF-0002We-HA
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 15:25:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTaKB-0001kl-Fa
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 15:25:51 -0500
Received: from indium.canonical.com ([91.189.90.7]:42164)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cTaKB-0001jW-AN
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 15:25:47 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cTaK9-00086w-R0
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 20:25:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id ABF342E80C8
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 20:25:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Jan 2017 20:14:07 -0000
From: Jignasha <jignasha.vithalani@triliodata.com>
Reply-To: Bug 1655764 <1655764@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170111212721.20360.4397.malonedeb@wampee.canonical.com>
Message-Id: <20170117201407.27020.70031.malone@chaenomeles.canonical.com>
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

Yes used qcow2 format only when compressing, I don't think due to older
version problem

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
