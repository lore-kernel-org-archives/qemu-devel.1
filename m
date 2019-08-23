Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46471C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 21:18:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FB2321874
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 21:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB2321874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1Gwu-00072y-2I
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 17:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i1Gv7-0006Sk-FK
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 17:16:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i1Gv6-0000XX-F8
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 17:16:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52522)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i1Gv3-0000Wi-A6; Fri, 23 Aug 2019 17:16:25 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D84CD3082D9E;
 Fri, 23 Aug 2019 21:16:23 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A3FC91001284;
 Fri, 23 Aug 2019 21:16:19 +0000 (UTC)
To: libguestfs@redhat.com
References: <25ead363-4f37-5450-b985-1876374e314d@redhat.com>
 <20190823144054.27420-1-eblake@redhat.com>
 <20190823144054.27420-4-eblake@redhat.com>
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
Message-ID: <0f743b37-6308-24d0-eae0-5f939af9dae2@redhat.com>
Date: Fri, 23 Aug 2019 16:16:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823144054.27420-4-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eXYbbBvIJTxpYUqAQfsoypeWf7DejGVhK"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Fri, 23 Aug 2019 21:16:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Libguestfs] [nbdkit PATCH 3/3] plugins: Add
 .can_fast_zero hook
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, nbd@other.debian.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eXYbbBvIJTxpYUqAQfsoypeWf7DejGVhK
Content-Type: multipart/mixed; boundary="0qmAS2y8KMZdV53c81xIWwAhFPnUp50lQ";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: libguestfs@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, nbd@other.debian.org
Message-ID: <0f743b37-6308-24d0-eae0-5f939af9dae2@redhat.com>
Subject: Re: [Libguestfs] [nbdkit PATCH 3/3] plugins: Add .can_fast_zero hook
References: <25ead363-4f37-5450-b985-1876374e314d@redhat.com>
 <20190823144054.27420-1-eblake@redhat.com>
 <20190823144054.27420-4-eblake@redhat.com>
In-Reply-To: <20190823144054.27420-4-eblake@redhat.com>

--0qmAS2y8KMZdV53c81xIWwAhFPnUp50lQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/23/19 9:40 AM, Eric Blake wrote:
> Allow plugins to affect the handling of the new NBD_CMD_FLAG_FAST_ZERO
> flag, then update affected plugins.  In particular, in-memory plugins
> are always fast; the full plugin is better served by omitting .zero
> and relying on .pwrite fallback; nbd takes advantage of libnbd
> extensions proposed in parallel to pass through support; and
> v2 language bindings expose the choice to their scripts.
>=20

> +++ b/server/plugins.c
> @@ -404,11 +404,25 @@ plugin_can_zero (struct backend *b, struct connec=
tion *conn)
>  static int
>  plugin_can_fast_zero (struct backend *b, struct connection *conn)
>  {
> +  struct backend_plugin *p =3D container_of (b, struct backend_plugin,=
 backend);
> +  int r;
> +
>    assert (connection_get_handle (conn, 0));
>=20
>    debug ("can_fast_zero");
>=20
> -  return 0; /* Upcoming patch will actually add support. */
> +  if (p->plugin.can_fast_zero)
> +    return p->plugin.can_fast_zero (connection_get_handle (conn, 0));
> +  /* Advertise support for fast zeroes if no .zero or .can_zero is
> +   * false: in those cases, we fail fast instead of using .pwrite.
> +   * This also works when v1 plugin has only ._zero_old.
> +   */
> +  if (p->plugin.zero =3D=3D NULL)
> +    return 1;
> +  r =3D plugin_can_zero (b, conn);
> +  if (r =3D=3D -1)
> +    return -1;
> +  return !r;
>  }
>=20

Needs this squashed in for libnbd to pass rather than skip its new
'can-fast-zero-flag' test:


diff --git i/server/plugins.c w/server/plugins.c
index 84329cf4..695a77ab 100644
--- i/server/plugins.c
+++ w/server/plugins.c
@@ -208,6 +208,7 @@ plugin_dump_fields (struct backend *b)
   HAS (can_cache);
   HAS (cache);
   HAS (thread_model);
+  HAS (can_fast_zero);
 #undef HAS

   /* Custom fields. */


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--0qmAS2y8KMZdV53c81xIWwAhFPnUp50lQ--

--eXYbbBvIJTxpYUqAQfsoypeWf7DejGVhK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1gV6IACgkQp6FrSiUn
Q2pzvQf/cfNQ7g1RZfUxUI16kEkNzxpc7agCkznqsk7hJqz7Nj5vOPMGsCt3lldK
AFLU5FB8BG0M2K+nEQcEHcMzIKuxi7FWFRZIC+sCQs835uurJcUixRI0uw+3SBUB
EEJwXZc6hr4SCXrbckIyFD8ZD9HZZkCuQRmzJnAssM/Q0dsZ6iVwtdOAcLEeByV3
mD1uiXYq2SENXLCM0vkcjwSMIJwMhnHG6E68/gNy/AWg+//zyZRqxOlUNsBvlbjS
3ejiTuylA2cyfU18V4aISVQVgBQ0tlTDTryEcQxLCfw7+jFDo+G246Vc/fRfLTrY
iPU96F0R1q7Ml4YJlmIjnXtrk0saaw==
=l5dh
-----END PGP SIGNATURE-----

--eXYbbBvIJTxpYUqAQfsoypeWf7DejGVhK--

