Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FE9C10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 09:35:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEE80218DE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 09:35:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE80218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFxW2-0001d9-RD
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 05:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49241)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iFxUh-0000dt-SB
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 05:33:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iFxUg-0003Ak-8w
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 05:33:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36422)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iFxUg-00039q-04
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 05:33:54 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BBB08368FF
 for <qemu-devel@nongnu.org>; Thu,  3 Oct 2019 09:33:52 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id k67so459155wmf.3
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 02:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=gf+Qbxksk3B9oIq95/inNVVvY3Do4jSQ6YPSwb50D20=;
 b=fZzg0rjBb/1YBfZjcNDzZCGShIeoMfRx+0YkOkoiic6v+g02tl12tKUkEzJf6Hn/RB
 gPGU+PKqA/zzSD984NIyO/GVy1ZpG9iV4p+obZ9ACXBpUnG1wRH2bXLVddBFCUGatoVX
 oPLvpO+Vsv0RpfmZfp+e8gZyNXg3zLibuicbv/AxgkSNLWTIVZr1fSPlaEpvyDBncEqF
 LUpR+i5OkSrHYb4m4mm0N9mEwb78PMvuCxIFBWEHVR3fYov3mwG0JuSnSOgKgJoyjoKD
 gHcBJgTT59ZTt0ws52Y/WvTCbhqTA2mxFJbt45hu+3y6JoBmvoBwU2lO0hJXiinjVqbP
 lpUg==
X-Gm-Message-State: APjAAAXkK0O0GVVImiy8dbv9V1vBC+znF6R9sptJTey/tEMYM1aIdscA
 J3U79mc2ZDbhqSzpqznkq00dPIFolvJ00xWcunkfq6lFfgjwNjC+fl3zsot5nzlH5G2G1szBwiq
 RFLpLMZXcptjiu04=
X-Received: by 2002:a1c:a404:: with SMTP id n4mr6121235wme.41.1570095231522;
 Thu, 03 Oct 2019 02:33:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxwdlT5rTYJzyEgYxGs3p8S+fz24KRQvE+R5uuvy1ojHsU/QR13qr+vWKAmtU/W4hofTwSa0w==
X-Received: by 2002:a1c:a404:: with SMTP id n4mr6121213wme.41.1570095231290;
 Thu, 03 Oct 2019 02:33:51 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id t6sm3726046wmf.8.2019.10.03.02.33.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2019 02:33:50 -0700 (PDT)
References: <20190913152507.56197-1-slp@redhat.com>
 <20190913152507.56197-2-slp@redhat.com>
 <f10c8f6d-5ad2-b37c-16b7-659a3f02661c@redhat.com>
 <20190916075303.GA10930@localhost.localdomain> <87d0g0h4mo.fsf@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [Qemu-block] [PATCH v2 1/2] blockdev: release the AioContext at
 drive_backup_prepare
In-reply-to: <87d0g0h4mo.fsf@redhat.com>
Date: Thu, 03 Oct 2019 11:33:46 +0200
Message-ID: <87o8yyi35x.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
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
Cc: mreitz@redhat.com, John Snow <jsnow@redhat.com>, armbru@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Sergio Lopez <slp@redhat.com> writes:

> Kevin Wolf <kwolf@redhat.com> writes:
>
>> Am 13.09.2019 um 21:54 hat John Snow geschrieben:
>>>=20
>>>=20
>>> On 9/13/19 11:25 AM, Sergio Lopez wrote:
>>> > do_drive_backup() already acquires the AioContext, so release it
>>> > before the call.
>>> >=20
>>> > Signed-off-by: Sergio Lopez <slp@redhat.com>
>>> > ---
>>> >  blockdev.c | 6 +-----
>>> >  1 file changed, 1 insertion(+), 5 deletions(-)
>>> >=20
>>> > diff --git a/blockdev.c b/blockdev.c
>>> > index fbef6845c8..3927fdab80 100644
>>> > --- a/blockdev.c
>>> > +++ b/blockdev.c
>>> > @@ -1783,20 +1783,16 @@ static void drive_backup_prepare(BlkActionSta=
te *common, Error **errp)
>>> >=20=20
>>> >      aio_context =3D bdrv_get_aio_context(bs);
>>> >      aio_context_acquire(aio_context);
>>> > -
>>
>> Are you removing this unrelated empty line intentionally?
>
> Yes. In the sense of that whole set of lines being a "open drained
> section" block.
>
>>> >      /* Paired with .clean() */
>>> >      bdrv_drained_begin(bs);
>>>=20
>>> Do we need to make this change to blockdev_backup_prepare as well?
>>
>> Actually, the whole structure feels a bit wrong. We get the bs here and
>> take its lock, then release the lock again and forget the reference,
>> only to do both things again inside do_drive_backup().
>>
>> The way snapshots work is that the "normal" snapshot commands are
>> wrappers that turn it into a single-entry transaction. Then you have
>> only one code path where you can resolve the ID and take the lock just
>> once. So maybe backup should work like this, too?
>
> I'm neither opposed nor in favor, but I think this is outside the scope
> of this patch series.

Kevin, do you think we should attempt to just fix this issue (which
would make a possible backport easier) or try to move all blockdev
actions to be transaction-based?

Cheers,
Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2VwHoACgkQ9GknjS8M
AjWNPQ//UWMQdMVZKHM4xXu0qrRngPi/paChzw67mLVXTbUxQaM2CBRgjU2e/uKB
G7JcizbXSfyYrfNhci76eMteLTrWn5805AaUpuFBw+/M4Eo/3ULIuQ4Wsvs+LsT9
R5rpA3lX0/Xfid+vjXAPMJ5tNoJYZryelD6XsDM3Q2KDie6mENZQOS1X4NK8JinT
5f+I/HQygOTdWm5W7ekmoy+GHlY3JXr6e6vNZjr8fMJQyTeGT9y2zsvo8SIpYGc/
QIMPV2fmhlkZVUT1luSvin+9nQplQ8HIeY2SqB5AKU4eA/tYTD8DicqNDY8lriSg
zHOQrqTVqfDbJwXR1rspZrakwjGlkf/UqYEDCtQkjgS8iNniYcZSXx/Kwn/V4Oav
LHbnt3dqmfjCtp76Kuy8o0zwnurwiCl/RIp1eNgkQwMW4mIDA4N7wtNoigs1KWCb
uCFZZtCHN5DT0IHhCHW5TfkFgXRJrUGHAdqL9xbEjfqkq+MFkaGCYC6QyAg4FTeX
gjGTbRxFRT7k8DcrblsZ6XkGNp6afg4FaJbcZOmpOjwm0ORXPgIZkLMWaHhhLcMG
1EuSxzcBpcboAhHFd38MZDo6A+jAzgp4NCjG089+Y/j7aPyqDMyIK/NGJI3vXgMs
OmcY0W/qDDaqE9LYWCd0IxgJWbDddY+M13AAoNxNWfUk4n0H8YY=
=fjjj
-----END PGP SIGNATURE-----
--=-=-=--

