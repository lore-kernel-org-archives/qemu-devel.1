Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC98C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 13:45:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83FE720650
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 13:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83FE720650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6EXv-0005tO-PP
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 09:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i6EXA-0005Rz-Jp
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 09:44:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i6EX8-0006Z0-Vq
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 09:44:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42150)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1i6EX8-0006Yi-OK
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 09:44:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C5B134E8AC;
 Fri,  6 Sep 2019 13:44:13 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F24885D9E5;
 Fri,  6 Sep 2019 13:44:08 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Tony Nguyen <tony.nguyen@bt.com>, qemu-devel@nongnu.org
References: <20190902012647.1761-1-tony.nguyen@bt.com>
 <41e61c1c-15b0-d028-fc23-52e2c59319d2@redhat.com>
 <93172f42-7506-65d0-5754-248c3fc31aa1@redhat.com>
 <867bdb4b-3eef-0660-6db2-a2e6a0ab5a0e@redhat.com>
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
Message-ID: <c1159dea-d68c-1143-a000-1320a1e39fb7@redhat.com>
Date: Fri, 6 Sep 2019 08:44:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <867bdb4b-3eef-0660-6db2-a2e6a0ab5a0e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Fri, 06 Sep 2019 13:44:13 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] memory: Set notdirty_mem_ops validator
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/6/19 8:24 AM, Philippe Mathieu-Daud=C3=A9 wrote:

>>>>  static const MemoryRegionOps notdirty_mem_ops =3D {
>>>>      .write =3D notdirty_mem_write,
>>>> -    .valid.accepts =3D notdirty_mem_accepts,
>>>>      .endianness =3D DEVICE_NATIVE_ENDIAN,
>>>>      .valid =3D {
>>>>          .min_access_size =3D 1,
>>>>          .max_access_size =3D 8,
>>>>          .unaligned =3D false,
>>>> +        .accepts =3D notdirty_mem_accepts,
>>>
>>> I'm surprised the compiler doesn't emit any warning...
>>
>> Same here.
>>
>> But reading
>> https://en.cppreference.com/w/c/language/struct_initialization, this i=
s
>> compliant behavior:
>>
>> "However, when an initializer begins with a left open brace, its curre=
nt
>> object is fully re-initialized and any prior explicit initializers for
>> any of its subobjects are ignored:"
>>
>> so it is worth filing a gcc bug asking for a QoI improvement in adding=
 a
>> warning (since the code does not violate the C standard, but does caus=
e
>> surprises in the reinitialization of omitted members in the later {} t=
o
>> go back to 0 in spite of the earlier initialization by nested name).
>=20
> Just remembered another case of (correct) reinitialization in
> hw/arm/palm.c:101:

We use nested reinitialization in multiple places. A gcc warning would
have to be discriminating enough to NOT warn merely when something is
listed twice...:

>=20
> static struct {
>     int row;
>     int column;
> } palmte_keymap[0x80] =3D {
>     [0 ... 0x7f] =3D { -1, -1 },
>     [0x3b] =3D { 0, 0 },	/* F1	-> Calendar */

Here, [0x3b].row and [0x3b].column are listed twice, but both of the
second listings are explicit.

Similarly, in qobject/json-lexer.c:

static const uint8_t json_lexer[][256] =3D  {
    /* Relies on default initialization to IN_ERROR! */
...

    /*
     * Two start states:
     * - IN_START recognizes JSON tokens with our string extensions
     * - IN_START_INTERP additionally recognizes interpolation.
     */
    [IN_START ... IN_START_INTERP] =3D {
        ['"'] =3D IN_DQ_STRING,
...
        ['\n'] =3D IN_START,
    },
    [IN_START_INTERP]['%'] =3D IN_INTERP,
};

Done that way on purpose (I actually remember scratching my head on the
best way to compress things while reviewing Markus' patch that ended up
as 2cbd15aa6f; it took me a couple of tries off-list to end up at that
override).

...rather, the gcc warning that I envision should ONLY be when a later
partial =3D{} causes a zero-initialization override of an earlier explici=
t
.member, and NOT when a later complete =3D{} or explicit member overrides
an earlier init (whether the earlier one was explicit due to .member or
implicit due to partial =3D{}).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

