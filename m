Received: from eggs.gnu.org ([208.118.235.92]:46488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cZFXK-0004VA-JY
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 06:26:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cZFNs-0003Mk-5h
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 06:17:05 -0500
Received: from indium.canonical.com ([91.189.90.7]:52266)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cZFNs-0003MH-0W
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 06:17:00 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cZFNq-0000Du-S5
	for <qemu-devel@nongnu.org>; Thu, 02 Feb 2017 11:16:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0E7062E81A2
	for <qemu-devel@nongnu.org>; Thu,  2 Feb 2017 11:16:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Feb 2017 11:00:48 -0000
From: Thomas Huth <740895@bugs.launchpad.net>
Reply-To: Bug 740895 <740895@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110323111128.18758.37780.malonedeb@wampee.canonical.com>
Message-Id: <20170202110048.8677.70104.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 740895] Re: qemu freeze when loading msdos with
 EMM386.EXE NOEMS HIGHSCAN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets ... QEMU 0.11 and 0.14 are pretty much outdated
nowadays... can you still reproduce this problem with the latest version
of QEMU?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/740895

Title:
  qemu freeze when loading msdos with EMM386.EXE NOEMS HIGHSCAN

Status in QEMU:
  Incomplete

Bug description:
  Qemu version used : 0.11.2 and 0.14.0
  Guest : Ms-Dos 6.2
  Host : Ubuntu 10.04 with 2.6.32-29-generic SMP i686
  Starting Qemu with command : qemu -hda dos.img -cpu 486 -m 16

  When I start msDos under Qemu with the option (in CONFIG.SYS) =

  DEVICE=3DC:\DOS\EMM386.EXE NOEMS HIGHSCAN
  the guest freeze.
  If I remove "HIGHSCAN" system is booting (but my software is not working).

  The whole thing is working on a real computer with a 486 with 16Mb ram
  or a PII.

  "HIGHSCAN switch allows EMM386.EXE to map expanded memory pages or
  upper memory blocks (UMBs) over portions of the upper memory area
  (UMA) used by system read-only memory " from
  http://support.microsoft.com/kb/96522/en-us

  I add some traces inside "default_ioport_read" in ioport.c, but I
  don't see any access to F000h-F7FFh like said in ms help.

  Before the system hung, there is access to dma1, dma page register and
  dma2 :

  inb : 0087 00
  outb: 000c 00
  inb : 0000 00
  inb : 0000 00
  inb : 0001 00
  inb : 0001 00
  inb : 0083 00
  outb: 000c 00
  inb : 0002 00
  inb : 0002 00
  inb : 0003 00
  inb : 0003 00
  inb : 0081 00
  outb: 000c 00
  inb : 0004 00
  inb : 0004 00
  inb : 0005 00
  inb : 0005 00
  inb : 0082 00
  outb: 000c 00
  inb : 0006 00
  inb : 0006 00
  inb : 0007 00
  inb : 0007 00
  inb : 008b 00
  outb: 00d8 00
  inb : 00c4 00
  inb : 00c4 00
  inb : 00c6 00
  inb : 00c6 00
  inb : 0089 00
  outb: 00d8 00
  inb : 00c8 00
  inb : 00c8 00
  inb : 00ca 00
  inb : 00ca 00
  inb : 008a 00
  outb: 00d8 00
  inb : 00cc 00
  inb : 00cc 00
  inb : 00ce 00
  inb : 00ce 00
  outb: 000c 00
  outb: 00d8 00

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/740895/+subscriptions
