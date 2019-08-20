Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4EDC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 19:25:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8B6922DA7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 19:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B6922DA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i09ku-0002wO-Pq
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 15:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i09dQ-0008Va-PF
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 15:17:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i09dP-0003V0-E6
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 15:17:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54598)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i09dK-0003Kt-Tq; Tue, 20 Aug 2019 15:17:31 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1097F300CB24;
 Tue, 20 Aug 2019 19:17:02 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 96BE510016EA;
 Tue, 20 Aug 2019 19:17:00 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, Denis Plotnikov
 <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20190820164616.4072-1-dplotnikov@virtuozzo.com>
 <d1de09cd-2243-0ae8-c589-2871be826f66@redhat.com>
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
Message-ID: <0df80b64-2f9f-b048-8b2e-4b3016b8e882@redhat.com>
Date: Tue, 20 Aug 2019 21:16:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d1de09cd-2243-0ae8-c589-2871be826f66@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cx1pWEl1z8V3wdVmFLIoAuZoaoFAMlCg9"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 20 Aug 2019 19:17:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v10] qemu-io: add pattern file for write
 command
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cx1pWEl1z8V3wdVmFLIoAuZoaoFAMlCg9
Content-Type: multipart/mixed; boundary="jTiIaGMBtG7QIJ4g4WLiv3tJmUjS73THC";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, Denis Plotnikov
 <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <0df80b64-2f9f-b048-8b2e-4b3016b8e882@redhat.com>
Subject: Re: [PATCH v10] qemu-io: add pattern file for write command
References: <20190820164616.4072-1-dplotnikov@virtuozzo.com>
 <d1de09cd-2243-0ae8-c589-2871be826f66@redhat.com>
In-Reply-To: <d1de09cd-2243-0ae8-c589-2871be826f66@redhat.com>

--jTiIaGMBtG7QIJ4g4WLiv3tJmUjS73THC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.08.19 19:24, Eric Blake wrote:
> On 8/20/19 11:46 AM, Denis Plotnikov wrote:
>> The patch allows to provide a pattern file for write
>> command. There was no similar ability before.
>>
>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> ---
>=20
>> @@ -983,8 +1057,9 @@ static int write_f(BlockBackend *blk, int argc, c=
har **argv)
>>      /* Some compilers get confused and warn if this is not initialize=
d.  */
>>      int64_t total =3D 0;
>>      int pattern =3D 0xcd;
>> +    const char *file_name =3D NULL;
>> =20
>> -    while ((c =3D getopt(argc, argv, "bcCfnpP:quz")) !=3D -1) {
>> +    while ((c =3D getopt(argc, argv, "bcCfnpP:quzs:")) !=3D -1) {
>=20
> This one looks odd (I would have preserved ordering by sticking s:
> between q and u).  But a maintainer could fix that.
>=20
>>          switch (c) {
>>          case 'b':
>>              bflag =3D true;
>> @@ -1020,6 +1095,10 @@ static int write_f(BlockBackend *blk, int argc,=
 char **argv)
>>          case 'z':
>>              zflag =3D true;
>>              break;
>> +        case 's':
>> +            sflag =3D true;
>> +            file_name =3D optarg;
>> +            break;
>=20
> Likewise, sorting the cases in the same order as the getopt() listing
> helps in finding code during later edits.

But it is in order of the getopt() listing. ;-)

>> @@ -1088,7 +1168,14 @@ static int write_f(BlockBackend *blk, int argc,=
 char **argv)
>>      }
>> =20
>>      if (!zflag) {
>> -        buf =3D qemu_io_alloc(blk, count, pattern);
>> +        if (sflag) {
>> +            buf =3D qemu_io_alloc_from_file(blk, count, file_name);
>> +            if (!buf) {
>> +                return -EINVAL;
>> +            }
>> +        } else {
>> +            buf =3D qemu_io_alloc(blk, count, pattern);
>> +        }
>=20
> Pre-existing, but it is odd that qemu_io_alloc() exit()s rather than
> returning NULL on huge allocation requests that can't be met.  (Then
> again, we have an early exit on any length > 2G, and 2G allocations ten=
d
> to succeed on modern development machines).  Perhaps it would be nice t=
o
> teach qemu-io to use blk_try_blockalign for more graceful handling even=

> on 32-bit platforms, but that's not the problem of your patch.

Then again, this is qemu-io.  Printing an error instead of just aborting
doesn=E2=80=99t really help anyone.

Also, the code would be wrong without an early exit on a length >
INT_MAX.  (Because pattern_len is an int, so the result of fread() might
overflow otherwise, which would be bad.)

(I just noticed that fread() might do a short read, but let=E2=80=99s jus=
t
ignore this at this point.)

> Option ordering is minor enough that I'm fine giving:
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> Now, to figure out which maintainer should take it.  Perhaps you want t=
o
> add a patch 2/1 that adds an iotest using this new mode, to a) ensure i=
t
> doesn't regress, and b) makes it reasonable to take in through the
> iotest tree.

Adding a test does not seem to bad of an idea, but I don=E2=80=99t see ho=
w that
would clarify things.  Both qemu-io and the iotests are part of the
block layer core:

$ scripts/get_maintainer.pl -f qemu-io-cmds.c
Kevin Wolf <kwolf@redhat.com> (supporter:Block layer core)
Max Reitz <mreitz@redhat.com> (supporter:Block layer core)
qemu-block@nongnu.org (open list:Block layer core)
qemu-devel@nongnu.org (open list:All patches CC here)

$ scripts/get_maintainer.pl -f tests/qemu-iotests
Kevin Wolf <kwolf@redhat.com> (supporter:Block layer core)
Max Reitz <mreitz@redhat.com> (supporter:Block layer core)
qemu-block@nongnu.org (open list:Block layer core)
qemu-devel@nongnu.org (open list:All patches CC here)


So we only need to figure out whether it should be Kevin or me to take
it; but Kevin is on PTO, so that decision is simple. :-)

Therefor, I=E2=80=99ve changed the optstring (and switch case) order to b=
e
alphabetical, and applied the patch to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Thanks for the patch and the review,

Max


(I wouldn=E2=80=99t mind an iotest, but well.  qemu-io itself is a testin=
g
utility, so I don=E2=80=99t deem it important to test it.)


--jTiIaGMBtG7QIJ4g4WLiv3tJmUjS73THC--

--cx1pWEl1z8V3wdVmFLIoAuZoaoFAMlCg9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1cRyoACgkQ9AfbAGHV
z0C6YAf+IBEjo4UyRTR1ulMbQ6bc3fL1Ay2aSw0fnORPu4QZxGL/etbbWFyCYiUA
pCZhyd2jQlwOT2OsdxTahLzvSaGP4zW8hnLmh0LkaWQJjXOrJr+IWjPQxTruX7im
+BSekVQOzFSFk3aeIvcvl6cwFMZpKlCIIQAOBfjQPyP5929mEg0lcelCQhaOTsZx
CURfe2H02k/hivXcupSChIyvwv9Ve2lCGD1KGhgvOYQXnuvw2Y9kj+7gA2WnpQ0i
H/9KYHFjbOspbS0xgBQGM9y5K63xzHlQ/ZR4HE1WHQLIKd6EdkX1xS0qo+D9u1oo
IwMc8/pSmhaJlNmRj/i/uN0alGOl6w==
=DeUH
-----END PGP SIGNATURE-----

--cx1pWEl1z8V3wdVmFLIoAuZoaoFAMlCg9--

