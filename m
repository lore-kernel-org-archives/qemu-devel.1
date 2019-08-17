Return-Path: <SRS0=glhp=WN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928AEC3A59B
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 14:57:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A20D21744
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 14:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A20D21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hz09O-0004Gb-96
	for qemu-devel@archiver.kernel.org; Sat, 17 Aug 2019 10:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56318)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1hz08e-0003b1-Ne
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 10:57:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hz08d-0008LS-Nm
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 10:57:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36206)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hz08X-0008IH-CZ; Sat, 17 Aug 2019 10:56:57 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 306313001571;
 Sat, 17 Aug 2019 14:56:56 +0000 (UTC)
Received: from [10.3.116.18] (ovpn-116-18.phx2.redhat.com [10.3.116.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B64D310013A7;
 Sat, 17 Aug 2019 14:56:52 +0000 (UTC)
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <1554474244-553661-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1677e835-39a1-4af3-8f4f-e1600021a2ee@redhat.com>
 <fa4f4405-5a51-c7ec-f712-95e40ef6dd41@redhat.com>
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
Message-ID: <5dc0231e-6fbc-3efc-8cc7-ff953651d0e9@redhat.com>
Date: Sat, 17 Aug 2019 09:56:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <fa4f4405-5a51-c7ec-f712-95e40ef6dd41@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Kfz6SsAGP2YASW4qcTMY9GDlgilVtyTqx"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Sat, 17 Aug 2019 14:56:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] block/io.c: fix for the allocation failure
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Kfz6SsAGP2YASW4qcTMY9GDlgilVtyTqx
Content-Type: multipart/mixed; boundary="Xt1LqX3OqK3MQCKNjK3NcT8eJt36kiuUf";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Message-ID: <5dc0231e-6fbc-3efc-8cc7-ff953651d0e9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block/io.c: fix for the allocation failure
References: <1554474244-553661-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1677e835-39a1-4af3-8f4f-e1600021a2ee@redhat.com>
 <fa4f4405-5a51-c7ec-f712-95e40ef6dd41@redhat.com>
In-Reply-To: <fa4f4405-5a51-c7ec-f712-95e40ef6dd41@redhat.com>

--Xt1LqX3OqK3MQCKNjK3NcT8eJt36kiuUf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/17/19 9:49 AM, Eric Blake wrote:

>> This change is a regression of sorts.  Now, you are unconditionally
>> attempting the fallback for ALL failures (such as EIO) and for all
>> drivers, even when that was not previously attempted and increases the=

>> traffic.  I think we should revert this patch and instead fix the
>> fallocate() path to convert whatever ACTUAL errno you got from unalign=
ed
>> fallocate failure into ENOTSUP (that is, just the file-posix.c locatio=
n
>> that failed), while leaving all other errors as immediately fatal.

Or even better, fix the call site of fallocate() to skip attempting an
unaligned fallocate(), and just directly return ENOTSUP, rather than
trying to diagnose EINVAL after the fact.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--Xt1LqX3OqK3MQCKNjK3NcT8eJt36kiuUf--

--Kfz6SsAGP2YASW4qcTMY9GDlgilVtyTqx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1YFbMACgkQp6FrSiUn
Q2ov5wgAoH76GVa1Bygw8FgOWy0zZTUgRNF6Pg6YY9fAFyf8tK6aKcu5LnpsvYfl
k0qITS35k+8CTR4AgNutdhKs2cj2fh/QgsCP2D1DqIMoOEW0JUzPdsw+y95txRpA
xd2Y52M4aFJralt8HONG5hGnYspwYKIbNfh/eBb7rOJm9lqk5f7z/i1ULlOH1PhS
7D1ju7UV+ebgrF9KCbBp8ihM8ZJD7X9pHs2M52e0vJBatRn5As7/5iQpDvTrZY9b
Z4Yfn4LQh+lVmHW08QiQRqQI5odP0r3XLNN72PlX0Jve35d04w0lCyt9BXqgoXo1
S4+ti/m0Fov++h4jnBAOWwFZ2HZNKQ==
=TCCH
-----END PGP SIGNATURE-----

--Kfz6SsAGP2YASW4qcTMY9GDlgilVtyTqx--

