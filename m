Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44842C31E41
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 15:37:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10F8020859
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 15:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F8020859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47760 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haMMn-0004cl-65
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 11:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51094)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1haMLi-0003qt-QU
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 11:36:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1haMLh-00056p-T4
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 11:36:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47016)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1haMLf-00054R-LT; Mon, 10 Jun 2019 11:36:39 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2AA0F20264;
 Mon, 10 Jun 2019 15:36:33 +0000 (UTC)
Received: from [10.3.116.85] (ovpn-116-85.phx2.redhat.com [10.3.116.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D650196AA;
 Mon, 10 Jun 2019 15:36:31 +0000 (UTC)
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <1560105348-459129-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1560105348-459129-2-git-send-email-andrey.shinkevich@virtuozzo.com>
 <96a6fd48-9e84-1285-1932-3ce1736cd08c@redhat.com>
 <786c3499-9bb4-0fa6-a4f1-f7537be73712@virtuozzo.com>
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
Message-ID: <023d5b7f-23c2-59e3-113e-684c9da6457a@redhat.com>
Date: Mon, 10 Jun 2019 10:36:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <786c3499-9bb4-0fa6-a4f1-f7537be73712@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3e7xvH66woZdbAV4JI4OzUfwaRzCYRtjG"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Mon, 10 Jun 2019 15:36:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/7] iotests: allow Valgrind checking all
 QEMU processes
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Roman Kagan <rkagan@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3e7xvH66woZdbAV4JI4OzUfwaRzCYRtjG
Content-Type: multipart/mixed; boundary="Yry8N8jIwZSsKTExlU1mb0L5n2ldB8Ut5";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>
Message-ID: <023d5b7f-23c2-59e3-113e-684c9da6457a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/7] iotests: allow Valgrind checking all
 QEMU processes
References: <1560105348-459129-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1560105348-459129-2-git-send-email-andrey.shinkevich@virtuozzo.com>
 <96a6fd48-9e84-1285-1932-3ce1736cd08c@redhat.com>
 <786c3499-9bb4-0fa6-a4f1-f7537be73712@virtuozzo.com>
In-Reply-To: <786c3499-9bb4-0fa6-a4f1-f7537be73712@virtuozzo.com>

--Yry8N8jIwZSsKTExlU1mb0L5n2ldB8Ut5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/10/19 10:02 AM, Andrey Shinkevich wrote:
>=20
>=20
> On 10/06/2019 17:24, Eric Blake wrote:
>> On 6/9/19 1:35 PM, Andrey Shinkevich wrote:
>>> With the '-valgrind' option, let all the QEMU processes be run under
>>> the Valgrind tool. The Valgrind own parameters may be set with its
>>> environment variable VALGRIND_OPTS, e.g.
>>> VALGRIND_OPTS=3D"--leak-check=3Dyes" ./check -qcow2 -valgrind <test#>=

>>
>> Let's spell this --valgrind; long options should prefer the use of --
>> (as in getopt_long), whether or not we also have a reason to support
>> -valgrind (as in getopt_long_only). Yes, qemu is an oddball in this
>> regards, but no need to make it worse.
>>
>=20
> Thank you, Eric. That sounds good but the short option'-valgrind' is
> preexisting in QEMU. Should I create a new patch for the long option?
> If so, will we have both options supported by QEMU?

Oh, you're talking about qemu-iotests/check already supporting merely
'-valgrind', not 'qemu-kvm' or '*/qemu-system-*'.  ./check is already an
oddball for not permitting double dash, but at this point, normalizing
it is a lot of churn. So it becomes a tradeoff on how much grunt work do
you really want to do.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--Yry8N8jIwZSsKTExlU1mb0L5n2ldB8Ut5--

--3e7xvH66woZdbAV4JI4OzUfwaRzCYRtjG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlz+ePoACgkQp6FrSiUn
Q2rJQQf/RCTu5RYwOJ+r73rexIaWYLVdVjmoi2lHulGTWObUbt1Nr0GNHUgnPKON
ODwuAo/Fses3bE+s3oX+NTjqjrrZ4gAR2PwU3MoXfHkWrME+4YU/IbOQuuvookKt
Mi5Jc7g6H9bfyL+GrbkyFj49u5nZBbwYo0sHIG3EKjCvt+3NfeRocVU//nVIj9CW
cCOWt+pCSGJQkj/CdA7hn9OVxHd+nROXwmeEMFWL5AolM5NmEYEOltdkb3ZI/k9O
PmViham2yPkelFoHhhGxEfe4mgguE1/wkoci2sUf77ddB6m1XnhGntjQ2hJGppd6
nj+8b+lCwROl7mSpE9mKUcqMwRbgqw==
=sqAY
-----END PGP SIGNATURE-----

--3e7xvH66woZdbAV4JI4OzUfwaRzCYRtjG--

