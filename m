Received: from eggs.gnu.org ([208.118.235.92]:47396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfAAW-0001Ib-Jt
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 16:04:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfAAV-0007Gu-P3
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 16:04:44 -0500
References: <20190102110804.18155-1-lbloch@janustech.com>
	<20190102110804.18155-2-lbloch@janustech.com>
	<w51h8eqdroh.fsf@maestria.local.igalia.com>
	<9df1a9a8-284b-573b-98aa-fd77edb0cd65@janustech.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1ab08459-6635-acc2-0ba2-961c7a0e5704@redhat.com>
Date: Thu, 3 Jan 2019 15:04:25 -0600
MIME-Version: 1.0
In-Reply-To: <9df1a9a8-284b-573b-98aa-fd77edb0cd65@janustech.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uzfqdGN7l56hR7672mAiUGmHdv663fFVx"
Subject: Re: [Qemu-devel] [PATCH 1/1] include: Auto-generate the sizes
 lookup table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uzfqdGN7l56hR7672mAiUGmHdv663fFVx
From: Eric Blake <eblake@redhat.com>
To: Leonid Bloch <lbloch@janustech.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Stefan Weil
 <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>
Message-ID: <1ab08459-6635-acc2-0ba2-961c7a0e5704@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] include: Auto-generate the sizes lookup
 table
References: <20190102110804.18155-1-lbloch@janustech.com>
 <20190102110804.18155-2-lbloch@janustech.com>
 <w51h8eqdroh.fsf@maestria.local.igalia.com>
 <9df1a9a8-284b-573b-98aa-fd77edb0cd65@janustech.com>
In-Reply-To: <9df1a9a8-284b-573b-98aa-fd77edb0cd65@janustech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/3/19 2:57 PM, Leonid Bloch wrote:

>> I have to say that I'm not very convinced of the benefits of replacing=
 a
>> set of trivial numeric macros with a longer and harder to read shell
>> script accompanied by changes to the build system.
>=20
> I think that the benefit is that the script is easily verifiable,=20
> whereas if someone would like to verify the table, they will need to=20
> generate it themselves. Also, this table is automatically generated=20
> anyway, so it only makes sense to generate it during the build.

But no one is submitting patches to active modify the table.  The work
has already been done once to generate it, and the reviewers have
already verified it; at this point, no further changes are likely to
happen (other than my pipe dream of entirely getting rid of the table in
favor of using runtime generation of human-friendly default strings is
added to QemuOpts instead).  If the table were not already in git, then
generating it at build time might make sense; but at this stage in the
game, you're slowing down every build to regenerate something that is
already correct.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--uzfqdGN7l56hR7672mAiUGmHdv663fFVx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlwueNkACgkQ3g5py3or
ov3HIQgAjZ9d+Prcg0X8CeHmKc8h8CnjXaZXfkI0VlXHWJXs++H3FqoD2E8M0xZO
KCHzXMeu+NsvNNbpicwE+1YE29R7XkQwtUliMTLd/rxiAKJr7KYvKkfSfD9nOuih
BuFx4f/vKaV1IlkW753TCQwEGfh08ydpCEsrDnhmKpQNRrJIkHTppSWz8jG/RUJX
TsgRGMm2HJ7O0yhSkRR1kXQVvnEKo9fQ0XyQMGMrp2E1oagIJu8W4dzhmMSGjLhi
Xp+9eknEde8gtovbVwUx9WkvRtAI1dxQj+WTEA279bEBQQ5MQKqtDXmzDbKe6TJF
mpPB4dtMRXFtk61jtkaVoztjPezOtQ==
=TiUl
-----END PGP SIGNATURE-----

--uzfqdGN7l56hR7672mAiUGmHdv663fFVx--
