Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97E0C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 01:36:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82C6521D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 01:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="fNy6yF46"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C6521D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihkjl-0004rg-Jj
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 20:36:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52085)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ihkiw-0003xO-Nk
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 20:35:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ihkiu-0001Ul-Cl
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 20:35:30 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:59041 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ihkip-0001M6-Gv; Wed, 18 Dec 2019 20:35:24 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47dZFD1wccz9sP3; Thu, 19 Dec 2019 12:35:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576719312;
 bh=yBVFp5h4djotC6XSWt5jHHe55Jux5li9vAYC0lGcPu4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fNy6yF46TDCBc1mhEMqdMR/iOry6ORQyMjSRzKQg/rak9xka4bMd/7vCxOJNUsEFO
 avTS+ELRFzGy0I2101lFXmrlKjtIol3rn1gMn2p7MQqRKMX8wVKOPb0WKR48IkvRiL
 Fi63cd9fdzTYVR6QohFGq+z2i6Iph80og2Nj5ZtI=
Date: Thu, 19 Dec 2019 12:35:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v3 ppc-for-5.0 2/2] ppc/spapr: Support reboot of secure
 pseries guest
Message-ID: <20191219013505.GB2321@umbus.fritz.box>
References: <20191218043208.28613-1-bharata@linux.ibm.com>
 <20191218043208.28613-3-bharata@linux.ibm.com>
 <20191218142249.6bcf5ab4@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Content-Disposition: inline
In-Reply-To: <20191218142249.6bcf5ab4@bahia.lan>
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
Cc: paulus@ozlabs.org, qemu-ppc@nongnu.org, linuxram@us.ibm.com,
 qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2019 at 02:22:49PM +0100, Greg Kurz wrote:
> On Wed, 18 Dec 2019 10:02:08 +0530
> Bharata B Rao <bharata@linux.ibm.com> wrote:
>=20
> > A pseries guest can be run as a secure guest on Ultravisor-enabled
> > POWER platforms. When such a secure guest is reset, we need to
> > release/reset a few resources both on ultravisor and hypervisor side.
> > This is achieved by invoking this new ioctl KVM_PPC_SVM_OFF from the
> > machine reset path.
> >=20
> > As part of this ioctl, the secure guest is essentially transitioned
> > back to normal mode so that it can reboot like a regular guest and
> > become secure again.
> >=20
> > This ioctl has no effect when invoked for a normal guest. If this ioctl
> > fails for a secure guest, the guest is terminated.
> >=20
> > Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
> > ---
> >  hw/ppc/spapr.c       |  1 +
> >  target/ppc/kvm.c     | 15 +++++++++++++++
> >  target/ppc/kvm_ppc.h |  6 ++++++
> >  3 files changed, 22 insertions(+)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index f11422fc41..e62c89b3dd 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1597,6 +1597,7 @@ static void spapr_machine_reset(MachineState *mac=
hine)
> >      void *fdt;
> >      int rc;
> > =20
> > +    kvmppc_svm_off(&error_fatal);
> >      spapr_caps_apply(spapr);
> > =20
> >      first_ppc_cpu =3D POWERPC_CPU(first_cpu);
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index 7406d18945..ae920ec310 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -2900,3 +2900,18 @@ void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, i=
nt64_t tb_offset)
> >          kvm_set_one_reg(cs, KVM_REG_PPC_TB_OFFSET, &tb_offset);
> >      }
> >  }
> > +
> > +/*
> > + * Don't set error if KVM_PPC_SVM_OFF ioctl is invoked on kernels
> > + * that don't support this ioctl.
> > + */
> > +void kvmppc_svm_off(Error **errp)
> > +{
> > +    int rc;
> > +    KVMState *s =3D KVM_STATE(current_machine->accelerator);
> > +
> > +    rc =3D kvm_vm_ioctl(s, KVM_PPC_SVM_OFF);
> > +    if (rc && rc !=3D -ENOTTY) {
> > +        error_setg(errp, "KVM_PPC_SVM_OFF ioctl failed");
>=20
> It could have made sense to use error_setg_errno(errp, -rc, ...) here
> but never mind.

Please update for this.  Otherwise we get no indication of what the
kernel level error was in the qemu error.

>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> > +    }
> > +}
> > diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> > index 47b08a4030..9a9bca1b72 100644
> > --- a/target/ppc/kvm_ppc.h
> > +++ b/target/ppc/kvm_ppc.h
> > @@ -37,6 +37,7 @@ int kvmppc_booke_watchdog_enable(PowerPCCPU *cpu);
> >  target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
> >                                       bool radix, bool gtse,
> >                                       uint64_t proc_tbl);
> > +void kvmppc_svm_off(Error **errp);
> >  #ifndef CONFIG_USER_ONLY
> >  bool kvmppc_spapr_use_multitce(void);
> >  int kvmppc_spapr_enable_inkernel_multitce(void);
> > @@ -201,6 +202,11 @@ static inline target_ulong kvmppc_configure_v3_mmu=
(PowerPCCPU *cpu,
> >      return 0;
> >  }
> > =20
> > +static inline void kvmppc_svm_off(Error **errp)
> > +{
> > +    return;
> > +}
> > +
> >  static inline void kvmppc_set_reg_ppc_online(PowerPCCPU *cpu,
> >                                               unsigned int online)
> >  {
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3608kACgkQbDjKyiDZ
s5LU2Q//bNHq16dIsp6R/LQqA7ibOkzaUbzg9yeHeb4Qys0zoKLe/dhJhpOf7u/P
0GKcw46v2KmKWY9ZE+Oyeg2H1GHrkUl/8l6+ZVodqjzeywutDJBKXSMHikkgakPg
rSM8pS7UgNVOBPVPYc4+nuE/TnWbhXaNjWQ8+M+awUvrtXGVC48n5f9jdmS7O1LT
rY1CNp0RuRrs1z8wahIrjdp81xUvxD/T9jBMDEL8Im2ah/LGyyvTa/vculTP2IjX
svrsNwqvdsfQZoqPoQCNAAUc5aKnmYgPxnbvweepOA7171dyhLRKiWfmDWzsCyK8
5mWVhvGKVTolUu4tsf7FG7YR37lXINPvXS09Qcm9qlqmdHvnfYDABwtR6PSaYMRV
fny02dIbRZJRZmDmuRf4YruLTlMxniF+AzNuMatKBJPMFD3fmgyTCz03KkjjV2rL
VoQr21Qksh59bN2QkBLZrLkfrup8VBrOChCQA8KpBWtC7rMd3WcabtEmbOTfN2yF
YN59OdfSR9Vv3HKtkdyRmv46tkyiIpt332dEFq3wrCqig8Z6v6lzx9pwkAaEv+xS
5nScdJc58Ya7pzLzMIqcM74uUPI0CYBi+K2q2a/MJwNCmBdxPejmnYWglmwWWOtX
h66vyw3ww2cQBFupk2LR/NwiKErP+qeZMbfEJVKEWM22213VB7g=
=8hSS
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--

