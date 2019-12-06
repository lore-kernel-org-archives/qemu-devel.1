Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80259C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 04:32:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B23824676
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 04:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hQzDWkrp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B23824676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1id5IM-0000HT-8q
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 23:32:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1id57h-0004QH-UN
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 23:21:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1id57f-0004UO-6X
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 23:21:45 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:40407 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1id57c-0004OB-N4; Thu, 05 Dec 2019 23:21:41 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47TfYC6wBfz9sPJ; Fri,  6 Dec 2019 15:21:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1575606095;
 bh=sTXzqSVABRNIJaRVcsklfiIDzUDXlCKqDPt+HwTROkg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hQzDWkrpVm0IrsElFUASD7ebeDMaSRf60G8JqiKOsR09/zu9FWHt94oVKEIfhrA0g
 ZrFxH0FRhbr4g8c5TMP67pgXbktQY5D1mC0/BsF4i+AGY0tXhpQtailswb49F80pc2
 jtoEXx2DoLTcyhqBfEubLa4hGSML5CWOXzv0bmBc=
Date: Fri, 6 Dec 2019 12:52:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Bharata B Rao <bharata.rao@gmail.com>
Subject: Re: [PATCH v3 2/3] spapr: Add NVDIMM device support
Message-ID: <20191206015255.GL5031@umbus.fritz.box>
References: <157107820388.27733.3565652855304038259.stgit@lep8c.aus.stglabs.ibm.com>
 <157107826404.27733.10134514695430511105.stgit@lep8c.aus.stglabs.ibm.com>
 <20191122043045.GD5582@umbus.fritz.box>
 <CAGZKiBo4bdTTbJ82YV92RtTqbhuj_-GRxt6GceWyPbWdr9LGFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="enGqbSaueFq5omEL"
Content-Disposition: inline
In-Reply-To: <CAGZKiBo4bdTTbJ82YV92RtTqbhuj_-GRxt6GceWyPbWdr9LGFA@mail.gmail.com>
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
Cc: xiaoguangrong.eric@gmail.com, Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 mst@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--enGqbSaueFq5omEL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2019 at 09:50:54AM +0530, Bharata B Rao wrote:
> On Fri, Nov 22, 2019 at 10:42 AM David Gibson
> <david@gibson.dropbear.id.au> wrote:
> >
> > Ok.  A number of queries about this.
> >
> > 1) The PAPR spec for ibm,dynamic-memory-v2 says that the first word in
> > each entry is the number of LMBs, but for NVDIMMs you use the
> > not-necessarily-equal scm_block_size instead.  Does the NVDIMM
> > amendment for PAPR really specify to use different block sizes for
> > these cases?  (In which case that's a really stupid spec decision, but
> > that wouldn't surprise me at this point).
>=20
> SCM block sizes can be different from LMB sizes, but here we enforce
> that SCM device size (excluding metadata) to multiple of LMB size so
> that we don't end up memory range that is not aligned to LMB size.

Right, but it still doesn't make sense to use scm_block_size when you
create the dynamic-memory-v2 property.  As far as the thing
interpreting that goes, it *must* be LMB size, not SCM block size.  If
those are required to be the same at this point, you should use an
assert().

> > 2) Similarly, the ibm,dynamic-memory-v2 description says that the
> > memory block described by the entry has a whole batch of contiguous
> > DRCs starting at the DRC index given and continuing for #LMBs DRCs.
> > For NVDIMMs it appears that you just have one DRC for the whole
> > NVDIMM.  Is that right?
>=20
> One NVDIMM has one DRC, In our case, we need to mark the LMBs
> corresponding to that address range in ibm,dynamic-memory-v2 as
> reserved and invalid.

Ok, that fits very weirdly with the DRC allocation for the rest of
pluggable memory, but I suppose that's PAPR for you.

Having these in together is very inscrutable though, and relies on a
heap of non-obvious constraints about placement of DIMMs and NVDIMMs
relative to each other.  I really wonder if it would be better to have
a completely different address range for the NVDIMMs.

> > 3) You're not setting *any* extra flags on the entry.  How is the
> > guest supposed to know which are NVDIMM entries and which are regular
> > DIMM entries?  AFAICT in this version the NVDIMM slots are
> > indistinguishable from the unassigned hotplug memory (which makes the
> > difference in LMB and DRC numbering even more troubling).
>=20
> For NVDIMM case, this patch should populate the LMB set in
> ibm,dynamic-memory-v2 something like below:
>             elem =3D spapr_get_drconf_cell(size /lmb_size, addr,
>                                          0, -1,
> SPAPR_LMB_FLAGS_RESERVED | SPAPR_LMB_FLAGS_DRC_INVALID);
>=20
> This will ensure that the NVDIMM range will never be considered as
> valid memory range for memory hotplug.

Hrm.  Ok so we already have code that does that for any gaps between
DIMMs.  I don't think there's actually anything that that code will do
differently than the code you have for NVDIMMs, so you could just skip
over the NVDIMMs here and it should do the right thing.

The *interpretation* of those entries will become different: for space
into which a regular DIMM is later inserted, we'll assume the DRC
index given is a base and there are more DRCs following it, but for
NVDIMMs we'll assume the same DRC throughout.  This is nuts, but IIUC
that's what PAPR says and we can't do much about it.

> > 4) AFAICT these are _present_ NVDIMMs, so why is
> > SPAPR_LMB_FLAGS_ASSIGNED not set for them?  (and why is the node
> > forced to -1, regardless of di->node).
> >
> > >          QSIMPLEQ_INSERT_TAIL(&drconf_queue, elem, entry);
> > >          nr_entries++;
> > >          cur_addr =3D addr + size;
> > > @@ -1261,6 +1273,85 @@ static void spapr_dt_hypervisor(SpaprMachineSt=
ate *spapr, void *fdt)
> > >      }
> > >  }
> > >
>=20
> > > +static void spapr_create_nvdimm_dr_connectors(SpaprMachineState *spa=
pr)
> > > +{
> > > +    MachineState *machine =3D MACHINE(spapr);
> > > +    int i;
> > > +
> > > +    for (i =3D 0; i < machine->ram_slots; i++) {
> > > +        spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_PMEM, i=
);
> >
> > What happens if you try to plug an NVDIMM to one of these slots, but a
> > regular DIMM has already taken it?
>=20
> NVDIMM hotplug won't get that occupied slot.

Ok.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--enGqbSaueFq5omEL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3ptHcACgkQbDjKyiDZ
s5KfRg/9F3kMaP04+uqhOydWHQrOP5vY3aD2gBu4uk3WomQMf9YzIr+Gl9nSgX0+
bmLtmoAs0UGPsMtO6MQAwt8KVOqeObCXsDrhg/s6JZswl9iByOCAgLfpWpaDc/jI
TI6oFTQhHk7nxY5zAOi+oaA2K/H9FIDgZTSHr29aRLH8vv/wz5STM4rXpcQ9WxEV
dtT/u/r4flWYjUXR8yx+h7kPtGKsbAnAErEky5MieYaJMjaneaALDoxLPjWBqVx+
OL40HuL657/n1luFkUTP7R3bVG0prZ0DsG61KDRPwLSwycuhnEiEfS26QLWuBtBH
h/j921IYDZtSxlgSYVyFEBqi3RtPxd9uJqCeO7si2K64ujiAsi9UYIvdrPEBcX4Y
3DYc6wVMy8jJEU5QneyCbiub1bPU5D4yB0yzs6lRVn9ukS3hqp8gRm7t5zAcQ1k3
GcyeHBMi31iFrcJbz3oZSggFxcRT6E3MFPwi+yxEzSbFHQ4KQegkHUQntU1lU1J0
9JSxWbqRd64SFwVFZaXeoQgtyv0h7eOdpkhZpIx/nQptFNqeZkqQNKeOD8xigos5
KedXh6EufYS8y9jcyd85r5Xub4g9lCkcl7szCPEg30RmFGWaxNlI2jjFcebNCniD
Q4us414zdrNhLXn3n6XFRdkSzzl5qmvpWlImcNwZmaaao4Vf+b4=
=VtQl
-----END PGP SIGNATURE-----

--enGqbSaueFq5omEL--

