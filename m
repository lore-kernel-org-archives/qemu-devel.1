Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353A5C352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 18:41:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F379524685
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 18:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F379524685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1wxI-0000Bh-59
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 13:41:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j1wwY-00085b-7J
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 13:41:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j1wwW-0002IJ-QD
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 13:41:02 -0500
Received: from indium.canonical.com ([91.189.90.7]:33032)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j1wwW-0002Ha-Kx
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 13:41:00 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j1wwU-0006eZ-LT
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 18:40:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id A16ED2E8078
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 18:40:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Feb 2020 18:32:36 -0000
From: Laurent Vivier <Laurent@vivier.eu>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: crockabiscuit laurent-vivier
X-Launchpad-Bug-Reporter: crocket (crockabiscuit)
X-Launchpad-Bug-Modifier: Laurent Vivier (laurent-vivier)
References: <157762661516.5433.16221584605990009162.malonedeb@gac.canonical.com>
Message-Id: <158153235677.30339.4267565117271209834.malone@wampee.canonical.com>
Subject: [Bug 1857811] Re: qemu user static binary seems to lack support for
 network namespace.
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="19413b719a8df7423ab1390528edadce9e0e4aca";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: de8d194fef3da094d4aa7e6654d51c00eec121af
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1857811 <1857811@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I've copied the file portage-2.3.84/build/lib.linux-
x86_64-3.7/portage/util/netlink.py from portage to my local directory
and run the following script:

cat > rtnetlink.py <<EOF
import socket

__has_ipv6 =3D None

def _has_ipv6():
        """
        Test that both userland and kernel support IPv6, by attempting
        to create a socket and listen on any unused port of the IPv6
        ::1 loopback address.

        @rtype: bool
        @return: True if IPv6 is supported, False otherwise.
        """
        global __has_ipv6

        if __has_ipv6 is None:
                if socket.has_ipv6:
                        sock =3D None
                        try:
                                # With ipv6.disable=3D0 and ipv6.disable_ip=
v6=3D1, socket creation
                                # succeeds, but then the bind call fails wi=
th this error:
                                # [Errno 99] Cannot assign requested addres=
s.
                                sock =3D socket.socket(socket.AF_INET6, soc=
ket.SOCK_DGRAM)
                                sock.bind(('::1', 0))
                        except EnvironmentError:
                                __has_ipv6 =3D False
                        else:
                                __has_ipv6 =3D True
                        finally:
                                # python2.7 sockets do not support context =
management protocol
                                if sock is not None:
                                        sock.close()
                else:
                        __has_ipv6 =3D False

        return __has_ipv6

def _configure_loopback_interface():
        """
        Configure the loopback interface.
        """

        from netlink import RtNetlink
        try:
                with RtNetlink() as rtnl:
                        ifindex =3D rtnl.get_link_ifindex(b'lo')
                        rtnl.set_link_up(ifindex)
                        rtnl.add_address(ifindex, socket.AF_INET, '10.0.0.1=
', 8)
                        if _has_ipv6():
                                rtnl.add_address(ifindex, socket.AF_INET6, =
'fd::1', 8)
        except EnvironmentError as e:
                print("Unable to configure loopback interface: %s\n" % e.st=
rerror)

_configure_loopback_interface()
EOF

And I have no error in an aarch64/ubunut eoan chroot.

sudo QEMU_STRACE=3D unshare --net chroot chroot/arm64/eoan python3 rtnetlin=
k.py
...
675051 socket(PF_NETLINK,,NETLINK_ROUTE) =3D 3
675051 bind(3,{nl_family=3DAF_NETLINK,nl_pid=3D0,nl_groups=3D0}, 12) =3D 0
675051 sendto(3,274891222784,38,0,274886293096,12) =3D 38
...

sudo strace -yyy unshare --net chroot chroot/arm64/eoan python3
rtnetlink.py

..
socket(AF_NETLINK, SOCK_DGRAM|SOCK_CLOEXEC, NETLINK_ROUTE) =3D 3<NETLINK:[2=
6260481]>
bind(3<NETLINK:[26260481]>, {sa_family=3DAF_NETLINK, nl_pid=3D0, nl_groups=
=3D00000000}, 12) =3D 0
sendto(3<NETLINK:[26260481]>, {{len=3D38, type=3D0x12 /* NLMSG_??? */, flag=
s=3DNLM_F_REQUEST, seq=3D1, pid=3D0}, "\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00\x00\x00\x00\x00\x00\x00\x06\x00\x03\x00\x6c\x6f"}, 38, 0, {sa_family=
=3DAF_NETLINK, nl_pid=3D0, nl_groups=3D00000000}, 12) =3D 38
...

So I need to know which version you are using (qemu, kernel host).

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1857811

Title:
  qemu user static binary seems to lack support for network namespace.

Status in QEMU:
  New

Bug description:
  Whenever I execute emerge in gentoo linux in qemu-aarch64 chroot, I
  see the following error message.

  Unable to configure loopback interface: Operation not supported

  If I disable emerge's network-sandbox which utilizes network
  namespace, the error disappears.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1857811/+subscriptions

