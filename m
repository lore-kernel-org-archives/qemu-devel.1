Received: from eggs.gnu.org ([2001:4830:134:3::10]:58864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e08BM-0007Ch-Cy
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:35:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e08BJ-0002cA-KY
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:35:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e08BJ-0002bP-4G
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:35:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 291D980472
	for <qemu-devel@nongnu.org>; Thu,  5 Oct 2017 15:35:24 +0000 (UTC)
References: <20171005152856.6166-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b53182c3-93fb-933a-38ef-c04dbbf88422@redhat.com>
Date: Thu, 5 Oct 2017 10:35:17 -0500
MIME-Version: 1.0
In-Reply-To: <20171005152856.6166-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Pq9C0u3UMBpKwV075nW0qAKUP8BnDuopG"
Subject: Re: [Qemu-devel] [PATCH] char: don't skip client cleanup if
 'connected' flag is unset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Pq9C0u3UMBpKwV075nW0qAKUP8BnDuopG
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Message-ID: <b53182c3-93fb-933a-38ef-c04dbbf88422@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] char: don't skip client cleanup if
 'connected' flag is unset
References: <20171005152856.6166-1-berrange@redhat.com>
In-Reply-To: <20171005152856.6166-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/05/2017 10:28 AM, Daniel P. Berrange wrote:
> The tcp_chr_free_connection & tcp_chr_disconnect methods both
> skip all of their cleanup work unless the 's->connected' flag
> is set.  This flag is set when the incoming client connection
> is ready to use. Crucially this is *after* the TLS handshake
> has been completed. So if the TLS handshake fails and we try
> to cleanup the failed client, all the cleanup is skipped as
> 's->connected' is still false.
>=20
> The only important thing that should be skipped in this case
> is sending of the CHR_EVENT_CLOSED, because we never got as
> far as sending the corresponding CHR_EVENT_OPENED. Every other
> bit of cleanup can be robust against being called even when
> s->connected is false.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  chardev/char-socket.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Pq9C0u3UMBpKwV075nW0qAKUP8BnDuopG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnWUTYACgkQp6FrSiUn
Q2rmYQgAh1X0tsEeA+76RoN1HDj8EZD7LJieKxcOBzfTxKvadJRiq1esZqa3/HBr
Lp02slY2ljGA8pbfRnVh/sBsf/TFaNqDQxv0RXPo/0Q29MrOoostZqMoEHahaL6P
o1AM7GXyU0PkEBNaHiX7B9qZdV/MuhgQMrkCTxU0o1lOA7sJ+13h8GWG5cpJFaB7
6MWJCPGjqNuMg1AgLHgkubDyi0DRvLCYpMACf31tlNkUflMYA7Zg5baNCHCnoU7x
EcA5V0oqzxUpoR2O19YBAnWnoZyhuwkajALocHlWSBZiM0NLlkqxFBUTKlfQ4pW1
y5JinPk7/tS3rBNhVkHS/OT77svOXw==
=t3X9
-----END PGP SIGNATURE-----

--Pq9C0u3UMBpKwV075nW0qAKUP8BnDuopG--
