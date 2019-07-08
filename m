Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDBCC606BD
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 18:35:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48E4C21852
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 18:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E4C21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkYUJ-00030Q-I9
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 14:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51210)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hkYSU-0001wt-W1
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 14:33:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hkYST-0003KC-7C
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 14:33:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47312)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hkYSH-00033X-Ng; Mon, 08 Jul 2019 14:33:39 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 526DA81110;
 Mon,  8 Jul 2019 18:33:35 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-127.brq.redhat.com
 [10.40.204.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BD9376EAD9;
 Mon,  8 Jul 2019 18:33:27 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190703215542.16123-1-jsnow@redhat.com>
 <20190703215542.16123-10-jsnow@redhat.com>
 <b73e23a0-5454-c7d4-f1b3-da99e07b1edb@redhat.com>
 <987b304e-2ad6-3342-3825-5f8e7b7dd06a@redhat.com>
 <7ea8d028-dab7-8067-6f25-5029dafaed56@redhat.com>
 <7264e167-9b11-ae94-d83b-ca09667b0016@redhat.com>
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
Message-ID: <f9ad5af8-d94a-535b-1676-876065464650@redhat.com>
Date: Mon, 8 Jul 2019 20:33:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <7264e167-9b11-ae94-d83b-ca09667b0016@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fgb4laguVjA6GdRXrZRlIinItM9mIHDK2"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Mon, 08 Jul 2019 18:33:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 09/18] block/dirty-bitmap: add
 bdrv_dirty_bitmap_merge_internal
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fgb4laguVjA6GdRXrZRlIinItM9mIHDK2
Content-Type: multipart/mixed; boundary="RxF4D6py2XPU9GHj1zDwLc41HzFBAPmyg";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, vsementsov@virtuozzo.com,
 Xie Changlong <xiechanglong.d@gmail.com>
Message-ID: <f9ad5af8-d94a-535b-1676-876065464650@redhat.com>
Subject: Re: [PATCH v2 09/18] block/dirty-bitmap: add
 bdrv_dirty_bitmap_merge_internal
References: <20190703215542.16123-1-jsnow@redhat.com>
 <20190703215542.16123-10-jsnow@redhat.com>
 <b73e23a0-5454-c7d4-f1b3-da99e07b1edb@redhat.com>
 <987b304e-2ad6-3342-3825-5f8e7b7dd06a@redhat.com>
 <7ea8d028-dab7-8067-6f25-5029dafaed56@redhat.com>
 <7264e167-9b11-ae94-d83b-ca09667b0016@redhat.com>
In-Reply-To: <7264e167-9b11-ae94-d83b-ca09667b0016@redhat.com>

--RxF4D6py2XPU9GHj1zDwLc41HzFBAPmyg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08.07.19 20:24, John Snow wrote:
>=20
>=20
> On 7/8/19 7:44 AM, Max Reitz wrote:
>> On 05.07.19 18:45, John Snow wrote:
>>>
>>>
>>> On 7/4/19 12:49 PM, Max Reitz wrote:
>>>> On 03.07.19 23:55, John Snow wrote:
>>
>> [...]
>>
>>>>> +
>>>>> +/**
>>>>> + * bdrv_dirty_bitmap_merge_internal: merge src into dest.
>>>>> + * Does NOT check bitmap permissions; not suitable for use as publ=
ic API.
>>>>> + *
>>>>> + * @backup: If provided, make a copy of dest here prior to merge.
>>>>> + * @lock: If true, lock and unlock bitmaps on the way in/out.
>>>>> + * returns true if the merge succeeded; false if unattempted.
>>>>> + */
>>>>> +bool bdrv_dirty_bitmap_merge_internal(BdrvDirtyBitmap *dest,
>>>>> +                                      const BdrvDirtyBitmap *src,
>>>>> +                                      HBitmap **backup,
>>>>> +                                      bool lock)
>>>>> +{
>>>>> +    bool ret;
>>>>> +
>>>>> +    if (lock) {
>>>>> +        qemu_mutex_lock(dest->mutex);
>>>>> +        if (src->mutex !=3D dest->mutex) {
>>>>> +            qemu_mutex_lock(src->mutex);
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>
>>>> Why not check for INCONSISTENT and RO still?
>>>>
>>>> Max
>>>>
>>>
>>> Well. "why", I guess. The user-facing API will always use the
>>> non-internal version. This is the scary dangerous version that you do=
n't
>>> call unless you are Very Sure You Know What You're Doing.
>>>
>>> I guess I just intended for the suitability checking to happen in
>>> bdrv_dirty_bitmap_merge, and this is the implementation that you can
>>> shoot yourself in the foot with if you'd like.
>>
>> I=E2=80=99m asking because the reasoning behind being allowed to call =
this
>> function is that BUSY means someone who is not the monitor has exclusi=
ve
>> access to the bitmap, and that someone is the caller of this function.=

>>
>=20
> Unfortunately, there's no way mechanically to check that this is the
> exact circumstance the function is being called in. I have named it
> _internal and documented the source to explain when it's safe to use.
>=20
> We do not keep track of who set +BUSY and therefore who is allowed to
> call functions that normally prohibit that flag from being set.
>=20
> I don't think it's worth implementing that, either.

Fully agreed.  I meant to say that calling this function on a busy
bitmap is completely fine, so I understand why there is no check and I
wouldn=E2=80=99t add one.

>> There is no justification for why it should be allowed to call this
>> function for bitmaps that are inconsistent or read-only.  If someone
>> needs that, they should justify it with a patch, I think.
>=20
> The only caller here has already verified that this bitmap is not
> inconsistent or read-only (because the caller MADE the bitmap).

Which is why implementing it would be trivial, as the caller could just
pass &error_abort.

Well, or the function just asserts that !readonly && !inconsistent.
(Which would probably be better, because bdrv_dirty_bitmap_check() is
probably something better suited for external interfaces.  No need to
use it if all callers of bdrv_dirty_bitmap_merge_internal() only pass
&error_abort anyway.)

> Do you
> feel strongly enough that the check should be duplicated for this one
> particular function?

I don=E2=80=99t see a good reason not to.

I see a weak reason to add some form of a check (and be it just an
assertion), and that is that if someone needs to remove that check,
they=E2=80=99ll have to explicitly justify why that is OK.

Just like this patch justifies why it=E2=80=99s sometimes OK to call this=

function on a busy bitmap.


So I feel weakly.

> There are many other dirty bitmap functions that, because they are
> called as an interior function not directly invoked by the QMP API
> layer, do not do any such checking.

Some still contain assertions, though.

Max


--RxF4D6py2XPU9GHj1zDwLc41HzFBAPmyg--

--fgb4laguVjA6GdRXrZRlIinItM9mIHDK2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0jjHYACgkQ9AfbAGHV
z0Bhwgf+JOwjJYKfI+ams3SiyRvuEtO1ioucHEwJwVAmyc1Ma/nUVnjsQp7Ektbn
Gp+UBbyMjathoRBWFmXSdvNiRF7/bNdgCg3rj/B6qaKPZH0iTc1EMMMGACcieIOD
9NGkf7THqqlIYLg75JLz9XgY6c4PXOExqfBchIxgwJNVgj4cami0WYdmBhm9M7Ts
y4PAT49bIB5QBOBN5CnUCVnxUDgN6CXX017jgsfguZH3TzAHEpGy9Il9UnnG3zp6
K16Tq+nEmsldOP0O/f3B07FovrcSA0ogjfpqLTYbMEdQCmPn3ehb6Wv/WoKvg9B9
aTwBYHvRPijXdbOSGXP6nm0ee6VncQ==
=GZ3a
-----END PGP SIGNATURE-----

--fgb4laguVjA6GdRXrZRlIinItM9mIHDK2--

