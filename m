Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA02C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 13:14:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABB812087C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 13:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Z5RDqFsh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABB812087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htXOE-0005is-2W
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 09:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47418)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1htXNn-0005Dr-Vu
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 09:14:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1htXNm-0005ID-R8
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 09:14:07 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:52567 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1htXNl-0005BB-LV; Fri, 02 Aug 2019 09:14:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 460SKZ0GJJz9sML; Fri,  2 Aug 2019 23:13:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1564751634;
 bh=frtsMBVGFEousdhK5AxCi0PK1N5daALpasNxCizDqmg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Z5RDqFshOITjYhIq9Pd5l05xLC8AlipkQBa4a0RD5XDCqhfLiqTjSyie54cAP/kNS
 AriVr5YTrDZQgsZFPp2lz9AVFjj0Ghiyn84Wn4+iBS/+ocsWHncsIPaH/gNNKN+FhK
 im08Mo1HFqn8N+cFaZ59GSV9SPFXZkDUdZo9dpn4=
Date: Fri, 2 Aug 2019 16:55:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Tao Xu <tao3.xu@intel.com>
Message-ID: <20190802065538.GA2031@umbus.fritz.box>
References: <20190801075258.19070-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <20190801075258.19070-1-tao3.xu@intel.com>
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


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 01, 2019 at 03:52:58PM +0800, Tao Xu wrote:
> Introduce MachineClass::auto_enable_numa for one implicit NUMA node,
> and enable it to fix broken check in spapr_validate_node_memory(), when
> spapr_populate_memory() creates a implicit node and info then use
> nb_numa_nodes which is 0.
>=20
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>

The change here looks fine so,

Acked-by: David Gibson <david@gibson.dropbear.id.au>

However, I'm not following what check in spapr is broken and why.

> ---
>=20
> This patch has a dependency on
> https://patchwork.kernel.org/cover/11063235/
> ---
>  hw/core/numa.c      | 9 +++++++--
>  hw/ppc/spapr.c      | 9 +--------
>  include/hw/boards.h | 1 +
>  3 files changed, 9 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index 75db35ac19..756d243d3f 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -580,9 +580,14 @@ void numa_complete_configuration(MachineState *ms)
>       *   guest tries to use it with that drivers.
>       *
>       * Enable NUMA implicitly by adding a new NUMA node automatically.
> +     *
> +     * Or if MachineClass::auto_enable_numa is true and no NUMA nodes,
> +     * assume there is just one node with whole RAM.
>       */
> -    if (ms->ram_slots > 0 && ms->numa_state->num_nodes =3D=3D 0 &&
> -        mc->auto_enable_numa_with_memhp) {
> +    if (ms->numa_state->num_nodes =3D=3D 0 &&
> +        ((ms->ram_slots > 0 &&
> +        mc->auto_enable_numa_with_memhp) ||
> +        mc->auto_enable_numa)) {
>              NumaNodeOptions node =3D { };
>              parse_numa_node(ms, &node, &error_abort);
>      }
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f607ca567b..e50343f326 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -400,14 +400,6 @@ static int spapr_populate_memory(SpaprMachineState *=
spapr, void *fdt)
>      hwaddr mem_start, node_size;
>      int i, nb_nodes =3D machine->numa_state->num_nodes;
>      NodeInfo *nodes =3D machine->numa_state->nodes;
> -    NodeInfo ramnode;
> -
> -    /* No NUMA nodes, assume there is just one node with whole RAM */
> -    if (!nb_nodes) {
> -        nb_nodes =3D 1;
> -        ramnode.node_mem =3D machine->ram_size;
> -        nodes =3D &ramnode;
> -    }
> =20
>      for (i =3D 0, mem_start =3D 0; i < nb_nodes; ++i) {
>          if (!nodes[i].node_mem) {
> @@ -4369,6 +4361,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>       */
>      mc->numa_mem_align_shift =3D 28;
>      mc->numa_mem_supported =3D true;
> +    mc->auto_enable_numa =3D true;
> =20
>      smc->default_caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
>      smc->default_caps.caps[SPAPR_CAP_VSX] =3D SPAPR_CAP_ON;
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 2eb9a0b4e0..4a350b87d2 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -220,6 +220,7 @@ struct MachineClass {
>      bool smbus_no_migration_support;
>      bool nvdimm_supported;
>      bool numa_mem_supported;
> +    bool auto_enable_numa;
> =20
>      HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
>                                             DeviceState *dev);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1D3mgACgkQbDjKyiDZ
s5IIwQ//cEMnHyxmeEJ1+B1+SaOQYM/M9XfFX3Nn72u9/jLKvr8sgjhQU62nr/6N
peaG4gbQGUZHw+Hhwa18vwP1bBzK0Q3CGnuhCj+J5kDk8fS66UzoelZdo3QU9zxG
sTKj7tEodUVSMgwxVX9Dnw+pfAPz1BjDmPO4YHSLWhGIpneK5pYBPObZNgeH9XuG
/JA4ZIXPPiwTDgXWetZ0ItAEKD098Mcc/pn+RhrYVfpyaOez33SKdUkL1LoBiH2M
NPgRFSpKvdcOiHub5OYzF7u1cJDpxihhqWnAX/Z22Piz4Kvt7pychcjLtoPzL3+r
qxV9pnxAQKHFsyuyivvEVf7YU8MSNBshn1C5WPvMOBtbeT8G7TgcqVGcBMuXBj/C
ic/0lgFB2FrjbVvD9A7bxHCTZOjb/wvRqU4ZxzglblDATaGvA8nhyl9C+loiSR1D
s5qY+DxZMfxJ37XOAsABfXppqNCcIcaxLi9mZxAftUXLDYJFPlwQmin4RwJOJ3i5
hwwq0Qoq1LaAPR1+vk1LXbRqXm5tkgKdY1iwRzAWA5jTqTOstnPT6WJZ3XqPuc4C
7MFsdbXHt4vnocNojzpOdWV6kfc5fk4DdvjMGcj4AkdwD0OCwcZM8441j7GSdriT
YFcR3sRtG1+C5jKu3Dym9TfqddPBj1GNkwqWHUwpd1QHSZYx7Qw=
=Y1Wl
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--

