Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23491C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 13:24:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF0ED2054F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 13:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF0ED2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2bSY-00045q-Rz
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 09:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i2bRW-0003Ir-Ms
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 09:23:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i2bRV-0007pf-BR
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 09:23:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36818)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i2bRR-0007oC-OG; Tue, 27 Aug 2019 09:23:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E96327E42F;
 Tue, 27 Aug 2019 13:23:20 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 201CD3782;
 Tue, 27 Aug 2019 13:23:15 +0000 (UTC)
To: "Richard W.M. Jones" <rjones@redhat.com>
References: <25ead363-4f37-5450-b985-1876374e314d@redhat.com>
 <20190827121449.GX7304@redhat.com>
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
Message-ID: <5ee3861d-1591-5328-d04c-63dff4c8cb0f@redhat.com>
Date: Tue, 27 Aug 2019 08:23:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827121449.GX7304@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fT2hshGd1HGujBr7onFlFyr6ebUWHDtHO"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 27 Aug 2019 13:23:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Libguestfs] cross-project patches: Add NBD Fast
 Zero support
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
Cc: libguestfs@redhat.com, QEMU <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, nbd@other.debian.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fT2hshGd1HGujBr7onFlFyr6ebUWHDtHO
Content-Type: multipart/mixed; boundary="X0B9LEKDH77RTZBbofLHqWrVZ0gj9mc2E";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, nbd@other.debian.org,
 libguestfs@redhat.com
Message-ID: <5ee3861d-1591-5328-d04c-63dff4c8cb0f@redhat.com>
Subject: Re: [Libguestfs] cross-project patches: Add NBD Fast Zero support
References: <25ead363-4f37-5450-b985-1876374e314d@redhat.com>
 <20190827121449.GX7304@redhat.com>
In-Reply-To: <20190827121449.GX7304@redhat.com>

--X0B9LEKDH77RTZBbofLHqWrVZ0gj9mc2E
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/27/19 7:14 AM, Richard W.M. Jones wrote:

>=20
> Is the plan to wait until NBD_CMF_FLAG_FAST_ZERO gets into the NBD
> protocol doc before doing the rest?  Also I would like to release both
> libnbd 1.0 and nbdkit 1.14 before we introduce any large new features.
> Both should be released this week, in fact maybe even today or
> tomorrow.

Sure, I don't mind this being the first feature for the eventual libnbd
1.2 and nbdkit 1.16.

>=20
> [...]
>> First, I had to create a scenario where falling back to writes is
>> noticeably slower than performing a zero operation, and where
>> pre-zeroing also shows an effect.  My choice: let's test 'qemu-img
>> convert' on an image that is half-sparse (every other megabyte is a
>> hole) to an in-memory nbd destination.  Then I use a series of nbdkit
>> filters to force the destination to behave in various manners:
>>  log logfile=3D>(sed ...|uniq -c) (track how many normal/fast zero
>> requests the client makes)
>>  nozero $params (fine-tune how zero requests behave - the parameters
>> zeromode and fastzeromode are the real drivers of my various tests)
>>  blocksize maxdata=3D256k (allows large zero requests, but forces larg=
e
>> writes into smaller chunks, to magnify the effects of write delays and=

>> allow testing to provide obvious results with a smaller image)
>>  delay delay-write=3D20ms delay-zero=3D5ms (also to magnify the effect=
s on a
>> smaller image, with writes penalized more than zeroing)
>>  stats statsfile=3D/dev/stderr (to track overall time and a decent sum=
mary
>> of how much I/O occurred).
>>  noextents (forces the entire image to report that it is allocated,
>> which eliminates any testing variability based on whether qemu-img use=
s
>> that to bypass a zeroing operation [1])
>=20
> I can't help thinking that a sh plugin might have been simpler ...

Maybe, but the extra cost of forking per request may have also made
obvious timing comparisons harder.  I'm just glad that nbdkit's
filtering system was flexible enough to do what I wanted, even if I did
have fun stringing together 6 filters :)

>=20
>> I hope you enjoyed reading this far, and agree with my interpretation =
of
>> the numbers about why this feature is useful!
>=20
> Yes it seems reasonable.
>=20
> The only thought I had is whether the qemu block layer does or should
> combine requests in flight so that a write-zero (offset) followed by a
> write-data (same offset) would erase the earlier request.  In some
> circumstances that might provide a performance improvement without
> needing any changes to protocols.

As in, maintain a backlog of requests that are needed but have not yet
been sent over the wire because of backlog, and merge those requests (by
splitting an existing large zero request into smaller pieces) if write
requests come in that window before actually transmitting to the NBD
server?  I know qemu has some write coalescing when servicing guest
behaviors; but I was testing on 'qemu-img convert' which does not depend
on guest behavior and therefore has already sent the zero request to the
NBD server before sending any data writes, so coalescing wouldn't see
anything to combine.  Or are you worried about qemu as the NBD server,
performing coalescing of incoming requests from the client?  But you are
right that some smarts about I/O coalescing at various points in the
data path may show some slight optimizations.

>=20
>> - NBD should have a way to advertise (probably via NBD_INFO_ during
>> NBD_OPT_GO) if the initial image is known to begin life with all zeroe=
s
>> (if that is the case, qemu-img can skip the extents calls and
>> pre-zeroing pass altogether)
>=20
> Yes, I really think we should do this one as well.

Stay tuned for my next cross-project post ;)  Hopefully in the next week
or so.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--X0B9LEKDH77RTZBbofLHqWrVZ0gj9mc2E--

--fT2hshGd1HGujBr7onFlFyr6ebUWHDtHO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1lLsIACgkQp6FrSiUn
Q2o4rgf/fTOCMSe/l1YZE5lxbZx0IWf1Xvn5obBdA5mptUza+BxIw5N8x1F3fcRD
NmeYdKHMibWPPSx4eWEe8LGLesFpXP/ozdlXSf4DBnQBqk20t2PBh6LrEiHx/MzQ
SBHzZrxqpIdk+tyG0F6ss72w2xwq//UfUq5be583r38sdcTE9NhdqPtBZQks3oS7
wJf0gsKaDlMT8ZBcOFtFH6t/N7B1UWgDDCOy1GUKgnYR6sUBS1wr6rdGvonlrV9Z
ezNyh3Uj7VbMwi/d4ZqGCvOQVyVadXJcs62g8yFvQ2Li4MLNPS04DlHXspYjottW
fN2+ARG9C8US5UlnLsQ9CMyQQwKADg==
=PTEC
-----END PGP SIGNATURE-----

--fT2hshGd1HGujBr7onFlFyr6ebUWHDtHO--

