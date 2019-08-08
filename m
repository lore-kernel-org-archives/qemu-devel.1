Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DD6C0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 11:27:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05889217F4
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 11:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05889217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvgaK-0008IU-7g
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 07:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44313)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hvgZv-0007se-BW
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 07:27:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hvgZu-0008N2-1q
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 07:27:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36538)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hvgZt-0008Lu-Po
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 07:27:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F10EC769E1;
 Thu,  8 Aug 2019 11:27:28 +0000 (UTC)
Received: from [10.3.116.93] (ovpn-116-93.phx2.redhat.com [10.3.116.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 481D060FA1;
 Thu,  8 Aug 2019 11:27:28 +0000 (UTC)
To: "Richard W.M. Jones" <rjones@redhat.com>, ivo welch <ivo.welch@ucla.edu>
References: <CAJrNScTufw-809ag5-DoqhDVJs4aRyYm9EQxSO4aqPVgT_+8gA@mail.gmail.com>
 <20190808074105.GD3888@redhat.com>
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
Message-ID: <e8cfc534-e922-fe65-4ed0-c9284a00aaa8@redhat.com>
Date: Thu, 8 Aug 2019 06:27:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190808074105.GD3888@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WY3zjrs1ScszL3wN2I3qlLhcnvij6R00T"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Thu, 08 Aug 2019 11:27:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Quick nbdkit question
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WY3zjrs1ScszL3wN2I3qlLhcnvij6R00T
Content-Type: multipart/mixed; boundary="hnbAoonAXSZ2sOYMTj69FCGndkkjRQQCJ";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>, ivo welch <ivo.welch@ucla.edu>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com
Message-ID: <e8cfc534-e922-fe65-4ed0-c9284a00aaa8@redhat.com>
Subject: Re: Quick nbdkit question
References: <CAJrNScTufw-809ag5-DoqhDVJs4aRyYm9EQxSO4aqPVgT_+8gA@mail.gmail.com>
 <20190808074105.GD3888@redhat.com>
In-Reply-To: <20190808074105.GD3888@redhat.com>

--hnbAoonAXSZ2sOYMTj69FCGndkkjRQQCJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/8/19 2:41 AM, Richard W.M. Jones wrote:
> On Wed, Aug 07, 2019 at 02:30:18PM -0700, ivo welch wrote:
>> hi richard---please forgive us.  another quickie.  we created an nbd
>> device.  just a block device...no partitions, etc.  in the guest vm, w=
e
>> wrote a short C program that writes one sector (open file, fseek, fwri=
te,
>> close file) and then does it again.  all is working just fine.  the ho=
st
>> console (filter) prints out the write requests, as it should.  (we add=
ed
>> some more print code.)
>>
>> but we are confused about that after the first [but not the second] wr=
ite,
>> we see about 30 (4096b) sector reads, starting from 4096, 12288, ... .=

>> (the file below has both the C code and the nbdkit messages.)
>=20
> I guess it's happening because of readahead in the qemu NBD driver, or
> generally in the QEMU block layer.  Eric or Kevin will probably have a
> better idea.

More likely, it's happening in the guest OS.  The kernel probes a lot of
sectors when first mounting block storage, to determine what lives on
that storage.  Rich even has a graphical demonstration of that probing
in his FOSDEM 2019 presentation.
https://rwmj.wordpress.com/2019/02/04/video-take-your-loop-mounts-to-the-=
next-level-with-nbdkit/
around the 21:20 mark.

>=20
>> there is no file system layer here, just an nbdkit block device. what =
is
>> reading sectors here?  is it the stdio.h library in the guest, somethi=
ng
>> magic about access into an unformatted block device in the guest VM li=
nux,
>> or nbdkit itself?!     does this sound familiar?

In order to determine if storage is formatted or not, the guest VM Linux
kernel reads a lot of sectors.  Qemu is not doing readahead, so much as
faithfully reproducing the read requests from the guest.  There are
places where qemu tries to consolidate consecutive actions from the
guest into one larger action to the storage, and we also have ideas
about adding a caching filter which can perform readahead and such for
performance, but I don't think they can be universally enabled in qemu
without penalizing some users, so it should be obvious when you are
opting in to those sorts of qemu features.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--hnbAoonAXSZ2sOYMTj69FCGndkkjRQQCJ--

--WY3zjrs1ScszL3wN2I3qlLhcnvij6R00T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1MBx8ACgkQp6FrSiUn
Q2pkDgf/ectWoEj3StNSZx4k85agiZP0LKFjyBdMMJArSL/8lMztyjDTe2ibuAyT
DpfaEnsBisiiClFethVsR66KCPbmPsSsZMV+zitb2nhXt5ud/ci2z669aH2l0KpS
p0rdpIQFJvSHjyw24fdPdU/2HlDmczYOWlO+VsC1e2bEfHHAgo13iuNcYkOExC0+
LM6f2IHyfJejtYpyVoaLN3+uP1wcmTMFLUfwC+xUQ36W73bT9HfLxyd5unt9HQg9
/Q2pF+rJkzDS56Toh8RuqaSlHdGZ+m6AUDsstJtFGIkj5TzmLFQl0I59V1ScDCyw
szNTIEOoXH/EuRuyq7M9CngQ+2pCqw==
=yjHq
-----END PGP SIGNATURE-----

--WY3zjrs1ScszL3wN2I3qlLhcnvij6R00T--

