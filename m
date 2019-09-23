Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45011C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:47:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17BE220578
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17BE220578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCPcS-0000FQ-UK
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 10:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41438)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iCPbK-00086V-OS
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:46:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iCPbJ-0000Lf-Dg
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:46:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35446)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iCPbE-0000KM-Qf; Mon, 23 Sep 2019 10:46:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EF9C1335DC;
 Mon, 23 Sep 2019 14:45:59 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A8045C1B5;
 Mon, 23 Sep 2019 14:45:54 +0000 (UTC)
Subject: Re: [PATCH v10 0/9] discard blockstats
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-block@nongnu.org
References: <20190923121737.83281-1-anton.nefedov@virtuozzo.com>
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
Message-ID: <eb6d9f9d-9b58-0d1e-6984-966520328f82@redhat.com>
Date: Mon, 23 Sep 2019 16:45:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923121737.83281-1-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EsWICaLpt4IikO8QcbGYDmV4ciRJvbclc"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Mon, 23 Sep 2019 14:46:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 den@virtuozzo.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EsWICaLpt4IikO8QcbGYDmV4ciRJvbclc
Content-Type: multipart/mixed; boundary="VqtlVnudfEAWI9HHjF4Rq3yltPPvzFDv7";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jsnow@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com,
 vsementsov@virtuozzo.com
Message-ID: <eb6d9f9d-9b58-0d1e-6984-966520328f82@redhat.com>
Subject: Re: [PATCH v10 0/9] discard blockstats
References: <20190923121737.83281-1-anton.nefedov@virtuozzo.com>
In-Reply-To: <20190923121737.83281-1-anton.nefedov@virtuozzo.com>

--VqtlVnudfEAWI9HHjF4Rq3yltPPvzFDv7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 23.09.19 14:17, Anton Nefedov wrote:
> v10:
>   - patch 3 commit message updated
>=20
> v9: https://lists.nongnu.org/archive/html/qemu-devel/2019-09/msg01190.h=
tml
>=20
> ----
>=20
> qmp query-blockstats provides stats info for write/read/flush ops.
>=20
> Patches 1-7 implement the similar for discard (unmap) command for scsi
> and ide disks.
> Discard stat "unmap_ops / unmap_bytes" is supposed to account the ops t=
hat
> have completed without an error.
>=20
> However, discard operation is advisory. Specifically,
>  - common block layer ignores ENOTSUP error code.
>    That might be returned if the block driver does not support discard,=

>    or discard has been configured to be ignored.
>  - format drivers such as qcow2 may ignore discard if they were configu=
red
>    to ignore that, or if the corresponding area is already marked unuse=
d
>    (unallocated / zero clusters).
>=20
> And what is actually useful is the number of bytes actually discarded
> down on the host filesystem.
> To achieve that, driver-specific statistics has been added to blockstat=
s
> (patch 9).
> With patch 8, file-posix driver accounts discard operations on its leve=
l too.
>=20
> query-blockstat result:
>=20
> (note the difference between blockdevice unmap and file discard stats. =
qcow2
> sends fewer ops down to the file as the clusters are actually unallocat=
ed
> on qcow2 level)
>=20
>     {
>       "device": "drive-scsi0-0-0-0",
>       "node-name": "#block159",
>       "stats": {
>>       "invalid_unmap_operations": 0,
>>       "failed_unmap_operations": 0,
>         "wr_highest_offset": 13411688448,
>         "rd_total_time_ns": 2859566315,
>         "rd_bytes": 103182336,
>         "rd_merged": 0,
>         "flush_operations": 19,
>         "invalid_wr_operations": 0,
>         "flush_total_time_ns": 23111608,
>         "failed_rd_operations": 0,
>         "failed_flush_operations": 0,
>         "invalid_flush_operations": 0,
>         "timed_stats": [
>          =20
>         ],
>         "wr_merged": 0,
>         "wr_bytes": 1702912,
>>       "unmap_bytes": 11954954240,
>>       "unmap_operations": 865,
>         "idle_time_ns": 2669508623,
>         "account_invalid": true,
>>       "unmap_total_time_ns": 19698002,
>         "wr_operations": 143,
>         "failed_wr_operations": 0,
>         "rd_operations": 4816,
>         "account_failed": true,
>>       "unmap_merged": 0,
>         "wr_total_time_ns": 1262686124,
>         "invalid_rd_operations": 0
>       },
>       "parent": {
>>       "driver-specific": {
>>         "discard-nb-failed": 0,
>>         "discard-bytes-ok": 720896,
>>         "driver": "file",
>>         "discard-nb-ok": 8
>>       },
>         "node-name": "#block009",
>         "stats": {
>         [..]
>         }
>       }
>     },
>     {
>       "device": "floppy0",
>=20
> Anton Nefedov (9):
>   qapi: group BlockDeviceStats fields
>   qapi: add unmap to BlockDeviceStats
>   block: add empty account cookie type
>   ide: account UNMAP (TRIM) operations
>   scsi: store unmap offset and nb_sectors in request struct
>   scsi: move unmap error checking to the complete callback
>   scsi: account unmap operations
>   file-posix: account discard operations
>   qapi: query-blockstat: add driver specific file-posix stats
>=20
>  qapi/block-core.json       | 81 ++++++++++++++++++++++++++++++++------=

>  include/block/accounting.h |  2 +
>  include/block/block.h      |  1 +
>  include/block/block_int.h  |  1 +
>  block.c                    |  9 +++++
>  block/accounting.c         |  6 +++
>  block/file-posix.c         | 54 ++++++++++++++++++++++++-
>  block/qapi.c               | 11 ++++++
>  hw/ide/core.c              | 12 ++++++
>  hw/scsi/scsi-disk.c        | 34 ++++++++++------
>  tests/qemu-iotests/227.out | 18 +++++++++
>  11 files changed, 206 insertions(+), 23 deletions(-)

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--VqtlVnudfEAWI9HHjF4Rq3yltPPvzFDv7--

--EsWICaLpt4IikO8QcbGYDmV4ciRJvbclc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2I2qEACgkQ9AfbAGHV
z0BjEAf+J6Q+dDGJ2z9oPY/kpvULNLS9bfiddZTJm2IrD9rQ7KsnwLWPE/7RMeye
tB2rSa6phy2PelfbXa+gyQQ2IGr00lfFkCFJpnhEg/ZRnR/MGkmulUANqURQI5ll
lwN8vBIQMqA9RV9sfpUzgaJZIiM6F6JSRgqw0Xrz4V91uL6ceOSYInPEQsWFSeNM
IRSqjum+NIwN2HZUKgrJtQVxJz/QcARb92J4ni1XKrZrLKKz69/7nDrmoRZZfwm4
p+uq1XBfQuvWYYFm7rXA3DtdFGmbcoSKdiuITQ099803jqhiRCpyMAUGdqPgRpkv
Yy46KIWFzMRR/RuJXHw5V7odPBdigg==
=6Pgs
-----END PGP SIGNATURE-----

--EsWICaLpt4IikO8QcbGYDmV4ciRJvbclc--

