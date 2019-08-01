Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21828C19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 11:18:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBECF216C8
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 11:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBECF216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ht96Z-0001kJ-9Y
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 07:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58944)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1ht95y-00019w-O4
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 07:18:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1ht95x-0004KR-Jd
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 07:18:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46664)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ht95x-0004Jt-Ak
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 07:18:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A2F2D8667D;
 Thu,  1 Aug 2019 11:18:03 +0000 (UTC)
Received: from [10.3.116.93] (ovpn-116-93.phx2.redhat.com [10.3.116.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F028E5D9CD;
 Thu,  1 Aug 2019 11:18:00 +0000 (UTC)
To: Ning Bo <ning.bo9@zte.com.cn>, qemu-devel@nongnu.org, armbru@redhat.com
References: <1564644533-28850-1-git-send-email-ning.bo9@zte.com.cn>
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
Message-ID: <37a4faaf-c589-2da5-a8b8-faa85c69e774@redhat.com>
Date: Thu, 1 Aug 2019 06:17:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1564644533-28850-1-git-send-email-ning.bo9@zte.com.cn>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tGguospFQB8IxavdscNTsO9vhqXXdQpM0"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Thu, 01 Aug 2019 11:18:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] vhost-vsock: report QMP event when set
 running
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
Cc: mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tGguospFQB8IxavdscNTsO9vhqXXdQpM0
Content-Type: multipart/mixed; boundary="pzEm3PBNThEcmQa6qgxdJz2TLWom0iLE7";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Ning Bo <ning.bo9@zte.com.cn>, qemu-devel@nongnu.org, armbru@redhat.com
Cc: mst@redhat.com
Message-ID: <37a4faaf-c589-2da5-a8b8-faa85c69e774@redhat.com>
Subject: Re: [PATCH] vhost-vsock: report QMP event when set running
References: <1564644533-28850-1-git-send-email-ning.bo9@zte.com.cn>
In-Reply-To: <1564644533-28850-1-git-send-email-ning.bo9@zte.com.cn>

--pzEm3PBNThEcmQa6qgxdJz2TLWom0iLE7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/1/19 2:28 AM, Ning Bo wrote:
> Report vsock running event so that the upper application can
> control boot sequence.
> see https://github.com/kata-containers/runtime/pull/1918
>=20
> Signed-off-by: Ning Bo <ning.bo9@zte.com.cn>
> ---

Since this is an update to an earlier version you posted, it is helpful
to include 'v2' in the subject line ('git format-patch -v2' or 'git
send-email -v2' can do that on your behalf), as well as to document here
after the --- separator how it differs from v1.

More patch submission hints at https://wiki.qemu.org/Contribute/SubmitAPa=
tch

> +++ b/qapi/char.json
> @@ -570,3 +570,25 @@
>  { 'event': 'VSERPORT_CHANGE',
>    'data': { 'id': 'str',
>              'open': 'bool' } }
> +
> +##
> +# @VSOCK_RUNNING:
> +#
> +# Emitted when the guest changes the vsock status.
> +#
> +# @cid: guest context ID
> +#
> +# @running: true if the vsock is running
> +#
> +# Since: v4.2

Still not consistent with other uses. s/v4.2/4.2/


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--pzEm3PBNThEcmQa6qgxdJz2TLWom0iLE7--

--tGguospFQB8IxavdscNTsO9vhqXXdQpM0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1CymcACgkQp6FrSiUn
Q2qrAgf/TvChh3zeGI3bgOWOvfkt8AOboSmWV0AgMJImRBtcxRn3HjPX4mcomUVH
TytS2rUu3ke8uBbG6hLqQOcuUSdVniJ3UYXbMnBdSLATU9aVzChXgmxenpg+xQgB
gd3OyFilGDVp4CJMH9cb+my8RXffSotAJx1B2bii78H3nFR+F8jWwyaofWkA52Ca
NeXuwH23jlQZnFLEW8igW8yDtcfOQ6C9xJQnuKwC3TflLe/SppqZ6qDNv5klTxIN
ybAltJy0gTB37PBGqeLDy4RUL7JyH0jMcypCBP6puzhffT+dTzdPGJF8tvkEqrLQ
HRSSzmSrMpk7s8fXcSy7coHtvsCc1g==
=r+SE
-----END PGP SIGNATURE-----

--tGguospFQB8IxavdscNTsO9vhqXXdQpM0--

