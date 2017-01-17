Received: from eggs.gnu.org ([2001:4830:134:3::10]:58956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTSWl-0006Ot-8y
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:06:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTSWh-0001Pp-CU
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:06:15 -0500
Received: from indium.canonical.com ([91.189.90.7]:43532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cTSWh-0001Pd-6h
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:06:11 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cTSWg-00021w-9H
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 12:06:10 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3FAEA2E80BF
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 12:06:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Jan 2017 11:46:40 -0000
From: Thomas Huth <1596870@bugs.launchpad.net>
Reply-To: Bug 1596870 <1596870@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160628090613.31004.29740.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170117114640.27439.39060.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1596870] Re: qemu-img backed over https fails on
 zero-length file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Released with QEMU v2.8

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1596870

Title:
  qemu-img backed over https fails on zero-length file

Status in QEMU:
  Fix Released

Bug description:
  When creating new disk with qemu-img backed by file accessed over
  HTTPS and the backing file has zero length, qemu-img fails with
  uninformative error:

          qemu-img: disk.qcow2: CURL: Error opening file:

  The error message should either be improved, or the operation on zero-
  length file should be allowed. Some other backends, as e.g. raw
  backend for regular files, seem to allow empty files.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1596870/+subscriptions
