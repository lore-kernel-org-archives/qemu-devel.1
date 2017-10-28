Received: from eggs.gnu.org ([2001:4830:134:3::10]:42761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8RtG-0004fW-Ep
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 10:15:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8RtC-0004p1-5z
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 10:15:10 -0400
Received: from indium.canonical.com ([91.189.90.7]:57856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e8RtB-0004nm-VA
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 10:15:06 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e8RtB-0002eN-6F
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 14:15:05 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 27E1A2E8033
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 14:15:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Oct 2017 14:05:39 -0000
From: Thomas Huth <1247478@bugs.launchpad.net>
Reply-To: Bug 1247478 <1247478@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131102213439.24131.94642.malonedeb@gac.canonical.com>
Message-Id: <150919953974.4992.16292501364010121514.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1247478] Re: usb passthrough mass storage write
 data corruption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays? Did you
report it to the libusb folks?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1247478

Title:
  usb passthrough mass storage write data corruption

Status in QEMU:
  New

Bug description:
  the windows 7 professional guest writes to usb high speed mass storage de=
vices connected via host-libusb
  in bulk packages of either size 20480 or 4096 (as far as the actual file =
data is concerned and
  except for the last packet for odd-sized files). The pattern is:
  3 times bulk out 20480
  1 time bulk out 4096

  and that repeats for files longer than 65536 bytes.

  the file on the usb disk is corrupted and it is always corrupt in the las=
t 4096 bytes of each
  20480 byte sized transfer. that means a file is corrupt at 16384-20480 an=
d 36864-40960 and
  57344-61440.
  and so on. and because the 4096 sized  bulk out is always error free, the=
 next corrupt span is from
  81920-86016.

  the last 4096 bytes of the 20480 sized transfer is always identical to th=
e first 4096 bytes of the same
  transfer.

  to reproduce: run windows7 guest on and pass through usb2.0 disk with hos=
t-libusb. write a large file.
  (possibly check the bulk transfer sizes with usbmon).
  note that attaching usb disks with hw/usb/dev-storage does work just fine.
  cannot reproduce with linux as it always writes just 4096 bytes and write=
s with a linux guest are
  always ok even with usb passthrough.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1247478/+subscriptions
