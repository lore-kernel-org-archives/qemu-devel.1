Received: from eggs.gnu.org ([2001:4830:134:3::10]:47570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cWQOQ-0004cw-P6
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:25:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cWQOP-0006Sp-MI
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:25:54 -0500
References: <20161216052040.53067-1-haoqf@linux.vnet.ibm.com>
	<20161216052040.53067-2-haoqf@linux.vnet.ibm.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <be77cb51-c3ad-d7a0-9c85-cb7aeaed31b0@redhat.com>
Date: Wed, 25 Jan 2017 17:25:44 +0100
MIME-Version: 1.0
In-Reply-To: <20161216052040.53067-2-haoqf@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jIp7lcqOiLJfnvHsOpdUckmUlNTpBCMkQ"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 1/1] block/vmdk: Fix the
 endian problem of buf_len and lba
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QingFeng Hao <haoqf@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-stable@nongnu.org, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jIp7lcqOiLJfnvHsOpdUckmUlNTpBCMkQ
From: Max Reitz <mreitz@redhat.com>
To: QingFeng Hao <haoqf@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-stable@nongnu.org,
 borntraeger@de.ibm.com, cornelia.huck@de.ibm.com
Message-ID: <be77cb51-c3ad-d7a0-9c85-cb7aeaed31b0@redhat.com>
Subject: Re: [Qemu-block] [PATCH v3 1/1] block/vmdk: Fix the endian problem of
 buf_len and lba
References: <20161216052040.53067-1-haoqf@linux.vnet.ibm.com>
 <20161216052040.53067-2-haoqf@linux.vnet.ibm.com>
In-Reply-To: <20161216052040.53067-2-haoqf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 16.12.2016 06:20, QingFeng Hao wrote:
> The problem was triggered by qemu-iotests case 055. It failed when it
> was comparing the compressed vmdk image with original test.img.
>
> The cause is that buf_len in vmdk_write_extent wasn't converted to
> little-endian before it was stored to disk. But later vmdk_read_extent
> read it and converted it from little-endian to cpu endian.
> If the cpu is big-endian like s390, the problem will happen and
> the data length read by vmdk_read_extent will become invalid!
> The fix is to add the conversion in vmdk_write_extent, meanwhile,
> repair the endianness problem of lba field which shall also be converte=
d
> to little-endian before storing to disk.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
> Signed-off-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> ---
>  block/vmdk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, I've applied the patch to my block tree:

https://github.com/XanClic/qemu/commits/block

Max


--jIp7lcqOiLJfnvHsOpdUckmUlNTpBCMkQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliI0YgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ARbEIAJsuUbHBW+It6HK5eDuWXQWc8aXUvL86
rwx8tMOk60BGxg66Y0WYBcU11fY+/AJUkrojwKihjVgsn+3e6L5Xe7qjNXHVzI4D
1a1PPEuLcyoc7Gb2KPRZK4zDwpueQpz4Tcz9K4ZXTl949fmzESsnjSAiYQSAVO2V
BRbp0WAS8SFRLrHP0zU+NxbrnzEsx88Go7Z89o/93PFfgYjjVknrCY3ByABjWLJd
1L+SpALLgLFMj9T+/kArL79ivIQJE9QE8D3oP0zjDAJ3ljohlHiJvP5Dk8iiYHeP
hdNRSbODwFZK0E55k1JEOoOqn4uLBtInhINBCtNrkFiXBMMjMaSpRrE=
=cI+E
-----END PGP SIGNATURE-----

--jIp7lcqOiLJfnvHsOpdUckmUlNTpBCMkQ--
