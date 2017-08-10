Received: from eggs.gnu.org ([2001:4830:134:3::10]:33189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfoGF-0002DJ-Qd
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 10:16:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfoGB-0000tq-Ro
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 10:16:31 -0400
References: <1502365466-19432-1-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4ef0d855-504c-e68d-d3a8-5c94e1622fb0@redhat.com>
Date: Thu, 10 Aug 2017 09:16:22 -0500
MIME-Version: 1.0
In-Reply-To: <1502365466-19432-1-git-send-email-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VCLHMp5RLmBaoL3G74fQTDdjXes19SlmA"
Subject: Re: [Qemu-devel] [PATCH] qemu-doc: Fix "-net van" typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-trivial@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VCLHMp5RLmBaoL3G74fQTDdjXes19SlmA
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-trivial@nongnu.org
Message-ID: <4ef0d855-504c-e68d-d3a8-5c94e1622fb0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-doc: Fix "-net van" typo
References: <1502365466-19432-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1502365466-19432-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/10/2017 06:44 AM, Thomas Huth wrote:
> While Andrew S. Tanenbaum has a point by saying "Never underestimate th=
e
> bandwidth of a station wagon full of tapes hurtling down the highway",
> we don't support that way of transportation in QEMU yet, so replace the=

> typo with the correct word "vlan".
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  qemu-doc.texi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

(Kudos for a commit message that is 4 times as long, and definitely
funnier, than the patch itself :)

>=20
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 92d50f1..9811476 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -3243,7 +3243,7 @@ the ``-netdev user,guestfwd=3DARGS'' argument ins=
tead.
> =20
>  @subsection -net vlan (since 2.9.0)
> =20
> -The ``-net van=3DNN'' argument is partially replaced with the
> +The ``-net vlan=3DNN'' argument is partially replaced with the
>  new ``-netdev'' argument. The remaining use cases will no
>  longer be directly supported in QEMU.
> =20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--VCLHMp5RLmBaoL3G74fQTDdjXes19SlmA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmMarYACgkQp6FrSiUn
Q2rXVAf+OrYHpLQnc6H/6xa/7rfwA+W+fwPzf30x9pmGCPCcvmQkbsOhEcpy9J6D
ZUIv2+5lde5plz+180qZJNHzIAHKPsbemIQf9nzHwrqbvektLjmg7Eff8GLZVF+k
XVRXlzPj21pXBXTrI46fWSWn4WLf7jsdUaF346W0zMdja0qIEp19rt3v6KtiorI9
jJfc71+/rbplFOk5OMQ3viJEyrJ2iKOyJmMqTgHPP72r08ymQLC5qywkxaRTWE7d
9iQYbiiIDemgTlSzTNJ0pNe8iQHyeXogA0pGf8hpLQg/IC6/S81I+6DIfPVU2Uvs
CqC47zptyk2j8a9Fg541jUyEPTVXVg==
=tm1u
-----END PGP SIGNATURE-----

--VCLHMp5RLmBaoL3G74fQTDdjXes19SlmA--
