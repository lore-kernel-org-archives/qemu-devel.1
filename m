Received: from eggs.gnu.org ([2001:4830:134:3::10]:46153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cEO9h-0002M7-F9
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 17:24:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cEO9d-0005Yl-J8
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 17:24:09 -0500
References: <20161202192223.15153-1-eblake@redhat.com>
	<20161202192223.15153-3-eblake@redhat.com>
	<42b3c9e3-7c0d-4ec2-4257-1331f16d2c04@redhat.com>
	<50585dad-8418-f52c-8e19-418d8a064131@redhat.com>
	<110c4d8c-c87c-a8b5-04e0-985672e24337@redhat.com>
	<227dbbb5-0486-281b-6668-1dc88cfb6d91@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1d974cec-fefe-e4c9-f2b0-1d8231b229cd@redhat.com>
Date: Tue, 6 Dec 2016 23:23:56 +0100
MIME-Version: 1.0
In-Reply-To: <227dbbb5-0486-281b-6668-1dc88cfb6d91@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dAKWI4tBLHv7XWuFavuatOxAaaWrgWTvW"
Subject: Re: [Qemu-devel] [PATCH v3 2/5] blkdebug: Add pass-through
 write_zero and discard support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dAKWI4tBLHv7XWuFavuatOxAaaWrgWTvW
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <1d974cec-fefe-e4c9-f2b0-1d8231b229cd@redhat.com>
Subject: Re: [PATCH v3 2/5] blkdebug: Add pass-through write_zero and discard
 support
References: <20161202192223.15153-1-eblake@redhat.com>
 <20161202192223.15153-3-eblake@redhat.com>
 <42b3c9e3-7c0d-4ec2-4257-1331f16d2c04@redhat.com>
 <50585dad-8418-f52c-8e19-418d8a064131@redhat.com>
 <110c4d8c-c87c-a8b5-04e0-985672e24337@redhat.com>
 <227dbbb5-0486-281b-6668-1dc88cfb6d91@redhat.com>
In-Reply-To: <227dbbb5-0486-281b-6668-1dc88cfb6d91@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.12.2016 23:18, Eric Blake wrote:
> On 12/06/2016 04:14 PM, Max Reitz wrote:
>> On 06.12.2016 23:12, Eric Blake wrote:
>>> On 12/06/2016 04:00 PM, Max Reitz wrote:
>>>
>>>>> Tested by setting up an NBD server with export 'foo', then invoking=
:
>>>>> $ ./qemu-io
>>>>> qemu-io> open -o driver=3Dblkdebug blkdebug::nbd://localhost:10809/=
foo
>>>
>>> By the way, I'd LOVE to know if there is a way to write a qemu-io
>>> command line that would do this connection automatically (so that I c=
an
>>> batch commands up front and benefit from the shell's history) rather
>>> than having to issue an 'open' after the fact.  I tried various
>>> incantations with --object and --image-opts, but got stumped.
>>
>> Can't you just do qemu-io -c 'open'?
>=20
> I suppose that would get command-line history.  But I still want
> interactive mode.  The moment you use -c, ALL commands get run
> back-to-back without stopping, so I'd have to add additional -c
> 'read'/'write' commands up front. I like interactive mode (open
> pre-connected, now let me explore the image at will).

Well, the usual --image-opts version would be:

=2E/qemu-io --image-opts driver=3Dblkdebug,image.driver=3Dnbd,\
image.host=3Dlocalhost,image.export=3Dfoo

Max


--dAKWI4tBLHv7XWuFavuatOxAaaWrgWTvW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlhHOnwSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A+jsH/1w42l1fk2CckhxP70+4pSx0i7KYNZzW
CgE4DTfDJoBxg58uZUJFFl5yctYsqNWgzF+h8TR1LHl43F6L5ZWCbnzAExwpmaT7
kdicdl6CA+1ER2ng4UCB8VvwHsj+PFQJZ8sih507xvpfSfiPv+f6KAdFy2chn+KC
nC1bMPxcVCNRhVt52riABrzVTs7KX6pQaOCIYvH3oEbVrazcUhyxy/VxlUAvo80R
6OiiPugbPsl0dMk6h8XSdqHUoAy+vzIKWlHAo3PFn3jbILOrJqoTsrENSbUM0uzH
6RAelhapeguWr3FOSjWPbUGm4DswdqhTzA9DOfhd1UFifZyfvBQLsKQ=
=8Zfk
-----END PGP SIGNATURE-----

--dAKWI4tBLHv7XWuFavuatOxAaaWrgWTvW--
