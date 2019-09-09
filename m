Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541B5C4740C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 16:44:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2572421479
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 16:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2572421479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7Mly-0000U5-BQ
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 12:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i7MlC-0008MA-Bt
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 12:43:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i7MlB-0006Sd-Ar
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 12:43:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54026)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i7Ml8-0006Ot-SR; Mon, 09 Sep 2019 12:43:23 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 392A269078;
 Mon,  9 Sep 2019 16:43:22 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 97E086012A;
 Mon,  9 Sep 2019 16:43:21 +0000 (UTC)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20190907172055.26870-1-eblake@redhat.com>
 <20190909091322.GA24509@redhat.com>
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
Message-ID: <5a56a456-b1dc-9d15-2047-b3fde440854d@redhat.com>
Date: Mon, 9 Sep 2019 11:43:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190909091322.GA24509@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UL1PFjYoDU0PyL8LphORVq0Ob8ZBQGamD"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Mon, 09 Sep 2019 16:43:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] nbd/client: Add hint when TLS is missing
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
Cc: qemu-devel@nongnu.org,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Tingting Mao <timao@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UL1PFjYoDU0PyL8LphORVq0Ob8ZBQGamD
Content-Type: multipart/mixed; boundary="k36iQDjo2o2lEH4cmZHHKPS7Imp2ZfFty";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Tingting Mao <timao@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Message-ID: <5a56a456-b1dc-9d15-2047-b3fde440854d@redhat.com>
Subject: Re: [PATCH] nbd/client: Add hint when TLS is missing
References: <20190907172055.26870-1-eblake@redhat.com>
 <20190909091322.GA24509@redhat.com>
In-Reply-To: <20190909091322.GA24509@redhat.com>

--k36iQDjo2o2lEH4cmZHHKPS7Imp2ZfFty
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/9/19 4:13 AM, Daniel P. Berrang=C3=A9 wrote:
> On Sat, Sep 07, 2019 at 12:20:55PM -0500, Eric Blake wrote:
>> I received an off-list report of failure to connect to an NBD server
>> expecting an x509 certificate, when the client was attempting somethin=
g
>> similar to this command line:
>>

>> +++ b/nbd/client.c
>> @@ -204,6 +204,7 @@ static int nbd_handle_reply_err(QIOChannel *ioc, N=
BDOptionReply *reply,
>>      case NBD_REP_ERR_TLS_REQD:
>>          error_setg(errp, "TLS negotiation required before option %" P=
RIu32
>>                     " (%s)", reply->option, nbd_opt_lookup(reply->opti=
on));
>> +        error_append_hint(errp, "Did you forget a valid tls-creds?\n"=
);
>>          break;
>>
>>      case NBD_REP_ERR_UNKNOWN:
>=20
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Thanks. I should really learn to finish my iotest runs before posting,
because I have to squash this in before queuing through my NBD tree.

diff --git i/tests/qemu-iotests/233.out w/tests/qemu-iotests/233.out
index 24321efa113b..c3c344811b2b 100644
--- i/tests/qemu-iotests/233.out
+++ w/tests/qemu-iotests/233.out
@@ -21,8 +21,10 @@ server reported: TLS not configured

 =3D=3D check plain client to TLS server fails =3D=3D
 qemu-img: Could not open 'nbd://localhost:PORT': TLS negotiation
required before option 7 (go)
+Did you forget a valid tls-creds?
 server reported: Option 0x7 not permitted before TLS
 qemu-nbd: TLS negotiation required before option 3 (list)
+Did you forget a valid tls-creds?
 server reported: Option 0x3 not permitted before TLS

 =3D=3D check TLS works =3D=3D


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--k36iQDjo2o2lEH4cmZHHKPS7Imp2ZfFty--

--UL1PFjYoDU0PyL8LphORVq0Ob8ZBQGamD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl12gSgACgkQp6FrSiUn
Q2pp3wf+MImFZTzqvkPdSrGeMDImt6VyT5QaGvlr4EHwj8s6YoCrYaH9C/KED/3i
xv7S5mpdjsyXGpFu5klS3StSVhp95YEqEuP6qELsu2yarkk4Ng8iJlUTlCZgulkN
CuflyBTof+efC9XyUpqxuccpsmdkMSMCBYjZCY6H2GF5xAveL799wxUjN3WuG88J
M5L2x0NIstxLKbfDdoGGbRJNDAL2EgBIDLUVbP8D5csTym8aOu0V/Rhu1wSOV9Cq
44bSmXDw67A0qbgGEE4B0ZXPh/kkCDcQKu9k8roh2uytejcazhFxXsiVwel//CUf
vqbpYOXxgGLBCCqrOWIS7zcnSMxktg==
=H4PU
-----END PGP SIGNATURE-----

--UL1PFjYoDU0PyL8LphORVq0Ob8ZBQGamD--

