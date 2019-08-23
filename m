Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BBBC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:23:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61C0121726
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C0121726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1CLT-0005A9-JA
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 12:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i1CK7-0004Hw-0U
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:22:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i1CK5-0001a0-P4
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:21:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57715)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1i1CK5-0001ZJ-GE
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:21:57 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CAF5D11A13;
 Fri, 23 Aug 2019 16:21:56 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 853F2261C2;
 Fri, 23 Aug 2019 16:21:51 +0000 (UTC)
To: Wei Yang <richard.weiyang@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20190621142739.23703-1-richardw.yang@linux.intel.com>
 <20190819112632.GA2765@work-vm> <20190819140828.otv7vq5lahvquczl@master>
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
Message-ID: <12c6eab2-7988-cdb9-ab54-ae052cd45188@redhat.com>
Date: Fri, 23 Aug 2019 11:21:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819140828.otv7vq5lahvquczl@master>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KuG3ysc4AfR8kkSJreUh0XMvKR9YDOff2"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 23 Aug 2019 16:21:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] migrtion: define
 MigrationState/MigrationIncomingState.state as MigrationStatus
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
Cc: qemu-devel@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KuG3ysc4AfR8kkSJreUh0XMvKR9YDOff2
Content-Type: multipart/mixed; boundary="urzgk2GwXqXKXoAqnYihrAi0b3rzPdfyU";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Wei Yang <richard.weiyang@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: quintela@redhat.com, Wei Yang <richardw.yang@linux.intel.com>,
 qemu-devel@nongnu.org
Message-ID: <12c6eab2-7988-cdb9-ab54-ae052cd45188@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migrtion: define
 MigrationState/MigrationIncomingState.state as MigrationStatus
References: <20190621142739.23703-1-richardw.yang@linux.intel.com>
 <20190819112632.GA2765@work-vm> <20190819140828.otv7vq5lahvquczl@master>
In-Reply-To: <20190819140828.otv7vq5lahvquczl@master>

--urzgk2GwXqXKXoAqnYihrAi0b3rzPdfyU
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/19/19 9:08 AM, Wei Yang wrote:
> On Mon, Aug 19, 2019 at 12:26:32PM +0100, Dr. David Alan Gilbert wrote:=

>> * Wei Yang (richardw.yang@linux.intel.com) wrote:

Typo in the subject line: migrtion should be migration

>>> No functional change. Add default case to fix warning.
>>
>> I think the problem with this is that migrate_set_state uses an
>> atomic_cmpxchg and so we have to be careful that the type we use
>> is compatible with that.
>> MigrationStatus is an enum and I think compilers are allowed to
>> choose the types of that;  so I'm not sure we're guaranteed
>> that an enum is always OK for the atomic_cmpxchg, and if it is
>=20
> Took a look into the definition of atomic_cmpxchg, which finally calls
>=20
>   * __atomic_compare_exchange_n for c++11
>   * __sync_val_compare_and_swap

Those are compiler-defined macros, so you have to consult the compiler
documentation to see if they state what happens when invoked on an enum
type.  You also have to check whether our macro
typeof_strip_qual(enum_type) produces 'int' or something else.

C99 doesn't specify _Atomic at all (which is why we handrolled our own
atomic.h built on top of compiler primitives, instead of using
<stdatomic.h>).  But reading C11, I see that 6.7.2.4 states that
_Atomic(type) is okay except for:

"The type name in an atomic type specifier shall not refer to an array
type, a function type, an atomic type, or a qualified type."

which does NOT preclude the use of _Atomic(enum_type), so presumably
compilers have to be prepared to handle an atomic enum type.  Still,
it's rather shaky ground if you can't prove compilers handle it correctly=
=2E


>=20
> Both of them take two pointers to compare and exchange its content.
>=20
> Per C99 standard, http://www.open-std.org/JTC1/SC22/WG14/www/docs/n1256=
=2Epdf,
> it mentioned:
>=20
>   Each enumerated type shall be compatible with char, a signed integer =
type,
>   or an unsigned integer type. The choice of type is implementation-def=
ined,
>   but shall be capable of representing the values of all the members of=
 the
>   enumeration.
>=20
> Based on this, I think atomic_cmpxchg should work fine with enum.

What C99 says is rather weak; you really want to be basing your
decisions on atomics based on C11 or later.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--urzgk2GwXqXKXoAqnYihrAi0b3rzPdfyU--

--KuG3ysc4AfR8kkSJreUh0XMvKR9YDOff2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1gEp4ACgkQp6FrSiUn
Q2r4SQgApHCELtVYNZj/yRnKomVoyn5JhMp1haVvfuVYhk8lb78B2aHJ+9OwG9oc
9sbnCtuYR0n8mMe6irqPGoW2jaqAcJzCL1FXGdAIoHoY82I6FOP2UMIDKEwXLYKb
Jfj4Bjt7i409PremO4Zba08zXDL1SDFw6Hh5bOhJnb//OqbAdcylCfAup4xrCR2C
zSvwQamfV7xCU29w8rdOWVBql8llkX7CvcaN8v7Q9sKrRFmfVw+r9gZERraehBf6
Ge9F5GRRPzApnlBOS+FlMndCcbY5Xd7nO1Bu+b0Im2oFG25ev9n7BVUzxYbBbzvX
BppaByqslLAEWu8ikNZrnUKhb3m2/A==
=+yIM
-----END PGP SIGNATURE-----

--KuG3ysc4AfR8kkSJreUh0XMvKR9YDOff2--

