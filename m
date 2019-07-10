Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883F6C74A35
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 21:08:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58966208C4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 21:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58966208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlJpC-000386-VS
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 17:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43740)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hlJoV-0002KD-S6
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 17:07:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hlJoU-0006io-N1
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 17:07:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53820)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hlJoR-0006df-OX; Wed, 10 Jul 2019 17:07:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5CB6983F3C;
 Wed, 10 Jul 2019 21:07:37 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1303660A98;
 Wed, 10 Jul 2019 21:07:34 +0000 (UTC)
To: Michal Privoznik <mprivozn@redhat.com>, qemu-block@nongnu.org
References: <927aae40b617ba7d4b6c7ffe74e6d7a2595f8e86.1562770546.git.mprivozn@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <56351995-0225-d30e-a683-5bf2b0660073@redhat.com>
Date: Wed, 10 Jul 2019 23:07:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <927aae40b617ba7d4b6c7ffe74e6d7a2595f8e86.1562770546.git.mprivozn@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dpheP3GZpSBq22MwvefvpzxvaGPvzmXPX"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Wed, 10 Jul 2019 21:07:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] nvme: Set number of queues later in
 nvme_init()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dpheP3GZpSBq22MwvefvpzxvaGPvzmXPX
Content-Type: multipart/mixed; boundary="DapuK65ZH4ZMAt4DasegoRv3oPTe0gspG";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org
Message-ID: <56351995-0225-d30e-a683-5bf2b0660073@redhat.com>
Subject: Re: [PATCH] nvme: Set number of queues later in nvme_init()
References: <927aae40b617ba7d4b6c7ffe74e6d7a2595f8e86.1562770546.git.mprivozn@redhat.com>
In-Reply-To: <927aae40b617ba7d4b6c7ffe74e6d7a2595f8e86.1562770546.git.mprivozn@redhat.com>

--DapuK65ZH4ZMAt4DasegoRv3oPTe0gspG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.07.19 16:57, Michal Privoznik wrote:
> When creating the admin queue in nvme_init() the variable that
> holds the number of queues created is modified before actual
> queue creation. This is a problem because if creating the queue
> fails then the variable is left in inconsistent state. This was
> actually observed when I tried to hotplug a nvme disk. The
> control got to nvme_file_open() which called nvme_init() which
> failed and thus nvme_close() was called which in turn called
> nvme_free_queue_pair() with queue being NULL. This lead to an
> instant crash:
>=20
>   #0  0x000055d9507ec211 in nvme_free_queue_pair (bs=3D0x55d952ddb880, =
q=3D0x0) at block/nvme.c:164
>   #1  0x000055d9507ee180 in nvme_close (bs=3D0x55d952ddb880) at block/n=
vme.c:729
>   #2  0x000055d9507ee3d5 in nvme_file_open (bs=3D0x55d952ddb880, option=
s=3D0x55d952bb1410, flags=3D147456, errp=3D0x7ffd8e19e200) at block/nvme.=
c:781
>   #3  0x000055d9507629f3 in bdrv_open_driver (bs=3D0x55d952ddb880, drv=3D=
0x55d95109c1e0 <bdrv_nvme>, node_name=3D0x0, options=3D0x55d952bb1410, op=
en_flags=3D147456, errp=3D0x7ffd8e19e310) at block.c:1291
>   #4  0x000055d9507633d6 in bdrv_open_common (bs=3D0x55d952ddb880, file=
=3D0x0, options=3D0x55d952bb1410, errp=3D0x7ffd8e19e310) at block.c:1551
>   #5  0x000055d950766881 in bdrv_open_inherit (filename=3D0x0, referenc=
e=3D0x0, options=3D0x55d952bb1410, flags=3D32768, parent=3D0x55d9538ce420=
, child_role=3D0x55d950eaade0 <child_file>, errp=3D0x7ffd8e19e510) at blo=
ck.c:3063
>   #6  0x000055d950765ae4 in bdrv_open_child_bs (filename=3D0x0, options=
=3D0x55d9541cdff0, bdref_key=3D0x55d950af33aa "file", parent=3D0x55d9538c=
e420, child_role=3D0x55d950eaade0 <child_file>, allow_none=3Dtrue, errp=3D=
0x7ffd8e19e510) at block.c:2712
>   #7  0x000055d950766633 in bdrv_open_inherit (filename=3D0x0, referenc=
e=3D0x0, options=3D0x55d9541cdff0, flags=3D0, parent=3D0x0, child_role=3D=
0x0, errp=3D0x7ffd8e19e908) at block.c:3011
>   #8  0x000055d950766dba in bdrv_open (filename=3D0x0, reference=3D0x0,=
 options=3D0x55d953d00390, flags=3D0, errp=3D0x7ffd8e19e908) at block.c:3=
156
>   #9  0x000055d9507cb635 in blk_new_open (filename=3D0x0, reference=3D0=
x0, options=3D0x55d953d00390, flags=3D0, errp=3D0x7ffd8e19e908) at block/=
block-backend.c:389
>   #10 0x000055d950465ec5 in blockdev_init (file=3D0x0, bs_opts=3D0x55d9=
53d00390, errp=3D0x7ffd8e19e908) at blockdev.c:602
>=20
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---
>  block/nvme.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--DapuK65ZH4ZMAt4DasegoRv3oPTe0gspG--

--dpheP3GZpSBq22MwvefvpzxvaGPvzmXPX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0mU5UACgkQ9AfbAGHV
z0Abrwf+JeKCTFmgU5Q6vtsYclvApgWpYe5Sjnp6TopBnqARdJIma9BgJ9GtrluE
xEgPkDiIqC5YN4IB8NFMZRgoF+saW+HMjiLeKIULCV4Bh63aPX1+SReeB2oFgG8r
3GxGRqFrQxFzU2s5S/DdFY0Hf3OtioN1co2mAFdkmG5RQjYNDQJ73PnONrBUK3ES
90A2kx9oTF40iG+wRcQPnurRJ0v9XoQ5gQ3B4xE5NfGhQGc+y/pnm64Nnnt/c+sb
PyIhsN0xLmlBzDSr0Wc86x+8aHjaWx3em2C0F4sMw/TBE3UWKzkAn1BkGHl1ZVFt
s6AmWFFyo2p2Uy7IBMTaxTOeXZvCPw==
=WBYD
-----END PGP SIGNATURE-----

--dpheP3GZpSBq22MwvefvpzxvaGPvzmXPX--

