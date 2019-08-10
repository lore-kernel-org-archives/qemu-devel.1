Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFCAC433FF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 12:48:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA9182089E
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 12:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA9182089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwQnI-00076G-7O
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 08:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56675)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hwQmh-0005t0-Pc
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 08:47:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hwQmg-0000wX-Ij
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 08:47:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37686)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hwQme-0000sf-2Z; Sat, 10 Aug 2019 08:47:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 59D8D3084031;
 Sat, 10 Aug 2019 12:47:42 +0000 (UTC)
Received: from [10.3.116.93] (ovpn-116-93.phx2.redhat.com [10.3.116.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 538B45DA32;
 Sat, 10 Aug 2019 12:47:35 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190809153207.49288-1-vsementsov@virtuozzo.com>
 <20190809153207.49288-7-vsementsov@virtuozzo.com>
 <62bca2ef-d175-6926-e1e8-5edfc08d58ab@redhat.com>
 <04e9f57a-4137-eed8-5005-f4fb26b71c47@virtuozzo.com>
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
Message-ID: <f5c3b9ff-5efd-d637-1be1-20f284088d8c@redhat.com>
Date: Sat, 10 Aug 2019 07:47:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <04e9f57a-4137-eed8-5005-f4fb26b71c47@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="c5bhP7quD73Goh8AsdvjUbzPWmjT6GAb9"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Sat, 10 Aug 2019 12:47:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 6/7] block/backup: teach
 backup_cow_with_bounce_buffer to copy more at once
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--c5bhP7quD73Goh8AsdvjUbzPWmjT6GAb9
Content-Type: multipart/mixed; boundary="BHhTWupOoRjwdxwxHn3fGFmBT77uXGz5H";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, Denis Lunev
 <den@virtuozzo.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Message-ID: <f5c3b9ff-5efd-d637-1be1-20f284088d8c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 6/7] block/backup: teach
 backup_cow_with_bounce_buffer to copy more at once
References: <20190809153207.49288-1-vsementsov@virtuozzo.com>
 <20190809153207.49288-7-vsementsov@virtuozzo.com>
 <62bca2ef-d175-6926-e1e8-5edfc08d58ab@redhat.com>
 <04e9f57a-4137-eed8-5005-f4fb26b71c47@virtuozzo.com>
In-Reply-To: <04e9f57a-4137-eed8-5005-f4fb26b71c47@virtuozzo.com>

--BHhTWupOoRjwdxwxHn3fGFmBT77uXGz5H
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/10/19 7:12 AM, Vladimir Sementsov-Ogievskiy wrote:
> 09.08.2019 18:59, Eric Blake wrote:
>> On 8/9/19 10:32 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> backup_cow_with_offload can transfer more than on cluster. Let
>>
>> s/on/one/
>>
>>> backup_cow_with_bounce_buffer behave similarly. It reduces number
>>> of IO and there are no needs to copy cluster by cluster.
>>
>> It reduces the number of IO requests, since there is no need to copy
>> cluster by cluster.

>>> -                                                      bool *error_is=
_read,
>>> -                                                      void **bounce_=
buffer)
>>> +                                                      bool *error_is=
_read)
>>
>> Why is this signature changing?
>>

>=20
> 2. Actually it is a question about memory allocator: is it fast and opt=
imized
> enough to not care, or is it bad, and we should work-around it like in
> mirror? And in my opinion (proved by a bit of benchmarking) memalign
> is fast enough to don't care. I was answering similar question in more =
details
> and with some numbers here:
> https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg00087.html
>=20
> So, I'd prefere to not care and keep code simpler. But if you don't agr=
ee,
> I can leave shared buffer here, at least until introduction of parallel=
 requests.
> Then, it will be something like qemu_try_blockalign(MIN(bytes, 64M))..

It may still be worth capping at 64M.  I'm not opposed to a change to
per-request allocation rather than trying to reuse a buffer, if it is
going to make parallelization efforts easier; but I am worried about the
maximum memory usage.  I'm more worried that you are trying to cram two
distinct changes into one patch, and didn't even mention the change
about a change from buffer reuse to per-request allocations, in the
commit message.  If you make that sort of change, it should be called
out in the commit message as intentional, or maybe even split to a
separate patch.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--BHhTWupOoRjwdxwxHn3fGFmBT77uXGz5H--

--c5bhP7quD73Goh8AsdvjUbzPWmjT6GAb9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1OvOcACgkQp6FrSiUn
Q2rSdAf/SIqUX8bhdhYQNt53O/A0naQA4KNkbU3PMnm88rwkG9UPKgdJvr07TDsY
Lh6dc7wrE93fOoNwIDFie4kIh7DyCuwpRexJ5HXln50E94kQUw8I5ICoiKs3NDAf
mvhaY89P9VfmCrOowBA+JX2QSQ7Ds2Vb9T99dAnJ4Vv/3nWlIJXdGrhAJSRAOMlS
HZ/g4gbP3wmqh9Y9iVslDC4P0xPa4QMML1g5hBZ7U3cAi1tGOeRTxlxZGj64UCvn
qwipwsgnEEbFaWQ8NBQ/qGCAcXaRvCl4jAgwLVhPjnXOCnHjWpifyuCpwMFX4emh
s1l19sIQsCW2hcMOglu/368fCDKGOw==
=b2nA
-----END PGP SIGNATURE-----

--c5bhP7quD73Goh8AsdvjUbzPWmjT6GAb9--

