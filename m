Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D229FC2BA83
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 18:48:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F3432084E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 18:48:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3432084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3Oxj-0006C0-T1
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 13:48:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.ibm.com>) id 1j3Ox2-0005gW-Gg
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 13:47:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.ibm.com>) id 1j3Ox1-0006k5-66
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 13:47:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47048)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
 id 1j3Owy-0006eI-24; Sun, 16 Feb 2020 13:47:28 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01GIk4WF109559; Sun, 16 Feb 2020 13:47:25 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y6e2da9vc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 16 Feb 2020 13:47:25 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01GIk7A5109898;
 Sun, 16 Feb 2020 13:47:25 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y6e2da9v2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 16 Feb 2020 13:47:24 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01GIj1Mj007514;
 Sun, 16 Feb 2020 18:47:23 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma04wdc.us.ibm.com with ESMTP id 2y6895v6nn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 16 Feb 2020 18:47:23 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01GIlNpu51315082
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 16 Feb 2020 18:47:23 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A2FF112065;
 Sun, 16 Feb 2020 18:47:23 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 45678112063;
 Sun, 16 Feb 2020 18:47:23 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Sun, 16 Feb 2020 18:47:23 +0000 (GMT)
Subject: Re: [RFC v2 6/6] hw/arm/virt: vTPM support
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20200214183704.14389-1-eric.auger@redhat.com>
 <20200214183704.14389-7-eric.auger@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <17dfaa9b-dd1a-9654-c59c-391a70d0327e@linux.ibm.com>
Date: Sun, 16 Feb 2020 13:47:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200214183704.14389-7-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-16_04:2020-02-14,
 2020-02-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=2 clxscore=1015 lowpriorityscore=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002160168
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
Cc: marcandre.lureau@redhat.com, lersek@redhat.com, ardb@kernel.org,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/14/20 1:37 PM, Eric Auger wrote:
> Let the TPM TIS SYSBUS device be dynamically instantiable
> in ARM virt.  A device tree node is dynamically created
> (TPM via MMIO).
>
> The TPM Physical Presence interface (PPI) is not supported.
>
> To run with the swtmp TPM emulator, the qemu command line must
> be augmented with:
>
>          -chardev socket,id=chrtpm,path=swtpm-sock \
>          -tpmdev emulator,id=tpm0,chardev=chrtpm \
>          -device tpm-tis-device,tpmdev=tpm0 \
>
> swtpm/libtpms command line example:
>
> swtpm socket --tpm2 -t -d --tpmstate dir=/tmp/tpm \
> --ctrl type=unixio,path=swtpm-sock


Can you also extend docs/spec/tpm.rst for the arm case? And the test 
cases should probably also cover the arm sysbus device.


>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   hw/arm/Kconfig      |  1 +
>   hw/arm/sysbus-fdt.c | 36 ++++++++++++++++++++++++++++++++++++
>   hw/arm/virt.c       |  7 +++++++
>   3 files changed, 44 insertions(+)
>
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 3d86691ae0..b6f03f7f53 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -5,6 +5,7 @@ config ARM_VIRT
>       imply VFIO_AMD_XGBE
>       imply VFIO_PLATFORM
>       imply VFIO_XGMAC
> +    imply TPM_TIS_SYSBUS
>       select A15MPCORE
>       select ACPI
>       select ARM_SMMUV3
> diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
> index 022fc97ecd..adf50444c2 100644
> --- a/hw/arm/sysbus-fdt.c
> +++ b/hw/arm/sysbus-fdt.c
> @@ -30,6 +30,7 @@
>   #include "hw/arm/sysbus-fdt.h"
>   #include "qemu/error-report.h"
>   #include "sysemu/device_tree.h"
> +#include "sysemu/tpm.h"
>   #include "hw/platform-bus.h"
>   #include "hw/vfio/vfio-platform.h"
>   #include "hw/vfio/vfio-calxeda-xgmac.h"
> @@ -434,6 +435,40 @@ static bool vfio_platform_match(SysBusDevice *sbdev,
>   #define VFIO_PLATFORM_BINDING(compat, add_fn) \
>       {TYPE_VFIO_PLATFORM, (compat), (add_fn), vfio_platform_match}
>   
> +/*
> + * add_tpm_tis_fdt_node: Create a DT node for TPM TIS
> + *
> + * See kernel documentation:
> + * Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt
> + * Optional interrupt for command completion is not exposed
> + */
> +static int add_tpm_tis_fdt_node(SysBusDevice *sbdev, void *opaque)
> +{
> +    PlatformBusFDTData *data = opaque;
> +    PlatformBusDevice *pbus = data->pbus;
> +    void *fdt = data->fdt;
> +    const char *parent_node = data->pbus_node_name;
> +    int compat_str_len;
> +    char *nodename;
> +    uint32_t reg_attr[2];
> +    uint64_t mmio_base;
> +
> +    mmio_base = platform_bus_get_mmio_addr(pbus, sbdev, 0);

I suppose any conditional creation of this device tree entry is covered 
with the TYPE_BINDING below, meaning no device tree is created if the 
device wasn't added.


> +    nodename = g_strdup_printf("%s/tpm_tis@%" PRIx64, parent_node, mmio_base);
> +    qemu_fdt_add_subnode(fdt, nodename);
> +
> +    compat_str_len = strlen("tcg,tpm-tis-mmio") + 1;
> +    qemu_fdt_setprop(fdt, nodename, "compatible", "tcg,tpm-tis-mmio",
> +                     compat_str_len);

You probably can use qemu_fdt_setprop_string()?


> +
> +    reg_attr[0] = cpu_to_be32(mmio_base);
> +    reg_attr[1] = cpu_to_be32(0x5000);
> +    qemu_fdt_setprop(fdt, nodename, "reg", reg_attr, 2 * sizeof(uint32_t));
> +
> +    g_free(nodename);
> +    return 0;
> +}
> +
>   #endif /* CONFIG_LINUX */
>   
>   static int no_fdt_node(SysBusDevice *sbdev, void *opaque)
> @@ -455,6 +490,7 @@ static const BindingEntry bindings[] = {
>       TYPE_BINDING(TYPE_VFIO_CALXEDA_XGMAC, add_calxeda_midway_xgmac_fdt_node),
>       TYPE_BINDING(TYPE_VFIO_AMD_XGBE, add_amd_xgbe_fdt_node),
>       VFIO_PLATFORM_BINDING("amd,xgbe-seattle-v1a", add_amd_xgbe_fdt_node),
> +    TYPE_BINDING(TYPE_TPM_TIS_SYSBUS, add_tpm_tis_fdt_node),
>   #endif
>       TYPE_BINDING(TYPE_RAMFB_DEVICE, no_fdt_node),
>       TYPE_BINDING("", NULL), /* last element */
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index f788fe27d6..4b967e39d1 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -47,6 +47,7 @@
>   #include "sysemu/numa.h"
>   #include "sysemu/runstate.h"
>   #include "sysemu/sysemu.h"
> +#include "sysemu/tpm.h"
>   #include "sysemu/kvm.h"
>   #include "hw/loader.h"
>   #include "exec/address-spaces.h"
> @@ -2041,6 +2042,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_AMD_XGBE);
>       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
>       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_PLATFORM);
> +    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
>       mc->block_default_type = IF_VIRTIO;
>       mc->no_cdrom = 1;
>       mc->pci_allow_0_address = true;
> @@ -2153,6 +2155,11 @@ type_init(machvirt_machine_init);
>   
>   static void virt_machine_5_0_options(MachineClass *mc)
>   {
> +    static GlobalProperty compat[] = {
> +        { TYPE_TPM_TIS_SYSBUS, "ppi", "false" },
> +    };
> +
> +    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
>   }
>   DEFINE_VIRT_MACHINE_AS_LATEST(5, 0)
>   



