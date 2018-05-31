Received: from eggs.gnu.org ([2001:4830:134:3::10]:58436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fOT3J-0001wq-9m
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:16:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fOT3G-0003D4-4W
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:16:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:40324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fOT3F-0003CB-UC
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:15:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fOT3D-0006iJ-88
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 19:15:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2FD782E88D8
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 19:15:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 31 May 2018 19:02:54 -0000
From: John Snow <1769189@bugs.launchpad.net>
Reply-To: Bug 1769189 <1769189@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152544791493.32626.6219738999075353422.malonedeb@gac.canonical.com>
Message-Id: <152779337592.31371.8030462266578334137.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1769189] Re: Issue with qemu 2.12.0 + SATA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: New =3D> Confirmed

** Changed in: qemu
     Assignee: (unassigned) =3D> John Snow (jnsnow)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1769189

Title:
  Issue with qemu 2.12.0 + SATA

Status in QEMU:
  Confirmed

Bug description:
  [EDIT: I first thought that OVMF was the issue, but it turns out to be
  SATA]

  I had a Windows 10 VM running perfectly fine with a SATA drive, since
  I upgraded to qemu 2.12, the guests hangs for a couple of minutes,
  works for a few seconds, and hangs again, etc. By "hang" I mean it
  doesn't freeze, but it looks like it's waiting on IO or something, I
  can move the mouse but everything needing disk access is unresponsive.

  What doesn't work: qemu 2.12 with SATA
  What works: using VirIO-SCSI with qemu 2.12 or downgrading qemu to 2.11.1=
 and keep using SATA.

  Platform is arch linux 4.16.7 on skylake and Haswell, I have attached
  the vm xml file.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1769189/+subscriptions
