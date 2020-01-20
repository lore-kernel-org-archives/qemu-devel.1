Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC021C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 15:34:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E17D21D7E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 15:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E17D21D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itZ4n-0007x6-G8
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 10:34:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1itZ40-00077g-2Q
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 10:34:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1itZ3v-0000b1-IH
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 10:34:03 -0500
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:41390)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1itZ3v-0000aE-BL
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 10:33:59 -0500
Received: from player699.ha.ovh.net (unknown [10.109.143.3])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id CD9FF1BEF27
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 16:33:56 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player699.ha.ovh.net (Postfix) with ESMTPSA id 467F2E6636D9;
 Mon, 20 Jan 2020 15:33:50 +0000 (UTC)
Subject: Re: [PATCH v3 07/84] hw/arm/aspeed: actually check RAM size
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <83481ccb-38e4-d0a2-18b5-66fcd7248521@kaod.org>
 <1579530112-80542-1-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e124b5be-42ec-03c2-10ee-874b966a3e67@kaod.org>
Date: Mon, 20 Jan 2020 16:33:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1579530112-80542-1-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 14439666306392361904
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudeigddugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieelledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.53.149
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
Cc: andrew@aj.id.au, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/20/20 3:21 PM, Igor Mammedov wrote:
> It's supposed that SOC will check if "-m" provided
> RAM size is valid by setting "ram-size" property and
> then board would read back valid (possibly corrected
> value) to map RAM MemoryReging with valid size.
> It isn't doing so, since check is called only
> indirectly from
>   aspeed_sdmc_reset()->asc->compute_conf()
> or much later when guest writes to configuration
> register.
>=20
> So depending on "-m" value QEMU end-ups with a warning
> and an invalid MemoryRegion size allocated and mapped.
> (examples:
>  -M ast2500-evb -m 1M
>     0000000080000000-000000017ffffffe (prio 0, i/o): aspeed-ram-contain=
er
>       0000000080000000-00000000800fffff (prio 0, ram): ram
>       0000000080100000-00000000bfffffff (prio 0, i/o): max_ram
>  -M ast2500-evb -m 3G
>     0000000080000000-000000017ffffffe (prio 0, i/o): aspeed-ram-contain=
er
>       0000000080000000-000000013fffffff (prio 0, ram): ram
>       [DETECTED OVERFLOW!] 0000000140000000-00000000bfffffff (prio 0, i=
/o): max_ram
> )
> On top of that sdmc falls back and reports to guest
> "default" size, it thinks machine should have.
>=20
> This patch makes ram-size check actually work and
> changes behavior from a warning later on during
> machine reset to error_fatal at the moment SOC.ram-size
> is set so user will have to fix RAM size on CLI
> to start machine.
>=20
> It also gets out of the way mutable ram-size logic,
> so we could consolidate RAM allocation logic around
> pre-allocated hostmem backend (supplied by user or
> auto created by generic machine code depending on
> supplied -m/mem-path/mem-prealloc options.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

LGTM, some comments below.

> ---
> v3:
>   * replace
>      [PATCH v2 07/86] arm:aspeed: convert valid RAM sizes to data
>      [PATCH v2 08/86] arm:aspeed: actually check RAM size
>     with a simplified variant that adds ram_size check to sdmc.ram-size
>     property
>=20
> CC: clg@kaod.org
> CC: peter.maydell@linaro.org
> CC: andrew@aj.id.au
> CC: joel@jms.id.au
> CC: qemu-arm@nongnu.org
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  include/hw/misc/aspeed_sdmc.h |  1 +
>  hw/arm/aspeed.c               | 13 +++-----
>  hw/misc/aspeed_sdmc.c         | 77 +++++++++++++++++++++++++++++++++++=
--------
>  3 files changed, 70 insertions(+), 21 deletions(-)
>=20
> diff --git a/include/hw/misc/aspeed_sdmc.h b/include/hw/misc/aspeed_sdm=
c.h
> index 5dbde59..cea1e67 100644
> --- a/include/hw/misc/aspeed_sdmc.h
> +++ b/include/hw/misc/aspeed_sdmc.h
> @@ -40,6 +40,7 @@ typedef struct AspeedSDMCClass {
>      SysBusDeviceClass parent_class;
> =20
>      uint64_t max_ram_size;
> +    const uint64_t *valid_ram_sizes;
>      uint32_t (*compute_conf)(AspeedSDMCState *s, uint32_t data);
>      void (*write)(AspeedSDMCState *s, uint32_t reg, uint32_t data);
>  } AspeedSDMCClass;
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index cc06af4..c8573e5 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -191,8 +191,12 @@ static void aspeed_machine_init(MachineState *mach=
ine)
> =20
>      sc =3D ASPEED_SOC_GET_CLASS(&bmc->soc);
> =20
> +    /*
> +     * This will error out if isize is not supported by memory control=
ler.
> +     */
>      object_property_set_uint(OBJECT(&bmc->soc), ram_size, "ram-size",
> -                             &error_abort);
> +                             &error_fatal);
> +
>      object_property_set_int(OBJECT(&bmc->soc), amc->hw_strap1, "hw-str=
ap1",
>                              &error_abort);
>      object_property_set_int(OBJECT(&bmc->soc), amc->hw_strap2, "hw-str=
ap2",
> @@ -215,13 +219,6 @@ static void aspeed_machine_init(MachineState *mach=
ine)
>      object_property_set_bool(OBJECT(&bmc->soc), true, "realized",
>                               &error_abort);
> =20
> -    /*
> -     * Allocate RAM after the memory controller has checked the size
> -     * was valid. If not, a default value is used.
> -     */
> -    ram_size =3D object_property_get_uint(OBJECT(&bmc->soc), "ram-size=
",
> -                                        &error_abort);
> -
>      memory_region_allocate_system_memory(&bmc->ram, NULL, "ram", ram_s=
ize);
>      memory_region_add_subregion(&bmc->ram_container, 0, &bmc->ram);
>      memory_region_add_subregion(get_system_memory(),
> diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
> index 2df3244..b36b362 100644
> --- a/hw/misc/aspeed_sdmc.c
> +++ b/hw/misc/aspeed_sdmc.c
> @@ -17,6 +17,9 @@
>  #include "migration/vmstate.h"
>  #include "qapi/error.h"
>  #include "trace.h"
> +#include "qemu/units.h"
> +#include "qemu/cutils.h"
> +#include "qapi/visitor.h"
> =20
>  /* Protection Key Register */
>  #define R_PROT            (0x00 / 4)
> @@ -163,10 +166,7 @@ static int ast2400_rambits(AspeedSDMCState *s)
>          break;
>      }

Now that the ramsizes are being checked, I think we can add in the defaul=
t
statement :

	g_assert_not_reached();


> =20
> -    /* use a common default */
> -    warn_report("Invalid RAM size 0x%" PRIx64 ". Using default 256M",
> -                s->ram_size);
> -    s->ram_size =3D 256 << 20;
> +    assert(0);
>      return ASPEED_SDMC_DRAM_256MB;


and skip the default return value.

A part from that,

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

>  }
> =20
> @@ -185,10 +185,7 @@ static int ast2500_rambits(AspeedSDMCState *s)
>          break;
>      }
> =20
> -    /* use a common default */
> -    warn_report("Invalid RAM size 0x%" PRIx64 ". Using default 512M",
> -                s->ram_size);
> -    s->ram_size =3D 512 << 20;
> +    assert(0);
>      return ASPEED_SDMC_AST2500_512MB;
>  }
> =20
> @@ -207,10 +204,7 @@ static int ast2600_rambits(AspeedSDMCState *s)
>          break;
>      }
> =20
> -    /* use a common default */
> -    warn_report("Invalid RAM size 0x%" PRIx64 ". Using default 1024M",
> -                s->ram_size);
> -    s->ram_size =3D 1024 << 20;
> +    assert(0);
>      return ASPEED_SDMC_AST2600_1024MB;
>  }
> =20
> @@ -225,6 +219,51 @@ static void aspeed_sdmc_reset(DeviceState *dev)
>      s->regs[R_CONF] =3D asc->compute_conf(s, 0);
>  }
> =20
> +static void aspeed_sdmc_get_ram_size(Object *obj, Visitor *v, const ch=
ar *name,
> +                                     void *opaque, Error **errp)
> +{
> +    AspeedSDMCState *s =3D ASPEED_SDMC(obj);
> +    int64_t value =3D s->ram_size;
> +
> +    visit_type_int(v, name, &value, errp);
> +}
> +
> +static void aspeed_sdmc_set_ram_size(Object *obj, Visitor *v, const ch=
ar *name,
> +                                     void *opaque, Error **errp)
> +{
> +    int i;
> +    char *sz;
> +    int64_t value;
> +    Error *local_err =3D NULL;
> +    AspeedSDMCState *s =3D ASPEED_SDMC(obj);
> +    AspeedSDMCClass *asc =3D ASPEED_SDMC_GET_CLASS(s);
> +
> +    visit_type_int(v, name, &value, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    for (i =3D 0; asc->valid_ram_sizes[i]; i++) {
> +        if (value =3D=3D asc->valid_ram_sizes[i]) {
> +            s->ram_size =3D value;
> +            return;
> +        }
> +    }
> +
> +    sz =3D size_to_str(value);
> +    error_setg(&local_err, "Invalid RAM size %s", sz);
> +    g_free(sz);
> +    error_propagate(errp, local_err);
> +}
> +
> +static void aspeed_sdmc_initfn(Object *obj)
> +{
> +    object_property_add(obj, "ram-size", "int",
> +                        aspeed_sdmc_get_ram_size, aspeed_sdmc_set_ram_=
size,
> +                        NULL, NULL, NULL);
> +}
> +
>  static void aspeed_sdmc_realize(DeviceState *dev, Error **errp)
>  {
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> @@ -249,7 +288,6 @@ static const VMStateDescription vmstate_aspeed_sdmc=
 =3D {
>  };
> =20
>  static Property aspeed_sdmc_properties[] =3D {
> -    DEFINE_PROP_UINT64("ram-size", AspeedSDMCState, ram_size, 0),
>      DEFINE_PROP_UINT64("max-ram-size", AspeedSDMCState, max_ram_size, =
0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> @@ -268,6 +306,7 @@ static const TypeInfo aspeed_sdmc_info =3D {
>      .name =3D TYPE_ASPEED_SDMC,
>      .parent =3D TYPE_SYS_BUS_DEVICE,
>      .instance_size =3D sizeof(AspeedSDMCState),
> +    .instance_init =3D aspeed_sdmc_initfn,
>      .class_init =3D aspeed_sdmc_class_init,
>      .class_size =3D sizeof(AspeedSDMCClass),
>      .abstract   =3D true,
> @@ -298,6 +337,9 @@ static void aspeed_2400_sdmc_write(AspeedSDMCState =
*s, uint32_t reg,
>      s->regs[reg] =3D data;
>  }
> =20
> +static const uint64_t
> +aspeed_2400_ram_sizes[] =3D { 64 * MiB, 128 * MiB, 256 * MiB, 512 * Mi=
B, 0};
> +
>  static void aspeed_2400_sdmc_class_init(ObjectClass *klass, void *data=
)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -307,6 +349,7 @@ static void aspeed_2400_sdmc_class_init(ObjectClass=
 *klass, void *data)
>      asc->max_ram_size =3D 512 << 20;
>      asc->compute_conf =3D aspeed_2400_sdmc_compute_conf;
>      asc->write =3D aspeed_2400_sdmc_write;
> +    asc->valid_ram_sizes =3D aspeed_2400_ram_sizes;
>  }
> =20
>  static const TypeInfo aspeed_2400_sdmc_info =3D {
> @@ -351,6 +394,9 @@ static void aspeed_2500_sdmc_write(AspeedSDMCState =
*s, uint32_t reg,
>      s->regs[reg] =3D data;
>  }
> =20
> +static const uint64_t
> +aspeed_2500_ram_sizes[] =3D { 128 * MiB, 256 * MiB, 512 * MiB, 1024 * =
MiB, 0};
> +
>  static void aspeed_2500_sdmc_class_init(ObjectClass *klass, void *data=
)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -360,6 +406,7 @@ static void aspeed_2500_sdmc_class_init(ObjectClass=
 *klass, void *data)
>      asc->max_ram_size =3D 1024 << 20;
>      asc->compute_conf =3D aspeed_2500_sdmc_compute_conf;
>      asc->write =3D aspeed_2500_sdmc_write;
> +    asc->valid_ram_sizes =3D aspeed_2500_ram_sizes;
>  }
> =20
>  static const TypeInfo aspeed_2500_sdmc_info =3D {
> @@ -404,6 +451,9 @@ static void aspeed_2600_sdmc_write(AspeedSDMCState =
*s, uint32_t reg,
>      s->regs[reg] =3D data;
>  }
> =20
> +static const uint64_t
> +aspeed_2600_ram_sizes[] =3D { 256 * MiB, 512 * MiB, 1024 * MiB, 2048 *=
 MiB, 0};
> +
>  static void aspeed_2600_sdmc_class_init(ObjectClass *klass, void *data=
)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -413,6 +463,7 @@ static void aspeed_2600_sdmc_class_init(ObjectClass=
 *klass, void *data)
>      asc->max_ram_size =3D 2048 << 20;
>      asc->compute_conf =3D aspeed_2600_sdmc_compute_conf;
>      asc->write =3D aspeed_2600_sdmc_write;
> +    asc->valid_ram_sizes =3D aspeed_2600_ram_sizes;
>  }
> =20
>  static const TypeInfo aspeed_2600_sdmc_info =3D {
>=20


