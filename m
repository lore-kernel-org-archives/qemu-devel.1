Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3625AC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 19:39:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0719120820
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 19:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0719120820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Ee1-0001yz-5u
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 15:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i5EdA-0001Xw-JY
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 15:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i5Ed8-0004Px-KU
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 15:38:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44340)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1i5Ed8-0004PR-Bp
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 15:38:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5AB5536887;
 Tue,  3 Sep 2019 19:38:17 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D07060606;
 Tue,  3 Sep 2019 19:38:16 +0000 (UTC)
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
References: <cover.1566503584.git.qemu_oss@crudebyte.com>
 <21182000.2zn5IIMESL@silver> <20190902173432.20f2637b@bahia.lan>
 <2734436.Mu773bgsdE@silver>
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
Message-ID: <46fe6c73-961f-d72a-77de-88491b6f223c@redhat.com>
Date: Tue, 3 Sep 2019 14:38:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2734436.Mu773bgsdE@silver>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NzPJN6hDJCioAunmbvha9r7JtUL8aJvdS"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 03 Sep 2019 19:38:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 0/4] 9p: Fix file ID collisions
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
Cc: stefanha@gmail.com, berrange@redhat.com, Greg Kurz <groug@kaod.org>,
 antonios.motakis@huawei.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NzPJN6hDJCioAunmbvha9r7JtUL8aJvdS
Content-Type: multipart/mixed; boundary="6GAnIbu9XYrG1pk8AWKpUwldCxVA1wNs6";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, stefanha@gmail.com, Greg Kurz <groug@kaod.org>,
 dgilbert@redhat.com, antonios.motakis@huawei.com
Message-ID: <46fe6c73-961f-d72a-77de-88491b6f223c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 0/4] 9p: Fix file ID collisions
References: <cover.1566503584.git.qemu_oss@crudebyte.com>
 <21182000.2zn5IIMESL@silver> <20190902173432.20f2637b@bahia.lan>
 <2734436.Mu773bgsdE@silver>
In-Reply-To: <2734436.Mu773bgsdE@silver>

--6GAnIbu9XYrG1pk8AWKpUwldCxVA1wNs6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/2/19 5:29 PM, Christian Schoenebeck via Qemu-devel wrote:

>>>>> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
>>>>> 1/4 Checking commit bb69de63f788 (9p: Treat multiple devices on one=

>>>>> export
>>>>> as an error) ERROR: Author email address is mangled by the mailing
>>>>> list
>>>>> #2:
>>>>> Author: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org=
>
>>>>
>>>> This is problematic since it ends up in the Author: field in git. Pl=
ease
>>>> find a way to fix that.
>>>
>>> Like in which way do you imagine that? And where is the actual practi=
cal
>>> problem? I mean every patch still has my signed-off-by tag with the
>>> correct
>>> email address ending up in git history.
>>
>> Yes, this only breaks Author: if the patch is applied from the list.

Except that many maintainers DO apply mail from the list (thanks to 'git
am').  Fixing patchew to unmunge things is an appealing idea, but would
not fix the problem for maintainers not cloning from patchew, so even if
patchew avoids the problem locally, it should still continue to warn
about the problem.

>>
>>> The cause for this issue is that the domain is configured to require =
DKIM
>>> signatures for all outgoing emails. That's why mailman replaces my ad=
dress
>>> by "Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>"
>>> placeholder since it could not provide a valid signature.

And when you know that mailman is going to munge your address, the fix
is to configure git to output 'From: correct name <correct@example.com>'
as the first line of the BODY of the message, since 'git am' favors the
unmunged From: from the body over the munged From: from the headers.


>=20
>> So, this means that patchew will complain each time you post if we can=
't
>> find a proper way to address that... :-\
>=20
> Well, mailman is handling this correctly. It replaces the "From:" field=
 with a=20
> placeholder and instead adds my actual email address as "Reply-To:" fie=
ld.=20
> That's the common way to handle this on mailing lists, as also mentione=
d here:
> https://en.wikipedia.org/wiki/DMARC#From:_rewriting
>=20
> So IMO patchew should automatically use the value of "Reply-To:" in tha=
t case=20
> as author of patches instead.
>=20
> Reducing security cannot be the solution.

No, there's no need to reduce security.  Just change your local git
configuration to produce a 'From:' line in the commit body..

>> How are you sending patches ? With git send-email ? If so, maybe you c=
an
>> pass something like --from=3D'"Christian Schoenebeck"
>> <qemu_oss@crudebyte.com>'. Since this is a different string, git will
>> assume you're sending someone else's patch : it will automatically add=
 an
>> extra From: made out of the commit Author as recorded in the git tree.=


I think it is probably as simple as a 'git config' command to tell git
to always put a 'From:' in the body of self-authored patches when using
git format-patch; however, as I don't suffer from munged emails, I
haven't actually tested what that setting would be.

>=20
> I use "git format-patch ..." to dump the invidiual emails as raw email =
sources=20
> and then I'll send those raw emails from the command line. So I have ev=
en more=20
> control of what is exactly sent out and could of course also add custom=
 email=20
> header fields if required, if that would solve the situation somehow, i=
=2Ee.=20
> manually as first test and later in automated way. That's not the issue=
 here.

Working around the problem does not require munging email headers, but
adding a line to the email body.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--6GAnIbu9XYrG1pk8AWKpUwldCxVA1wNs6--

--NzPJN6hDJCioAunmbvha9r7JtUL8aJvdS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1uwScACgkQp6FrSiUn
Q2o9UwgAqcHsB3XvVxXiFxaLupNCvP3Nq8YBl5Ko0x2nmwb5sUa5skuLiV7rUKUh
YvaCZZRreFBC5ShG9Z0TCDnW/8W0uOTO/E+rXyscwzCnUTzo686afcep02f5yb3O
Ao1bkKrr5TIKtS9PdpxXIdnMRFyUSu+R8CCyOQ4XyY9emXmefePahpXLurlXGIhg
e5PQ5rfAmWuCcy6HNkT54wp196reWbQ4bRw7ihzlUUJ0QOLY7b3qgun2YtjMEx+1
e1T4xqxL/KM87Q0WSDiekrxQSWb4M/ZFCCDWojHF3nZMoYuldvx8nNWHNwgBhx39
b0LPnl0SvWWSOAIXWpzYpNbQxfBJgw==
=njut
-----END PGP SIGNATURE-----

--NzPJN6hDJCioAunmbvha9r7JtUL8aJvdS--

