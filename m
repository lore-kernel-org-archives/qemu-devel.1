Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB51C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 02:03:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17F702075A
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 02:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hiCVAvgX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17F702075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXbos-0003HJ-7r
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 21:03:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iXbnw-0002I4-8z
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 21:02:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iXbnu-0007W9-Kw
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 21:02:44 -0500
Received: from ozlabs.org ([203.11.71.1]:54529)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iXbnt-0007V6-PA; Wed, 20 Nov 2019 21:02:42 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47JN9n6mwDz9sPV; Thu, 21 Nov 2019 13:02:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574301757;
 bh=NThrUQ5NfrxdG9xlirSWIL54OjtWMEr5hDEeDbEBJH4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hiCVAvgX9XheEjq8o8yKcO0iG8uZTINvg3RWUnlalMJk6HMLjB4OhLUmReTVNeJRV
 l1q5MPLwZLNGF6EzlRUhVokTAXi+lBComLbGT3us/Y2ZKbmZ4YedwHCxMDc2CloVMR
 LryhIKA70jWmB8qoA2UJMAIajr4bLnf3I4otU1lA=
Date: Thu, 21 Nov 2019 13:02:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH] spapr: Fix VSMT mode when it is not supported by the
 kernel
Message-ID: <20191121020212.GS5582@umbus.fritz.box>
References: <20191108154035.12913-1-lvivier@redhat.com>
 <20191108174759.2d4040f1@bahia.lan>
 <20191119010012.GI5582@umbus.fritz.box>
 <caa35299-c928-a968-83b5-842d000f0242@redhat.com>
 <20191119164526.0e980a37@bahia.lan>
 <20191120043653.GG5582@umbus.fritz.box>
 <cb8f7dc7-d6db-6bd9-e825-1ade7d89cdd9@redhat.com>
 <0c1f57ac-0823-4268-429b-d1aee8f7f8d5@redhat.com>
 <20191120114128.GN5582@umbus.fritz.box>
 <8bc97c7d-9773-b5e2-cd29-deab14e919ad@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="k1z90nur9s/yY9w9"
Content-Disposition: inline
In-Reply-To: <8bc97c7d-9773-b5e2-cd29-deab14e919ad@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-ppc@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--k1z90nur9s/yY9w9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2019 at 03:28:19PM +0100, Laurent Vivier wrote:
> On 20/11/2019 12:41, David Gibson wrote:
> > On Wed, Nov 20, 2019 at 12:28:19PM +0100, Laurent Vivier wrote:
> >> On 20/11/2019 10:00, Laurent Vivier wrote:
> >>> On 20/11/2019 05:36, David Gibson wrote:
> >>>> On Tue, Nov 19, 2019 at 04:45:26PM +0100, Greg Kurz wrote:
> >>>>> On Tue, 19 Nov 2019 15:06:51 +0100
> >>>>> Laurent Vivier <lvivier@redhat.com> wrote:
> >>>>>
> >>>>>> On 19/11/2019 02:00, David Gibson wrote:
> >>>>>>> On Fri, Nov 08, 2019 at 05:47:59PM +0100, Greg Kurz wrote:
> >>>>>>>> On Fri,  8 Nov 2019 16:40:35 +0100
> >>>>>>>> Laurent Vivier <lvivier@redhat.com> wrote:
> >>>>>>>>
> >>>>>>>>> Commit 29cb4187497d sets by default the VSMT to smp_threads,
> >>>>>>>>> but older kernels (< 4.13) don't support that.
> >>>>>>>>>
> >>>>>>>>> We can reasonably restore previous behavior with this kernel
> >>>>>>>>> to allow to run QEMU as before.
> >>>>>>>>>
> >>>>>>>>> If VSMT is not supported, VSMT will be set to MAX(8, smp_thread=
s)
> >>>>>>>>> as it is done for previous machine types (< pseries-4.2)
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> It is usually _bad_ to base the machine behavior on host capabil=
ities.
> >>>>>>>> What happens if we migrate between an older kernel and a recent =
one ?
> >>>>>>>
> >>>>>>> Right.  We're really trying to remove instaces of such behaviour.=
  I'd
> >>>>>>> prefer to completely revert Greg's original patch than to re-intr=
oduce
> >>>>>>> host configuration dependency into the guest configuration..
> >>>>>>>
> >>>>>>>> I understand this is to fix tests/migration-test on older kernel=
s.
> >>>>>>>> Couldn't this be achieved with migration-test doing some introsp=
ection
> >>>>>>>> and maybe pass vsmt=3D8 on the QEMU command line ?
> >>>>>>>
> >>>>>>> ..adjusting the test case like this might be a better idea, thoug=
h.
> >>>>>>>
> >>>>>>> What's the test setup where we're using the old kernel?  I really=
 only
> >>>>>>> applied the original patch on the guess that we didn't really care
> >>>>>>> about kernels that old.  The fact you've hit this in practice mak=
es me
> >>>>>>> doubt that assumption.
> >>>>>>>
> >>>>>>
> >>>>>> The way to fix the tests is to add "-smp threads=3D8" on the comma=
nd line
> >>>>>> (for all tests, so basically in qtest_init_without_qmp_handshake()=
, and
> >>>>>> it will impact all the machine types), and we have to check if it =
is
> >>>>>
> >>>>> Ohhh... it isn't possible to initialize Qtest with machine specific
> >>>>> properties ? That's a bit unfortunate :-\
> >>>>
> >>>> Uhh... I don't see why we can't.  Couldn't we just put either -machi=
ne
> >>>> vsmt=3D8 or -smp 8 into the cmd_src / cmd_dst printfs() in the
> >>>> strcmp(arch, "ppc64") case?
> >>>
> >>> Yes, but we need to do that to all other tests that fail. test-migrat=
ion
> >>> is not the only one impacted by the problem (we have also pxe-test), =
so
> >>> it's why I thought to fix the problem in a generic place.
> >>>
> >>> But it seems there are only this couple of tests that are impacted so=
 I
> >>> can modify both instead. I think only tests that really start CPU have
> >>> the problem.
> >>>
> >>> I'm going to send a patch to fix that.
> >>
> >> And again, it's a little bit more complicated than expected: setting
> >> vsmt to 8 works only with kvm_hv, but breaks in case of TCG or kvm_pr.
> >> So the test must check what is in use...
> >=20
> > Ugh, yeah, that's getting too ugly.  I think the feasible options are
> > either to revert the patch, or just say that upstream qemu no longer
> > supports a RHEL7 host.
>=20
> In I was mistakenly using "-smp threads=3D8", with "-M vsmt=3D8" it works
> with TCG and KVM PR (with a warning).

Ah, yes, that's not so bad.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--k1z90nur9s/yY9w9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3V8CEACgkQbDjKyiDZ
s5LPag//TlHQMwiQVM5dz9ggQjXJkOIbP1DwjduG3TCJZSvm4na/ctb5vPf0q5fK
pH913rshDkhOblzdVg5TWsPvvBi4+7YKWkaYkn0KgR1MbXxp0PfGq6Jz0/qEVmZh
Z7uBUmKB4kI26bXa2HioakfwNxD4zSv2iVuLApmqqNgto55OmWHh9HQEtYRd6f/F
560mf11wGCV03WW8MROp21YMv/S3xsGZsbMz2dTJ4ujDEGyAuSDyVntV22wwJVxz
U+DkMaFUTYEIF5mjhinR64xtcQITd+oqfTIVn0Cy7L71FYKrTkUoA5bvMPIa1XD6
QD3hMeEnuhr9/zRbOIzMLgWxEX31TfDH91tNRSaGACMXEKdc4u4bUueOml2pUnzi
hmLZ0zNP+3Gj8fz5dJaoywHmy8kKBG2mhgB3joOazZ2BpVP2PJ37iQRdQ7i7sg2U
By3eDXdyl47ZN3eJbuv/bIt2/WByUzbGu5fQdznPQ/ELcaQIZThcuD5vOAZzYQe2
yLXLCpusuO/gfcmtnSJF3UIhnwO4nyY43SRXPvxv6CgBWkvHw9P/aqjOG8V7PCpo
Auz41Dy6rQBX5e8Si+6SXBa6eIV89SwiAR2A2ejvzeO3APuR7aoPVRgo/LvwGxKs
tKbRlAgHT1NR/Ih5faIE4dt2HzHc7O5uOjVx0BAnVfNSSnYxhgk=
=NBco
-----END PGP SIGNATURE-----

--k1z90nur9s/yY9w9--

