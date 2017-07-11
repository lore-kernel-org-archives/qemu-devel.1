Received: from eggs.gnu.org ([2001:4830:134:3::10]:36119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dV1Zc-0005Be-AA
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:15:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dV1Zb-0004wo-07
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:15:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:52085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dV1Za-0004wO-QP
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:15:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dV1ZY-0001Xs-U8
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 20:15:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DFBDA2E8193
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 20:15:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Jul 2017 19:56:56 -0000
From: Thomas Huth <1093360@bugs.launchpad.net>
Reply-To: Bug 1093360 <1093360@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121223234026.15429.45355.malonedeb@wampee.canonical.com>
Message-Id: <149980301683.15210.6452842359132731083.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1093360] Re: files on microsoft iso images
 mounted to qemu VM get stripped from Version info. E.G. Microsoft UAG
 installation fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Can you still reproduce this problem wit the latest release of QEMU
(currently version 2.9.0), or could we close this bug nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1093360

Title:
  files on microsoft iso images mounted to qemu VM  get stripped  from
  Version info. E.G. Microsoft UAG installation fails

Status in QEMU:
  Incomplete

Bug description:
  QEMU 0.9.0-0.14.1
  KVM 60-88-0.14.1
  there is a reference for a root cause, why installation of Microsoft UAG =
fails.
  http://blogs.technet.com/b/isablog/archive/2010/07/13/another-tmg-2010-in=
stallation-failure-with-error-0x80070643.aspx

  when checking available information on the mounted UAG ISO in my qemu mac=
hine, I realized simliar reduced information.
  this was found:
  using AQEMU 0.8.2 of 2011.07.27

  using QEMU 0.9.0-0.14.1 and KVM 60-88-0.14.1
  in an KVM managed  machine

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1093360/+subscriptions
