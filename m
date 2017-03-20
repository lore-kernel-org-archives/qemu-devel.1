Received: from eggs.gnu.org ([2001:4830:134:3::10]:38580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cq3VZ-0000Or-OM
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 16:02:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cq3VY-0004Bd-Q4
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 16:02:25 -0400
References: <1490014548-15083-1-git-send-email-armbru@redhat.com>
	<1490014548-15083-5-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9775458f-7adc-d8d8-4549-0f4f397c025d@redhat.com>
Date: Mon, 20 Mar 2017 15:02:17 -0500
MIME-Version: 1.0
In-Reply-To: <1490014548-15083-5-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KDslotuD6VjbWkjblduEAo2Fufs61aJri"
Subject: Re: [Qemu-devel] [PATCH for-2.9 4/5] keyval: Document issues with
 'any' and alternate types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KDslotuD6VjbWkjblduEAo2Fufs61aJri
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <9775458f-7adc-d8d8-4549-0f4f397c025d@redhat.com>
Subject: Re: [PATCH for-2.9 4/5] keyval: Document issues with 'any' and
 alternate types
References: <1490014548-15083-1-git-send-email-armbru@redhat.com>
 <1490014548-15083-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1490014548-15083-5-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/20/2017 07:55 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  util/keyval.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/util/keyval.c b/util/keyval.c
> index 46cd540..93d5db6 100644
> --- a/util/keyval.c
> +++ b/util/keyval.c
> @@ -61,6 +61,16 @@
>   * "key absent" already means "optional object/array absent", which
>   * isn't the same as "empty object/array present".
>   *
> + * Design flaw: scalar values can only be strings; there is no way to
> + * denote numbers, true, false or null.  The special QObject input
> + * visitor returned by qobject_input_visitor_new_keyval() mostly hides=

> + * this by automatically converting strings to the type the visitor
> + * expects.  Breaks down for alternate types and type 'any', where the=

> + * visitor's expectation isn't clear.  Code visiting such types needs
> + * to do the conversion itself, but only when using this keyval
> + * visitor.  Awkward.  Alternate types without a string member don't
> + * work at all.

We've toyed with the idea of making socket parsing accept an alternate
between string and integer (right now it's string due to named port
support, even though most users end up accessing an integer causing a
lot of in-tree parsing/formatting between integers and strings) - that
will be one case that is particularly impacted by this design flaw, if
we ever go through with that idea.  But enough speculation about the
future - your patch as written is accurate for the present.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--KDslotuD6VjbWkjblduEAo2Fufs61aJri
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0DVJAAoJEKeha0olJ0NqghAH/jO/vsVZ2QaaXSXgjU5uA/dv
WO97nmOH0VEomLwtqxnRXfizr0ZR2CxtgZobIHiNiNPSm6z9hTbMjtABxNQ7BSML
UR/QZTz1IQLoH35ht6EmwOrgb7TsAkOIreTROWsfLyukwPiGhKfdSA3E49z9DotJ
p6IOPBd3+jNtOXVGgEkYp3BA6YGTIvCkwkgX95sOtJBAJ1NGAd1sShs+48j++mm1
OltzE05BvjUFLfMxDtFHDWMUJreUErO88pbrehYf2neKP9hp83OXuEsV00DyvL9S
LbpEbSd+XOoGm1yyjbsmOmFK7LHbeGkfmoEAi3RwLNGSX6VOKo2/aa7HXaaKL50=
=zEZj
-----END PGP SIGNATURE-----

--KDslotuD6VjbWkjblduEAo2Fufs61aJri--
