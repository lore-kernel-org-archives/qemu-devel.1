Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B773C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 14:47:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A676720870
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 14:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A676720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5t39-00056V-8P
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 10:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i5t2F-0004fK-UR
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 10:46:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i5t2E-0005oz-8M
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 10:46:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:1938)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1i5t2D-0005oo-W5
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 10:46:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A85AD300B912;
 Thu,  5 Sep 2019 14:46:52 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EFBAB600CC;
 Thu,  5 Sep 2019 14:46:51 +0000 (UTC)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20190829165036.9773-1-berrange@redhat.com>
 <20190829165036.9773-4-berrange@redhat.com>
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
Message-ID: <066b199b-3f1d-11a3-3e51-92c5b80f5475@redhat.com>
Date: Thu, 5 Sep 2019 09:46:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829165036.9773-4-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="w7936bcJ1QL7vzFtoewiFpLHM2j9hfgNc"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 05 Sep 2019 14:46:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 3/4] docs: document use of automatic
 cleanup functions in glib
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--w7936bcJ1QL7vzFtoewiFpLHM2j9hfgNc
Content-Type: multipart/mixed; boundary="zhpZhFHpH15CQ133hOBVZ5wzmpKVl62Co";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <066b199b-3f1d-11a3-3e51-92c5b80f5475@redhat.com>
Subject: Re: [PATCH v3 3/4] docs: document use of automatic cleanup functions
 in glib
References: <20190829165036.9773-1-berrange@redhat.com>
 <20190829165036.9773-4-berrange@redhat.com>
In-Reply-To: <20190829165036.9773-4-berrange@redhat.com>

--zhpZhFHpH15CQ133hOBVZ5wzmpKVl62Co
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/29/19 11:50 AM, Daniel P. Berrang=C3=A9 wrote:
> Document the use of g_autofree and g_autoptr in glib for automatic
> freeing of memory.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  CODING_STYLE.rst | 85 ++++++++++++++++++++++++++++++++++++++++++++++++=

>  1 file changed, 85 insertions(+)
>=20
> diff --git a/CODING_STYLE.rst b/CODING_STYLE.rst
> index 4501d87352..39397f0f6f 100644
> --- a/CODING_STYLE.rst
> +++ b/CODING_STYLE.rst
> @@ -441,6 +441,91 @@ In addition, QEMU assumes that the compiler does n=
ot use the latitude
>  given in C99 and C11 to treat aspects of signed '<<' as undefined, as
>  documented in the GNU Compiler Collection manual starting at version 4=
=2E0.
> =20
> +Automatic memory deallocation
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +
> +QEMU has a mandatory dependency either the GCC or CLang compiler. As

s/either/on either/

> +such it has the freedom to make use of a C language extension for
> +automatically running a cleanup function when a stack variable goes
> +out of scope. This can be used to simplify function cleanup paths,
> +often allowing many goto jumps to be eliminated, through automatic
> +free'ing of memory.
> +

> +
> +For example, instead of
> +
> +.. code-block:: c
> +
> +    int somefunc(void) {

Should that { be on its own line to match our prevailing style?

> +        int ret =3D -1;
> +        char *foo =3D g_strdup_printf("foo%", "wibble");
> +        GList *bar =3D .....
> +
> +        if (eek) {
> +           goto cleanup;
> +        }
> +
> +        ret =3D 0;
> +
> +      cleanup:
> +        g_free(foo);
> +        g_list_free(bar);
> +        return ret;
> +    }
> +
> +Using g_autofree/g_autoptr enables the code to be written as:
> +
> +.. code-block:: c
> +
> +    int somefunc(void) {

here too

> +        g_autofree char *foo =3D g_strdup_printf("foo%", "wibble");
> +        g_autoptr (GList) bar =3D .....
> +
> +        if (eek) {
> +           return -1;
> +        }
> +
> +        return 0;
> +    }
> +
> +While this generally results in simpler, less leak-prone code, there
> +are still some caveats to beware of
> +
> +* Variables declared with g_auto* MUST always be initialized,
> +  otherwise the cleanup function will use uninitialized stack memory
> +
> +* If a variable declared with g_auto* holds a value which must
> +  live beyond the life of the function, that value must be saved
> +  and the original variable NULL'd out. This can be simpler using
> +  g_steal_pointer
> +
> +
> +.. code-block:: c
> +
> +    char *somefunc(void) {

and again

> +        g_autofree char *foo =3D g_strdup_printf("foo%", "wibble");
> +        g_autoptr (GList) bar =3D .....
> +
> +        if (eek) {
> +           return NULL;
> +        }
> +
> +        return g_steal_pointer(&foo);
> +    }
> +
> +
>  Error handling and reporting
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> =20
>=20

With those fixes,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--zhpZhFHpH15CQ133hOBVZ5wzmpKVl62Co--

--w7936bcJ1QL7vzFtoewiFpLHM2j9hfgNc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1xH9sACgkQp6FrSiUn
Q2qfhggAr0NYcH2IGLk4eNXKpCivcgs8kV6Gh2rgNNJRj+IiuP/0Svu4Ho5g16NK
E5huF9Gs2CgiFJdBcLkgHbGYe11a11X7Fs8EdCaBP6vOGcA5dMhW4F2udpJdz5VQ
pfhY5GDw3F6h3ve9fsDDRQhOQ1mxUJOB2Ykk4Lnb+roM4zVzwsV8P9GBgSHsYGuA
b1WpC817sPKPw0gkSS9BWYUXBc94RPI10Bt0UH/wzlRQJ5vErSt7BlVWVMcnKyhR
izxZi8WkIXmrBc/4BP2C03uux0hbwFtvA90PaMqKmEELKsx8yJ/pOzRmAEAitD7X
rTHRx/rsf24VA7MKF4OsuXzSaXPf5w==
=1UYc
-----END PGP SIGNATURE-----

--w7936bcJ1QL7vzFtoewiFpLHM2j9hfgNc--

