Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F5FC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 11:47:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADEBE22D6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 11:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADEBE22D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i02c3-00029Y-UC
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 07:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56778)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i02b3-0001by-FP
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 07:46:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i02b2-0004ju-J9
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 07:46:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40844)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i02b0-0004iO-H7; Tue, 20 Aug 2019 07:46:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 41B9F307D962;
 Tue, 20 Aug 2019 11:46:37 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 083D318EED;
 Tue, 20 Aug 2019 11:46:35 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20190819185602.4267-1-mreitz@redhat.com>
 <20190819185602.4267-11-mreitz@redhat.com>
 <6dbb0e2f-8745-fc05-1a88-8047def4d88f@redhat.com>
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
Message-ID: <ea3814ad-b837-82b9-403c-f15f6736d788@redhat.com>
Date: Tue, 20 Aug 2019 13:46:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6dbb0e2f-8745-fc05-1a88-8047def4d88f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xTMOEu6BjSCjqTjUVhZm77SLrgOs6uI7G"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 20 Aug 2019 11:46:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 10/16] qcow2: Fix broken snapshot table
 entries
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xTMOEu6BjSCjqTjUVhZm77SLrgOs6uI7G
Content-Type: multipart/mixed; boundary="8eWrudYp7MqmcsEMYsemVrK8g6qbRvPro";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <ea3814ad-b837-82b9-403c-f15f6736d788@redhat.com>
Subject: Re: [PATCH v2 10/16] qcow2: Fix broken snapshot table entries
References: <20190819185602.4267-1-mreitz@redhat.com>
 <20190819185602.4267-11-mreitz@redhat.com>
 <6dbb0e2f-8745-fc05-1a88-8047def4d88f@redhat.com>
In-Reply-To: <6dbb0e2f-8745-fc05-1a88-8047def4d88f@redhat.com>

--8eWrudYp7MqmcsEMYsemVrK8g6qbRvPro
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19.08.19 21:37, Eric Blake wrote:
> On 8/19/19 1:55 PM, Max Reitz wrote:
>> The only case where we currently reject snapshot table entries is when=

>> they have too much extra data.  Fix them with qemu-img check -r all by=

>> counting it as a corruption, reducing their extra_data_size, and then
>> letting qcow2_check_fix_snapshot_table() do the rest.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/qcow2-snapshot.c | 67 +++++++++++++++++++++++++++++++++++------=
-
>>  1 file changed, 56 insertions(+), 11 deletions(-)
>>
>=20
>> @@ -64,6 +80,8 @@ int qcow2_read_snapshots(BlockDriverState *bs, Error=
 **errp)
>>      s->snapshots =3D g_new0(QCowSnapshot, s->nb_snapshots);
>> =20
>>      for(i =3D 0; i < s->nb_snapshots; i++) {
>> +        bool truncate_unknown_extra_data =3D false;
>=20
> Worth adding space after 'for' while in the vicinity?

Hm, it doesn=E2=80=99t bother me enough, at least.  It=E2=80=99d probably=
 be better to
just fix all occurrences of that in block/qcow2* in one patch (and there
are a few indeed).  That is, if someone is sufficiently bothered by it. ;=
-)

Max


--8eWrudYp7MqmcsEMYsemVrK8g6qbRvPro--

--xTMOEu6BjSCjqTjUVhZm77SLrgOs6uI7G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1b3ZoACgkQ9AfbAGHV
z0B3GAf7BcK1833DIXoeL7rw5GyQPTnGy9geMYdvUO3mbnTBeo0mYutupsVpmnMg
9RBz+V1608rm0Rt6gSFgQr99m1rp4Dz+1VykTmvdZHkEaH9Zhgibp35tE+wjF1rD
1qWxf7iPpfq2nQ8LG1KJztD+fYUjP8w+NloPwqdDfWzV/Y/P+z+rSagkpxcD33um
rut2iSQ5oZUQtBcocl0uhIIIBF8AB9QU1C3N9ldPF2qg6DgEZ6A5Jyz/1YwKiI+j
hm27HHbg2NGmPSDq3i0nNpmdHWAvxPaH6bo3f+tdPEQtV4N+Rzn1cM5WwLb0qY0/
3iH3gDrRQ283MI5K7xPB/dQbzpev9g==
=GurR
-----END PGP SIGNATURE-----

--xTMOEu6BjSCjqTjUVhZm77SLrgOs6uI7G--

