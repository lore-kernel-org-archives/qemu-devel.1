Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6E7C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 08:23:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF6D32087E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 08:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWURA5Ol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6D32087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNtsJ-0004p3-23
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 04:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kNtrW-0004Kp-6s
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 04:22:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47158)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kNtrT-0001ah-A8
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 04:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601540565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vA8un5xuDNZ0t7AkV5lsDjwxYGEJ+UQTEZXH4qk0QO8=;
 b=TWURA5OlS8KQl5EtyCrc5NCCLukXuA8blNfIduAXgt7mQHTRGPy0qTnbFYDtUkTZcbPP0B
 isRqyXISei2pp9zUAWKUCvTQAdgF3zVWGvuvzu3Ia3lmWj0W3ziPMiuKLVE4IzftzwcVqy
 qlTpnqOKGwDXORtY0uuFLYfdJN01+tg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-pSOBb86LPLuKwX2X20SQ9g-1; Thu, 01 Oct 2020 04:22:41 -0400
X-MC-Unique: pSOBb86LPLuKwX2X20SQ9g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3516E10199A7;
 Thu,  1 Oct 2020 08:22:40 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-181.ams2.redhat.com
 [10.36.113.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B71AC60BF1;
 Thu,  1 Oct 2020 08:22:34 +0000 (UTC)
Subject: Re: [PATCH v6 14/15] scripts/simplebench: improve ascii table: add
 difference line
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200918181951.21752-1-vsementsov@virtuozzo.com>
 <20200918181951.21752-15-vsementsov@virtuozzo.com>
 <6b808a3b-735b-45b4-79bf-6e73000de5bb@redhat.com>
 <5df7fb5f-d551-c9fc-d5a8-dc267599d1b7@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
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
Message-ID: <1cfd7964-3e4b-36f4-c927-34d85e78d88f@redhat.com>
Date: Thu, 1 Oct 2020 10:22:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <5df7fb5f-d551-c9fc-d5a8-dc267599d1b7@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ASwUzrSbWElZgWQWkel23npjHsEUQhQuW"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URI_DOTEDU=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ASwUzrSbWElZgWQWkel23npjHsEUQhQuW
Content-Type: multipart/mixed; boundary="dxW7WpltbzFmcFBt988J02jHiTtGsvUiu"

--dxW7WpltbzFmcFBt988J02jHiTtGsvUiu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.09.20 19:13, Vladimir Sementsov-Ogievskiy wrote:
> 25.09.2020 13:24, Max Reitz wrote:
>> On 18.09.20 20:19, Vladimir Sementsov-Ogievskiy wrote:
>>> Performance improvements / degradations are usually discussed in
>>> percentage. Let's make the script calculate it for us.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>> =C2=A0 scripts/simplebench/simplebench.py | 46 ++++++++++++++++++++++++=
+++---
>>> =C2=A0 1 file changed, 42 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/scripts/simplebench/simplebench.py
>>> b/scripts/simplebench/simplebench.py
>>> index 56d3a91ea2..0ff05a38b8 100644
>>> --- a/scripts/simplebench/simplebench.py
>>> +++ b/scripts/simplebench/simplebench.py
>>
>> [...]
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for=
 j in range(0, i):
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 env_j =3D results['envs'][j]
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 res_j =3D case_results[env_j['id']]
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if 'average' not in res_j:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Failed result
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cell +=3D ' --'
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 col_j =3D chr(ord('A') + j)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 avg_j =3D res_j['average']
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 delta =3D (res['average'] - avg_j) / avg_j * 100
>>
>> I was wondering why you=E2=80=99d subtract, when percentage differences =
usually
>> mean a quotient.=C2=A0 Then I realized that this would usually be writte=
n as:
>>
>> (res['average'] / avg_j - 1) * 100
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 delta_delta =3D (res['delta'] + res_j['delta']) /
>>> avg_j * 100
>>
>> Why not use the new format_percent for both cases?
>=20
> because I want less precision here
>=20
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 cell +=3D f'
>>> {col_j}{round(delta):+}=C2=B1{round(delta_delta)}%'
>>
>> I don=E2=80=99t know what I should think about =C2=B1delta_delta.=C2=A0 =
If I saw =E2=80=9CCompared
>> to run A, this is +42.1%=C2=B12.0%=E2=80=9D, I would think that you calc=
ulated the
>> difference between each run result, and then based on that array
>> calculated average and standard deviation.
>>
>> Furthermore, I don=E2=80=99t even know what the delta_delta is supposed =
to tell
>> you.=C2=A0 It isn=E2=80=99t even a delta_delta, it=E2=80=99s an average_=
delta.
>=20
> not avarage, but sum of errors. And it shows the error for the delta
>=20
>>
>> The delta_delta would be (res['delta'] / res_j['delta'] - 1) * 100.0.
>=20
> and this shows nothing.
>=20
> Assume we have =3D A =3D 10+-2 and B =3D 15+-2
>=20
> The difference is (15-10)+-(2+2) =3D 5+-4.
> And your formula will give (2/2 - 1) *100 =3D 0, which is wrong.

Well, it=E2=80=99s the difference in delta (whatever =E2=80=9Cdelta=E2=80=
=9D means here).  I
wouldn=E2=80=99t call it wrong.

We want to compare two test runs, so if both have the same delta, then
the difference in delta is 0.  That=E2=80=99s how understood it, hence my =
=E2=80=9C=CE=94=C2=B1=E2=80=9D
notation below.  (This may be useful information, because perhaps one
may consider a big delta bad, and so if one run has less delta than
another one, that may be considered a better outcoming.  Comparing
deltas has a purpose.)

I see I understood your intentions wrong, though; you want to just give
an error estimate for the difference of the means of both runs.  I have
to admit I don=E2=80=99t know how that works exactly, and it will probably
heavily depend on what =E2=80=9Cdelta=E2=80=9D is.

(Googling suggests that for the standard deviation, one would square
each SD to get the variance back, then divide by the respective sample
size, add, and take the square root.  But that=E2=80=99s for when you have =
two
distributions that you want to combine, but we want to compare here...
http://homework.uoregon.edu/pub/class/es202/ztest.html seems to suggest
the same for such a comparison, though.  I don=E2=80=99t know.)

(As for your current version, after more thinking it does seem right
when delta is the maximum deviation.  Or perhaps the deltas shouldn=E2=80=
=99t be
added then but the maximum should be used?  I=E2=80=99m just not sure.)

((Perhaps it doesn=E2=80=99t even matter.  =E2=80=9CDon=E2=80=99t believe a=
ny statistics you
haven=E2=80=99t forged yourself=E2=80=9D, and so on.))

Max


--dxW7WpltbzFmcFBt988J02jHiTtGsvUiu--

--ASwUzrSbWElZgWQWkel23npjHsEUQhQuW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl91kckACgkQ9AfbAGHV
z0A5uwgAkEr7Q+N4ZKkWDr45k2OfIHTiJhBMNP1DKXoBpo3/dh1TVKxPQvEGqe5d
Z0+2Jud166uddmtkjjtS8RIZEWwWJBufLw37C71Ulheel+zWzIV5tq0EgNirE6wQ
e3FuCycmZHmRU4cD3uSqZsOoHycaaUfBnjx2qEMGgkhxk3A4z37bJ9uS+jXQzbAK
c1IsDL+7InPzAFyI+LIi6l1Hidm/qZtz2H3QSaEqa6Bl9zk1ISjZ8uJUriFFpFqW
wLJmFGKRAmmm80ubKHKYQUTfQSnJY7jIFhVHY7uPTRiKc3Wqj9pZZI6Q2ntKNaUB
oVOV+m3QT5guOgzQpjJ++2Y2vwpEnw==
=3H9e
-----END PGP SIGNATURE-----

--ASwUzrSbWElZgWQWkel23npjHsEUQhQuW--


