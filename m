Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B19EC35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 16:02:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B08321A4C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 16:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B08321A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFh5K-0003Nb-4g
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 12:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFh26-0002Cy-0o
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 11:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFh24-00007J-18
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 11:59:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44406)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFh1y-000050-Uc; Wed, 02 Oct 2019 11:59:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C80DF3084025;
 Wed,  2 Oct 2019 15:59:09 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F0A1608C0;
 Wed,  2 Oct 2019 15:58:58 +0000 (UTC)
Subject: Re: [PATCH v2 0/6] qcow2: advanced compression options
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
References: <157002883347.27524.13510585852065141081@8230166b0665>
 <75c7393b-5ad0-66d5-9592-388f0260a0de@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
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
Message-ID: <5106e252-43d4-0ed5-ee65-a71a5e569bf7@redhat.com>
Date: Wed, 2 Oct 2019 17:58:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <75c7393b-5ad0-66d5-9592-388f0260a0de@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0L7e6NzqG4BljDKMooIiS2s5cskAJVqAh"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Wed, 02 Oct 2019 15:59:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "patchew-devel@redhat.com" <patchew-devel@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0L7e6NzqG4BljDKMooIiS2s5cskAJVqAh
Content-Type: multipart/mixed; boundary="eVydxOMXw8MhByKTvqvP8WLLNaRhARhOw"

--eVydxOMXw8MhByKTvqvP8WLLNaRhARhOw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02.10.19 17:35, Vladimir Sementsov-Ogievskiy wrote:
> Hi,
>=20
> 02.10.2019 18:07, no-reply@patchew.org wrote:
>> Patchew URL: https://patchew.org/QEMU/1570026166-748566-1-git-send-ema=
il-andrey.shinkevich@virtuozzo.com/
>>
>>
>>
>> Hi,
>>
>> This series failed the docker-quick@centos7 build test. Please find th=
e testing commands and
>> their output below. If you have Docker installed, you can probably rep=
roduce it
>> locally.
>>
>> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
>> #!/bin/bash
>> make docker-image-centos7 V=3D1 NETWORK=3D1
>> time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D14 NETWORK=3D1
>> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>>
>>    CC      block/parallels.o
>>    CC      block/blklogwrites.o
>>    CC      block/block-backend.o
>> /tmp/qemu-test/src/block/qcow2.c:4077:64: error: unknown type name 'Ai=
oTask'
>>   static coroutine_fn int qcow2_co_pwritev_compressed_task_entry(AioTa=
sk *task)
>>                                                                  ^
>> /tmp/qemu-test/src/block/qcow2.c: In function 'qcow2_co_pwritev_compre=
ssed_part':
>> /tmp/qemu-test/src/block/qcow2.c:4098:5: error: unknown type name 'Aio=
TaskPool'
>>       AioTaskPool *aio =3D NULL;
>>       ^
>=20
>=20
> Who knows, what is wrong with it? Seems patchew ignores Based-on: tag i=
n cover-letter,
> which is written as "Based-on: https://github.com/XanClic/qemu.git bloc=
k"...
> These new types and functions are defined in Max's block branch.

It would be news to me if Patchew supported such URLs.  I just put it
into my cover letter for human reviewers...

(Actually, it would be news to me if Patchew supported Based-on at all
reliably...)

Max


--eVydxOMXw8MhByKTvqvP8WLLNaRhARhOw--

--0L7e6NzqG4BljDKMooIiS2s5cskAJVqAh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2UyUEACgkQ9AfbAGHV
z0C9yQf/aVAPJWUuJWcL0RhF29wd9SqfSFAWl4QdunhXBiFNaMrqINSZBFDOCBGG
0U7D4ACmxIbrl9sbl8ibf35lG/6XyDdNC6kv+KmyHUxo8h4N4ET4st2siJZ2B7Bk
KnelLYzLBHCyXXzXPCUiI5RGPSrP2X3MuOyLm0iX4+svJq1tO8LQQY+GrZ/HJi80
0wpaF0xWJZXea1S5xuI/RmIjv3A/1Ha7R6VWc03MxNK9bEmmgwlgwTqfsPYnAIKI
dVPqtYG8QsuNWIZBaavJ2qrUfzrugK27WaMYtjP/wlubseJJLKJaVcmVi1iJ2mtR
99dlWN/O/f4cb6/plWYFt542KQ8UGw==
=e5Io
-----END PGP SIGNATURE-----

--0L7e6NzqG4BljDKMooIiS2s5cskAJVqAh--

