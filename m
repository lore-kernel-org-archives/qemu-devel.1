Received: from eggs.gnu.org ([2001:4830:134:3::10]:39622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f615Z-0004fS-NX
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 17:46:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f615V-0004cQ-No
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 17:46:05 -0400
Received: from indium.canonical.com ([91.189.90.7]:45318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f615V-0004c1-IS
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 17:46:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f615U-0002mM-B9
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 21:46:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4C6622E80CB
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 21:46:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Apr 2018 21:34:12 -0000
From: Thomas Huth <1192065@bugs.launchpad.net>
Reply-To: Bug 1192065 <1192065@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130618075717.15131.49330.malonedeb@chaenomeles.canonical.com>
Message-Id: <152339605260.13883.1340266997085950319.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1192065] Re: qemu release memory to system
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Looking through old bug tickets... I think you should rather use
hotpluggable memory here for the guests instead - or use a big swap
partition on the host. Anyway, this is not a bug, so closing this ticket
now.

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1192065

Title:
  qemu release memory to system

Status in QEMU:
  Invalid

Bug description:
  Qemu pre-allocates the maximum balloon amount which is inconvinient if
  all of the memory is used up and some other system needs to be added
  memory resource

  eg:- I have 4GB RAM with 4 virtual systems to be run.
  I want each of them to start with 1GB RAM with maximum 2GB possible. This=
 is not achievable since qemu pre-allocates the maximum balloon amount whic=
h is 2GBx4 systems . So to start all 4 systems the system needs 8GB RAM rat=
her than 4GB RAM to start with although I have told initial balloon amount =
to be 1GB.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1192065/+subscriptions
