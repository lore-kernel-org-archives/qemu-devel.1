Received: from eggs.gnu.org ([209.51.188.92]:42134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gmJZg-0005Q9-Ot
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:32:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gmJUj-0006UR-8l
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:27:10 -0500
References: <20181221234750.23577-1-mreitz@redhat.com>
	<20181221234750.23577-2-mreitz@redhat.com>
	<fd55396f-47d6-2836-46c3-0c44c8248a8b@redhat.com>
	<64732cb4-b586-2e38-b2b4-880359c56a3e@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <72fbcfe7-7f65-9e5b-e5f8-4f119f93c5d0@redhat.com>
Date: Wed, 23 Jan 2019 08:27:04 -0600
MIME-Version: 1.0
In-Reply-To: <64732cb4-b586-2e38-b2b4-880359c56a3e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nNQxlQXXD3o5u62Df3iTHsTRRIRdBpwFx"
Subject: Re: [Qemu-devel] [PATCH 1/3] iotests.py: Add qemu_nbd_pipe()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nNQxlQXXD3o5u62Df3iTHsTRRIRdBpwFx
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <72fbcfe7-7f65-9e5b-e5f8-4f119f93c5d0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] iotests.py: Add qemu_nbd_pipe()
References: <20181221234750.23577-1-mreitz@redhat.com>
 <20181221234750.23577-2-mreitz@redhat.com>
 <fd55396f-47d6-2836-46c3-0c44c8248a8b@redhat.com>
 <64732cb4-b586-2e38-b2b4-880359c56a3e@redhat.com>
In-Reply-To: <64732cb4-b586-2e38-b2b4-880359c56a3e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/23/19 7:06 AM, Max Reitz wrote:
> On 21.01.19 21:55, Eric Blake wrote:
>> On 12/21/18 5:47 PM, Max Reitz wrote:
>>> In some cases, we may want to deal with qemu-nbd errors (e.g. by
>>> launching it in a different configuration until it no longer throws
>>> any).  In that case, we do not want its output ending up in the test
>>> output.
>>>
>>> It may still be useful for handling the error, though, so add a new
>>> function that works basically like qemu_nbd(), only that it returns t=
he
>>> qemu-nbd output instead of making it end up in the log.  In contrast =
to
>>> qemu_img_pipe(), it does still return the exit code as well, though,
>>
>> In contrast to qemu_nbd(),
>=20
> But qemu_nbd() does return the exit code.  qemu_img_pipe() doesn't.
>=20

Oh, I see where I got confused. I thought you were comparing the new
code [qemu_nbd_pipe] to itself; not to the pre-existing qemu_img_pipe
that is not touched by this patch, but which served as the model you
copied after.

>>> because that is even more important for error handling.
>>>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>>  tests/qemu-iotests/iotests.py | 14 ++++++++++++++
>>>  1 file changed, 14 insertions(+)
>>>

>> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> Thanks for reviewing!

Although my questions on patch 3 call into question whether you even
need this patch, if your only use of it was to find a free port.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--nNQxlQXXD3o5u62Df3iTHsTRRIRdBpwFx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxIebgACgkQp6FrSiUn
Q2owhAf+LAjElR3QfGcjF0O8IDh5YH15/Oakvil+2vPVSUu/F7UFJYNNI1Xq4Eh6
uWs+shBBibr8LN3OcZ2nSCUVcjBEhmkZsrcI+LkcjePW9gIkCcOtVlc2AGVCipj6
S4iBUp27Sd07vjtGDrYsgmhrYjWGtdz47WQWmAd2d/VN8PZx51ASIH34/uCF7ioC
6mAGmVEEnd/DAGwiE/MFoKffaarzfx3hnF2UW0dAR0pceJPzpxlwUMJuGQemzgcX
dVN0dJRGiY9T3jqn705+r6TtbkuNBlfRzS1OZPWETFGCXH1f/MMtM6iXDFIOKLbn
w9JKDoOZp4ZM9kntZzem3+dNI6PZ8A==
=Ba85
-----END PGP SIGNATURE-----

--nNQxlQXXD3o5u62Df3iTHsTRRIRdBpwFx--
