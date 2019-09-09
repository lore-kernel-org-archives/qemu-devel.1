Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B0EC00307
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 08:10:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25ADF21920
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 08:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25ADF21920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7El7-0000dn-Bz
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 04:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49737)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7EkM-00005J-Lu
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 04:10:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7EkL-00054s-Di
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 04:10:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55056)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7EkI-00053c-Hq; Mon, 09 Sep 2019 04:09:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 80BB518CB8E4;
 Mon,  9 Sep 2019 08:09:57 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-179.ams2.redhat.com
 [10.36.116.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A2B595D6A7;
 Mon,  9 Sep 2019 08:09:55 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-12-mreitz@redhat.com>
 <20190905131129.GB4911@localhost.localdomain>
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
Message-ID: <f95ba860-55c4-6436-b3d4-acb7aabc001a@redhat.com>
Date: Mon, 9 Sep 2019 10:09:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905131129.GB4911@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nixpVsvusBQEuLQyq5pPTMIZ5mzMnxnBH"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Mon, 09 Sep 2019 08:09:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 11/42] block: Add
 bdrv_supports_compressed_writes()
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nixpVsvusBQEuLQyq5pPTMIZ5mzMnxnBH
Content-Type: multipart/mixed; boundary="7qRg2VnbPlqX2fVp0nZ6p4mDrcu2TNwyd";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f95ba860-55c4-6436-b3d4-acb7aabc001a@redhat.com>
Subject: Re: [PATCH v6 11/42] block: Add bdrv_supports_compressed_writes()
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-12-mreitz@redhat.com>
 <20190905131129.GB4911@localhost.localdomain>
In-Reply-To: <20190905131129.GB4911@localhost.localdomain>

--7qRg2VnbPlqX2fVp0nZ6p4mDrcu2TNwyd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.09.19 15:11, Kevin Wolf wrote:
> Am 09.08.2019 um 18:13 hat Max Reitz geschrieben:
>> Filters cannot compress data themselves but they have to implement
>> .bdrv_co_pwritev_compressed() still (or they cannot forward compressed=

>> writes).  Therefore, checking whether
>> bs->drv->bdrv_co_pwritev_compressed is non-NULL is not sufficient to
>> know whether the node can actually handle compressed writes.  This
>> function looks down the filter chain to see whether there is a
>> non-filter that can actually convert the compressed writes into
>> compressed data (and thus normal writes).
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
> Should patches 2 and 3 that add the .bdrv_co_pwritev_compressed()
> callback to filter drivers come only after this one?

Why not.

> And should we also
> support it in the mirror filter?

Hm.  AFAIU, compressed writes have very limited use.  You can basically
only use them when writing to a new image (where you=E2=80=99d never writ=
e
anywhere you=E2=80=99ve already written something to), i.e. for qemu-img =
convert
or the backup target.  It makes sense to blockdev-backup to throttle, so
that=E2=80=99s why it should be implemented there.  I don=E2=80=99t reall=
y see how it
would make sense for mirror.

OTOH, it doesn=E2=80=99t make sense for COR either.  And it isn=E2=80=99t=
 that hard.
Now I don=E2=80=99t have a strong preference for either dropping the COR =
patch
or adding it to mirror as well...

Max


--7qRg2VnbPlqX2fVp0nZ6p4mDrcu2TNwyd--

--nixpVsvusBQEuLQyq5pPTMIZ5mzMnxnBH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl12CNEACgkQ9AfbAGHV
z0AMIQf/cTthBastzJ2Z62fDneVWVOPEdVin46ZChtH9vXJdpWU63f1YeHQwKMjI
fP6Sz5JPgYMzW1b1aK29sCC5M2q2xnZIRZznMtvVE9glqJA2qCNgpfzqlsU//G2u
athqwOZlN11LvojO2POG45KYeawUNlrmgJpFY5Sp45ejanCRajvOtLQ04GeZSoGP
Y6+H3HCLCe3GOEBaxrq9y7bR3NfnU2PG/sdpVfPhx38/vpcPhSHsoDjr9c6WfKtT
yyDNe6pjUc/zBo657QoXsPYu2btjMRCLo3h8b0aMj9lf7VVw9QU0K+jGkIDheU1O
Mgr93tDOslchjSWQgrEv3Ya5aPx9fQ==
=FhhJ
-----END PGP SIGNATURE-----

--nixpVsvusBQEuLQyq5pPTMIZ5mzMnxnBH--

