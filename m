Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CD0C76192
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 00:05:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6F9D21851
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 00:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bV8rrW2+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F9D21851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnXRs-00053a-Ti
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 20:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42330)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hnXRX-0003um-TH
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 20:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hnXRW-0001mL-HM
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 20:05:11 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:43277 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hnXRV-0001gg-S9; Tue, 16 Jul 2019 20:05:10 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45pHZm1XnTz9sLt; Wed, 17 Jul 2019 10:05:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563321904;
 bh=7QxQXjF+/3q0javjafvFC/nu6B8dq0jO6IHBh8vGtwQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bV8rrW2+YAQfyjWffWBb5I3VRRjmqQbnoT/ud6szj19q2+9cak97AKQ4qjq1fxlj1
 szL3nJOi5Vb/4XfNlrCunm3wttP5TaRou0MOcWgMioMZPCOjUUhZY5W8/0n6kX8icE
 WCR5PoWvUnkCE8IZMJnKbFAnZHgMQxj6nrQEjDpM=
Date: Tue, 16 Jul 2019 19:16:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Message-ID: <20190716091649.GJ7525@umbus.fritz.box>
References: <156326547324.51324.17260886524634041718.stgit@lep8c.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UlxN1C6awaFNesUv"
Content-Disposition: inline
In-Reply-To: <156326547324.51324.17260886524634041718.stgit@lep8c.aus.stglabs.ibm.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH] ppc: Fix some memory leaks
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--UlxN1C6awaFNesUv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2019 at 03:24:57AM -0500, Shivaprasad G Bhat wrote:
> valgrind showed some memory leaks while running qemu-system-ppc64.
> Fixing them in this patch.
>=20
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>

Applied, thanks.

> ---
>  hw/ppc/spapr_caps.c  |    2 ++
>  hw/ppc/spapr_drc.c   |    5 ++++-
>  hw/ppc/spapr_hcall.c |    2 ++
>  target/ppc/kvm.c     |    3 ++-
>  4 files changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index bbb001f84a..8e3350f777 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -786,11 +786,13 @@ void spapr_caps_add_properties(SpaprMachineClass *s=
mc, Error **errp)
>                                    NULL, cap, &local_err);
>          if (local_err) {
>              error_propagate(errp, local_err);
> +            g_free((char *)name);
>              return;
>          }
> =20
>          desc =3D g_strdup_printf("%s", cap->description);
>          object_class_property_set_description(klass, name, desc, &local_=
err);
> +        g_free((char *)name);
>          g_free(desc);
>          if (local_err) {
>              error_propagate(errp, local_err);
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index bacadfcac5..37fbfe6900 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -827,6 +827,7 @@ int spapr_dt_drc(void *fdt, int offset, Object *owner=
, uint32_t drc_type_mask)
>          Object *obj;
>          SpaprDrc *drc;
>          SpaprDrcClass *drck;
> +        const char *drc_name =3D NULL;
>          uint32_t drc_index, drc_power_domain;
> =20
>          if (!strstart(prop->type, "link<", NULL)) {
> @@ -856,8 +857,10 @@ int spapr_dt_drc(void *fdt, int offset, Object *owne=
r, uint32_t drc_type_mask)
>          g_array_append_val(drc_power_domains, drc_power_domain);
> =20
>          /* ibm,drc-names */
> -        drc_names =3D g_string_append(drc_names, spapr_drc_name(drc));
> +        drc_name =3D spapr_drc_name(drc);
> +        drc_names =3D g_string_append(drc_names, drc_name);
>          drc_names =3D g_string_insert_len(drc_names, -1, "\0", 1);
> +        g_free((char *)drc_name);
> =20
>          /* ibm,drc-types */
>          drc_types =3D g_string_append(drc_types, drck->typename);
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 6808d4cda8..0fc58156a0 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1612,6 +1612,7 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
>      ov5_updates =3D spapr_ovec_new();
>      spapr->cas_reboot =3D spapr_ovec_diff(ov5_updates,
>                                          ov5_cas_old, spapr->ov5_cas);
> +    spapr_ovec_cleanup(ov5_cas_old);
>      /* Now that processing is finished, set the radix/hash bit for the
>       * guest if it requested a valid mode; otherwise terminate the boot.=
 */
>      if (guest_radix) {
> @@ -1640,6 +1641,7 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
>              (spapr_h_cas_compose_response(spapr, args[1], args[2],
>                                            ov5_updates) !=3D 0);
>      }
> +    spapr_ovec_cleanup(ov1_guest);
> =20
>      /*
>       * Ensure the guest asks for an interrupt mode we support; otherwise
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 8a06d3171e..498ca6d53b 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -491,7 +491,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          return ret;
>      }
> =20
> -    idle_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, kvm_kick_cpu, cpu);
> +    if (!idle_timer)
> +        idle_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, kvm_kick_cpu, cp=
u);
> =20
>      switch (cenv->mmu_model) {
>      case POWERPC_MMU_BOOKE206:
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--UlxN1C6awaFNesUv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0tlf8ACgkQbDjKyiDZ
s5I7YhAAruYZWc/MxVerdEog9KMNw+2aHhn9jSguf9qgZNvQoGKG29kiKVLQZ8Pa
dyUzYHP0IDDKZ/1ru+5WD9FuOUcacorU4YiUweytRyLMXlQSY71SysZS28Rm4zEu
y0innztZF/QUdUK8+9C3U+dJQ7pDKz749v4DN6VlVvbTqdtlp1oVRYBMoourTbNY
ncgdTY/sIhidwdhX3DiBvBXDbQl2SlikjlCBHQrq9GtXz93y6SKwpCsyPAWeejZK
+BGzg7iSrQEgW9AVQ2dqC6CfkNeaOObcSEOO0h+1zsYOpHoQiMK1vav2AaZKxcfQ
+bD382PufJTDBEGPjtH1L8RKZ/7XMP4y3M5mfdh8KtHQJ1zHPecoAIJGjnFS79zP
EH0Wp3jcHK0T0upc+72+wmEmbQZSGOxJYefDRJCCMeB/is0XCQAQQv68sot6oyeD
OWsbodSdy6FDC0yhgd264CjjakKuKhv9mIrtxSyUMaS66pxlii9kW1R8lD92/1CS
FzrIJVicBybWIqcQ+xSYpoSq1I+Y8SO4VgrN9QBhc7ITNZyaL3dDjQiDDt/Gh/VU
YZxYPNfzT73zQCocnCys/F/1JxgU4xx48yECeublBptFGJPoLlyMRoU/c7v0jyqw
v64WJ/MwjycXbgeRPu5YTN/T1UreZu0Zp9ZOVWIh40NFFZww0T4=
=Iv6r
-----END PGP SIGNATURE-----

--UlxN1C6awaFNesUv--

