Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19228C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 15:50:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDD1221734
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 15:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD1221734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48896 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLV1N-0004tI-V9
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 11:50:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLUuk-0007mj-22
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLUjw-0002fL-Q5
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:32:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:14278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hLUju-0002eb-IC; Tue, 30 Apr 2019 11:32:14 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 895483092650;
	Tue, 30 Apr 2019 15:32:13 +0000 (UTC)
Received: from [10.3.116.15] (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 88A0910013D9;
	Tue, 30 Apr 2019 15:32:12 +0000 (UTC)
To: qemu-devel@nongnu.org, patchew-devel@patchew.org, kwolf@redhat.com
References: <155663248155.10667.17447181616173672748@c2072b67cc0c>
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
Message-ID: <5ea85bff-8f16-d140-c3ac-d9aaea0186e2@redhat.com>
Date: Tue, 30 Apr 2019 10:32:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <155663248155.10667.17447181616173672748@c2072b67cc0c>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FtIzyKBbzQ74n16wQSA2Gx4QGPOgtDxvZ"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Tue, 30 Apr 2019 15:32:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH] qcow2: Fix qcow2_make_empty() with
 external data file
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
Cc: fam@euphon.net, qemu-stable@nongnu.org, qemu-block@nongnu.org,
	mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430153211.LwH-AjbCLj84HnvyQeP7jhliCwrRNv3shecOpLvVvKE@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FtIzyKBbzQ74n16wQSA2Gx4QGPOgtDxvZ
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org, patchew-devel@patchew.org, kwolf@redhat.com
Cc: fam@euphon.net, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 mreitz@redhat.com
Message-ID: <5ea85bff-8f16-d140-c3ac-d9aaea0186e2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qcow2: Fix qcow2_make_empty() with external
 data file
References: <155663248155.10667.17447181616173672748@c2072b67cc0c>
In-Reply-To: <155663248155.10667.17447181616173672748@c2072b67cc0c>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/30/19 8:54 AM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20190429105741.31033-1-kwolf@redh=
at.com/
>=20
>=20
>=20
> Hi,
>=20
> This series failed the docker-mingw@fedora build test. Please find the =
testing commands and
> their output below. If you have Docker installed, you can probably repr=
oduce it
> locally.
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> time make docker-test-mingw@fedora SHOW_ENV=3D1 J=3D14 NETWORK=3D1
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
>=20
>=20
>=20
> The full log is available at

Patchew trimmed a bit too much; also, the error appears to be transient
and unrelated to the patch at hand. Quoting from:

> http://patchew.org/logs/20190429105741.31033-1-kwolf@redhat.com/testing=
=2Edocker-mingw@fedora/?type=3Dmessage.



Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
fatal: git fetch_pack: expected ACK/NAK, got 'ERR upload-pack: not our
ref 1cd70b1217a3e02617dbba76d15d21be1e8e4aa0'
fatal: The remote end hung up unexpectedly
error: Could not fetch 3c8cf5a9c21ff8782164d1def7f44bd888713384
Traceback (most recent call last):
  File "patchew-tester/src/patchew-cli", line 521, in test_one
    git_clone_repo(clone, r["repo"], r["head"], logf, True)
  File "patchew-tester/src/patchew-cli", line 48, in git_clone_repo
    stdout=3Dlogf, stderr=3Dlogf)
  File "/usr/lib64/python3.4/subprocess.py", line 558, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['git', 'remote', 'add', '-f',
'--mirror=3Dfetch', '3c8cf5a9c21ff8782164d1def7f44bd888713384',
'https://github.com/patchew-project/qemu']' returned non-zero exit status=
 1


> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--FtIzyKBbzQ74n16wQSA2Gx4QGPOgtDxvZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzIansACgkQp6FrSiUn
Q2qB4wf9GkhwOjpharJgpF2+GxpIMkx3+jzVP0OXUr0nBHOJ1LRCMoP33wtRG3Sk
tJyQRBCE7dLSSA0SJpNIJGX/VTtUK80B2O2J5KTX2rzGZonMv0KAQ3rOxmQf9y5h
rSCj7oK9wZigfPqmQiLLa3Rnj/uGXL1jNIaE0W73C6q4c8DidmDouO684KPLUwxN
Cb0WdCe4N0Xl4f2U0/jhonuMWlHI3kKqMCspaCxHeofXLs3Jbf1fx02L74yz22ea
/8nZkPdnlkHhqQp+an0fafS3SMOyh5sXhWdAJRhavZZTTujLjNQGNiaxQK8UuuAD
nxWqaqU9nDUPF1IshLN5cHmBHSwuBQ==
=blqk
-----END PGP SIGNATURE-----

--FtIzyKBbzQ74n16wQSA2Gx4QGPOgtDxvZ--

