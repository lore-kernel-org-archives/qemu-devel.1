Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E8CC2D0C9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 05:41:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 029122253D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 05:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="kW7q/l9r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 029122253D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifdhV-0000SC-3z
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 00:41:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51047)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ifdgG-0007dd-G4
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 00:40:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ifdgE-0004WZ-QN
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 00:40:00 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:45643 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ifdg9-0004HL-6R; Fri, 13 Dec 2019 00:39:53 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47YzyC6x1Yz9sPL; Fri, 13 Dec 2019 16:39:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576215587;
 bh=56eM89FTG1pvXviciouBwME2vyl4LJRakyHsbFicFXw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kW7q/l9rA2YfyK6wdsyyds/u3Yd01xGt3h2pnHPBDYewVEAh8AKG8/hDS6jk0qzT4
 CLphEkUbeeuJ8f0uNB8oiX/tmeHt6wMgnGEroQZBSxCjUFpt3VleLa/nY0wCB/Bwfs
 HsVGTXY24nJi20QByygqhDomwDdl2PKDFZyQTVOg=
Date: Fri, 13 Dec 2019 16:00:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: [RFC PATCH v2 1/5] hw: add compat machines for 5.0
Message-ID: <20191213050005.GC207300@umbus.fritz.box>
References: <20191212173320.11610-1-drjones@redhat.com>
 <20191212173320.11610-2-drjones@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="RyB1I56Pcq42iZjE"
Content-Disposition: inline
In-Reply-To: <20191212173320.11610-2-drjones@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: peter.maydell@linaro.org, Cornelia Huck <cohuck@redhat.com>,
 bijan.mottahedeh@oracle.com, "Michael S. Tsirkin" <mst@redhat.com>,
 maz@kernel.org, Richard Henderson <rth@twiddle.net>,
 David Hildenbrand <david@redhat.com>, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>, qemu-arm@nongnu.org,
 "open list:sPAPR" <qemu-ppc@nongnu.org>, guoheyi@huawei.com,
 Paolo Bonzini <pbonzini@redhat.com>, msys.mizuma@gmail.com,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--RyB1I56Pcq42iZjE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2019 at 06:33:16PM +0100, Andrew Jones wrote:
> Add 5.0 machine types for arm/i440fx/q35/s390x/spapr.
>=20
> Signed-off-by: Andrew Jones <drjones@redhat.com>

ppc parts
Acked-by: David Gibson <david@gibson.dropbear.id.au>

>=20
> ---
>=20
> Hi Eduardo,
>=20
> If we need to do something special for i440fx and q35, as
> 9aec2e52ce9d ("hw: add compat machines for 4.2") implies, then
> I'll need guidance as to what.
> ---
>  hw/arm/virt.c              |  9 ++++++++-
>  hw/core/machine.c          |  3 +++
>  hw/i386/pc.c               |  3 +++
>  hw/i386/pc_piix.c          | 14 +++++++++++++-
>  hw/i386/pc_q35.c           | 13 ++++++++++++-
>  hw/ppc/spapr.c             | 15 +++++++++++++--
>  hw/s390x/s390-virtio-ccw.c | 15 ++++++++++++++-
>  include/hw/boards.h        |  3 +++
>  include/hw/i386/pc.h       |  3 +++
>  9 files changed, 72 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index d4bedc260712..cb7041e9677a 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2147,10 +2147,17 @@ static void machvirt_machine_init(void)
>  }
>  type_init(machvirt_machine_init);
> =20
> +static void virt_machine_5_0_options(MachineClass *mc)
> +{
> +}
> +DEFINE_VIRT_MACHINE_AS_LATEST(5, 0)
> +
>  static void virt_machine_4_2_options(MachineClass *mc)
>  {
> +    virt_machine_5_0_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
>  }
> -DEFINE_VIRT_MACHINE_AS_LATEST(4, 2)
> +DEFINE_VIRT_MACHINE(4, 2)
> =20
>  static void virt_machine_4_1_options(MachineClass *mc)
>  {
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 1689ad3bf8af..21fe2d974817 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -27,6 +27,9 @@
>  #include "hw/pci/pci.h"
>  #include "hw/mem/nvdimm.h"
> =20
> +GlobalProperty hw_compat_4_2[] =3D {};
> +const size_t hw_compat_4_2_len =3D G_N_ELEMENTS(hw_compat_4_2);
> +
>  GlobalProperty hw_compat_4_1[] =3D {
>      { "virtio-pci", "x-pcie-flr-init", "off" },
>  };
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index ac08e6360437..58867f987d88 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -103,6 +103,9 @@
> =20
>  struct hpet_fw_config hpet_cfg =3D {.count =3D UINT8_MAX};
> =20
> +GlobalProperty pc_compat_4_2[] =3D {};
> +const size_t pc_compat_4_2_len =3D G_N_ELEMENTS(pc_compat_4_2);
> +
>  GlobalProperty pc_compat_4_1[] =3D {};
>  const size_t pc_compat_4_1_len =3D G_N_ELEMENTS(pc_compat_4_1);
> =20
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 1bd70d1abbc4..aa2c6147a7ea 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -424,7 +424,7 @@ static void pc_i440fx_machine_options(MachineClass *m)
>      machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
>  }
> =20
> -static void pc_i440fx_4_2_machine_options(MachineClass *m)
> +static void pc_i440fx_5_0_machine_options(MachineClass *m)
>  {
>      PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
>      pc_i440fx_machine_options(m);
> @@ -433,6 +433,18 @@ static void pc_i440fx_4_2_machine_options(MachineCla=
ss *m)
>      pcmc->default_cpu_version =3D 1;
>  }
> =20
> +DEFINE_I440FX_MACHINE(v5_0, "pc-i440fx-5.0", NULL,
> +                      pc_i440fx_5_0_machine_options)
> +
> +static void pc_i440fx_4_2_machine_options(MachineClass *m)
> +{
> +    pc_i440fx_5_0_machine_options(m);
> +    m->alias =3D NULL;
> +    m->is_default =3D 0;
> +    compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len);
> +    compat_props_add(m->compat_props, pc_compat_4_2, pc_compat_4_2_len);
> +}
> +
>  DEFINE_I440FX_MACHINE(v4_2, "pc-i440fx-4.2", NULL,
>                        pc_i440fx_4_2_machine_options);
> =20
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 385e5cffb167..ddd485d608c0 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -348,7 +348,7 @@ static void pc_q35_machine_options(MachineClass *m)
>      m->max_cpus =3D 288;
>  }
> =20
> -static void pc_q35_4_2_machine_options(MachineClass *m)
> +static void pc_q35_5_0_machine_options(MachineClass *m)
>  {
>      PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
>      pc_q35_machine_options(m);
> @@ -356,6 +356,17 @@ static void pc_q35_4_2_machine_options(MachineClass =
*m)
>      pcmc->default_cpu_version =3D 1;
>  }
> =20
> +DEFINE_Q35_MACHINE(v5_0, "pc-q35-5.0", NULL,
> +                   pc_q35_5_0_machine_options);
> +
> +static void pc_q35_4_2_machine_options(MachineClass *m)
> +{
> +    pc_q35_5_0_machine_options(m);
> +    m->alias =3D NULL;
> +    compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len);
> +    compat_props_add(m->compat_props, pc_compat_4_2, pc_compat_4_2_len);
> +}
> +
>  DEFINE_Q35_MACHINE(v4_2, "pc-q35-4.2", NULL,
>                     pc_q35_4_2_machine_options);
> =20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index e076f6023c73..3ae7db156303 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4491,15 +4491,26 @@ static const TypeInfo spapr_machine_info =3D {
>      }                                                                \
>      type_init(spapr_machine_register_##suffix)
> =20
> +/*
> + * pseries-5.0
> + */
> +static void spapr_machine_5_0_class_options(MachineClass *mc)
> +{
> +    /* Defaults for the latest behaviour inherited from the base class */
> +}
> +
> +DEFINE_SPAPR_MACHINE(5_0, "5.0", true);
> +
>  /*
>   * pseries-4.2
>   */
>  static void spapr_machine_4_2_class_options(MachineClass *mc)
>  {
> -    /* Defaults for the latest behaviour inherited from the base class */
> +    spapr_machine_5_0_class_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
>  }
> =20
> -DEFINE_SPAPR_MACHINE(4_2, "4.2", true);
> +DEFINE_SPAPR_MACHINE(4_2, "4.2", false);
> =20
>  /*
>   * pseries-4.1
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index d3edeef0ad92..a40f79e20733 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -639,14 +639,27 @@ bool css_migration_enabled(void)
>      }                                                                   =
      \
>      type_init(ccw_machine_register_##suffix)
> =20
> +
> +static void ccw_machine_5_0_instance_options(MachineState *machine)
> +{
> +}
> +
> +static void ccw_machine_5_0_class_options(MachineClass *mc)
> +{
> +}
> +DEFINE_CCW_MACHINE(5_0, "5.0", true);
> +
>  static void ccw_machine_4_2_instance_options(MachineState *machine)
>  {
> +    ccw_machine_5_0_instance_options(machine);
>  }
> =20
>  static void ccw_machine_4_2_class_options(MachineClass *mc)
>  {
> +    ccw_machine_5_0_class_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
>  }
> -DEFINE_CCW_MACHINE(4_2, "4.2", true);
> +DEFINE_CCW_MACHINE(4_2, "4.2", false);
> =20
>  static void ccw_machine_4_1_instance_options(MachineState *machine)
>  {
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index de45087f34cb..24cbeecbaecc 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -329,6 +329,9 @@ struct MachineState {
>      } \
>      type_init(machine_initfn##_register_types)
> =20
> +extern GlobalProperty hw_compat_4_2[];
> +extern const size_t hw_compat_4_2_len;
> +
>  extern GlobalProperty hw_compat_4_1[];
>  extern const size_t hw_compat_4_1_len;
> =20
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 1f86eba3f998..61a998de4665 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -237,6 +237,9 @@ void pc_system_firmware_init(PCMachineState *pcms, Me=
moryRegion *rom_memory);
>  void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
>                         const CPUArchIdList *apic_ids, GArray *entry);
> =20
> +extern GlobalProperty pc_compat_4_2[];
> +extern const size_t pc_compat_4_2_len;
> +
>  extern GlobalProperty pc_compat_4_1[];
>  extern const size_t pc_compat_4_1_len;
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--RyB1I56Pcq42iZjE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3zGtIACgkQbDjKyiDZ
s5KuqhAAxyf7RGKynjk1H4vgjIrPaU6rDarsH7A7JCFgTbHxQq0dkl3dW3Z1kY2Q
3nDOC3Fks9MWBQTzk/Vz8kdzT5Y1C7eihSbAE1G91IU0nAu7oFXc7w/t27+QHGf8
2Ll1DNoo1L5i/9GwOp3S+sxVpL2aba8TAuyW5eOHkSLiPXRz1ohuB+8lKomAf+/c
JJMZBX0qa41/1zDPEAqvKAb/jSBkBtmPyqmu7v4ZSnkweTxQ+y2UjYUNKS+cAwHh
WP6QAWMdoaOCSjiwaPBjw5l101TlcH0WX9YbkuengjvbMrIlLQEkwXxft+8mK2AW
RrVttCBHRVf0KITA1Wi8viz2ElrHOA4BCzOq90BkT+GV30HEAWrzIRYuVs7CDZ9/
X6CQW0pXz5W4iLPXvIT9ciER4AeuFWUQZqG6C/CiXWiXYzUEASmS8XrQG70jrZ47
89QxdUgxkKLtRleiD80wCdk2YdzAgTRwbqmBW9gyfjg8cUmseq+CjrZaMnNoJgvr
+5Jjy937JzFiEJzrX9Rn1SJhDDJ2M+OztQMK7aYiBeusBn54B6Y70Kp5eonoi9Vd
NMgZdzyX0hUn2oTiLWuD6KLMV6dD+vpJNqGnJGG20vtltcb3L6h2p0ZGUWwXM+Vc
0RqP0Vbh3wUm9fhaZPPob3O5LDHvRludpw+wHdPPKmy8uBi/+88=
=QmEN
-----END PGP SIGNATURE-----

--RyB1I56Pcq42iZjE--

