Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A594C3A5A3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 21:12:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B194D233FC
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 21:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B194D233FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0uNm-0007g4-Vf
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 17:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i0uN2-00078S-SG
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 17:11:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i0uN1-00037C-Tn
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 17:11:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41612)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i0uN1-00036t-LR; Thu, 22 Aug 2019 17:11:47 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C388C7EB88;
 Thu, 22 Aug 2019 21:11:46 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B50B10016F3;
 Thu, 22 Aug 2019 21:11:46 +0000 (UTC)
To: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
References: <20190822195918.3307-1-danielhb413@gmail.com>
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
Message-ID: <63a2fef4-3e9d-5dfc-9ccb-2924bb1fe808@redhat.com>
Date: Thu, 22 Aug 2019 16:11:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822195918.3307-1-danielhb413@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="C7EqCSiqwxjZn9AkC26u4Hu54Bv5DLbMh"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Thu, 22 Aug 2019 21:11:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1 1/1] spapr_pci: remove all child
 functions in function zero unplug
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
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C7EqCSiqwxjZn9AkC26u4Hu54Bv5DLbMh
Content-Type: multipart/mixed; boundary="4v6XS3BvEAwBOIcUKY2QhM7uEM07eZq99";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Message-ID: <63a2fef4-3e9d-5dfc-9ccb-2924bb1fe808@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 1/1] spapr_pci: remove all child functions
 in function zero unplug
References: <20190822195918.3307-1-danielhb413@gmail.com>
In-Reply-To: <20190822195918.3307-1-danielhb413@gmail.com>

--4v6XS3BvEAwBOIcUKY2QhM7uEM07eZq99
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/22/19 2:59 PM, Daniel Henrique Barboza wrote:
> There is nothing wrong with how sPAPR handles multifunction PCI
> hot unplugs. The problem is that x86 does it simpler. Instead of
> removing each non-zero function and then removing function zero,
> x86 can remove any function of the slot to trigger the hot unplug.
>=20

> +++ b/hw/ppc/spapr_pci.c
> @@ -1700,11 +1700,13 @@ static void spapr_pci_unplug_request(HotplugHan=
dler *plug_handler,
>                  state =3D func_drck->dr_entity_sense(func_drc);
>                  if (state =3D=3D SPAPR_DR_ENTITY_SENSE_PRESENT
>                      && !spapr_drc_unplug_requested(func_drc)) {
> -                    error_setg(errp,
> -                               "PCI: slot %d, function %d still presen=
t. "
> -                               "Must unplug all non-0 functions first.=
",
> -                               slotnr, i);
> -                    return;
> +                    /*
> +                     * Attempting to remove function 0 of a multifunct=
ion
> +                     * device will will cascade into removing all chil=
d
> +                     * functions, even if their unplug weren't request=
ed

s/weren't/wasn't/

> +                     * beforehand.
> +                     */
> +                    spapr_drc_detach(func_drc);
>                  }
>              }
>          }
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--4v6XS3BvEAwBOIcUKY2QhM7uEM07eZq99--

--C7EqCSiqwxjZn9AkC26u4Hu54Bv5DLbMh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1fBREACgkQp6FrSiUn
Q2rj8gf/f6JCTuwXKv4bUp/4EJulqmyGa1zkpRBGrfwgVovND2pAkz0nXsdD69/m
1yDZcmX7fuJMCbM67zMaKVpDPJpi7LXYpnClOMk2dRpr0qPB3sHzsx+RpBN25bFH
x6LvHpUVnw/cPjEY1AlWkI+58tMzsVEyi9JkvS9np2DJJoJ4w1XQp2JmfaEfuU0g
6GGOdVnInvpggNn9+4ZotQNNtX3JfQ4jWiyyED4iPWcaWM3SH73hOzHN+w4Rs0ey
hKrNlxy168iuTvylSDQx9KrfC9ZmlO8Q0sHffLx2+ka/wQyW4qgDlg4o2bH+rQoG
eKcWFUsIWSTcejDQv2OE+/JZswC5YQ==
=XWkP
-----END PGP SIGNATURE-----

--C7EqCSiqwxjZn9AkC26u4Hu54Bv5DLbMh--

