Received: from eggs.gnu.org ([2001:4830:134:3::10]:34187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cRhYJ-0002o0-5T
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:44:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cRhYE-0005tp-N2
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:44:35 -0500
Content-Type: multipart/signed;
	boundary="Apple-Mail=_65EC4AA3-C441-4C24-AC3A-B37303B275D1";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <e6e26ad1-3fdf-85ac-0dc4-f4027123af6b@redhat.com>
Date: Thu, 12 Jan 2017 15:44:23 +0000
Message-Id: <2EAE3C4F-58AF-4594-A284-A69D8BC3EA8F@alex.org.uk>
References: <CAMxP3BT7ncDLePmP7QfXMtbodJ81+9Frc01aCkipya3-BNL6AA@mail.gmail.com>
	<e6e26ad1-3fdf-85ac-0dc4-f4027123af6b@redhat.com>
Subject: Re: [Qemu-devel] [Nbd] How to online resize qemu disk with nbd
 protocol?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Alex Bligh <alex@alex.org.uk>, Bob Chen <a175818323@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>


--Apple-Mail=_65EC4AA3-C441-4C24-AC3A-B37303B275D1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii


> On 12 Jan 2017, at 14:43, Eric Blake <eblake@redhat.com> wrote:
> 
> That's because the NBD protocol lacks a resize command.  You'd have to
> first get that proposed as an NBD extension before qemu could support it.

Actually the NBD protocol lacks a 'make a disk with size X' command,
let alone a resize command. The size of an NBD disk is (currently)
entirely in the hands of the server. What I think we'd really need
would be a 'reread size' command, and have the server capable of
supporting resizing. That would then work for readonly images too.

--
Alex Bligh





--Apple-Mail=_65EC4AA3-C441-4C24-AC3A-B37303B275D1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJYd6RXAAoJEBPm5K7i9iOR06EP/jMGao6briPN3V0xJ7o92pWG
LOB8m3RasGNc44bdkisCqK4kuJHhRRxcTu+diUuId18bY4KZq05uuOF9eZKIhdzv
KpIi5gFvviNSaEPYBksAoHMWxeh2Hc1Lysmdf16KzW84OFiuND59ZbpiqBbSHOSl
kkmoZp7a0IUEw24NiPjNpMK0DIGnKOXhVB/0xdMe+t/MeBrW7cQmraSjqDuCeDoV
bURoktVJgl/n5lZdt/tYEBkOBHrQs3Nxb3RA/AXcK+RqzJWxJCF1qbxeHG1D4fj/
vY7KG/8Ehy1bXdXoldDdL+q0z32m0sxpjJuLVRUAmZILTqWn66zS5OPjJkl3EW2A
rz4RHPfHYq2A2IAqS9pRPUr5aRLlnWjC8cYOULH8xTLOsV8dsgR++QCLo5f9oLI5
B26XanfaMJILGK57jhB/9Pt/tKfTw9qH+l8Zi9OoqxLGnjVhAGQk+E3IMQEYRZ/g
xjwwSAwMnOOXJaQZqKXt18RE+2TDs0MOWOwg48teTDn3XkKTY14rASZJS5bw0pcH
9IUkk37Z4BsFrGxWcwP7bncSsCZx3EdNrwnyodft4iVC17QGdk8ihXVeJ2guzebQ
1VoDJWd/MyeBAscCxRn6LCFaLdBM3QyC8YMGqZjrFH1Yf3JnjiEoWx8/Uu3uqSde
r/onQ11QipqDwCyP53HH
=Rk+t
-----END PGP SIGNATURE-----

--Apple-Mail=_65EC4AA3-C441-4C24-AC3A-B37303B275D1--
