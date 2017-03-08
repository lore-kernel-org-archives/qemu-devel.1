Received: from eggs.gnu.org ([2001:4830:134:3::10]:57683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1clgGW-0005ZS-V7
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 13:24:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1clgGT-0005Ni-QW
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 13:24:48 -0500
Received: from indium.canonical.com ([91.189.90.7]:52573)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1clgGT-0005NI-KF
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 13:24:45 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1clgGS-0006C5-4a
	for <qemu-devel@nongnu.org>; Wed, 08 Mar 2017 18:24:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 16A162E8029
	for <qemu-devel@nongnu.org>; Wed,  8 Mar 2017 18:24:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Mar 2017 18:13:01 -0000
From: Colin Burgess <colin.burgess@gmail.com>
Reply-To: Bug 1274170 <1274170@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140129161114.30551.55586.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170308181301.23223.61605.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1274170] Re: qemu window hides in the background
 on osx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This seems to only affect fullscreen mode, so if that's the case, I
don't see it as resolved.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1274170

Title:
  qemu window hides in the background on osx

Status in QEMU:
  Incomplete

Bug description:
  When launching qemu on OSX (10.8.5), the window comes up in the
  background.  A bit of googling shows that the addition of [NSApp
  activateIgnoringOtherApps:YES]; before the [NSApp run]; in main fixes
  this.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1274170/+subscriptions
