Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5B5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 09:01:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95CAB20721
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 09:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95CAB20721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbh53-0004Un-Pk
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 05:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jbh4C-0003t5-C5
 for qemu-devel@nongnu.org; Thu, 21 May 2020 05:00:40 -0400
Received: from 15.mo7.mail-out.ovh.net ([87.98.180.21]:55710)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jbh4B-0003Vi-40
 for qemu-devel@nongnu.org; Thu, 21 May 2020 05:00:40 -0400
Received: from player787.ha.ovh.net (unknown [10.108.35.131])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 740FC164923
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 11:00:36 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player787.ha.ovh.net (Postfix) with ESMTPSA id A423012C34754;
 Thu, 21 May 2020 09:00:30 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R005141d6106-8fdc-4305-98e6-12780102a973,0C88E457D5774F601C3A42E7BE1517355FE6C707)
 smtp.auth=groug@kaod.org
Date: Thu, 21 May 2020 11:00:28 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2 2/2] spapr: Add a new level of NUMA for GPUs
Message-ID: <20200521110028.79a26fa0@bahia.lan>
In-Reply-To: <20200521051345.GG63349@umbus.fritz.box>
References: <20200518214418.18248-1-arbab@linux.ibm.com>
 <20200518214418.18248-2-arbab@linux.ibm.com>
 <20200521013616.15664254@bahia.lan>
 <20200521051345.GG63349@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/r_YE01EgHFRe=0Du91BjSgg";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 4842495500045883878
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudduuddguddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtsehgtderreertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeeggfekuddvuddtgfekkeejleegjeffheduuefhledtteeftdfhffdtgfegiefhvdenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeekjedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=87.98.180.21; envelope-from=groug@kaod.org;
 helo=15.mo7.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 05:00:36
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: Reza Arbab <arbab@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb@linux.ibm.com>,
 Leonardo Augusto Guimaraes Garcia <lagarcia@linux.ibm.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/r_YE01EgHFRe=0Du91BjSgg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 21 May 2020 15:13:45 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, May 21, 2020 at 01:36:16AM +0200, Greg Kurz wrote:
> > On Mon, 18 May 2020 16:44:18 -0500
> > Reza Arbab <arbab@linux.ibm.com> wrote:
> >=20
> > > NUMA nodes corresponding to GPU memory currently have the same
> > > affinity/distance as normal memory nodes. Add a third NUMA associativ=
ity
> > > reference point enabling us to give GPU nodes more distance.
> > >=20
> > > This is guest visible information, which shouldn't change under a
> > > running guest across migration between different qemu versions, so ma=
ke
> > > the change effective only in new (pseries > 5.0) machine types.
> > >=20
> > > Before, `numactl -H` output in a guest with 4 GPUs (nodes 2-5):
> > >=20
> > > node distances:
> > > node   0   1   2   3   4   5
> > >   0:  10  40  40  40  40  40
> > >   1:  40  10  40  40  40  40
> > >   2:  40  40  10  40  40  40
> > >   3:  40  40  40  10  40  40
> > >   4:  40  40  40  40  10  40
> > >   5:  40  40  40  40  40  10
> > >=20
> > > After:
> > >=20
> > > node distances:
> > > node   0   1   2   3   4   5
> > >   0:  10  40  80  80  80  80
> > >   1:  40  10  80  80  80  80
> > >   2:  80  80  10  80  80  80
> > >   3:  80  80  80  10  80  80
> > >   4:  80  80  80  80  10  80
> > >   5:  80  80  80  80  80  10
> > >=20
> > > These are the same distances as on the host, mirroring the change made
> > > to host firmware in skiboot commit f845a648b8cb ("numa/associativity:
> > > Add a new level of NUMA for GPU's").
> > >=20
> > > Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
> > > ---
> > >  hw/ppc/spapr.c             | 11 +++++++++--
> > >  hw/ppc/spapr_pci_nvlink2.c |  2 +-
> > >  2 files changed, 10 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 88b4a1f17716..1d9193d5ee49 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -893,7 +893,11 @@ static void spapr_dt_rtas(SpaprMachineState *spa=
pr, void *fdt)
> > >      int rtas;
> > >      GString *hypertas =3D g_string_sized_new(256);
> > >      GString *qemu_hypertas =3D g_string_sized_new(256);
> > > -    uint32_t refpoints[] =3D { cpu_to_be32(0x4), cpu_to_be32(0x4) };
> > > +    uint32_t refpoints[] =3D {
> > > +        cpu_to_be32(0x4),
> > > +        cpu_to_be32(0x4),
> > > +        cpu_to_be32(0x2),
> > > +    };
> > >      uint32_t nr_refpoints;
> > >      uint64_t max_device_addr =3D MACHINE(spapr)->device_memory->base=
 +
> > >          memory_region_size(&MACHINE(spapr)->device_memory->mr);
> > > @@ -4544,7 +4548,7 @@ static void spapr_machine_class_init(ObjectClas=
s *oc, void *data)
> > >      smc->linux_pci_probe =3D true;
> > >      smc->smp_threads_vsmt =3D true;
> > >      smc->nr_xirqs =3D SPAPR_NR_XIRQS;
> > > -    smc->nr_assoc_refpoints =3D 2;
> > > +    smc->nr_assoc_refpoints =3D 3;
> > >      xfc->match_nvt =3D spapr_match_nvt;
> > >  }
> > > =20
> > > @@ -4611,8 +4615,11 @@ DEFINE_SPAPR_MACHINE(5_1, "5.1", true);
> > >   */
> > >  static void spapr_machine_5_0_class_options(MachineClass *mc)
> > >  {
> > > +    SpaprMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> > > +
> > >      spapr_machine_5_1_class_options(mc);
> > >      compat_props_add(mc->compat_props, hw_compat_5_0, hw_compat_5_0_=
len);
> > > +    smc->nr_assoc_refpoints =3D 2;
> > >  }
> > > =20
> > >  DEFINE_SPAPR_MACHINE(5_0, "5.0", false);
> > > diff --git a/hw/ppc/spapr_pci_nvlink2.c b/hw/ppc/spapr_pci_nvlink2.c
> > > index 8332d5694e46..247fd48731e2 100644
> > > --- a/hw/ppc/spapr_pci_nvlink2.c
> > > +++ b/hw/ppc/spapr_pci_nvlink2.c
> > > @@ -362,7 +362,7 @@ void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbStat=
e *sphb, void *fdt)
> > >          uint32_t associativity[] =3D {
> > >              cpu_to_be32(0x4),
> > >              SPAPR_GPU_NUMA_ID,
> > > -            SPAPR_GPU_NUMA_ID,
> > > +            cpu_to_be32(nvslot->numa_id),
> >=20
> > This is a guest visible change. It should theoretically be controlled
> > with a compat property of the PHB (look for "static GlobalProperty" in
> > spapr.c). But since this code is only used for GPU passthrough and we
> > don't support migration of such devices, I guess it's okay. Maybe just
> > mention it in the changelog.
>=20
> Yeah, we might get away with it, but it should be too hard to get this

I guess you mean "it shouldn't be too hard" ?

> right, so let's do it.
>=20
> >=20
> > >              SPAPR_GPU_NUMA_ID,
> > >              cpu_to_be32(nvslot->numa_id)
> > >          };
> >=20
>=20


--Sig_/r_YE01EgHFRe=0Du91BjSgg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl7GQywACgkQcdTV5YIv
c9Y/Yg/+JpXxEqYx9BiU8Yo/CcQH2emi1C0D3OXDApol5Oo1oae7wrYeWAvcDBTA
ed7VttykGG6xGPmjwYNwCEVYNc7hEm4IFtbkOulkWJLi24G6U/Myo994fe1b3Iks
c+ZZ0aEnpIvUxS0T4psYOTvn+hRCtEkHGE7a1oaJoADUKdLTI4FfHC6cUgiClE1T
GLEz7HtUz3mDelTuhUbNx126NNWO1bdb+NA2jeDkgP2GK8lfUvf8uhN0v1bcDd8I
3B5KuJ9bBkiRvOZ3IOzLHlpowUsRSQqQHbXt1YZLHCV8UfJrSLHouKprR0qGqAHy
EJvKwdkLFEBqLyBRGWd19lMLfXMNJpdqAJXrXYgJ0NcGZ/dwbLwd1NHFkFfhuQNE
eNTXyqEJ9MUk7Yk5M/yqn/WpdU2RIbgmqP4Lbh72svrGnx61rlT0lA2qMD5I5xNX
8Y/gcox2qARexumOqrWiP2PtgjM74PtEyco7aWld8QF6T5dNpVH4SNWfdYtkl41d
ehJc6C328w1ti2q3UPlQpkql+fvOv9DA7cZdOO9vHOLG6qf+2kV98GpKTvsgfnNJ
l37B7QdZGQOgL1uQAa23d7W/1hrnTdcwfEhwPqyxpVq3YfIuaY2lPLB4ZXbmU/n5
RzzShhET7tqr+i0hLlN470Jo/sJWhY8wrMw8nMzOpLD+wK6E/Vo=
=CT43
-----END PGP SIGNATURE-----

--Sig_/r_YE01EgHFRe=0Du91BjSgg--

