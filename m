Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26C8C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 21:55:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BA222083B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 21:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA222083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyNiE-0000SR-Bp
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 17:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1hyNhP-0008DZ-0y
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 17:54:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hyNhN-0006IO-Sy
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 17:54:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40572)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hyNhL-0006GN-3v; Thu, 15 Aug 2019 17:54:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2071B8535C;
 Thu, 15 Aug 2019 21:54:18 +0000 (UTC)
Received: from [10.3.117.22] (ovpn-117-22.phx2.redhat.com [10.3.117.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0667C8CFA1;
 Thu, 15 Aug 2019 21:54:14 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20190815185024.7010-1-eblake@redhat.com>
 <e2c4f996-a1c3-d7aa-fc3e-4fffc596e8de@redhat.com>
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
Message-ID: <5dbb9c0d-4eb0-b6a0-ff23-107010fa3c1f@redhat.com>
Date: Thu, 15 Aug 2019 16:54:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <e2c4f996-a1c3-d7aa-fc3e-4fffc596e8de@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RMLcDIb4TDhgC0QcTqtXfaP3YpWxz9vhp"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 15 Aug 2019 21:54:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] nbd: Advertise multi-conn for
 shared read-only connections
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RMLcDIb4TDhgC0QcTqtXfaP3YpWxz9vhp
Content-Type: multipart/mixed; boundary="7Foj4veazXTznhuHrU540y7y8bFvrI6Su";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <5dbb9c0d-4eb0-b6a0-ff23-107010fa3c1f@redhat.com>
Subject: Re: [Qemu-block] [PATCH] nbd: Advertise multi-conn for shared
 read-only connections
References: <20190815185024.7010-1-eblake@redhat.com>
 <e2c4f996-a1c3-d7aa-fc3e-4fffc596e8de@redhat.com>
In-Reply-To: <e2c4f996-a1c3-d7aa-fc3e-4fffc596e8de@redhat.com>

--7Foj4veazXTznhuHrU540y7y8bFvrI6Su
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/15/19 4:45 PM, John Snow wrote:
>=20
>=20
> On 8/15/19 2:50 PM, Eric Blake wrote:
>> The NBD specification defines NBD_FLAG_CAN_MULTI_CONN, which can be
>> advertised when the server promises cache consistency between
>> simultaneous clients (basically, rules that determine what FUA and
>> flush from one client are able to guarantee for reads from another
>> client).  When we don't permit simultaneous clients (such as qemu-nbd
>> without -e), the bit makes no sense; and for writable images, we
>> probably have a lot more work before we can declare that actions from
>> one client are cache-consistent with actions from another.  But for
>> read-only images, where flush isn't changing any data, we might as
>> well advertise multi-conn support.  What's more, advertisement of the
>> bit makes it easier for clients to determine if 'qemu-nbd -e' was in
>> use, where a second connection will succeed rather than hang until the=

>> first client goes away.
>>
>> This patch affects qemu as server in advertising the bit.  We may want=

>> to consider patches to qemu as client to attempt parallel connections
>> for higher throughput by spreading the load over those connections
>> when a server advertises multi-conn, but for now sticking to one
>> connection per nbd:// BDS is okay.
>>

>> +++ b/blockdev-nbd.c
>> @@ -189,7 +189,7 @@ void qmp_nbd_server_add(const char *device, bool h=
as_name, const char *name,
>>      }
>>
>>      exp =3D nbd_export_new(bs, 0, len, name, NULL, bitmap,
>> -                         writable ? 0 : NBD_FLAG_READ_ONLY,
>> +                         writable ? 0 : NBD_FLAG_READ_ONLY, true,
>>                           NULL, false, on_eject_blk, errp);
>=20
> Why is it okay to force the share bit on regardless of the value of
> 'writable' ?

Well, it's probably not, except that...


>> @@ -1486,6 +1486,8 @@ NBDExport *nbd_export_new(BlockDriverState *bs, =
uint64_t dev_offset,
>>      perm =3D BLK_PERM_CONSISTENT_READ;
>>      if ((nbdflags & NBD_FLAG_READ_ONLY) =3D=3D 0) {
>>          perm |=3D BLK_PERM_WRITE;
>> +    } else if (shared) {
>> +        nbdflags |=3D NBD_FLAG_CAN_MULTI_CONN;
>>      }

requesting shared=3Dtrue has no effect for a writable export.

I can tweak it for less confusion, though.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--7Foj4veazXTznhuHrU540y7y8bFvrI6Su--

--RMLcDIb4TDhgC0QcTqtXfaP3YpWxz9vhp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1V1IUACgkQp6FrSiUn
Q2qd3Qf/U6o+jGNqBtNKwx9tG0Kllyfc82ePkTr27Q/LBAK8B+C1GpguG923g2RF
VKEfmL4l6Gmsq+GEgJReM1SuN0L+irsOPkGxWnrJs9iv3kpB8seKcS+Lz+GrheND
8RkuN3WLWwz0gbB+FJuEGBjO4V9BqUgORj+kk6ET+18f8JmcLHLzrwUWOseQWMo2
EPfzbqz+gbaV2GEADgRRTHm8E5GpV+pEKcf0nNsza4L1ePPXFxnSVU8DYOoHcTMC
d6mdKFzYgCvlv1452IL5erFGIDIsXidxpQ//S66Ii0ewdpfpcei6VT9B9CWydRJR
cT8WrwymjGmd9F3nfHpxDG22hs/DPA==
=00Dv
-----END PGP SIGNATURE-----

--RMLcDIb4TDhgC0QcTqtXfaP3YpWxz9vhp--

