Received: from eggs.gnu.org ([2001:4830:134:3::10]:39147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fv09s-00052L-N5
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 09:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fv09p-0006tG-2N
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 09:05:16 -0400
References: <cover.1535291602.git.berto@igalia.com>
	<599f98e81407a82d8b05764eeac7dbcf5f52142d.1535291602.git.berto@igalia.com>
	<8530786e-50b2-3dc2-2f1c-834ccd163b3a@redhat.com>
	<w51o9dl2vzv.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <56132017-1c41-35e8-d882-5a6835157887@redhat.com>
Date: Wed, 29 Aug 2018 14:59:59 +0200
MIME-Version: 1.0
In-Reply-To: <w51o9dl2vzv.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bxTUrBf5xEAv2uaCcGXKHhgU8oyue33SN"
Subject: Re: [Qemu-devel] [PATCH 6/9] file-posix: Forbid trying to change
 unsupported options during reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bxTUrBf5xEAv2uaCcGXKHhgU8oyue33SN
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <56132017-1c41-35e8-d882-5a6835157887@redhat.com>
Subject: Re: [PATCH 6/9] file-posix: Forbid trying to change unsupported
 options during reopen
References: <cover.1535291602.git.berto@igalia.com>
 <599f98e81407a82d8b05764eeac7dbcf5f52142d.1535291602.git.berto@igalia.com>
 <8530786e-50b2-3dc2-2f1c-834ccd163b3a@redhat.com>
 <w51o9dl2vzv.fsf@maestria.local.igalia.com>
In-Reply-To: <w51o9dl2vzv.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-29 14:33, Alberto Garcia wrote:
> On Wed 29 Aug 2018 01:33:13 PM CEST, Max Reitz wrote:
>> On 2018-08-26 16:09, Alberto Garcia wrote:
>>> The file-posix code is used for the "file", "host_device" and
>>> "host_cdrom" drivers, and it allows reopening images. However the onl=
y
>>> option that is actually processed is "x-check-cache-dropped", and
>>> changes in all other options (e.g. "filename") are silently ignored:
>>>
>>>    (qemu) qemu-io virtio0 "reopen -o file.filename=3Dno-such-file"
>>>
>>> While we could allow changing some of the other options, let's keep
>>> things as they are for now but return an error if the user tries to
>>> change any of them.
>>>
>>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>>> ---
>>>  block/file-posix.c | 9 +++++++--
>>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> Looks OK, but the same question from the last patch arises.  If
>> unspecified options mean using the default, shouldn't the user have to=

>> re-specify all mandatory options, so at least @filename in this case?
>=20
> This is the old (existing) reopen command, which takes the current
> options and applies the user-specified changes on top. In this one we
> can leave options out because the old values are kept.
>=20
> It's in the new QMP blockdev-reopen command (not in this series yet)
> that you need to specify all options (among other things because it
> takes a BlockdevOptions struct, so there's no choice not to specify the=

> mandatory ones).

Hmm...  OK.  I thought we'd just change the current reopen command.  But
that's OK, then.

Max


--bxTUrBf5xEAv2uaCcGXKHhgU8oyue33SN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluGmNAACgkQ9AfbAGHV
z0DLLAf+P5KYktz7Djjv7ESFPE14qmfGb1lxjRGKB92644v6ImhROXSbd6xHZs1V
ZVmgUAZMkqpeCUCOztoVj5c1nkBN0kJ8dbAtFsPV9rLBW2hKONmtOiOO5DgJXawC
E71a5OJ6k8lfQkG7j/QPhFNuME4oSJUBkNassr93MSe7G2hEmsb9MXY86w3sVHvF
6vIbIjIRlml2iZjDpvvROYkz3bgEn9slE8xJml1YpYF5hDFQ7bKZy8zRUjWWYPrk
rG024jNGJSC+GtiqM713Od0f+D0zOq0mEWDD9T98pKot1+7ydSJokugddP5DY2Pn
DXetF74FmqMjnMueb13or9/Un2KWlg==
=CWgr
-----END PGP SIGNATURE-----

--bxTUrBf5xEAv2uaCcGXKHhgU8oyue33SN--
