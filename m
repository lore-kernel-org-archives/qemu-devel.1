Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFF2C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 15:03:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF42B20656
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 15:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF42B20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyHHH-0007nH-F5
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 11:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1hyHFJ-0006LN-Dk
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 11:01:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hyHFD-0008Io-NG
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 11:00:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39350)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hyHEu-00088B-EY; Thu, 15 Aug 2019 11:00:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2F461315C020;
 Thu, 15 Aug 2019 15:00:31 +0000 (UTC)
Received: from [10.3.117.22] (ovpn-117-22.phx2.redhat.com [10.3.117.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F0388424B;
 Thu, 15 Aug 2019 15:00:16 +0000 (UTC)
To: Maxim Levitsky <mlevitsk@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <d0635a23-7f99-9cf7-500c-af668e8ca370@redhat.com>
 <20190815091039.GA7415@linux.fritz.box> <87y2zuy0k7.fsf@dusky.pond.sub.org>
 <2561ace5297c93cee597c776230dcb8f457a8561.camel@redhat.com>
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
Message-ID: <414e8dab-b19b-fd47-52eb-db43ae75ec07@redhat.com>
Date: Thu, 15 Aug 2019 10:00:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <2561ace5297c93cee597c776230dcb8f457a8561.camel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="q3VMePz5O2NohIaRozoJ8nCwYNnEkUhBX"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 15 Aug 2019 15:00:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 00/13] RFC: luks/encrypted qcow2 key
 management
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Daniel_P=2eBerrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--q3VMePz5O2NohIaRozoJ8nCwYNnEkUhBX
Content-Type: multipart/mixed; boundary="s1W0VZbtAVFMh4ZNmI4jOfDEL1ku0jgGu";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Daniel_P=2eBerrang=c3=a9?=
 <berrange@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <414e8dab-b19b-fd47-52eb-db43ae75ec07@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/13] RFC: luks/encrypted qcow2 key
 management
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <d0635a23-7f99-9cf7-500c-af668e8ca370@redhat.com>
 <20190815091039.GA7415@linux.fritz.box> <87y2zuy0k7.fsf@dusky.pond.sub.org>
 <2561ace5297c93cee597c776230dcb8f457a8561.camel@redhat.com>
In-Reply-To: <2561ace5297c93cee597c776230dcb8f457a8561.camel@redhat.com>

--s1W0VZbtAVFMh4ZNmI4jOfDEL1ku0jgGu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/15/19 9:44 AM, Maxim Levitsky wrote:

>>>> Does the idea of a union type with a default value for the discrimin=
ator
>>>> help?  Maybe we have a discriminator which defaults to 'auto', and a=
dd a
>>>> union branch 'auto':'any'.  During creation, if the "driver":"auto"
>>>> branch is selected (usually implicitly by omitting "driver", but als=
o
>>>> possible explicitly), the creation attempt is rejected as invalid
>>>> regardless of the contents of the remaining 'any'.  But during amend=

>>>> usage, if the 'auto' branch is selected, we then add in the proper
>>>> "driver":"xyz" and reparse the QAPI object to determine if the remai=
ning
>>>> fields in 'any' still meet the specification for the required driver=
 branch.
>>>>
>>>> This idea may still require some tweaks to the QAPI generator, but i=
t's
>>>> the best I can come up with for a way to parse an arbitrary JSON obj=
ect
>>>> with unknown validation, then reparse it again after adding more
>>>> information that would constrain the parse differently.
>>>
>>> Feels like this would be a lot of code just to allow the client to om=
it
>>> passing a value that it knows anyway. If this were a human interface,=
 I
>>> could understand the desire to make commands less verbose, but for QM=
P I
>>> honestly don't see the point when it's not trivial.
>>
>> Seconded.
>=20
>=20
> But what about my suggestion of adding something like:
>=20
> { 'union': 'BlockdevAmendOptions',
>=20
>   'base': {
>       'node-name':         'str' },
>=20
>   'discriminator': { 'get_block_driver(node-name)' } ,

Not worth it. It makes the QAPI generator more complex (to invoke
arbitrary code instead of a fixed name) just to avoid a little bit of
complexity in the caller (which is assumed to be a computer, and thus
shouldn't have a hard time providing a sane 'driver' unconditionally).
An HMP wrapper around the QMP command can do whatever magic it needs to
omit driver, but making driver mandatory for QMP is just fine.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--s1W0VZbtAVFMh4ZNmI4jOfDEL1ku0jgGu--

--q3VMePz5O2NohIaRozoJ8nCwYNnEkUhBX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1Vc38ACgkQp6FrSiUn
Q2rCMgf/Z3IdCIkB2hWwkbNCh5GD/RSJ5DgLD4xZINb07+r2Uai6DfnORYbBjjbq
Bh5LYn6Y/dC744fA7Q5A+98ShQDBwl8KzrTyBmZWsxaG4AWPeAgcSNBgvYGy1sIq
CAv1em6DATzNi+x4p1OT6ftChVqgmjRy/yeK+GkF8OYaUI9esHT+VXQ1v8rtmVam
biU8rfFVm8i61qiPkzO7TUY8F/LEohtNWQYoZioTtKBtR5a+r55BEGQm3oPMlL6R
F8BqXh2GV1aZuqo7gblhJGnRcygdmrTqkX+X1Q/AsR0ImVMJp5eR+ZSjluyRH1/U
B4H9mqWWPI6f2AU4M0WzLt1lqafqLA==
=mv3e
-----END PGP SIGNATURE-----

--q3VMePz5O2NohIaRozoJ8nCwYNnEkUhBX--

