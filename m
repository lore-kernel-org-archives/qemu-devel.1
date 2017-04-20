Received: from eggs.gnu.org ([2001:4830:134:3::10]:47175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1CoH-00063a-9z
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 10:11:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1CoG-0002MX-6I
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 10:11:49 -0400
References: <1488288927-4607-1-git-send-email-pl@kamp.de>
	<20170420140514.GM24486@lemon.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7731ccd9-b18f-aba2-3bd4-2663b1b9bbea@redhat.com>
Date: Thu, 20 Apr 2017 09:11:35 -0500
MIME-Version: 1.0
In-Reply-To: <20170420140514.GM24486@lemon.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5PgpLLmqAjrlofTSqkvrBAxIglw7fq5gH"
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, stefanha@gmail.com, ct@flyingcircus.io, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5PgpLLmqAjrlofTSqkvrBAxIglw7fq5gH
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, Peter Lieven <pl@kamp.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com,
 stefanha@gmail.com, ct@flyingcircus.io, mreitz@redhat.com
Message-ID: <7731ccd9-b18f-aba2-3bd4-2663b1b9bbea@redhat.com>
Subject: Re: [PATCH] qemu-img: simplify img_convert
References: <1488288927-4607-1-git-send-email-pl@kamp.de>
 <20170420140514.GM24486@lemon.lan>
In-Reply-To: <20170420140514.GM24486@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/20/2017 09:05 AM, Fam Zheng wrote:
> On Tue, 02/28 14:35, Peter Lieven wrote:
>> img_convert has been around before there was an ImgConvertState or
>> a block backend, but it has never been modified to directly use
>> these structs. Change this by parsing parameters directly into
>> the ImgConvertState and directly use BlockBackend where possible.
>> Futhermore variable initalization has been reworked and sorted.
>>
>> Signed-off-by: Peter Lieven <pl@kamp.de>
>=20
> I see an iotest failure with this patch, in Kevin's block-next tree:
>=20
> 019 1s ... - output mismatch (see 019.out.bad)
> --- /stor/work/qemu/tests/qemu-iotests/019.out	2017-04-17 16:19:56.5239=
68474 +0800
> +++ 019.out.bad	2017-04-20 22:03:29.868216955 +0800
> @@ -1086,8 +1086,8 @@
> =20
>  Checking if backing clusters are allocated when they shouldn't
> =20
> -0/128 sectors allocated at offset 1 MiB
> -0/128 sectors allocated at offset 4.001 GiB
> +128/128 sectors allocated at offset 1 MiB
> +128/128 sectors allocated at offset 4.001 GiB

Hmm - I wonder if my patch to make 'zero with unmap' on an image with no
backing file prefer pure unallocated clusters over a reads-as-zero would
make a difference.
https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg01728.html

Testing now...

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--5PgpLLmqAjrlofTSqkvrBAxIglw7fq5gH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY+MGXAAoJEKeha0olJ0NqC5YH/0H+nhZ18SKzrMC+4QJpQ52Q
WYgeSV7Nt2+L4JJdGUgA6v11LBa31ih6KC1Zib3LCyj1HleR262NJBvqygJXZtr1
mEpPa1NVOSF3eEsR99ys7PPGiyhOqeax2jAFSGMTPHF7OM7MNz1biF9D7Yq5JAr/
RXNMqmUo18m5VfaIxiJHuRW8S4XDTO8vQp9MVm76VrCRkn/UVAunFQbOqB73psF8
8LXYuqiTuxJkYbUmGhRUAUrfhhaST6zIMIpRDg4EAXgwCMlyhB6mz31za3Z4PWs8
Jibti9GpdEVfb/vH6BGU2Ux0KIMLbUMBtoixwQG4WM+n2gQFaEMDmEQhUP2qduI=
=m4BO
-----END PGP SIGNATURE-----

--5PgpLLmqAjrlofTSqkvrBAxIglw7fq5gH--
