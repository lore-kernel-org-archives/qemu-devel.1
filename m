Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47F3C06513
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 15:20:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B105D218A0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 15:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B105D218A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hih3O-0004Z1-7p
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 11:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37236)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1higxT-0003NR-5R
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:14:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1higxM-0000f7-BL
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:14:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:30441)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1higwy-0000SO-Bi; Wed, 03 Jul 2019 11:13:39 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3912530C745E;
 Wed,  3 Jul 2019 15:13:19 +0000 (UTC)
Received: from [10.3.116.152] (ovpn-116-152.phx2.redhat.com [10.3.116.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2235919698;
 Wed,  3 Jul 2019 15:13:17 +0000 (UTC)
To: Denis Plotnikov <dplotnikov@virtuozzo.com>,
 "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com"
 <mreitz@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>
References: <20190703110044.25610-1-dplotnikov@virtuozzo.com>
 <20190703110044.25610-2-dplotnikov@virtuozzo.com>
 <f41f5552-a625-3306-ba3b-50d60dbefe22@redhat.com>
 <030cb268-263d-580b-bd75-ec3bc973799b@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=eblake@redhat.com; keydata=
 xsBNBEvHyWwBCACw7DwsQIh0kAbUXyqhfiKAKOTVu6OiMGffw2w90Ggrp4bdVKmCaEXlrVLU
 xphBM8mb+wsFkU+pq9YR621WXo9REYVIl0FxKeQo9dyQBZ/XvmUMka4NOmHtFg74nvkpJFCD
 TUNzmqfcjdKhfFV0d7P/ixKQeZr2WP1xMcjmAQY5YvQ2lUoHP43m8TtpB1LkjyYBCodd+LkV
 GmCx2Bop1LSblbvbrOm2bKpZdBPjncRNob73eTpIXEutvEaHH72LzpzksfcKM+M18cyRH+nP
 sAd98xIbVjm3Jm4k4d5oQyE2HwOur+trk2EcxTgdp17QapuWPwMfhaNq3runaX7x34zhABEB
 AAHNHkVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPsLAegQTAQgAJAIbAwULCQgHAwUV
 CgkICwUWAgMBAAIeAQIXgAUCS8fL9QIZAQAKCRCnoWtKJSdDahBHCACbl/5FGkUqJ89GAjeX
 RjpAeJtdKhujir0iS4CMSIng7fCiGZ0fNJCpL5RpViSo03Q7l37ss+No+dJI8KtAp6ID+PMz
 wTJe5Egtv/KGUKSDvOLYJ9WIIbftEObekP+GBpWP2+KbpADsc7EsNd70sYxExD3liwVJYqLc
 Rw7so1PEIFp+Ni9A1DrBR5NaJBnno2PHzHPTS9nmZVYm/4I32qkLXOcdX0XElO8VPDoVobG6
 gELf4v/vIImdmxLh/w5WctUpBhWWIfQDvSOW2VZDOihm7pzhQodr3QP/GDLfpK6wI7exeu3P
 pfPtqwa06s1pae3ad13mZGzkBdNKs1HEm8x6zsBNBEvHyWwBCADGkMFzFjmmyqAEn5D+Mt4P
 zPdO8NatsDw8Qit3Rmzu+kUygxyYbz52ZO40WUu7EgQ5kDTOeRPnTOd7awWDQcl1gGBXgrkR
 pAlQ0l0ReO57Q0eglFydLMi5bkwYhfY+TwDPMh3aOP5qBXkm4qIYSsxb8A+i00P72AqFb9Q7
 3weG/flxSPApLYQE5qWGSXjOkXJv42NGS6o6gd4RmD6Ap5e8ACo1lSMPfTpGzXlt4aRkBfvb
 NCfNsQikLZzFYDLbQgKBA33BDeV6vNJ9Cj0SgEGOkYyed4I6AbU0kIy1hHAm1r6+sAnEdIKj
 cHi3xWH/UPrZW5flM8Kqo14OTDkI9EtlABEBAAHCwF8EGAEIAAkFAkvHyWwCGwwACgkQp6Fr
 SiUnQ2q03wgAmRFGDeXzc58NX0NrDijUu0zx3Lns/qZ9VrkSWbNZBFjpWKaeL1fdVeE4TDGm
 I5mRRIsStjQzc2R9b+2VBUhlAqY1nAiBDv0Qnt+9cLiuEICeUwlyl42YdwpmY0ELcy5+u6wz
 mK/jxrYOpzXKDwLq5k4X+hmGuSNWWAN3gHiJqmJZPkhFPUIozZUCeEc76pS/IUN72NfprZmF
 Dp6/QDjDFtfS39bHSWXKVZUbqaMPqlj/z6Ugk027/3GUjHHr8WkeL1ezWepYDY7WSoXwfoAL
 2UXYsMAr/uUncSKlfjvArhsej0S4zbqim2ZY6S8aRWw94J3bSvJR+Nwbs34GPTD4Pg==
Organization: Red Hat, Inc.
Message-ID: <7c3620c5-039b-41e5-0b5e-cb80e60120ef@redhat.com>
Date: Wed, 3 Jul 2019 10:13:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <030cb268-263d-580b-bd75-ec3bc973799b@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EVEISg2YQVI5Y5YSp3FhmgAWEQZPRPBTj"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Wed, 03 Jul 2019 15:13:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1 1/3] qcow2: introduce compression type
 feature
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EVEISg2YQVI5Y5YSp3FhmgAWEQZPRPBTj
Content-Type: multipart/mixed; boundary="i1VawPQOvzUYRapr3X9NlxfWQ6T5mRcee";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>,
 "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com"
 <mreitz@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>
Cc: Denis Lunev <den@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <7c3620c5-039b-41e5-0b5e-cb80e60120ef@redhat.com>
Subject: Re: [PATCH v1 1/3] qcow2: introduce compression type feature
References: <20190703110044.25610-1-dplotnikov@virtuozzo.com>
 <20190703110044.25610-2-dplotnikov@virtuozzo.com>
 <f41f5552-a625-3306-ba3b-50d60dbefe22@redhat.com>
 <030cb268-263d-580b-bd75-ec3bc973799b@virtuozzo.com>
In-Reply-To: <030cb268-263d-580b-bd75-ec3bc973799b@virtuozzo.com>

--i1VawPQOvzUYRapr3X9NlxfWQ6T5mRcee
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/3/19 10:01 AM, Denis Plotnikov wrote:

>>> +     * with QCOW2_COMPRESSION_TYPE_ZLIB the corresponding incompatib=
le
>>> +     * feature flag must be absent, with other compression types the=

>>> +     * incompatible feature flag must be set
>> Is there a strong reason for forbid the incompatible feature flag with=

>> ZLIB?
> The main reason is to guarantee image opening for older qemu if=20
> compression type is zlib.
>> Sure, it makes the image impossible to open with older qemu, but
>> it doesn't get in the way of newer qemu opening it. I'll have to see h=
ow
>> your spec changes documented this, to see if you could instead word it=

>> as 'for ZLIB, the incompatible feature flag may be absent'.
> I just can't imagine when and why we would want to set incompatible=20
> feature flag with zlib. Suppose we have zlib with the flag set, then
> older qemu can't open the image although it is able to work with the=20
> zlib compression type. For now, I don't understand why we should make=20
> such an artificial restriction.

We have an artificial restriction one way or the other.

Method 1 - artificial restriction that incompatible bit must NOT be set
when compression type is zlib

Method 2 - artificial restriction that older qcow2 programs can't open a
zlib image with incompatible bit set, even though removing the bit makes
the image more portable.

It's desirable that qemu should NOT set the incompatible bit when it
does not need to (for the sake of portability to more apps), but
MANDATING that it must not set the bit for zlib is a stronger spec
restriction.

I tend to lean for the spec being looser unless there is a strong reason
for why it must be strict; just because qemu won't be setting the
incompatible bit does not necessarily mean that all other
implementations will try to be that careful; they may have valid reasons
for setting the bit even when using zlib, but only if the spec permits
them to do so.


>>> @@ -2434,6 +2493,13 @@ int qcow2_update_header(BlockDriverState *bs)
>>>       total_size =3D bs->total_sectors * BDRV_SECTOR_SIZE;
>>>       refcount_table_clusters =3D s->refcount_table_size >> (s->clust=
er_bits - 3);
>>>  =20
>>> +    ret =3D check_compression_type(s, NULL);
>> Why are you ignoring the error here?
> qcow2_update_header() doesn't use the error and just returns an error=20
> code or 0

Are we potentially losing a valuable error message (in which case
qcow2_update_header should maybe be first patched to take an errp
parameter), or is it always going to succeed (in which case &error_abort
would document our intention that we know it can't fail), or is it
really a case where it may fail, but we don't care about losing the
message?  Passing NULL is not wrong (as you say, we aren't plumbed to
pass the message back up to the caller), but does raise enough
suspicions as to be worth auditing the code while in the area.


>>> +        104 - 107:  compression_type
>>> +                    Defines the compression method used for compress=
ed clusters.
>>> +                    A single compression type is applied to all comp=
ressed image
>>> +                    clusters.
>>> +                    The compression type is set on image creation on=
ly.
>>> +                    The default compression type is zlib.
>> Where is the documentation that a value of 0 corresponds to zlib?
> Should I do it right here or it's better to add a separate chapter in=20
> the  docs/interop/qcow2.txt ?

Right here.


>>> +++ b/qapi/block-core.json
>>> @@ -78,6 +78,8 @@
>>>   #
>>>   # @bitmaps: A list of qcow2 bitmap details (since 4.0)
>>>   #
>>> +# @compression-type: the image cluster compression method (since 4.1=
)
>>> +#
>>>   # Since: 1.7
>>>   ##
>>>   { 'struct': 'ImageInfoSpecificQCow2',
>>> @@ -89,7 +91,8 @@
>>>         '*corrupt': 'bool',
>>>         'refcount-bits': 'int',
>>>         '*encrypt': 'ImageInfoSpecificQCow2Encryption',
>>> -      '*bitmaps': ['Qcow2BitmapInfo']
>>> +      '*bitmaps': ['Qcow2BitmapInfo'],
>>> +      '*compression-type': 'Qcow2CompressionType'
>> Why is this field optional? Can't we always populate it, even for olde=
r
>> images?
> Why we should if we don't care ?

Because it shows that we are running a new enough qemu that knows about
the compression field (even when it is absent).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--i1VawPQOvzUYRapr3X9NlxfWQ6T5mRcee--

--EVEISg2YQVI5Y5YSp3FhmgAWEQZPRPBTj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl0cxg0ACgkQp6FrSiUn
Q2oiMwf8CBNMnxMZKwaefVvpsOW8Pe9cpcKC92tHVw70G6daLSnXfNfxRHrXMhCZ
gK3HQKsBc9fVCWwze+O57C2IPu7GOOHgjUqAkJRrBT2p8rjm6iJerH/GDv8uByTn
LruMYPS17mz4QN8TUrYX+MOu2N1YsBBeHzDG/Cfse6aEv0X1u5PKGEjzi3xFsGH4
MI1kU6iYMrXf2FyLwhwt7R9xxRWa7+4h/BDHPYrS+PSb8EGnopdRIhJ7gPfltF9T
CFlG11B26/15sv4mgyzI4NHgqDBI6Z+MsyLHJO4hUHL4vqoTigslOMvjLCeY5KB7
qYNoOE/WJfNttdlzwAZ2zFFtSpJIyQ==
=QBsT
-----END PGP SIGNATURE-----

--EVEISg2YQVI5Y5YSp3FhmgAWEQZPRPBTj--

