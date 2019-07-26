Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DFEC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 11:00:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D36521994
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 11:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D36521994
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqxxm-0006Cp-Qd
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 07:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41396)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hqxxT-0005d7-Gr
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 07:00:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hqxxQ-0008KW-DN
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 07:00:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32824)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hqxxH-0007iW-EP; Fri, 26 Jul 2019 07:00:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 97A0D59440;
 Fri, 26 Jul 2019 11:00:05 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-164.ams2.redhat.com
 [10.36.116.164])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 794045D719;
 Fri, 26 Jul 2019 11:00:02 +0000 (UTC)
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20190724171239.8764-1-mreitz@redhat.com>
 <20190724171239.8764-6-mreitz@redhat.com>
 <20190726094307.x3rm5tvpsh3s4vp4@steredhat>
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
Message-ID: <a0cc5892-f90a-e5c3-af6a-1482b7eb3056@redhat.com>
Date: Fri, 26 Jul 2019 13:00:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190726094307.x3rm5tvpsh3s4vp4@steredhat>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9qh5rucsJjLqrgZtmYDHlGym53iTxJY3H"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 26 Jul 2019 11:00:05 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 05/11] block: Use
 bdrv_has_zero_init_truncate()
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9qh5rucsJjLqrgZtmYDHlGym53iTxJY3H
Content-Type: multipart/mixed; boundary="Wahd8IAJCbTPOGQ7a5MgQUAOj35mrmYVr";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <a0cc5892-f90a-e5c3-af6a-1482b7eb3056@redhat.com>
Subject: Re: [PATCH v2 05/11] block: Use bdrv_has_zero_init_truncate()
References: <20190724171239.8764-1-mreitz@redhat.com>
 <20190724171239.8764-6-mreitz@redhat.com>
 <20190726094307.x3rm5tvpsh3s4vp4@steredhat>
In-Reply-To: <20190726094307.x3rm5tvpsh3s4vp4@steredhat>

--Wahd8IAJCbTPOGQ7a5MgQUAOj35mrmYVr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.07.19 11:43, Stefano Garzarella wrote:
> On Wed, Jul 24, 2019 at 07:12:33PM +0200, Max Reitz wrote:
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/parallels.c | 2 +-
>>  block/vhdx.c      | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/parallels.c b/block/parallels.c
>> index 00fae125d1..7cd2714b69 100644
>> --- a/block/parallels.c
>> +++ b/block/parallels.c
>> @@ -835,7 +835,7 @@ static int parallels_open(BlockDriverState *bs, QD=
ict *options, int flags,
>>          goto fail_options;
>>      }
>> =20
>> -    if (!bdrv_has_zero_init(bs->file->bs)) {
>> +    if (!bdrv_has_zero_init_truncate(bs->file->bs)) {
>>          s->prealloc_mode =3D PRL_PREALLOC_MODE_FALLOCATE;
>>      }
>> =20
>> diff --git a/block/vhdx.c b/block/vhdx.c
>> index d6070b6fa8..a02d1c99a7 100644
>> --- a/block/vhdx.c
>> +++ b/block/vhdx.c
>> @@ -1282,7 +1282,7 @@ static coroutine_fn int vhdx_co_writev(BlockDriv=
erState *bs, int64_t sector_num,
>>                  /* Queue another write of zero buffers if the underly=
ing file
>>                   * does not zero-fill on file extension */
>> =20
>> -                if (bdrv_has_zero_init(bs->file->bs) =3D=3D 0) {
>> +                if (bdrv_has_zero_init_truncate(bs->file->bs) =3D=3D =
0) {
>>                      use_zero_buffers =3D true;
>> =20
>>                      /* zero fill the front, if any */
>> --=20
>> 2.21.0
>>
>=20
> What about describing in the commit message why we are using
> bdrv_has_zero_init_truncate() like in the cover letter?

Sure.  (Not sure why I didn=E2=80=99t do it in the first place.)

> With or without:
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks for reviewing!

Max


--Wahd8IAJCbTPOGQ7a5MgQUAOj35mrmYVr--

--9qh5rucsJjLqrgZtmYDHlGym53iTxJY3H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl063TAACgkQ9AfbAGHV
z0BOcAgAl4EdvNEtVibFejUNGddnWL0SG53HeJxEHCIUPgPX5AHuVDaPAfzVigch
F5DTq4LIXrmfzcXNwLbqaehpNuKbRUI6T+uiDPDawoK+d0RsQQFY7EH61dHIx4Kq
2fjFeRzzkkt2LTj4cRdPiUMOqss9WigTugFdbcNY2xQXYEsD966sXgYylpw7m2n6
zaCYPHw+AN8OyJ3h7NlkUVy3bjYa4KrnTAx/Urv02LQpTmk3jfw7rG3UZMehuD72
Vgw9ksBHGy6Ny2n+Z3GkPSF1Wo8bb9aCQQmGAYVMqRrwhC19CxzR0N05axrCflAb
VwfYqPBNssQEOQMRjqz1cvS/Qz1itQ==
=ao7q
-----END PGP SIGNATURE-----

--9qh5rucsJjLqrgZtmYDHlGym53iTxJY3H--

