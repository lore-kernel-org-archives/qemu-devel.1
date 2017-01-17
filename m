Received: from eggs.gnu.org ([2001:4830:134:3::10]:59006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTSWr-0006Sx-6U
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:06:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTSWq-0001SW-66
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:06:21 -0500
Received: from indium.canonical.com ([91.189.90.7]:43659)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cTSWq-0001SG-0f
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:06:20 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cTSWp-000268-45
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 12:06:19 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1CFA22E80C1
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 12:06:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Jan 2017 11:53:02 -0000
From: Thomas Huth <678363@bugs.launchpad.net>
Reply-To: Bug 678363 <678363@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20101122014509.824.39732.malonedeb@gandwana.canonical.com>
Message-Id: <20170117115303.14697.54694.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 678363] Re: Swapping caps lock and control causes
 qemu confusion
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
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/678363

Title:
  Swapping caps lock and control causes qemu confusion

Status in QEMU:
  Incomplete

Bug description:
  Running Fedora14 [host], I have caps-lock and control swapped over in
  my keyboard preferences.

  Qemu doesn't cope very well with this; running an OS inside Qemu
  (again fedora, suspect that it doesn't matter):

  The physical caps-lock key [which the host uses as control] toggles
  caps-lock on both press and release.

  The physical control key [which the host uses as caps-lock], acts as
  both a caps-lock and control key.

  Qemu should either respect my keyboard layout or else ignore it
  completely.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/678363/+subscriptions
