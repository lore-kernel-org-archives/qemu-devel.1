Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBACC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:03:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E5F621848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E5F621848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1EqP-00044D-W1
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 15:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44052)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i1Elw-0000BD-W7
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 14:58:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i1Elv-000661-QH
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 14:58:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46998)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i1Els-0005yq-MZ; Fri, 23 Aug 2019 14:58:48 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F21213175285;
 Fri, 23 Aug 2019 18:58:47 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8027F600C1;
 Fri, 23 Aug 2019 18:58:44 +0000 (UTC)
To: Wouter Verhelst <w@uter.be>
References: <25ead363-4f37-5450-b985-1876374e314d@redhat.com>
 <20190823143426.26838-1-eblake@redhat.com>
 <20190823143426.26838-2-eblake@redhat.com>
 <20190823184834.brhsfbc4sdq5xuij@grep.be>
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
Message-ID: <d3d1590e-e276-e449-c3da-0bdc4d4977d7@redhat.com>
Date: Fri, 23 Aug 2019 13:58:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823184834.brhsfbc4sdq5xuij@grep.be>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EH2bSYSWGcIkMUKvlAApzOkXl3E28Wsmi"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 23 Aug 2019 18:58:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/1] protocol: Add NBD_CMD_FLAG_FAST_ZERO
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
Cc: libguestfs@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 nbd@other.debian.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EH2bSYSWGcIkMUKvlAApzOkXl3E28Wsmi
Content-Type: multipart/mixed; boundary="4aDRVcsv1YZBCvrlCxWe9GiPmIO2C73z2";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Wouter Verhelst <w@uter.be>
Cc: nbd@other.debian.org, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 libguestfs@redhat.com
Message-ID: <d3d1590e-e276-e449-c3da-0bdc4d4977d7@redhat.com>
Subject: Re: [PATCH 1/1] protocol: Add NBD_CMD_FLAG_FAST_ZERO
References: <25ead363-4f37-5450-b985-1876374e314d@redhat.com>
 <20190823143426.26838-1-eblake@redhat.com>
 <20190823143426.26838-2-eblake@redhat.com>
 <20190823184834.brhsfbc4sdq5xuij@grep.be>
In-Reply-To: <20190823184834.brhsfbc4sdq5xuij@grep.be>

--4aDRVcsv1YZBCvrlCxWe9GiPmIO2C73z2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/23/19 1:48 PM, Wouter Verhelst wrote:
> On Fri, Aug 23, 2019 at 09:34:26AM -0500, Eric Blake wrote:
>> +- bit 4, `NBD_CMD_FLAG_FAST_ZERO`; valid during
>> +  `NBD_CMD_WRITE_ZEROES`. If set, but the server cannot perform the
>> +  write zeroes any faster than it would for an equivalent
>> +  `NBD_CMD_WRITE`,
>=20
> One way of fulfilling the letter of this requirement but not its spirit=

> could be to have background writes; that is, the server makes a note
> that the zeroed region should contain zeroes, makes an error-free reply=

> to the client, and then starts updating things in the background (with
> proper layering so that an NBD_CMD_READ would see zeroes).

For writes, this should still be viable IF the server can also cancel
that background write of zeroes in favor of a foreground request for
actual data to be written to the same offset.  In other words, as long
as the behavior to the client is "as if" there is no duplicated I/O
cost, the zero appears fast, even if it kicked off a long-running async
process to actually accomplish it.

>=20
> This could negatively impact performance after that command to the
> effect that syncing the device would be slower rather than faster, if
> not done right.

Oh. I see - for flush requests, you're worried about the cost of the
flush forcing the I/O for the background zero to complete before flush
can return.

Perhaps that merely means that a client using fast zero requests as a
means of probing whether it can do a bulk pre-zero pass even though it
will be rewriting part of that image with data later SHOULD NOT attempt
to flush the disk until all other interesting write requests are also
ready to queue.  In the 'qemu-img convert' case which spawned this
discussion, that's certainly the case (qemu-img does not call flush
after the pre-zeroing, but only after all data is copied - and then it
really DOES want to wait for any remaining backgrounded zeroing to land
on the disk along with any normal writes when it does its final flush).

>=20
> Do we want to keep that in consideration?

Ideas on how best to add what I mentioned above into the specification?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--4aDRVcsv1YZBCvrlCxWe9GiPmIO2C73z2--

--EH2bSYSWGcIkMUKvlAApzOkXl3E28Wsmi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1gN2QACgkQp6FrSiUn
Q2riDwgApROHFJjgCRdVzWdGKJNRQP7KYEVqLDLMxff7YzQb00gwnr2ig7xcd0QM
4LwN6f1FKCMDWFoLdLn5nA8LCCfKJl6Hu7YrLQZfRzWMb0gQSnNwdrWXDQgYY8CQ
dwmbKx9H3cZrK6Nm2fCCtCHNnufj9rxaSPeHu+lelRZWgW7qraJOfvIl0PjL7DrS
pot+1o1ZUoJZtxYeFuOb9C0v6SNUu2ELseLBKSJNQsCVTO6TH+A3hFePC6H8Vl7n
9d4YGNg4fIevreg749HxF8Bb2aedNnmTAYuz+aeS/IeyuMacv9t+UEebhtC5bhhz
tGMY1zmsBF54h+Y/tq3fCFsuFIqPGw==
=muzs
-----END PGP SIGNATURE-----

--EH2bSYSWGcIkMUKvlAApzOkXl3E28Wsmi--

