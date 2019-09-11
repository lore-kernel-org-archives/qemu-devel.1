Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53252C5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 17:57:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 291B2206A1
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 17:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 291B2206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i86s7-0005Xj-7r
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 13:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i86rU-00057P-Jz
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 13:57:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i86rS-0003XZ-Lh
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 13:56:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48552)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1i86rS-0003W2-9v
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 13:56:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F2209C05243E
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 17:56:56 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1016719C6A;
 Wed, 11 Sep 2019 17:56:55 +0000 (UTC)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
References: <20190911164202.31136-1-dgilbert@redhat.com>
 <20190911164202.31136-2-dgilbert@redhat.com>
 <20190911165627.GG24295@redhat.com>
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
Message-ID: <a16529f1-a5e3-ec80-7586-07d5b1c9ca87@redhat.com>
Date: Wed, 11 Sep 2019 12:56:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190911165627.GG24295@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="io9QwS0aav3JcdvjnRQklFeGIoVYgFYuE"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Wed, 11 Sep 2019 17:56:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/3] rcu: Add automatically released
 rcu_read_lock variant
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--io9QwS0aav3JcdvjnRQklFeGIoVYgFYuE
Content-Type: multipart/mixed; boundary="zOPuSntCz9VqXKyyidApNsWVO0TWhkUKb";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, quintela@redhat.com
Message-ID: <a16529f1-a5e3-ec80-7586-07d5b1c9ca87@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] rcu: Add automatically released
 rcu_read_lock variant
References: <20190911164202.31136-1-dgilbert@redhat.com>
 <20190911164202.31136-2-dgilbert@redhat.com>
 <20190911165627.GG24295@redhat.com>
In-Reply-To: <20190911165627.GG24295@redhat.com>

--zOPuSntCz9VqXKyyidApNsWVO0TWhkUKb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/11/19 11:56 AM, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Sep 11, 2019 at 05:42:00PM +0100, Dr. David Alan Gilbert (git) =
wrote:
>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>
>> RCU_READ_LOCK_AUTO takes the rcu_read_lock  and then uses glib's

spurious double space

>> g_auto infrastrcture (and thus whatever the compilers hooks are) to

infrastructure
compiler's

>> release it on all exits of the block.
>>
>> Note this macro has a variable declaration in, and hence is not in
>> a while loop.
>>

>> +#define RCU_READ_LOCK_AUTO g_auto(rcu_read_auto_t) \
>> +    _rcu_read_auto =3D 'x'; \
>> +    rcu_read_lock();
>> +
>=20
> Functionally this works, but my gut feeling would be to follow
> the design of GMutexLocker as-is:
>=20
>   https://developer.gnome.org/glib/stable/glib-Threads.html#g-mutex-loc=
ker-new
>=20
> so you get a use pattern of
>=20
>   g_autoptr(rcu_read_locker) locker =3D rcu_read_locker_new();

Another pattern to consider: nbdkit uses:

#define ACQUIRE_LOCK_FOR_CURRENT_SCOPE(mutex) \
  CLEANUP_UNLOCK pthread_mutex_t *_lock =3D mutex; \
  do { \
    int _r =3D pthread_mutex_lock (_lock); \
    assert (!_r); \
  } while (0)

with later code calling:

  ACQUIRE_LOCK_FOR_CURRENT_SCOPE (&lock);

>=20
> This makes it explicit that the code is creating a variable here, which=

> in turns means it is clear to force unlock early with
>=20
>   g_clear_pointer(&locker, rcu_read_locker_free)

Yes, this aspect of glib is nicer than the corresponding nbdkit usage
pattern.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--zOPuSntCz9VqXKyyidApNsWVO0TWhkUKb--

--io9QwS0aav3JcdvjnRQklFeGIoVYgFYuE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl15NWcACgkQp6FrSiUn
Q2rbLQf+NfD2o4SobAZ0hlEu4mobJ4hIr3+vIsPEX6KNAkfhn/valTMelo+sWkaM
d5DQB5P2vysjZs/h8Zl0TVtJJn5NTnYJrBLyeHe6pCDFUj+D1VnjKIVOO8paXKHD
kfWEm0y9tKJ3sX2kBBs9sHBvak+YrvOL561BwoNb8bc373n+NfZtQDAuFXK/lMPd
q+Dq4W6DpoPMzV5rN82FxNbj9q/tGNao1sx4rGwIlpNFzwCZvfmxLCJfj0YKNIbV
i/RfNcrXeprzy83D1eZTrMD3N4fr0Yjegjxt69RBxMCr4hBHC3tNrauNUwKYziRq
DL/dbeBX05ZGUXyQDE7Gym2REq2lsg==
=m7cG
-----END PGP SIGNATURE-----

--io9QwS0aav3JcdvjnRQklFeGIoVYgFYuE--

