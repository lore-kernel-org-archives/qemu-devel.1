Received: from eggs.gnu.org ([208.118.235.92]:53988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehdob-0003bF-JC
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:03:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehdoX-0006pF-8Z
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:03:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ehdoX-0006ox-1s
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:03:45 -0500
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-5-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <27d72a71-6494-885f-fa62-233bea7d5923@redhat.com>
Date: Fri, 2 Feb 2018 10:03:38 -0600
MIME-Version: 1.0
In-Reply-To: <20180202130336.24719-5-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FVQ3aEhN864X25MGhvLH3F3cbj65r10dI"
Subject: Re: [Qemu-devel] [PATCH RFC 04/21] qapi: Reduce use of global
 variables in generators some
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FVQ3aEhN864X25MGhvLH3F3cbj65r10dI
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <27d72a71-6494-885f-fa62-233bea7d5923@redhat.com>
Subject: Re: [PATCH RFC 04/21] qapi: Reduce use of global variables in
 generators some
References: <20180202130336.24719-1-armbru@redhat.com>
 <20180202130336.24719-5-armbru@redhat.com>
In-Reply-To: <20180202130336.24719-5-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/02/2018 07:03 AM, Markus Armbruster wrote:
> In preparation of the next commit, which will turn the generators into
> modules.  These global variables will become local to main() then.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--FVQ3aEhN864X25MGhvLH3F3cbj65r10dI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlp0i9oACgkQp6FrSiUn
Q2pveggAoZoxth+b21/B16M5ObdE6icZXKjwh6OjS7uU6w4/4Hgifx/gCXfdd4Jh
vxarhL3qqoKEJ/XABxYcOwj+aQ6gZnWAX4RXVNqArbqTdbpL5vI7xQM+3XYwbwYd
hGRfDnxRmXJ9VQLVo4ihVb1YFsP13G+AMXPB++KN+ToVvabeGl8Koycef8uZXr6U
/fGSU0SmpYLvUMbxKe5m8bwSHTpLMPHifX+4P3l716S2JsJsVi+dPw34+0Tn49EL
R8Lp1aL0ZAMD4UjHMcc+Juf7tWbIG+tJruIl2qXf1GwuLS8nhgRHr2mO1Qs5G9xR
4ifAe+g4TTZxlU8VEplk3NRC45pJkg==
=/rCY
-----END PGP SIGNATURE-----

--FVQ3aEhN864X25MGhvLH3F3cbj65r10dI--
