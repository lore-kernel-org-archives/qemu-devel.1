Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F94C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 04:41:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7168722365
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 04:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="HqquU5j6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7168722365
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXHoJ-0005fB-Go
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 23:41:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59685)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iXHml-0004fg-JL
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 23:40:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iXHmj-0004n3-9s
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 23:40:11 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:37183)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iXHmf-0004ca-Jt; Tue, 19 Nov 2019 23:40:08 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47Hqjr0dG7z9sPc; Wed, 20 Nov 2019 15:39:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574224800;
 bh=x5t2+xcStYX8kS1dWXeJSZDbqhKSmP1vO0Pnz5dtZwc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HqquU5j6PlD/yH8YyTqsn6CfusRdBw7V4GQ7Gz8KgrY7ofl14F2q486XpQ1rghDpO
 H2/DLPectrIdvuheryXNZbaO7UAOgQX9WUJ3UpQMUGp0GXWgj3wJx8BOV2f66goeW3
 IG/u7E8S+JesQQ+Jh0dQJB/om83jUG8oF8J7yNKE=
Date: Wed, 20 Nov 2019 15:36:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] spapr: Fix VSMT mode when it is not supported by the
 kernel
Message-ID: <20191120043653.GG5582@umbus.fritz.box>
References: <20191108154035.12913-1-lvivier@redhat.com>
 <20191108174759.2d4040f1@bahia.lan>
 <20191119010012.GI5582@umbus.fritz.box>
 <caa35299-c928-a968-83b5-842d000f0242@redhat.com>
 <20191119164526.0e980a37@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4VcSvkf+hAuPXtVJ"
Content-Disposition: inline
In-Reply-To: <20191119164526.0e980a37@bahia.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-ppc@nongnu.org,
 clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--4VcSvkf+hAuPXtVJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2019 at 04:45:26PM +0100, Greg Kurz wrote:
> On Tue, 19 Nov 2019 15:06:51 +0100
> Laurent Vivier <lvivier@redhat.com> wrote:
>=20
> > On 19/11/2019 02:00, David Gibson wrote:
> > > On Fri, Nov 08, 2019 at 05:47:59PM +0100, Greg Kurz wrote:
> > >> On Fri,  8 Nov 2019 16:40:35 +0100
> > >> Laurent Vivier <lvivier@redhat.com> wrote:
> > >>
> > >>> Commit 29cb4187497d sets by default the VSMT to smp_threads,
> > >>> but older kernels (< 4.13) don't support that.
> > >>>
> > >>> We can reasonably restore previous behavior with this kernel
> > >>> to allow to run QEMU as before.
> > >>>
> > >>> If VSMT is not supported, VSMT will be set to MAX(8, smp_threads)
> > >>> as it is done for previous machine types (< pseries-4.2)
> > >>>
> > >>
> > >> It is usually _bad_ to base the machine behavior on host capabilitie=
s.
> > >> What happens if we migrate between an older kernel and a recent one ?
> > >=20
> > > Right.  We're really trying to remove instaces of such behaviour.  I'd
> > > prefer to completely revert Greg's original patch than to re-introduce
> > > host configuration dependency into the guest configuration..
> > >=20
> > >> I understand this is to fix tests/migration-test on older kernels.
> > >> Couldn't this be achieved with migration-test doing some introspecti=
on
> > >> and maybe pass vsmt=3D8 on the QEMU command line ?
> > >=20
> > > ..adjusting the test case like this might be a better idea, though.
> > >=20
> > > What's the test setup where we're using the old kernel?  I really only
> > > applied the original patch on the guess that we didn't really care
> > > about kernels that old.  The fact you've hit this in practice makes me
> > > doubt that assumption.
> > >=20
> >=20
> > The way to fix the tests is to add "-smp threads=3D8" on the command li=
ne
> > (for all tests, so basically in qtest_init_without_qmp_handshake(), and
> > it will impact all the machine types), and we have to check if it is
>=20
> Ohhh... it isn't possible to initialize Qtest with machine specific
> properties ? That's a bit unfortunate :-\

Uhh... I don't see why we can't.  Couldn't we just put either -machine
vsmt=3D8 or -smp 8 into the cmd_src / cmd_dst printfs() in the
strcmp(arch, "ppc64") case?

> > ppc64/pseries to do that, and there it becomes a little bit complicated
> > for a so small piece of code.
> >=20
> > So I think the best to do is to revert Greg's patch.
> >=20
>=20
> I'm okay with that since this patch doesn't bring much for the moment.
>=20
> But soon, ie. linux-5.5 hopefully, KVM will allow to configure the number
> of presenters in the XIVE and XICS-on-XIVE devices on POWER9. Combined
> with this patch, it will allow to drastically reduce the consumption of
> resources in the XIVE HW, which currently limits the number of VMs that
> can run concurrently with an in-kernel irqchip. So I hope the 'make check'
> you're willing to fix is worth it :-), and BTW you didn't answer David's
> question about the test setup.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4VcSvkf+hAuPXtVJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3UwuUACgkQbDjKyiDZ
s5LYuA/+P6OUp6gZkgDY+IfHqSgxwcx6Z/+d5geI47uQZsYTWZWZ4AkY9X/gQKKi
mUWZx0L3DYZHcfTWPsLPwIZhTw0Xes5Hef+6IQuPcLcRgCEHVMEIBT5mnS1zT7zl
n5MDRIo9HH4xVwd13Tq//TU3zBzJqNL4UoxMV4lfLyKsvTl+VbxqlWI38XqE72Xk
Dg8W5EefN/FzkiU4ARBeof4NSJvWgGxsLx/2UyV7TQPDccmpsCICezbYs28uEDix
7rE36nc3OxIwRLvuLszjd73cWK7k32+hJcYPC3bT7sZOnXeh5SbRVsIMRIlRSkAA
BlOH2nq6PNfn+afoxC5vFQVDPBZeCom06mBfcbEQDO2f3T4dbOHiXD9UTBM+LF0l
XtItC+V5gfp+FK+V4FpnVbxTuoR/4LnjCGFAi8vBpUHq6+8D73fCMlLNh81rj54Q
PB/247vfOL0IVB6f0bJBV3XGfSmy2CoVWT6x3qfsrQJgqizRw8hElsYZS1rdPoho
IYxEw4bjL7M8c7DNc+sFFcP1chOXzFSdE5J4mIwDRyTs3yVh22VpzaZSBwBCB6n5
VWuUoHJAc8XR6ZRCpEpOFjK+7LBf56NheDPo8QFRvvh7SJ40/WKMT33fNLT0ncid
WC5qF2p4gc0WHhA0MZR4pN7qX5K0NFTjghPpMnMdjy9ImPVVQRc=
=lfHV
-----END PGP SIGNATURE-----

--4VcSvkf+hAuPXtVJ--

