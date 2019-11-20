Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B795C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 04:41:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A47922365
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 04:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="kkrCXshv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A47922365
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXHoI-0005fP-Cr
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 23:41:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59683)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iXHml-0004fe-MF
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 23:40:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iXHmj-0004n4-9r
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 23:40:11 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:59421 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iXHmf-0004cd-Rw; Tue, 19 Nov 2019 23:40:07 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47Hqjr1ZD9z9sPZ; Wed, 20 Nov 2019 15:40:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574224800;
 bh=2etGAGp4gLajhKL75NyqqEA2KgRXjGwWEXP7Zq5gGtE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kkrCXshv7vSB+Xa3UO9op3/ccMaI53CPKs+0WHYG2jq/mya8vpdoWukeVnczMBNnT
 XsjKU+A1g4+jwKSVrBPbQ1/fpfOsOGoY09bOBddojxotuRWpmeHDt3OvsVI2LrAOPR
 O+pazf239On1Df/joBTJLDCBLcDnNNld0mIZizJc=
Date: Wed, 20 Nov 2019 15:39:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>
Subject: Re: [PATCH] spapr: Fix VSMT mode when it is not supported by the
 kernel
Message-ID: <20191120043949.GH5582@umbus.fritz.box>
References: <20191108154035.12913-1-lvivier@redhat.com>
 <20191108174759.2d4040f1@bahia.lan>
 <20191119010012.GI5582@umbus.fritz.box>
 <caa35299-c928-a968-83b5-842d000f0242@redhat.com>
 <20191119164526.0e980a37@bahia.lan>
 <a9974c2c-eea9-4f53-fa4b-4c4ab64a788b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UkokfXldvRlmz8/+"
Content-Disposition: inline
In-Reply-To: <a9974c2c-eea9-4f53-fa4b-4c4ab64a788b@redhat.com>
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
Cc: Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-ppc@nongnu.org,
 clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--UkokfXldvRlmz8/+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2019 at 05:13:29PM +0100, Luk=C3=A1=C5=A1 Doktor wrote:
> Dne 19. 11. 19 v 16:45 Greg Kurz napsal(a):
> > On Tue, 19 Nov 2019 15:06:51 +0100
> > Laurent Vivier <lvivier@redhat.com> wrote:
> >=20
> >> On 19/11/2019 02:00, David Gibson wrote:
> >>> On Fri, Nov 08, 2019 at 05:47:59PM +0100, Greg Kurz wrote:
> >>>> On Fri,  8 Nov 2019 16:40:35 +0100
> >>>> Laurent Vivier <lvivier@redhat.com> wrote:
> >>>>
> >>>>> Commit 29cb4187497d sets by default the VSMT to smp_threads,
> >>>>> but older kernels (< 4.13) don't support that.
> >>>>>
> >>>>> We can reasonably restore previous behavior with this kernel
> >>>>> to allow to run QEMU as before.
> >>>>>
> >>>>> If VSMT is not supported, VSMT will be set to MAX(8, smp_threads)
> >>>>> as it is done for previous machine types (< pseries-4.2)
> >>>>>
> >>>>
> >>>> It is usually _bad_ to base the machine behavior on host capabilitie=
s.
> >>>> What happens if we migrate between an older kernel and a recent one ?
> >>>
> >>> Right.  We're really trying to remove instaces of such behaviour.  I'd
> >>> prefer to completely revert Greg's original patch than to re-introduce
> >>> host configuration dependency into the guest configuration..
> >>>
> >>>> I understand this is to fix tests/migration-test on older kernels.
> >>>> Couldn't this be achieved with migration-test doing some introspecti=
on
> >>>> and maybe pass vsmt=3D8 on the QEMU command line ?
> >>>
> >>> ..adjusting the test case like this might be a better idea, though.
> >>>
> >>> What's the test setup where we're using the old kernel?  I really only
> >>> applied the original patch on the guess that we didn't really care
> >>> about kernels that old.  The fact you've hit this in practice makes me
> >>> doubt that assumption.
> >>>
> >>
> >> The way to fix the tests is to add "-smp threads=3D8" on the command l=
ine
> >> (for all tests, so basically in qtest_init_without_qmp_handshake(), and
> >> it will impact all the machine types), and we have to check if it is
> >=20
> > Ohhh... it isn't possible to initialize Qtest with machine specific
> > properties ? That's a bit unfortunate :-\
> >=20
> >> ppc64/pseries to do that, and there it becomes a little bit complicated
> >> for a so small piece of code.
> >>
> >> So I think the best to do is to revert Greg's patch.
> >>
> >=20
> > I'm okay with that since this patch doesn't bring much for the moment.
> >=20
> > But soon, ie. linux-5.5 hopefully, KVM will allow to configure the numb=
er
> > of presenters in the XIVE and XICS-on-XIVE devices on POWER9. Combined
> > with this patch, it will allow to drastically reduce the consumption of
> > resources in the XIVE HW, which currently limits the number of VMs that
> > can run concurrently with an in-kernel irqchip. So I hope the 'make che=
ck'
> > you're willing to fix is worth it :-), and BTW you didn't answer David's
> > question about the test setup.
> >=20
>=20
> Hello Greg, guys,
>=20
> it is P8 machine using RHEL7 host with a stock kernel-3.10.0-XXXX. If you=
're interested in the whole setup, then:
>=20
>     ./configure --enable-kvm --block-drv-rw-whitelist=3Dvmdk,null-aio,quo=
rum,null-co,blkverify,file,nbd,raw,blkdebug,host_device,qed,nbd,iscsi,glust=
er,rbd,qcow2,throttle,copy-on-read
>     make -j 13
>     SPEED=3Dslow make check

Really the only relevant factor here is that it's a RHEL7 host, which
has an old kernel (3.10 is misleading, since it has a *heap* of
backports, but support for the vsmt feature isn't one of them).

So more generally than this specific test, the question really is
whether we thinkg RHEL7 is still in wide enough use that we care to
keep supporting it with the latest upstream machine type.  I'm a bit
undecided on that.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--UkokfXldvRlmz8/+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3Uw5UACgkQbDjKyiDZ
s5LrSQ//eKjenjic5vN837M7Vug5XRtHkF/B8bTucQ5qOdcc9OLh/bem6ECczG74
5tpxJChp6dmmORbOiUePT6yx71ChNQozn7pJ/TbOK19OOt/sPB1vjhztjn6TL/ZB
hCp0B1NEzKSFpUGaRPV7bKplVn9Xa6qJdriP+TAMc+08yPOTA4T/l5SOOoB8tCw1
+THFYwvd5r989oJXD0A/mAK8cRMLAY3+ZU7WXdufTTRaARIIoCQmdlfQaYfY5c5+
KzDeoS9FK/NtCxWUjEN4VuXLY9vlLcikrRQEsAXVhyqes90EKgNt0cfN7+3H2F/A
WzH78EAoJq9R0q5X0MNS+5StttaBdlQCXrFvaPDlHRIz5K5uVgS4FXdxqgvVzxSh
/16BJVQhhWRxm6HLgpSdnwhu3eetECAeGMIkVURBZXpBIzrHH+VSyMeN+UfOvK9g
f3gEnPbrFXXB8VVua/T+YsjhTg/j1Mw4Q3JWPeOwJ7KcPXL80mh2INblM80ZV+FH
OdmrZ7kqzNUjSlouHHzrnjNzne99ygdVOkI6AhKkchtUpMEHM7crpJWARVyXq9tr
ACHd4WzK3DQjau7E6b+OBdlzn56NHjVpq26GfG7ZPMYhNBJT4f90oGo/XPTdY9j7
qBN26lYn/zcs4HWrDtNjfrp9KMIq8gcbJAvXgUlgj+V6EYiFvF0=
=A9HG
-----END PGP SIGNATURE-----

--UkokfXldvRlmz8/+--

