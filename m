Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8496C282DC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 23:24:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 716A120881
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 23:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="aBTYO0gf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 716A120881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54238 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTaaw-0000on-NU
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 19:24:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hTaZf-0008Vv-7I
	for qemu-devel@nongnu.org; Wed, 22 May 2019 19:23:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hTaZd-0008C2-Ks
	for qemu-devel@nongnu.org; Wed, 22 May 2019 19:23:07 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:52509)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hTaZc-00087o-1F; Wed, 22 May 2019 19:23:05 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 458TFS1C3Xz9s55; Thu, 23 May 2019 09:22:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1558567372;
	bh=PjPC6RIQzDJI8kUZMROtJu3SmJU4jI4sarUe22Aae6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aBTYO0gfmUx61juZ2aPdwwSNpg7uuRYabv2IaXa0ytXVDDCgegIhxq8JIHh+4zqRU
	gDaPerdKpbyZ05tGpYlWAK/T1PaY0vNfWcjYDDLbfVFz9Rs83XXnC+/F6IsTIENrlV
	e5tssjzJ+nqSG6P3tFFfos9phIqfSZc4+3Rv3Aw8=
Date: Thu, 23 May 2019 09:22:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190522232246.GL30423@umbus.fritz.box>
References: <155853262675.1158324.17301777846476373459.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="64LDleNqNegJ4g97"
Content-Disposition: inline
In-Reply-To: <155853262675.1158324.17301777846476373459.stgit@bahia.lan>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH] spapr: Don't migrate the hpt_maxpagesize
 cap to older machine types
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--64LDleNqNegJ4g97
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2019 at 03:43:46PM +0200, Greg Kurz wrote:
> Commit 0b8c89be7f7b added the hpt_maxpagesize capability to the migration
> stream. This is okay for new machine types but it breaks backward migrati=
on
> to older QEMUs, which don't expect the extra subsection.
>=20
> Add a compatibility boolean flag to the sPAPR machine class and use it to
> skip migration of the capability for machine types 4.0 and older. This
> fixes migration to an older QEMU. Note that the destination will emit a
> warning:
>=20
> qemu-system-ppc64: warning: cap-hpt-max-page-size lower level (16) in inc=
oming stream than on destination (24)
>=20
> This is expected and harmless though. It is okay to migrate from a lower
> HPT maximum page size (64k) to a greater one (16M).
>=20
> Fixes: 0b8c89be7f7b "spapr: Add forgotten capability to migration stream"
> Based-on: <20190522074016.10521-3-clg@kaod.org>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

> ---
>=20
> Please notice that this is based on Cedric's patch that make "dual" the
> default for the ic-mode property.
> ---
>  hw/ppc/spapr.c         |    1 +
>  hw/ppc/spapr_caps.c    |   12 +++++++++++-
>  include/hw/ppc/spapr.h |    1 +
>  3 files changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 4fd16b43f014..e2b33e5890ae 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4431,6 +4431,7 @@ static void spapr_machine_4_0_class_options(Machine=
Class *mc)
>      compat_props_add(mc->compat_props, hw_compat_4_0, hw_compat_4_0_len);
>      smc->phb_placement =3D phb_placement_4_0;
>      smc->irq =3D &spapr_irq_xics;
> +    smc->pre_4_1_migration =3D true;
>  }
> =20
>  DEFINE_SPAPR_MACHINE(4_0, "4.0", false);
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 658eb15a147b..31b466139975 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -64,6 +64,7 @@ typedef struct SpaprCapabilityInfo {
>      void (*apply)(SpaprMachineState *spapr, uint8_t val, Error **errp);
>      void (*cpu_apply)(SpaprMachineState *spapr, PowerPCCPU *cpu,
>                        uint8_t val, Error **errp);
> +    bool (*migrate_needed)(void *opaque);
>  } SpaprCapabilityInfo;
> =20
>  static void spapr_cap_get_bool(Object *obj, Visitor *v, const char *name,
> @@ -350,6 +351,11 @@ static void cap_hpt_maxpagesize_apply(SpaprMachineSt=
ate *spapr,
>      spapr_check_pagesize(spapr, qemu_minrampagesize(), errp);
>  }
> =20
> +static bool cap_hpt_maxpagesize_migrate_needed(void *opaque)
> +{
> +    return !SPAPR_MACHINE_GET_CLASS(opaque)->pre_4_1_migration;
> +}
> +
>  static bool spapr_pagesize_cb(void *opaque, uint32_t seg_pshift,
>                                uint32_t pshift)
>  {
> @@ -542,6 +548,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =
=3D {
>          .type =3D "int",
>          .apply =3D cap_hpt_maxpagesize_apply,
>          .cpu_apply =3D cap_hpt_maxpagesize_cpu_apply,
> +        .migrate_needed =3D cap_hpt_maxpagesize_migrate_needed,
>      },
>      [SPAPR_CAP_NESTED_KVM_HV] =3D {
>          .name =3D "nested-hv",
> @@ -679,8 +686,11 @@ int spapr_caps_post_migration(SpaprMachineState *spa=
pr)
>  static bool spapr_cap_##sname##_needed(void *opaque)    \
>  {                                                       \
>      SpaprMachineState *spapr =3D opaque;                  \
> +    bool (*needed)(void *opaque) =3D                      \
> +        capability_table[cap].migrate_needed;           \
>                                                          \
> -    return spapr->cmd_line_caps[cap] &&                 \
> +    return needed ? needed(opaque) : true &&            \
> +           spapr->cmd_line_caps[cap] &&                 \
>             (spapr->eff.caps[cap] !=3D                     \
>              spapr->def.caps[cap]);                      \
>  }                                                       \
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 9fc91c8f5eac..4f5becf1f3cc 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -119,6 +119,7 @@ struct SpaprMachineClass {
>      bool pre_2_10_has_unused_icps;
>      bool legacy_irq_allocation;
>      bool broken_host_serial_model; /* present real host info to the gues=
t */
> +    bool pre_4_1_migration; /* don't migrate hpt-max-page-size */
> =20
>      void (*phb_placement)(SpaprMachineState *spapr, uint32_t index,
>                            uint64_t *buid, hwaddr *pio,=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--64LDleNqNegJ4g97
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzl2cYACgkQbDjKyiDZ
s5KJAxAAjM204OghP6IdgleKCAtZKd6pkkbfeq0kcr3pbSrFp98zFYoA/281l6/h
EbhA5zd4d3hQ23pkLzK28peO8SdJOlxxi7WRwFerOWkRpl2Eb4N2t+IP3Oso04Lr
uM9djdA/RSIg5CS7jFmumRzdphi4SLyU4bGliKlpKaMIwBtzEAmhCVNarJLOt5JO
ALXP+68HomcGhp8BCYiSn9D/zaOlk7/ak2xg820vCagY/x1WNBPYITZqO/8xVRGx
XXjcuwpOMqYIJJcP09ywzjFs9K6I+I+Bvja0H3OvONHmFEkw+v7lxB8gdC+NqEyW
8/Am6WmOiFTL9SdK4jeltBlwghMV0YCy4KoR39CjXR3NJpN+Ea4DYHdvb9CZNqL0
TitOu6A1D0K3LRgB+AAJTQ7uzU16sSQM2hBDIXqXP9/Zjfmi4edI+DfGIQQxI/6m
nfXDrQvRT3nW+zeFW725IjCSFW04A+gqdYC9JTEY19EjGlbmpC7g0NGyuC1wBYf9
EeFrXMZIY++Rg+jm0FiZmEINsYoJvXdPxT1xIxLBPoOskzaoGWisPcI4SNv/mVv1
F+Y1JzQyqHRz5AZWaxIXEUWPbX/i/CpCYtYi5rvtXCMl6oUw6syS15zJnouRJyT3
xpgqb2gJuxsvpQBMC26Yuyp+HsCNkbb0GnbZvrOXhnmGW+ttADw=
=cG7w
-----END PGP SIGNATURE-----

--64LDleNqNegJ4g97--

