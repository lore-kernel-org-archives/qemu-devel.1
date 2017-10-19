Received: from eggs.gnu.org ([2001:4830:134:3::10]:36692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5CbI-0005RK-4r
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:19:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5CbE-0004uI-Tr
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:19:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e5CbE-0004tl-Ln
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:19:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BD796914FD
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 15:19:07 +0000 (UTC)
References: <20171019142848.572-1-berrange@redhat.com>
	<20171019142848.572-4-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1eae2fcd-7c37-eee1-71ee-1c69d4d35726@redhat.com>
Date: Thu, 19 Oct 2017 10:19:01 -0500
MIME-Version: 1.0
In-Reply-To: <20171019142848.572-4-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="18lPU4RmPVp8npTHsXiWSu8jqat2ROX4j"
Subject: Re: [Qemu-devel] [PATCH v1 3/9] ui: use correct union field for key
 number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--18lPU4RmPVp8npTHsXiWSu8jqat2ROX4j
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <1eae2fcd-7c37-eee1-71ee-1c69d4d35726@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 3/9] ui: use correct union field for key
 number
References: <20171019142848.572-1-berrange@redhat.com>
 <20171019142848.572-4-berrange@redhat.com>
In-Reply-To: <20171019142848.572-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/19/2017 09:28 AM, Daniel P. Berrange wrote:
> The code converting key numbers to QKeyCode in the 'input-send-event'
> command mistakenly accessed the key->u.qcode union field instead of
> the key->u.number field. This is harmless because the fields use the
> same size datatype in both cases, but none the less it should be fixed
> to avoid confusion.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  ui/input.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/ui/input.c b/ui/input.c
> index 290b47354a..4e821f8f2b 100644
> --- a/ui/input.c
> +++ b/ui/input.c
> @@ -162,7 +162,7 @@ void qmp_input_send_event(bool has_device, const ch=
ar *device,
>          if (evt->type =3D=3D INPUT_EVENT_KIND_KEY &&
>              evt->u.key.data->key->type =3D=3D KEY_VALUE_KIND_NUMBER) {=

>              KeyValue *key =3D evt->u.key.data->key;
> -            QKeyCode code =3D qemu_input_key_number_to_qcode(key->u.qc=
ode.data);
> +            QKeyCode code =3D qemu_input_key_number_to_qcode(key->u.nu=
mber.data);
>              qemu_input_event_send_key_qcode(con, code, evt->u.key.data=
->down);
>          } else {
>              qemu_input_event_send(con, evt);
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--18lPU4RmPVp8npTHsXiWSu8jqat2ROX4j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnowmUACgkQp6FrSiUn
Q2qb6wf/WKeeg4lpoDpskAoJlytSg7i55px44NHS083kscnMsks++X2XG223RZTt
ndyf6IWNu2LgWAqd19IfNVm5x6LUaOLxvEgqK/oJA/7rnW+XJhjdydUHcI7HopOz
mqY1Pwv8HFkMOzQ1lS7g3kU0WEp2i5FJnMwnLVrbcFqbamzyDRLWaO6XINsWrhKA
PZIgRaMJTUZCU/CNQznCPM89/kfJ8/7zbBejm6fKXCDo8wsZltZZHfAbVyGViVu4
SHLo4fEX3rzBKNaYKSYwV9upe/AKJFXni8SjFNo5FiENIdaNVh6VRMPBgby2TYQ+
9CowOQr0/gpZDBM7scfK3J10OpIuIw==
=6O5A
-----END PGP SIGNATURE-----

--18lPU4RmPVp8npTHsXiWSu8jqat2ROX4j--
