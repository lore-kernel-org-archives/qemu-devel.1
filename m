Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7785EC4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:27:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C2F520665
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C2F520665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAGKO-0005xs-1S
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 12:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iAG80-0003ZZ-Sx
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:14:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iAG7z-0000x5-RG
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:14:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58534)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iAG7z-0000vh-Io
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:14:55 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E071B81DF1;
 Tue, 17 Sep 2019 16:14:54 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B60F860126;
 Tue, 17 Sep 2019 16:14:51 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>
References: <20190910063724.28470-1-armbru@redhat.com>
 <20190910063724.28470-16-armbru@redhat.com>
 <1b10e16d-9377-38ae-08ce-3bc0f8fc39d2@redhat.com>
 <8736h08asx.fsf@dusky.pond.sub.org>
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
Message-ID: <a354d2d6-7633-f95c-eb86-45a60d28e43e@redhat.com>
Date: Tue, 17 Sep 2019 11:14:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8736h08asx.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mryZz0rWAhSZ39AwagTHA8dyu3M1NDn9x"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 17 Sep 2019 16:14:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 15/16] docs/devel/qapi-code-gen: Improve
 QAPI schema language doc
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
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mryZz0rWAhSZ39AwagTHA8dyu3M1NDn9x
Content-Type: multipart/mixed; boundary="6JviPCnUfBR3spgo7gzADcxTDUD3vSzjn";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com,
 mdroth@linux.vnet.ibm.com
Message-ID: <a354d2d6-7633-f95c-eb86-45a60d28e43e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 15/16] docs/devel/qapi-code-gen: Improve
 QAPI schema language doc
References: <20190910063724.28470-1-armbru@redhat.com>
 <20190910063724.28470-16-armbru@redhat.com>
 <1b10e16d-9377-38ae-08ce-3bc0f8fc39d2@redhat.com>
 <8736h08asx.fsf@dusky.pond.sub.org>
In-Reply-To: <8736h08asx.fsf@dusky.pond.sub.org>

--6JviPCnUfBR3spgo7gzADcxTDUD3vSzjn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/13/19 10:39 AM, Markus Armbruster wrote:

>>> +  expression A; expression A, ... likewise, but separated by ,
>>
>> worth calling out that trailing , are not allowed?
>=20
> Doesn't "separated by" imply that?
>=20
>> Is the 'expression A;' a copy-paste from RFC text, irrelevant to our
>> usage here?
>=20
> What about
>=20
>     * Repetition: Expression A... matches zero or more occurences of
>       expression A
>     * Repetition: Expression A, ... matches zero or more occurences of
>       expression A separated by ,

With the spelling of 'occurrences' fixed, that works.


>>> +The top-level expressions are all JSON objects.  Their order does no=
t
>>> +matter.
>>
>> Is that always true for all directives?
>=20
> Yes from a purely semantic point of view.
>=20
> No when you look at the generated text: that's in source order.  Should=

> not matter for C.  Does matter for documentation.
>=20
> See also discussion of previous patch.
>=20
>> Would it be worth reformulating as something like:
>>
>> SCHEMA =3D DIRECTIVE... DEFINITION...
>>
>> allowing zero-or-more of either, but where directives come first?
>=20
> Language change.  Not sure anything outside tests would break.  But why=

> bother?

Fair enough.


>>> +Each BRANCH of the 'data' object defines a branch of the union.  A
>>> +union must have at least one branch.
>>
>> Is it worth trying to represent one-or-more in the grammar, in a
>> different manner than zero-or-more?
>=20
> If we needed it multiple times, then something like
>=20
>     * Repetition: Expression A * matches zero or more occurences of
>       expression A
>     * Repetition: Expression A, * matches zero or more occurences of
>       expression A separated by ,
>     * Repetition: Expression A + matches one or more occurences of
>       expression A
>     * Repetition: Expression A, + matches one or more occurences of
>       expression A separated by ,
>=20
> could be helpful.  But I can't see the need right now.

Again with the typo. But I also agree that it's not needed right now.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--6JviPCnUfBR3spgo7gzADcxTDUD3vSzjn--

--mryZz0rWAhSZ39AwagTHA8dyu3M1NDn9x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl2BBnoACgkQp6FrSiUn
Q2rz1wgAnk5zhfPtqGH9eGoihO/hUJSOnYMziaVIwYkApO+GUukvfVfQeOOQuAjn
ZkHo1WPaAfmoedkQ2rqfBG/F4jEjqDPVu5pE/soyZbHaLplolmWGMfS3SVfGzDp1
km8Zw7jh7MADlsNF+K9KCz1jrsJzbhtbeos+ebD0emJhs/dWOAjIIb9gNb6xE4j7
V/qCWEBhx1GpczeNm4hhaSNNilKKvbuQmI0GxA9Rni84bzjS0bLoDvAAomSyNrJX
iIl5kTiujKlTC+lEBY5vHwFZMnmXycqGAJ5k3PwSILakJ2q7wZzaevMXCDZLuJ4o
082nK9oiClsZAwxDuYImk4gndO3oHA==
=NWEv
-----END PGP SIGNATURE-----

--mryZz0rWAhSZ39AwagTHA8dyu3M1NDn9x--

