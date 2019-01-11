Received: from eggs.gnu.org ([209.51.188.92]:37071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gi2Zl-0003N2-Mz
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 14:34:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gi2Zj-0004Y5-CF
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 14:34:41 -0500
References: <20181221093529.23855-1-jsnow@redhat.com>
	<20181221093529.23855-2-jsnow@redhat.com>
	<6ab25a23-c717-2ef0-7cac-7ee6db63c364@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e87bc5ed-2d56-4e78-6948-a0127cbab0eb@redhat.com>
Date: Fri, 11 Jan 2019 13:34:18 -0600
MIME-Version: 1.0
In-Reply-To: <6ab25a23-c717-2ef0-7cac-7ee6db63c364@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="D6zaXsmpz72iAr5TiKLVxa61wzZS9GgY9"
Subject: Re: [Qemu-devel] [PATCH v6 01/11] blockdev: abort transactions in
 reverse order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D6zaXsmpz72iAr5TiKLVxa61wzZS9GgY9
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 vsementsov@virtuozzo.com, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <e87bc5ed-2d56-4e78-6948-a0127cbab0eb@redhat.com>
Subject: Re: [PATCH v6 01/11] blockdev: abort transactions in reverse order
References: <20181221093529.23855-1-jsnow@redhat.com>
 <20181221093529.23855-2-jsnow@redhat.com>
 <6ab25a23-c717-2ef0-7cac-7ee6db63c364@redhat.com>
In-Reply-To: <6ab25a23-c717-2ef0-7cac-7ee6db63c364@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/11/19 11:52 AM, Eric Blake wrote:
> On 12/21/18 3:35 AM, John Snow wrote:
>> Presently, we abort transactions in the same order they were processed=
 in.
>> Bitmap commands, though, attempt to restore backup data structures on =
abort.
>>
>> That's not valid, they need to be aborted in reverse chronological ord=
er.
>>
>> Replace the QSIMPLEQ data structure with a QTAILQ one, so we can itera=
te
>> in reverse for the abort phase of the transaction.
>=20
> This patch conflicts with Paolo's improvements to QTAILQ that just
> landed; the resolution should be obvious, but at this point, you'll wan=
t
> to post a v7.
>=20
> Or did you want me to try and fix the conflict, and take the series
> through my NBD tree since I have patches based on top of it?

Actually, I went ahead and queued this series in my NBD tree after
making the fixes, so I can get the removal of x- in place sooner for
easier integration testing on my libvirt code.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--D6zaXsmpz72iAr5TiKLVxa61wzZS9GgY9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw477oACgkQp6FrSiUn
Q2qZzAgAmogvHPzFjLDBTGDqjh8URZiniMMBiOMNnTwIhLCkknQr4JQXOWXw5/Fn
kaPSUYKGie4Zo6yusxm+3caRCTyxoFnckz/qv11OYr7Xq/QBXOjV+fTt/Ft0XDxM
Rd7wSV0RL1+kJgf+MvO/ERtsa3XCnHASEAFb/s9E9otw6IjnGBaJxH5UMQWCQ+x3
WQGnR4WTs+IcWVkLZj8n9ccGa1Pmp5N2IH97BxOWkoDJhri+tv6ebeXpkpiYWlQD
Ky82IyAcleRxjQkpQ2tp+3N5nkpH0eSCySnpywWqUiR4V61KozA76vgG3Sb6fo7B
neRYbXHTIljEoOxcAYiflLBnGEmOEw==
=kX1o
-----END PGP SIGNATURE-----

--D6zaXsmpz72iAr5TiKLVxa61wzZS9GgY9--
