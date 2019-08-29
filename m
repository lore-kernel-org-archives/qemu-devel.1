Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6123AC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 00:33:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32969214DA
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 00:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32969214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i38N9-0004Lo-Ab
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 20:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i38L8-0003Qj-9I
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 20:31:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i38L7-00064i-2t
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 20:31:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53210)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i38L3-00062l-3r; Wed, 28 Aug 2019 20:30:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E3DEB300BEA6;
 Thu, 29 Aug 2019 00:30:55 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 647135C1B5;
 Thu, 29 Aug 2019 00:30:50 +0000 (UTC)
To: John Snow <jsnow@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <1566834628-485525-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1566834628-485525-2-git-send-email-andrey.shinkevich@virtuozzo.com>
 <d04202ac-87ab-f226-0fc9-490d20f571fd@redhat.com>
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
Message-ID: <dd9f0ef8-d24c-29c3-6c48-809c9a4ac5d8@redhat.com>
Date: Wed, 28 Aug 2019 19:30:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d04202ac-87ab-f226-0fc9-490d20f571fd@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uUegk2yNC7C3Gph4ztntqhXOzgWuWLbxp"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 29 Aug 2019 00:30:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 1/6] iotests: allow Valgrind checking
 all QEMU processes
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uUegk2yNC7C3Gph4ztntqhXOzgWuWLbxp
Content-Type: multipart/mixed; boundary="eYqkC8uRkIAF3Cb6VzslnGWmbmnLgIlBH";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 mreitz@redhat.com
Message-ID: <dd9f0ef8-d24c-29c3-6c48-809c9a4ac5d8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 1/6] iotests: allow Valgrind checking all
 QEMU processes
References: <1566834628-485525-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1566834628-485525-2-git-send-email-andrey.shinkevich@virtuozzo.com>
 <d04202ac-87ab-f226-0fc9-490d20f571fd@redhat.com>
In-Reply-To: <d04202ac-87ab-f226-0fc9-490d20f571fd@redhat.com>

--eYqkC8uRkIAF3Cb6VzslnGWmbmnLgIlBH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/28/19 5:58 PM, John Snow wrote:

>> +++ b/tests/qemu-iotests/common.rc
>> @@ -60,61 +60,132 @@ if ! . ./common.config
>>      exit 1
>>  fi
>> =20
>> +# Unset the variables to turn Valgrind off for specific processes, e.=
g.

That's not unsetting, that's setting to the empty string.

>> +# $ VALGRIND_QEMU_IO=3D ./check -qcow2 -valgrind 015
>> +
>> +: ${VALGRIND_QEMU_VM=3D'y'}
>> +: ${VALGRIND_QEMU_IMG=3D'y'}
>> +: ${VALGRIND_QEMU_IO=3D'y'}
>> +: ${VALGRIND_QEMU_NBD=3D'y'}
>> +: ${VALGRIND_QEMU_VXHS=3D'y'}
>> +
>=20
> I have to admit to you that I'm not familiar with this trick. I'm
> looking it up and I see :=3D documented, but not =3D alone.

It's been a repeated complaint to the bash developer that the manual is
doing a disservice to its users by not documenting ${var=3Dval} in an
easily searchable form.  It IS documented, but only by virtue of
${var:=3Dval} occurring under a section header that states:

       When not performing substring expansion,  using  the  forms
documented
       below  (e.g.,  :-),  bash  tests for a parameter that is unset or
null.
       Omitting the colon results in a test  only  for  a  parameter
that  is
       unset.

So the choice is whether you want to special case a variable set to an
empty string the same as an unset variable, or the same as a variable
with a non-empty value.

>=20
> It doesn't seem documented here at all:
> https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expa=
nsion.html
>=20
> I see it here, though:
> https://www.tldp.org/LDP/abs/html/parameter-substitution.html
>=20
> And it seems to work, but I'm not sure if this works with BSD or OSX's
> sh. I see Eric comment on that compatibility a lot, so maybe I'll let
> him chime in.

It's quite portable; POSIX requires it, and autoconf relies on it.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--eYqkC8uRkIAF3Cb6VzslnGWmbmnLgIlBH--

--uUegk2yNC7C3Gph4ztntqhXOzgWuWLbxp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1nHLgACgkQp6FrSiUn
Q2p+3Af+O9njtDSfMov1GqNCEBMd6LsJRKuCsCHBe3fp6WkubqTlfEUNG8a8p3HH
+T0WBUf+h27RCSJn453UgH8Xt6LbhCg34MGQU+tpWRFBBye5XN7JUUVqc4GiHKL8
KWMyZDm0X96SufwUHwhdbDq7h2HBe9wUqD9QCFbMFblUhj4dfMFWFP6Pf24P+y2S
YRdr4s9CYGDAbFKVfR9pe6h3SnU+trVV6zsk4Zr0yjouZT0o5F+gRNRc3Ie6lQbw
H5eO6HX2wM3kDaQyav2UYgKGZjgXA5/3Gi7BAoU3sLRXbgYvPXESAN2quFT+uAYK
FE6iyrN45zljryuSmIdK/f+haEf/aQ==
=ovzF
-----END PGP SIGNATURE-----

--uUegk2yNC7C3Gph4ztntqhXOzgWuWLbxp--

