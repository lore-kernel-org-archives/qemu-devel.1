Received: from eggs.gnu.org ([209.51.188.92]:47800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hL7SY-0007gv-Bt
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:40:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hL7SX-0006U0-HX
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:40:46 -0400
References: <20190429105741.31033-1-kwolf@redhat.com>
	<20190429112140.GF8492@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ab303a48-a796-4550-f6cf-cff2674d2ee9@redhat.com>
Date: Mon, 29 Apr 2019 09:40:40 -0500
MIME-Version: 1.0
In-Reply-To: <20190429112140.GF8492@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="E017uU8EB5L5gMdQwB2ku4OLLIBmljN1J"
Subject: Re: [Qemu-devel] [PATCH] qcow2: Fix qcow2_make_empty() with
 external data file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E017uU8EB5L5gMdQwB2ku4OLLIBmljN1J
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, mreitz@redhat.com
Message-ID: <ab303a48-a796-4550-f6cf-cff2674d2ee9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qcow2: Fix qcow2_make_empty() with external
 data file
References: <20190429105741.31033-1-kwolf@redhat.com>
 <20190429112140.GF8492@localhost.localdomain>
In-Reply-To: <20190429112140.GF8492@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/29/19 6:21 AM, Kevin Wolf wrote:
> Am 29.04.2019 um 12:57 hat Kevin Wolf geschrieben:
>> make_completely_empty() is an optimisated path for bdrv_make_empty()
>> where completely new metadata is created inside the image file instead=

>> of going through all clusters and discarding them. For an external dat=
a
>> file, however, we actually need to do discard operations on the data
>> file; just overwriting the qcow2 file doesn't get rid of the data.
>>
>> The necessary slow path with an explicit discard operation already
>> exists for other cases. Use it for external data files, too.
>>
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> ---
>>  block/qcow2.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)

> Oops, I hadn't everything committed yet. I'll add a comment change as
> well:

With the comment change squashed in,
Reviewed-by: Eric Blake <eblake@redhat.com>


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--E017uU8EB5L5gMdQwB2ku4OLLIBmljN1J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzHDOgACgkQp6FrSiUn
Q2qMsAgAqgRilOeU4bC8M60cyBLAU91O55BfbS5aMVZNNflMLV0QWhAkXSYwziuP
7om7wElQgdEy6ywES/85/LieA/PiwXpjZP/wg0wYHjq0NMXxzfP6Nt+g1hGF8d7K
juePCbhWwxkkkARt1jOxb+iQf013Yaa4K2tesSy1/BbX14twt9lctd3O8W2umLmV
GUNx46VLZa29yJhkESfsqd60XwryvDB+j78RhMb6twlc3I7eXToevpFNasAi1eWt
h5LyYb/PxPhptzTQQI/ZV02/eH+02T66jE40vpAD5SslZjGK+o+y7n62if7T/tyA
2kuozWz4b/9vBA5J75cAy3nXmahYmw==
=qo7b
-----END PGP SIGNATURE-----

--E017uU8EB5L5gMdQwB2ku4OLLIBmljN1J--
