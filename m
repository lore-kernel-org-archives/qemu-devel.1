Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E812EC74A35
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:47:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE54F20844
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE54F20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlJVL-00041U-Hn
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 16:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37059)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hlJUV-0003Bk-Cg
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hlJUU-00081E-8f
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:47:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45552)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hlJUP-0007kB-Pc; Wed, 10 Jul 2019 16:46:59 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 624FA85538;
 Wed, 10 Jul 2019 20:46:53 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 76B9960BFC;
 Wed, 10 Jul 2019 20:46:47 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190710010556.32365-1-jsnow@redhat.com>
 <20190710010556.32365-9-jsnow@redhat.com>
 <8147a871-906b-2e97-86c1-fd8f32218960@redhat.com>
 <ec327b5f-bb53-61f7-19b6-f723c56ee09a@redhat.com>
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
Message-ID: <5ff7f740-f96d-928c-c88b-d3c277a7c944@redhat.com>
Date: Wed, 10 Jul 2019 22:46:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ec327b5f-bb53-61f7-19b6-f723c56ee09a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4azwtaLc3Gbp6BMqFovygGTFYFsMjveWP"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Wed, 10 Jul 2019 20:46:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 8/8] iotests/257: test traditional sync
 modes
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4azwtaLc3Gbp6BMqFovygGTFYFsMjveWP
Content-Type: multipart/mixed; boundary="E88Ut3Ti2bVs95V2CPZNareRTirK5y4WK";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <5ff7f740-f96d-928c-c88b-d3c277a7c944@redhat.com>
Subject: Re: [PATCH 8/8] iotests/257: test traditional sync modes
References: <20190710010556.32365-1-jsnow@redhat.com>
 <20190710010556.32365-9-jsnow@redhat.com>
 <8147a871-906b-2e97-86c1-fd8f32218960@redhat.com>
 <ec327b5f-bb53-61f7-19b6-f723c56ee09a@redhat.com>
In-Reply-To: <ec327b5f-bb53-61f7-19b6-f723c56ee09a@redhat.com>

--E88Ut3Ti2bVs95V2CPZNareRTirK5y4WK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.07.19 21:00, John Snow wrote:
>=20
>=20
> On 7/10/19 1:14 PM, Max Reitz wrote:
>> On 10.07.19 03:05, John Snow wrote:
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>  tests/qemu-iotests/257     |   31 +
>>>  tests/qemu-iotests/257.out | 3089 ++++++++++++++++++++++++++++++++++=
++
>>>  2 files changed, 3120 insertions(+)
>>
>> Oof.
>>
>=20
> Yeah, it's... a lot of test output. We probably shouldn't count the
> reference test output against any kind of SLOC metrics.
>=20
>>> diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
>>> index de8707cb19..8de1c4da19 100755
>>> --- a/tests/qemu-iotests/257
>>> +++ b/tests/qemu-iotests/257
>>
>> [...]
>>
>>> @@ -410,6 +416,11 @@ def test_bitmap_sync(bsync_mode, msync_mode=3D'b=
itmap', failure=3DNone):
>>>          if bsync_mode =3D=3D 'always' and failure =3D=3D 'intermedia=
te':
>>>              # We manage to copy one sector (one bit) before the erro=
r.
>>>              ebitmap.clear_bit(ebitmap.first_bit)
>>> +            if msync_mode in ('full', 'top'):
>>> +                # These modes return all bits set except what was co=
pied/skipped
>>
>> Hm.  How useful is bitmap support for 'top' then, anyway?  That means
>> that if you want to resume a top backup, you always have to resume it
>> like it was a full backup.  Which sounds kind of useless.
>>
>> Max
>>
>=20
> Good point!
>=20
> I think this can be fixed by doing an initialization pass of the
> copy_bitmap when sync=3Dtop to set only the allocated regions in the bi=
tmap.
>=20
> This means that the write notifier won't copy out regions that are
> written to that weren't already in the top layer. I believe this is
> actually a bugfix; the data we'd copy out in such cases is actually in
> the backing layer and shouldn't be copied with sync=3Dtop.

Now that you mention it...  I didn=E2=80=99t realize that.  Yes, you=E2=80=
=99re right.

> So this would have two effects:
> (1) sync=3Dtop gets a little more judicious about what it copies out on=

> sync=3Dtop, and
> (2) the bitmap return value is more meaningful again.
>=20
> This doesn't touch sync=3Dnone at all, which needs more invasive fixes =
if
> we wanted it to have useful bitmap return values (it needs to
> differentiate the idea between must-copy and can-copy, and I still don'=
t
> know if this is worthwhile to do, so until I hear otherwise, I'm not go=
nna.)

No, I=E2=80=99m with you on that one.

Max

>>> +                fail_bit =3D ebitmap.first_bit
>>> +                ebitmap.clear()
>>> +                ebitmap.dirty_bits(range(fail_bit, SIZE // GRANULARI=
TY))
>>>          ebitmap.compare(get_bitmap(bitmaps, drive0.device, 'bitmap0'=
))
>>> =20
>>>          # 2 - Writes and Reference Backup
>> [...]
>>



--E88Ut3Ti2bVs95V2CPZNareRTirK5y4WK--

--4azwtaLc3Gbp6BMqFovygGTFYFsMjveWP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0mTrUACgkQ9AfbAGHV
z0Cxnwf/XSEOwDZfOmgA/ZQTn+JH3HPe+0FV2HEB/bS1ZUGc3P1m6aVJru9c7fUF
P4M49B2S7lLTtzZoepbh9Dg61HLFrQxE0ceADiJd9HrrFtlowAclQvCvCH/9pyF+
VlZXSCTOLHh/oiOFztn2mlG+ITM8/qK+aPERk1bhObz2X/8sHIeXs//7RFM3z3X7
ySVJz274uAZVot21p2whwVp2oCkZLZJzDnc+Z6/kvBkMb0SPObnn9j+EtRJyqRxa
R/t/NIc07Ahz6Am1KOkhC6oVk2kJYd0yQN9iJBg8sZCv0zYMhp13GE7rfTOiSXbz
2YpujISq/cQIwp6E9FuNwWDS5i7QwQ==
=v+RE
-----END PGP SIGNATURE-----

--4azwtaLc3Gbp6BMqFovygGTFYFsMjveWP--

