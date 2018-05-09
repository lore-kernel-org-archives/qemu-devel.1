Received: from eggs.gnu.org ([2001:4830:134:3::10]:48342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fGMSl-0008Fl-L5
	for qemu-devel@nongnu.org; Wed, 09 May 2018 06:36:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fGMSi-0005by-Ci
	for qemu-devel@nongnu.org; Wed, 09 May 2018 06:36:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:50744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fGMSi-0005ag-7L
	for qemu-devel@nongnu.org; Wed, 09 May 2018 06:36:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fGMSh-0000Hn-23
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 10:36:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0E4CC2E80CB
	for <qemu-devel@nongnu.org>; Wed,  9 May 2018 10:36:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 May 2018 10:17:09 -0000
From: Thomas Huth <1440843@bugs.launchpad.net>
Reply-To: Bug 1440843 <1440843@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150406185912.26127.6004.malonedeb@gac.canonical.com>
Message-Id: <152586102975.6935.16592237805259438061.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1440843] Re: Guest WinXP crashes when trying to
 use a USB spectrometer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

"-usbdevice host" and "usb_add host" have been removed with QEMU 2.12,
so marking this bug as Wont-Fix.

** Changed in: qemu
       Status: New =3D> Won't Fix

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1440843

Title:
  Guest WinXP crashes when trying to use a USB spectrometer

Status in QEMU:
  Won't Fix

Bug description:
  I'm using Amadeus spectrometer (OceanOptics USB250) via Windows-based
  software "Quantum". I've tried six ways of attaching it to QEMU:

  1. command line parameter "-device usb-host,hostbus=3D3,hostaddr=3D25"
  2. command line parameter "-device usb-host,vendorid=3D0x2457,productid=
=3D0x1030"
  3. command line parameter "-usbdevice host:2457:1030
  4. command line parameter "-usbdevice host:3.25"
  5. qemu console command "usb_add host:2457:1030"
  5. qemu console command "usb_add host:3.25"

  From these, only "-device ..." options work, i.e. numbers 1 and 2 in
  the list above, and all others lead to IRQL_NOT_LESS_OR_EQUAL BSOD in
  usbuhci.sys when I launch Quantum, which tries to start acquiring
  spectra.

  I've also tried to reproduce the crash with a flash drive, but
  couldn't =E2=80=94 it seems to work reliably in this case.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1440843/+subscriptions
