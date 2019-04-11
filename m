Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A244C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 14:49:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5752B206BA
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 14:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5752B206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50084 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEb0k-0000WW-C5
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 10:49:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hEazd-000074-U9
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:47:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hEazY-0005LC-7i
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:47:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hEazP-0005Hv-JG; Thu, 11 Apr 2019 10:47:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 667C131524C4;
	Thu, 11 Apr 2019 14:47:39 +0000 (UTC)
Received: from [10.3.117.110] (ovpn-117-110.phx2.redhat.com [10.3.117.110])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 461F217A9F;
	Thu, 11 Apr 2019 14:47:35 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190410204215.5963-1-eblake@redhat.com>
	<61e3b78b-4daf-eebc-7e8b-860c57658933@virtuozzo.com>
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
Message-ID: <111374f2-ad0c-3f81-9c51-33201c63b6c5@redhat.com>
Date: Thu, 11 Apr 2019 09:47:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <61e3b78b-4daf-eebc-7e8b-860c57658933@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lCg0bCzthqmVZ5ux4fdjoWjBu4UfuniYP"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Thu, 11 Apr 2019 14:47:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH for-4.0?] iotest: Fix 241 to run in generic
 directory
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411144734.pozQ2p170jtSnyPg-piSvyRtT5Ai8Lqk977VjEaORE0@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lCg0bCzthqmVZ5ux4fdjoWjBu4UfuniYP
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <111374f2-ad0c-3f81-9c51-33201c63b6c5@redhat.com>
Subject: Re: [PATCH for-4.0?] iotest: Fix 241 to run in generic directory
References: <20190410204215.5963-1-eblake@redhat.com>
 <61e3b78b-4daf-eebc-7e8b-860c57658933@virtuozzo.com>
In-Reply-To: <61e3b78b-4daf-eebc-7e8b-860c57658933@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/11/19 2:57 AM, Vladimir Sementsov-Ogievskiy wrote:
> 10.04.2019 23:42, Eric Blake wrote:
>> Filter the qemu-nbd server output to get rid of a direct reference
>> to my build directory.
>>
>> Fixes: e9dce9cb
>> Reported-by: Max Reitz <mreitz@redhat.com>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>
>> Not worth -rc4 on its own, but if something else pops up that requires=

>> another spin, I plan on a pull request for this one. Otherwise it
>> slips to 4.1, and 4.0 just has a broken iotest.
>>

>> @@ -69,12 +70,13 @@ echo
>>
>>   # Intentionally omit '-f' to force image probing, which in turn forc=
es
>>   # sector alignment, here at the server.
>> -nbd_server_start_unix_socket "$TEST_IMG_FILE"
>> +nbd_server_start_unix_socket "$TEST_IMG_FILE" 2> "$TEST_DIR/server.lo=
g"
>>

>>   1 KiB (0x400) bytes     allocated at offset 0 bytes (0x0)
>> +WARNING: Image format was not specified for 'TEST_DIR/t.raw' and prob=
ing guessed raw.
>> +         Automatically detecting the format is dangerous for raw imag=
es, write operations on block 0 will be restricted.
>> +         Specify the 'raw' format explicitly to remove the restrictio=
ns.
>=20
> May be, just add -f raw to nbd server, to make this message disappear? =
And than, don't do any redirections, as if there
> will be failed unfiltered output it is OK?

No. See the comment in the test - it is intentional that we are omitting
-f, in two different places, in order to get three test scenarios:

normal: server '-f raw' 1-byte align, client '-f raw' 1-byte align
server-constrained: server omit for 512-byte align, client '-f raw'
obeys server align
client-constrained: server '-f raw' 1-byte align, client omit for
intentional 512-byte align

in order to show both that the server with forced alignment is able to
round requests correctly before sending to the client, and to show that
the client with forced alignment is able to round requests correctly in
spite of the server sending answers narrower than the client wants.

In 4.1, when Max's filter handling patches land, it will be possible to
use the blkdebug driver to force alignment instead of omitting '-f raw';
at which point we can take away the server.log file. But until the
filter handling patches land, any use of blkdebug causes odd test
misbehaviors because not everything in the block layer properly sees
through filter nodes.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--lCg0bCzthqmVZ5ux4fdjoWjBu4UfuniYP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyvU4YACgkQp6FrSiUn
Q2ojxAgAhL8AHmx3Vd2BDEoBPUVbsmLMcNsVzqqGEeGrV2wZR7YpT8a5Zc4ixn2p
b+a19WQfkrPKj1NNGaTsAsggVyiZWwxBP1IzKIcXOt9hLb/+uPljxj3jF6y3mOcC
SrBmlKxDj2JydeF/nPW9cA77pEIwbtYIyhZ2h2vuRT8zKPY0/zZDchqRhgl7qE5r
gBYfAuygfw4xfoYPa4nB4U34GrMSgDizlrAy4ghSrEsvSR/R4UGNwftqcToQ2y6L
y66+O4+2oYgE2wBf/lTn9IkOzvCbMRdp0p+HSoXtiUPNNWG7PNzZY/xrwEuWDIBJ
XV6H7imiuJBcvMv7rNQdfEj5DJsBfg==
=KGq9
-----END PGP SIGNATURE-----

--lCg0bCzthqmVZ5ux4fdjoWjBu4UfuniYP--

