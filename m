Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA4CC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 10:44:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 663AD280AB
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 10:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 663AD280AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32961 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXkSD-0003ip-4N
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 06:44:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hXkRM-0003Oa-Bv
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 06:43:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hXkRL-0007Es-0H
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 06:43:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hXkRK-0007DH-Oi
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 06:43:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8C1113082E68;
	Mon,  3 Jun 2019 10:43:41 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-121-13.rdu2.redhat.com
	[10.10.121.13])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0BEC01001E69;
	Mon,  3 Jun 2019 10:43:34 +0000 (UTC)
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20190528204331.5280-1-kraxel@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <6068295f-5a36-5d16-8895-95385f0b44be@redhat.com>
Date: Mon, 3 Jun 2019 12:43:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190528204331.5280-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Mon, 03 Jun 2019 10:43:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] q35: fix mmconfig and PCI0._CRS
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/28/19 22:43, Gerd Hoffmann wrote:
> This patch changes the handling of the mmconfig area.  Thanks to the
> pci(e) expander devices we already have the logic to exclude address
> ranges from PCI0._CRS.  We can simply add the mmconfig address range
> to the list get it excluded as well.
>=20
> With that in place we can go with a fixed pci hole which covers the
> whole area from the end of (low) ram to the ioapic.
>=20
> This will make the whole logic alot less fragile.  No matter where the
> firmware places the mmconfig xbar, things should work correctly.  The
> guest also gets a bit more PCI address space (seabios boot):
>=20
>     # cat /proc/iomem
>     [ ... ]
>     7ffdd000-7fffffff : reserved
>     80000000-afffffff : PCI Bus 0000:00            <<-- this is new
>     b0000000-bfffffff : PCI MMCONFIG 0000 [bus 00-ff]
>       b0000000-bfffffff : reserved
>     c0000000-febfffff : PCI Bus 0000:00
>       f8000000-fbffffff : 0000:00:01.0
>     [ ... ]
>=20
> So this is a guest visible change.
>=20
> Cc: L=C3=A1szl=C3=B3 =C3=89rsek <lersek@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/i386/acpi-build.c | 14 ++++++++++++++
>  hw/pci-host/q35.c    | 31 ++++++++-----------------------
>  2 files changed, 22 insertions(+), 23 deletions(-)
>=20
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 0d78d738948c..abb0e0ce9f27 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -122,6 +122,8 @@ typedef struct FwCfgTPMConfig {
>      uint8_t tpmppi_version;
>  } QEMU_PACKED FwCfgTPMConfig;
> =20
> +static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg);
> +
>  static void init_common_fadt_data(Object *o, AcpiFadtData *data)
>  {
>      uint32_t io =3D object_property_get_uint(o, ACPI_PM_PROP_PM_IO_BAS=
E, NULL);
> @@ -1807,6 +1809,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker=
,
>      CrsRangeSet crs_range_set;
>      PCMachineState *pcms =3D PC_MACHINE(machine);
>      PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(machine);
> +    AcpiMcfgInfo mcfg;
>      uint32_t nr_mem =3D machine->ram_slots;
>      int root_bus_limit =3D 0xFF;
>      PCIBus *bus =3D NULL;
> @@ -1921,6 +1924,17 @@ build_dsdt(GArray *table_data, BIOSLinker *linke=
r,
>          }
>      }
> =20
> +    /*
> +     * At this point crs_range_set has all the ranges used by pci
> +     * busses *other* than PCI0.  These ranges will be excluded from
> +     * the PCI0._CRS.  Add mmconfig to the set so it will be excluded
> +     * too.
> +     */
> +    if (acpi_get_mcfg(&mcfg)) {
> +        crs_range_insert(crs_range_set.mem_ranges,
> +                         mcfg.base, mcfg.base + mcfg.size - 1);
> +    }
> +
>      scope =3D aml_scope("\\_SB.PCI0");
>      /* build PCI0._CRS */
>      crs =3D aml_resource_template();
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index 960939f5ed3e..72093320befe 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -258,15 +258,6 @@ static void q35_host_initfn(Object *obj)
>      object_property_add_link(obj, MCH_HOST_PROP_IO_MEM, TYPE_MEMORY_RE=
GION,
>                               (Object **) &s->mch.address_space_io,
>                               qdev_prop_allow_set_link_before_realize, =
0, NULL);
> -
> -    /* Leave enough space for the biggest MCFG BAR */
> -    /* TODO: this matches current bios behaviour, but
> -     * it's not a power of two, which means an MTRR
> -     * can't cover it exactly.
> -     */
> -    range_set_bounds(&s->mch.pci_hole,
> -            MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT + MCH_HOST_BRIDGE_PCIEXBA=
R_MAX,
> -            IO_APIC_DEFAULT_ADDRESS - 1);
>  }
> =20
>  static const TypeInfo q35_host_info =3D {
> @@ -338,20 +329,6 @@ static void mch_update_pciexbar(MCHPCIState *mch)
>      }
>      addr =3D pciexbar & addr_mask;
>      pcie_host_mmcfg_update(pehb, enable, addr, length);
> -    /* Leave enough space for the MCFG BAR */
> -    /*
> -     * TODO: this matches current bios behaviour, but it's not a power=
 of two,
> -     * which means an MTRR can't cover it exactly.
> -     */
> -    if (enable) {
> -        range_set_bounds(&mch->pci_hole,
> -                         addr + length,
> -                         IO_APIC_DEFAULT_ADDRESS - 1);
> -    } else {
> -        range_set_bounds(&mch->pci_hole,
> -                         MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT,
> -                         IO_APIC_DEFAULT_ADDRESS - 1);
> -    }
>  }
> =20
>  /* PAM */
> @@ -484,6 +461,14 @@ static void mch_update(MCHPCIState *mch)
>      mch_update_pam(mch);
>      mch_update_smram(mch);
>      mch_update_ext_tseg_mbytes(mch);
> +
> +    /*
> +     * pci hole goes from end-of-low-ram to io-apic.
> +     * mmconfig will be excluded by the dsdt builder.
> +     */
> +    range_set_bounds(&mch->pci_hole,
> +                     mch->below_4g_mem_size,
> +                     IO_APIC_DEFAULT_ADDRESS - 1);
>  }
> =20
>  static int mch_post_load(void *opaque, int version_id)
>=20

Looks plausible to me, but I've burned myself with this so frequently
that I'm not comfortable giving a formal feedback tag. I'll defer to
other reviewers (thankfully, there seem to be many, in this instance!)

One question: are we sure all guest OSes we care about can deal with
discontiguous 32-bit PCI MMIO aperture(s)? Personally, I've got no clue.
Is a "na=C3=AFve" OS imaginable that looks only at the first suitable ran=
ge
in the _CRS?

Thanks,
Laszlo

