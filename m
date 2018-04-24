Received: from eggs.gnu.org ([2001:4830:134:3::10]:60596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB1vV-0002dj-KN
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 13:40:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB1vU-0002QD-KC
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 13:40:25 -0400
References: <20180215192829.9944-1-eblake@redhat.com>
	<20180215192829.9944-4-eblake@redhat.com>
	<20180424155205.GD4080@localhost.localdomain>
	<f9c2e87f-082e-36ce-971a-6b11cb65d843@redhat.com>
	<20180424171920.GI4080@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1cee058b-465d-4862-7fb0-8567f79c79b1@redhat.com>
Date: Tue, 24 Apr 2018 12:40:06 -0500
MIME-Version: 1.0
In-Reply-To: <20180424171920.GI4080@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Vznfjcpaa8xGNGwkvymh9X68UiIHty2ue"
Subject: Re: [Qemu-devel] [PATCH 3/6] null: Switch to byte-based read/write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Vznfjcpaa8xGNGwkvymh9X68UiIHty2ue
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Fam Zheng
 <famz@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <1cee058b-465d-4862-7fb0-8567f79c79b1@redhat.com>
Subject: Re: [PATCH 3/6] null: Switch to byte-based read/write
References: <20180215192829.9944-1-eblake@redhat.com>
 <20180215192829.9944-4-eblake@redhat.com>
 <20180424155205.GD4080@localhost.localdomain>
 <f9c2e87f-082e-36ce-971a-6b11cb65d843@redhat.com>
 <20180424171920.GI4080@localhost.localdomain>
In-Reply-To: <20180424171920.GI4080@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/24/2018 12:19 PM, Kevin Wolf wrote:

>>>> +static void null_refresh_limits(BlockDriverState *bs, Error **errp)=

>>>> +{
>>>> +    bs->bl.request_alignment =3D 1;
>>>> +}
>>>
>>> I would rather modify bdrv_refresh_limits() so that it defaults to 1 =
for
>>> drivers supporting either .bdrv_co_preadv or .bdrv_aio_preadv.
>>
>> Sure, I can do that (although then I may have to provide a
>> refresh_limits callback for each of the other drivers that I
>> specifically left at 512 alignment).
>=20
> Do we know that the other drivers need 512, or do we expect than they
> can handle byte granularity, but we try to err on the safe side?

Done to err on the safe side and avoid the difficulty of a deep audit in
code I'm unfamiliar with; in fact, for vxhs, I wasn't even able to
compile test things, which means I certainly wasn't able to reproduce a
test to see if dropping the alignment would break anything under qemu-io.=


>=20
> If it's the latter (which would be my expectation), then it's probably
> better to set request_alignment =3D 512 with a comment in those drivers=

> and hope that someone will lift the restriction in the future.

Indeed, leaving a good comment for a future reader is worth the effort.
I'll send a v2 later today.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Vznfjcpaa8xGNGwkvymh9X68UiIHty2ue
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrfa/YACgkQp6FrSiUn
Q2rxKAf8CGpZezcnENXMg50E4AiiXK+QzFYvr+CMlPfBZw1HFijjrRhYHCv4idqp
NaWR6fnfpmDsN7R95jds2TX44USkxiSS1frjzsiYVBgiv8I4IUkOjmS/Sk82d+xd
+6FDBPpTU7BPR9dgzjpfK8D6NNxYWqAFKE30IPW+XYGEHaacFji2jBce0jvaDBs1
ypVMVZv3YvRax0plxX2kllqyDMBosytRj1L9lECBev9grlHUuVG2MIqBLv+z3aHv
bM29Z6pddzf6qAg/QtCuAtpf4O9fclf2vzS3ertbJBnsP/dflIsHULfMIEy+N8eR
Mo4Wq1ysJjqS3F52rE0PPXAlrFmazw==
=dA+l
-----END PGP SIGNATURE-----

--Vznfjcpaa8xGNGwkvymh9X68UiIHty2ue--
