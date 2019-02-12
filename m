Received: from eggs.gnu.org ([209.51.188.92]:52350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gtN12-00055v-DN
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 20:37:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gtMpU-0006tB-4i
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 20:25:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:47322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gtMpJ-0006kN-CP
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 20:25:33 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gtMpH-00076c-T5
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 01:25:31 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BD3B62E80CC
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 01:25:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 Feb 2019 01:16:07 -0000
From: John Snow <1808928@bugs.launchpad.net>
Reply-To: Bug 1808928 <1808928@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154511858636.8591.3431958243733477284.malonedeb@gac.canonical.com>
Message-Id: <154993416748.25593.344286169027865049.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1808928] Re: Bitmap Extra data is not supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi, bitmap extensions have a field that allows us to attach
extra/arbitrary data to them. It is not currently used by QEMU. If this
field is set, it means something corrupted your qcow2.

Please make a backup of your qcow2 file first (because attempting to
repair a broken qcow2 can sometimes make it worse), and then please try
running qemu-img check to try and diagnose the image.

What happened to cause the "disastrous error", do you recall?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1808928

Title:
  Bitmap Extra data is not supported

Status in QEMU:
  New

Bug description:
  i am using dirty bitmaps and drive-backup. It works as aspected.

  Lately, i encounter a disastrous error. There is not any information
  about that situation. I cannot reach/open/attach/info or anything with
  a qcow2 file.

  virsh version
  Compiled against library: libvirt 4.10.0
  Using library: libvirt 4.10.0
  Using API: QEMU 4.10.0
  Running hypervisor: QEMU 2.12.0

  "qemu-img: Could not open '/var/lib/libvirt/images/test.qcow2': Bitmap
  extra data is not supported"

  what is that mean? what should i do?
  i cannot remove bitmap. i cannot open image or query.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1808928/+subscriptions
