Received: from eggs.gnu.org ([209.51.188.92]:36412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gvpAl-0007m6-Hh
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 15:05:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gvpAi-0002H6-G9
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 15:05:50 -0500
Received: from indium.canonical.com ([91.189.90.7]:46846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gvpAe-0002DX-AA
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 15:05:46 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gvpAb-0005fj-NK
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 20:05:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AC2B72E8070
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 20:05:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 Feb 2019 19:56:22 -0000
From: John Snow <1808928@bugs.launchpad.net>
Reply-To: Bug 1808928 <1808928@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154511858636.8591.3431958243733477284.malonedeb@gac.canonical.com>
Message-Id: <155051978212.28678.14987935362706104563.malone@chaenomeles.canonical.com>
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

OK, I think it is a bug that you cannot at least repair the image,
though the cause of corruption is still unknown to me. Do you have
libvirt/QEMU logs from when then VM was shut down, before it wouldn't
boot properly again?

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
