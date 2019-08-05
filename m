Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D45C19759
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 02:59:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A11DB2086D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 02:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Rlmk0bty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11DB2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huTDY-0002PU-Hq
	for qemu-devel@archiver.kernel.org; Sun, 04 Aug 2019 22:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56376)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1huTD7-0001ul-Vv
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 22:58:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1huTD6-0007ul-MM
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 22:58:57 -0400
Received: from ozlabs.org ([203.11.71.1]:45195)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1huTD5-0007sK-9a; Sun, 04 Aug 2019 22:58:56 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4622XV2LkSz9sDB; Mon,  5 Aug 2019 12:58:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1564973930;
 bh=hGNpndo8qO96RsjGxUkggparRDVgxf/f6kOGyKhlZ/Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Rlmk0btyIStThMNNqhCsjsG5kfZxv4PtWVh+dv48IALslCSvnYfRg0Ffo0dc0/EIr
 L3+8PjCof9r5/poWcy3qX7PHEcxkeiVkguNFUoKefRzwHdPgzjxNDU4y9rpGCOztdi
 LXCy8SXTuZsOTxvplZYtbJ9SjSuaZ7jMuG++WJJQ=
Date: Mon, 5 Aug 2019 12:58:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Tao Xu <tao3.xu@intel.com>
Message-ID: <20190805025844.GA29381@umbus.fritz.box>
References: <20190801075258.19070-1-tao3.xu@intel.com>
 <20190802065538.GA2031@umbus.fritz.box>
 <27846884-9bf4-7729-7a9e-0392280ee67f@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <27846884-9bf4-7729-7a9e-0392280ee67f@intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [RFC PATCH] numa: add auto_enable_numa to fix
 broken check in spapr
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
Cc: imammedo@redhat.com, qemu-ppc@nongnu.org, ehabkost@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 05, 2019 at 08:56:40AM +0800, Tao Xu wrote:
> On 8/2/2019 2:55 PM, David Gibson wrote:
> > On Thu, Aug 01, 2019 at 03:52:58PM +0800, Tao Xu wrote:
> > > Introduce MachineClass::auto_enable_numa for one implicit NUMA node,
> > > and enable it to fix broken check in spapr_validate_node_memory(), wh=
en
> > > spapr_populate_memory() creates a implicit node and info then use
> > > nb_numa_nodes which is 0.
> > >=20
> > > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > > Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> > > Signed-off-by: Tao Xu <tao3.xu@intel.com>
> >=20
> > The change here looks fine so,
> >=20
> > Acked-by: David Gibson <david@gibson.dropbear.id.au>
> >=20
> > However, I'm not following what check in spapr is broken and why.
> >=20
> Sorry, may be I should update the commit message.
>=20
> Because in spapr_populate_memory(), if numa node is 0
>=20
>     if (!nb_nodes) {
>         nb_nodes =3D 1;
>         ramnode.node_mem =3D machine->ram_size;
>         nodes =3D &ramnode;
>     }
>=20
> it use a local 'nb_nodes' as 1 and update global nodes info, but
> inpapr_validate_node_memory(), use the global nb_numa_nodes
>=20
>     for (i =3D 0; i < nb_numa_nodes; i++) {
>     	if (numa_info[i].node_mem % SPAPR_MEMORY_BLOCK_SIZE) {
>=20
> so the global is 0 and skip the node_mem check.

Well, not really.  That loop is that each node has memory size a
multiple of 256MiB.  But we've already checked that the whole memory
size is a multiple of 256MiB, so in the case of one NUMA node, the
per-node check doesn't actually do anything extra.

And in the "non-NUMA" case, nb_numa_nodes =3D=3D 0, then I don't believe
numa_info[] is populated anyway, so we couldn't do the check like
this.


> > > ---
> > >=20
> > > This patch has a dependency on
> > > https://patchwork.kernel.org/cover/11063235/
> > > ---
> > >   hw/core/numa.c      | 9 +++++++--
> > >   hw/ppc/spapr.c      | 9 +--------
> > >   include/hw/boards.h | 1 +
> > >   3 files changed, 9 insertions(+), 10 deletions(-)
> > >=20
> > > diff --git a/hw/core/numa.c b/hw/core/numa.c
> > > index 75db35ac19..756d243d3f 100644
> > > --- a/hw/core/numa.c
> > > +++ b/hw/core/numa.c
> > > @@ -580,9 +580,14 @@ void numa_complete_configuration(MachineState *m=
s)
> > >        *   guest tries to use it with that drivers.
> > >        *
> > >        * Enable NUMA implicitly by adding a new NUMA node automatical=
ly.
> > > +     *
> > > +     * Or if MachineClass::auto_enable_numa is true and no NUMA node=
s,
> > > +     * assume there is just one node with whole RAM.
> > >        */
> > > -    if (ms->ram_slots > 0 && ms->numa_state->num_nodes =3D=3D 0 &&
> > > -        mc->auto_enable_numa_with_memhp) {
> > > +    if (ms->numa_state->num_nodes =3D=3D 0 &&
> > > +        ((ms->ram_slots > 0 &&
> > > +        mc->auto_enable_numa_with_memhp) ||
> > > +        mc->auto_enable_numa)) {
> > >               NumaNodeOptions node =3D { };
> > >               parse_numa_node(ms, &node, &error_abort);
> > >       }
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index f607ca567b..e50343f326 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -400,14 +400,6 @@ static int spapr_populate_memory(SpaprMachineSta=
te *spapr, void *fdt)
> > >       hwaddr mem_start, node_size;
> > >       int i, nb_nodes =3D machine->numa_state->num_nodes;
> > >       NodeInfo *nodes =3D machine->numa_state->nodes;
> > > -    NodeInfo ramnode;
> > > -
> > > -    /* No NUMA nodes, assume there is just one node with whole RAM */
> > > -    if (!nb_nodes) {
> > > -        nb_nodes =3D 1;
> > > -        ramnode.node_mem =3D machine->ram_size;
> > > -        nodes =3D &ramnode;
> > > -    }
> > >       for (i =3D 0, mem_start =3D 0; i < nb_nodes; ++i) {
> > >           if (!nodes[i].node_mem) {
> > > @@ -4369,6 +4361,7 @@ static void spapr_machine_class_init(ObjectClas=
s *oc, void *data)
> > >        */
> > >       mc->numa_mem_align_shift =3D 28;
> > >       mc->numa_mem_supported =3D true;
> > > +    mc->auto_enable_numa =3D true;
> > >       smc->default_caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
> > >       smc->default_caps.caps[SPAPR_CAP_VSX] =3D SPAPR_CAP_ON;
> > > diff --git a/include/hw/boards.h b/include/hw/boards.h
> > > index 2eb9a0b4e0..4a350b87d2 100644
> > > --- a/include/hw/boards.h
> > > +++ b/include/hw/boards.h
> > > @@ -220,6 +220,7 @@ struct MachineClass {
> > >       bool smbus_no_migration_support;
> > >       bool nvdimm_supported;
> > >       bool numa_mem_supported;
> > > +    bool auto_enable_numa;
> > >       HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
> > >                                              DeviceState *dev);
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1Hm2EACgkQbDjKyiDZ
s5LDFhAArqnm2QZDYC6+flTxt+wmkkFkiK8fkoav1lV0VQuAnh+fXg39885A7/e+
HgIAWaHBDs8RJBXTTiT/bCeU8WOPqXOnvAYgTPub9DIZXrBEoRugiWF3HRMJqd0X
dRuJL/qMtz02j20ZFwLsREB+IJzlhGL0UN3fzcBRLo11bPITkkGyOnmNWKpdh4S8
YbTY5o/VzWzlALXlIOP5M4H/GFx5088QCKU6R3bcv+vcJHBxCGmLFoJo/k6KuoY0
CBJlWpaT26Vkgt9wCMm/qstbRuSpOxds154eAmd/t+Ld2sXF3STPGsJuXueTX9My
NIuVN6+QYsQ/6r3jWgmhXTF+28/SHQdJ4JXTX9KSZHdPhCcSTokQT93mMPoWtWx3
AI6N0SlHvnPxxotwBy9gccwQXD/a94qfukxUX4o01gDVVYY+6zo+0knyAKpqgQS9
WqDnZi8Cfl3oH5qGptf//NxKOTHB5ByGFaIt7lzRZhVJygE5HOcHLfkI2YHS4ENL
albzMEEUD6ch81AgD82gZ7Kf7zKc9ttICrQU+LGQgY+3jFLEmSnP4kkeSVpT1rUw
9gWiszP2NIS0RUt7pY/0rFiDwCz+hyFQhWvrrbl2ITd+0CloLw58hs9qlEiEIIjG
KjAOf6Kzv1pxzdf4qUPkVxrLtLx77QcyVUhgfxoHz8LwT+aWj/s=
=qB95
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--

