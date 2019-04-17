Received: from eggs.gnu.org ([209.51.188.92]:36059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1hGoNr-0008Jn-0T
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:30:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1hGoNp-0005L5-Vs
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:30:06 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:42110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1hGoNp-0005KQ-M1
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:30:05 -0400
Received: by mail-oi1-x235.google.com with SMTP id w139so20662190oie.9
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 10:30:05 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <155552219818.15309.1691620619742559575@sif>
Date: Wed, 17 Apr 2019 12:29:58 -0500
Subject: [Qemu-devel] [ANNOUNCE] QEMU 4.0.0-rc4 is now available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
fifth release candidate for the QEMU 4.0 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-4.0.0-rc4.tar.xz
  http://download.qemu-project.org/qemu-4.0.0-rc4.tar.xz.sig

A note from the maintainer:

  rc4 has a small set of bugfixes for a few late-breaking
  release blockers; the final release is planned for
  Tuesday 23rd.

You can help improve the quality of the QEMU 4.0 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/4.0

Please add entries to the ChangeLog for the 4.0 release below:

  http://wiki.qemu.org/ChangeLog/4.0

Thank you to everyone involved!

Changes since rc3:

eeba63fc7f: Update version for v4.0.0-rc4 release (Peter Maydell)
375cb86d9f: usb-mtp: fix bounds check for guest provided filename (Daniel P=
. Berrang=C3=A9)
93e32b3e20: qcow2: Fix preallocation bdrv_pwrite to wrong file (Kevin Wolf)
a9b305ba29: socket: allow wait=3Dfalse for client socket (Marc-Andr=C3=A9 L=
ureau)
6fabae61a9: slirp: Gcc 9 -O3 fix (Dr. David Alan Gilbert)
9749636b00: iotest: Fix 241 to run in generic directory (Eric Blake)
23e1d05411: iotests: Let 245 pass on tmpfs (Max Reitz)
13c24edaa7: qemu-img: fix .hx and .texi disparity (John Snow)
e1be98540e: curses: fix wchar_t printf warning (Gerd Hoffmann)
4560116e42: spapr_pci: Fix broken naming of PCI bus (Greg Kurz)
