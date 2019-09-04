Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CA7C3A5A8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 19:11:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09E5320820
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 19:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E5320820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5agg-0008Mw-Vm
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 15:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36884)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i5afK-0007Jy-O4
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:10:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i5afI-0005o8-54
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:10:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54160)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1i5afH-0005nt-T5
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:10:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1E1232A09B1
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2019 19:09:59 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DDC75C219;
 Wed,  4 Sep 2019 19:09:55 +0000 (UTC)
To: Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20190904130047.25808-1-thuth@redhat.com>
 <20190904130047.25808-6-thuth@redhat.com>
 <20190904185130.GE26826@stefanha-x1.localdomain>
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
Message-ID: <42f1e032-36de-2692-b425-9bb14303c9ea@redhat.com>
Date: Wed, 4 Sep 2019 14:09:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904185130.GE26826@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NUTDOflAYWjtEe7cPIIPUfOOD8IM6CorS"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Wed, 04 Sep 2019 19:09:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 5/6] tests/libqtest: Move global_test
 wrapper function into a separate header
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NUTDOflAYWjtEe7cPIIPUfOOD8IM6CorS
Content-Type: multipart/mixed; boundary="79kTHFPsFpVHTx8bfUGSd5UIbPtCK52oi";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <42f1e032-36de-2692-b425-9bb14303c9ea@redhat.com>
Subject: Re: [PATCH v2 5/6] tests/libqtest: Move global_test wrapper function
 into a separate header
References: <20190904130047.25808-1-thuth@redhat.com>
 <20190904130047.25808-6-thuth@redhat.com>
 <20190904185130.GE26826@stefanha-x1.localdomain>
In-Reply-To: <20190904185130.GE26826@stefanha-x1.localdomain>

--79kTHFPsFpVHTx8bfUGSd5UIbPtCK52oi
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/4/19 1:51 PM, Stefan Hajnoczi wrote:
> On Wed, Sep 04, 2019 at 03:00:46PM +0200, Thomas Huth wrote:
>> diff --git a/tests/libqtest-single.h b/tests/libqtest-single.h
>> new file mode 100644
>> index 0000000000..49259558a5
>> --- /dev/null
>> +++ b/tests/libqtest-single.h

>> +static inline QTestState *qtest_start(const char *args)
>> +{
>> +    global_qtest =3D qtest_init(args);
>=20
> Where are global_qtest and qtest_init() declared?  I would expect
> compilation to fail if a .c file included just "libqtest-single.h".

In patch 5, "libqtest.h" declares global_qtest, then includes
"libqtest-single.h"; no file includes it standalone.  Then in patch 6,
the roles are swapped; "libqtest-single.h" declares global_qtest and
includes "libqtest.h".  But yes, the commit message could do better in
explaining this.

> Missing #include?
>=20
> If this header is not supposed to be included by .c files, please
> include at least a comment or use a magic #define + #ifdef to prevent
> inclusion.

The condition is transient for one patch; but calling it out better in
the commit message and/or as a comment (especially since the #include
"libqtest-single.h" is not in the normal #includes up front) would help.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--79kTHFPsFpVHTx8bfUGSd5UIbPtCK52oi--

--NUTDOflAYWjtEe7cPIIPUfOOD8IM6CorS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1wDAIACgkQp6FrSiUn
Q2q+owf+IQm8tsNQIgxsQMORRll6vL2B/ctKb/j/+oFzqJMMaWCal5xv5UBNzrff
JeaQAVqjXcED/4mgIO++t1KKZh9CLFyI7OGANyDRHbvglHe3bYtgm+zabYQkqaZT
+ULh5UZ/HHBSD0aIseRYrWgOlOBlmRM1jBtS5Znu/NIhaIjWvRvTT97A64DjDcUU
UVC5sQ2yUergHoXyI70Lyb2lxzyFS6dvGI+y0gZttDWcJTtFRGEhJCmMNvmI5QQY
VhMUdI8TIYplJ9dl2xaFa+Cr6zsYg449gxZA6jPNebzLollCeO4MUSxsgmkRCgcH
I1cy1A35pAii2isuvmzqeAN0KlizcQ==
=1In6
-----END PGP SIGNATURE-----

--NUTDOflAYWjtEe7cPIIPUfOOD8IM6CorS--

