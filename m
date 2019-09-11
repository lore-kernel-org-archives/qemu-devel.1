Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787B2C49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 17:49:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 515EF2081B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 17:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 515EF2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i86kS-0002Vi-H2
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 13:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54165)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i86jp-00027J-7A
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 13:49:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i86jm-0007RN-P3
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 13:49:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47118)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1i86jm-0007R7-Go
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 13:49:02 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C8C8D1DCC
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 17:49:01 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3300560C18;
 Wed, 11 Sep 2019 17:49:01 +0000 (UTC)
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, pbonzini@redhat.com, berrange@redhat.com,
 quintela@redhat.com
References: <20190911164202.31136-1-dgilbert@redhat.com>
 <20190911164202.31136-2-dgilbert@redhat.com>
 <1a03f787-5cf8-6b8e-7489-3f90c3311032@redhat.com>
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
Message-ID: <4c73915d-c4c8-0829-855b-ab5775d7e6fe@redhat.com>
Date: Wed, 11 Sep 2019 12:49:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1a03f787-5cf8-6b8e-7489-3f90c3311032@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5LWnm19geCQZ9RQGmZTdX1H4GFtZGjS8Y"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Wed, 11 Sep 2019 17:49:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/3] rcu: Add automatically released
 rcu_read_lock variant
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5LWnm19geCQZ9RQGmZTdX1H4GFtZGjS8Y
Content-Type: multipart/mixed; boundary="cmdP5ZJzxoP0LNsWnbDqCR3EUwJwfRczn";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, pbonzini@redhat.com, berrange@redhat.com,
 quintela@redhat.com
Message-ID: <4c73915d-c4c8-0829-855b-ab5775d7e6fe@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] rcu: Add automatically released
 rcu_read_lock variant
References: <20190911164202.31136-1-dgilbert@redhat.com>
 <20190911164202.31136-2-dgilbert@redhat.com>
 <1a03f787-5cf8-6b8e-7489-3f90c3311032@redhat.com>
In-Reply-To: <1a03f787-5cf8-6b8e-7489-3f90c3311032@redhat.com>

--cmdP5ZJzxoP0LNsWnbDqCR3EUwJwfRczn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/11/19 12:40 PM, Eric Blake wrote:

>> +
>> +#define RCU_READ_LOCK_AUTO g_auto(rcu_read_auto_t) \
>> +    _rcu_read_auto =3D 'x'; \
>=20
> I'm a bit lost at where _rcu_read_auto is declared.  (I could understan=
d
> if an earlier macro had created that typedef via concatenating _ with
> rcu_read_auto_t, but making the preprocessor drop _t is not possible. I=
s
> this a typo, and if so, why did the compiler not complain?)

Okay, I read it wrong.  This rendering would be easier for me to
understand (you are declaring a dummy variable right here):

#define RCU_READ_LOCK_AUTO \
    g_auto(rcu_read_auto_t) _rcu_read_auto =3D 'x'; \
=2E..

In other words, I'm not used to expecting a split between type and
variable name across two lines, especially when the type is itself a
macro call, and where my first reading didn't spot that
(rcu_read_auto_t) was not the name of the argument to a mixed-case macro
RCU_READ_LOACK_AUTO_g_auto, rather than g_auto(...) being the start of
the parameter-less macro RCU_READ_LOCK_AUTO definition.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--cmdP5ZJzxoP0LNsWnbDqCR3EUwJwfRczn--

--5LWnm19geCQZ9RQGmZTdX1H4GFtZGjS8Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl15M4wACgkQp6FrSiUn
Q2odlgf/cV4tZLbCZ/CgF/rjN3cDOy+O+MBgZC7iyxtRMh7REKYOu/RhJ80/rWyj
w08OishT0mlpPT3EU673C/dwiBx4LA7ri6J115RX94EU1yIHiRN3h77Nvm03/62/
P7KrTO0u1lNnsLz32Ph50n1LgJDzogpsGz2kHoFFTWvbbsHQixVcD6upd2k00TjT
jP6odvr44mjN5pUig6X9h34q9Ogd/h1ViM5TJIwNweViYHO2oUv9tSAEpK6rHK4N
J2OeocXSfSOzxS0BKQlvLEsTo9C/goEAKOEK/wMl9bUkayV5+8cIRgTh9cQ37h0w
2DgCxSzUPLUpavbA6rmqzDmJXRI9aA==
=wQ28
-----END PGP SIGNATURE-----

--5LWnm19geCQZ9RQGmZTdX1H4GFtZGjS8Y--

