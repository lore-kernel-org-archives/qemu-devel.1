Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11B3C072B5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 01:43:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BB0E2173C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 01:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB0E2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34037 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTGI0-0003R4-FV
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 21:43:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hTGH1-00035E-8H
	for qemu-devel@nongnu.org; Tue, 21 May 2019 21:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hTGBX-0007f1-9o
	for qemu-devel@nongnu.org; Tue, 21 May 2019 21:36:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hTGBX-0007eC-1M
	for qemu-devel@nongnu.org; Tue, 21 May 2019 21:36:51 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F1018859FC;
	Wed, 22 May 2019 01:36:49 +0000 (UTC)
Received: from [10.3.116.56] (ovpn-116-56.phx2.redhat.com [10.3.116.56])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CB0B719744;
	Wed, 22 May 2019 01:36:43 +0000 (UTC)
To: Wei Yang <richardw.yang@linux.intel.com>,
	Markus Armbruster <armbru@redhat.com>
References: <20190521081227.30799-1-richardw.yang@linux.intel.com>
	<c184d4f7-686b-d54a-f969-a05ab965028a@redhat.com>
	<87lfyzrfms.fsf@dusky.pond.sub.org> <20190522005349.GC14030@richard>
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
Message-ID: <09538032-9453-9d09-2823-1515005b5516@redhat.com>
Date: Tue, 21 May 2019 20:36:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522005349.GC14030@richard>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MIiViPUKb04rXtqIDjgS7SfxCSCo3MucC"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Wed, 22 May 2019 01:36:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH] Makefile: simplify qapi-py definition with
 wildcard
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
Cc: berrange@redhat.com, kraxel@redhat.com, alex.bennee@linaro.org,
	qemu-devel@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MIiViPUKb04rXtqIDjgS7SfxCSCo3MucC
From: Eric Blake <eblake@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, berrange@redhat.com,
 philmd@redhat.com, kraxel@redhat.com
Message-ID: <09538032-9453-9d09-2823-1515005b5516@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Makefile: simplify qapi-py definition with
 wildcard
References: <20190521081227.30799-1-richardw.yang@linux.intel.com>
 <c184d4f7-686b-d54a-f969-a05ab965028a@redhat.com>
 <87lfyzrfms.fsf@dusky.pond.sub.org> <20190522005349.GC14030@richard>
In-Reply-To: <20190522005349.GC14030@richard>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/21/19 7:53 PM, Wei Yang wrote:
> On Tue, May 21, 2019 at 05:28:27PM +0200, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>>
>>> On 5/21/19 3:12 AM, Wei Yang wrote:
>>>> All the python script in scripts/qapi is used to generate qapi code.=
 Use
>>>> wildcard to simplify it.
>>>>
>>>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>>>> ---
>>>>  Makefile | 8 +-------
>>>>  1 file changed, 1 insertion(+), 7 deletions(-)
>>>
>>> I'm not a fan of $(wildcard). It makes your tarball creation
>>> non-deterministic - if there is a leftover file from development that=
 is
>>> no longer part of the build, wildcard will still pick it up.  Explici=
t
>>
>> Actually, in this case can "only" adds spurious prerequisites.
>=20
> Hmm... which spurious prerequisites will be added? I may miss something=
 here.

If I touch the file scripts/qapi/foo.py, then that becomes a
prerequisite, and will rebuild my files even though it doesn't need to.
And if the definition of $(qapi-py) is ever applied to determining which
files to include in a tarball, then my tarball will include foo.py, even
though it is not essential to the tarball, while the next person, who
does not have foo.py lying around in their directory, produces a
different tarball.  Non-deterministic results are bad, hence our rule of
thumb to avoid $(wildcard) when listing files in a Makefile.

>=20
>>
>>> lists are better.  I'm inclined to NACK this, but Markus has final sa=
y
>>> since he maintains the qapi generator.
>>
>> I consider use of $(wildcard) for the purpose of collecting sources a
>> lazy mistake.

Which is another polite way of saying that this patch should not be appli=
ed.

If you WANT to factor things for less typing, you could use something lik=
e:

var=3Dcommands.py events.py introspect.py types.py visit.py common.py doc=
=2Epy
$(addprefix $(SRC_PATH)/scripts/qapi/,$(var))

for some suitably-named var.  Or even factor out the .py suffix as well.
That doesn't use the problematic $(wildcard), but still lets you get
away with easier maintenance of adding a new file to the explicit list
should we add a file in the future.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--MIiViPUKb04rXtqIDjgS7SfxCSCo3MucC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzkp6oACgkQp6FrSiUn
Q2rTBggAjiOTKLnLtyR+RG4UCmcOGlWe0gFjmZbm6WuqMg+6qevm5HVuMvPusItH
P0gIY5RkpP0WmjsCheQ5rK7KeiWukQT2/M+Q1crAiFXfM50baLJGISU2vB/f2qDT
53PxvmoQjphk6Dk2NVrC4GSC0ZIEnuoNGPIkPJ0ySfTMDsCPQzqTEvfx5Tx+br7t
AHOil4sC3D1MI83isZSQCnzkVB+X33HZcnOuYUzR/zXJrfxUYSRGx5vAFnC5gmZX
MUn579lvr91BIW0iShGUyPtdez7sH02U1n9popHTKuIN+ZdvFEUtfPWFffgpPErR
sssc1lHpEyZ+Y5YFm25ZZKLVTKTkMg==
=CX9T
-----END PGP SIGNATURE-----

--MIiViPUKb04rXtqIDjgS7SfxCSCo3MucC--

