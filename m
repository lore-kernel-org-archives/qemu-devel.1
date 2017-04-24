Received: from eggs.gnu.org ([2001:4830:134:3::10]:33726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d2YvG-0005bb-Hh
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 04:00:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d2Yv6-0006vR-ON
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 04:00:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1d2Yv6-0006uO-ID
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 04:00:28 -0400
References: <VI1PR0601MB2479AC08F717F15FCE287FC99C020@VI1PR0601MB2479.eurprd06.prod.outlook.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2ea59451-5508-8c80-16c9-66eeeb0cfe1c@redhat.com>
Date: Mon, 24 Apr 2017 10:00:22 +0200
MIME-Version: 1.0
In-Reply-To: <VI1PR0601MB2479AC08F717F15FCE287FC99C020@VI1PR0601MB2479.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] dns server not working in QEMU using usermode
 networking (SLIRP)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: FONNEMANN Mark <mark.fonnemann@hexagon.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>

On 13.04.2017 22:17, FONNEMANN Mark wrote:
> Hello-
>=20
> I posted this question on stack overflow and got no response. Stefan re=
commended asking the question here.
>=20
> I=E2=80=99ve included a summary of the problem here in this email but m=
ore details can be found here:
>=20
> http://stackoverflow.com/questions/43308310/dns-server-not-working-in-q=
emu-usermode-networking?noredirect=3D1#comment73706410_43308310
>=20
> Basically, I can access the internet using static IP addresses but name=
server resolution is not working. I can ping the router 10.0.2.2 address =
and my 10.0.2.15 address but not the 10.0.2.3 address of the DNS server o=
r the 10.0.2.4 of the SMB server both of which I need for my project.
>=20
> Any suggestions?
>=20
> p.s. I tried 2.9rc3 and it failed as well.

IIRC there have been some DNS related fixes shortly before the final 2.9
release ... so does it work if you use the final 2.9.0 version instead?

 Thomas
