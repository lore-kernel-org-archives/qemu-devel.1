Received: from eggs.gnu.org ([2001:4830:134:3::10]:43166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfooV-0002E0-EM
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 10:51:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfooQ-0002ja-VL
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 10:51:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dfooQ-0002hZ-MR
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 10:51:50 -0400
References: <1502367921-17730-1-git-send-email-armbru@redhat.com>
	<1502367921-17730-2-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1837a5c7-92a2-a40a-5f96-21bd448790bd@redhat.com>
Date: Thu, 10 Aug 2017 09:43:46 -0500
MIME-Version: 1.0
In-Reply-To: <1502367921-17730-2-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9UO1CSAXa7TqSInSJmlsksniRLIvw6JC7"
Subject: Re: [Qemu-devel] [PATCH 1/2] vl: Factor object_create() out of
 main()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: el13635@mail.ntua.gr, kwolf@redhat.com, berrange@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9UO1CSAXa7TqSInSJmlsksniRLIvw6JC7
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: el13635@mail.ntua.gr, kwolf@redhat.com, berrange@redhat.com,
 pbonzini@redhat.com
Message-ID: <1837a5c7-92a2-a40a-5f96-21bd448790bd@redhat.com>
Subject: Re: [PATCH 1/2] vl: Factor object_create() out of main()
References: <1502367921-17730-1-git-send-email-armbru@redhat.com>
 <1502367921-17730-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1502367921-17730-2-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/10/2017 07:25 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  vl.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>=20

> +++ b/vl.c
> @@ -2845,7 +2845,6 @@ static bool object_create_initial(const char *typ=
e)
>      return true;
>  }
> =20
> -
>  /*

Spurious whitespace change? I can live with it because it adds
consistency, but it's not on a function directly touched by this patch.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--9UO1CSAXa7TqSInSJmlsksniRLIvw6JC7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmMcSIACgkQp6FrSiUn
Q2ptjQgAoGOjSUJ83LZ2bHyrmV2UhfyZwt6khc78OSTFGPYJWp+6COGAnvyG+BkM
zRIjtKOwE3Lo/Uexyb5cFQxj+zNAVwVvNtxSsKiFazp429/rIN3SImamVxzaGrG5
7Rl4WTv2UhiuBFfT4TnaliUh2C5JQGTK1FLXCv6XxfGpkXLOOb+epjsZxeQxn3l+
3GrvsQ53jkKp2o54wPVb/F2BtUpRHc1FQIwOFnALc2AzzrF8D6mQM1cyPDi9LmRG
A2pgxhLSaofmL0tBjDKkDc/GHfbojUW0a93SCSfgg/+LQortSC5vKbFPHsXLD7nz
5YNJ5KzhT7fN+ow8/XngI4HGRK1N3Q==
=O4jW
-----END PGP SIGNATURE-----

--9UO1CSAXa7TqSInSJmlsksniRLIvw6JC7--
