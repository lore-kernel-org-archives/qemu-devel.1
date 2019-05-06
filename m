Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E14C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:58:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C41ED20675
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41ED20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60252 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNhsO-0004gL-Pf
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 13:58:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hNhfr-00031D-Dz
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:45:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hNhfq-0000vK-5V
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:45:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hNhfi-0000qX-D9; Mon, 06 May 2019 13:45:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 63A44308FEE2;
	Mon,  6 May 2019 17:45:00 +0000 (UTC)
Received: from [10.3.116.15] (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 840295DD73;
	Mon,  6 May 2019 17:44:57 +0000 (UTC)
To: Thomas Huth <thuth@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>
References: <68cc5bbc-ed6f-e001-e376-ccd986683b88@redhat.com>
	<f1dfe2c3-2d61-e477-ac3d-37ad26d9236d@redhat.com>
	<61685a48-b84e-c379-7193-f456e82635ba@redhat.com>
	<67a38513-89af-7f54-2fc8-05b5777983ca@redhat.com>
	<22933e94-18da-257c-7931-da511bc5a602@redhat.com>
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
Message-ID: <20f1aecc-02b4-781c-9ada-7ac6c73892a3@redhat.com>
Date: Mon, 6 May 2019 12:44:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <22933e94-18da-257c-7931-da511bc5a602@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lZ5Wsrrj33chhS6tgk1nFZrKXcPhidcxL"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Mon, 06 May 2019 17:45:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] Failing QEMU iotest 175
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
	Nir Soffer <nirsof@gmail.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lZ5Wsrrj33chhS6tgk1nFZrKXcPhidcxL
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Nir Soffer <nirsof@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20f1aecc-02b4-781c-9ada-7ac6c73892a3@redhat.com>
Subject: Re: Failing QEMU iotest 175
References: <68cc5bbc-ed6f-e001-e376-ccd986683b88@redhat.com>
 <f1dfe2c3-2d61-e477-ac3d-37ad26d9236d@redhat.com>
 <61685a48-b84e-c379-7193-f456e82635ba@redhat.com>
 <67a38513-89af-7f54-2fc8-05b5777983ca@redhat.com>
 <22933e94-18da-257c-7931-da511bc5a602@redhat.com>
In-Reply-To: <22933e94-18da-257c-7931-da511bc5a602@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/4/19 1:51 AM, Thomas Huth wrote:

>> Hmm, it's passing for me on ext4, but that probably means we have
>> different configuration parameters. I'm not sure how to easily show wh=
at
>> parameters a particular ext4 partition uses to compare the differences=

>> between your setup and mine (mine is tuned to whatever defaults Fedora=
's
>> installer chose on my behalf), so maybe someone else can chime in.
>=20
> $ sudo tune2fs -l /dev/mapper/Home
> tune2fs 1.42.9 (28-Dec-2013)
> Filesystem volume name:   <none>
> Last mounted on:          /home
> Filesystem magic number:  0xEF53
> Filesystem revision #:    1 (dynamic)
> Filesystem features:      has_journal ext_attr dir_index filetype
> needs_recovery meta_bg extent 64bit flex_bg sparse_super large_file
> huge_file uninit_bg dir_nlink extra_isize
> Filesystem flags:         signed_directory_hash
> Default mount options:    user_xattr acl
> Filesystem state:         clean
> Errors behavior:          Continue
> Filesystem OS type:       Linux
> Inode count:              36700160
> Block count:              146800640
> Reserved block count:     5873663
> Free blocks:              56266267
> Free inodes:              35403275
> First block:              1
> Block size:               1024
> Fragment size:            1024
> Group descriptor size:    64
> Blocks per group:         8192
> Fragments per group:      8192
> Inodes per group:         2048
> Inode blocks per group:   256
> First meta block group:   258
> Flex block group size:    16
> Filesystem created:       Thu Apr 19 18:34:33 2018
> Last mount time:          Sat May  4 08:20:36 2019
> Last write time:          Sat May  4 08:20:36 2019
> Mount count:              224
> Maximum mount count:      -1
> Last checked:             Thu Apr 19 18:34:33 2018
> Check interval:           0 (<none>)
> Lifetime writes:          1826 GB
> Reserved blocks uid:      0 (user root)
> Reserved blocks gid:      0 (group root)
> First inode:              11
> Inode size:	          128
> Journal inode:            8
> First orphan inode:       11076944
> Default directory hash:   half_md4
> Directory Hash Seed:      08e1be04-c3a3-4c37-a059-cf54af5c4bc0
> Journal backup:           inode blocks
>=20

# tune2fs -l /dev/mapper/fedora-home
tune2fs 1.44.6 (5-Mar-2019)
Filesystem volume name:   home
Last mounted on:          /home
Filesystem UUID:          3ef45c0b-b2a0-43da-a1d3-c4f726097eda
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr resize_inode dir_index
filetype needs_recovery extent 64bit flex_bg sparse_super large_file
huge_file dir_nlink extra_isize metadata_csum
Filesystem flags:         signed_directory_hash
Default mount options:    user_xattr acl
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              13107200
Block count:              52428800
Reserved block count:     2621440
Free blocks:              27184765
Free inodes:              12049129
First block:              0
Block size:               4096
Fragment size:            4096
Group descriptor size:    64
Reserved GDT blocks:      1024
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         8192
Inode blocks per group:   512
Flex block group size:    16
Filesystem created:       Thu Dec  6 16:17:23 2018
Last mount time:          Wed Apr  3 10:19:05 2019
Last write time:          Wed Apr  3 10:19:05 2019
Mount count:              12
Maximum mount count:      -1
Last checked:             Thu Dec  6 16:17:23 2018
Check interval:           0 (<none>)
Lifetime writes:          1962 GB
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:	          256
Required extra isize:     32
Desired extra isize:      32
Journal inode:            8
First orphan inode:       5248434
Default directory hash:   half_md4
Directory Hash Seed:      d1bbea0e-dd2e-4df7-b7f0-f7300c524cc9
Journal backup:           inode blocks
Checksum type:            crc32c
Checksum:                 0x3a8a8676

I'm definitely seeing some differences in the two configs (such as your
block size of 1k vs. mine at 4k), but not sure which are the most
important, nor how to easily recreate a setup that matches yours.

> IIRC I talked to stefanha on IRC about this some weeks ago already, and=

> he was able to reproduce the problem when using a certain parameter to
> create the file system. However, I fail to remember which parameter it
> was. Maybe Stefan still remembers...
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--lZ5Wsrrj33chhS6tgk1nFZrKXcPhidcxL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzQcpgACgkQp6FrSiUn
Q2p+oAgAlI5y6CkTkR7DrR90JnMwZMONk/keKOuo/+rwGXvEPs80dYbi+HAmxGet
9fSQ7SvD++7I30wc8WCRWOJYVnIdjaS7P9qfmbmL7ei0D8nAljG0F5d9UqnJndQ9
e4WiAsDH0peiimQ0ltjwKoOqO6nL9mZVetVuO8TuyAHg5A9kjHVJ6cgt+T70raqD
8gQ8opIkHzxxlk7JdqFqDKfIeZx+HrhfMZLFo/y0skQYefO62XDyyMTePM6FkzFN
wic194EtENwiYJDuYRexbtKlFYVrsMJZ41BW07YS395PUNmxl9mavFeoAa9g2Ej/
UMdNvAiiEdW3uqlrsm1nTfvZ4EPaPg==
=vj90
-----END PGP SIGNATURE-----

--lZ5Wsrrj33chhS6tgk1nFZrKXcPhidcxL--

