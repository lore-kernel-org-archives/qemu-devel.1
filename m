Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939F5C3276C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 00:46:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52CB921734
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 00:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="qJJC9ux7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52CB921734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inB70-0007QD-D9
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 19:46:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1inB5m-0006kj-Df
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 19:45:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1inB5i-0007Yl-UG
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 19:45:29 -0500
Received: from ozlabs.org ([203.11.71.1]:48501)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1inB5g-0007H4-Ip; Thu, 02 Jan 2020 19:45:26 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47pmQl4PNpz9s4Y; Fri,  3 Jan 2020 11:45:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578012319;
 bh=0E4ENNHAmExEh9ijlflSzJhkyu6HsPa3EeVLhvFJ/Qs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qJJC9ux7zotMopSFPINiCx83RioGSBW00OWl97NodBm6FaI3VBHb7fHKm4Hfuucdf
 mX6fBfghzdye5hM/xFwo6Od7FRypoZASjWXQlFMNbcZQkQTCHvrQO1tw8vW7+hONz/
 5QXiVyoeidzur1UQMURXRYPf//0PqV5+aF7zd9pc=
Date: Fri, 3 Jan 2020 11:45:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Subject: Re: [PATCH v3 2/3] spapr: Add NVDIMM device support
Message-ID: <20200103004514.GO2098@umbus>
References: <157107820388.27733.3565652855304038259.stgit@lep8c.aus.stglabs.ibm.com>
 <157107826404.27733.10134514695430511105.stgit@lep8c.aus.stglabs.ibm.com>
 <20191122043045.GD5582@umbus.fritz.box>
 <CAGZKiBo4bdTTbJ82YV92RtTqbhuj_-GRxt6GceWyPbWdr9LGFA@mail.gmail.com>
 <20191206015255.GL5031@umbus.fritz.box>
 <1c24857f-64d4-a14d-1b66-cae2113d53a2@linux.ibm.com>
 <20191211090509.1845b913@redhat.com>
 <463b35ba-c35d-a251-a8ee-c65e5134cf8c@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="m46qSNjkc66Ye11q"
Content-Disposition: inline
In-Reply-To: <463b35ba-c35d-a251-a8ee-c65e5134cf8c@linux.ibm.com>
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
Cc: qemu-ppc@nongnu.org, xiaoguangrong.eric@gmail.com, mst@redhat.com,
 qemu-devel@nongnu.org, Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>,
 Bharata B Rao <bharata.rao@gmail.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--m46qSNjkc66Ye11q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2019 at 02:22:56PM +0530, Shivaprasad G Bhat wrote:
>=20
>=20
> On 12/11/2019 01:35 PM, Igor Mammedov wrote:
> > On Wed, 11 Dec 2019 09:44:11 +0530
> > Shivaprasad G Bhat <sbhat@linux.ibm.com> wrote:
> >=20
> > > On 12/06/2019 07:22 AM, David Gibson wrote:
> > > > On Wed, Nov 27, 2019 at 09:50:54AM +0530, Bharata B Rao wrote:
> > > > > On Fri, Nov 22, 2019 at 10:42 AM David Gibson
> > > > > <david@gibson.dropbear.id.au> wrote:
> > > > > > Ok.  A number of queries about this.
> > > > > >=20
> > > > > > 1) The PAPR spec for ibm,dynamic-memory-v2 says that the first =
word in
> > > > > > each entry is the number of LMBs, but for NVDIMMs you use the
> > > > > > not-necessarily-equal scm_block_size instead.  Does the NVDIMM
> > > > > > amendment for PAPR really specify to use different block sizes =
for
> > > > > > these cases?  (In which case that's a really stupid spec decisi=
on, but
> > > > > > that wouldn't surprise me at this point).
> > > > > SCM block sizes can be different from LMB sizes, but here we enfo=
rce
> > > > > that SCM device size (excluding metadata) to multiple of LMB size=
 so
> > > > > that we don't end up memory range that is not aligned to LMB size.
> > > > Right, but it still doesn't make sense to use scm_block_size when y=
ou
> > > > create the dynamic-memory-v2 property.
> > > Right, I should use LMB size here as I will be creating holes here to
> > > disallow DIMMs
> > > to claim those LMBs marking them INVALID as Bharata Suggested before.
> > >=20
> > > >    As far as the thing
> > > > interpreting that goes, it *must* be LMB size, not SCM block size. =
 If
> > > > those are required to be the same at this point, you should use an
> > > > assert().
> > > SCM block size should be a multiple for LMB size, need not be equal.
> > > I'll add an assert
> > > for that, checking if equal. There is no benefit I see as of now havi=
ng
> > > higher
> > > SCM block size as the bind/unbind are already done before the bind hc=
all.
> > >=20
> > > > > > 2) Similarly, the ibm,dynamic-memory-v2 description says that t=
he
> > > > > > memory block described by the entry has a whole batch of contig=
uous
> > > > > > DRCs starting at the DRC index given and continuing for #LMBs D=
RCs.
> > > > > > For NVDIMMs it appears that you just have one DRC for the whole
> > > > > > NVDIMM.  Is that right?
> > > > > One NVDIMM has one DRC, In our case, we need to mark the LMBs
> > > > > corresponding to that address range in ibm,dynamic-memory-v2 as
> > > > > reserved and invalid.
> > > > Ok, that fits very weirdly with the DRC allocation for the rest of
> > > > pluggable memory, but I suppose that's PAPR for you.
> > > >=20
> > > > Having these in together is very inscrutable though, and relies on a
> > > > heap of non-obvious constraints about placement of DIMMs and NVDIMMs
> > > > relative to each other.  I really wonder if it would be better to h=
ave
> > > > a completely different address range for the NVDIMMs.
> > > The backend object for both DIMM and NVDIMM are memory-backend-*
> > > and they use the address from the same space. Separating it would mean
> > > using/introducing different backend object. I dont think we have a
> > > choice here.
> > What address-space(s) are are talking about here exactly?
> >  From my point of view memory-backend-* provides RAM block at
> > some HVA, which shouldn't not have anything to do with how NVDIMM
> > partitions and maps it to GPA.
>=20
> Ah, you are right! I got confused with the HVA.
>=20
> Nonetheless, I don't see a need for having vNVDIMM in different
> guest physical address range as the existing code has support for marking
> memory ranges distinctly for DIMM/NVDIMM.

The problem is that the way you create the dynamic-memory-v2 property
relies on knowing whether a GPA is DIMM or NVDIMM -but you can't in
the presence of hotplug.  Using the default address allocation, DIMMs
and NVDIMMs are dynamically assigned addresses in the hotplug memory
area.

So, if you have an NVDIMM plugged at boot time, you'll mark that range
of LMBs as invalid.  If you then unplug it, and instead plug in a
regular DIMM (before the guest has even tried to online the NVDIMM),
it will probably use the same GPA range.  You therefore need regular
LMB DRCs for that range, and we have no way to communicate that to the
guest.

Similar problems if you go the other way (unplug DIMM, plug NVDIMM).

> On another note, the x86 too does it the same way. There is no separate
> range defined there.

Yes, but AIUI, the way PC describes DIMMs and NVDIMMs in ACPI are
pretty similar.  In PAPR they are gratuitously different - we don't
even have the concept of a DIMM, only the individual LMBs that go into
it.  The match between the DIMM backend and the PAPR LMB frontend is
already pretty poor, covering NVDIMMs in the same range pushes it past
breaking point.

> > > > > > 3) You're not setting *any* extra flags on the entry.  How is t=
he
> > > > > > guest supposed to know which are NVDIMM entries and which are r=
egular
> > > > > > DIMM entries?  AFAICT in this version the NVDIMM slots are
> > > > > > indistinguishable from the unassigned hotplug memory (which mak=
es the
> > > > > > difference in LMB and DRC numbering even more troubling).
> > > > > For NVDIMM case, this patch should populate the LMB set in
> > > > > ibm,dynamic-memory-v2 something like below:
> > > > >               elem =3D spapr_get_drconf_cell(size /lmb_size, addr,
> > > > >                                            0, -1,
> > > > > SPAPR_LMB_FLAGS_RESERVED | SPAPR_LMB_FLAGS_DRC_INVALID);
> > > > >=20
> > > > > This will ensure that the NVDIMM range will never be considered as
> > > > > valid memory range for memory hotplug.
> > > > Hrm.  Ok so we already have code that does that for any gaps between
> > > > DIMMs.  I don't think there's actually anything that that code will=
 do
> > > > differently than the code you have for NVDIMMs, so you could just s=
kip
> > > > over the NVDIMMs here and it should do the right thing.
> > > >=20
> > > > The *interpretation* of those entries will become different: for sp=
ace
> > > > into which a regular DIMM is later inserted, we'll assume the DRC
> > > > index given is a base and there are more DRCs following it, but for
> > > > NVDIMMs we'll assume the same DRC throughout.  This is nuts, but II=
UC
> > > > that's what PAPR says and we can't do much about it.
> > > My current patch is buggy as Bharata pointed out. The NVDIMM DRCs
> > > are not to be populated here, but mark the LMB DRCs as RESERVED and I=
NVALID
> > > so that no malicious attempts to online those LMBs at those NVDIMM ad=
dress
> > > ranges are attempted.
> > >=20
> > > > > > 4) AFAICT these are _present_ NVDIMMs, so why is
> > > > > > SPAPR_LMB_FLAGS_ASSIGNED not set for them?  (and why is the node
> > > > > > forced to -1, regardless of di->node).
> > > > > > >            QSIMPLEQ_INSERT_TAIL(&drconf_queue, elem, entry);
> > > > > > >            nr_entries++;
> > > > > > >            cur_addr =3D addr + size;
> > > > > > > @@ -1261,6 +1273,85 @@ static void spapr_dt_hypervisor(SpaprM=
achineState *spapr, void *fdt)
> > > > > > >        }
> > > > > > >    }
> > > > > > >=20
> > > > > > > +static void spapr_create_nvdimm_dr_connectors(SpaprMachineSt=
ate *spapr)
> > > > > > > +{
> > > > > > > +    MachineState *machine =3D MACHINE(spapr);
> > > > > > > +    int i;
> > > > > > > +
> > > > > > > +    for (i =3D 0; i < machine->ram_slots; i++) {
> > > > > > > +        spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC=
_PMEM, i);
> > > > > > What happens if you try to plug an NVDIMM to one of these slots=
, but a
> > > > > > regular DIMM has already taken it?
> > > > > NVDIMM hotplug won't get that occupied slot.
> > > > Ok.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--m46qSNjkc66Ye11q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4OjpcACgkQbDjKyiDZ
s5LnjRAApftYrMvjwfASt6X6ptFsMgbOu2xVhzBOP+1iR+IVbKH2rO0vS6s2dHgW
W2g/UC5sdR229mC8udYiZ1cvYWDeB/jlYc0d5JZVvVuHar1e13T+PioojDGgQNR3
PxK3iSRcwfkQMfB/XrM5ZmDXXe59we16Aw5PqFwFR63lK0lMKR7Y20/2+ssA+yK/
Yx//H5F6ts/CyMmfQLPDZj/QIb3ojB+6jbBikNH2aTLU8SAxybgRuWh0kH9faXNR
mTslPCMwOS90apFU3i06F8aTaceEzxKsR37CXMSGEJu/2ki0D96V422BiZmKGX8e
KvjJ8hxeW0uXw4BFZhN97QzQxT7FxcKCi0xnN+U4Ll9YxzFZ3nrGw4cRE36ad3t+
g//DRPF2l8HsU0bMbVOQMVtJ7QGkl3lheLkLj8tcRnjS/Zm51B52/vAmj4rfrq0A
7ZcfOTD7RybrXu6d+H0gXz8on2UsnbwMlGbtU1pPa1ylY0ypzrRpuCx/O/TnaeF0
wTNbyu6kPZTXYnjlvphBwmu8Sb69GBzEeNmcVcH0gN3nzAGc9A1AAwr960HPftbF
njHb+nW8G60ybE+CwZnUj5k7Q1nX4sIhhCEGh7Se/POMPEznWeCSqoOuZ2qPx0Mx
N473m7GZPdsu5XOE9F7S52loeiAnnDBSa71iclzPnK9JYFPU/jM=
=2WwB
-----END PGP SIGNATURE-----

--m46qSNjkc66Ye11q--

