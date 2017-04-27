Received: from eggs.gnu.org ([2001:4830:134:3::10]:37995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d3lVr-0005LJ-4G
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 11:39:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d3lVn-0000RE-3S
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 11:39:23 -0400
Received: from indium.canonical.com ([91.189.90.7]:58269)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d3lVm-0000Qk-Uu
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 11:39:19 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d3lVk-00076u-Mv
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 15:39:16 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id ABC972E80C3
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 15:39:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Apr 2017 15:29:28 -0000
From: Thomas Huth <1064631@bugs.launchpad.net>
Reply-To: Bug 1064631 <1064631@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121009195133.2476.13072.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170427152929.3242.39867.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1064631] Re: Feature request: tls for chardev
 socket (telnet, tcp, udp)
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
   Importance: Undecided =3D> Wishlist

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1064631

Title:
  Feature request: tls for chardev socket (telnet,tcp,udp)

Status in QEMU:
  New

Bug description:
  Hello,

  it would be nice if chardev socket (telnet,tcp,udp) could have tls
  support as vnc does.

  This way we could have encrypted access to virtual character devices over=
 network,
  for example in setup: conserver -> socat+tls <-> qemu+chardev+tls.

  The best would be both direction - server even client, so even the client=
 should
  trust remote server (trustfile, fingeprint...?).

  Thank you.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1064631/+subscriptions
