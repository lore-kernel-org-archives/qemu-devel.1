Received: from eggs.gnu.org ([2001:4830:134:3::10]:33301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gA9Gu-0001oZ-5k
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 03:51:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gA9Gq-0002Xr-Vp
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 03:51:08 -0400
Received: from indium.canonical.com ([91.189.90.7]:39590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gA9Gq-0002XI-P9
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 03:51:04 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gA9Gn-0008WS-2B
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 07:51:01 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 501F02E819F
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 07:50:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Oct 2018 07:44:35 -0000
From: Chris Ward <1796816@bugs.launchpad.net>
Reply-To: Bug 1796816 <1796816@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153907284198.23615.17821186357944149368.malonedeb@chaenomeles.canonical.com>
Message-Id: <153915747529.3860.1705321803580035071.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1796816] Re: Wrong keyboard in QEMU Windows for
 OpenSUSE PowerPC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I have configured a matching PowerPC virtual machine under an OpenSUSE
Tumbleweed x86_64 host with qemu-ppc64 for that platform, and the
keyboard mapping is correct for all keys. So the bug I have come across
is presumably a bug with the WIndows port of QEMU.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1796816

Title:
  Wrong keyboard in QEMU Windows for OpenSUSE PowerPC

Status in QEMU:
  New

Bug description:
  I am trying to run an OpenSUSE PowerPC Little Endian system under Microso=
ft Windows. I have an English UK keyboard. The keyboard is basically correc=
t (I get a 'pound' sign when I press shift-3) but some of the keys are rend=
ered incorrectly. The wrong keys are
  \ renders as # (just right of left hand shift key)
  | renders as ~ (shift-\)
  ' renders as ` (2 keys right of l)
  @ renders as =C2=AC (shift-')
  # renders as ' (3 keys right of l)
  ~ renders as @ (shift-#)

  QEMU command line was
  >"\Program Files\qemu\qemu-system-ppc64.exe" -hda opensuse.qcow2

  OpenSUSE was installed from
  download.opensuse.org/ports/ppc/tumbleweed/iso/openSUSE-Tumbleweed-
  DVD-ppc64le-Current.iso .

  I am running OpenSUSE in runlevel 3 (no X11).

  I don't really know whether the problem is with QEMU, the Windows port
  of QEMU, or with OpenSUSE Tumbleweed.

  This is with QEMU for Windows 3.0.0 from https://qemu.weilnetz.de/w64/

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1796816/+subscriptions
