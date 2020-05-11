Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E30C54E8D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:31:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD61F20722
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD61F20722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY4n0-0004YW-26
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 05:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jY4mM-0003wq-T6
 for qemu-devel@nongnu.org; Mon, 11 May 2020 05:31:18 -0400
Received: from 2.mo179.mail-out.ovh.net ([178.33.250.45]:33884)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jY4mK-0006EM-I5
 for qemu-devel@nongnu.org; Mon, 11 May 2020 05:31:18 -0400
Received: from player693.ha.ovh.net (unknown [10.110.208.168])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 97082166BCB
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 11:31:06 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player693.ha.ovh.net (Postfix) with ESMTPSA id B90C01230BAC5;
 Mon, 11 May 2020 09:31:00 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R001d16a22ee-f50d-4a18-8670-8736e47e739d,66ED7F9E79076F4C3FC548A5F07D03F9BB6B1AD6)
 smtp.auth=groug@kaod.org
Date: Mon, 11 May 2020 11:30:58 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 6/6] target/ppc: Don't update radix PTE R/C bits with
 gdbstub
Message-ID: <20200511113058.6032a285@bahia.lan>
In-Reply-To: <20200511014348.GN2183@umbus.fritz.box>
References: <158887239173.1564424.16721638327458334129.stgit@bahia.lan>
 <158887243487.1564424.7276382177976503972.stgit@bahia.lan>
 <20200511014348.GN2183@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/D7gaC8mo8/i5bcbI7zHa0S5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 1970887789519018470
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrledtgdduudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgesghdtreerredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgefgkeduvddutdfgkeekjeelgeejffehudeuhfeltdetfedthffftdfggeeihfdvnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheileefrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=178.33.250.45; envelope-from=groug@kaod.org;
 helo=2.mo179.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 05:31:06
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/D7gaC8mo8/i5bcbI7zHa0S5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 11 May 2020 11:43:48 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, May 07, 2020 at 07:27:15PM +0200, Greg Kurz wrote:
> > gdbstub shouldn't silently change guest visible state when doing address
> > translation. While here drop a not very useful comment.
> >=20
> > This was found while reading the code. I could verify that this affects
> > both powernv and pseries, but I failed to observe any actual bug.
> >=20
> > Fixes: d04ea940c597 "target/ppc: Add support for Radix partition-scoped=
 translation"
> > Signed-off-by: Greg Kurz <groug@kaod.org>
>=20
> It's a real fix.  But AFAICT we'll always have cause_excp =3D=3D
> cause_rc_update, and I can't see any reason we'd ever them different.

This is definitely true as of today because all memory accesses are
performed by a CPU, but POWER9 has accelerator agents (eg. NPU) that
can also issue load/store operations on the PowerBus.

I'm currently doing some experiments to model the NPU as used with
OpenCAPI (the ultimate goal being to have another user for XIVE).
This requires to be able to do EA->RA translation without a CPU
context, as done by the NestMMU in real HW. This requires quite
some code refactoring in mmu-radix64.c and I opted to keep these
flags separate as a first step... but you're right, since page
faults are always handled on behalf of a CPU, I don't see any
reason for them to be different.

Cc'ing Nick in case I've missed something.

> So I'd prefer to just rename the flag and use it for both tests.
>=20
> Maybe just 'guest_visible' ?
>=20

Sounds good.

> > ---
> >  target/ppc/mmu-radix64.c |   36 ++++++++++++++++++++++++------------
> >  1 file changed, 24 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> > index ceeb3dfe2d49..bc51cd89a079 100644
> > --- a/target/ppc/mmu-radix64.c
> > +++ b/target/ppc/mmu-radix64.c
> > @@ -270,7 +270,8 @@ static int ppc_radix64_partition_scoped_xlate(Power=
PCCPU *cpu, int rwx,
> >                                                ppc_v3_pate_t pate,
> >                                                hwaddr *h_raddr, int *h_=
prot,
> >                                                int *h_page_size, bool p=
de_addr,
> > -                                              bool cause_excp)
> > +                                              bool cause_excp,
> > +                                              bool cause_rc_update)
> >  {
> >      int fault_cause =3D 0;
> >      hwaddr pte_addr;
> > @@ -291,8 +292,9 @@ static int ppc_radix64_partition_scoped_xlate(Power=
PCCPU *cpu, int rwx,
> >          return 1;
> >      }
> > =20
> > -    /* Update Reference and Change Bits */
> > -    ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, h_prot);
> > +    if (cause_rc_update) {
> > +        ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, h_prot);
> > +    }
> > =20
> >      return 0;
> >  }
> > @@ -301,7 +303,8 @@ static int ppc_radix64_process_scoped_xlate(PowerPC=
CPU *cpu, int rwx,
> >                                              vaddr eaddr, uint64_t pid,
> >                                              ppc_v3_pate_t pate, hwaddr=
 *g_raddr,
> >                                              int *g_prot, int *g_page_s=
ize,
> > -                                            bool cause_excp)
> > +                                            bool cause_excp,
> > +                                            bool cause_rc_update)
> >  {
> >      CPUState *cs =3D CPU(cpu);
> >      CPUPPCState *env =3D &cpu->env;
> > @@ -336,7 +339,8 @@ static int ppc_radix64_process_scoped_xlate(PowerPC=
CPU *cpu, int rwx,
> >          ret =3D ppc_radix64_partition_scoped_xlate(cpu, 0, eaddr, prtb=
e_addr,
> >                                                   pate, &h_raddr, &h_pr=
ot,
> >                                                   &h_page_size, true,
> > -                                                 cause_excp);
> > +                                                 cause_excp,
> > +                                                 cause_rc_update);
> >          if (ret) {
> >              return ret;
> >          }
> > @@ -376,7 +380,8 @@ static int ppc_radix64_process_scoped_xlate(PowerPC=
CPU *cpu, int rwx,
> >              ret =3D ppc_radix64_partition_scoped_xlate(cpu, 0, eaddr, =
pte_addr,
> >                                                       pate, &h_raddr, &=
h_prot,
> >                                                       &h_page_size, tru=
e,
> > -                                                     cause_excp);
> > +                                                     cause_excp,
> > +                                                     cause_rc_update);
> >              if (ret) {
> >                  return ret;
> >              }
> > @@ -408,7 +413,9 @@ static int ppc_radix64_process_scoped_xlate(PowerPC=
CPU *cpu, int rwx,
> >          return 1;
> >      }
> > =20
> > -    ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, g_prot);
> > +    if (cause_rc_update) {
> > +        ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, g_prot);
> > +    }
> > =20
> >      return 0;
> >  }
> > @@ -433,7 +440,8 @@ static int ppc_radix64_process_scoped_xlate(PowerPC=
CPU *cpu, int rwx,
> >  static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx,
> >                               bool relocation,
> >                               hwaddr *raddr, int *psizep, int *protp,
> > -                             bool cause_excp)
> > +                             bool cause_excp,
> > +                             bool cause_rc_update)
> >  {
> >      CPUPPCState *env =3D &cpu->env;
> >      uint64_t lpid, pid;
> > @@ -483,7 +491,9 @@ static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr=
 eaddr, int rwx,
> >      if (relocation) {
> >          int ret =3D ppc_radix64_process_scoped_xlate(cpu, rwx, eaddr, =
pid,
> >                                                     pate, &g_raddr, &pr=
ot,
> > -                                                   &psize, cause_excp);
> > +                                                   &psize,
> > +                                                   cause_excp,
> > +                                                   cause_rc_update);
> >          if (ret) {
> >              return ret;
> >          }
> > @@ -506,7 +516,9 @@ static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr=
 eaddr, int rwx,
> > =20
> >              ret =3D ppc_radix64_partition_scoped_xlate(cpu, rwx, eaddr=
, g_raddr,
> >                                                       pate, raddr, &pro=
t, &psize,
> > -                                                     0, cause_excp);
> > +                                                     0,
> > +                                                     cause_excp,
> > +                                                     cause_rc_update);
> >              if (ret) {
> >                  return ret;
> >              }
> > @@ -562,7 +574,7 @@ int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, v=
addr eaddr, int rwx,
> > =20
> >      /* Translate eaddr to raddr (where raddr is addr qemu needs for ac=
cess) */
> >      if (ppc_radix64_xlate(cpu, eaddr, rwx, relocation, &raddr,
> > -                          &page_size, &prot, true)) {
> > +                          &page_size, &prot, true, true)) {
> >          return 1;
> >      }
> > =20
> > @@ -584,7 +596,7 @@ hwaddr ppc_radix64_get_phys_page_debug(PowerPCCPU *=
cpu, target_ulong eaddr)
> >      }
> > =20
> >      if (ppc_radix64_xlate(cpu, eaddr, 0, msr_dr, &raddr, &psize,
> > -                          &prot, false)) {
> > +                          &prot, false, false)) {
> >          return -1;
> >      }
> > =20
> >=20
>=20


--Sig_/D7gaC8mo8/i5bcbI7zHa0S5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl65G1MACgkQcdTV5YIv
c9bGmw/9Ey49IEJEBUQEup1zZUSJs2mGO6wd37Seq2s7v/AD7wvfrCFogfjFiMYs
nOjHzo6Lpie3dqQXaLKrkwHNFdENXgO8Xw1/q2tCRiQajy7SvviZRkurar5SZi70
Ay69qheqvW5H4Otdscs2YXQsym+l3DRKx7KFQngIqNE7KkJEY9e9kcSPkgX97/C8
NH1lzHojx9W40XIh+CRpYgCAIFzzTqB9fRenVdzymTwjI3/hetsWbkHHTGgXsfnq
Sriu4yCQzPsKP3VmK5ZJSveqmn3Fnd2B7zQZTV31CEiK0wU3hNtEdJzAclLUFRqN
TIOxyMhQTCLw5F5KlBjmb0YgH1dsAJyLze/mapmfa4P7dPuQtU3WgAdKXHzuVJgl
4f2juUDgWVpXKkooXXWSnOvxckeCve1rh9wA1a1sU7AMkRVSNbRfBDBmGXMouAol
/DtrvJlgCxM0PkqQg5gcRVpZ3/GFFJkvFX7No/IZvEElXGcZbA9SRzyghrxqra3P
a+JSxRHPPhT+dNJrYSd3rHg72t6CFomEV/WAbXKYaLoobCllGF8/R1+6yper6Pn9
0TlW+fh/U5XgjvOfdygnqVK7UEFaQmAVhg/rXUJmvkNm7mrWcU86Uwja/BQ1gYyl
mwUy1Z4+03T7Uznbo5EWlo+vBJuvRa4BD6GoTjcUy92qj2QmE2E=
=4fSG
-----END PGP SIGNATURE-----

--Sig_/D7gaC8mo8/i5bcbI7zHa0S5--

