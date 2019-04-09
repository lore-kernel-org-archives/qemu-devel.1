Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5934C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 10:36:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46CA620818
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 10:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46CA620818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38798 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDo6q-0001MT-7f
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 06:36:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDo54-0008S3-By
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 06:34:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDo53-00006y-6o
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 06:34:18 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hDo52-0008WN-OY
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 06:34:17 -0400
Received: by mail-wm1-f67.google.com with SMTP id h18so2723755wml.1
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 03:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to;
	bh=LvTxYNsjSJolHHNshx5hunOoQnp10TS37tCAhX7mfzg=;
	b=mqk352RSp3PR4z7XZPr4B0b3aYPXMilGDiY3ghWDQwhdo1FyHL+6mja97rzdIlSjQy
	ZXhwl2rtO70e+b5M+rPG15X4oZQBsEGjh65S6xaeViNbtk28p9lTBPGlUudqUNGVQ91G
	247rZiWDRzkCep7vZwy/UTPAlDD9Wq23pCMK4XBPSQpaTqovlSRorzcXGl4N4Rz8CkzT
	9BlV1RALnxjNlx3dZ1qtVpKhDd+8lsCPbRwAFYWoEEJEgWsdB5TvF4GTIPynupm2++W8
	L3lon9rVEB1AQggkxO4KeJgVeQt/of9oaDLML0uOnQf0i9DbPtouhqHgwSdF2xpnxgC0
	1EVw==
X-Gm-Message-State: APjAAAXmF/2ed389m1Iic6cRnYNjRkv/ApGqn5g6lqNFaINmCaiYDKOG
	fFy2mDIKiBMPStXANb+Vw0BJPw==
X-Google-Smtp-Source: APXvYqzwwaRviPuINCiwmYJhoGBtGmWd4u/NmyoR+METAGSsweopuvIrdA+8W7N4hrDF1O2LAp72cw==
X-Received: by 2002:a05:600c:21d3:: with SMTP id
	x19mr21428517wmj.2.1554806054148; 
	Tue, 09 Apr 2019 03:34:14 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	t24sm18656680wmi.10.2019.04.09.03.34.12
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 03:34:13 -0700 (PDT)
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>, qemu-devel@nongnu.org
References: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6cf20899-f643-950b-37b9-dcc47df0d72e@redhat.com>
Date: Tue, 9 Apr 2019 12:34:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="efSY6aaqISsFx5nfisEO9E76Kh9g8Nyr6"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 00/10] block/pflash_cfi02: Implement
 missing AMD pflash functionality
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409103411.guri24AscEstnFvRDBUqXl_qjNDGKGJvBUAEFVuWZRQ@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--efSY6aaqISsFx5nfisEO9E76Kh9g8Nyr6
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Message-ID: <6cf20899-f643-950b-37b9-dcc47df0d72e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/10] block/pflash_cfi02: Implement missing
 AMD pflash functionality
References: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
In-Reply-To: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

[Cc'ing Markus and Laszlo, we have similar interest in pflash01 testing]

On 4/8/19 10:55 PM, Stephen Checkoway wrote:
> The goal of this patch series implement the following AMD command-set p=
arallel
> flash functionality:
> - flash interleaving;
> - nonuniform sector sizes;
> - erase suspend/resume commands; and
> - multi-sector erase.

I am very glad you addressed these long overdue issues and very pleased
by your patches :)
I'll thoroughly review it during next week (this won't get merge for the
current 4.0 cycle anyway).

I started a similar cleanup (mostly pflash01 focused) and converted
DPRINTF to trace events, added few constants. I'll see if I can rebase
your work on top of mine. So far only your patch 2 (refactor) would be
modified, simplified as the "pull out all of the code to modify the
status into simple helper functions" part (which else I'd ask you to
move in a separate patch).

We should think of more intereleaved tests, I'll prepare a table of
current QEMU models using this device and how is their intereleave
mapping. Hopefully it would be enough to simply add the existing
machines to your current musicpal qtest.

Also I'd like to see some Top/Bottom block configuration qtests, your
patch #5 doesn't seem tested.

> During refactoring and implementation, I discovered several bugs that a=
re
> fixed here as well:
> - flash commands use only 11-bits of the address in most cases, but the=

>   current code uses all of them [1];
> - entering CFI mode from autoselect mode and then exiting CFI mode shou=
ld
>   return the chip to autoselect mode, but the current code returns to r=
ead
>   array mode; and
> - reset command should be ignored during sector/chip erase, but the cur=
rent
>   code performs the reset.
>=20
> The first patch in the series adds a test for the existing behavior. Te=
sts for
> additional behavior/bug fixes are added in the relevant patch.
>=20
> 1. I found firmware in the wild that relies on the 11-bit address behav=
ior,
>    probably due to a bug in the firmware itself.

Is it a musicpal firmware? Are you able to compare with real hardware?

I vaguely remember some issue regarding address bus width when trying to
implement the TopBlock small sectors, but I wasn't using the musicpal.
I'll see if I can find my old notes and test with your series.

Regards,

Phil.

> Stephen Checkoway (10):
>   block/pflash_cfi02: Add test for supported commands
>   block/pflash_cfi02: Refactor, NFC intended
>   block/pflash_cfi02: Fix command address comparison
>   block/pflash_cfi02: Implement intereleaved flash devices
>   block/pflash_cfi02: Implement nonuniform sector sizes
>   block/pflash_cfi02: Fix CFI in autoselect mode
>   block/pflash_cfi02: Fix reset command not ignored during erase
>   block/pflash_cfi02: Implement multi-sector erase
>   block/pflash_cfi02: Implement erase suspend/resume
>   block/pflash_cfi02: Use the chip erase time specified in the CFI tabl=
e
>=20
>  hw/block/pflash_cfi02.c   | 843 +++++++++++++++++++++++++++-----------=

>  tests/Makefile.include    |   2 +
>  tests/pflash-cfi02-test.c | 757 ++++++++++++++++++++++++++++++++++
>  3 files changed, 1367 insertions(+), 235 deletions(-)
>  create mode 100644 tests/pflash-cfi02-test.c
>=20


--efSY6aaqISsFx5nfisEO9E76Kh9g8Nyr6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEicHnj2Ae6GyGdJXLoqP9bt6twN4FAlysdSMACgkQoqP9bt6t
wN75DxAAjACVm9G747DpLK3VeyG8iNQZA9LpKlsBOxA9EN7j/yVx6IBKuQ9O8j90
1PbYvxPIu1RRQip9zqW4r73CKCFmWRU2d8mqIy/38f1FWZ7LgoVlMHGp89GspsCL
to0ntYMlFZxwI5wdvZyjml9B21FNK9/Xcwg2/sthp9Lzuza3vQFG+KvlKL4WBvb2
v37+mKyHYm69/csYQpgUOQ0kvjnwH26yFZ6U9y8Zrnugzw0nX+T6WB0q/t3m51uF
K4Giqqv9LM835MPbPfxUzjzqMRGQYT05lwGUWze6RIcqqqzZx9nbVsBzT4qvhBOG
YhHDWC31ZwzrFrQkAcd/1LIdNzMJv7Ab9HgAI0UwgdwfP/+mPnk7wx+QC94HvwDb
+uQ9TdoThacGRS6CqjGzwFlykL/2dMYA5E5M9injZp64RLUK17D1RVun0CPXXDz4
H8Mb1JAOwD6+3hBQSrW4q1q5tpej9XA3Jbl9mPfYXGfHBa4LNYWQ1tKRzcytANUI
e/85lh5zwLvxuwmQLWfCRb6BuG+VmQPufDXKFI2cD6rY/W1cZ+5LxcCxQJ3XGuE1
6RDp3dilmnslsnRyOYG8i9TbB8GTsn70sdWNFAVYjmE8WSECo98cmR3GYrhdp8jX
VXoMZE3qnjiZiaNyi4sbecxl8xM0Q3sCygXmA3Bl4EveGS7K7NU=
=3uqe
-----END PGP SIGNATURE-----

--efSY6aaqISsFx5nfisEO9E76Kh9g8Nyr6--

