Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54036C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 11:44:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BD25216F4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 11:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BD25216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i02Yj-0000VZ-7g
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 07:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i02Xp-0008J1-35
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 07:43:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i02Xo-00038s-33
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 07:43:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55940)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i02Xl-000379-Hy; Tue, 20 Aug 2019 07:43:17 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C8324315C013;
 Tue, 20 Aug 2019 11:43:16 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9274418B55;
 Tue, 20 Aug 2019 11:43:15 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20190819185602.4267-1-mreitz@redhat.com>
 <20190819185602.4267-5-mreitz@redhat.com>
 <85d04ded-0bf6-ab67-7af9-cc97f30ad366@redhat.com>
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
Message-ID: <9f41a69e-317e-b14b-30e9-59dadadb3c45@redhat.com>
Date: Tue, 20 Aug 2019 13:43:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <85d04ded-0bf6-ab67-7af9-cc97f30ad366@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aS42y3eB6W9xjs1HgXKAIRNF7INJxlQSE"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 20 Aug 2019 11:43:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 04/16] qcow2: Keep unknown extra
 snapshot data
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
--aS42y3eB6W9xjs1HgXKAIRNF7INJxlQSE
Content-Type: multipart/mixed; boundary="8MLLZuDV6Wcm8FNSTEyAg6vbB17h7sWHy";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <9f41a69e-317e-b14b-30e9-59dadadb3c45@redhat.com>
Subject: Re: [PATCH v2 04/16] qcow2: Keep unknown extra snapshot data
References: <20190819185602.4267-1-mreitz@redhat.com>
 <20190819185602.4267-5-mreitz@redhat.com>
 <85d04ded-0bf6-ab67-7af9-cc97f30ad366@redhat.com>
In-Reply-To: <85d04ded-0bf6-ab67-7af9-cc97f30ad366@redhat.com>

--8MLLZuDV6Wcm8FNSTEyAg6vbB17h7sWHy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19.08.19 21:34, Eric Blake wrote:
> On 8/19/19 1:55 PM, Max Reitz wrote:
>> The qcow2 specification says to ignore unknown extra data fields in
>> snapshot table entries.  Currently, we discard it whenever we update t=
he
>> image, which is a bit different from "ignore".
>>
>> This patch makes the qcow2 driver keep all unknown extra data fields
>> when updating an image's snapshot table.
>>
>=20
>> @@ -80,31 +80,53 @@ int qcow2_read_snapshots(BlockDriverState *bs, Err=
or **errp)
>>          sn->date_sec =3D be32_to_cpu(h.date_sec);
>>          sn->date_nsec =3D be32_to_cpu(h.date_nsec);
>>          sn->vm_clock_nsec =3D be64_to_cpu(h.vm_clock_nsec);
>> -        extra_data_size =3D be32_to_cpu(h.extra_data_size);
>> +        sn->extra_data_size =3D be32_to_cpu(h.extra_data_size);
>> =20
>>          id_str_size =3D be16_to_cpu(h.id_str_size);
>>          name_size =3D be16_to_cpu(h.name_size);
>> =20
>> -        /* Read extra data */
>> +        if (sn->extra_data_size > QCOW_MAX_SNAPSHOT_EXTRA_DATA) {
>> +            ret =3D -EFBIG;
>> +            error_setg(errp, "Too much extra metadata in snapshot tab=
le "
>> +                       "entry %i", i);
>> +            goto fail;
>=20
> We fail if extra_data_size is > 1024...
>=20
>=20
>> +        if (sn->extra_data_size > sizeof(extra)) {
>> +            /* Store unknown extra data */
>> +            size_t unknown_extra_data_size =3D
>> +                sn->extra_data_size - sizeof(extra);
>> +
>=20
> But read at most 1008 bytes into sn->unknown_extra_data.
>=20
>> @@ -234,6 +257,22 @@ static int qcow2_write_snapshots(BlockDriverState=
 *bs)
>>          }
>>          offset +=3D sizeof(extra);
>> =20
>> +        if (sn->extra_data_size > sizeof(extra)) {
>> +            size_t unknown_extra_data_size =3D
>> +                sn->extra_data_size - sizeof(extra);
>> +
>> +            /* qcow2_read_snapshots() ensures no unbounded allocation=
 */
>> +            assert(unknown_extra_data_size <=3D BDRV_REQUEST_MAX_BYTE=
S);
>=20
> So this assertion is quite loose in what it permits; tighter would be
>=20
> assert(unknown_extra_data_size <=3D QCOW_MAX_SNAPSHOT_EXTRA_DATA -
> sizeof(extra))

As I said in the last version, I have this assertion here just because
of the following bdrv_pwrite(); so all we need to assert is that it fits
BDRV_REQUEST_MAX_BYTES (which it clearly does, as you say).

Max


--8MLLZuDV6Wcm8FNSTEyAg6vbB17h7sWHy--

--aS42y3eB6W9xjs1HgXKAIRNF7INJxlQSE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1b3NIACgkQ9AfbAGHV
z0AclQf9GWUusiyxUta87jpQGsqFXEJX0YlxyxlvWrzREtWf70mn8T6MvKzlz2aH
mzq1LVToahYYORJlf7chwRX0aeo+OFINFqPVf7ecrFjXylQHqIT+JpIpb+xwTkn7
WAKIQ8omiJzaVP1SMrrQJJFOKCZ8kz56tXbt1twI0ZWxtQqZzLal3ajycWFyctSx
DbfKpL1FQe2Wr6g/avdI+LeGOds//I61h9yJ5S5uVV/RTaN9ufs2RVDhzR0ifg6q
8E1mEsTpnia4Gs5Mme069d4u/wlWcVkF95P26S2FfkW1wwatIRNLvxiTD0PGCvAq
/c+jMCGmrCTEWntr47N7ZCDED+l1pA==
=Y9Tg
-----END PGP SIGNATURE-----

--aS42y3eB6W9xjs1HgXKAIRNF7INJxlQSE--

