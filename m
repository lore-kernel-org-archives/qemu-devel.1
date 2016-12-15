Received: from eggs.gnu.org ([2001:4830:134:3::10]:58913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aderumier@oxygem.tv>) id 1cHPog-0000H9-QZ
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 01:46:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aderumier@oxygem.tv>) id 1cHPoc-0007Ao-VC
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 01:46:58 -0500
Received: from mailpro.odiso.net ([89.248.211.110]:43756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aderumier@oxygem.tv>) id 1cHPoc-0007AU-Oj
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 01:46:54 -0500
Date: Thu, 15 Dec 2016 07:46:32 +0100 (CET)
From: Alexandre DERUMIER <aderumier@odiso.com>
Message-ID: <464605215.4528644.1481784392571.JavaMail.zimbra@oxygem.tv>
In-Reply-To: <32c0e94e-8beb-03f3-2605-46225500e6ad@profihost.ag>
References: <1a3a7aef-55f1-11b6-b33f-621979cbb59f@profihost.ag>
	<1383290552.4515122.1481729638569.JavaMail.zimbra@oxygem.tv>
	<32c0e94e-8beb-03f3-2605-46225500e6ad@profihost.ag>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] any known virtio-net regressions in Qemu 2.7?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Stefan Priebe, Profihost AG" <s.priebe@profihost.ag>
Cc: qemu-devel <qemu-devel@nongnu.org>

does rollbacking the kernel to previous version fix the problem ?

i'm not sure if "perf" could give you some hints
----- Mail original -----
De: "Stefan Priebe, Profihost AG" <s.priebe@profihost.ag>
=C3=80: "aderumier" <aderumier@odiso.com>
Cc: "qemu-devel" <qemu-devel@nongnu.org>
Envoy=C3=A9: Mercredi 14 D=C3=A9cembre 2016 21:36:23
Objet: Re: [Qemu-devel] any known virtio-net regressions in Qemu 2.7?

Am 14.12.2016 um 16:33 schrieb Alexandre DERUMIER:=20
> Hi Stefan,=20
>=20
> do you have upgraded kernel ?=20

Yes sure. But i'm out of ideas how to debug. Sometimes it gives me=20
constant 80MB/s, sometimes 125 and sometimes only 6. While on the host=20
the cards are not busy.=20

Greets,=20
Stefan=20

>=20
> maybe it could be related to vhost-net module too.=20
>=20
>=20
> ----- Mail original -----=20
> De: "Stefan Priebe, Profihost AG" <s.priebe@profihost.ag>=20
> =C3=80: "qemu-devel" <qemu-devel@nongnu.org>=20
> Envoy=C3=A9: Mercredi 14 D=C3=A9cembre 2016 16:04:08=20
> Objet: [Qemu-devel] any known virtio-net regressions in Qemu 2.7?=20
>=20
> Hello,=20
>=20
> after upgrading a cluster OS, Qemu, ... i'm experiencing slow and=20
> volatile network speeds inside my VMs.=20
>=20
> Currently I've no idea what causes this but it's related to the host=20
> upgrades. Before i was running Qemu 2.6.2.=20
>=20
> I'm using virtio for the network cards.=20
>=20
> Greets,=20
> Stefan=20
>=20
