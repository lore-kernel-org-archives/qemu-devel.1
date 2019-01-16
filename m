Received: from eggs.gnu.org ([209.51.188.92]:51832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjtrm-0002vL-Lx
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 17:40:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjtrl-0000q6-JU
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 17:40:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gjtrl-0000gm-7z
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 17:40:57 -0500
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
	<c374ab1ece7bfc933669d8807a54bf362d715a23.1545598229.git.DirtY.iCE.hu@gmail.com>
	<65a00798-9a26-b0bb-b70a-cfd292169123@redhat.com>
	<6198f566-623f-7af7-a337-46173001eada@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <37047cad-7a13-1b32-5ed8-b72c1254d845@redhat.com>
Date: Wed, 16 Jan 2019 16:40:45 -0600
MIME-Version: 1.0
In-Reply-To: <6198f566-623f-7af7-a337-46173001eada@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LX04QYBoKiWOhK25jA2jZrS9CADnFIqOV"
Subject: Re: [Qemu-devel] [PATCH v2 43/52] audio: add mixeng option
 (documentation)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LX04QYBoKiWOhK25jA2jZrS9CADnFIqOV
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>,
 qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <37047cad-7a13-1b32-5ed8-b72c1254d845@redhat.com>
Subject: Re: [PATCH v2 43/52] audio: add mixeng option (documentation)
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
 <c374ab1ece7bfc933669d8807a54bf362d715a23.1545598229.git.DirtY.iCE.hu@gmail.com>
 <65a00798-9a26-b0bb-b70a-cfd292169123@redhat.com>
 <6198f566-623f-7af7-a337-46173001eada@gmail.com>
In-Reply-To: <6198f566-623f-7af7-a337-46173001eada@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/16/19 2:27 PM, Zolt=C3=A1n K=C5=91v=C3=A1g=C3=B3 wrote:

>>> +++ b/qapi/audio.json
>>> @@ -184,6 +184,10 @@
>>>  #
>>>  # General audio backend options that are used for both playback and =
recording.
>>>  #
>>> +# @mixeng: #optional use QEMU's mixing engine to mix all streams ins=
ide QEMU.
>>
>> The #optional tag is no longer necessary (the docs generator figures i=
t
>> out from the '*mixeng' name below).
>=20
> Ok.
>=20
>>> +#          When set to off, fixed-settings must be also off.  Not ev=
ery backend
>>> +#          compatible with the off setting (default on)
>>
>> Missing a '(since 4.0)' tag.
>=20
> The whole AudiodevPerDirectionOptions struct is marked with 'Since:
> 4.0', so I don't think it's necessary.

Oh right. It's less common to see incremental additions to a type within
a single release, but you are right that the per-member tag is only
needed when an older release exposed the type you are extending.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--LX04QYBoKiWOhK25jA2jZrS9CADnFIqOV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw/su4ACgkQp6FrSiUn
Q2oMVgf8DND+hdAbkzV20pAWfzExMfRzM/rKzIrgne1pjoAYR0F6CTo94uLoOGb7
NtP25gc8FtDQk99p6porM+4kakJliw960nmpRfnvDP0738jJG+vWbvyghJ/hiUht
qROmwt5PCMfvwCkokJpETV1E2XCpEr4EspI2O70OHXw9fnOwQgh1E3Jtt3xOa1VD
NwGpRYu6BGqSBidaeqz6ychyaqc0kAmj/vi6+IC+v3eJYvPFhSx/IedZJAzY/e+G
nqJ7uCV3t3IjBwgi8EIieg434qooWDRQGd6K8JI4c16beD85qFJMPmPQRiUciWGQ
jCztFbphWOr5F62aeBKJAASVPFUeTg==
=z18x
-----END PGP SIGNATURE-----

--LX04QYBoKiWOhK25jA2jZrS9CADnFIqOV--
