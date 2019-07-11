Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71E9C74A52
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 13:09:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DCB220872
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 13:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DCB220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlYoy-0001ph-Ky
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 09:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35829)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hlYni-0000yj-AP
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:07:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hlYnh-0005xZ-7w
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:07:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47248)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hlYnf-0005tH-2H; Thu, 11 Jul 2019 09:07:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9D03930842AF;
 Thu, 11 Jul 2019 13:07:49 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.198])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 40CA25C220;
 Thu, 11 Jul 2019 13:07:48 +0000 (UTC)
To: Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "kwolf@redhat.com" <kwolf@redhat.com>
References: <20190610132124.3568-1-dplotnikov@virtuozzo.com>
 <9c2edd2b-766c-26e8-436a-d2763e2537c8@virtuozzo.com>
 <973ca865-83ee-5dd0-5c36-906cab220fe9@virtuozzo.com>
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
Message-ID: <c8293553-a410-27e7-4794-03adcfc91cea@redhat.com>
Date: Thu, 11 Jul 2019 15:07:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <973ca865-83ee-5dd0-5c36-906cab220fe9@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jzst5paUmMEEuF44US1FJRtl2YdbKuUX1"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 11 Jul 2019 13:07:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6] qemu-io: add pattern file for write
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jzst5paUmMEEuF44US1FJRtl2YdbKuUX1
Content-Type: multipart/mixed; boundary="GZOGaiaiNRJVm5al3ctH5SHUqYuwegntA";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "kwolf@redhat.com" <kwolf@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Message-ID: <c8293553-a410-27e7-4794-03adcfc91cea@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6] qemu-io: add pattern file for write
 command
References: <20190610132124.3568-1-dplotnikov@virtuozzo.com>
 <9c2edd2b-766c-26e8-436a-d2763e2537c8@virtuozzo.com>
 <973ca865-83ee-5dd0-5c36-906cab220fe9@virtuozzo.com>
In-Reply-To: <973ca865-83ee-5dd0-5c36-906cab220fe9@virtuozzo.com>

--GZOGaiaiNRJVm5al3ctH5SHUqYuwegntA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27.06.19 17:26, Denis Plotnikov wrote:
>=20
>=20
> On 19.06.2019 13:09, Vladimir Sementsov-Ogievskiy wrote:
>> 10.06.2019 16:21, Denis Plotnikov wrote:
>>> The patch allows to provide a pattern file for write
>>> command. There was no similar ability before.
>>>
>>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>>> ---
>>> v6:
>>>     * the pattern file is read once to reduce io
>>>
>>> v5:
>>>     * file name initiated with null to make compilers happy
>>>
>>> v4:
>>>     * missing signed-off clause added
>>>
>>> v3:
>>>     * missing file closing added
>>>     * exclusive flags processing changed
>>>     * buffer void* converted to char* to fix pointer arithmetics
>>>     * file reading error processing added
>>> ---
>>>    qemu-io-cmds.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++=
----
>>>    1 file changed, 82 insertions(+), 6 deletions(-)

[...]

>>> +    if (l < len) {
>>> +        char *file_buf =3D g_malloc(sizeof(char) * l);

Note that sizeof(char) is guaranteed to be 1.

(C1x standard, 6.5.3.4, paragraph 4.)

>>> +        memcpy(file_buf, buf, l);
>>
>> I see no reason to copy it, you can just use buf_origin pointer
>> instead.
> I use buf_origin to save the beginning pointer to return it from the=20
> function avoiding later calculation of the beginning address since=20
> pointer of the buf is changed in the loop.

The point is that you don=E2=80=99t need file_buf.  You can drop it, repl=
ace all
occurrences of file_buf by buf_origin, and probably use memmove instead
of memcpy.

Max


--GZOGaiaiNRJVm5al3ctH5SHUqYuwegntA--

--jzst5paUmMEEuF44US1FJRtl2YdbKuUX1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0nNKIACgkQ9AfbAGHV
z0Aq1wgAjWA2/UCwztK5c0Ez1GwkUuAgL1TdgUmL0+bJvIkltKUGYPYHx7F9SQv5
8DTy0qnjImaVKcrsPGGWV84N+RiNFblen2XViK3czKrEuGY7Zm3AaZrf7IDaGoz3
0NuaM7psOIPnzkypVRjBcQnn/x5IOMQ1GJZ4BZpStuV6AlYbbhSjDVM9YNMMpp3o
LGAxJhiSAKuH3YuGLlXOTck2yB/Jy81AZXbw2oacwHY1DXg4I9n9wX00iSyO6jam
AycKeyq8gpvy4MO7lkTk+1AwAGVvopbGPWMkZTxTEpw42MjsmwhvVSj75VJH08tO
EWq/qKv5jAxipkejnRuCKnHNM++DqA==
=HoKQ
-----END PGP SIGNATURE-----

--jzst5paUmMEEuF44US1FJRtl2YdbKuUX1--

