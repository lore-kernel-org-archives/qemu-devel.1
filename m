Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F15C3A59E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 01:34:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 587A72339E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 01:34:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 587A72339E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0bzW-00048L-Fk
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 21:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i0byT-0002tp-En
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 21:33:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i0byQ-0006Kv-DP
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 21:33:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57348)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1i0byO-0006KD-Nc
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 21:33:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 031DC3082E57;
 Thu, 22 Aug 2019 01:33:06 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 87CE260600;
 Thu, 22 Aug 2019 01:33:05 +0000 (UTC)
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
References: <20190822011620.106337-1-aik@ozlabs.ru>
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
Message-ID: <b9098689-a8cb-0c68-0065-f9362cdcb32d@redhat.com>
Date: Wed, 21 Aug 2019 20:33:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822011620.106337-1-aik@ozlabs.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="m02TyPsTxNG6Nl7Zh3ZKdsHfeYghLcyFv"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 22 Aug 2019 01:33:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH qemu] qapi: Add query-memory-checksum
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m02TyPsTxNG6Nl7Zh3ZKdsHfeYghLcyFv
Content-Type: multipart/mixed; boundary="KjfhyBYqJJpDTJp6babPfRsOqR2k5MNxy";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b9098689-a8cb-0c68-0065-f9362cdcb32d@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH qemu] qapi: Add query-memory-checksum
References: <20190822011620.106337-1-aik@ozlabs.ru>
In-Reply-To: <20190822011620.106337-1-aik@ozlabs.ru>

--KjfhyBYqJJpDTJp6babPfRsOqR2k5MNxy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/21/19 8:16 PM, Alexey Kardashevskiy wrote:
> This returns MD5 checksum of all RAM blocks for migration debugging
> as this is way faster than saving the entire RAM to a file and checking=

> that.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>=20
>=20
> I am actually wondering if there is an easier way of getting these
> checksums and I just do not see it, it cannot be that we fixed all
> memory migration bugs :)

I'm not sure whether the command itself makes sense, but for the interfac=
e:


> +++ b/qapi/misc.json
> @@ -1194,6 +1194,33 @@
>  ##
>  { 'command': 'query-memory-size-summary', 'returns': 'MemoryInfo' }
> =20
> +##
> +# @MemoryChecksum:
> +#
> +# A string with MD5 checksum of all RAMBlocks.
> +#
> +# @checksum: the checksum.
> +#
> +# Since: 3.2.0

This should be 4.2, not 3.2.

> +##
> +{ 'struct': 'MemoryChecksum',
> +  'data'  : { 'checksum': 'str' } }
> +
> +##
> +# @query-memory-checksum:
> +#
> +# Return the MD5 checksum of all RAMBlocks.
> +#
> +# Example:
> +#
> +# -> { "execute": "query-memory-checksum" }
> +# <- { "return": { "checksum": "a0880304994f64cb2edad77b9a1cd58f" } }
> +#
> +# Since: 3.2.0

and again

> +##
> +{ 'command': 'query-memory-checksum',
> +  'returns': 'MemoryChecksum' }
> +
> =20

> +++ b/exec.c
> @@ -2050,6 +2050,22 @@ void *qemu_ram_get_host_addr(RAMBlock *rb)
>      return rb->host;
>  }
> =20
> +gchar *qemu_ram_chksum(void)

gchar is a pointless glib type.  Use 'char' instead.

> +{
> +    struct RAMBlock *rb;
> +    GChecksum *chksum =3D g_checksum_new(G_CHECKSUM_MD5);
> +    gchar *ret;
> +
> +    RAMBLOCK_FOREACH(rb) {
> +        g_checksum_update(chksum, qemu_ram_get_host_addr(rb),
> +                          qemu_ram_get_used_length(rb));
> +    }
> +    ret =3D g_strdup(g_checksum_get_string(chksum));
> +    g_checksum_free(chksum);
> +
> +    return ret;
> +}

How long does this take to run?  Is it something where you really want
to block the guest while chewing over the guest's entire memory?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--KjfhyBYqJJpDTJp6babPfRsOqR2k5MNxy--

--m02TyPsTxNG6Nl7Zh3ZKdsHfeYghLcyFv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1d8NAACgkQp6FrSiUn
Q2o9cAgAoCWnwqzwSPRAAiD5+V7msbNA5hm4EDcr2TJ9Thad1A44xshX/SMvOR+q
Bavsmlj1Z1fBd9uQNs3j9sYEKreDMwxb9T3dRJU5PLd6QMjJofwcdVwB60DdEJkE
1SVqmQefCVYXEAOjXGr7LYaUkhSJUgdU656YgGwHQTe+vuHbordavz5uZjdsFeyr
XswHj5JiK/E0EOCiZe/Ueo5kAyAUhSAdDdChsNK6IskBcaRCYXv9BEfoMAIoLQ4b
OCSLN9CwpALdWJgU4r2hWkvGbPvirpUD3e29Ovwxe6f1mAN/SkrWoByT9nvFuhS1
kW+dxSNJIJbbf1Z3cP/RAD1F6/bB5A==
=Ulv9
-----END PGP SIGNATURE-----

--m02TyPsTxNG6Nl7Zh3ZKdsHfeYghLcyFv--

