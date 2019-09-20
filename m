Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B89CC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 17:09:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDB152086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 17:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB152086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBMPb-00051V-Qg
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 13:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iBMOr-0004YF-Ci
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 13:08:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iBMOp-0003ty-3b
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 13:08:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51262)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iBMOo-0003tZ-Ri
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 13:08:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EE4ED3086218
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 17:08:49 +0000 (UTC)
Received: from [10.3.116.249] (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B9BE5D9C3;
 Fri, 20 Sep 2019 17:08:49 +0000 (UTC)
Subject: Re: [RFC 0/4] POC: Generating realistic block errors
To: tasleson@redhat.com, Kevin Wolf <kwolf@redhat.com>
References: <20190919194847.18518-1-tasleson@redhat.com>
 <20190920083630.GA5458@localhost.localdomain>
 <566d0d07-35fc-2d66-a47c-00526546b31e@redhat.com>
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
Message-ID: <c1c6ae56-ce0e-fddc-d72a-98a748b5c897@redhat.com>
Date: Fri, 20 Sep 2019 12:08:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <566d0d07-35fc-2d66-a47c-00526546b31e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="acRLstd836nhiJ0tGLchaut2utSxivRHT"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 20 Sep 2019 17:08:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--acRLstd836nhiJ0tGLchaut2utSxivRHT
Content-Type: multipart/mixed; boundary="kcIO3HQzKDyB65TLsDc2NQGUWVP9OhF6B";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: tasleson@redhat.com, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <c1c6ae56-ce0e-fddc-d72a-98a748b5c897@redhat.com>
Subject: Re: [RFC 0/4] POC: Generating realistic block errors
References: <20190919194847.18518-1-tasleson@redhat.com>
 <20190920083630.GA5458@localhost.localdomain>
 <566d0d07-35fc-2d66-a47c-00526546b31e@redhat.com>
In-Reply-To: <566d0d07-35fc-2d66-a47c-00526546b31e@redhat.com>

--kcIO3HQzKDyB65TLsDc2NQGUWVP9OhF6B
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/20/19 11:41 AM, Tony Asleson wrote:
> On 9/20/19 3:36 AM, Kevin Wolf wrote:
>> I/O error inserted by blkdebug can be one-off or permanent, but since =
it
>> also supports using a small state machine, I think you should already =
be
>> able to configure your errors that are corrected by a rewrite, too, ev=
en
>> if there is no explicit support for this yet (I guess we could add it =
if
>> it turned out to be much easier to use).
>=20
> One thing I thought about is the feasibility of having a callback for
> these errors across qapi.  For example you could register a sector for =
a
> read/write/both and when that operation occurs you would block IO, send=

> the sector number and associated data across qapi for test code to do
> something with it and respond allowing the operation to continue
> successfully or by returning an error determined by the external test
> code to be propagated to guest.
>=20
> This would allow the logic to be outside of QEMU.  So for example in th=
e
> re-write case the test code could remove the error when it gets the
> write, instead of having that logic embedded in QEMU itself.
>=20
> Thoughts?

To some extent, this sounds similar to what you can accomplish with an
NBD disk.  You can write an nbdkit plugin which exposes whatever error
handling you want (such as "the first read to this sector fails with
EIO, but a second read succeeds"), but only insofar as it fits in the
bounds of what the NBD protocol exposes over the wire (so qemu would see
EIO errors, and could narrow in on which portion of the disk provides or
avoids those errors, but would not have any additional insights that
would resemble a hardware-specific query without extensions to the NBD
protocol).

I am worried, however, that making data transactions have to go through
QMP to get an answer on how to handle a specific guest request will slow
things down; QMP is not built to be an efficient dataplane interface.
If you truly want isolation (where another process receives all guest
transactions, and makes decisions on how to handle them), it seems like
writing up a remote server (as in 'nbdkit' for the NBD protocol, or a
custom provider for the iscsi protocol) is the way to go.

[I have no idea if there is an iscsi counterpart for nbdkit; the iscsi
protocol is notoriously more complex than the NBD protocol, so it's not
something I'm likely to write]


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--kcIO3HQzKDyB65TLsDc2NQGUWVP9OhF6B--

--acRLstd836nhiJ0tGLchaut2utSxivRHT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl2FB6AACgkQp6FrSiUn
Q2pJIwf+JztofIgi+AFQC6cN8yb32J/JqAMZcC9j5i6T3iOCMifbjl739nojL4EB
NibrjTZKSXSoaUDrRvSc/WBYOCpa1YHZ7xR5rLDY9o1Ae6cFeJw7q5K8Db3F1QEi
rqw2dW2c+T48oVqiDDGIAzJH3FEYJdVUE9aWByQpgbWN9QezAg+OM0unHn2lbckt
JwqlSlCpDW+dVlyNTdyFXgck2v2U3oB3lOGksU7jqBEm+yxzHFFnaMUmW4t5686F
He2dTwRG3PMRIuIInwVakCHr2T/VW4nSulOi9yyEyY8uiK60P2certD9SBiSn/50
jXxCzVXQrCjcdmqA7xp9WxQ/wTb6Aw==
=2aer
-----END PGP SIGNATURE-----

--acRLstd836nhiJ0tGLchaut2utSxivRHT--

