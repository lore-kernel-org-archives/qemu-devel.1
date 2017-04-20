Received: from eggs.gnu.org ([2001:4830:134:3::10]:49126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1Cv0-0007my-P3
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 10:18:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1Cux-0007uR-Fy
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 10:18:46 -0400
References: <1488288927-4607-1-git-send-email-pl@kamp.de>
	<20170420140514.GM24486@lemon.lan>
	<7731ccd9-b18f-aba2-3bd4-2663b1b9bbea@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ad3d3f20-19ac-4af6-f208-fe7d3a3eeb0e@redhat.com>
Date: Thu, 20 Apr 2017 09:18:33 -0500
MIME-Version: 1.0
In-Reply-To: <7731ccd9-b18f-aba2-3bd4-2663b1b9bbea@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="A57GbV31IG4GrG5Hbo1m5iSCIQAswGF1L"
Subject: Re: [Qemu-devel] [PATCH] qemu-img: simplify img_convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Peter Lieven <pl@kamp.de>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, ct@flyingcircus.io, stefanha@gmail.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--A57GbV31IG4GrG5Hbo1m5iSCIQAswGF1L
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, Peter Lieven <pl@kamp.de>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, ct@flyingcircus.io,
 stefanha@gmail.com, qemu-devel@nongnu.org, mreitz@redhat.com
Message-ID: <ad3d3f20-19ac-4af6-f208-fe7d3a3eeb0e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-img: simplify img_convert
References: <1488288927-4607-1-git-send-email-pl@kamp.de>
 <20170420140514.GM24486@lemon.lan>
 <7731ccd9-b18f-aba2-3bd4-2663b1b9bbea@redhat.com>
In-Reply-To: <7731ccd9-b18f-aba2-3bd4-2663b1b9bbea@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/20/2017 09:11 AM, Eric Blake wrote:
> On 04/20/2017 09:05 AM, Fam Zheng wrote:
>> On Tue, 02/28 14:35, Peter Lieven wrote:
>>> img_convert has been around before there was an ImgConvertState or
>>> a block backend, but it has never been modified to directly use
>>> these structs. Change this by parsing parameters directly into
>>> the ImgConvertState and directly use BlockBackend where possible.
>>> Futhermore variable initalization has been reworked and sorted.
>>>
>>> Signed-off-by: Peter Lieven <pl@kamp.de>
>>
>> I see an iotest failure with this patch, in Kevin's block-next tree:
>>
>> 019 1s ... - output mismatch (see 019.out.bad)
>> --- /stor/work/qemu/tests/qemu-iotests/019.out	2017-04-17 16:19:56.523=
968474 +0800
>> +++ 019.out.bad	2017-04-20 22:03:29.868216955 +0800
>> @@ -1086,8 +1086,8 @@
>> =20
>>  Checking if backing clusters are allocated when they shouldn't
>> =20
>> -0/128 sectors allocated at offset 1 MiB
>> -0/128 sectors allocated at offset 4.001 GiB
>> +128/128 sectors allocated at offset 1 MiB
>> +128/128 sectors allocated at offset 4.001 GiB
>=20
> Hmm - I wonder if my patch to make 'zero with unmap' on an image with n=
o
> backing file prefer pure unallocated clusters over a reads-as-zero woul=
d
> make a difference.
> https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg01728.html
>=20
> Testing now...

Nope, did not make a difference, although it's certainly related; per my
comment in that thread that:

    Note that technically, we _could_ write a cluster as unallocated
    rather than zero if a backing file exists but the backing file
    also reads as zero, but that's more expensive to determine, so
    this optimization is limited to qcow2 without a backing file.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--A57GbV31IG4GrG5Hbo1m5iSCIQAswGF1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY+MM5AAoJEKeha0olJ0Nq7KEH/0vB0NjS9ZTetk2Vnffz9pzW
IFWivtAoaLClvHreM5FhjXHT14QB4eL8fhjdp+S+MUb0pZt7naGW41tbn+ZX3gHQ
5zwjcTpoT0+OFjy5jECSVaS4evMbnjtw1tKZnYuiyi+d17+D2lqK3Xw4h0Xt8abm
sqJn28Zi6jOC/TCARYoW0MZhq0qpAgxQwhVCuBqbfBM3N4fwWCpq4s6eR0MfTHQ2
ut1ufukNC4dSVG4b6OvDoXW0iTL2EbwC0zUJW4xvAn+ga1PcAb9cy3pU5azfR/rP
JH8Ekd9tqZ2uuIWcTdqldyheIegEF2q28A3j5xNsD4cfRi/D3nROjH5fh+c5tiw=
=ngij
-----END PGP SIGNATURE-----

--A57GbV31IG4GrG5Hbo1m5iSCIQAswGF1L--
