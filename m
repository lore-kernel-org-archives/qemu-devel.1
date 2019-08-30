Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647EDC3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 23:38:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32FD023430
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 23:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32FD023430
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3qTY-0003Np-V5
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 19:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i3qNZ-0001PD-TL
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 19:32:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i3qNX-0006B5-Ad
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 19:32:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50956)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i3qNP-0005eh-4c; Fri, 30 Aug 2019 19:32:20 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 643F8189DACA;
 Fri, 30 Aug 2019 23:32:14 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B5FC60BE1;
 Fri, 30 Aug 2019 23:32:11 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <25ead363-4f37-5450-b985-1876374e314d@redhat.com>
 <20190823143726.27062-1-eblake@redhat.com>
 <20190823143726.27062-2-eblake@redhat.com>
 <92e9cfa2-fbaa-259d-7a04-91187cc809b6@virtuozzo.com>
 <b1483a24-d524-169a-3440-5a9bf4440265@redhat.com>
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
Message-ID: <55ebe9db-5a28-d844-89f7-2dc9a7d977d7@redhat.com>
Date: Fri, 30 Aug 2019 18:32:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b1483a24-d524-169a-3440-5a9bf4440265@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vvggllkG3A9wqHFBfpDVv29rEON1aoc67"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Fri, 30 Aug 2019 23:32:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/5] nbd: Improve per-export flag handling
 in server
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
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "libguestfs@redhat.com" <libguestfs@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vvggllkG3A9wqHFBfpDVv29rEON1aoc67
Content-Type: multipart/mixed; boundary="RPpWzgVrtSfl3tfpcd4cx2C6YSVpci26I";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 "libguestfs@redhat.com" <libguestfs@redhat.com>,
 "nbd@other.debian.org" <nbd@other.debian.org>
Message-ID: <55ebe9db-5a28-d844-89f7-2dc9a7d977d7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] nbd: Improve per-export flag handling in
 server
References: <25ead363-4f37-5450-b985-1876374e314d@redhat.com>
 <20190823143726.27062-1-eblake@redhat.com>
 <20190823143726.27062-2-eblake@redhat.com>
 <92e9cfa2-fbaa-259d-7a04-91187cc809b6@virtuozzo.com>
 <b1483a24-d524-169a-3440-5a9bf4440265@redhat.com>
In-Reply-To: <b1483a24-d524-169a-3440-5a9bf4440265@redhat.com>

--RPpWzgVrtSfl3tfpcd4cx2C6YSVpci26I
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/30/19 6:10 PM, Eric Blake wrote:
> On 8/30/19 1:00 PM, Vladimir Sementsov-Ogievskiy wrote:
>> 23.08.2019 17:37, Eric Blake wrote:
>>> When creating a read-only image, we are still advertising support for=

>>> TRIM and WRITE_ZEROES to the client, even though the client should no=
t
>>> be issuing those commands.  But seeing this requires looking across
>>> multiple functions:
>>>
>=20
>>> @@ -458,10 +458,13 @@ static int nbd_negotiate_handle_export_name(NBD=
Client *client,
>>>           return -EINVAL;
>>>       }
>>>
>>> -    trace_nbd_negotiate_new_style_size_flags(client->exp->size,
>>> -                                             client->exp->nbdflags |=
 myflags);
>>> +    myflags =3D client->exp->nbdflags;
>>> +    if (client->structured_reply) {
>>> +        myflags |=3D NBD_FLAG_SEND_DF;
>>> +    }
>>
>>
>> why we cant do just
>> client->exp->nbdflags |=3D NBD_FLAG_SEND_DF ?
>=20
> Because myflags is the runtime flags for _this_ client, while
> client->exp->nbdflags are the base flags shared by _all_ clients.  If
> client A requests structured reply, but client B does not, then we don'=
t
> want to advertise DF to client B; but amending client->exp->nbdflags
> would have that effect.

I stand corrected - it looks like a fresh client->exp is created per
client, as evidenced by:

diff --git i/nbd/client.c w/nbd/client.c
index b9dc829175f9..9e05f1a0e2a3 100644
--- i/nbd/client.c
+++ w/nbd/client.c
@@ -1011,6 +1011,8 @@ int nbd_receive_negotiate(AioContext *aio_context,
QIOChannel *ioc,
     assert(info->name);
     trace_nbd_receive_negotiate_name(info->name);

+    if (getenv ("MY_HACK"))
+        info->structured_reply =3D false;
     result =3D nbd_start_negotiate(aio_context, ioc, tlscreds, hostname,=

outioc,
                                  info->structured_reply, &zeroes, errp);=


diff --git i/nbd/server.c w/nbd/server.c
index d5078f7468af..6f3a83704fb3 100644
--- i/nbd/server.c
+++ w/nbd/server.c
@@ -457,6 +457,7 @@ static int
nbd_negotiate_handle_export_name(NBDClient *client, bool no_zeroes,
     myflags =3D client->exp->nbdflags;
     if (client->structured_reply) {
         myflags |=3D NBD_FLAG_SEND_DF;
+        client->exp->nbdflags |=3D NBD_FLAG_SEND_DF;
     }
     trace_nbd_negotiate_new_style_size_flags(client->exp->size, myflags)=
;
     stq_be_p(buf, client->exp->size);

$ ./qemu-nbd -r -f raw file -t &

$  ~/qemu/qemu-io -r -f raw --trace=3Dnbd_\*size_flags
nbd://localhost:10809 -c quit
32145@1567207628.519883:nbd_receive_negotiate_size_flags Size is
1049088, export flags 0x48f

$ MY_HACK=3D1 ~/qemu/qemu-io -r -f raw --trace=3Dnbd_\*size_flags
nbd://localhost:10809 -c quit
32156@1567207630.417815:nbd_receive_negotiate_size_flags Size is
1049088, export flags 0x40f

$  ~/qemu/qemu-io -r -f raw --trace=3Dnbd_\*size_flags
nbd://localhost:10809 -c quit
32167@1567207635.202940:nbd_receive_negotiate_size_flags Size is
1049088, export flags 0x48f

The export flags change per client, so I _can_ store into
client->exp->nbdflags.  Will do that for v2.

Meanwhile, this points out a missing feature in libnbd - for testing
purposes, it would be really nice to be able to purposefully cripple the
client to NOT request structured replies automatically (default enabled,
but the ability to turn it off is useful for interop testing, as in this
thread).  I already recently added a --no-sr flag to nbdkit for a
similar reason (but that's creating a server which refuses to advertise,
where here I want a guest that refuses to ask).  Guess I'll be adding a
patch for that, too :)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--RPpWzgVrtSfl3tfpcd4cx2C6YSVpci26I--

--vvggllkG3A9wqHFBfpDVv29rEON1aoc67
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1psfoACgkQp6FrSiUn
Q2pc8Qf9EQLxZFFYD64KBGqrS0jTuPnhmq3tVaC/YacTJzVr/++pxyDW7gGUQvyP
DDn0Z4tN2a4F4kyCrFWuHHhU1FiQI3E/OyG8SbV+gg6pV0lQLfLJrdZLHGwL0xDx
1N7IForaIdoM9auujdSYbs+/aLXi/djKeQkwyB9g5mlLyGonPXr3KplS2zE7VdWh
46AePgHG7E0MTKJiveyUK36ahpWum042qyvoXu5b8665RE37S6wKIOnNWjWDDq75
mcqp5WHSvZr+GgYq4LS+k9zENpGyXPkckNnkQQFHNNUToTh4TxkXHOPiVTtYFReV
kwXFT30W+b8blnoI4OZGrtReIIUP9A==
=YeFM
-----END PGP SIGNATURE-----

--vvggllkG3A9wqHFBfpDVv29rEON1aoc67--

