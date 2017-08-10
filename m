Received: from eggs.gnu.org ([2001:4830:134:3::10]:52914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfsjD-0008Dm-8v
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 15:02:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfsj9-0000Yx-2r
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 15:02:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dfsj8-0000Yp-QK
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 15:02:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B510B61D37
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 19:02:37 +0000 (UTC)
References: <20170810155522.31099-1-berrange@redhat.com>
	<20170810155522.31099-6-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ebc649e6-7e62-84fc-629a-d8e33aeabc6d@redhat.com>
Date: Thu, 10 Aug 2017 14:02:32 -0500
MIME-Version: 1.0
In-Reply-To: <20170810155522.31099-6-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="egwnibaBnkgkN7w96dNOjJg9E4wiJ2gpR"
Subject: Re: [Qemu-devel] [PATCH 05/15] ui: use QKeyCode exclusively in
 InputKeyEvent
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
--egwnibaBnkgkN7w96dNOjJg9E4wiJ2gpR
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <ebc649e6-7e62-84fc-629a-d8e33aeabc6d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/15] ui: use QKeyCode exclusively in
 InputKeyEvent
References: <20170810155522.31099-1-berrange@redhat.com>
 <20170810155522.31099-6-berrange@redhat.com>
In-Reply-To: <20170810155522.31099-6-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/10/2017 10:55 AM, Daniel P. Berrange wrote:
> Now that keycode numbers are converted to QKeyCodes immediately
> when creating input events, the InputKeyEvent struct can be
> changed to only accept a QKeyCode, instead of a KeyValue.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---

> +++ b/qapi-schema.json
> @@ -5747,7 +5747,7 @@
>  # Since: 2.0
>  ##
>  { 'struct'  : 'InputKeyEvent',
> -  'data'  : { 'key'     : 'KeyValue',
> +  'data'  : { 'key'     : 'QKeyCode',
>                'down'    : 'bool' } }

Isn't this going to break backwards-compatibility of 'input-send-event'?

I think you have to keep the public API the same, even if you make the
conversion as early as possible to the preferred mapping form internally.=


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--egwnibaBnkgkN7w96dNOjJg9E4wiJ2gpR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmMrcgACgkQp6FrSiUn
Q2okfwf/Thy+//8fMFAmgGQvl7135xiHnwRrNaDZ9W+KL4MROoKqK2XQz1DxLbtV
EoBHeAfs2caLW/y/uvwnSfuNlYPK+kLLWyTPgnY5214z95FkaagjREYBf3vdWUJ+
2ZwZK2VBe5WEF89esmo2ZemwkW1K3v+LN2kGsV5Blq5e1hm5Q2O0SDmA10fXvslr
G9XjZ8WgYOGo14ogsF77WT/uCPdleeVV6GMY7poGDXvESryFaLt8fOKDASo3NdPP
xUZZcbhSC6oA2sv/NC0DkVw2JoJ3qySTcryDuo2JtZAzbg+mTXWVCD+UseleROl+
s60RxYmhERm40ksEfCvm9yAa/vQwzg==
=dPQ0
-----END PGP SIGNATURE-----

--egwnibaBnkgkN7w96dNOjJg9E4wiJ2gpR--
