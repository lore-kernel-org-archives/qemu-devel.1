Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A22C43218
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 22:14:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46B412082E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 22:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B412082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50064 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haSYs-0002uy-1D
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 18:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41672)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1haSXN-0001kG-IH
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 18:13:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1haSRz-00057Q-4m
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 18:07:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47056)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1haSRy-00056V-SO
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 18:07:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DDC5087633;
 Mon, 10 Jun 2019 22:07:33 +0000 (UTC)
Received: from [10.3.116.85] (ovpn-116-85.phx2.redhat.com [10.3.116.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 115255DA2E;
 Mon, 10 Jun 2019 22:07:30 +0000 (UTC)
To: Gary Dale <gary@extremeground.com>, Stefan Hajnoczi <stefanha@gmail.com>
References: <abb7990e-0331-67a4-af92-05276366478c@extremeground.com>
 <20190610121941.GI14257@stefanha-x1.localdomain>
 <dc7a70ea-c94f-e975-df44-b0199da698e2@extremeground.com>
 <ab3e81c2-f0ce-2ef5-bbe7-948a87463b59@extremeground.com>
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
Message-ID: <edf57b3a-660c-0964-2455-9461b9aa2711@redhat.com>
Date: Mon, 10 Jun 2019 17:07:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ab3e81c2-f0ce-2ef5-bbe7-948a87463b59@extremeground.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="K2gJayIcESzcEPVHUa0os4mXQveQZHVdm"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Mon, 10 Jun 2019 22:07:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] kvm / virsh snapshot management
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--K2gJayIcESzcEPVHUa0os4mXQveQZHVdm
Content-Type: multipart/mixed; boundary="6lITd0FOqQXdxW57qkKHEujFi00VZHlSQ";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Gary Dale <gary@extremeground.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Message-ID: <edf57b3a-660c-0964-2455-9461b9aa2711@redhat.com>
Subject: Re: [Qemu-devel] kvm / virsh snapshot management
References: <abb7990e-0331-67a4-af92-05276366478c@extremeground.com>
 <20190610121941.GI14257@stefanha-x1.localdomain>
 <dc7a70ea-c94f-e975-df44-b0199da698e2@extremeground.com>
 <ab3e81c2-f0ce-2ef5-bbe7-948a87463b59@extremeground.com>
In-Reply-To: <ab3e81c2-f0ce-2ef5-bbe7-948a87463b59@extremeground.com>

--6lITd0FOqQXdxW57qkKHEujFi00VZHlSQ
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/10/19 4:27 PM, Gary Dale wrote:

>>
> Trying this against a test VM, I ran into a roadblock. My command line
> and the results are:
>=20
> # virsh blockcommit stretch "/home/secure/virtual/stretch.qcow2" --top
> stretchS3 --delete --wait
> error: unsupported flags (0x2) in function qemuDomainBlockCommit
>=20
> I get the same thing when the path to the qcow2 file isn't quoted.

That's a libvirt limitation - the --delete flag is documented from the
generic API standpoint, but not (yet) implemented for the qemu driver
within libvirt. For now, you have to omit --delete from your virsh
command line, and then manually 'rm' the unused external file after the
fact.

>=20
> I noted in
> https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/=
6/html/virtualization_administration_guide/sub-sect-domain_commands-using=
_blockcommit_to_shorten_a_backing_chain
> that the options use a single "-".

Sounds like a bug in that documentation.

> However the results for that were:
> # virsh blockcommit stretch /home/secure/virtual/stretch.qcow2 -top
> stretchS3 -delete -wait
> error: Scaled numeric value '-top' for <--bandwidth> option is malforme=
d
> or out of range
>=20
> which looks like virsh doesn't like the single dashes and is trying to
> interpret them as positional options.
>=20
> I also did a
>=20
> # virsh domblklist stretch
> Target=A0=A0=A0=A0 Source
> ------------------------------------------------
> vda=A0=A0=A0=A0=A0=A0=A0 /home/secure/virtual/stretch.qcow2
> hda=A0=A0=A0=A0=A0=A0=A0 -
>=20
> and tried using vda instead of the full path in the blockcommit but got=

> the same error.
>=20
> Any ideas on what I'm doing wrong?

Do you know for sure whether you have internal or external snapshots?
And at this point, your questions are starting to wander more into
libvirt territory.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--6lITd0FOqQXdxW57qkKHEujFi00VZHlSQ--

--K2gJayIcESzcEPVHUa0os4mXQveQZHVdm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlz+1KIACgkQp6FrSiUn
Q2obeggAjN1NyupIkTIcuJET++dftWIhs2P8uigcNCSFMV3ZewRuU+OT5qyoV621
LihI/hOPVD8zqtifMxNQNiLE75B7JJKSccLPvtPAj5T1qK3qpAtuW6i1ANcHRpq1
iTxQISn5E4jcVUpDHrfIfs7ABPuC2JzTIP7wOr+dL+3/6/aKoNSkjzJpkN05ttwO
AFoxH/zOKWAjS13SpUYtkSJkc+x1BmVqV9TN0r7XPy1Lq0U64WO8UrsoG6HSFNG4
E5/xO3ceQg5gpPt47PdEzmu5j1HBkFOYVbdkgP+DJ4NJ3YxC+E3iL8h8cDu50WEb
lp2Wi5DmBLUF3GLDuwBGOqvIs/8e7A==
=oRXe
-----END PGP SIGNATURE-----

--K2gJayIcESzcEPVHUa0os4mXQveQZHVdm--

