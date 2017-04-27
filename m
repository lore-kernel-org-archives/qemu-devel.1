Received: from eggs.gnu.org ([2001:4830:134:3::10]:43621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d3lpJ-0004fW-Iw
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 11:59:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d3lpG-0000fW-Bi
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 11:59:29 -0400
Received: from indium.canonical.com ([91.189.90.7]:33363)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d3lpG-0000fI-6S
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 11:59:26 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d3lpF-0000BS-1b
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 15:59:25 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EBB7F2E80C1
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 15:59:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Apr 2017 15:47:26 -0000
From: Daniel Berrange <1064631@bugs.launchpad.net>
Reply-To: Bug 1064631 <1064631@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121009195133.2476.13072.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170427154726.2693.12828.malone@soybean.canonical.com>
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

This support was introduced in QEMU 2.6 last year. Some info here:

https://www.berrange.com/posts/2016/08/16/improving-qemu-security-part-6
-tls-support-for-character-devices/

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1064631

Title:
  Feature request: tls for chardev socket (telnet,tcp,udp)

Status in QEMU:
  Fix Released

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
