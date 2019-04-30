Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47538C04AA6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 21:11:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0758921743
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 21:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0758921743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53572 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLa2H-0000ro-9A
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 17:11:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLa12-0008QY-H9
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:10:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLa11-0005pF-EW
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:10:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hLa11-0005nV-4B; Tue, 30 Apr 2019 17:10:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6F05431676B6;
	Tue, 30 Apr 2019 21:10:13 +0000 (UTC)
Received: from [10.3.116.15] (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D05F7191A;
	Tue, 30 Apr 2019 21:10:08 +0000 (UTC)
To: Alistair Francis <alistair23@gmail.com>, Laurent Vivier <laurent@vivier.eu>
References: <cover.1556650594.git.alistair.francis@wdc.com>
	<6bfa446eb7c351b5d867eb4158198231af724b11.1556650594.git.alistair.francis@wdc.com>
	<d4dd0758-64af-e249-1f1b-b52af014b404@vivier.eu>
	<CAKmqyKNx2r93-ASC0dAZJvu_36dV69sRj92-m6G9zXqLdc2sag@mail.gmail.com>
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
Message-ID: <5f6212e0-6bc4-8e84-c522-e80d36c67257@redhat.com>
Date: Tue, 30 Apr 2019 16:10:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAKmqyKNx2r93-ASC0dAZJvu_36dV69sRj92-m6G9zXqLdc2sag@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2eQGYAMbxZNLq163vRzK1kPqdTbMJ7rpK"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Tue, 30 Apr 2019 21:10:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v1 5/5] linux-user/elfload: Fix GCC 9 build
 warnings
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
	"riku.voipio@iki.fi" <riku.voipio@iki.fi>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"kraxel@redhat.com" <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430211007.wkUDL6nduA-OX_B7wIk2sCuXwzzYkL-RoRJnjwYKcQQ@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2eQGYAMbxZNLq163vRzK1kPqdTbMJ7rpK
From: Eric Blake <eblake@redhat.com>
To: Alistair Francis <alistair23@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>
Message-ID: <5f6212e0-6bc4-8e84-c522-e80d36c67257@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 5/5] linux-user/elfload: Fix GCC 9 build
 warnings
References: <cover.1556650594.git.alistair.francis@wdc.com>
 <6bfa446eb7c351b5d867eb4158198231af724b11.1556650594.git.alistair.francis@wdc.com>
 <d4dd0758-64af-e249-1f1b-b52af014b404@vivier.eu>
 <CAKmqyKNx2r93-ASC0dAZJvu_36dV69sRj92-m6G9zXqLdc2sag@mail.gmail.com>
In-Reply-To: <CAKmqyKNx2r93-ASC0dAZJvu_36dV69sRj92-m6G9zXqLdc2sag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/30/19 4:01 PM, Alistair Francis wrote:
> On Tue, Apr 30, 2019 at 1:36 PM Laurent Vivier <laurent@vivier.eu> wrot=
e:
>>
>> Le 30/04/2019 =C3=A0 22:09, Alistair Francis a =C3=A9crit :
>>> Fix this warning when building with GCC9 on Fedora 30:
>>> In function =E2=80=98strncpy=E2=80=99,
>>>     inlined from =E2=80=98fill_psinfo=E2=80=99 at /home/alistair/qemu=
/linux-user/elfload.c:3208:12,
>>>     inlined from =E2=80=98fill_note_info=E2=80=99 at /home/alistair/q=
emu/linux-user/elfload.c:3390:5,
>>>     inlined from =E2=80=98elf_core_dump=E2=80=99 at /home/alistair/qe=
mu/linux-user/elfload.c:3539:9:
>>> /usr/include/bits/string_fortified.h:106:10: error: =E2=80=98__builti=
n_strncpy=E2=80=99 specified bound 16 equals destination size [-Werror=3D=
stringop-truncation]
>>>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos=
 (__dest));
>>>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~
>>>

>>        /*
>>         * Using strncpy here is fine: at max-length,
>>>       * this field is not NUL-terminated.
>>>       */>      (void) strncpy(psinfo->pr_fname, base_filename,
>>> -                   sizeof(psinfo->pr_fname));
>>> +                   sizeof(psinfo->pr_fname) - 1);
>>
>> Read the comment above :)
>=20
> GCC can't read the comment though. The only other option I can think
> of is using a pragma, which I avoided using unless I had to. Would you
> prefer a pragma here? Or do you have a better solution?

psinfo is struct target_elf_prpsinfo, which we declare.  Why not just
use the QEMU_NONSTRING attribute in the declaration, to tell the
compiler our exact intents (untested, but something like this):

diff --git i/linux-user/elfload.c w/linux-user/elfload.c
index c1a26021f8d..6ebb2eeb957 100644
--- i/linux-user/elfload.c
+++ w/linux-user/elfload.c
@@ -2872,7 +2872,7 @@ struct target_elf_prpsinfo {
     target_gid_t pr_gid;
     target_pid_t pr_pid, pr_ppid, pr_pgrp, pr_sid;
     /* Lots missing */
-    char    pr_fname[16];           /* filename of executable */
+    char    pr_fname[16] QEMU_NONSTRING;           /* filename of
executable */
     char    pr_psargs[ELF_PRARGSZ]; /* initial part of arg list */
 };




--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--2eQGYAMbxZNLq163vRzK1kPqdTbMJ7rpK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzIua8ACgkQp6FrSiUn
Q2r/7ggApsTIaRRUv/G9fQPGBvmMb04sQyyxt/bE2c5EnsLk4QDO2K370HgNGRaW
GOyh8EZVQomkSliU87N4VLvXCS423MAFArL2/faQNls5szGTNqaMfaEicHCR49yv
hcZxBgSf1wExbKE4sTeosLU89vRzd9kw2vweYv7raTjEoiOo7BWpvr5juLy8o8bg
jV2AKJYivvPIgOjSs5dCLVbQblDE4arwGqG/9Tqw9GxTlPbbXVewje9CUoskYdWi
4dZlaIhqkv+I9I2eFSiHbymW5eVIz8QCkxQa1okKWnd8KQR+MgiszQbmGa3/dzWb
hZS5oc9SUADUwg1TzZObMEjW9Tf/BQ==
=LPec
-----END PGP SIGNATURE-----

--2eQGYAMbxZNLq163vRzK1kPqdTbMJ7rpK--

