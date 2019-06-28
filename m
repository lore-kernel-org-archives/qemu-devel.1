Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B424C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 19:39:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71FE120828
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 19:39:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71FE120828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgwis-0004GV-Oh
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 15:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58208)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hgwdZ-000104-Ar
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 15:34:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hgwdW-0001xK-Qc
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 15:34:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38802)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hgwdO-0001rR-Lq; Fri, 28 Jun 2019 15:34:10 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F151D316290D;
 Fri, 28 Jun 2019 19:34:08 +0000 (UTC)
Received: from [10.3.116.142] (ovpn-116-142.phx2.redhat.com [10.3.116.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E8E3519C59;
 Fri, 28 Jun 2019 19:34:07 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>
References: <20190528143727.10529-1-dplotnikov@virtuozzo.com>
 <20190528143727.10529-3-dplotnikov@virtuozzo.com>
 <20190628102333.GG5179@dhcp-200-226.str.redhat.com>
 <08da0859-10da-5d4b-3203-72341a166255@virtuozzo.com>
 <20190628120622.GI5179@dhcp-200-226.str.redhat.com>
 <4fef0430-5a0c-36ca-eec0-a2c0ce10cb91@virtuozzo.com>
 <20190628142437.GL5179@dhcp-200-226.str.redhat.com>
 <bf5134a7-7c5e-2b28-9acb-3b82df982e1e@virtuozzo.com>
 <20190628145419.GM5179@dhcp-200-226.str.redhat.com>
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
Message-ID: <9dea8cff-f540-3689-91d4-21afc5a4dd5e@redhat.com>
Date: Fri, 28 Jun 2019 14:34:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190628145419.GM5179@dhcp-200-226.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GRmsUCJH0fyJdddnwFdxOEveYzfnZfnyC"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 28 Jun 2019 19:34:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v0 2/3] qcow2: add compression type
 processing
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GRmsUCJH0fyJdddnwFdxOEveYzfnZfnyC
Content-Type: multipart/mixed; boundary="sVW6EfHQW62bO8UESNM9eaUJJ1qGKRfQt";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>
Cc: "mreitz@redhat.com" <mreitz@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <9dea8cff-f540-3689-91d4-21afc5a4dd5e@redhat.com>
Subject: Re: [PATCH v0 2/3] qcow2: add compression type processing
References: <20190528143727.10529-1-dplotnikov@virtuozzo.com>
 <20190528143727.10529-3-dplotnikov@virtuozzo.com>
 <20190628102333.GG5179@dhcp-200-226.str.redhat.com>
 <08da0859-10da-5d4b-3203-72341a166255@virtuozzo.com>
 <20190628120622.GI5179@dhcp-200-226.str.redhat.com>
 <4fef0430-5a0c-36ca-eec0-a2c0ce10cb91@virtuozzo.com>
 <20190628142437.GL5179@dhcp-200-226.str.redhat.com>
 <bf5134a7-7c5e-2b28-9acb-3b82df982e1e@virtuozzo.com>
 <20190628145419.GM5179@dhcp-200-226.str.redhat.com>
In-Reply-To: <20190628145419.GM5179@dhcp-200-226.str.redhat.com>

--sVW6EfHQW62bO8UESNM9eaUJJ1qGKRfQt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/28/19 9:54 AM, Kevin Wolf wrote:

>>>>>>> We would save most of this code if we added a new field to the he=
ader
>>>>>>> instead of adding a header extension. Not saying that we should
>>>>>>> definitely do this, but let's discuss it at least.
>>>>>>
>>>>>> If we add the new field to the header will the older qemu be able =
to use
>>>>>> it. Or we will add the header only if needed, i.e. if compression_=
type
>>>>>> !=3D zlib
>>>>>
>>>>> Increasing the header size is backwards compatible. Older qemu vers=
ions
>>>>> should handle such images correctly. They would store the unknown p=
art
>>>>> of the header in s->unknown_header_fields and keep it unmodified wh=
en
>>>>> updating the image header.
>>>>>
>>>>> We would still add the incompatible feature flag for non-zlib, of
>>>>> course.
>>>> so, we basically need to do the same: store compression type and for=
bid
>>>> to use because of flag if not zlib.
>>>>
>>>> Sounds like it doesn't differ that much from the extension header ap=
proach.
>>>
>>> It provides more or less the same functionality, but would probably m=
ake
>>> this patch half the size because all of the code related to reading a=
nd
>>> checking the header extension would go away. It also saves a few byte=
s
>>> in the header cluster (4 bytes vs. 16 bytes).
>> ok, will re-do it that way.
>>
>> Do you agree in general with how zlib compression type is treated?
>=20
> As I said, I think both ways are justifiable as long as we stay
> consistent between qemu and spec.
>=20
> I'd prefer to allow zlib in the extension, you'd prefer to forbid it.
> So I'd like to hear opinions from some more people on which way they
> prefer.

My preferences - use a 4 byte header field, and require the incompatible
feature bit if the field is non-zero. The standard should allow someone
to explicitly request zlib compression (done by leaving the incompatible
bit clear, then specifying a header length of 108 instead of 104, but
leaving the compression field at 104-107 at 0), to implicitly request
zlib compression (done by leaving the incompatible bit clear, and
specifying a header length of 104); or to explicitly request some other
compression (done by setting the incompatible bit, specifying a header
length of 108, and putting a non-zero value in the compression field
104-107).

Under these rules, if you implicitly or explicitly request zlib, your
image can be opened without problems by both older and newer qemu.  If
you explicitly request zstd, your image will fail to open by older qemu
(good, because they would misinterpret compressed clusters), and work
with newer qemu.  And since providing a 108-byte header works just fine
with older qemu as long as the header contains 0, I recommend that we
just always make newer qemu provide that field (even if it is explicitly
set to zlib), as that is less complicated than only providing the larger
header for non-zlib files (we still have to parse 104-byte headers, but
that doesn't mean we have to create brand-new files that way).

There's one more corner case. I recommend that the standard require that
it be an error to set the incompatible feature bit but use a header size
of 104 - if you have an imabe like that, the image would be treated as
using zlib (implicitly due to the header size), so older images _could_
use it other than the fact that they don't recognize the incompatible
feature bit.  On the other hand, requiring such an image to be rejected
is a bit of a stretch - no qemu (whether one that understands the
feature bit or one that does not) would misinterpret the image contents
as being zlib compressed, if it had not been for the bit being set.  So
in this corner case, I'm fine if you end up documenting whatever is
easiest to code.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--sVW6EfHQW62bO8UESNM9eaUJJ1qGKRfQt--

--GRmsUCJH0fyJdddnwFdxOEveYzfnZfnyC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl0Wa6kACgkQp6FrSiUn
Q2r0kwf+PxsBohkWSYtnkkPr+T+H11xAJjzIHBTMH61oquHRBqj0HgPLmUSrhD+J
wdYSxv6iD9JJQOZ1BuYv2vHoT7rxfeVYtSXsprHGwSZLiMtj8IiVtAY5mk3m89Us
Sa/Ok1pg4jl1TfLR6ptVsahGKuCAdnJ329800JXnly9L5X1p0x800+WjZdwO6vnu
3xrDojNADHBWHrzuNZGeppqZCk8T29pHL7GjwE0sPzGKzq5A35s+2OAg73UiLnoT
x2yOcVUqsIZ3nc6K7of7wpmD2O/iLr0QTgz74DjDyU0FeI34xNzhuaGN5s8t0VhT
lo7tUlDfCAgShNj4V2KFVyK+hPORcA==
=NWNz
-----END PGP SIGNATURE-----

--GRmsUCJH0fyJdddnwFdxOEveYzfnZfnyC--

