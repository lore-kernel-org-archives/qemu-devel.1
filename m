Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E30C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 10:55:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A97822CF4
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 10:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A97822CF4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0OGr-0002yx-Qg
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 06:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49614)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i0OG2-0002UG-TW
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 06:54:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i0OG1-0007Rd-Vp
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 06:54:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60057)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i0OFz-0007Qk-Hv; Wed, 21 Aug 2019 06:54:23 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 970423083363;
 Wed, 21 Aug 2019 10:54:22 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.84])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D7BAA2B9EC;
 Wed, 21 Aug 2019 10:54:18 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
References: <20190819201851.24418-1-mreitz@redhat.com>
 <20190819201851.24418-6-mreitz@redhat.com>
 <23c31011-70d4-11ab-b8b9-294fe47453da@redhat.com>
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
Message-ID: <cf342a07-2077-4ff5-0a7d-6807dd29ae78@redhat.com>
Date: Wed, 21 Aug 2019 12:54:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <23c31011-70d4-11ab-b8b9-294fe47453da@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iJeOHsF9E1Jn0LA9p11vnsc9qCDEJf704"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 21 Aug 2019 10:54:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 5/8] iotests: Let skip_if_unsupported()
 accept a method
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iJeOHsF9E1Jn0LA9p11vnsc9qCDEJf704
Content-Type: multipart/mixed; boundary="J50EFjFxeHbDdeyXEjLBkjugSJNwAAahy";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <cf342a07-2077-4ff5-0a7d-6807dd29ae78@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/8] iotests: Let skip_if_unsupported()
 accept a method
References: <20190819201851.24418-1-mreitz@redhat.com>
 <20190819201851.24418-6-mreitz@redhat.com>
 <23c31011-70d4-11ab-b8b9-294fe47453da@redhat.com>
In-Reply-To: <23c31011-70d4-11ab-b8b9-294fe47453da@redhat.com>

--J50EFjFxeHbDdeyXEjLBkjugSJNwAAahy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.08.19 23:31, John Snow wrote:
>=20
>=20
> On 8/19/19 4:18 PM, Max Reitz wrote:
>> This lets tests use skip_if_unsupported() with a potentially variable
>> list of required formats.
>>
>> Suggested-by: Kevin Wolf <kwolf@redhat.com>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/iotests.py | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotest=
s.py
>> index 726f904f50..8f315538e9 100644
>> --- a/tests/qemu-iotests/iotests.py
>> +++ b/tests/qemu-iotests/iotests.py
>> @@ -893,8 +893,12 @@ def skip_if_unsupported(required_formats=3D[], re=
ad_only=3DFalse):
>>         Runs the test if all the required formats are whitelisted'''
>>      def skip_test_decorator(func):
>>          def func_wrapper(*args, **kwargs):
>> -            usf_list =3D list(set(required_formats) -
>> -                            set(supported_formats(read_only)))
>> +            if callable(required_formats):
>> +                fmts =3D required_formats(args[0])
>> +            else:
>> +                fmts =3D required_formats
>> +
>> +            usf_list =3D list(set(fmts) - set(supported_formats(read_=
only)))
>>              if usf_list:
>>                  args[0].case_skip('{}: formats {} are not whitelisted=
'.format(
>>                      args[0], usf_list))
>>
>=20
> I am required to inform you that this is in direct violation of the
> pythonista treaty of 2007; which mandates that you try to call and fail=

> instead of attempting to gracefully check ahead of time.
>=20
> Luckily, I am not fond of such rules.

:-)

I blame Kevin=E2=80=99s proposal.  (We should always have someone on PTO =
to
blame for everything.)


Thanks for reviewing.

Max


--J50EFjFxeHbDdeyXEjLBkjugSJNwAAahy--

--iJeOHsF9E1Jn0LA9p11vnsc9qCDEJf704
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1dItkACgkQ9AfbAGHV
z0AKeAgAs8RX7kRD9mlLTBE4Yr0MIcpEUZrBcKpYOLvZOxWkqooCUWOTO2g8PQU9
vpXThRRy4KA1k54j82EqkTMlUe+DGEQR/wXh1C5XS7A/7/faog/rcCP/G/WifcGG
7VFhq24ku8xNYsG/AKxd1cPY6VfNB14UIF3ihsK0biXBCh3opDOfk5b93oTE7pDD
42U/of9ggWk8n9dhEpeKgUlWIx1VjDLDLvB7XBUo3mHTlir14wHvUvaEsnKiwTnX
rl1JfgLac52FJjI5wpyqFPoDplx/rw7+9+ORFUDBur+DBaiwJ6sczP1AzAENCan0
axOKR+9yzkH+eXnOMNgN8uUGn5+hLA==
=IkhH
-----END PGP SIGNATURE-----

--iJeOHsF9E1Jn0LA9p11vnsc9qCDEJf704--

