Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DED7C10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 14:52:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC73420656
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 14:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC73420656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38360 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIaIq-0007f0-NI
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 10:52:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hIaI1-0007KV-6s
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:51:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hIaHz-0000HM-WC
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:51:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hIaHz-0000Gi-N4
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:51:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 20D09C049E20;
	Mon, 22 Apr 2019 14:51:22 +0000 (UTC)
Received: from [10.3.116.149] (ovpn-116-149.phx2.redhat.com [10.3.116.149])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 03EAD61B7C;
	Mon, 22 Apr 2019 14:51:18 +0000 (UTC)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
	qemu-devel@nongnu.org
References: <20190211182442.8542-1-berrange@redhat.com>
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
Message-ID: <46b6b751-4e3f-1b11-9ac7-d0d73cca2227@redhat.com>
Date: Mon, 22 Apr 2019 09:51:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190211182442.8542-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="z3hgxBtKre85to5bdVEyc7HYKiSm0hBKs"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Mon, 22 Apr 2019 14:51:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v3 00/16] chardev: refactoring & many
 bugfixes related tcp_chr_wait_connected
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Max Reitz <mreitz@redhat.com>, Yongji Xie <elohimes@gmail.com>,
	=?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422145117.awsPh8lsu3V5jIdPnhdPxlpUJ-GL5kIJ9-KJ95CHrKc@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--z3hgxBtKre85to5bdVEyc7HYKiSm0hBKs
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Yongji Xie <elohimes@gmail.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <46b6b751-4e3f-1b11-9ac7-d0d73cca2227@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 00/16] chardev: refactoring & many
 bugfixes related tcp_chr_wait_connected
References: <20190211182442.8542-1-berrange@redhat.com>
In-Reply-To: <20190211182442.8542-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/11/19 12:24 PM, Daniel P. Berrang=C3=A9 wrote:
> This is a followup to
>=20
>   v1: https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg03344.ht=
ml
>   v2: http://lists.nongnu.org/archive/html/qemu-devel/2019-01/msg05947.=
html
>=20
> This series comes out of a discussion between myself & Yongji Xie in:
>=20
>   https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg01881.html
>=20
> I eventually understood that the problem faced was that
> tcp_chr_wait_connected was racing with the background connection attemp=
t
> previously started, causing two connections to be established. This
> broke because some vhost user servers only allow a single connection.
>=20
> After messing around with the code alot the final solution was in fact
> very easy. We simply have to delay the first background connection
> attempt until the main loop is running. It will then automatically
> turn into a no-op if tcp_chr_wait_connected has been run. This is
> dealt with in the last patch in this series
>=20
> I believe this should solve the problem Yongji Xie faced, and thus not
> require us to add support for "nowait" option with client sockets at
> all. The reconnect=3D1 option effectively already implements nowait
> semantics, and now plays nicely with tcp_chr_wait_connected.
>=20
> In investigating this I found various other bugs that needed fixing and=

> identified some useful refactoring to simplify / clarify the code, henc=
e
> this very long series.

Even with this series applied, I'm still seeing sporadic failures of
iotest 169. Max posted a hack patch a while back that tries to work
around the race:

https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg05907.html

which he originally diagnosed in iotest 147:
https://lists.nongnu.org/archive/html/qemu-devel/2018-12/msg05579.html

but as it was a hack, he has not pursued it further, and so the symptoms
are still there, although not completely reproducible:

169 10s ... - output mismatch (see 169.out.bad)
--- /home/eblake/qemu/tests/qemu-iotests/169.out	2018-11-16
15:48:12.018526748 -0600
+++ /home/eblake/qemu/tests/qemu-iotests/169.out.bad	2019-04-22
09:38:45.481517132 -0500
@@ -1,3 +1,5 @@
+WARNING:qemu:qemu received signal 11:
/home/eblake/qemu/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86=
_64
-chardev
socket,id=3Dmon,path=3D/home/eblake/qemu/tests/qemu-iotests/scratch/tmp4c=
lmPF/qemua-26803-monitor.sock
-mon chardev=3Dmon,mode=3Dcontrol -display none -vga none -qtest
unix:path=3D/home/eblake/qemu/tests/qemu-iotests/scratch/qemua-26803-qtes=
t.sock
-machine accel=3Dqtest -nodefaults -machine accel=3Dqtest -drive
if=3Dvirtio,id=3Ddrive0,file=3D/home/eblake/qemu/tests/qemu-iotests/scrat=
ch/disk_a,format=3Dqcow2,cache=3Dwriteback

Any chance you can take a look as to what a non-hack fix should be?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--z3hgxBtKre85to5bdVEyc7HYKiSm0hBKs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAly91OUACgkQp6FrSiUn
Q2ollAf+Lov4gqZFQztOSUfKIEQWVZ2ZLrzueZdfeeIgqNolFFTNnxN0tmFeMb+y
OncB8GJ10B4U1DBJsoHWg1cwwtea9g55ZNerFgvPpBJ6uKXVRnO/S5UG2Gtp/2dw
LSzrnStdJ0Antl/+kaMMUN9p5Mz17h27mGZNvFcYithI1fjj/JX9y632+w+Ssaf1
4QBdPEIaNqn5YnEh7W0OmAcMkwW09PgH8L08iHkxR+BxtoXGS/0+Q4jr1SBebkf3
gk22ChgGSksUeRsxemTO/n97P/ONg1aIOPCNreZXK6mO0KDU9nxyljNiOykOYo32
82nu2a8zSARKmrC2hVsaUmOma488sw==
=9QLn
-----END PGP SIGNATURE-----

--z3hgxBtKre85to5bdVEyc7HYKiSm0hBKs--

