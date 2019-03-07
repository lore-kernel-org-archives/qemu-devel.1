Received: from eggs.gnu.org ([209.51.188.92]:54144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1w6M-0001RR-KP
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:42:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1w6L-0007Jf-TX
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:42:34 -0500
References: <1551949966-20092-1-git-send-email-lizhengui@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6fe0e2cf-cff9-6884-2a71-ec506f00c8da@redhat.com>
Date: Thu, 7 Mar 2019 10:42:26 -0600
MIME-Version: 1.0
In-Reply-To: <1551949966-20092-1-git-send-email-lizhengui@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oiE6HuPToWrDLS9YKN93olLc3QhPHuyfd"
Subject: Re: [Qemu-devel] [PATCH] scsi-disk: Fix crash if request is invaild
 or disk is no medium
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhengui li <lizhengui@huawei.com>, pbonzini@redhat.com, stefanha@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, eric.fangyi@huawei.com, qemu-devel@nongnu.org, zhengxiang9@huawei.com, wangjie88@huawei.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oiE6HuPToWrDLS9YKN93olLc3QhPHuyfd
From: Eric Blake <eblake@redhat.com>
To: Zhengui li <lizhengui@huawei.com>, pbonzini@redhat.com,
 stefanha@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, eric.fangyi@huawei.com, qemu-devel@nongnu.org,
 zhengxiang9@huawei.com, wangjie88@huawei.com
Message-ID: <6fe0e2cf-cff9-6884-2a71-ec506f00c8da@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] scsi-disk: Fix crash if request is invaild
 or disk is no medium
References: <1551949966-20092-1-git-send-email-lizhengui@huawei.com>
In-Reply-To: <1551949966-20092-1-git-send-email-lizhengui@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/7/19 3:12 AM, Zhengui li wrote:
> From: Zhengui Li <lizhengui@huawei.com>
>=20
> Qemu will crash with the assertion error that "assert(r->req.aiocb !=3D=

> NULL)" in scsi_read_complete if request is invaild or disk is no medium=
=2E

s/invaild/invalid/

> The error is below:
> qemu-kvm: hw/scsi/scsi_disk.c:299: scsi_read_complete: Assertion
> `r->req.aiocb !=3D NULL' failed.
>=20
> This patch add a funtion scsi_read_complete_noio to fix it.
>=20

s/funtion/function/

> Signed-off-by: Zhengui Li <lizhengui@huawei.com>
> ---
>  hw/scsi/scsi-disk.c | 37 ++++++++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 13 deletions(-)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--oiE6HuPToWrDLS9YKN93olLc3QhPHuyfd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyBSfIACgkQp6FrSiUn
Q2puHQf/Y9AZH8qFLgcFkiSXsFu32FDF/am1dcTH41+kFam4sB5G2F5CQ+VvL4rL
QpPuZldITWJRH+wlMPOxVwr0wo79Hn2tYyoLG9xCCPlIJHOf/C53kChygUb8HM8r
Uo1uxtEGJtjGynGCu+jyH/+JUalNgJPFst9KRZRUaaq15MqdjeO8yroBRzCmH6F3
LkrtjPkdS9RBqmaA32/puFTZYJE3FEPzjnE9XRu394nagWT5SCZgfwa11BILN/0w
cl0N6rAcZkbzgD4FmeFAOEtDlNMRQa4hcvsi8yfwXYnNGNqKnYFOwNX3SnBHLdFp
G7LK2zGk0fViHFneJXKiYUFZq8Ohhw==
=L9F7
-----END PGP SIGNATURE-----

--oiE6HuPToWrDLS9YKN93olLc3QhPHuyfd--
