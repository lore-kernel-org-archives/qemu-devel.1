Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1EFC31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 16:03:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E11B2187F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 16:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E11B2187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39862 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdd3t-0005pV-Kh
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 12:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51514)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hdczi-0003ku-SW
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 11:59:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hdczh-0005o5-ID
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 11:59:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53018)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hdczb-0005hK-LI; Wed, 19 Jun 2019 11:59:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8CD7AF74AE;
 Wed, 19 Jun 2019 15:59:05 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-121.ams2.redhat.com
 [10.36.116.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 66D4F60DDF;
 Wed, 19 Jun 2019 15:59:02 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-34-mreitz@redhat.com>
 <2670e61d-6c9b-9499-8e41-01c294379e47@virtuozzo.com>
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
Message-ID: <761c245d-3bb3-5fb3-21e4-0085caaffd2a@redhat.com>
Date: Wed, 19 Jun 2019 17:59:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <2670e61d-6c9b-9499-8e41-01c294379e47@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TMm68YVbdx51DVC82A4rsXB1gYYFOtHhW"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Wed, 19 Jun 2019 15:59:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 33/42] blockdev: Fix active commit choice
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TMm68YVbdx51DVC82A4rsXB1gYYFOtHhW
Content-Type: multipart/mixed; boundary="u8O6Uywk09yJb06jfYQujAKRWbkmfYvvi";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <761c245d-3bb3-5fb3-21e4-0085caaffd2a@redhat.com>
Subject: Re: [PATCH v5 33/42] blockdev: Fix active commit choice
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-34-mreitz@redhat.com>
 <2670e61d-6c9b-9499-8e41-01c294379e47@virtuozzo.com>
In-Reply-To: <2670e61d-6c9b-9499-8e41-01c294379e47@virtuozzo.com>

--u8O6Uywk09yJb06jfYQujAKRWbkmfYvvi
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19.06.19 11:31, Vladimir Sementsov-Ogievskiy wrote:
> 13.06.2019 1:09, Max Reitz wrote:
>> We have to perform an active commit whenever the top node has a parent=

>> that has taken the WRITE permission on it.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   blockdev.c | 24 +++++++++++++++++++++---
>>   1 file changed, 21 insertions(+), 3 deletions(-)
>>
>> diff --git a/blockdev.c b/blockdev.c
>> index a464cabf9e..5370f3b738 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -3294,6 +3294,7 @@ void qmp_block_commit(bool has_job_id, const cha=
r *job_id, const char *device,
>>        */
>>       BlockdevOnError on_error =3D BLOCKDEV_ON_ERROR_REPORT;
>>       int job_flags =3D JOB_DEFAULT;
>> +    uint64_t top_perm, top_shared;
>>  =20
>>       if (!has_speed) {
>>           speed =3D 0;
>> @@ -3406,14 +3407,31 @@ void qmp_block_commit(bool has_job_id, const c=
har *job_id, const char *device,
>>           goto out;
>>       }
>>  =20
>> -    if (top_bs =3D=3D bs) {
>> +    /*
>> +     * Active commit is required if and only if someone has taken a
>> +     * WRITE permission on the top node.  Historically, we have alway=
s
>> +     * used active commit for top nodes, so continue that practice.
>> +     * (Active commit is never really wrong.)
>=20
> Hmm, if we start active commit when nobody has write access, than
> we leave a possibility to someone to get this access during commit.

Isn=E2=80=99t that blocked by the commit filter?  If it isn=E2=80=99t, it=
 should be.

> And during
> passive commit write access is blocked. So, may be right way is do acti=
ve commit
> always? Benefits:
> 1. One code path. and it shouldn't be worse when no writers, without gu=
est writes
> mirror code shouldn't work worse than passive commit, if it is, it shou=
ld be fixed.
> 2. Possibility of write access if user needs it during commit
> 3. I'm sure that active commit (mirror code) actually works faster, as =
it uses
> async requests and smarter handling of block status.

Disadvantage: Something may break because the basic commit job does not
emit BLOCK_JOB_READY and thus does not require block-job-complete.

Technically everything should expect jobs to potentially emit
BLOCK_JOB_READY, but who knows.  I think we=E2=80=99d want at least a
deprecation period.

Max

>> +     */
>> +    bdrv_get_cumulative_perm(top_bs, &top_perm, &top_shared);
>> +    if (top_perm & BLK_PERM_WRITE ||
>> +        bdrv_skip_rw_filters(top_bs) =3D=3D bdrv_skip_rw_filters(bs))=

>> +    {
>>           if (has_backing_file) {
>>               error_setg(errp, "'backing-file' specified,"
>>                                " but 'top' is the active layer");
>>               goto out;
>>           }
>> -        commit_active_start(has_job_id ? job_id : NULL, bs, base_bs,
>> -                            job_flags, speed, on_error,
>> +        if (!has_job_id) {
>> +            /*
>> +             * Emulate here what block_job_create() does, because it
>> +             * is possible that @bs !=3D @top_bs (the block job shoul=
d
>> +             * be named after @bs, even if @top_bs is the actual
>> +             * source)
>> +             */
>> +            job_id =3D bdrv_get_device_name(bs);
>> +        }
>> +        commit_active_start(job_id, top_bs, base_bs, job_flags, speed=
, on_error,
>>                               filter_node_name, NULL, NULL, false, &lo=
cal_err);
>>       } else {
>>           BlockDriverState *overlay_bs =3D bdrv_find_overlay(bs, top_b=
s);
>>
>=20
>=20



--u8O6Uywk09yJb06jfYQujAKRWbkmfYvvi--

--TMm68YVbdx51DVC82A4rsXB1gYYFOtHhW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0KW8UACgkQ9AfbAGHV
z0BBfQf+OViWz5s7I7NvMQhk+Vk+jyQ7tDQ8oBqg3I5DT14trM9uFAQ3z74I5A06
73hh0sqMAbpCs06KraxK/NH2kJRLBJLi7iX6JM5QIi8/3nerCMY2m36Dd3MkFCSw
57UJaHhh3DK/9wfqVBC3Igj81J08mUpUl/PpfRWyI4e0xCkHERkTqJ5Jq+RGke5l
ZTLjDeAYBvYY+4VzgdU8qU57FW3dlMsXBbqihVrpMhVQOACQnGIuYU/MfZwcLZd5
JhXbpEPNbX732t488t36wSAv44C8lRieSmfRVJxMkjBJpBXerkuVEB7JAOUmypMx
STnBQHM1WG08KhuGvTXkBxfuoY+6sg==
=Z9j7
-----END PGP SIGNATURE-----

--TMm68YVbdx51DVC82A4rsXB1gYYFOtHhW--

