Received: from eggs.gnu.org ([2001:4830:134:3::10]:49923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dLrHj-0000Un-Tq
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 09:27:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dLrHj-0000uS-2M
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 09:27:35 -0400
References: <1497509253-28941-1-git-send-email-sochin.jiang@huawei.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <49c65c67-5dcc-5822-c2f9-e1c3ff0181de@redhat.com>
Date: Fri, 16 Jun 2017 15:27:22 +0200
MIME-Version: 1.0
In-Reply-To: <1497509253-28941-1-git-send-email-sochin.jiang@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OSB4wgUjP8cIFiVCFBH3Lhjj723qGULDU"
Subject: Re: [Qemu-devel] [PATCH] fix: avoid an infinite loop or a dangling
 pointer problem in img_commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "sochin.jiang" <sochin.jiang@huawei.com>, jcody@redhat.com, kwolf@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, eric.fangyi@huawei.com, subo7@huawei.com, xieyingtai@huawei.com, lina.lulina@huawei.com, zhangshuai13@huawei.com, lizhengui@huawei.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OSB4wgUjP8cIFiVCFBH3Lhjj723qGULDU
From: Max Reitz <mreitz@redhat.com>
To: "sochin.jiang" <sochin.jiang@huawei.com>, jcody@redhat.com,
 kwolf@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, eric.fangyi@huawei.com,
 subo7@huawei.com, xieyingtai@huawei.com, lina.lulina@huawei.com,
 zhangshuai13@huawei.com, lizhengui@huawei.com
Message-ID: <49c65c67-5dcc-5822-c2f9-e1c3ff0181de@redhat.com>
Subject: Re: [PATCH] fix: avoid an infinite loop or a dangling pointer problem
 in img_commit
References: <1497509253-28941-1-git-send-email-sochin.jiang@huawei.com>
In-Reply-To: <1497509253-28941-1-git-send-email-sochin.jiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-15 08:47, sochin.jiang wrote:
> From: "sochin.jiang" <sochin.jiang@huawei.com>
>=20
> img_commit could fall into an infinite loop calling run_block_job() if
> its blockjob fails on any I/O error, fix this already known problem.
>=20
> Signed-off-by: sochin.jiang <sochin.jiang@huawei.com>
> ---
>  blockjob.c               |  4 ++--
>  include/block/blockjob.h | 18 ++++++++++++++++++
>  qemu-img.c               | 20 +++++++++++++-------
>  3 files changed, 33 insertions(+), 9 deletions(-)

Thanks! I've applied the patch to my block branch:

https://github.com/XanClic/qemu/commits/block

PS: In the future, please change the subject prefix to "PATCH v2" (etc.)
for updated versions of a patch.

Max


--OSB4wgUjP8cIFiVCFBH3Lhjj723qGULDU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZQ9y6EhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQA/2
B/42e0NItPvBZU3/0g3eNmh2WDlgFu2TzCgSe4B0afUAkZZXDLUg5vghEiDMr2jw
aXszTlcT9kOAax3TL/NMKHrtwgw9XN5FyYIX6KbmZk/yaBMvpOpLHUoXdsD7F+Qn
RkcBjvz9CvQB+nHjJIEjyEEOcTXk8oK7ewpfhq+ek1PNMJUycwtI+YHypQMlqyVg
5CN0iHW8e0VYe7ZHDa6ybLTovc55lu6+EfoaH1AKOBQc0H70nOtpRp7VnXv1BdrM
7Yp6maOa7oxRD1k+5IHlB+mF5hA69XfNBO7SMmZv8M9q4AeqZu3thdREcRLNMQ8F
LppS3y9m7AwcFyeUDtzY2GPp
=ZtTZ
-----END PGP SIGNATURE-----

--OSB4wgUjP8cIFiVCFBH3Lhjj723qGULDU--
