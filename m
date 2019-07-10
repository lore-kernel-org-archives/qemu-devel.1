Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E60C74A36
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:39:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FEDA20651
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FEDA20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlJNd-0000u2-MK
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 16:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34134)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hlJN8-0000Lo-MN
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:39:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hlJN7-0006YW-Gn
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:39:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33994)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hlJN4-0006Vg-JB; Wed, 10 Jul 2019 16:39:22 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 55D2430C543C;
 Wed, 10 Jul 2019 20:39:21 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F14860BFB;
 Wed, 10 Jul 2019 20:39:17 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190710010556.32365-1-jsnow@redhat.com>
 <20190710010556.32365-8-jsnow@redhat.com>
 <01ddc5da-c4e1-864e-ee0d-e39036d6d4dd@redhat.com>
 <ad4d1652-3289-f050-28cb-337039413319@redhat.com>
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
Message-ID: <649d38b8-7641-e110-2554-fc322d1ef5fe@redhat.com>
Date: Wed, 10 Jul 2019 22:39:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ad4d1652-3289-f050-28cb-337039413319@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uoC1gcII2K3FylQB3u4CtyA38kLRbHYV8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Wed, 10 Jul 2019 20:39:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 7/8] block/backup: support bitmap sync
 modes for non-bitmap backups
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
--uoC1gcII2K3FylQB3u4CtyA38kLRbHYV8
Content-Type: multipart/mixed; boundary="cDDuegXvkExufScpqnn628wYj48coeaSV";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <649d38b8-7641-e110-2554-fc322d1ef5fe@redhat.com>
Subject: Re: [PATCH 7/8] block/backup: support bitmap sync modes for
 non-bitmap backups
References: <20190710010556.32365-1-jsnow@redhat.com>
 <20190710010556.32365-8-jsnow@redhat.com>
 <01ddc5da-c4e1-864e-ee0d-e39036d6d4dd@redhat.com>
 <ad4d1652-3289-f050-28cb-337039413319@redhat.com>
In-Reply-To: <ad4d1652-3289-f050-28cb-337039413319@redhat.com>

--cDDuegXvkExufScpqnn628wYj48coeaSV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.07.19 20:32, John Snow wrote:
>=20
>=20
> On 7/10/19 12:48 PM, Max Reitz wrote:
>> On 10.07.19 03:05, John Snow wrote:
>>> Accept bitmaps and sync policies for the other backup modes.
>>> This allows us to do things like create a bitmap synced to a full bac=
kup
>>> without a transaction, or start a resumable backup process.
>>>
>>> Some combinations don't make sense, though:
>>>
>>> - NEVER policy combined with any non-BITMAP mode doesn't do anything,=

>>>   because the bitmap isn't used for input or output.
>>>   It's harmless, but is almost certainly never what the user wanted.
>>>
>>> - sync=3DNONE is more questionable. It can't use on-success because t=
his
>>>   job never completes with success anyway, and the resulting artifact=

>>>   of 'always' is suspect: because we start with a full bitmap and onl=
y
>>>   copy out segments that get written to, the final output bitmap will=

>>>   always be ... a fully set bitmap.
>>>
>>>   Maybe there's contexts in which bitmaps make sense for sync=3Dnone,=

>>>   but not without more severe changes to the current job, and omittin=
g
>>>   it here doesn't prevent us from adding it later.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>  block/backup.c       |  8 +-------
>>>  blockdev.c           | 22 ++++++++++++++++++++++
>>>  qapi/block-core.json |  6 ++++--
>>>  3 files changed, 27 insertions(+), 9 deletions(-)
>>
>> [...]
>>
>>> diff --git a/blockdev.c b/blockdev.c
>>> index f0b7da53b0..bc152f8e0d 100644
>>> --- a/blockdev.c
>>> +++ b/blockdev.c
>>
>> [...]
>>
>>> +    if (!backup->has_bitmap && backup->has_bitmap_mode) {
>>> +        error_setg(errp, "Cannot specify Bitmap sync mode without a =
bitmap");
>>
>> Any reason for capitalizing the first =E2=80=9CBitmap=E2=80=9D?
>>
>> With a reason or it fixed:
>>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>
>=20
> Hanging around Germans too much?

You should know then that the korrekt way to write it would be:

=E2=80=9ESpecifying Binarydigitmapsynchronizationmode without a Binarydig=
itmap
is absolutely verboten!=E2=80=9C

> Actually, I can explain why: because a "bitmap" is a generic term, but
> whenever I capitalize it as "Bitmap" I am referring to a Block Dirty
> Bitmap which is a specific sort of thing. I do this unconsciously.
>=20
> But in that case, I should actually be consistent in the interface (and=

> docstrings and docs and error strings) and always call it that specific=

> thing, which I don't.
>=20
> "bitmap" is probably more correct for now, but I ought to go through al=
l
> the interface and make it consistent in some way or another.
>=20
>=20
> (Actually: I'd like to see if I can't rename the "BdrvDirtyBitmap"
> object to something more generic and shorter so I can rename many of th=
e
> functions we have something shorter.

Well, BDB is free.  That path has worked fine for BlockDriverStates.

Or what I said on IRC, but you know.

> Because the structure is "BdrvDirtyBitmap", there's some confusion when=

> we name functions like bdrv_dirty_bitmap_{verb} because it's not clear
> if this is a bdrv function that does something with dirty bitmaps, or i=
f
> it's a "BdrvDirtyBitmap" function that does something with that object.=

>=20
> I guess that seems like a subtle point, but it's why the naming
> conventions in dirty-bitmap.c are all over the place. I think at one
> point, the idea was that:
>=20
> bdrv_{verb}_dirty_bitmap was an action applied to a BDS that happened t=
o
> do something with dirty bitmaps. bdrv_dirty_bitmap_{verb} was an action=

> that applied to a "BdrvDirtyBitmap". Crystal clear and not confusing at=

> all, right?

I just thought people named their functions whatever they felt like at
the time.

> It'd be nice to have functions that operate on a node be named
> bdrv_dbitmap_foo() and functions that operate on the bitmap structure
> itself named just dbitmap_bar().
>=20
> Would it be okay if I named them such a thing, I wonder?
>=20
> we have "bitmap" and "hbitmap" already, I could do something like
> "dbitmap" for "dirty bitmap" or some such. Kind of an arbitrary change =
I
> admit, but I'm itching to do a big spring cleaning in dirty-bitmap.c
> right after this series is done.)

HBitmaps are generally used to track dirty areas, so I=E2=80=99d find thi=
s a
misnomer.  BDBitmap would be OK.  The =E2=80=9Cblock=E2=80=9D part should=
 be in there
somewhere.

Max


--cDDuegXvkExufScpqnn628wYj48coeaSV--

--uoC1gcII2K3FylQB3u4CtyA38kLRbHYV8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0mTPQACgkQ9AfbAGHV
z0BDIAf/YB/8iJGuMDNLwrkD11h/JDNriKvXG+WyrACyjHtVxsWzc9Vm4s+OJZLo
l751r6E0K49kUKbKrr7HE2LuTZbzmTuIFhSPxxmt9bpbYxWky9iHDZ08lrWOjLga
fjN6mlOFRSdIcse9t/XLeBRcsDr8YR7K9udT52S0aC3owBszlEeotQ1tKNFXMN+G
XF0xv9deQFBKpCImZRaZz9MgQupJPhshroQLcGbApuOSmZjzXcR78nS2TUUTqikr
/yWN/vy/4iCN86/YZDg84lqnwRkbscZVPz9oWvdsEGbepJj5YvviuL/WfaXlK2pn
i4a+fRzFXuev/xqN4bEYmoq/6Ierzw==
=Q3V1
-----END PGP SIGNATURE-----

--uoC1gcII2K3FylQB3u4CtyA38kLRbHYV8--

