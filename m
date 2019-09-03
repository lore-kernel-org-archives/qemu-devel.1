Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C514CC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 18:50:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9922A2168B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 18:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9922A2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Dsr-0001v8-NI
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 14:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34570)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i5Ds9-0001Kc-7g
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 14:49:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i5Ds8-0008Fk-74
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 14:49:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43532)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i5Ds5-0008Bw-GP; Tue, 03 Sep 2019 14:49:41 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 46C052A09CD;
 Tue,  3 Sep 2019 18:49:40 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5393260127;
 Tue,  3 Sep 2019 18:49:39 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <25ead363-4f37-5450-b985-1876374e314d@redhat.com>
 <20190823143726.27062-1-eblake@redhat.com>
 <20190823143726.27062-3-eblake@redhat.com>
 <9476b1d1-47e4-ecfd-eb23-5b2fbc1410e3@virtuozzo.com>
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
Message-ID: <bae3c83f-644f-4379-5426-bdfba467fb0b@redhat.com>
Date: Tue, 3 Sep 2019 13:49:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9476b1d1-47e4-ecfd-eb23-5b2fbc1410e3@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AQETwcaKFmjCOxQ8YEFM4wHWVWxCptIco"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Tue, 03 Sep 2019 18:49:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/5] nbd: Prepare for NBD_CMD_FLAG_FAST_ZERO
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AQETwcaKFmjCOxQ8YEFM4wHWVWxCptIco
Content-Type: multipart/mixed; boundary="s6ryFedDeGdvO7tkQgzabCIIl6LQEZWG2";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Message-ID: <bae3c83f-644f-4379-5426-bdfba467fb0b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] nbd: Prepare for NBD_CMD_FLAG_FAST_ZERO
References: <25ead363-4f37-5450-b985-1876374e314d@redhat.com>
 <20190823143726.27062-1-eblake@redhat.com>
 <20190823143726.27062-3-eblake@redhat.com>
 <9476b1d1-47e4-ecfd-eb23-5b2fbc1410e3@virtuozzo.com>
In-Reply-To: <9476b1d1-47e4-ecfd-eb23-5b2fbc1410e3@virtuozzo.com>

--s6ryFedDeGdvO7tkQgzabCIIl6LQEZWG2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/30/19 1:07 PM, Vladimir Sementsov-Ogievskiy wrote:
> 23.08.2019 17:37, Eric Blake wrote:
>> Commit fe0480d6 and friends added BDRV_REQ_NO_FALLBACK as a way to
>> avoid wasting time on a preliminary write-zero request that will later=

>> be rewritten by actual data, if it is known that the write-zero
>> request will use a slow fallback; but in doing so, could not optimize
>> for NBD.  The NBD specification is now considering an extension that
>> will allow passing on those semantics; this patch updates the new
>> protocol bits and 'qemu-nbd --list' output to recognize the bit, as
>> well as the new errno value possible when using the new flag; while
>> upcoming patches will improve the client to use the feature when
>> present, and the server to advertise support for it.
>>

>> +++ b/nbd/server.c
>> @@ -55,6 +55,8 @@ static int system_errno_to_nbd_errno(int err)
>>           return NBD_ENOSPC;
>>       case EOVERFLOW:
>>           return NBD_EOVERFLOW;
>> +    case ENOTSUP:
>> +        return NBD_ENOTSUP;
>=20

I'm squashing this in:

diff --git i/nbd/server.c w/nbd/server.c
index b3bd08ef2953..4992148de1c4 100644
--- i/nbd/server.c
+++ w/nbd/server.c
@@ -56,6 +56,9 @@ static int system_errno_to_nbd_errno(int err)
     case EOVERFLOW:
         return NBD_EOVERFLOW;
     case ENOTSUP:
+#if ENOTSUP !=3D EOPNOTSUPP
+    case EOPNOTSUPP:
+#endif
         return NBD_ENOTSUP;
     case ESHUTDOWN:
         return NBD_ESHUTDOWN;

It makes no difference on Linux, but may matter on other platforms
(since POSIX says the two may be equivalent, but may also be distinct).

>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--s6ryFedDeGdvO7tkQgzabCIIl6LQEZWG2--

--AQETwcaKFmjCOxQ8YEFM4wHWVWxCptIco
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1utcIACgkQp6FrSiUn
Q2rhdwf+N6fWoBbdS4ZTsW8eiVIyb4H+LO3zQKkEMP+FtUHQM2VtZYOitBGNNCN/
CU+ZjfoPZT3rLQsdulRjSUoIruDNwkXgrXOBSGV94pu1+TyNt8NQXvfzkaKV1yf7
sIlit9bZoqUGcvkFplRuoO1s5Gw1TaVOA/4NC7jN48bwzKlTdpMkHTvJZwAj5TWz
RDAqV/nBznWsxRfY75/oKd64VlV5G+LFlsXFtQzenICuczGDi67SjHPhkWcuBgUs
znPy7X6kc4iarpIHB4EjJZ1lMPbJNmevJ4+TSL60M9pssm/PRTvbe0LSQVUwIjc8
ArQ8VZccq+rKpXUUpC/hNuwd2G1uSg==
=lAIX
-----END PGP SIGNATURE-----

--AQETwcaKFmjCOxQ8YEFM4wHWVWxCptIco--

