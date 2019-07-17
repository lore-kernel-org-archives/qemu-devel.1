Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0283CC76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 09:50:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCB6A20880
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 09:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB6A20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnga3-0008PC-M3
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 05:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43046)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hngZq-0007qn-5R
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 05:50:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hngZo-0006Gg-UC
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 05:50:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40654)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hngZm-0006D2-3Q; Wed, 17 Jul 2019 05:50:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BB203307D91E;
 Wed, 17 Jul 2019 09:50:16 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E0F1C608A6;
 Wed, 17 Jul 2019 09:50:11 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190716000117.25219-1-jsnow@redhat.com>
 <20190716000117.25219-12-jsnow@redhat.com>
 <9cf9c85d-c41e-123c-07cb-81c453363aea@redhat.com>
 <91af10c4-e4ff-df49-d1e9-31ea210fc637@redhat.com>
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
Message-ID: <0f773100-ecba-2d2a-8526-9fe980c6830a@redhat.com>
Date: Wed, 17 Jul 2019 11:50:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <91af10c4-e4ff-df49-d1e9-31ea210fc637@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NEVl8ziVwRmU0CO05KAvrWFSNI8U9EXWQ"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 17 Jul 2019 09:50:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 11/11] iotests/257: test traditional
 sync modes
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NEVl8ziVwRmU0CO05KAvrWFSNI8U9EXWQ
Content-Type: multipart/mixed; boundary="tO2hyOmUcKGubr40RMYw3g7kuNPGfACgn";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <0f773100-ecba-2d2a-8526-9fe980c6830a@redhat.com>
Subject: Re: [PATCH v2 11/11] iotests/257: test traditional sync modes
References: <20190716000117.25219-1-jsnow@redhat.com>
 <20190716000117.25219-12-jsnow@redhat.com>
 <9cf9c85d-c41e-123c-07cb-81c453363aea@redhat.com>
 <91af10c4-e4ff-df49-d1e9-31ea210fc637@redhat.com>
In-Reply-To: <91af10c4-e4ff-df49-d1e9-31ea210fc637@redhat.com>

--tO2hyOmUcKGubr40RMYw3g7kuNPGfACgn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16.07.19 18:58, John Snow wrote:
>=20
>=20
> On 7/16/19 8:04 AM, Max Reitz wrote:
>> On 16.07.19 02:01, John Snow wrote:
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>  tests/qemu-iotests/257     |   41 +-
>>>  tests/qemu-iotests/257.out | 3089 ++++++++++++++++++++++++++++++++++=
++
>>>  2 files changed, 3128 insertions(+), 2 deletions(-)
>>
>> This needs a %s/specify Bitmap sync mode/specify bitmap sync mode/.
>>
>>> diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
>>> index 53ab31c92e..c2a72c577a 100755
>>> --- a/tests/qemu-iotests/257
>>> +++ b/tests/qemu-iotests/257
>>
>> [...]
>>
>>> @@ -393,7 +399,7 @@ def test_bitmap_sync(bsync_mode, msync_mode=3D'bi=
tmap', failure=3DNone):
>>>              # group 1 gets cleared first, then group two gets writte=
n.
>>>              if ((bsync_mode =3D=3D 'on-success' and not failure) or
>>>                  (bsync_mode =3D=3D 'always')):
>>> -                ebitmap.clear_group(1)
>>> +                ebitmap.clear()
>>
>> Hmmm...  Why?
>>
>=20
> From an order of operations standpoint, if we are here, we are expectin=
g
> the bitmap to be synchronized. We can clear any existing data it holds,=

> and then:
>=20
>>>              ebitmap.dirty_group(2)
>>> =20
>=20
> Add new writes that occurred during the job; which only happen here in
> this callback.
>=20
> (The old code cleared specifically only group 1, the new code is just
> more general. I wound up changing it for a version that didn't make it
> to the list, but this is still correct.)
>=20
>>>          vm.run_job(job, auto_dismiss=3DTrue, auto_finalize=3DFalse,
>>> @@ -404,8 +410,19 @@ def test_bitmap_sync(bsync_mode, msync_mode=3D'b=
itmap', failure=3DNone):
>>>          log('')
>>> =20
>>>          if bsync_mode =3D=3D 'always' and failure =3D=3D 'intermedia=
te':
>>> +            # TOP treats anything allocated as dirty, expect to see:=

>>> +            if msync_mode =3D=3D 'top':
>>> +                ebitmap.dirty_group(0)
>>> +
>=20
> Sorry, this code is definitely in the "cute" category...
>=20
> If the failure was intermediate, we never call the pre-finalize callbac=
k
> above. So we know that the allocated regions of the file are only from
> groups 0 and 1.
>=20
> So, HERE, we can mark the emulated bitmap's group 0 as dirty, to mimic
> what the copy_bitmap is going to have started the operation with.
>=20
>>>              # We manage to copy one sector (one bit) before the erro=
r.
>>>              ebitmap.clear_bit(ebitmap.first_bit)
>=20
> And then right here, we clear the first bit which we did copy out
> successfully. The emulated bitmap is now correct for sync=3Dtop.
>=20
>>> +
>>> +            # Full returns all bits set except what was copied/skipp=
ed
>>> +            if msync_mode =3D=3D 'full':
>>> +                fail_bit =3D ebitmap.first_bit
>>> +                ebitmap.clear()
>>> +                ebitmap.dirty_bits(range(fail_bit, SIZE // GRANULARI=
TY))
>>> +
>=20
> The full mode, though, is special. We cleared the first allocated bit
> just like for sync=3Dtop, but we take note of the second bit which is t=
he
> one that caused the injected failure.
>=20
> For both 'top' and 'full' modes here we're really using the ebitmap as
> an allocation record to inform what the output bitmap is going to look =
like.
>=20
>>
>> So sync=3Dtop didn=E2=80=98t copy anything?  Is that because it now er=
rors out
>> before getting to copy something?
>>
>=20
> The ebitmap.clear_bit(ebitmap.first_bit) triggers for top, too. The tes=
t
> output should hopefully make sense here.

I...   I have no idea how I missed the ebitmap.clear_bit().

So with the test output fixed:

Reviewed-by: Max Reitz <mreitz@redhat.com>

>> (The rest looks good to me.)
>>
>> Max
>>
>>>          ebitmap.compare(get_bitmap(bitmaps, drive0.device, 'bitmap0'=
))
>>> =20
>>>          # 2 - Writes and Reference Backup
>>
>=20



--tO2hyOmUcKGubr40RMYw3g7kuNPGfACgn--

--NEVl8ziVwRmU0CO05KAvrWFSNI8U9EXWQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0u71EACgkQ9AfbAGHV
z0CPIAf/SZpGGK6h7+okxPu7BHFtM8QjFB+LgKaFqwjsR2A+8kAMfSLZ0ZOrR1mb
8NjfOPjSdXBlyA9yqom1xuZaDzGE7SRIZrd7O2WppkK9hbpN/cNlbVXxakIsGCwy
ZpBzwfpNZPXJNZd6dNodVfgPP+icf9HKVaxhwQmdH9n3aKN30Ks3TagetSwRxvAd
YuhHtKx/enrSoRUz17C+sknLG/NfRWeSQ9hrNKLQKzIv/vXnShPAV/vs3rghcwpE
49VJZtVBESJuy4nMo4YQ4WOxjCCoHYEV9mSURv+fSOJjfUFEo8l6hDbLBdFdd8L6
1obzQ6tGKexCTKxeyWz/Gk/JOWM+HQ==
=LbHy
-----END PGP SIGNATURE-----

--NEVl8ziVwRmU0CO05KAvrWFSNI8U9EXWQ--

