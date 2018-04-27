Received: from eggs.gnu.org ([2001:4830:134:3::10]:58738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fC9Qd-0000cd-D0
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:53:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fC9QY-0006LN-MV
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:53:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46488 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fC9QY-0006KS-GQ
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:53:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 082DA81A8A13
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 19:53:05 +0000 (UTC)
References: <20180427192852.15013-1-lersek@redhat.com>
	<20180427192852.15013-3-lersek@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5853853e-fa05-2dcf-0c8e-6b812222c453@redhat.com>
Date: Fri, 27 Apr 2018 14:53:04 -0500
MIME-Version: 1.0
In-Reply-To: <20180427192852.15013-3-lersek@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OrdUe8gYfb7lYGKCulWfLDCjSOQc15jnk"
Subject: Re: [Qemu-devel] [PATCH v3 2/5] qapi: add SysEmuTarget to
 "common.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OrdUe8gYfb7lYGKCulWfLDCjSOQc15jnk
From: Eric Blake <eblake@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <5853853e-fa05-2dcf-0c8e-6b812222c453@redhat.com>
Subject: Re: [PATCH v3 2/5] qapi: add SysEmuTarget to "common.json"
References: <20180427192852.15013-1-lersek@redhat.com>
 <20180427192852.15013-3-lersek@redhat.com>
In-Reply-To: <20180427192852.15013-3-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/27/2018 02:28 PM, Laszlo Ersek wrote:
> We'll soon need an enumeration type that lists all the softmmu targets
> that QEMU (the project) supports. Introduce @SysEmuTarget to
> "common.json".
>=20
> The enum constant @x86_64 doesn't match the QAPI convention of preferri=
ng
> hyphen ("-") over underscore ("_"). This is intentional; the @SysEmuTar=
get
> constants are supposed to produce QEMU executable names when stringifie=
d
> and appended to the "qemu-system-" prefix. Put differently, the
> replacement text of the TARGET_NAME preprocessor macro must be possible=
 to
> look up in the list of (stringified) enum constants.
>=20
> Like other enum types, @SysEmuTarget too can be used for discriminator
> fields in unions. For the @i386 constant, a C-language union member cal=
led
> "i386" would be generated. On mingw build hosts, "i386" is a macro
> however. Add "i386" to "polluted_words" at once.
>=20
> Cc: "Daniel P. Berrange" <berrange@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>=20
> Notes:
>     PATCHv3:
>    =20
>     - copy the suggested (shorter) Notes: wrt. underscore use in @x86_6=
4 to
>       the schema, and move the original (longer) schema Notes: to the c=
ommit
>       message [Eric]

Thanks; that looks better.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--OrdUe8gYfb7lYGKCulWfLDCjSOQc15jnk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrjf6AACgkQp6FrSiUn
Q2pxhQgAnCCZv/6OueoQRfeFyY1fitZhEr5fArMK42uNiT1CzUB+sl2yK07yEU/W
iwav8axbpIyVMqxxbIfM0umpS3cf5SzrD97apO97SsJw4vpeiX7ST69LJozXB5LX
ikxSNfsVPfs+wmEit//jYjhBt9xlJas8VJ01CsnlSqz9rg7Cx6GvQt7HcA5U8H50
+lx4H9vi5MXiNO7Od37TcScS8kRN+lxZMhNv4kcfuiNngWyMDOnFcnd35tJXhBJa
5YXC5Ua7XJJwMIOtela2P69T9RKdacJmoq9rVV3yn9Aq8OkG1JEirGsVo6zYZAzO
qxkvC7tAo2i9Rf3ZFdeIYAz24LX+ZA==
=6Ua2
-----END PGP SIGNATURE-----

--OrdUe8gYfb7lYGKCulWfLDCjSOQc15jnk--
