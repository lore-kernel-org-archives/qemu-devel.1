Received: from eggs.gnu.org ([2001:4830:134:3::10]:34147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC9CB-00017U-SW
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 14:06:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC9CA-0007iR-Tv
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 14:05:59 -0500
Received: from indium.canonical.com ([91.189.90.7]:41642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eC9CA-0007iF-Nh
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 14:05:58 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eC9C9-0000L0-ML
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 19:05:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A102B2E80CB
	for <qemu-devel@nongnu.org>; Tue,  7 Nov 2017 19:05:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Nov 2017 18:48:12 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1163034 <1163034@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130401223319.8572.52647.malonedeb@gac.canonical.com>
Message-Id: <151008049370.9208.7918481148946593107.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1163034] Re: linux-user mode can't handle guest
 setting a very small RLIMIT_AS (hangs running gnutls28,
 coreutils configure check code)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Summary changed:

- linux-user mode can't handle guest setting RLIMIT_AS (hangs running gnutl=
s28 configure check code)
+ linux-user mode can't handle guest setting a very small RLIMIT_AS (hangs =
running gnutls28, coreutils configure check code)

** Tags added: linux-user

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1163034

Title:
  linux-user mode can't handle guest setting a very small RLIMIT_AS
  (hangs running gnutls28, coreutils configure check code)

Status in QEMU:
  Confirmed
Status in qemu package in Ubuntu:
  Confirmed

Bug description:
  Please look at
  https://code.launchpad.net/~costamagnagianfranco/+archive/costamagnagianf=
ranco-ppa/+packages
  and
  https://code.launchpad.net/~costamagnagianfranco/+archive/costamagnagianf=
ranco-ppa/+build/4457434

  I cannot make gnutls28 build on armhf, I suspect a builder problem

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1163034/+subscriptions
