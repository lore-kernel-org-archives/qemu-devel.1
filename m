Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6391AC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 19:20:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 350AF20863
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 19:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 350AF20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51420 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcxAr-0006iH-7d
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 15:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48490)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hcx9D-0005lG-09
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 15:18:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hcx9B-0000lK-QG
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 15:18:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50638)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hcx9B-0000iv-CS
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 15:18:29 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3A14322386E;
 Mon, 17 Jun 2019 19:18:21 +0000 (UTC)
Received: from [10.3.118.50] (ovpn-118-50.phx2.redhat.com [10.3.118.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BB8210021B4;
 Mon, 17 Jun 2019 19:18:17 +0000 (UTC)
To: elena.ufimtseva@oracle.com, qemu-devel@nongnu.org
References: <20190617181620.30047-1-elena.ufimtseva@oracle.com>
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
Message-ID: <9c747527-67c2-2e5c-4724-e0bf5c2a8822@redhat.com>
Date: Mon, 17 Jun 2019 14:18:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190617181620.30047-1-elena.ufimtseva@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="O1P3WWNDoMFqrbHVgUlmQkUNpYjADRCI9"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Mon, 17 Jun 2019 19:18:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH v2 20/35] multi-process: Add QMP &
 extend HMP commands to list remote info
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
Cc: john.g.johnson@oracle.com, jag.raman@oracle.com, konrad.wilk@oracle.com,
 dgilbert@redhat.com, armbru@redhat.com, ross.lagerwall@citrix.com,
 liran.alon@oracle.com, stefanha@redhat.com, kanth.ghatraju@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--O1P3WWNDoMFqrbHVgUlmQkUNpYjADRCI9
Content-Type: multipart/mixed; boundary="JUkilLTin4kjhdG2ynICvamvlQJM7Sk6v";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: elena.ufimtseva@oracle.com, qemu-devel@nongnu.org
Cc: ross.lagerwall@citrix.com, stefanha@redhat.com, liran.alon@oracle.com,
 kanth.ghatraju@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, armbru@redhat.com
Message-ID: <9c747527-67c2-2e5c-4724-e0bf5c2a8822@redhat.com>
Subject: Re: [RFC PATCH v2 20/35] multi-process: Add QMP & extend HMP commands
 to list remote info
References: <20190617181620.30047-1-elena.ufimtseva@oracle.com>
In-Reply-To: <20190617181620.30047-1-elena.ufimtseva@oracle.com>

--JUkilLTin4kjhdG2ynICvamvlQJM7Sk6v
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/17/19 1:16 PM, elena.ufimtseva@oracle.com wrote:
> From: Jagannathan Raman <jag.raman@oracle.com>
>=20
> Add query-remote QMP command and extend "info" HMP command, to list
> the remote objects used by QEMU.
>=20
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> ---

> +++ b/qapi/block-core.json
> @@ -673,6 +673,23 @@
>             '*tray_open': 'bool', '*io-status': 'BlockDeviceIoStatus',
>             '*dirty-bitmaps': ['BlockDirtyInfo'] } }
> =20
> +##
> +# @RemoteProc:

Unless there's a compelling reason to abbreviate, naming this
'RemoteProcess' is just fine.

> +#
> +# Remote process information.
> +#
> +# @id: Device ID
> +#
> +# @pid: Linux Process ID

Is this information only available for Linux, or is it a generic pid
appropriate to any operating system?  I'm wondering if you can just
s/Linux//.

> +#
> +# @proc: Process name

Again, no need to abbreviate, if @process or @name would be easier to
document.

> +#
> +# Since:  3.0.93

No such release. The next release will be 4.1.

> +##
> +{ 'struct': 'RemoteProc',
> +  'data': {'id': 'str', 'pid': 'int32', 'proc': 'str' },
> +  'if': 'defined(CONFIG_MPQEMU)' }
> +
>  ##
>  # @BlockMeasureInfo:
>  #
> @@ -795,6 +812,18 @@
>  ##
>  { 'command': 'query-block', 'returns': ['BlockInfo'] }
> =20
> +##
> +# @query-remote:
> +#
> +# Get a list of all the remote processes spawned by QEMU.
> +#
> +# Returns: a list of @RemoteProc describing each remote process.
> +#
> +# Since: 3.0.93

4.1

> +#
> +##
> +{ 'command': 'query-remote', 'returns': ['RemoteProc'],
> +  'if': 'defined(CONFIG_MPQEMU)' }
> =20
>  ##
>  # @BlockDeviceTimedStats:
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--JUkilLTin4kjhdG2ynICvamvlQJM7Sk6v--

--O1P3WWNDoMFqrbHVgUlmQkUNpYjADRCI9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl0H53gACgkQp6FrSiUn
Q2pPEgf9Gt1KpGFwx//A3URBRsF14vNrcKZ5PoUrp0FIw0eaKttZW/wzabqWDdxw
pBlvyzsORSH0z7bUlg9YttISBFI980SbN1eGXvxioUoOnaw2ZBzhKGa8/6E3wiTE
BmEv/EqhCsA7G68tJZxFe/IfTfzdIsxPpQAt1HFhRIhjaCWjPcSF+sByMfKhneyI
0+rwycV75PzgSnHZhxuZZPVVV1JLgtNy8JW1AxijooDRPl7SRnV2uIoizmcGvjS8
Pml0Jhs0GwlKdFXZ9NP7HWFcy6dtyXbu6o856100gVFM7UrgSTQmCyyODcTf3zIg
NgfkmCFmfGKnzRY6zVwXgTIV7U59og==
=uXSQ
-----END PGP SIGNATURE-----

--O1P3WWNDoMFqrbHVgUlmQkUNpYjADRCI9--

