Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC31DC76199
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 00:32:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA73F208C3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 00:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ElkHV9Zf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA73F208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3UL3-0002U3-01
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 19:32:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60876)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j3UKH-0001Ul-AV
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 19:31:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j3UKF-0006O8-U2
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 19:31:53 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:47481)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j3UKF-0006Iz-5j; Sun, 16 Feb 2020 19:31:51 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48LQ0K4Dskz9sRL; Mon, 17 Feb 2020 11:31:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1581899505;
 bh=tB2JHIu2jpNN32iWn7H792GeQ4Kx98zvSsrW5mBsIKw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ElkHV9ZfNIeGvIY3JY4bxFeOCtLmNAFbi6ojkMAhsLm897n/A2ubf+oLwAnHhDJAy
 I7FGNI3dmN5bcrnyDb05vv6JM9QBiVE+j0NKpM5RaibNJCIYXEYApCUmLD3hzLtcUW
 xyW7eCz9d+x+tyBTJCJGLpIHKxUdyCp79B+e211s=
Date: Mon, 17 Feb 2020 11:28:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Pan Nengyuan <pannengyuan@huawei.com>
Subject: Re: [PATCH] ppc: free 'fdt' after reset the machine
Message-ID: <20200217002833.GA14136@umbus.fritz.box>
References: <20200214033206.4395-1-pannengyuan@huawei.com>
 <20200214164816.137e1de7@bahia.lan>
 <fe4b442b-a854-6eae-95ab-2c3af0a2986a@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <fe4b442b-a854-6eae-95ab-2c3af0a2986a@huawei.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, clg@kaod.org,
 euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2020 at 09:30:56AM +0800, Pan Nengyuan wrote:
>=20
>=20
> On 2/14/2020 11:48 PM, Greg Kurz wrote:
> > On Fri, 14 Feb 2020 11:32:06 +0800
> > <pannengyuan@huawei.com> wrote:
> >=20
> >> From: Pan Nengyuan <pannengyuan@huawei.com>
> >>
> >> 'fdt' forgot to clean both e500 and pnv when we call 'system_reset' on=
 ppc,
> >> this patch fix it. The leak stacks are as follow:
> >>
> >> Direct leak of 4194304 byte(s) in 4 object(s) allocated from:
> >>     #0 0x7fafe37dd970 in __interceptor_calloc (/lib64/libasan.so.5+0xe=
f970)
> >>     #1 0x7fafe2e3149d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
> >>     #2 0x561876f7f80d in create_device_tree /mnt/sdb/qemu-new/qemu/dev=
ice_tree.c:40
> >>     #3 0x561876b7ac29 in ppce500_load_device_tree /mnt/sdb/qemu-new/qe=
mu/hw/ppc/e500.c:364
> >>     #4 0x561876b7f437 in ppce500_reset_device_tree /mnt/sdb/qemu-new/q=
emu/hw/ppc/e500.c:617
> >>     #5 0x56187718b1ae in qemu_devices_reset /mnt/sdb/qemu-new/qemu/hw/=
core/reset.c:69
> >>     #6 0x561876f6938d in qemu_system_reset /mnt/sdb/qemu-new/qemu/vl.c=
:1412
> >>     #7 0x561876f6a25b in main_loop_should_exit /mnt/sdb/qemu-new/qemu/=
vl.c:1645
> >>     #8 0x561876f6a398 in main_loop /mnt/sdb/qemu-new/qemu/vl.c:1679
> >>     #9 0x561876f7da8e in main /mnt/sdb/qemu-new/qemu/vl.c:4438
> >>     #10 0x7fafde16b812 in __libc_start_main ../csu/libc-start.c:308
> >>     #11 0x5618765c055d in _start (/mnt/sdb/qemu-new/qemu/build/ppc64-s=
oftmmu/qemu-system-ppc64+0x2b1555d)
> >>
> >> Direct leak of 1048576 byte(s) in 1 object(s) allocated from:
> >>     #0 0x7fc0a6f1b970 in __interceptor_calloc (/lib64/libasan.so.5+0xe=
f970)
> >>     #1 0x7fc0a656f49d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
> >>     #2 0x55eb05acd2ca in pnv_dt_create /mnt/sdb/qemu-new/qemu/hw/ppc/p=
nv.c:507
> >>     #3 0x55eb05ace5bf in pnv_reset /mnt/sdb/qemu-new/qemu/hw/ppc/pnv.c=
:578
> >>     #4 0x55eb05f2f395 in qemu_system_reset /mnt/sdb/qemu-new/qemu/vl.c=
:1410
> >>     #5 0x55eb05f43850 in main /mnt/sdb/qemu-new/qemu/vl.c:4403
> >>     #6 0x7fc0a18a9812 in __libc_start_main ../csu/libc-start.c:308
> >>     #7 0x55eb0558655d in _start (/mnt/sdb/qemu-new/qemu/build/ppc64-so=
ftmmu/qemu-system-ppc64+0x2b1555d)
> >>
> >> Reported-by: Euler Robot <pannengyuan@huawei.com>
> >=20
> > The recipient list and 'git log' seem to agree on the fact that 'Euler =
Robot'
> > has its own email address, that is not yours ;-)
> >=20
> > Reported-by: Euler Robot <euler.robot@huawei.com>
> >=20
> > I guess David can fix this when applying the patch. No need to repost
> > unless explicitly asked to do so.
>=20
> Yes, your guess is right. I'm sorry for my carelessness.

Corrected inline and merged, thanks.

Oddly, the original mail of this series didn't seem to appear in my
inbox, although the replies did, even though I see that you've CCed
me.

I hope that just means that it did appear and I accidentally deleted
it, not that something is wrong with my mail setup.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5J3i8ACgkQbDjKyiDZ
s5I02A/+NFSfn9U7aF88Y86Zwh4MzA2tOU6uPYNx0y6JRehN5SqjviJA1EVgPdIn
gqSsvNRwISjz8HRdYsdPUAvH+XLNPzaka+K0/Gt3J1b3MhSlibo0nHQG0xBpdwyJ
SroXIg/T5zcijOCRwMoK4C1nzfkIgvQ9Hs9DRpj3Dbr2cHcZrrnP7u0qeT0EWca+
G2TR8qmaPTSdKVzbtyh0IxxhUaUScUCw/FzEL0qZw7OqjIHuMElqWk8910iN/Z38
PvRL2RkgNYcgzpQPS6ZYMoxDp5fxYmGQSY4sJLMOYbJvKeDTzZWnjqsH2tVbTxz0
gj5QimhCkKIBXF8UV2VzQKPGeshqlG5b/Sjl4gbmr+9fFfEMteDQDXfAChzC20Q8
6YE+K01tZW/Sn+BJjJSfW6BtVgIabipcX/Bng0OZHu2retUERp3RmqbUkoOPl33S
kSpvgF/6zlCu++YatraDl8ig7g8R5wR54CjLc1cF/jisvAc371ASIPoKrwqZzYAH
F5sOqz8c9YRKIUwjc2Hikayiv0BTTMuElP+tU23Uum+y/KhKBMMt9MY5GFdT418P
k14r8Ovl2PIl0fbmBsewE49poFDG1kumxUBJvKK/26gV9HF77GK752+sOQcTnSZj
Mzakeryr0Ytip1Meg8OLUJH8aKg/qRIWK8yjGRZM6/tUGYdlAaw=
=Hk4t
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--

