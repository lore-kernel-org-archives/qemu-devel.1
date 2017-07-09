Received: from eggs.gnu.org ([2001:4830:134:3::10]:43095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUKNZ-0004bT-A0
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 18:08:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUKNY-0007oR-DI
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 18:08:37 -0400
References: <20170707143028.692-1-pbutsykin@virtuozzo.com>
	<20170707143028.692-4-pbutsykin@virtuozzo.com>
	<15af9be5-dbc2-cac1-31b4-432492fb7477@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <61dc37ba-62f8-922e-a4d0-b684f2303706@redhat.com>
Date: Mon, 10 Jul 2017 00:08:25 +0200
MIME-Version: 1.0
In-Reply-To: <15af9be5-dbc2-cac1-31b4-432492fb7477@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MCQ71cR9AK7qvV3SOcAR1mUOfEut4Cnjh"
Subject: Re: [Qemu-devel] [PATCH v3 3/4] qcow2: add shrink image support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MCQ71cR9AK7qvV3SOcAR1mUOfEut4Cnjh
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, Pavel Butsykin <pbutsykin@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, den@openvz.org
Message-ID: <61dc37ba-62f8-922e-a4d0-b684f2303706@redhat.com>
Subject: Re: [PATCH v3 3/4] qcow2: add shrink image support
References: <20170707143028.692-1-pbutsykin@virtuozzo.com>
 <20170707143028.692-4-pbutsykin@virtuozzo.com>
 <15af9be5-dbc2-cac1-31b4-432492fb7477@redhat.com>
In-Reply-To: <15af9be5-dbc2-cac1-31b4-432492fb7477@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-07-07 23:26, Eric Blake wrote:
> On 07/07/2017 09:30 AM, Pavel Butsykin wrote:
>> This patch add shrinking of the image file for qcow2. As a result, thi=
s allows
>> us to reduce the virtual image size and free up space on the disk with=
out
>> copying the image. Image can be fragmented and shrink is done by punch=
ing holes
>> in the image file.
>>
>> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
>> ---
>>  block/qcow2-cluster.c  |  40 +++++++++++++++++++
>>  block/qcow2-refcount.c | 103 ++++++++++++++++++++++++++++++++++++++++=
+++++++++
>>  block/qcow2.c          |  42 +++++++++++++++-----
>>  block/qcow2.h          |  14 +++++++
>>  qapi/block-core.json   |   3 +-
>>  5 files changed, 191 insertions(+), 11 deletions(-)
>>
>=20
>> +++ b/qapi/block-core.json
>> @@ -2372,7 +2372,8 @@
>>              'cluster_alloc_bytes', 'cluster_free', 'flush_to_os',
>>              'flush_to_disk', 'pwritev_rmw_head', 'pwritev_rmw_after_h=
ead',
>>              'pwritev_rmw_tail', 'pwritev_rmw_after_tail', 'pwritev',
>> -            'pwritev_zero', 'pwritev_done', 'empty_image_prepare' ] }=

>> +            'pwritev_zero', 'pwritev_done', 'empty_image_prepare',
>> +            'l1_shrink_write_table', 'l1_shrink_free_l2_clusters' ] }=

>=20
> Missing documentation for the additions.

Well, I'd say there's missing documentation for everything, so....

Max


--MCQ71cR9AK7qvV3SOcAR1mUOfEut4Cnjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZYqlaEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQMg/
CACIlsOAJH1LqAP5ODBfBurm/gCFnnhjKYAHA2BHMC2FPlbQOvbwlyMCA/JZaOR4
rFRhv/uRNmizObX3rop2bw8wO0Xlx5fe7Lq9zZEBHwpjTAC7PaMYF0iEuXwcA7h8
ZE3Lo9vxc0p0O5XqHStWWqD7BJo7FN65PgmmDfc511k2L3YY9w/8WBbsVzlJgr4p
Ivl6U6QwwdEeedO5aw14YoC41UmvNGl+MkF1FTf66+Mgbcv6rJupHgM1nzHR8FX/
ZU20Ga9xQkOEmn3G5TtMHyfiVLHts3Cdp8L76uxsEwLiZB88+CQbbXREaHUi6HbE
4OQIaXNZN1+4NtnUMlQ4oEt/
=bwHC
-----END PGP SIGNATURE-----

--MCQ71cR9AK7qvV3SOcAR1mUOfEut4Cnjh--
