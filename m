Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BEFC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 02:39:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BDBF20C09
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 02:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="U+EWG1Eb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BDBF20C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kF73i-00013w-Gu
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 22:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kF731-0000Yg-H2; Sun, 06 Sep 2020 22:38:23 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:51969)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kF72y-0003mG-7a; Sun, 06 Sep 2020 22:38:22 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BlCBT6VJWz9sTR; Mon,  7 Sep 2020 12:38:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599446289;
 bh=cA2/UB0t6rSIszXDdFDknMATd5phSVWhQz3GGCrw5Wg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=U+EWG1EbinmSPEZu0cXu0jkj8yBDJwemX4iBqvntUbA+Va/dpxU2b3IPY+ODNhpwh
 cW9lE8nKYmi1mhLFOfxC4gLabUT1QCVogdgtQp0ivJwzcPOmZtfo2ax9b3DxpG3cbQ
 ThdfgL3LHWYa87YQfVpvb6Ws0vP5ZENXz0d0328Q=
Date: Mon, 7 Sep 2020 12:38:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/30] ppc-for-5.2 queue 20200904
Message-ID: <20200907023800.GJ341806@yekko.fritz.box>
References: <20200904034719.673626-1-david@gibson.dropbear.id.au>
 <CAFEAcA8xCpRBcsCaozEXnCuM5SqWr5ZEDrwLjs+8va=316_70Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="huG+SbfbdD6eblZQ"
Content-Disposition: inline
In-Reply-To: <CAFEAcA8xCpRBcsCaozEXnCuM5SqWr5ZEDrwLjs+8va=316_70Q@mail.gmail.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--huG+SbfbdD6eblZQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 06, 2020 at 04:20:10PM +0100, Peter Maydell wrote:
> On Fri, 4 Sep 2020 at 04:47, David Gibson <david@gibson.dropbear.id.au> w=
rote:
> >
> > The following changes since commit 67a7bfe560a1bba59efab085cb3430f45176=
d382:
> >
> >   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2=
020-09-03' into staging (2020-09-03 16:58:25 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/dgibson/qemu.git tags/ppc-for-5.2-20200904
> >
> > for you to fetch changes up to b172606ecf29a140073f7787251a9d70ecb53b6e:
> >
> >   spapr_numa: move NVLink2 associativity handling to spapr_numa.c (2020=
-09-04 13:40:09 +1000)
> >
> > ----------------------------------------------------------------
> > ppc patch queue 2020-09-04
> >
> > Next pull request for qemu-5.2.  The biggest thing here is the
> > generalization of ARM's start-powered-off machine property to all
> > targets.  This can fix a number of odd little edge cases where KVM
> > could run vcpus before they were properly initialized.  This does
> > include changes to a number of files that aren't normally in my
> > purview.  There are suitable Acked-by lines and Peter requested this
> > come in via my tree, since the most pressing requirement for it is in
> > pseries machines with the POWER secure virtual machine facility.
> >
> > In addition we have:
> >  * The start of Daniel Barboza's rework and clean up of pseries
> >    machine NUMA handling
> >  * Correction to behaviour of the nvdimm=3D generic machine property on
> >    pseries
> >  * An optimization to the allocation of XIVE interrupts on KVM
> >  * Some fixes for confused behaviour with kernel_irqchip when both
> >    XICS and XIVE are in play
> >  * Add HIOMAP comamnd to pnv flash
> >  * Properly advertise the fact that spapr_vscsi doesn't handle
> >    hotplugged disks
> >  * Some assorted minor enhancements
>=20
> Hi -- this fails to build for Windows:
>=20
> ../../hw/ppc/spapr_numa.c: In function 'spapr_numa_fixup_cpu_dt':
> ../../hw/ppc/spapr_numa.c:77:5: error: unknown type name 'uint'
>      uint vcpu_assoc_size =3D NUMA_ASSOC_SIZE + 1;
>      ^

Huh, that's weird.  My testing run was less thorough than I'd usually
do, because so many tests were broken on the master branch, but I was
pretty sure I did do successful mingw builds.

> That should probably be using one of the standard C types.

Done.

> The 'check-tcg' tests for the linux-user static build also
> failed on an s390x test:
>=20
>   CHECK   debian-s390x-cross
>   BUILD   s390x-linux-user guest-tests with docker qemu/debian-s390x-cross
>   RUN     tests for s390x
>   TEST    threadcount on s390x
> Unhandled trap: 0x10003
> PSW=3Dmask 0000000180000000 addr 00000000010004f0 cc 00
> R00=3D0000000000000000 R01=3D0000000000000000 R02=3D0000000000000000
> R03=3D0000000000000000
> R04=3D0000000000000000 R05=3D0000000000000000 R06=3D0000000000000000
> R07=3D0000000000000000
> R08=3D0000000000000000 R09=3D0000000000000000 R10=3D0000000000000000
> R11=3D0000000000000000
> R12=3D0000000000000000 R13=3D0000000000000000 R14=3D0000000000000000
> R15=3D00000040008006c0
>=20
> ../Makefile.target:153: recipe for target 'run-threadcount' failed
> make[2]: *** [run-threadcount] Error 1

Bother.  I did see that failure on Travis, but assumed it was a false
positive because there were so many failures on master there.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--huG+SbfbdD6eblZQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9VnQYACgkQbDjKyiDZ
s5JPRg//VpQ+ak6B0AgVNXakq/HGiYrN+1sZ8lOBE5/ZDiTKtkRblB//wM6Fnk0u
YEncfxeDlYDDYNtGugvE4/Td7s7atTDoHmFVgkhrjC5U3AgRDG2IEHULd3zyAfiP
+RjuKM6up7iwm2hFevDhptku7WA7JuRQEqWrobidSFY+3c7CggSb4vHczrOC7YDA
o09KQT4eBRxTWVlnh2FKejcDqMpEJ3FS2In4V6b7eWjdxC4TCW5AZOT3RTUFY3k0
98NuGtf6FxBbVT8XVd4EvjSA2xVjJN2DHptdqzMEZ9KjTRqGllIyO7YkuTZutoJ7
81APvUXBbhZqYjZFBgASjJ/6dAZcOteF5rJCOa9DzestVAECpDdrMj/aw28x7h9G
qY6B4bqjYIEN8n+B19NFE9YINRJcMwpxBSt0FMKMSoBfKwys/B5QXRJwFyjATtjJ
zIGyWhGQ9ROrCnSBKS3rgQk89j9OEzkqYYETD9FqVzxBXRP1BMzkjUbF93zebecd
3UDjhU7ZuJbhrv0wbc8+1/vikqDEBDfGD/sNFTVkJtGmgxWP7EdnlPMOQmgjf729
rtsgRT4ED0TrVBCUpgdmgK8bzvd8QkJkDnbVeA3mNlB6Tx4E1iOBh95peT2BcjyF
o0/2nlhJi6zzchvkTENH+rVHrgyslcnpr0fOKXHP1eIOkhLNdUA=
=3Z87
-----END PGP SIGNATURE-----

--huG+SbfbdD6eblZQ--

