Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38054C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 21:07:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D09F217D7
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 21:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D09F217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvT9a-0004LO-B0
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 17:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38652)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hvT96-0003fZ-BF
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 17:06:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hvT95-00041i-Af
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 17:06:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47698)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hvT95-00040W-2D
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 17:06:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0EFD5307D97F;
 Wed,  7 Aug 2019 21:06:54 +0000 (UTC)
Received: from [10.3.116.93] (ovpn-116-93.phx2.redhat.com [10.3.116.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6828B5D9CD;
 Wed,  7 Aug 2019 21:06:51 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-13-armbru@redhat.com>
 <d822b034-f283-5945-da5d-4fe3bc767f2b@redhat.com>
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
Message-ID: <fd6a172e-1c79-5c0a-c9ba-3dbc671dc72f@redhat.com>
Date: Wed, 7 Aug 2019 16:06:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <d822b034-f283-5945-da5d-4fe3bc767f2b@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="H4qqdgganj88iVvIT4vzQAkQCyVnM8NLL"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 07 Aug 2019 21:06:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 12/29] Include hw/irq.h a lot less
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
Cc: Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--H4qqdgganj88iVvIT4vzQAkQCyVnM8NLL
Content-Type: multipart/mixed; boundary="EXt4R9iApdw0vj7dTbedNBmdCFsCLklGz";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <fd6a172e-1c79-5c0a-c9ba-3dbc671dc72f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 12/29] Include hw/irq.h a lot less
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-13-armbru@redhat.com>
 <d822b034-f283-5945-da5d-4fe3bc767f2b@redhat.com>
In-Reply-To: <d822b034-f283-5945-da5d-4fe3bc767f2b@redhat.com>

--EXt4R9iApdw0vj7dTbedNBmdCFsCLklGz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/7/19 8:04 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 8/6/19 5:14 PM, Markus Armbruster wrote:
>> In my "build everything" tree, changing hw/irq.h triggers a recompile
>> of some 5400 out of 6600 objects (not counting tests and objects that
>> don't depend on qemu/osdep.h).
>>
>> hw/hw.h supposedly includes it for convenience.  Several other headers=

>> include it just to get qemu_irq and.or qemu_irq_handler.
>>
>> Move the qemu_irq and qemu_irq_handler typedefs from hw/irq.h to
>> qemu/typedefs.h, and then include hw/irq.h only where it's still
>> needed.  Touching it now recompiles only some 500 objects.
>>

>>  /*
>>   * Function types
>>   */
>>  typedef void SaveStateHandler(QEMUFile *f, void *opaque);
>>  typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version_i=
d);
>> +typedef void (*qemu_irq_handler)(void *opaque, int n, int level);

Should we prefer a consistent form for function pointer typedefs?  Here,
we've mixed 'rettype Name(params)' with 'rettype (*name)(params)'.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--EXt4R9iApdw0vj7dTbedNBmdCFsCLklGz--

--H4qqdgganj88iVvIT4vzQAkQCyVnM8NLL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1LPWoACgkQp6FrSiUn
Q2oaswf/Rm6uht9KhfDXILQN3FZ02/ooHudzuAhEE5YBmUmkNLK3Sy2fRTHltViL
TWItdpaPGghp9oaWPX+fsv2FMDL03t6GJrHcR53/YCYd6bx0ubhuTJD8Xh4UgOMm
s7G4aOhjglsw6nBIiBBJe2NFob5lOxIW0V0qs7RTZcjgc9Sx4fXnz8ITKS7XWCXo
mvgTMyBv6wEMAsTRtJg24VtQ/IPL1WV6jwF5uYSxbO+1AOxw8oyJWknKUAlDqidu
k9Fk0i0uVz8GTaep9UbwtSCCex+v5zUgxQXC/J3CDUIUsgkFhTT+dpDi8fivXOUD
gcEzuDimewRRr5dsaDrB7LBmAFUxVg==
=Oc/H
-----END PGP SIGNATURE-----

--H4qqdgganj88iVvIT4vzQAkQCyVnM8NLL--

