Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB4DC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 14:49:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54E8821882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 14:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E8821882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1higZd-0005qZ-Hw
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 10:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59948)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1higX3-0004VO-EW
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 10:46:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1higX1-0001WL-GN
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 10:46:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44082)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1higWw-0001R9-RO; Wed, 03 Jul 2019 10:46:43 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A5168307E04A;
 Wed,  3 Jul 2019 14:46:37 +0000 (UTC)
Received: from [10.3.116.152] (ovpn-116-152.phx2.redhat.com [10.3.116.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AEC3B59441;
 Wed,  3 Jul 2019 14:46:36 +0000 (UTC)
To: Stefan Hajnoczi <stefanha@gmail.com>, Maxim Levitsky <mlevitsk@redhat.com>
References: <20190630150855.1016-1-mlevitsk@redhat.com>
 <20190703095217.GD11844@stefanha-x1.localdomain>
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
Message-ID: <727d4d5c-944a-c43a-a1c3-d4750ae12000@redhat.com>
Date: Wed, 3 Jul 2019 09:46:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190703095217.GD11844@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HwJaLjrLiylxH9IZ1SCzvQAEqKe9AkZkj"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Wed, 03 Jul 2019 14:46:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/1] RFC: don't obey the block
 device max transfer len / max segments for block devices
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 John Ferlan <jferlan@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HwJaLjrLiylxH9IZ1SCzvQAEqKe9AkZkj
Content-Type: multipart/mixed; boundary="SNqo7ewYntSAxD7WSdHeTU00sahsc0Z1u";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>, Maxim Levitsky <mlevitsk@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 John Ferlan <jferlan@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <727d4d5c-944a-c43a-a1c3-d4750ae12000@redhat.com>
Subject: Re: [Qemu-block] [PATCH 0/1] RFC: don't obey the block device max
 transfer len / max segments for block devices
References: <20190630150855.1016-1-mlevitsk@redhat.com>
 <20190703095217.GD11844@stefanha-x1.localdomain>
In-Reply-To: <20190703095217.GD11844@stefanha-x1.localdomain>

--SNqo7ewYntSAxD7WSdHeTU00sahsc0Z1u
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/3/19 4:52 AM, Stefan Hajnoczi wrote:
> On Sun, Jun 30, 2019 at 06:08:54PM +0300, Maxim Levitsky wrote:
>> It looks like Linux block devices, even in O_DIRECT mode don't have an=
y user visible
>> limit on transfer size / number of segments, which underlying block de=
vice can have.
>> The block layer takes care of enforcing these limits by splitting the =
bios.

s/The block layer/The kernel block layer/

>>
>> By limiting the transfer sizes, we  force qemu to do the splitting its=
elf which

double space

>> introduces various overheads.
>> It is especially visible in nbd server, where the low max transfer siz=
e of the
>> underlying device forces us to advertise this over NBD, thus increasin=
g the traffic overhead in case of

Long line for a commit message.

>> image conversion which benefits from large blocks.
>>
>> More information can be found here:
>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1647104
>>
>> Tested this with qemu-img convert over nbd and natively and to my surp=
rise, even native IO performance improved a bit.
>> (The device on which it was tested is Intel Optane DC P4800X, which ha=
s 128k max transfer size)
>>
>> The benchmark:
>>

I'm sorry I didn't see this before softfreeze, but as a performance
improvement, I think it still classes as a bug fix and is safe for
inclusion in rc0.

>> The block limits of max transfer size/max segment size are retained
>> for the SCSI passthrough because in this case the kernel passes the us=
erspace request
>> directly to the kernel scsi driver, bypassing the block layer, and thu=
s there is no code to split
>> such requests.
>>
>> What do you think?

Seems like a reasonable explanation.

>>
>> Fam, since you was the original author of the code that added
>> these limits, could you share your opinion on that?
>> What was the reason besides SCSI passthrough?
>>
>> Best regards,
>> 	Maxim Levitsky
>>
>> Maxim Levitsky (1):
>>   raw-posix.c - use max transfer length / max segemnt count only for
>>     SCSI passthrough
>>
>>  block/file-posix.c | 16 +++++++---------
>>  1 file changed, 7 insertions(+), 9 deletions(-)
>=20
> Adding Eric Blake, who implemented the generic request splitting in the=

> block layer and may know if there were any other reasons aside from SCS=
I
> passthrough why file-posix.c enforces the host block device's maximum
> transfer size.

No, I don't have any strong reasons for why file I/O must be capped to a
specific limit other than size_t (since the kernel does just fine at
splitting things up).

>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--SNqo7ewYntSAxD7WSdHeTU00sahsc0Z1u--

--HwJaLjrLiylxH9IZ1SCzvQAEqKe9AkZkj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl0cv8sACgkQp6FrSiUn
Q2puKwf/TTwfiiFR7Bhrg9NaBe5hbE77PEkMgQW3C9oEJyslwKGOZWJz6GKZR7t8
czXVSZ7G2NWi8LpCvyS8OmYqsZ4sNTkJklipn6MDrYJbCH6z1gHaHTxSP7dockJd
dyg6IW6qYAX0xRvRDqUviCmdYTDTb140F3Sh+IsmgHRzSrY073QwlmGxTXQXriXw
qQ1q8R9TEXYxWWYIM/VJD6NROY05L28269B3lQuZZjEwtAe5P0B6lEUEqtkEhhI2
w2ri/6cDQQtZTozT2hF5v9Q3DCyaY16Dxiir/8djYDrJGih1YDEUc7Sw5FNf88cN
1Qgn2IlriN9sEI/Gfos2U8bXulUJyQ==
=2tu5
-----END PGP SIGNATURE-----

--HwJaLjrLiylxH9IZ1SCzvQAEqKe9AkZkj--

