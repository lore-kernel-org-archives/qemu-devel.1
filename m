Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C3EC0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 13:20:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7240206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 13:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7240206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsS3B-0006eB-Tk
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 09:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46289)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hsS2h-0006Ev-7k
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 09:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hsS2f-0004cV-Tx
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 09:19:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46180)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hsS2f-0004bk-LC
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 09:19:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AA87681DF1;
 Tue, 30 Jul 2019 13:19:48 +0000 (UTC)
Received: from [10.3.116.93] (ovpn-116-93.phx2.redhat.com [10.3.116.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B6E0C605A8;
 Tue, 30 Jul 2019 13:19:42 +0000 (UTC)
To: "N. B." <n.b@live.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>
References: <HK2PR04MB38595779EA521C94675599F981DC0@HK2PR04MB3859.apcprd04.prod.outlook.com>
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
Message-ID: <32b3e5c7-3bb7-ecd8-0c04-b622c278e5b1@redhat.com>
Date: Tue, 30 Jul 2019 08:19:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <HK2PR04MB38595779EA521C94675599F981DC0@HK2PR04MB3859.apcprd04.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Myq57nJ8IeQzXmQzNtcTbrPdc6ywrIVr4"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 30 Jul 2019 13:19:48 +0000 (UTC)
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
Cc: Ning Bo <ning.bo9@zte.com.cn>, "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Myq57nJ8IeQzXmQzNtcTbrPdc6ywrIVr4
Content-Type: multipart/mixed; boundary="87VNnOhQEh2Y2Nf2n8oF7QEz3BAGNClEZ";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: "N. B." <n.b@live.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>
Cc: "mst@redhat.com" <mst@redhat.com>, Ning Bo <ning.bo9@zte.com.cn>
Message-ID: <32b3e5c7-3bb7-ecd8-0c04-b622c278e5b1@redhat.com>
Subject: Re: [PATCH] vhost-vsock: report QMP event when set running
References: <HK2PR04MB38595779EA521C94675599F981DC0@HK2PR04MB3859.apcprd04.prod.outlook.com>
In-Reply-To: <HK2PR04MB38595779EA521C94675599F981DC0@HK2PR04MB3859.apcprd04.prod.outlook.com>

--87VNnOhQEh2Y2Nf2n8oF7QEz3BAGNClEZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/30/19 7:24 AM, N. B. wrote:
> From: Ning Bo <n.b@live.com>
>=20
> Report vsock running event so that the upper application can
> control boot sequence.
> see https://github.com/kata-containers/runtime/pull/1918
>=20
> Signed-off-by: Ning Bo <ning.bo9@zte.com.cn>

Your From: and S-o-b: differ from one another, which can make crawling
through git history in search of contributor statistics a bit harder.
Can you fix your git settings to use the same address in both places,
and/or contribute a patch to .mailmap to consolidate your contributions
under a single preferred address?

> ---
>  hw/virtio/vhost-vsock.c |  3 +++
>  qapi/char.json          | 22 ++++++++++++++++++++++
>  2 files changed, 25 insertions(+)
>=20

> +++ b/qapi/char.json
> @@ -570,3 +570,25 @@
>  { 'event': 'VSERPORT_CHANGE',
>    'data': { 'id': 'str',
>              'open': 'bool' } }
> +
> +##
> +# @VSOCK_RUNNING:
> +#
> +# Emitted when the guest be set running.

s/be set running/changes the vsock status/

> +#
> +# @cid: guest context ID
> +#
> +# @running: true if the vsock be set running

s/be set/is/

> +#
> +# Since: v4.1.0

Not our typical spelling, and as a new feature it is too late for 4.1.
This should read:

# Since: 4.2

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--87VNnOhQEh2Y2Nf2n8oF7QEz3BAGNClEZ--

--Myq57nJ8IeQzXmQzNtcTbrPdc6ywrIVr4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1AQ+0ACgkQp6FrSiUn
Q2pjIgf/bV+HwJKvAzXIztpMVqbdihW28jJO9jsr/j+MYC3Sai5lbaHtBQAdYZ7A
aaaz9jFtcA+cMkU4wR+9Arn5yc4cRGv6anbSSfOdUeURuZvAavTGDPgeEz6wAb2E
Ad4C2cOkn9obDS69Yy0gfdA23HCZ8AzfELB0drw/Lj6SE6Y1DpQWJAFC5jH7Uf0v
25N1gx1WAXp/HJ8VZ6nLbmsWE5Q2kLnWQV9KSv8XR2Njb91Zv0aP8wZvpsxE8BSu
0Myo+bzbG2+g8zeu0+DnkUv8O8Jkv2ZRaJBLXzE17ognjQKIX3tmcTltoZNlZyv6
LRnC1bnEHHEKjxzPR8OYi+af/wT8fQ==
=wLBF
-----END PGP SIGNATURE-----

--Myq57nJ8IeQzXmQzNtcTbrPdc6ywrIVr4--

