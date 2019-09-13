Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C86C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 09:38:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D1C2081B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 09:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D1C2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8i2A-0002zb-Lw
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 05:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1i8i1F-0002Sq-7c
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 05:37:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1i8i1D-0006e5-1q
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 05:37:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56296)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1i8i1C-0006cY-O6
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 05:37:30 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 05E73882EA
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 09:37:29 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id c188so1101596wmd.9
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 02:37:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=y5kqMRWDGZjgMRZKqbjjBcDrNxR8UJBsgAXixZExY6w=;
 b=I8e+css7JimZIj9J7DtQyMAG6Xx1AHgvMMiPVyTfmMXVP0kh9W/Kscy6R6Wvty2jWV
 voK93cuyGKc+EMI8ve+jPaqiRS2DHHsAhxstrht4wTfFjfGdTcuorp1G46686CFGgdfE
 hfqCrz3AX2+zLgRZ/aMfHo04LPcTkV/LwgqEoHHFn4PI7v4qgyOI5+hTi2ydILjTuYyE
 M+owje8fexcvc/KzJul1rL5qgI6jYPIaPy7Zp4UkHLO5DCqHKWmNU5wX6fkCTvBLCADW
 8VfzbebYsKTVIiQ9B57UdwkBfFJvmMk1zafdcm8nncHHF2IRr7d8cXEZCK8aNvwzEf+v
 54Dw==
X-Gm-Message-State: APjAAAUuKr2/I2R4/95/KZlDTKbBHoIYowtsTOujfbok1j9LAeaLuTsN
 fmu5UqdlNgYAGiSF81yvCoTH5bpCsVuGIzZjNpMUqCCc6qUdgsSe86BivoLbio6tdHOuFHyP/zK
 R/lqch1ke9fGuSsI=
X-Received: by 2002:a7b:cc19:: with SMTP id f25mr2522423wmh.92.1568367447782; 
 Fri, 13 Sep 2019 02:37:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzxm8C+A9xTDs6dY+1CT2Wufi9xgVJAI6e5G+i8RFi4fIs1Y1JtAoe2pJl75jCZeYXffDKC1w==
X-Received: by 2002:a7b:cc19:: with SMTP id f25mr2522403wmh.92.1568367447476; 
 Fri, 13 Sep 2019 02:37:27 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id y12sm18611477wrn.74.2019.09.13.02.37.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2019 02:37:26 -0700 (PDT)
References: <20190912161624.40886-1-slp@redhat.com>
 <3ceab9a7-e002-a33e-d996-8c4fba374ece@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Max Reitz <mreitz@redhat.com>
In-reply-to: <3ceab9a7-e002-a33e-d996-8c4fba374ece@redhat.com>
Date: Fri, 13 Sep 2019 11:37:24 +0200
Message-ID: <87v9twwn8r.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] blockdev: avoid acquiring AioContext lock
 twice at do_drive_backup()
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Max Reitz <mreitz@redhat.com> writes:

> On 12.09.19 18:16, Sergio Lopez wrote:
>> do_drive_backup() acquires the AioContext lock of the corresponding
>> BlockDriverState. This is not a problem when it's called from
>> qmp_drive_backup(), but drive_backup_prepare() also acquires the lock
>> before calling it.
>>=20
>> This change adds a BlockDriverState argument to do_drive_backup(),
>> which is used to signal that the context lock is already acquired and
>> to save a couple of redundant calls.
>
> But those redundant calls don=E2=80=99t really hurt (it=E2=80=99s just bd=
rv_lookup_bs(),
> as far as I can tell).  Wouldn=E2=80=99t it be simpler to just release the
> context lock in drive_backup_prepare() before calling do_drive_backup()?
>  The BDS is drained anyway.

Redundant calls rarely hurt, they're just redundant ;-)

> On top of that, do_backup_common() calls bdrv_try_set_aio_context() to
> bring the target into the source=E2=80=99s AioContext.  However, this fun=
ction
> must be called with the old AioContext held, and the new context not held.

Is this documented somewhere? I see nothing in the function declaration
nor definition.

I'm starting to get the feeling that the block layer is riddled with
unwritten rules and assumptions that makes every change a lot harder
than it should be.

> Currently, it=E2=80=99s called exactly the other way around: With the new
> context held, but the old one not held.
>
> So I think it indeed actually makes more sense to release the AioContext
> before calling do_drive_backup(), and to move the
> bdrv_try_set_aio_context() call for target_bs to the callers of
> do_backup_common() (where they have not yet taken the AioContext lock).

OK. I see this also happens in external_snapshot_prepare() and
qmp_drive_mirror() too. I guess we should fix these too.

In qmp_drive_mirror(), would it be safe to delay the acquisition of any
context until just before the blockdev_mirror_common()?

> Max
>
>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>> ---
>>  blockdev.c | 54 ++++++++++++++++++++++++++++++++++++++----------------
>>  1 file changed, 38 insertions(+), 16 deletions(-)
>>=20
>> diff --git a/blockdev.c b/blockdev.c
>> index fbef6845c8..0cc6c69ceb 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -1762,8 +1762,10 @@ typedef struct DriveBackupState {
>>      BlockJob *job;
>>  } DriveBackupState;
>>=20=20
>> -static BlockJob *do_drive_backup(DriveBackup *backup, JobTxn *txn,
>> -                            Error **errp);
>> +static BlockJob *do_drive_backup(DriveBackup *backup,
>> +                                 BlockDriverState *backup_bs,
>> +                                 JobTxn *txn,
>> +                                 Error **errp);
>>=20=20
>>  static void drive_backup_prepare(BlkActionState *common, Error **errp)
>>  {
>> @@ -1781,6 +1783,11 @@ static void drive_backup_prepare(BlkActionState *=
common, Error **errp)
>>          return;
>>      }
>>=20=20
>> +    if (!bs->drv) {
>> +        error_setg(errp, "Device has no medium");
>> +        return;
>> +    }
>> +
>>      aio_context =3D bdrv_get_aio_context(bs);
>>      aio_context_acquire(aio_context);
>>=20=20
>> @@ -1789,7 +1796,9 @@ static void drive_backup_prepare(BlkActionState *c=
ommon, Error **errp)
>>=20=20
>>      state->bs =3D bs;
>>=20=20
>> -    state->job =3D do_drive_backup(backup, common->block_job_txn, &loca=
l_err);
>> +    state->job =3D do_drive_backup(backup, bs,
>> +                                 common->block_job_txn,
>> +                                 &local_err);
>>      if (local_err) {
>>          error_propagate(errp, local_err);
>>          goto out;
>> @@ -3607,7 +3616,9 @@ static BlockJob *do_backup_common(BackupCommon *ba=
ckup,
>>      return job;
>>  }
>>=20=20
>> -static BlockJob *do_drive_backup(DriveBackup *backup, JobTxn *txn,
>> +static BlockJob *do_drive_backup(DriveBackup *backup,
>> +                                 BlockDriverState *backup_bs,
>> +                                 JobTxn *txn,
>>                                   Error **errp)
>>  {
>>      BlockDriverState *bs;
>> @@ -3625,18 +3636,27 @@ static BlockJob *do_drive_backup(DriveBackup *ba=
ckup, JobTxn *txn,
>>          backup->mode =3D NEW_IMAGE_MODE_ABSOLUTE_PATHS;
>>      }
>>=20=20
>> -    bs =3D bdrv_lookup_bs(backup->device, backup->device, errp);
>> -    if (!bs) {
>> -        return NULL;
>> -    }
>> +    if (backup_bs) {
>> +        bs =3D backup_bs;
>> +        /*
>> +         * If the caller passes us a BDS, we assume it has already
>> +         * acquired the context lock.
>> +         */
>> +        aio_context =3D bdrv_get_aio_context(bs);
>> +    } else {
>> +        bs =3D bdrv_lookup_bs(backup->device, backup->device, errp);
>> +        if (!bs) {
>> +            return NULL;
>> +        }
>>=20=20
>> -    if (!bs->drv) {
>> -        error_setg(errp, "Device has no medium");
>> -        return NULL;
>> -    }
>> +        if (!bs->drv) {
>> +            error_setg(errp, "Device has no medium");
>> +            return NULL;
>> +        }
>>=20=20
>> -    aio_context =3D bdrv_get_aio_context(bs);
>> -    aio_context_acquire(aio_context);
>> +        aio_context =3D bdrv_get_aio_context(bs);
>> +        aio_context_acquire(aio_context);
>> +    }
>>=20=20
>>      if (!backup->has_format) {
>>          backup->format =3D backup->mode =3D=3D NEW_IMAGE_MODE_EXISTING ?
>> @@ -3713,7 +3733,9 @@ static BlockJob *do_drive_backup(DriveBackup *back=
up, JobTxn *txn,
>>  unref:
>>      bdrv_unref(target_bs);
>>  out:
>> -    aio_context_release(aio_context);
>> +    if (!backup_bs) {
>> +        aio_context_release(aio_context);
>> +    }
>>      return job;
>>  }
>>=20=20
>> @@ -3721,7 +3743,7 @@ void qmp_drive_backup(DriveBackup *arg, Error **er=
rp)
>>  {
>>=20=20
>>      BlockJob *job;
>> -    job =3D do_drive_backup(arg, NULL, errp);
>> +    job =3D do_drive_backup(arg, NULL, NULL, errp);
>>      if (job) {
>>          job_start(&job->job);
>>      }
>>=20


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl17Y1QACgkQ9GknjS8M
AjWwbRAAiB3zRJkLSU4dcbBVBsJBukHiVcKX7jsJ1x3rVAucmZLx6fsqbNAG6dNF
wFwSNbYcB5RqTSceZDSYpGqsebVljw40mXIjQkIDK3w5PO7mLk9uxc33Q0hQ0rCj
CjSj4JDxDKJDtmGCLXpoxu6b3puPuo6SRqQhv16Up0XxLAssGoX29tubSG/yhxhx
1r45m4X2iQ3ovC0DgUUzcX0J6LPwaAc+cnY/dLcAlenSibLhR/7+Twk/E4kzGQxg
7iCmaLMwT3jjSExPLoT/7HrE7ditpqNOjLKTgiwFYsGEwgVAQsA/A9JqSLiLsRir
GpEybq3UvtBg21e32XDIn+JSso5FO36pRu8Pgu2hIwQhsazHIJ0m1wpOSiSQUd/4
7D5yyaPw0TEePOaIj7IEtJFa66uBdTxvUATRQruJXgeCtaLVEZgaTFldy6wXY5yq
ZIvxrwNkaYix2JNl4XDJvLDd56eBtPvepq+HnQJpksG8npIClPvRJu3KbuRFuYQl
CTcBr9RbGU5oX6C9LU7rntPEuLm8Ag8J091yo/8q5VB+9AtZmmp6+tvAvDMUN7h7
07Ph7UD2VDPPdJ/AQ/sNXKpmOPR2iiM9Bi3Gwa7Vn/dDy6HsugYrtzIIIXHZoEt7
XZASSpdXs4gvrD5OxLgVpK1dVEkIpxyOcwtHFjD/AEn2+Qf5Xkk=
=VH0m
-----END PGP SIGNATURE-----
--=-=-=--

