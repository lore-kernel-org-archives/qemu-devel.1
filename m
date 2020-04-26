Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989E2C55186
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 01:51:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 620B3206DD
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 01:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="CQ+i8pE3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 620B3206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSWSP-00070h-II
	for qemu-devel@archiver.kernel.org; Sat, 25 Apr 2020 21:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jSWRh-00068m-G7
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 21:51:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jSWRg-0005So-UC
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 21:51:01 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:45635 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jSWRb-0003cf-7b; Sat, 25 Apr 2020 21:50:56 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 498rTZ39NNz9sSd; Sun, 26 Apr 2020 11:50:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1587865842;
 bh=jcrtSqWfwSyI1uHbyiBdio1ngK0mM82wIqUWoHCmh+g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CQ+i8pE38/klh/MW2DVdjeg3lCihYOI3KIhBpRzFtVsj0K29DWUJzIPURDQeOE1Dz
 XQ9S45VehOzCVcY+e1/N9rvg3QezjQiQLM3xUhmXJNty76eccM+aqQWuTfi/2k9DPZ
 aAH9piDh/ExIvUJdXTATNaFLAw4TThKhN34YJIfI=
Date: Sun, 26 Apr 2020 10:59:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] hw: add compat machines for 5.1
Message-ID: <20200426005915.GA13332@umbus.fritz.box>
References: <20200424090314.544-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <20200424090314.544-1-cohuck@redhat.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/25 21:50:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2020 at 11:03:14AM +0200, Cornelia Huck wrote:
> Add 5.1 machine types for arm/i440fx/q35/s390x/spapr.
>=20
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>=20
> Still keeping the default cpu model version on x86 at v1.
>=20
> I'll queue this to my s390-next branch, as I'm planning to send a pull
> req as soon as 5.0 is out; if someone else wants to queue this, we'll
> figure it out :)
>=20
> ---
>  hw/arm/virt.c              |  9 ++++++++-
>  hw/core/machine.c          |  3 +++
>  hw/i386/pc.c               |  3 +++
>  hw/i386/pc_piix.c          | 14 +++++++++++++-
>  hw/i386/pc_q35.c           | 13 ++++++++++++-
>  hw/ppc/spapr.c             | 15 +++++++++++++--
>  hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
>  include/hw/boards.h        |  3 +++
>  include/hw/i386/pc.h       |  3 +++
>  9 files changed, 71 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 7dc96abf72cf..5e84c09402dd 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2309,15 +2309,22 @@ static void machvirt_machine_init(void)
>  }
>  type_init(machvirt_machine_init);
> =20
> +static void virt_machine_5_1_options(MachineClass *mc)
> +{
> +}
> +DEFINE_VIRT_MACHINE_AS_LATEST(5, 1)
> +
>  static void virt_machine_5_0_options(MachineClass *mc)
>  {
>      static GlobalProperty compat[] =3D {
>          { TYPE_TPM_TIS_SYSBUS, "ppi", "false" },
>      };
> =20
> +    virt_machine_5_1_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_5_0, hw_compat_5_0_len);
>      compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
>  }
> -DEFINE_VIRT_MACHINE_AS_LATEST(5, 0)
> +DEFINE_VIRT_MACHINE(5, 0)
> =20
>  static void virt_machine_4_2_options(MachineClass *mc)
>  {
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index c1a444cb7558..7a50dd518f4c 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -28,6 +28,9 @@
>  #include "hw/mem/nvdimm.h"
>  #include "migration/vmstate.h"
> =20
> +GlobalProperty hw_compat_5_0[] =3D {};
> +const size_t hw_compat_5_0_len =3D G_N_ELEMENTS(hw_compat_5_0);
> +
>  GlobalProperty hw_compat_4_2[] =3D {
>      { "virtio-blk-device", "queue-size", "128"},
>      { "virtio-scsi-device", "virtqueue_size", "128"},
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 5143c516531e..13e1d18cd758 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -94,6 +94,9 @@
>  #include "fw_cfg.h"
>  #include "trace.h"
> =20
> +GlobalProperty pc_compat_5_0[] =3D {};
> +const size_t pc_compat_5_0_len =3D G_N_ELEMENTS(pc_compat_5_0);
> +
>  GlobalProperty pc_compat_4_2[] =3D {
>      { "mch", "smbase-smram", "off" },
>  };
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 22dee0e76c62..921caa502b85 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -419,7 +419,7 @@ static void pc_i440fx_machine_options(MachineClass *m)
>      machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
>  }
> =20
> -static void pc_i440fx_5_0_machine_options(MachineClass *m)
> +static void pc_i440fx_5_1_machine_options(MachineClass *m)
>  {
>      PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
>      pc_i440fx_machine_options(m);
> @@ -428,6 +428,18 @@ static void pc_i440fx_5_0_machine_options(MachineCla=
ss *m)
>      pcmc->default_cpu_version =3D 1;
>  }
> =20
> +DEFINE_I440FX_MACHINE(v5_1, "pc-i440fx-5.1", NULL,
> +                      pc_i440fx_5_1_machine_options);
> +
> +static void pc_i440fx_5_0_machine_options(MachineClass *m)
> +{
> +    pc_i440fx_5_1_machine_options(m);
> +    m->alias =3D NULL;
> +    m->is_default =3D false;
> +    compat_props_add(m->compat_props, hw_compat_5_0, hw_compat_5_0_len);
> +    compat_props_add(m->compat_props, pc_compat_5_0, pc_compat_5_0_len);
> +}
> +
>  DEFINE_I440FX_MACHINE(v5_0, "pc-i440fx-5.0", NULL,
>                        pc_i440fx_5_0_machine_options);
> =20
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index d37c425e2236..253688a9b8f3 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -349,7 +349,7 @@ static void pc_q35_machine_options(MachineClass *m)
>      m->max_cpus =3D 288;
>  }
> =20
> -static void pc_q35_5_0_machine_options(MachineClass *m)
> +static void pc_q35_5_1_machine_options(MachineClass *m)
>  {
>      PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
>      pc_q35_machine_options(m);
> @@ -357,6 +357,17 @@ static void pc_q35_5_0_machine_options(MachineClass =
*m)
>      pcmc->default_cpu_version =3D 1;
>  }
> =20
> +DEFINE_Q35_MACHINE(v5_1, "pc-q35-5.1", NULL,
> +                   pc_q35_5_1_machine_options);
> +
> +static void pc_q35_5_0_machine_options(MachineClass *m)
> +{
> +    pc_q35_5_1_machine_options(m);
> +    m->alias =3D NULL;
> +    compat_props_add(m->compat_props, hw_compat_5_0, hw_compat_5_0_len);
> +    compat_props_add(m->compat_props, pc_compat_5_0, pc_compat_5_0_len);
> +}
> +
>  DEFINE_Q35_MACHINE(v5_0, "pc-q35-5.0", NULL,
>                     pc_q35_5_0_machine_options);
> =20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 9a2bd501aa6e..fd5bfd11a84c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4599,15 +4599,26 @@ static void spapr_machine_latest_class_options(Ma=
chineClass *mc)
>      }                                                                \
>      type_init(spapr_machine_register_##suffix)
> =20
> +/*
> + * pseries-5.1
> + */
> +static void spapr_machine_5_1_class_options(MachineClass *mc)
> +{
> +    /* Defaults for the latest behaviour inherited from the base class */
> +}
> +
> +DEFINE_SPAPR_MACHINE(5_1, "5.1", true);
> +
>  /*
>   * pseries-5.0
>   */
>  static void spapr_machine_5_0_class_options(MachineClass *mc)
>  {
> -    /* Defaults for the latest behaviour inherited from the base class */
> +    spapr_machine_5_1_class_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_5_0, hw_compat_5_0_len);
>  }
> =20
> -DEFINE_SPAPR_MACHINE(5_0, "5.0", true);
> +DEFINE_SPAPR_MACHINE(5_0, "5.0", false);
> =20
>  /*
>   * pseries-4.2
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 0fa00a9fff3d..967a6de9683b 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -672,14 +672,26 @@ bool css_migration_enabled(void)
>      }                                                                   =
      \
>      type_init(ccw_machine_register_##suffix)
> =20
> +static void ccw_machine_5_1_instance_options(MachineState *machine)
> +{
> +}
> +
> +static void ccw_machine_5_1_class_options(MachineClass *mc)
> +{
> +}
> +DEFINE_CCW_MACHINE(5_1, "5.1", true);
> +
>  static void ccw_machine_5_0_instance_options(MachineState *machine)
>  {
> +    ccw_machine_5_1_instance_options(machine);
>  }
> =20
>  static void ccw_machine_5_0_class_options(MachineClass *mc)
>  {
> +    ccw_machine_5_1_class_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_5_0, hw_compat_5_0_len);
>  }
> -DEFINE_CCW_MACHINE(5_0, "5.0", true);
> +DEFINE_CCW_MACHINE(5_0, "5.0", false);
> =20
>  static void ccw_machine_4_2_instance_options(MachineState *machine)
>  {
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index fd4d62b5010f..18815d9be24f 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -318,6 +318,9 @@ struct MachineState {
>      } \
>      type_init(machine_initfn##_register_types)
> =20
> +extern GlobalProperty hw_compat_5_0[];
> +extern const size_t hw_compat_5_0_len;
> +
>  extern GlobalProperty hw_compat_4_2[];
>  extern const size_t hw_compat_4_2_len;
> =20
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 6ab6eda046fd..15b9294dac38 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -204,6 +204,9 @@ void pc_system_firmware_init(PCMachineState *pcms, Me=
moryRegion *rom_memory);
>  void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
>                         const CPUArchIdList *apic_ids, GArray *entry);
> =20
> +extern GlobalProperty pc_compat_5_0[];
> +extern const size_t pc_compat_5_0_len;
> +
>  extern GlobalProperty pc_compat_4_2[];
>  extern const size_t pc_compat_4_2_len;
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6k3OAACgkQbDjKyiDZ
s5JkzBAAiqN2qujfRs00xUvk3cL2MzF5MpDJF448Dfn16FK29dhT5jU7g+OdAWZu
6Y1ZJdA59q/RTkSkTLRR5AiMZgvIziJsJlqBz6d3lwWE069BEO6GdsJ5shJfzUQ5
ajcukCLtKFuVRoXc6uy/6Mn+ZcgDs4AJkk+3xdBrhjBXoU74PdG9R/QHWb1IcFDa
k0/MU2cCSn7hlelctW3ce0pchtjD6j7y77d2oaN1xSwex1faTpBmhExAMiiCt7la
P0S6NmG20YSI8WA0qk83Y8JqVvHfTn/jZuQQWHKrKldXT6ifP7d66L7tVOtJgkHT
+ZPWSZ85FnhVrbEKqcY7qgVjNvS2d/OyP72GPSISMDXtmRu8i1MPu66GUVN2Z50O
1suxsxCePtUbXYtOWwgnArCDC7HBmJ9YwwhwaSOgRhJblro8OlWKUgOy/20Um26/
P9gcB3ziJuptBJBEFOZuORPDNzgMeqFrSlRNwvVg952gv916coYfuLy0gcNiCqW0
hsGjrMr78/Cp2NolJp2/jmnhoAkWGsk47aBvUh8Djb0OAQBG1lN97aaBf489QtvX
L6CFomeHbV8VToUrbZlmGBOwGIU67T5l7KEmVUhJkweW8kVlO54KjIcuhR1lBqM5
NZcYmmwYiFjQBNRLFIJRU6qbHJ6LJEDj8SNu/DHvJcIVDbpm2xI=
=YBI4
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--

