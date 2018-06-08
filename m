Received: from eggs.gnu.org ([2001:4830:134:3::10]:54297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fR92J-0005wP-4e
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 00:30:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fR92G-0001pz-11
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 00:30:03 -0400
Date: Fri, 8 Jun 2018 14:23:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180608042316.GP3344@umbus.fritz.box>
References: <20180607144645.10187-1-f4bug@amsat.org>
	<20180607144645.10187-3-f4bug@amsat.org>
	<20180608030319.GE3344@umbus.fritz.box>
	<83125664-91ec-3274-e6d3-6c5ccfd95297@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9zecZT88ylESpiZX"
Content-Disposition: inline
In-Reply-To: <83125664-91ec-3274-e6d3-6c5ccfd95297@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] hw/ppc/spapr_drc: Replace
 error_setg(&error_abort) by abort()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org


--9zecZT88ylESpiZX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 08, 2018 at 12:54:36AM -0300, Philippe Mathieu-Daud=E9 wrote:
> Hi David,
>=20
> On 06/08/2018 12:03 AM, David Gibson wrote:
> > On Thu, Jun 07, 2018 at 11:46:43AM -0300, Philippe Mathieu-Daud=E9 wrot=
e:
> >> Use abort() instead of error_setg(&error_abort),
> >> as suggested by the "qapi/error.h" documentation:
> >>
> >>     Please don't error_setg(&error_fatal, ...), use error_report() and
> >>     exit(), because that's more obvious.
> >>     Likewise, don't error_setg(&error_abort, ...), use assert().
> >>
> >> Use abort() instead of the suggested assert() because the assertion is
> >> already verified by the switch case.
> >=20
> > I think g_assert_not_reached() would be the right thing here.
>=20
> I try to follow Eric advice (who recalled Markus).
> As I understand:
> http://lists.gnu.org/archive/html/qemu-devel/2017-08/msg03605.html
>=20
> "glib-Testing [...] should not be used outside of tests/."

Oh, ok, go with that then.

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> I can respin if you prefer.



>=20
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> >> ---
> >>  hw/ppc/spapr_drc.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> >> index 8a045d6b93..b934b9c9ed 100644
> >> --- a/hw/ppc/spapr_drc.c
> >> +++ b/hw/ppc/spapr_drc.c
> >> @@ -366,7 +366,7 @@ static void prop_get_fdt(Object *obj, Visitor *v, =
const char *name,
> >>              break;
> >>          }
> >>          default:
> >> -            error_setg(&error_abort, "device FDT in unexpected state:=
 %d", tag);
> >> +            abort(); /* device FDT in unexpected state */
> >>          }
> >>          fdt_offset =3D fdt_offset_next;
> >>      } while (fdt_depth !=3D 0);
> >=20
>=20




--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9zecZT88ylESpiZX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsaBLIACgkQbDjKyiDZ
s5JjuQ/8CNrKeHZ8Sv9Awc9wH+Aal1eHLQal2u47RDAYc2RemIFZTEB6EDEbzwiN
RMkXZkicgzjrhM184LGUUIBeEQXZ/RZmHKsyxWv+VqiLWt4T6iFp5BlfNKGbtA4O
QFJxo6GM53gsutxW2IMhjj7eEMZg5OmCV74zgBK+qvoHsicKbUn0p0x3EAPfDoP3
KzEoPGKbL9/POWf1Uq6bIHx3KHYlsZsIokG3quL+H1ZWxMFy/9T2scqqEp59xqUs
y7fEdzdJn6Xw8atmcfINomePDl4FeXK+aUgftg7Hz8VRILq7R34rrQeHQQB7RgwI
WR8c9TzF/mFr+NBPZzvZF7Oj+LRZAjxH0IJHJQcuQFHnHqUtrVH9QdHNglWAhqrS
1h7JD9KjqF4i1S1UsF7ctISdio7Oldct0msQQOHK7S//rMpBwIAmlOFboKhI0jXd
cR0XVMwxV0yPR3ln2IWGRnPRvZ7/UD443Shh73zHCNs3rqrMHETV5BNB7L2xLREh
YyJ4jkgmaqMgVIAAAjMfGlyQIPRTlZKrzzJJhNdjlsjOVVoQjT1f0loZlmkL/A93
kpxpmtnLhmyWLqnfjmCxf3WOIHCtsX27V4ovM3w2OLQ0EPsVpl0i/25iVfFFK3At
0SDhEq3RL57T0s8k8K2OkX4+OIuEGHNtkBhWc0yQuA5/Nsg7Igs=
=6Jn/
-----END PGP SIGNATURE-----

--9zecZT88ylESpiZX--
