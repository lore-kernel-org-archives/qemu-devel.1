Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5B8C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 11:19:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C48772087E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 11:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48772087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ht970-0002aJ-49
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 07:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59016)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1ht968-0001L2-82
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 07:18:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ht967-0004Q1-2b
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 07:18:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53438)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1ht964-0004Mm-99; Thu, 01 Aug 2019 07:18:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D6BF9317917A;
 Thu,  1 Aug 2019 11:18:10 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-187.brq.redhat.com
 [10.40.204.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A45E25D9CA;
 Thu,  1 Aug 2019 11:18:06 +0000 (UTC)
To: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20190730163251.755248-1-vsementsov@virtuozzo.com>
 <20190730163251.755248-2-vsementsov@virtuozzo.com>
 <f13fdafd-34d2-3079-ab17-78cdb7e9f428@redhat.com>
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
Message-ID: <9bb902a3-d2f2-6cf8-8adb-832ccbfde8f9@redhat.com>
Date: Thu, 1 Aug 2019 13:18:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f13fdafd-34d2-3079-ab17-78cdb7e9f428@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nk4giPD5t25ciMiOS0KqhHpJMLMEthKjf"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 01 Aug 2019 11:18:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/3] block/backup: deal with zero detection
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
Cc: kwolf@redhat.com, den@openvz.org, armbru@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nk4giPD5t25ciMiOS0KqhHpJMLMEthKjf
Content-Type: multipart/mixed; boundary="JrFduQ5QF3aDtOxsnYXjBbMDzwmMeA1Qn";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, den@openvz.org
Message-ID: <9bb902a3-d2f2-6cf8-8adb-832ccbfde8f9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] block/backup: deal with zero detection
References: <20190730163251.755248-1-vsementsov@virtuozzo.com>
 <20190730163251.755248-2-vsementsov@virtuozzo.com>
 <f13fdafd-34d2-3079-ab17-78cdb7e9f428@redhat.com>
In-Reply-To: <f13fdafd-34d2-3079-ab17-78cdb7e9f428@redhat.com>

--JrFduQ5QF3aDtOxsnYXjBbMDzwmMeA1Qn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 30.07.19 20:40, John Snow wrote:
>=20
>=20
> On 7/30/19 12:32 PM, Vladimir Sementsov-Ogievskiy wrote:
>> We have detect_zeroes option, so at least for blockdev-backup user
>> should define it if zero-detection is needed. For drive-backup leave
>> detection enabled by default but do it through existing option instead=

>> of open-coding.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=

>> ---
>>  block/backup.c | 15 ++++++---------
>>  blockdev.c     |  8 ++++----
>>  2 files changed, 10 insertions(+), 13 deletions(-)
>>
>> diff --git a/block/backup.c b/block/backup.c
>> index 715e1d3be8..f4aaf08df3 100644
>> --- a/block/backup.c
>> +++ b/block/backup.c
>> @@ -110,7 +110,10 @@ static int coroutine_fn backup_cow_with_bounce_bu=
ffer(BackupBlockJob *job,
>>      BlockBackend *blk =3D job->common.blk;
>>      int nbytes;
>>      int read_flags =3D is_write_notifier ? BDRV_REQ_NO_SERIALISING : =
0;
>> -    int write_flags =3D job->serialize_target_writes ? BDRV_REQ_SERIA=
LISING : 0;
>> +    int write_flags =3D
>> +            (job->serialize_target_writes ? BDRV_REQ_SERIALISING : 0)=
 |
>> +            (job->compress ? BDRV_REQ_WRITE_COMPRESSED : 0);
>> +
>> =20
>>      assert(QEMU_IS_ALIGNED(start, job->cluster_size));
>>      hbitmap_reset(job->copy_bitmap, start, job->cluster_size);
>> @@ -128,14 +131,8 @@ static int coroutine_fn backup_cow_with_bounce_bu=
ffer(BackupBlockJob *job,
>>          goto fail;
>>      }
>> =20
>> -    if (buffer_is_zero(*bounce_buffer, nbytes)) {
>> -        ret =3D blk_co_pwrite_zeroes(job->target, start,
>> -                                   nbytes, write_flags | BDRV_REQ_MAY=
_UNMAP);
>> -    } else {
>> -        ret =3D blk_co_pwrite(job->target, start,
>> -                            nbytes, *bounce_buffer, write_flags |
>> -                            (job->compress ? BDRV_REQ_WRITE_COMPRESSE=
D : 0));
>> -    }
>> +    ret =3D blk_co_pwrite(job->target, start, nbytes, *bounce_buffer,=

>> +                        write_flags);
>>      if (ret < 0) {
>>          trace_backup_do_cow_write_fail(job, start, ret);
>>          if (error_is_read) {
>> diff --git a/blockdev.c b/blockdev.c
>> index 4d141e9a1f..a94d754504 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -3434,7 +3434,7 @@ static BlockJob *do_drive_backup(DriveBackup *ba=
ckup, JobTxn *txn,
>>      BlockJob *job =3D NULL;
>>      BdrvDirtyBitmap *bmap =3D NULL;
>>      AioContext *aio_context;
>> -    QDict *options =3D NULL;
>> +    QDict *options;
>>      Error *local_err =3D NULL;
>>      int flags, job_flags =3D JOB_DEFAULT;
>>      int64_t size;
>> @@ -3529,10 +3529,10 @@ static BlockJob *do_drive_backup(DriveBackup *=
backup, JobTxn *txn,
>>          goto out;
>>      }
>> =20
>> +    options =3D qdict_new();
>> +    qdict_put_str(options, "discard", "unmap");
>> +    qdict_put_str(options, "detect-zeroes", "unmap");
>>      if (backup->format) {
>> -        if (!options) {
>> -            options =3D qdict_new();
>> -        }
>>          qdict_put_str(options, "driver", backup->format);
>>      }
>> =20
>>
>=20
> I'm less sure of this one personally. Is it right to always try to set
> unmap on the target?
>=20
> I like the idea of removing special cases and handling things more
> centrally though, but I'll want Max (or Kevin) to take a peek.

I don=E2=80=99t quite know why, because this is just a block job specific=

question and doesn=E2=80=99t have much to do with the rest of the block l=
ayer,
but OK. :-)

drive-backup always set BDRV_REQ_MAY_UNMAP, as you can see.  Maybe that
didn=E2=80=99t do anything because the target wasn=E2=80=99t opened with =
discard=3Dunmap.
 But to me, it=E2=80=99s clear that the intention was to indeed unmap the=
 areas
in the target (it isn=E2=80=99t like the user had a choice of opening the=
 target
with discard=3Dunmap or not).

Max


--JrFduQ5QF3aDtOxsnYXjBbMDzwmMeA1Qn--

--nk4giPD5t25ciMiOS0KqhHpJMLMEthKjf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1CymwACgkQ9AfbAGHV
z0C8NQf/aQW4RwXJqbQ4fXvtuX0EtXGr2qL2AXGceOlKyA/lysw6CUDI+ut1q9ST
R6lmqPFTn5yFxxdhm9RAgFHNigL3vgNwtw2r3D1OtJdcNludQ2m1bzAFVPxDBbOm
RxccGvnGp0GjXvZ4pDjog84pPr/MRMLL/YDApRo7l6T2uJNpK+3D3oSH9RGh3gt0
5Xy0A5SA23r5J4BZV03dmQ1RbzF/Ai01IJgoQzRHdWf4bUrbWHRW+0DWk3aPw0bh
0hLZKrujjmGWHal7hkQ7wdA3p5F/ar7NG8KxGJQuawQUmOmqXbmNCqkFT6eZf2Lb
cdP420FaeT7OmLdZB7tZL8i1gETi6Q==
=UtbT
-----END PGP SIGNATURE-----

--nk4giPD5t25ciMiOS0KqhHpJMLMEthKjf--

