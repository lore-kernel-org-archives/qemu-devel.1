Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169EFC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 04:41:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4DD120748
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 04:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZcYG8Wox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4DD120748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irwyF-00074e-Vl
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 23:41:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58277)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1irwvw-0004Qb-4S
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 23:39:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1irwvu-0005A9-FW
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 23:39:04 -0500
Received: from ozlabs.org ([203.11.71.1]:42807)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1irwvp-00054E-GM; Wed, 15 Jan 2020 23:38:58 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47ys0G2ZNFz9sRQ; Thu, 16 Jan 2020 15:38:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1579149534;
 bh=uXHXnxQ6z4+rqzdt+wC4wGT9VHSh7NbeJd8FvrssXew=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZcYG8WoxUTmhcOm9PBTFEWYB2aOSyNz5iqsK5Z9k8J+HFI965CSi4XRlAll/j+F2l
 ovPlSwYbvqflXe6n5O684hgei1b5TDwsynmYErTgfAjESLuOPXbjDH93eL88bvkR+F
 jeJ3UoiibtPXc3U4O16YTJ7h62btY3NDyf/98BI0=
Date: Thu, 16 Jan 2020 14:36:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v2 82/86] numa: forbid '-numa node, mem' for 5.0 and newer
 machine types
Message-ID: <20200116043608.GP54439@umbus>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-83-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="aC33ObtQAkNdOZ6b"
Content-Disposition: inline
In-Reply-To: <1579100861-73692-83-git-send-email-imammedo@redhat.com>
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, mst@redhat.com,
 libvir-list@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--aC33ObtQAkNdOZ6b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2020 at 04:07:37PM +0100, Igor Mammedov wrote:
> Deprecation period is ran out and it's a time to flip the switch
> introduced by cd5ff8333a.
> Disable legacy option for new machine types and amend documentation.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

ppc parts
Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
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
> ---
>  hw/arm/virt.c        |  2 +-
>  hw/core/numa.c       |  6 ++++++
>  hw/i386/pc.c         |  1 -
>  hw/i386/pc_piix.c    |  1 +
>  hw/i386/pc_q35.c     |  1 +
>  hw/ppc/spapr.c       |  2 +-
>  qemu-deprecated.texi | 16 ----------------
>  qemu-options.hx      |  8 ++++----
>  8 files changed, 14 insertions(+), 23 deletions(-)
>=20
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index e2fbca3..49de0d8 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2049,7 +2049,6 @@ static void virt_machine_class_init(ObjectClass *oc=
, void *data)
>      hc->pre_plug =3D virt_machine_device_pre_plug_cb;
>      hc->plug =3D virt_machine_device_plug_cb;
>      hc->unplug_request =3D virt_machine_device_unplug_request_cb;
> -    mc->numa_mem_supported =3D true;
>      mc->auto_enable_numa_with_memhp =3D true;
>      mc->default_ram_id =3D "mach-virt.ram";
>  }
> @@ -2153,6 +2152,7 @@ DEFINE_VIRT_MACHINE_AS_LATEST(5, 0)
>  static void virt_machine_4_2_options(MachineClass *mc)
>  {
>      compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
> +    mc->numa_mem_supported =3D true;
>  }
>  DEFINE_VIRT_MACHINE(4, 2)
> =20
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index 0970a30..3177066 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -117,6 +117,12 @@ static void parse_numa_node(MachineState *ms, NumaNo=
deOptions *node,
>      }
> =20
>      if (node->has_mem) {
> +        if (!mc->numa_mem_supported) {
> +            error_setg(errp, "Parameter -numa node,mem is not supported =
by this"
> +                      " machine type. Use -numa node,memdev instead");
> +            return;
> +        }
> +
>          numa_info[nodenr].node_mem =3D node->mem;
>          if (!qtest_enabled()) {
>              warn_report("Parameter -numa node,mem is deprecated,"
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 21b8290..fa8d024 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1947,7 +1947,6 @@ static void pc_machine_class_init(ObjectClass *oc, =
void *data)
>      hc->unplug =3D pc_machine_device_unplug_cb;
>      mc->default_cpu_type =3D TARGET_DEFAULT_CPU_TYPE;
>      mc->nvdimm_supported =3D true;
> -    mc->numa_mem_supported =3D true;
>      mc->default_ram_id =3D "pc.ram";
> =20
>      object_class_property_add(oc, PC_MACHINE_DEVMEM_REGION_SIZE, "int",
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index fa12203..0a9b9e0 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -435,6 +435,7 @@ static void pc_i440fx_4_2_machine_options(MachineClas=
s *m)
>      pc_i440fx_5_0_machine_options(m);
>      m->alias =3D NULL;
>      m->is_default =3D 0;
> +    m->numa_mem_supported =3D true;
>      compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len);
>      compat_props_add(m->compat_props, pc_compat_4_2, pc_compat_4_2_len);
>  }
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 84cf925..4d6e2be 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -363,6 +363,7 @@ static void pc_q35_4_2_machine_options(MachineClass *=
m)
>  {
>      pc_q35_5_0_machine_options(m);
>      m->alias =3D NULL;
> +    m->numa_mem_supported =3D true;
>      compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len);
>      compat_props_add(m->compat_props, pc_compat_4_2, pc_compat_4_2_len);
>  }
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index bcbe1f1..2686b73 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4383,7 +4383,6 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>       * in which LMBs are represented and hot-added
>       */
>      mc->numa_mem_align_shift =3D 28;
> -    mc->numa_mem_supported =3D true;
>      mc->auto_enable_numa =3D true;
> =20
>      smc->default_caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
> @@ -4465,6 +4464,7 @@ static void spapr_machine_4_2_class_options(Machine=
Class *mc)
>  {
>      spapr_machine_5_0_class_options(mc);
>      compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
> +    mc->numa_mem_supported =3D true;
>  }
> =20
>  DEFINE_SPAPR_MACHINE(4_2, "4.2", false);
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 982af95..17a0e1d 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -89,22 +89,6 @@ error in the future.
>  The @code{-realtime mlock=3Don|off} argument has been replaced by the
>  @code{-overcommit mem-lock=3Don|off} argument.
> =20
> -@subsection -numa node,mem=3D@var{size} (since 4.1)
> -
> -The parameter @option{mem} of @option{-numa node} is used to assign a pa=
rt of
> -guest RAM to a NUMA node. But when using it, it's impossible to manage s=
pecified
> -RAM chunk on the host side (like bind it to a host node, setting bind po=
licy, ...),
> -so guest end-ups with the fake NUMA configuration with suboptiomal perfo=
rmance.
> -However since 2014 there is an alternative way to assign RAM to a NUMA n=
ode
> -using parameter @option{memdev}, which does the same as @option{mem} and=
 adds
> -means to actualy manage node RAM on the host side. Use parameter @option=
{memdev}
> -with @var{memory-backend-ram} backend as an replacement for parameter @o=
ption{mem}
> -to achieve the same fake NUMA effect or a properly configured
> -@var{memory-backend-file} backend to actually benefit from NUMA configur=
ation.
> -In future new machine versions will not accept the option but it will st=
ill
> -work with old machine types. User can check QAPI schema to see if the le=
gacy
> -option is supported by looking at MachineInfo::numa-mem-supported proper=
ty.
> -
>  @subsection -numa node (without memory specified) (since 4.1)
> =20
>  Splitting RAM by default between NUMA nodes has the same issues as @opti=
on{mem}
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 709162c..55500bd 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -223,10 +223,10 @@ For example:
>  -numa cpu,node-id=3D0,socket-id=3D0 -numa cpu,node-id=3D1,socket-id=3D1
>  @end example
> =20
> -@samp{mem} assigns a given RAM amount to a node. @samp{memdev}
> -assigns RAM from a given memory backend device to a node. If
> -@samp{mem} and @samp{memdev} are omitted in all nodes, RAM is
> -split equally between them.
> +Legacy @samp{mem} assigns a given RAM amount to a node (not supported fo=
r 5.0
> +and newer machine types). @samp{memdev} assigns RAM from a given memory =
backend
> +device to a node. If @samp{mem} and @samp{memdev} are omitted in all nod=
es, RAM
> +is split equally between them.
> =20
>  @samp{mem} and @samp{memdev} are mutually exclusive. Furthermore,
>  if one node uses @samp{memdev}, all of them have to use it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--aC33ObtQAkNdOZ6b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4f6DgACgkQbDjKyiDZ
s5Jz8hAAtJSEA/OwyWMrBT+QIA/F59pEoz5a8yE9XHxuH8a8WAWR09q0KzMccEfc
p7YWtWa6UWDszHby+Y7Tj+UsRQ+gpixglKngmlOR6dP33J3HFrM2tM9p6CT7124x
bKGr5y5VwStsZWhk0lUncy6yRArEY5+wQfb4adLPM+AT+FN9mik2xnKLVPd7XlYp
bim0/WAPZ7TrUSNslZ+eUE98vuol2Y/tTQNsw5b6LpWktAcQnePEmh5zPJ/A4LsA
3YTShjc1agPi46hkJYv5XsxHZ33HPrM7bUmJ7eWbdrSf7+/Glx0mUVuWc7/kcVRe
BPNj75lRHlTyK8Eh3Saoq6LvQnQb5DJrXVuoSeWV/sLNPcK1P/2f7g2tYT+NbvIA
3ub9BlGVfJF1xsGbBYn+2GCjRMmf/ZY49IwoAvFdYPrESuiqG7wfeW+OJpOXWZvw
jVC4+2qCut99LXQ3p8DJERztIBH+ElfnnsjQJHe5oUaGvpyIgzkAxVbcuYKNBHcM
s2PXEQ1CwevdyvBcxyzoIfSq3fohayMD7rF1xy0RZP0iqff+nZ1E5kVyoiaoRTeH
9HoOzkcZNAjkTq3dlsNQFFO3KqS4dh7ME7QxAW87DDW1Mz5bLZJoaL71bicrlulx
WLY1QbxsZ+BFxesI/wUdwZg6/ZhqsW96iYGhdw20Vx3ZxJrkWY8=
=c4bQ
-----END PGP SIGNATURE-----

--aC33ObtQAkNdOZ6b--

