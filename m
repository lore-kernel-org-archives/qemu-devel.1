Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3137DC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 18:03:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC9C4206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 18:03:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC9C4206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35401 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEHYx-0002Sr-OY
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 14:03:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hEHXh-0001w3-4X
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 14:01:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hEHXd-0000Rd-6q
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 14:01:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11489)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hEHXZ-0000Ol-7H; Wed, 10 Apr 2019 14:01:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ED36C753F7;
	Wed, 10 Apr 2019 18:01:39 +0000 (UTC)
Received: from [10.3.117.110] (ovpn-117-110.phx2.redhat.com [10.3.117.110])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 50126BA83;
	Wed, 10 Apr 2019 18:01:39 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20190401140903.19186-1-eblake@redhat.com>
	<20190401140903.19186-8-eblake@redhat.com>
	<22c4f9fa-a740-0d01-7b45-c802817f4f6c@redhat.com>
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
Message-ID: <1b8e1af8-cde5-75d5-a4d4-a0b6d56e6608@redhat.com>
Date: Wed, 10 Apr 2019 13:01:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <22c4f9fa-a740-0d01-7b45-c802817f4f6c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8n8u6I1ehrjWNfSgI7SYBycbTXmXXogK0"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Wed, 10 Apr 2019 18:01:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [Qemu-block] [PULL 07/14] iotests: Add 241 to test
 NBD on unaligned images
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
Cc: Kevin Wolf <kwolf@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	"open list:Block layer core" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410180138.UCjfRM6Z18GOpDHuIWGR_Ic5Uq0oLlJYbzhYJZ7Oj3w@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8n8u6I1ehrjWNfSgI7SYBycbTXmXXogK0
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Message-ID: <1b8e1af8-cde5-75d5-a4d4-a0b6d56e6608@redhat.com>
Subject: Re: [Qemu-block] [PULL 07/14] iotests: Add 241 to test NBD on
 unaligned images
References: <20190401140903.19186-1-eblake@redhat.com>
 <20190401140903.19186-8-eblake@redhat.com>
 <22c4f9fa-a740-0d01-7b45-c802817f4f6c@redhat.com>
In-Reply-To: <22c4f9fa-a740-0d01-7b45-c802817f4f6c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/10/19 12:45 PM, Max Reitz wrote:
> On 01.04.19 16:08, Eric Blake wrote:
>> Add a test for the NBD client workaround in the previous patch.  It's
>> not really feasible for an iotest to assume a specific tracing engine,=

>> so we can't really probe trace_nbd_parse_blockstatus_compliance to see=

>> if the server was fixed vs. whether the client just worked around the
>> server (other than by rearranging order between code patches and this
>> test). But having a successful exchange sure beats the previous state
>> of an error message. Since format probing can change alignment, we can=

>> use that as an easy way to test several configurations.
>>
>> Not tested yet, but worth adding to this test in future patches: an
>> NBD server that can advertise a non-sector-aligned size (such as
>> nbdkit) causes qemu as the NBD client to misbehave when it rounds the
>> size up and accesses beyond the advertised size. Qemu as NBD server
>> never advertises a non-sector-aligned size (since bdrv_getlength()
>> currently rounds up to sector boundaries); until qemu can act as such
>> a server, testing that flaw will have to rely on external binaries.
>>

>> +++ b/tests/qemu-iotests/241.out

>> +=3D=3D=3D Exporting unaligned raw image, forced server sector alignme=
nt =3D=3D=3D
>> +
>> +WARNING: Image format was not specified for '/home/eblake/qemu/tests/=
qemu-iotests/scratch/t.raw' and probing guessed raw.
>> +         Automatically detecting the format is dangerous for raw imag=
es, write operations on block 0 will be restricted.
>> +         Specify the 'raw' format explicitly to remove the restrictio=
ns.
>=20
> Is there a patch for this already?

Oh shoot. I saw the complaint about the hard-coded path needing a
filter, and still failed to fix it in time for 4.0-rc3. Not a driver for
-rc4 on its own, but if we have something else pop up that mandates
-rc4, I'll get that fix in.

Will post shortly...

>=20
> Also, I planned to reply to the original patch =E2=80=93 but where is i=
t?  The
> latest version I can see on the list is v3, and that only has seven
> lines in the reference output.  Well, the difference would explain why
> Vladimir would give a Tested-by to a test that clearly will not run on
> his machine.

Yeah, this line in the commit message is evidence of my botching things:

> [eblake: add forced-512 alignment, and nbdkit reproducer comment]

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--8n8u6I1ehrjWNfSgI7SYBycbTXmXXogK0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyuL4IACgkQp6FrSiUn
Q2q7pAf/S13b2Nt/gvgjp96NtHWUI0kH8BcvzRYjCgmE4jQjt9rrVdQsjracpjyj
1x4xC62YNtYLEmLutU3fU+z6S/o1brtkz0mnddcb3XZWtMGg6RJECFa2R1muVKcu
B3t3lcW6QhsSdpcXm2hDI5k3idljpEPVmN2LuWrkg7anCHnAfnajmCZC9Hi6+t+W
+ZU0PorW9p6/4q75PlwcvDwC9Dz3cY/WZ0R/eQXaiSZEACMM5yulAvO2jz3IZ72P
V1pkKGgZTsnihCPVHtEqh1Z2hPISC8bAj1N0+lXlA+JkjZCmdo9Ht4/shqOawMf+
N0WofQer42WNBstR3AwwD+HsV6Hptg==
=f6sx
-----END PGP SIGNATURE-----

--8n8u6I1ehrjWNfSgI7SYBycbTXmXXogK0--

