Received: from eggs.gnu.org ([2001:4830:134:3::10]:60603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cQ9KU-0002Rg-Lb
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 03:59:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cQ9KO-0005Jf-4r
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 03:59:54 -0500
Received: from indium.canonical.com ([91.189.90.7]:60851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cQ9KN-0005IM-UG
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 03:59:48 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cQ9KM-0003kN-LQ
	for <qemu-devel@nongnu.org>; Sun, 08 Jan 2017 08:59:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 971A22E80AF
	for <qemu-devel@nongnu.org>; Sun,  8 Jan 2017 08:59:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Jan 2017 08:50:09 -0000
From: Thomas Huth <864490@bugs.launchpad.net>
Reply-To: Bug 864490 <864490@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20111002073554.24942.56669.malonedeb@soybean.canonical.com>
Message-Id: <20170108085009.13899.10035.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 864490] Re: Windows 2008 x64 (SBS Server) freezes
 randomly when using more than 1 CPU core
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Since nobody replied here within the last years: I think you should
rather report problems with XEN / Proxmox to the XEN or Proxmox
bugtracker instead.

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/864490

Title:
  Windows 2008 x64 (SBS Server) freezes randomly when using more than 1
  CPU core

Status in QEMU:
  Invalid

Bug description:
  This issue has been giving headache to us since a long time.
  Difficult to reproduce as it happens randomly.
  We had this issue when we ran Windows 2008 x64 or Windows SBS Server gues=
ts in either XEN 3.3 or Proxmox environments.
  When only one CPU core is assigned to the guest, everything is fine. If 2=
 or more cores are assigned, the guest stops responding after several hours=
 - and in the host machine one of the cores is using 100%. The only thing t=
hat helps is resetting the guest.

  I am ready to provide logs/crashdumps if needed, because we want to
  help resolve this issue. I saw some posts on the web of people having
  the same problems - for some of the workaround was to fix some BIOS
  settings, but we did not have success with those (e.g. disabling C1E
  Support and Intel C-State )

  Server is running on Intel=C2=AE Core=E2=84=A2 i7-920 Quad-Core, 24 Gig R=
AM.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/864490/+subscriptions
