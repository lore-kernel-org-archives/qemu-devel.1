Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C6CC3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 14:24:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F13A822CED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 14:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F13A822CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5WCj-0000Jv-3k
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 10:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i5WC1-0008GZ-AP
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 10:23:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i5WBz-0004ZI-Qx
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 10:23:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33598)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1i5WBz-0004Yw-GV
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 10:23:27 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A586E307D868
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2019 14:23:26 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 743FF1001947;
 Wed,  4 Sep 2019 14:23:22 +0000 (UTC)
To: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org
References: <20190904130047.25808-1-thuth@redhat.com>
 <20190904130047.25808-6-thuth@redhat.com>
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
Message-ID: <f374e357-8822-52c4-ff8d-44f9790565c7@redhat.com>
Date: Wed, 4 Sep 2019 09:23:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904130047.25808-6-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="25GrX05xG9gAtR0ZHBKdM2aOL2mXKrqoT"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 04 Sep 2019 14:23:26 +0000 (UTC)
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--25GrX05xG9gAtR0ZHBKdM2aOL2mXKrqoT
Content-Type: multipart/mixed; boundary="AWD9Xe3eH02vpd1mbat9LtN1pxMSjKkAt";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <f374e357-8822-52c4-ff8d-44f9790565c7@redhat.com>
Subject: Re: [PATCH v2 5/6] tests/libqtest: Move global_test wrapper function
 into a separate header
References: <20190904130047.25808-1-thuth@redhat.com>
 <20190904130047.25808-6-thuth@redhat.com>
In-Reply-To: <20190904130047.25808-6-thuth@redhat.com>

--AWD9Xe3eH02vpd1mbat9LtN1pxMSjKkAt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/4/19 8:00 AM, Thomas Huth wrote:
> We want libqtest.h to become completely independen from global_qtest

independent

> (so that the wrapper functions are not used by accident anymore). As
> a first step, move the wrapper functions into a separate header file.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS             |   2 +-
>  tests/libqtest-single.h | 311 ++++++++++++++++++++++++++++++++++++++++=

>  tests/libqtest.c        |  11 --
>  tests/libqtest.h        | 287 +-----------------------------------
>  4 files changed, 313 insertions(+), 298 deletions(-)
>  create mode 100644 tests/libqtest-single.h
>=20

> +/**
> + * qmp:
> + * @fmt...: QMP message to send to qemu, formatted like
> + * qobject_from_jsonf_nofail().  See parse_escape() for what's
> + * supported after '%'.
> + *
> + * Sends a QMP message to QEMU and returns the response.
> + */
> +GCC_FMT_ATTR(1, 2)
> +static inline QDict *qmp(const char *fmt, ...)
> +{

I'm a bit surprised gcc doesn't complain about inlining a va_arg
function, but since it works, I'm fine with the approach.

> +++ b/tests/libqtest.c
> @@ -1106,17 +1106,6 @@ void qtest_memset(QTestState *s, uint64_t addr, =
uint8_t pattern, size_t size)
>      qtest_rsp(s, 0);
>  }
> =20
> -QDict *qmp(const char *fmt, ...)
> -{
> -    va_list ap;
> -    QDict *response;
> -
> -    va_start(ap, fmt);
> -    response =3D qtest_vqmp(global_qtest, fmt, ap);
> -    va_end(ap);
> -    return response;
> -}
> -

Nice - we've reduced the use of global_qtest to just a single optional
header!

> +++ b/tests/libqtest.h

> -/**
> - * clock_step:
> - * @step: Number of nanoseconds to advance the clock by.
> - *
> - * Advance the QEMU_CLOCK_VIRTUAL by @step nanoseconds.
> - *
> - * Returns: The current value of the QEMU_CLOCK_VIRTUAL in nanoseconds=
=2E
> - */
> -static inline int64_t clock_step(int64_t step)
> -{
> -    return qtest_clock_step(global_qtest, step);
> -}
> +#include "libqtest-single.h"

Well, almost.  I guess this commit is the code motion, and the next one
actually fixes clients to track the rename, so this #include is
temporary (I hope).  It's just churn to put a TODO comment in this
commit that would get removed in the next.  So,

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--AWD9Xe3eH02vpd1mbat9LtN1pxMSjKkAt--

--25GrX05xG9gAtR0ZHBKdM2aOL2mXKrqoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1vyNoACgkQp6FrSiUn
Q2rllQf8DpUiaGeOyoHIJ3zrm3flqIhjej/nR3vib1wLVt+04KCgZpWgk7GNEkXs
QlSRdcyoray0mkgsRKMofYEPEekzfAC3cFXEQZiYdOTTWR6S2gtM7hQXA/Y1pJWr
DPf1L635qhXJb5HOAgAdrbi0HG78pbi7nbFUWS80QWX9wnOMbWLpiYZHWwbftx7n
khkDSGs8e3BvAVIcyDw27LrtBq4jq4AHPcRmi6peAOUqLf5+MLMbyEaNQdwFcNCq
twVT/n1ctpBHjf8QpvNemglE/TlstulS6ArhgKkanSUnWvt4sZslithunlI0Pe5w
K971kZaF+LXrcpMb54LK3o5w7NjlUQ==
=i827
-----END PGP SIGNATURE-----

--25GrX05xG9gAtR0ZHBKdM2aOL2mXKrqoT--

