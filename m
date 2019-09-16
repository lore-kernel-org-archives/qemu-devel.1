Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38290C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 11:20:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C6B1206A4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 11:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C6B1206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9p33-00038j-6j
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 07:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1i9p1C-0001s1-5X
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 07:18:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1i9p1A-0003Iw-JD
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 07:18:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56280)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1i9p1A-0003Gs-6M
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 07:18:04 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F3B4885A03
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 11:18:02 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id l6so15844177wrn.2
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 04:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=92n9iVmIP8WXpmFiP/z+yc2Hv3AQzU9gAWb8le/yzV4=;
 b=Ib0tyabkx4U3YO9WAPlX3X1OjscksU2XL4xkQ0qQmViU/ByMbsGQ1DRcj1yGdMV5lB
 dadcdFwBv8oWiegNfKL/LmShYsqiEOwgHFY023zmdjlLXJwSjuoa8123u6gPKcORGYd7
 RMGtjwB5X/CVVesYPK4ahangVZ+rc1ZqOKVADAJUbVvWiyBrICBiWkwwCIRSY3T/NHYU
 jOxZ+/9/mFihhuJPuXWg3kY/OmJpG8zwUR6GOF6mf5GhSMTjnBSdoL5P9zTvJd01PZgw
 H6GKmyLzQszTdWeYRQ7BDlvynwWkjisafnU594iLPh1YaPw0bYVY2t/FZYejKJdiBHQ2
 8jpw==
X-Gm-Message-State: APjAAAWn0ZheMKgwCJmAOZs91UxhQL6xsk61JSlYmiYN/WkfNw4nVKNl
 CwxMbze8ursdIUdddb6HJHxr8kw2VVTcHBSRY7TDZyuYv4VX2g6pOBNUC7Z6skraE8Fbo+H8yGI
 2ygGCI91Y5eLhDl4=
X-Received: by 2002:a1c:cb05:: with SMTP id b5mr13378519wmg.79.1568632681721; 
 Mon, 16 Sep 2019 04:18:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzP8HjU3vkpI7bHnMIBPMd7byITbejL9fq7axIQCuEZNhqY0mGc6Smeiwj986P7l/TbpLTt0w==
X-Received: by 2002:a1c:cb05:: with SMTP id b5mr13378488wmg.79.1568632681449; 
 Mon, 16 Sep 2019 04:18:01 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id m11sm6549605wrn.59.2019.09.16.04.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2019 04:18:00 -0700 (PDT)
References: <20190913152507.56197-1-slp@redhat.com>
 <20190913152507.56197-2-slp@redhat.com>
 <f10c8f6d-5ad2-b37c-16b7-659a3f02661c@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: John Snow <jsnow@redhat.com>
In-reply-to: <f10c8f6d-5ad2-b37c-16b7-659a3f02661c@redhat.com>
Date: Mon, 16 Sep 2019 13:17:58 +0200
Message-ID: <87blvkh4m1.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 1/2] blockdev: release the
 AioContext at drive_backup_prepare
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
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


John Snow <jsnow@redhat.com> writes:

> On 9/13/19 11:25 AM, Sergio Lopez wrote:
>> do_drive_backup() already acquires the AioContext, so release it
>> before the call.
>>=20
>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>> ---
>>  blockdev.c | 6 +-----
>>  1 file changed, 1 insertion(+), 5 deletions(-)
>>=20
>> diff --git a/blockdev.c b/blockdev.c
>> index fbef6845c8..3927fdab80 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -1783,20 +1783,16 @@ static void drive_backup_prepare(BlkActionState =
*common, Error **errp)
>>=20=20
>>      aio_context =3D bdrv_get_aio_context(bs);
>>      aio_context_acquire(aio_context);
>> -
>>      /* Paired with .clean() */
>>      bdrv_drained_begin(bs);
>
> Do we need to make this change to blockdev_backup_prepare as well?

Yes, we do. Thanks.

>> +    aio_context_release(aio_context);
>>=20=20
>>      state->bs =3D bs;
>>=20=20
>>      state->job =3D do_drive_backup(backup, common->block_job_txn, &loca=
l_err);
>>      if (local_err) {
>>          error_propagate(errp, local_err);
>> -        goto out;
>>      }
>> -
>> -out:
>> -    aio_context_release(aio_context);
>>  }
>>=20=20
>>  static void drive_backup_commit(BlkActionState *common)
>>=20


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl1/b2YACgkQ9GknjS8M
AjVCNBAAtmLEKsClvuqPnT/xgqSaHk7VL6vqoRjyCFPZruvhTz9q0ctE0Hb0eyvI
pWW7FkYMGyRwoARJMNzRbi15wFfuM0jO60PyoZ/lf/DAPcy2hSufnBEEiAkZoYXm
GOZpFhzAdtV2cVJEadDdesGLgNYbjwMSkWtZyOHTTVRbUoS77zoPE1TeGnkNEsyt
HLc0mI/OmMahPdG4WAjehD26UEhdgwN6nKNQQfFjwiCcrfEuv27B8clarGfBSrC3
VhjgJnHG8ONfnVHdiTFwTENng+SKW+3RGH9pxob/wD4Sc1nDr6qLBkjGSvNBEiC9
o2QaltIpglcFWjAyL3FXKpd+ycOtfj4bbZPOsxZVe/9LnJuzMgYCKXDFY/2a4Ulh
MZcBbd1k+WyCDewInWemVNghSZMrPbyAWGc3k+jq536/8vPmud4Z77pwlicLgwRb
pWyoBENWdLnFboTpw9gWQGx9/lx+BqhjsEmKctqyKwrDZf/KQZbDAwNkge68gzKu
Ii9r/g1sCWRNpMidXjZi/t77lGIPIpL86Wlent4mWa2wRP2GAZUQflGuAS4a3Lso
h9WDZIklyb/JCqhyq/bsZeAdFFuRXqI5Ojg6GBwHgSi+UNFY06r1pbxBanTDCfuG
9sjRULd8E2OYQXizmCxBh3K7Eb/WjFBzs19xtrSuKqyS/DnFmYo=
=/+V/
-----END PGP SIGNATURE-----
--=-=-=--

