Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484EDC5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 05:49:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A0F1208E4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 05:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="T5JamDfC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A0F1208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhpCA-0002PC-6f
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 01:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37356)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hhpAg-0000e4-Ee
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 01:48:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hhpAe-0005q0-Vq
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 01:48:10 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:33321 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hhpAe-0005oA-Av; Mon, 01 Jul 2019 01:48:08 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45cbxs0HmHz9s4Y; Mon,  1 Jul 2019 15:48:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1561960081;
 bh=vb2ASapvK2L2M4YhLizryolwqb73LHVMNEGTx7o4AYQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=T5JamDfCA/rjStavC19h0AMfKz9NW/Plz8Qj8rtMnBP0622Vju661OmhwCvpXUsUo
 kPYW79/iTI1FkxdchJsopRDvw3XgtoInadeJm7GiNk5YaUqrAmPvAWEJeUn41iqWCl
 s99AuygBFUBejX67q//Cp4tBuha3xqOAZLnfcH2Y=
Date: Mon, 1 Jul 2019 15:04:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190701050426.GI2138@umbus.fritz.box>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
 <20190310082703.1245-58-david@gibson.dropbear.id.au>
 <20190312150115.6zuaid43gr7hklt5@unused>
 <58de43c6-31d5-a0a3-b443-54a33f11d75a@kaod.org>
 <20190312191409.vxnpscrephtk6otv@dhcp-17-165.bos.redhat.com>
 <1746025955.7399905.1552419034356.JavaMail.zimbra@redhat.com>
 <154364d7-fe5b-4f40-b976-b85ff9060ee0@kaod.org>
 <dc6578eb-569b-477e-9a74-2925de8ac204@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="N8NGGaQn1mzfvaPg"
Content-Disposition: inline
In-Reply-To: <dc6578eb-569b-477e-9a74-2925de8ac204@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PULL 57/60] target/ppc: add HV support for POWER9
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
Cc: lvivier@redhat.com, peter maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--N8NGGaQn1mzfvaPg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2019 at 03:20:32PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Hi,
>=20
> On 3/12/19 8:58 PM, C=E9dric Le Goater wrote:
> > On 3/12/19 8:30 PM, Cleber Rosa wrote:
> >>> From: "Cleber Rosa" <crosa@redhat.com>
> >>> Sent: Tuesday, March 12, 2019 3:14:09 PM
> >>> Subject: Re: [Qemu-devel] [PULL 57/60] target/ppc: add HV support for=
 POWER9
> >>>
> >>> On Tue, Mar 12, 2019 at 07:34:04PM +0100, C=E9dric Le Goater wrote:
> >>>> On 3/12/19 4:01 PM, Cleber Rosa wrote:
> >>>>> On Sun, Mar 10, 2019 at 07:27:00PM +1100, David Gibson wrote:
> >>>>>> From: C=E9dric Le Goater <clg@kaod.org>
> >>>>>>
> >>>>>> We now have enough support to boot a PowerNV machine with a POWER9
> >>>>>> processor. Allow HV mode on POWER9.
> >>>>>>
> >>>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>>>>> Message-Id: <20190307223548.20516-16-clg@kaod.org>
> >>>>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> >>>>>> ---
> >>>>>>  target/ppc/translate_init.inc.c | 3 ++-
> >>>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/target/ppc/translate_init.inc.c
> >>>>>> b/target/ppc/translate_init.inc.c
> >>>>>> index af70a3b78c..0bd555eb19 100644
> >>>>>> --- a/target/ppc/translate_init.inc.c
> >>>>>> +++ b/target/ppc/translate_init.inc.c
> >>>>>> @@ -8895,7 +8895,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void
> >>>>>> *data)
> >>>>>>                         PPC_CACHE | PPC_CACHE_ICBI | PPC_CACHE_DCB=
Z |
> >>>>>>                         PPC_MEM_SYNC | PPC_MEM_EIEIO |
> >>>>>>                         PPC_MEM_TLBSYNC |
> >>>>>> -                       PPC_64B | PPC_64BX | PPC_ALTIVEC |
> >>>>>> +                       PPC_64B | PPC_64H | PPC_64BX | PPC_ALTIVEC=
 |
> >>>>>>                         PPC_SEGMENT_64B | PPC_SLBI |
> >>>>>>                         PPC_POPCNTB | PPC_POPCNTWD |
> >>>>>>                         PPC_CILDST;
> >>>>>> @@ -8907,6 +8907,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void
> >>>>>> *data)
> >>>>>>                          PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_=
S64 |
> >>>>>>                          PPC2_TM | PPC2_ISA300 | PPC2_PRCNTL;
> >>>>>>      pcc->msr_mask =3D (1ull << MSR_SF) |
> >>>>>> +                    (1ull << MSR_SHV) |
> >>>>>>                      (1ull << MSR_TM) |
> >>>>>>                      (1ull << MSR_VR) |
> >>>>>>                      (1ull << MSR_VSX) |
> >>>>>>
> >>>>>>
> >>>>>
> >>>>> This change prevents a Fedora 29 kernel[1] from booting... is this
> >>>>> intended or a known limitation of the Fedora 29 kernel?
> >>>>
> >>>> The default CPU is still power8_v2.0. This is curious.
> >>>>
> >>>
> >>> Are you sure?  I'm getting:
> >>>
> >>>  $ git rev-parse HEAD
> >>>  cfc3fef6b4e493bf1a7ee16790ad584e20dfbbd1
> >>>  $ ./ppc64-softmmu/qemu-system-ppc64 -qmp unix:/tmp/qmp-sock,server
> >>>  $ ./scripts/qmp/qom-get -s /tmp/qmp-sock /machine/unattached/device[=
0].type
> >>>  power9_v2.0-spapr-cpu-core
> >=20
> > That's a pseries machine, not a powernv machine. pseries should use P9
> > processor by default but the patch above should not impact f29 on pseri=
es.=20
> > If it does, then we have a bug.=20
> > =20
> >> Looks like the overall default is "power9_v2.0", and then on pseries-3=
=2E1 and
> >> lower, it's "power8_v2.0", as per 34a6b015a98.
> >=20
> > I was looking at pnv_machine_class_init() which sets the default CPU :
> >=20
> >     mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
>=20
> I found this thread while trying auto-bisection for LP#1834613:
> https://bugs.launchpad.net/bugs/1834613
>=20
> When trying the options suggested by Laurent here:
> https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg06209.html
>=20
> this one hangs:
>=20
> $ qemu-system-ppc64 \
>  -kernel vmlinuz-vanilla \
>  -nographic -append "console=3Dhvc0" \
>  -M cap-cfpc=3Dbroken,cap-sbbc=3Dbroken,cap-ibs=3Dbroken
>=20
> but this one works:
>=20
> $ qemu-system-ppc64 \
>  -kernel vmlinuz-vanilla \
>  -nographic -append "console=3Dhvc0" \
>  -M pseries-3.1

Sorry, I missed most of this thread while on holidays.  What's the
actual bug here?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--N8NGGaQn1mzfvaPg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0ZlFgACgkQbDjKyiDZ
s5Ji4BAApAZklg8fMl+IUDNRttizMXtwM5LNoLuYGPVoEvgVOV/4YAGaV82A4GVt
sl/GCcyuTtetBhruuO+a8srtN5gkALRQzs1Yd31G44lUh8UBiedhOLOG9saEpgP3
qHmGUMWD9B7tKZhtQ/QrwAqfelRar4SNpYTpCJVu8h6ZOavEfCBm8Jc84n2oVIrb
6zo/Oh9Wj3bS9zP2HmhwC9fcqQVdjS70hdU36BKB2eFa3AxC3Fm1sCZzK/xs0xt7
xPhLXRGH2gsJXoo2WJ8BhLP74jQFUuCKjmhmFbicdQFE1UiHV3kWCNQjCjTg8VA3
4oLwZQIWj4O7pJShMkemQxHsgXrrNe9rKNDM/UDIqSSTjAltHCFoScbBl4/rhpu/
2wZ/ePWUedMFHZ7xiftDeJAATRLPIUWIYkCF6nMtUcmx6MD26R0E7pMvOa6IhSAV
KwyH7KxFsZosZilFltUxPphymtRVgpE21/hBR0pBrJJ5z2XcD23bRjioby0170wk
N/2foYmVIjCRVDfa5TLbUIscmsuh98rnA+yJdTfxTKgj77Pf9PEhDcwW0Y3Kfniu
6Ekc/SOfa4tXSVarr/6gz535Fe5yZx+WugwRN957U6+yoKYW4wR2qY+Bcaw8YbnC
GrVfevn1jLAWtj4fnIlntdjBdFyoTbyPYiTZMHW0Eccic0hL+KQ=
=Ax6k
-----END PGP SIGNATURE-----

--N8NGGaQn1mzfvaPg--

