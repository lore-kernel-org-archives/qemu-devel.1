Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65801C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 07:35:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C55B4205CA
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 07:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C55B4205CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSEpm-0006bO-QP
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 03:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kSEoi-00063k-Qg; Tue, 13 Oct 2020 03:33:52 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:46993)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kSEog-00056c-4q; Tue, 13 Oct 2020 03:33:52 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.179])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 6118A65079CA;
 Tue, 13 Oct 2020 09:33:45 +0200 (CEST)
Received: from kaod.org (37.59.142.103) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Tue, 13 Oct
 2020 09:33:45 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G0051ddd0fbc-4252-40d3-aa01-317a1a802a94,
 D6AFF0C3E053B6A762171B7B83DFD2EA3CA7D1A7) smtp.auth=groug@kaod.org
Date: Tue, 13 Oct 2020 09:33:44 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] spapr: Move spapr_create_nvdimm_dr_connectors() to core
 machine code
Message-ID: <20201013093344.644b5677@bahia.lan>
In-Reply-To: <20201013004014.GF71119@yekko.fritz.box>
References: <160249772183.757627.7396780936543977766.stgit@bahia.lan>
 <20201013004014.GF71119@yekko.fritz.box>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aET2y59p4M+wBr9/g4GNNWv";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Originating-IP: [37.59.142.103]
X-ClientProxiedBy: DAG3EX2.mxp5.local (172.16.2.22) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 240dbd8d-16f0-4ac9-8d5c-ff4b1e61b20c
X-Ovh-Tracer-Id: 6366119549554432480
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrheekgdduvdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtihesghdtreerredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnheplefggfefueegudegkeevieevveejfffhuddvgeffteekieevueefgfeltdfgieetnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 03:33:47
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/aET2y59p4M+wBr9/g4GNNWv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Oct 2020 11:40:14 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Mon, Oct 12, 2020 at 12:15:21PM +0200, Greg Kurz wrote:
> > The spapr_create_nvdimm_dr_connectors() function doesn't need to access
> > any internal details of the sPAPR NVDIMM implementation. Also, pretty
> > much like for the LMBs, only spapr_machine_init() is responsible for the
> > creation of DR connectors for NVDIMMs.
> >=20
> > Make this clear by making this function static in hw/ppc/spapr.c.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
>=20
> Hrm, I'm not really seeing the advantage to moving this.  It doesn't
> have to be in spapr_nvdimm for data hiding, but it is related, and
> spapr.c is kind of huge.
>=20

The only advantage is to give an appropriate scope to this function,
as many other functions that create internal devices, eg. other DRC
types or the default PHB for which a similar change was accepted
2 years ago.

commit 999c9caf2eee66103195e1ec7580b379929db9d2
Author: Greg Kurz <groug@kaod.org>
Date:   Fri Dec 21 01:35:09 2018 +0100

    spapr: move spapr_create_phb() to core machine code
   =20
    This function is only used when creating the default PHB. Let's rename
    it and move it to the core machine code for clarity.
   =20
    Signed-off-by: Greg Kurz <groug@kaod.org>
    Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
    Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
    Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

I agree that spapr.c is huge indeed (4943 lines) but this increases its
size by _just_ 0.2 %. And there are certainly good candidates that
landed in spapr.c by _default_ over the years but should rather be
moved to their own compilation unit (eg. a bunch of FDT building
functions for various resources or some hotplug related functions
that don't need to access machine internals).

> > ---
> >  hw/ppc/spapr.c                |   10 ++++++++++
> >  hw/ppc/spapr_nvdimm.c         |   11 -----------
> >  include/hw/ppc/spapr_nvdimm.h |    1 -
> >  3 files changed, 10 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 63315f2d0fa9..ee716a12af73 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2641,6 +2641,16 @@ static hwaddr spapr_rma_size(SpaprMachineState *=
spapr, Error **errp)
> >      return rma_size;
> >  }
> > =20
> > +static void spapr_create_nvdimm_dr_connectors(SpaprMachineState *spapr)
> > +{
> > +    MachineState *machine =3D MACHINE(spapr);
> > +    int i;
> > +
> > +    for (i =3D 0; i < machine->ram_slots; i++) {
> > +        spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_PMEM, i);
> > +    }
> > +}
> > +
> >  /* pSeries LPAR / sPAPR hardware init */
> >  static void spapr_machine_init(MachineState *machine)
> >  {
> > diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
> > index b3a489e9fe18..9e3d94071fe1 100644
> > --- a/hw/ppc/spapr_nvdimm.c
> > +++ b/hw/ppc/spapr_nvdimm.c
> > @@ -106,17 +106,6 @@ void spapr_add_nvdimm(DeviceState *dev, uint64_t s=
lot, Error **errp)
> >      }
> >  }
> > =20
> > -void spapr_create_nvdimm_dr_connectors(SpaprMachineState *spapr)
> > -{
> > -    MachineState *machine =3D MACHINE(spapr);
> > -    int i;
> > -
> > -    for (i =3D 0; i < machine->ram_slots; i++) {
> > -        spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_PMEM, i);
> > -    }
> > -}
> > -
> > -
> >  static int spapr_dt_nvdimm(SpaprMachineState *spapr, void *fdt,
> >                             int parent_offset, NVDIMMDevice *nvdimm)
> >  {
> > diff --git a/include/hw/ppc/spapr_nvdimm.h b/include/hw/ppc/spapr_nvdim=
m.h
> > index b834d82f5545..490b19a009f4 100644
> > --- a/include/hw/ppc/spapr_nvdimm.h
> > +++ b/include/hw/ppc/spapr_nvdimm.h
> > @@ -31,6 +31,5 @@ void spapr_dt_persistent_memory(SpaprMachineState *sp=
apr, void *fdt);
> >  bool spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *=
nvdimm,
> >                             uint64_t size, Error **errp);
> >  void spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp);
> > -void spapr_create_nvdimm_dr_connectors(SpaprMachineState *spapr);
> > =20
> >  #endif
> >=20
> >=20
>=20


--Sig_/aET2y59p4M+wBr9/g4GNNWv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl+FWFgACgkQcdTV5YIv
c9Y+ZhAAnxZ4FUElYKw8gYbCzmig8gDmghBIsoDLFVaRMdzicDrbFNHqcCBxND4D
Iu/DI+lr7Ndv9pEBiswRlv1d94QAVAmVg5PSojvNJeZDWHW0ydwRUSWeqcPF2rUp
viZIFjfo1/OqNWQVk/uNudNm1Gy4TZcZ4i9VKWzRiI0AVJ6s+K8xTVKE/sxzadh0
DVzjJ9ULsWK2tK4VfPAWvGHmvJo7bzFjSl6Ofr0m/KML78EqxSCnQdOp+PkuL9WS
piByOTijcTaOKs7UATwcPhxwZ3rE6rNDCHi2xwFD5gMbMblMKmvZ+XIQwF3SWpj4
oqLsXH4/SZUWsaP6WJWk42q3af+ex2EUmRNMr/1wsuyoYCvds0ed/iY50V8p+F3m
8n7SHY6npxqEAM9knhGQnJck517pCOT/dvd5bTA/4cSW6VK6a/4fI2rNbwN9R8GH
ZYVkCp3PAMMV9MZLFjulLLOtKbs+CrZr/K2wkPptJDqoFH/kzsu0AKcfqSE7h1y/
AYk4a57O9FQIZKlINaqfePsfljCTmsfooNipPK3PMMYqon+GxqilYHeZ2mM2WhSs
+e3UdGt4MTLHCOB8ui5FDHdscqqgyOZ0ZmxyF0iXqzUeaTXX1KAqxIgoUnMk7SVo
GcNPrIXgVJqU5md//XaKKWx78dK7ISoXglcnNQIaHl3B2CwPEGQ=
=9sxa
-----END PGP SIGNATURE-----

--Sig_/aET2y59p4M+wBr9/g4GNNWv--

