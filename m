Return-Path: <SRS0=HPkn=YN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C22CA9EAD
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 16:34:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBB0A2190F
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 16:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=startmail.com header.i=@startmail.com header.b="X/DAzTV/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB0A2190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=startmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMEAJ-0005KD-W7
	for qemu-devel@archiver.kernel.org; Sun, 20 Oct 2019 12:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33223)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hanetzer@startmail.com>) id 1iME8f-0003c4-PA
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 12:33:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hanetzer@startmail.com>) id 1iME8d-0000IR-Kv
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 12:33:05 -0400
Received: from mx-out2.startmail.com ([145.131.90.155]:57153)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <hanetzer@startmail.com>)
 id 1iME8b-0000Gc-Mk; Sun, 20 Oct 2019 12:33:01 -0400
Date: Sun, 20 Oct 2019 11:32:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
 s=2017-11; t=1571589179;
 bh=twZ2sgaTbPxrhRF3sPv3KybyhqyvC00bfkrnyFmiy5I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=X/DAzTV/+ew0ML7HAi2j5LoHgl1X2ih3NR8fBhVpTVZPrjMqOf9UlXKnXj7ZTOWXv
 lH+z87s7kPFOSCDxCPk2ft6/Opn4y4TvYz2XVugpXJz6DuqIINOVHc7ImWWb1S6iqX
 nGJBdz5myf73TtjzxzyQ7Jip0QgZUqvXjQ2HArrgHj6EEKuzQ99TySlPyiq4PVrTih
 tO5zGCzuEYDyVYI4H93kn+Hn73n2YhPfJMg/Mp8J0POuRVm7xXmwdS8vh+FV7PwfB1
 pmzbApNqun2e8E1pwWYjuz8+g4a0/0/krvU//yVGx8JapwnsDNr0vZViGMyq7DuLjM
 OQK22v86gZyFg==
From: "Marty E. Plummer" <hanetzer@startmail.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: qemu/powernv: coreboot support?
Message-ID: <20191020163254.sqgqnyqbjudyowyu@proprietary-killer>
References: <20191018172622.kz4smemh5cwesfit@proprietary-killer>
 <21ba3404-dcd3-fe06-7725-d58e249f9fd2@kaod.org>
 <20191019153108.gkupn3tnihspq7th@proprietary-killer>
 <1cbd1882-15c8-5471-cd65-1c84c2920ba8@kaod.org>
 <20191019160933.fizoc6tpu5jday4o@proprietary-killer>
 <20191020062842.GI1960@umbus.fritz.box>
 <0a7cbd9b-2c46-259d-4e0d-9084ee2875a3@kaod.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <0a7cbd9b-2c46-259d-4e0d-9084ee2875a3@kaod.org>
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 145.131.90.155
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
Cc: Joel Stanley <joel@jms.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Oct 20, 2019 at 08:51:47AM +0200, C=E9dric Le Goater wrote:
> On 20/10/2019 08:28, David Gibson wrote:
> > Ok.  Note that the qemu emulated machine doesn't model the hardware
> > right down to the level of hostboot.  That's wy we're just loading
> > skiboot and jumping straight into it usually.  I guess clg's stuff to
> > load pnor images gets us a little closer to the hardware behaviour,
> > but I think it's still only a rough approximation.
>=20
Yeah, but its useful enough to see that my rough understanding of ppc64
assembly is more/less correct (using the hostboot/skiboot sources as a
reference [both are elfv1] to write coreboot [I'm using elfv2] is a bit
fun)
> It's really tied to the OpenPOWER firmwares using the HIOMAP protocol
> to discuss with the BMC and load the flash. We could loosen how QEMU=20
> interprets the MTD device and use a property to inform QEMU that this
> is an OpenPOWER  PNOR file and that skiboot and can be loaded from it.
> Something to discuss.
>=20
Yeah, it would be useful to be able to use a non-pnor mtd device but
still get the hiomap behavior, because that's what I'll be dealing with
on real hardware.
>=20
> I have applied this small hack to load larger -bios files :
> =20
> --- qemu-powernv-4.2.git.orig/hw/ppc/pnv.c
> +++ qemu-powernv-4.2.git/hw/ppc/pnv.c
> @@ -58,7 +58,7 @@
> =20
>  #define FW_FILE_NAME            "skiboot.lid"
>  #define FW_LOAD_ADDR            0x0
> -#define FW_MAX_SIZE             (4 * MiB)
> +#define FW_MAX_SIZE             (64 * MiB)
> =20
Yeah, I did a similar hack after I realized I only did this hack to
version 4.1.0 and not the powernv-4.2 git version.
>  #define KERNEL_LOAD_ADDR        0x20000000
>  #define KERNEL_MAX_SIZE         (256 * MiB)
>=20
> and coreboot.rom loads and boots and loops.
>=20
>=20
> You can use -d exec,in_asm to check what's going on.
>=20
Ended up using -s -S and gdb'ing it. It loops because of endian issues
in the coreboot fmap implmentation. That needs to be fixed upstream.
>=20
> C.

