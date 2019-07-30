Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80DBC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 13:15:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0598206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 13:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0598206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsRys-000464-0P
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 09:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45548)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hsRyI-0003IC-6D
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 09:15:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hsRyG-0002oq-SJ
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 09:15:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42060)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hsRyG-0002oT-K3
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 09:15:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F1FE530A7C62;
 Tue, 30 Jul 2019 13:15:14 +0000 (UTC)
Received: from [10.3.116.93] (ovpn-116-93.phx2.redhat.com [10.3.116.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4082210016E8;
 Tue, 30 Jul 2019 13:15:14 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20190726120542.9894-1-armbru@redhat.com>
 <20190726120542.9894-24-armbru@redhat.com>
 <20190729194414.GG4313@habkost.net> <87d0hreqh3.fsf_-_@dusky.pond.sub.org>
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
Message-ID: <8bea0201-f796-d682-22e6-069985b45523@redhat.com>
Date: Tue, 30 Jul 2019 08:15:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87d0hreqh3.fsf_-_@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GiGAccUTAzXyCh3SZjJMJLJJuepGav1TL"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 30 Jul 2019 13:15:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] When to use qemu/typedefs.h (was: [PATCH 23/28]
 numa: Don't include hw/boards.h into sysemu/numa.h)
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GiGAccUTAzXyCh3SZjJMJLJJuepGav1TL
Content-Type: multipart/mixed; boundary="ClrLSUI8Kyp4ADZSVEdAHcQDZL0BpZCSk";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Message-ID: <8bea0201-f796-d682-22e6-069985b45523@redhat.com>
Subject: Re: When to use qemu/typedefs.h (was: [Qemu-devel] [PATCH 23/28]
 numa: Don't include hw/boards.h into sysemu/numa.h)
References: <20190726120542.9894-1-armbru@redhat.com>
 <20190726120542.9894-24-armbru@redhat.com>
 <20190729194414.GG4313@habkost.net> <87d0hreqh3.fsf_-_@dusky.pond.sub.org>
In-Reply-To: <87d0hreqh3.fsf_-_@dusky.pond.sub.org>

--ClrLSUI8Kyp4ADZSVEdAHcQDZL0BpZCSk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/30/19 6:01 AM, Markus Armbruster wrote:
> Cc'ing a few more people who might be interested.
>=20
> Eduardo Habkost <ehabkost@redhat.com> writes:

>> Why is it bad to require the inclusion of hw/boards.h just
>> because of CPUArchId, but acceptable to require the inclusion of
>> qapi-types-machine.h just to be able to write "NodeInfo *nodes"
>> instead of "struct NodeInfo *nodes" below?
>=20
> hw/boards.h is worse.  Both headers pull in qapi/qapi-builtin-types.h
> and qapi/qapi-types-common.h, but hw/boards.h pulls in ~60 more.
>=20
> That doesn't mean including qapi/qapi-types-common.h is good.
>=20
> For better or worse[*], our coding style mandates typedefs.

I could live with a switch to kernel style of always writing the
'struct' at every use, instead of using typedefs; but it would have to
be a flag-day switchover, preferably aided by Coccinelle.  But I'm not
holding my breath for it happening.

>=20
> We generally declare a typedef name in exactly one place.  The obvious
> place is together with the type it denotes.
>=20
> Non-local users of the type then need to include the header that
> declares the typedef name.
>=20
> This can lead to inclusion cycles, in particular for complete struct an=
d
> union types that need more types for their members.
>=20
> We move typedefs to qemu/typedefs.h to break such cycles.
>=20
> We also do it to include less, for less frequent recompilation.  As thi=
s
> series demonstrates, we're not very good at that.  When to put a typede=
f
> in qemu/typedefs.h for this purpose is not obvious.  If we simply put
> all of them there, we'd recompile the world every time we add a typedef=
,
> which is pretty much exactly what we're trying to avoid.
>=20
> Some of qemu/typedefs.h's typedefs are used in dozens or even hundreds
> of other headers.  Quite a few only in one.  The latter likely should
> not be there.
>=20
> We occasionally give up and use types directly rather than their typede=
f
> names, flouting the coding style.  This patch does.  Trades messing wit=
h
> qemu/typedefs.h for having to write 'struct' a few times.
>=20
> Should we give up more?  Or not at all?
>=20
> Can we have some guidelines on proper use of qemu/typedefs.h?

How hard would it be to compute which typedefs already in
qemu/typedefs.h are necessary to avoid cyclic inclusion?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--ClrLSUI8Kyp4ADZSVEdAHcQDZL0BpZCSk--

--GiGAccUTAzXyCh3SZjJMJLJJuepGav1TL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1AQuAACgkQp6FrSiUn
Q2o+ggf/TesoySJfnygApMgPAYSuiOj9t6GL4tkrs8oYp03tE+Sr6FV/VBdkEBUI
glh0kmLgJpYyVxbtTg2RLKxjmwKyIo2T9lBycRIhnu35ZbdE3xnmycBZYQ5lYw/4
tcuu2hh/fv8fW8dEbZPQ8z8VatzcTyiLxUV/eJ5v5ZhY9v59yYEspOgKa4uJhT2R
QX2C7soySdO5D94JH7mE8I28DS4FCk/+DeaueH2pRZJs1NFaG4zqw2szbw7YMxVk
I/Jgq5FjvHYEHAZkiKXVrAdTYLfdy9TJXO3NsiL9KM0y9aaxxsWxdb9Ggu+PgcSK
5bR+ixYYfp8kEaVFEXj9SMkriYzNKA==
=P3pk
-----END PGP SIGNATURE-----

--GiGAccUTAzXyCh3SZjJMJLJJuepGav1TL--

