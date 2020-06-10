Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3AFC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:07:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFC242074B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Pt+RuPLt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC242074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jisxh-0000mT-Vn
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 01:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jisjO-0002lq-SR; Wed, 10 Jun 2020 00:52:54 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:45099 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jisjN-0004fF-Cu; Wed, 10 Jun 2020 00:52:54 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49hZFC3hzgz9sSd; Wed, 10 Jun 2020 14:46:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1591764367;
 bh=GAHcumRBPim0MrbmWI9QVBYHpb+KntBxmT/1zecd9DI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Pt+RuPLtoS5tGrt0Xbuodk5x701RISKo0pFHkuaqvytBj0yfZ9oJ4p09kD1NTiLFv
 u7Nq1I816DA5VuPL2BjSHOnW2wmntW1dBNO4QgDhVt35onfdgLbzbSvwx13Gi82ctM
 /72sj0tcJDl3dkYcM6W7pJQ6GvJTV4ZWMS3WmCeM=
Date: Wed, 10 Jun 2020 14:32:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v5] numa: forbid '-numa node,mem' for 5.1 and newer
 machine types
Message-ID: <20200610043243.GG494336@umbus.fritz.box>
References: <20200609135635.761587-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xjyYRNSh/RebjC6o"
Content-Disposition: inline
In-Reply-To: <20200609135635.761587-1-imammedo@redhat.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>, libvir-list@redhat.com,
 Michal Privoznik <mprivozn@redhat.com>, Greg Kurz <groug@kaod.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--xjyYRNSh/RebjC6o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2020 at 09:56:35AM -0400, Igor Mammedov wrote:
> Deprecation period is run out and it's a time to flip the switch
> introduced by cd5ff8333a.  Disable legacy option for new machine
> types (since 5.1) and amend documentation.
>=20
> '-numa node,memdev' shall be used instead of disabled option
> with new machine types.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Michal Privoznik <mprivozn@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>

ppc parts
Acked-b: David Gibson <david@gibson.dropbear.id.au>

> ---
> v1:
>  - rebased on top of current master
>  - move compat mode from 4.2 to 5.0
> v2:
>  - move deprecation text to recently removed section
> v3:
>  - increase title line length for (deprecated.rst)
>      '``-numa node,mem=3D``\ *size* (removed in 5.1)'
> v4:
>  - use error_append_hint() for suggesting valid CLI
> v5:
>  - add "\n" at the end of error_append_hint()
>  - fix gramar/spelling in moved deprecation text
>=20
> CC: peter.maydell@linaro.org
> CC: ehabkost@redhat.com
> CC: marcel.apfelbaum@gmail.com
> CC: mst@redhat.com
> CC: pbonzini@redhat.com
> CC: rth@twiddle.net
> CC: david@gibson.dropbear.id.au
> CC: libvir-list@redhat.com
> CC: qemu-arm@nongnu.org
> CC: qemu-ppc@nongnu.org
> CC: eblake@redhat.com
> CC: groug@kaod.org
> ---
>  docs/system/deprecated.rst | 37 ++++++++++++++++++++-----------------
>  hw/arm/virt.c              |  2 +-
>  hw/core/numa.c             |  7 +++++++
>  hw/i386/pc.c               |  1 -
>  hw/i386/pc_piix.c          |  1 +
>  hw/i386/pc_q35.c           |  1 +
>  hw/ppc/spapr.c             |  2 +-
>  qemu-options.hx            |  9 +++++----
>  8 files changed, 36 insertions(+), 24 deletions(-)
>=20
> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> index 544ece0a45..72666ac764 100644
> --- a/docs/system/deprecated.rst
> +++ b/docs/system/deprecated.rst
> @@ -101,23 +101,6 @@ error in the future.
>  The ``-realtime mlock=3Don|off`` argument has been replaced by the
>  ``-overcommit mem-lock=3Don|off`` argument.
> =20
> -``-numa node,mem=3D``\ *size* (since 4.1)
> -'''''''''''''''''''''''''''''''''''''''
> -
> -The parameter ``mem`` of ``-numa node`` is used to assign a part of
> -guest RAM to a NUMA node. But when using it, it's impossible to manage s=
pecified
> -RAM chunk on the host side (like bind it to a host node, setting bind po=
licy, ...),
> -so guest end-ups with the fake NUMA configuration with suboptiomal perfo=
rmance.
> -However since 2014 there is an alternative way to assign RAM to a NUMA n=
ode
> -using parameter ``memdev``, which does the same as ``mem`` and adds
> -means to actualy manage node RAM on the host side. Use parameter ``memde=
v``
> -with *memory-backend-ram* backend as an replacement for parameter ``mem``
> -to achieve the same fake NUMA effect or a properly configured
> -*memory-backend-file* backend to actually benefit from NUMA configuratio=
n.
> -In future new machine versions will not accept the option but it will st=
ill
> -work with old machine types. User can check QAPI schema to see if the le=
gacy
> -option is supported by looking at MachineInfo::numa-mem-supported proper=
ty.
> -
>  ``-numa`` node (without memory specified) (since 4.1)
>  '''''''''''''''''''''''''''''''''''''''''''''''''''''
> =20
> @@ -516,3 +499,23 @@ long starting at 1MiB, the old command::
>  can be rewritten as::
> =20
>    qemu-nbd -t --image-opts driver=3Draw,offset=3D1M,size=3D100M,file.dri=
ver=3Dqcow2,file.file.driver=3Dfile,file.file.filename=3Dfile.qcow2
> +
> +Command line options
> +--------------------
> +
> +``-numa node,mem=3D``\ *size* (removed in 5.1)
> +''''''''''''''''''''''''''''''''''''''''''''
> +
> +The parameter ``mem`` of ``-numa node`` was used to assign a part of
> +guest RAM to a NUMA node. But when using it, it's impossible to manage a=
 specified
> +RAM chunk on the host side (like bind it to a host node, setting bind po=
licy, ...),
> +so the guest ends up with the fake NUMA configuration with suboptiomal p=
erformance.
> +However since 2014 there is an alternative way to assign RAM to a NUMA n=
ode
> +using parameter ``memdev``, which does the same as ``mem`` and adds
> +means to actually manage node RAM on the host side. Use parameter ``memd=
ev``
> +with *memory-backend-ram* backend as replacement for parameter ``mem``
> +to achieve the same fake NUMA effect or a properly configured
> +*memory-backend-file* backend to actually benefit from NUMA configuratio=
n.
> +New machine versions (since 5.1) will not accept the option but it will =
still
> +work with old machine types. User can check the QAPI schema to see if th=
e legacy
> +option is supported by looking at MachineInfo::numa-mem-supported proper=
ty.
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 37462a6f78..063d4703f7 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2262,7 +2262,6 @@ static void virt_machine_class_init(ObjectClass *oc=
, void *data)
>      hc->pre_plug =3D virt_machine_device_pre_plug_cb;
>      hc->plug =3D virt_machine_device_plug_cb;
>      hc->unplug_request =3D virt_machine_device_unplug_request_cb;
> -    mc->numa_mem_supported =3D true;
>      mc->nvdimm_supported =3D true;
>      mc->auto_enable_numa_with_memhp =3D true;
>      mc->default_ram_id =3D "mach-virt.ram";
> @@ -2375,6 +2374,7 @@ DEFINE_VIRT_MACHINE_AS_LATEST(5, 1)
>  static void virt_machine_5_0_options(MachineClass *mc)
>  {
>      virt_machine_5_1_options(mc);
> +    mc->numa_mem_supported =3D true;
>  }
>  DEFINE_VIRT_MACHINE(5, 0)
> =20
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index 316bc50d75..a935640962 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -117,6 +117,13 @@ static void parse_numa_node(MachineState *ms, NumaNo=
deOptions *node,
>      }
> =20
>      if (node->has_mem) {
> +        if (!mc->numa_mem_supported) {
> +            error_setg(errp, "Parameter -numa node,mem is not supported =
by this"
> +                      " machine type");
> +            error_append_hint(errp, "Use -numa node,memdev instead\n");
> +            return;
> +        }
> +
>          numa_info[nodenr].node_mem =3D node->mem;
>          if (!qtest_enabled()) {
>              warn_report("Parameter -numa node,mem is deprecated,"
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 2128f3d6fe..a86136069c 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1960,7 +1960,6 @@ static void pc_machine_class_init(ObjectClass *oc, =
void *data)
>      hc->unplug =3D pc_machine_device_unplug_cb;
>      mc->default_cpu_type =3D TARGET_DEFAULT_CPU_TYPE;
>      mc->nvdimm_supported =3D true;
> -    mc->numa_mem_supported =3D true;
>      mc->default_ram_id =3D "pc.ram";
> =20
>      object_class_property_add(oc, PC_MACHINE_DEVMEM_REGION_SIZE, "int",
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index f66e1d73ce..8955436efa 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -438,6 +438,7 @@ static void pc_i440fx_5_0_machine_options(MachineClas=
s *m)
>      pc_i440fx_5_1_machine_options(m);
>      m->alias =3D NULL;
>      m->is_default =3D false;
> +    m->numa_mem_supported =3D true;
>      compat_props_add(m->compat_props, hw_compat_5_0, hw_compat_5_0_len);
>      compat_props_add(m->compat_props, pc_compat_5_0, pc_compat_5_0_len);
>  }
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 4ba8ac8774..af6b32adb7 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -366,6 +366,7 @@ static void pc_q35_5_0_machine_options(MachineClass *=
m)
>  {
>      pc_q35_5_1_machine_options(m);
>      m->alias =3D NULL;
> +    m->numa_mem_supported =3D true;
>      compat_props_add(m->compat_props, hw_compat_5_0, hw_compat_5_0_len);
>      compat_props_add(m->compat_props, pc_compat_5_0, pc_compat_5_0_len);
>  }
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 3b1a5ed865..210d61d1b3 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4511,7 +4511,6 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>       * in which LMBs are represented and hot-added
>       */
>      mc->numa_mem_align_shift =3D 28;
> -    mc->numa_mem_supported =3D true;
>      mc->auto_enable_numa =3D true;
> =20
>      smc->default_caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
> @@ -4599,6 +4598,7 @@ static void spapr_machine_5_0_class_options(Machine=
Class *mc)
>  {
>      spapr_machine_5_1_class_options(mc);
>      compat_props_add(mc->compat_props, hw_compat_5_0, hw_compat_5_0_len);
> +    mc->numa_mem_supported =3D true;
>  }
> =20
>  DEFINE_SPAPR_MACHINE(5_0, "5.0", false);
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 93bde2bbc8..196f468786 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -239,10 +239,11 @@ SRST
>          -numa node,nodeid=3D0 -numa node,nodeid=3D1 \
>          -numa cpu,node-id=3D0,socket-id=3D0 -numa cpu,node-id=3D1,socket=
-id=3D1
> =20
> -    '\ ``mem``\ ' assigns a given RAM amount to a node. '\ ``memdev``\ '
> -    assigns RAM from a given memory backend device to a node. If
> -    '\ ``mem``\ ' and '\ ``memdev``\ ' are omitted in all nodes, RAM is
> -    split equally between them.
> +    Legacy '\ ``mem``\ ' assigns a given RAM amount to a node (not suppo=
rted
> +    for 5.1 and newer machine types). '\ ``memdev``\ ' assigns RAM from
> +    a given memory backend device to a node. If '\ ``mem``\ ' and
> +    '\ ``memdev``\ ' are omitted in all nodes, RAM is split equally betw=
een them.
> +
> =20
>      '\ ``mem``\ ' and '\ ``memdev``\ ' are mutually exclusive.
>      Furthermore, if one node uses '\ ``memdev``\ ', all of them have to

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xjyYRNSh/RebjC6o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7gYmsACgkQbDjKyiDZ
s5L52g/+PuT97bS3FIMzYZ5howQxprZkmbxCkNxpjdB81cVcC+116lQj9M80nEw2
Ws9yNI5YmP5EUZUoAyW6+Q2qHIaUWWpnnzrDqna3GK/gma4FDXOyQxhQ0CGO43Pa
xA24zUvpq9ofWmfpDWYKgB6Y3cYhwLVOjKTgszsgrHkPQ2PLLlvg0RKbMQ8TA/zx
eig2Dfxl4nc3nF+I+bZDNwYU3KN+unbfe9KNjtmho72wX7ODob/GAqVQVSxYjzq/
7NFihDgdtEjMvZzN44qPxY6XQ7/QFMyH9a7tLN6nml3goAW0nPWgSFhikZWzMh3W
G+9vcNNE+CvGGvwGTeVaMuAlfrdhpI/1jn4vg51jAM4wW6f7Tz9JXJmIY+ZTAjlO
AWywc5hrmsiFUWWa14R5ZNuJpaAyeJbKn87tNFqTuY5cM3i/ke1Mslwj4T9uPEbX
MzC0H53GV+iFhkD9ipgezlPmIZw1yUyAj1JJQ2gX7e2Dju8U9xfSWp+JGpqch0pB
MWd7vR0grRSRggKag4uyA+aBznRDuOHUmdVPVPO4W03NBp8hlOxSpopHe0BXJnT8
9L9kFCX0Deyr6sYPcbB7bRfn50BzXNzvP9mSc6JrTHEQqaxHAO0cbN+G9vlAyfdC
i6IwhlyT0a1pnPh0aKuxTXB46vuG3Si1MQxvzMgAHWNZgG5uAc0=
=vbzX
-----END PGP SIGNATURE-----

--xjyYRNSh/RebjC6o--

