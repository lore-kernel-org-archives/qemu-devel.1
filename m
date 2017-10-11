Received: from eggs.gnu.org ([2001:4830:134:3::10]:53513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e2FDn-0007Rl-9a
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 07:30:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e2FDm-0006ZP-5V
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 07:30:43 -0400
References: <20171009215533.12530-1-mreitz@redhat.com>
	<20171009215533.12530-2-mreitz@redhat.com>
	<7e2e97b0-bca9-bd38-7641-c38f1e38c586@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b4275f79-b640-ce23-1738-eb0910445452@redhat.com>
Date: Wed, 11 Oct 2017 13:30:27 +0200
MIME-Version: 1.0
In-Reply-To: <7e2e97b0-bca9-bd38-7641-c38f1e38c586@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wp6Ep8lIfUR2A86XqNpBMDJh8oJxS1Sl4"
Subject: Re: [Qemu-devel] [PATCH 1/3] qcow2: Fix unaligned preallocated
 truncation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Ping Li <pingl@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wp6Ep8lIfUR2A86XqNpBMDJh8oJxS1Sl4
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Ping Li <pingl@redhat.com>
Message-ID: <b4275f79-b640-ce23-1738-eb0910445452@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] qcow2: Fix unaligned preallocated
 truncation
References: <20171009215533.12530-1-mreitz@redhat.com>
 <20171009215533.12530-2-mreitz@redhat.com>
 <7e2e97b0-bca9-bd38-7641-c38f1e38c586@redhat.com>
In-Reply-To: <7e2e97b0-bca9-bd38-7641-c38f1e38c586@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-10-10 00:25, Eric Blake wrote:
> On 10/09/2017 04:55 PM, Max Reitz wrote:
>> A qcow2 image file's length is not required to have a length that is a=

>> multiple of the cluster size.  However, qcow2_refcount_area() expects =
an
>> aligned value for its @start_offset parameter, so we need to round
>> @old_file_size up to the next cluster boundary.
>>
>> Reported-by: pingl <pingl@redhat.com>
>=20
> Should we use a real name? My autocomplete when adding cc suggests Ping=
 Li.

So does Red Hat's staff search. :-)

I thought I'd just take the name from the BZ, so I'd be safe -- pleading
the fact that real names are only required for S-o-bs.  But well, why not=
=2E

> (The upcoming git 2.15.0 adds my patch that auto-cc's anyone listed in
> Reported-by, so we don't have to keep doing it manually:
> https://github.com/git/git/commit/09ac6737 - but that doesn't help you
> while you are still on 2.13.6)

I like doing it manually because I don't like CC-ing only singular
patches of a series, though -- at least not without CC-ing the cover
letter, too.

So far I was lucky enough not to get into a situation where I didn't
want someone I wanted to CC on one patch not to see the whole series.
(In this case here I don't think Red Hat QA gains much from seeing the
upstream patch.)  If I get unlucky in the future, I guess I'll have to
extend my email sending script...

>> Bug: https://bugzilla.redhat.com/show_bug.cgi?id=3D1414049
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/qcow2.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

Max


--wp6Ep8lIfUR2A86XqNpBMDJh8oJxS1Sl4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlneANMSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AGvUIAJGuWi36cLCh3xVqEvD3m+pgRmhhEPKd
57wO8bCf514wKZA5Ifi+wcg5D6Ddjupzjklc7e3RC3ks7qt9riZIkE5OscW/2G2y
azsXHcLXitGtRaZnNyRxcrGp/MezmhFxqcRr5mUoJllmB0Iy1P3WSrZSiMDhYZGT
89lec3Hrmdf2AEbwm570awpSmNzEChAVOj+VzyY3uTwQdgLOQvW10HrYeBq0Z77Y
qCnaaeHeH1k3mV3tW9muptrWAVsFhPnxFLM5aIKiBn82hZM5cOA9MTAxb5q3UrdX
xlrROEvYqAHpg22Ed4CAWxSSY/MA5/Bt669JrPUj67JIuoHWawiFLUk=
=l0Vt
-----END PGP SIGNATURE-----

--wp6Ep8lIfUR2A86XqNpBMDJh8oJxS1Sl4--
