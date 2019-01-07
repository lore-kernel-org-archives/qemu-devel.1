Received: from eggs.gnu.org ([209.51.188.92]:50286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1ggXyE-0004nP-L8
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:41:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1ggXyD-0002Yj-Tb
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:41:46 -0500
Date: Mon, 7 Jan 2019 17:36:06 +0100
From: Christophe Fergeau <cfergeau@redhat.com>
Message-ID: <20190107163606.GL23773@natto.ory.fergeau.eu>
References: <20190102140535.11512-1-cfergeau@redhat.com>
	<20190102180158.GA6015@natto.ory.fergeau.eu>
	<4ff5eb04-e1e0-7126-c08d-58d1f28b4f27@redhat.com>
	<87o98sii5b.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2OzUYMsT4j3Kc+NU"
Content-Disposition: inline
In-Reply-To: <87o98sii5b.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH] json: Fix % handling when not interpolating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org


--2OzUYMsT4j3Kc+NU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2019 at 04:47:44PM +0100, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
> > On 1/2/19 12:01 PM, Christophe Fergeau wrote:
> >> Adding Markus to cc: list, I forgot to do it when sending the patch.
> >
> > Also worth backporting via qemu-stable, now in cc.
> >
> >>=20
> >> Christophe
> >>=20
> >> On Wed, Jan 02, 2019 at 03:05:35PM +0100, Christophe Fergeau wrote:
> >>> commit 8bca4613 added support for %% in json strings when interpolati=
ng,
> >>> but in doing so, this broke handling of % when not interpolating as t=
he
> >>> '%' is skipped in both cases.
> >>> This commit ensures we only try to handle %% when interpolating.
>=20
> Impact?
>=20
> If you're unable to assess, could you give us at least a reproducer?

This all came from https://lists.freedesktop.org/archives/spice-devel/2018-=
December/046644.html
Setting up a VM with libvirt with <graphics type=3D'spice' autoport=3D'yes'=
 passwd=3D'password%'/>
fails to start with:
  qemu-system-x86_64: qobject/json-parser.c:146: parse_string: Assertion `*=
ptr' failed.

If you use 'password%%' as the password instead, when trying to connect
to the VM, you type 'password%' as the password instead of 'password%%'
as configured in the domain XML.

Christophe

--2OzUYMsT4j3Kc+NU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElKn3VmH3emFoZJsjqdjCFCmsbIIFAlwzf/IACgkQqdjCFCms
bIJeqg/+LH0+sOq48+aktiTIrdbA9snnhna9IBCF2XjtaBYaaFgl+Pome/qHmkvL
WRJQt1Mj4SuEo7fhL6KrxGZybh/Kfjv66xm2E/XEg0vnzE+1YKMZlYCSCzXEFuZz
Fgg1NZ8M4lrukpWyjqgSllBufMp6ZWxeS9l68woNxDVq/5nb3Iz3duNSiFbPvBBz
LDLMK7+GE+UT9XvDwgYCxwwpyj+6O8H4GnfPRghER5Abk4cYw5AovvAGfoJxzKp7
z++cxeNctfDiqwo+gCHcuCVIx8UUrZmoCBANKWq0nAY5+DtE3mwy+65xI5DmlPPa
c636sbxW5E4AUkNcofA/nzcRzCxcdMLpWSUj+PRdH/1+03eKmPoLGDgtowdETurY
NMtGwHBsiwRrDqsQHgHp8z0wWwhzxCTlIoAuTsCSJV87nk0HtdWo6z10l6kGYaVt
/pbP3EmrMwxZ9gDrwMJnGZiQgJQi+yHSTwTvlUGgf+Pb7S59oshnn6JSU4g/Bd+P
tTXGKSCpAM9FZhd+G+evC8A0D2eIJoZZZD1JIakS74kDXLGB2QwgrtfwgptPPSAP
BAGuuaYUazDeKO+7N09Ej8qKF9Mn/ZXIBpV3iK8/Q4V30R5Y5Z45C/PjyyT5wfMc
Cs47WWo2Px5fHQCR3anpmX/BiWiYjRyhcZv6kF7KiR7aqhfmMBE=
=EH6D
-----END PGP SIGNATURE-----

--2OzUYMsT4j3Kc+NU--
