Return-Path: <SRS0=60Ee=WH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F78C433FF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 06:35:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D87E216F4
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 06:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D87E216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwhRV-0006xH-LU
	for qemu-devel@archiver.kernel.org; Sun, 11 Aug 2019 02:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52461)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bala24@linux.ibm.com>) id 1hwhQv-0006XV-1s
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 02:34:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1hwhQr-0002yb-PK
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 02:34:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22734)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1hwhQr-0002w7-CJ
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 02:34:21 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7B6VnW7078651
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2019 02:34:19 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2uabewbbwv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2019 02:34:18 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Sun, 11 Aug 2019 07:34:16 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sun, 11 Aug 2019 07:34:14 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7B6YDTv47906856
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 11 Aug 2019 06:34:13 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF47E4C046;
 Sun, 11 Aug 2019 06:34:13 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5EC014C044;
 Sun, 11 Aug 2019 06:34:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.102.2.246])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 11 Aug 2019 06:34:11 +0000 (GMT)
To: David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20190807071445.4109-1-bala24@linux.ibm.com>
 <20190807071445.4109-4-bala24@linux.ibm.com>
 <bfbabf96-fdec-f52a-0204-605420919149@kaod.org>
 <20190809044435.GK5465@umbus.fritz.box>
From: Balamuruhan S <bala24@linux.ibm.com>
Date: Sun, 11 Aug 2019 12:04:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190809044435.GK5465@umbus.fritz.box>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19081106-0020-0000-0000-0000035E62CD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081106-0021-0000-0000-000021B36E8A
Message-Id: <c53ef346-3118-893b-d3bd-50f550e4cc34@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-11_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908110074
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [RFC PATCH 3/6] hw/ppc/pnv_homer: add homer/occ
 common area emulation for PowerNV
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
Cc: pbonzini@redhat.com, maddy@linux.vnet.ibm.com, hari@linux.vnet.ibm.com,
 qemu-devel@nongnu.org, anju@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/9/19 10:14 AM, David Gibson wrote:
> On Wed, Aug 07, 2019 at 09:54:55AM +0200, C=E9dric Le Goater wrote:
>> On 07/08/2019 09:14, Balamuruhan S wrote:
>>> Add mmio callback functions to enable homer/occ common area
>>> to emulate pstate table, occ-sensors, slw, occ static and
>>> dynamic values for Power8 and Power9 chips. It also works for
>>> multiple chips as offset remains the same whereas the base
>>> address are handled appropriately while initializing device
>>> tree.
>>>
>>> currently skiboot disables the homer/occ code path with
>>> `QUIRK_NO_PBA`, this quirk have to be removed in skiboot
>>> for it to use this infrastructure.
>>
>> I think this patch can come before the others as it is adding
>> support without the python extra facilities.
> Right.  In fact it seems to me having it as an entirely separate
> series would be preferable.  I don't think we want to tie review of a
> basic OCC extension to to the frankly not all that palatable idea of
> adding arbitrary scripting into the MMIO path.

sure, I will send them as separate series. But the idea is to demonstrate
how the scripting interface can be added and to leverage it and I can
get feedback/suggestions to correct/improve it.

>
>> Some comments below,=20
>> =20
>>> Signed-off-by: Hariharan T.S <hari@linux.vnet.ibm.com>
>>> Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
>>> ---
>>>  hw/ppc/Makefile.objs       |   2 +-
>>>  hw/ppc/pnv_homer.c         | 185 +++++++++++++++++++++++++++++++++++=
++++++++++
>>>  include/hw/ppc/pnv.h       |  14 ++++
>>>  include/hw/ppc/pnv_homer.h |  41 ++++++++++
>>>  4 files changed, 241 insertions(+), 1 deletion(-)
>>>  create mode 100644 hw/ppc/pnv_homer.c
>>>  create mode 100644 include/hw/ppc/pnv_homer.h
>>>
>>> diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
>>> index 9da93af905..7260b4a96c 100644
>>> --- a/hw/ppc/Makefile.objs
>>> +++ b/hw/ppc/Makefile.objs
>>> @@ -7,7 +7,7 @@ obj-$(CONFIG_PSERIES) +=3D spapr_pci.o spapr_rtc.o sp=
apr_drc.o
>>>  obj-$(CONFIG_PSERIES) +=3D spapr_cpu_core.o spapr_ovec.o spapr_irq.o
>>>  obj-$(CONFIG_SPAPR_RNG) +=3D  spapr_rng.o
>>>  # IBM PowerNV
>>> -obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pn=
v_psi.o pnv_occ.o pnv_bmc.o
>>> +obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pn=
v_psi.o pnv_occ.o pnv_bmc.o pnv_homer.o
>> add an extra line.
>>
>>>  ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES)$(CONFIG_LINUX), yyy)
>>>  obj-y +=3D spapr_pci_vfio.o spapr_pci_nvlink2.o
>>>  endif
>>> diff --git a/hw/ppc/pnv_homer.c b/hw/ppc/pnv_homer.c
>>> new file mode 100644
>>> index 0000000000..73a94856d0
>>> --- /dev/null
>>> +++ b/hw/ppc/pnv_homer.c
>>> @@ -0,0 +1,185 @@
>>> +/*
>>> + * QEMU PowerPC PowerNV Homer and OCC common area region
>>> + *
>>> + * Copyright (c) 2019, IBM Corporation.
>>> + *
>>> + * This library is free software; you can redistribute it and/or
>>> + * modify it under the terms of the GNU Lesser General Public
>>> + * License as published by the Free Software Foundation; either
>>> + * version 2 of the License, or (at your option) any later version.
>>> + *
>>> + * This library is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>> + * Lesser General Public License for more details.
>>> + *
>>> + * You should have received a copy of the GNU Lesser General Public
>>> + * License along with this library; if not, see <http://www.gnu.org/=
licenses/>.
>>> + */
>>> +#include "qemu/osdep.h"
>>> +#include "sysemu/hw_accel.h"
>>> +#include "sysemu/cpus.h"
>>> +#include "hw/ppc/pnv.h"
>>> +
>>> +static bool core_max_array(hwaddr addr)
>>> +{
>>> +    char *cpu_type;
>>> +    hwaddr core_max_base =3D 0xe2819;
>> What is this representing ?=20
>>
>>> +    MachineState *ms =3D MACHINE(qdev_get_machine());
>>> +    cpu_type =3D strstr(ms->cpu_type, "power8");
>> you need to get this information some other way. The PnvChip should ha=
ve it.
>>
>>> +    if (cpu_type)
>>> +        core_max_base =3D 0x1f8810;
>> It could be a PnvChipClass value.
>>
>>> +    for (int i =3D 0; i <=3D ms->smp.cores; i++)
>>> +       if (addr =3D=3D (core_max_base + i))
>>> +           return true;
>>> +    return false;
>>> +}
>>
>>> +static uint64_t homer_read(void *opaque, hwaddr addr, unsigned width=
)
>>> +{
>>> +    switch (addr) {
>> We should be using defines for the case statements below.=20
>>
>> Are we accessing one or more structures which are mapped at specific=20
>> addresses ? If so I would define them in this file and change the=20
>> memory ops to use well known offsets.
>>
>> Are these structures the same on P9 and P8 ?=20
>>
>> Are there default values ? May be we could use a reset handler
>> in this case.
>>
>>> +        case 0xe2006:  /* max pstate ultra turbo */
>>> +        case 0xe2018:  /* pstate id for 0 */
>>> +        case 0x1f8001: /* P8 occ pstate version */
>>> +        case 0x1f8003: /* P8 pstate min */
>>> +        case 0x1f8010: /* P8 pstate id for 0 */
>>> +            return 0;
>>> +        case 0xe2000:  /* occ data area */
>>> +        case 0xe2002:  /* occ_role master/slave*/
>>> +        case 0xe2004:  /* pstate nom */
>>> +        case 0xe2005:  /* pstate turbo */
>>> +        case 0xe2020:  /* pstate id for 1 */
>>> +        case 0xe2818:  /* pstate ultra turbo */
>>> +        case 0xe2b85:  /* opal dynamic data (runtime) */
>>> +        case 0x1f8000: /* P8 occ pstate valid */
>>> +        case 0x1f8002: /* P8 throttle */
>>> +        case 0x1f8004: /* P8 pstate nom */
>>> +        case 0x1f8005: /* P8 pstate turbo */
>>> +        case 0x1f8012: /* vdd voltage identifier */
>>> +        case 0x1f8013: /* vcs voltage identifier */
>>> +        case 0x1f8018: /* P8 pstate id for 1 */
>>> +            return 1;
>>> +        case 0xe2003:  /* pstate min (2 as pstate min) */
>>> +        case 0xe2028:  /* pstate id for 2 */
>>> +        case 0x1f8006: /* P8 pstate ultra turbo */
>>> +        case 0x1f8020: /* P8 pstate id for 2 */
>>> +            return 2;
>>> +        case 0xe2001:  /* major version */
>>> +            return 0x90;
>>> +        /* 3000 khz frequency for 0, 1, and 2 pstates */
>>> +        case 0xe201c:
>>> +        case 0xe2024:
>>> +        case 0xe202c:
>>> +        /* P8 frequency for 0, 1, and 2 pstates */
>>> +        case 0x1f8014:
>>> +        case 0x1f801c:
>>> +        case 0x1f8024:
>>> +            return 3000;
>>> +        case 0x0:      /* homer base */
>>> +        case 0xe2008:  /* occ data area + 8 */
>>> +        case 0x1f8008: /* P8 occ data area + 8 */
>>> +        case 0x200008: /* homer base access to get homer image point=
er*/
>>> +            return 0x1000000000000000;
>>> +    }
>>> +    /* pstate table core max array */
>>> +    if (core_max_array(addr))
>>> +        return 1;
>> I don't understand what the core_max_array is returning
>>
>>> +    return 0;
>>> +}
>>> +
>>> +static void homer_write(void *opaque, hwaddr addr, uint64_t val,
>>> +                        unsigned width)
>>> +{
>>> +    /* callback function defined to homer write */
>>> +    return;
>>> +}
>>> +
>>> +const MemoryRegionOps pnv_homer_ops =3D {
>>> +    .read =3D homer_read,
>>> +    .write =3D homer_write,
>>> +    .valid.min_access_size =3D 1,
>>> +    .valid.max_access_size =3D 8,
>>> +    .impl.min_access_size =3D 1,
>>> +    .impl.max_access_size =3D 8,
>>> +    .endianness =3D DEVICE_BIG_ENDIAN,
>>> +};
>>> +
>>> +static uint64_t occ_common_area_read(void *opaque, hwaddr addr, unsi=
gned width)
>>> +{
>>> +    switch (addr) {
>>> +        /*
>>> +         * occ-sensor sanity check that asserts the sensor
>>> +         * header block
>>> +         */
>> Same comments as above.=20
>>
>>> +        case 0x580000: /* occ sensor data block */
>>> +        case 0x580001: /* valid */
>>> +        case 0x580002: /* version */
>>> +        case 0x580004: /* reading_version */
>>> +        case 0x580008: /* nr_sensors */
>>> +        case 0x580010: /* names_offset */
>>> +        case 0x580014: /* reading_ping_offset */
>>> +        case 0x58000c: /* reading_pong_offset */
>>> +        case 0x580023: /* structure_type */
>>> +            return 1;
>>> +        case 0x58000d: /* name length */
>>> +            return 0x30;
>>> +        case 0x580022: /* occ sensor loc core */
>>> +            return 0x0040;
>>> +        case 0x580003: /* occ sensor type power */
>>> +            return 0x0080;
>>> +        case 0x580005: /* sensor name */
>>> +            return 0x1000;
>>> +        case 0x58001e: /* HWMON_SENSORS_MASK */
>>> +        case 0x580020:
>>> +            return 0x8e00;
>>> +        case 0x0:      /* P8 slw base access for slw image size */
>>> +            return 0x1000000000000000;
>>> +    }
>>> +    return 0;
>>> +}
>>> +
>>> +static void occ_common_area_write(void *opaque, hwaddr addr, uint64_=
t val,
>>> +                                  unsigned width)
>>> +{
>>> +    /* callback function defined to occ common area write */
>>> +    return;
>>> +}
>>> +
>>> +const MemoryRegionOps pnv_occ_common_area_ops =3D {
>>> +    .read =3D occ_common_area_read,
>>> +    .write =3D occ_common_area_write,
>>> +    .valid.min_access_size =3D 1,
>>> +    .valid.max_access_size =3D 8,
>>> +    .impl.min_access_size =3D 1,
>>> +    .impl.max_access_size =3D 8,
>>> +    .endianness =3D DEVICE_BIG_ENDIAN,
>>> +};
>>
>> Why aren't you using the PnvOCC model ?=20
>>
>>> +void pnv_occ_common_area_realize(PnvChip *chip, Error **errp)
>>> +{
>>> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(chip);
>>> +    sbd->num_mmio =3D PNV_OCC_COMMON_AREA_SYSBUS;
>>> +    char *occ_common_area;
>>> +
>>> +    /* occ common area */
>>> +    occ_common_area =3D g_strdup_printf("occ-common-area-%x", chip->=
chip_id);
>>> +    memory_region_init_io(&chip->occ_common_area_mmio, OBJECT(chip),
>>> +                          &pnv_occ_common_area_ops, chip, occ_common=
_area,
>>> +                          PNV_OCC_COMMON_AREA_SIZE);
>>> +    sysbus_init_mmio(sbd, &chip->occ_common_area_mmio);
>>> +    g_free(occ_common_area);
>>> +}
>>
>> May be this "device" deserves a PnvHomer model, one for P8 and one for=
 P9.=20
>>
>>> +void pnv_homer_realize(PnvChip *chip, Error **errp)
>>> +{
>>> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(chip);
>>> +    sbd->num_mmio =3D PNV_HOMER_SYSBUS;
>>> +    char *homer;
>>> +
>>> +    /* homer region */
>>> +    homer =3D g_strdup_printf("homer-%x", chip->chip_id);
>>> +    memory_region_init_io(&chip->homer_mmio, OBJECT(chip), &pnv_home=
r_ops,
>>> +                          chip, homer, PNV_HOMER_SIZE);
>>> +    sysbus_init_mmio(sbd, &chip->homer_mmio);
>>> +    g_free(homer);
>>> +}
>>> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
>>> index fb123edc4e..6464e32892 100644
>>> --- a/include/hw/ppc/pnv.h
>>> +++ b/include/hw/ppc/pnv.h
>>> @@ -28,6 +28,7 @@
>>>  #include "hw/ppc/pnv_occ.h"
>>>  #include "hw/ppc/pnv_xive.h"
>>>  #include "hw/ppc/pnv_core.h"
>>> +#include "hw/ppc/pnv_homer.h"
>>> =20
>>>  #define TYPE_PNV_CHIP "pnv-chip"
>>>  #define PNV_CHIP(obj) OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP)
>>> @@ -36,6 +37,13 @@
>>>  #define PNV_CHIP_GET_CLASS(obj) \
>>>       OBJECT_GET_CLASS(PnvChipClass, (obj), TYPE_PNV_CHIP)
>>> =20
>>> +enum SysBusNum {
>>> +    PNV_XSCOM_SYSBUS,
>>> +    PNV_ICP_SYSBUS,
>>> +    PNV_HOMER_SYSBUS,
>>> +    PNV_OCC_COMMON_AREA_SYSBUS,
>>> +};
>> What is this ?=20
>>
>>
>>>  typedef enum PnvChipType {
>>>      PNV_CHIP_POWER8E,     /* AKA Murano (default) */
>>>      PNV_CHIP_POWER8,      /* AKA Venice */
>>> @@ -56,6 +64,8 @@ typedef struct PnvChip {
>>>      uint64_t     cores_mask;
>>>      void         *cores;
>>> =20
>>> +    MemoryRegion homer_mmio;
>>> +    MemoryRegion occ_common_area_mmio;
>>>      MemoryRegion xscom_mmio;
>>>      MemoryRegion xscom;
>>>      AddressSpace xscom_as;
>>> @@ -191,6 +201,10 @@ static inline bool pnv_is_power9(PnvMachineState=
 *pnv)
>>>  void pnv_dt_bmc_sensors(IPMIBmc *bmc, void *fdt);
>>>  void pnv_bmc_powerdown(IPMIBmc *bmc);
>>> =20
>>> +extern void pnv_occ_common_area_realize(PnvChip *chip, Error **errp)=
;
>>> +extern void pnv_homer_realize(PnvChip *chip, Error **errp);
>>> +
>>> +
>>>  /*
>>>   * POWER8 MMIO base addresses
>>>   */
>>> diff --git a/include/hw/ppc/pnv_homer.h b/include/hw/ppc/pnv_homer.h
>>> new file mode 100644
>>> index 0000000000..0fe6469abe
>>> --- /dev/null
>>> +++ b/include/hw/ppc/pnv_homer.h
>>> @@ -0,0 +1,41 @@
>>> +/*
>>> + * QEMU PowerPC PowerNV Homer and occ common area definitions
>>> + *
>>> + * Copyright (c) 2019, IBM Corporation.
>>> + *
>>> + * This library is free software; you can redistribute it and/or
>>> + * modify it under the terms of the GNU Lesser General Public
>>> + * License as published by the Free Software Foundation; either
>>> + * version 2 of the License, or (at your option) any later version.
>>> + *
>>> + * This library is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>> + * Lesser General Public License for more details.
>>> + *
>>> + * You should have received a copy of the GNU Lesser General Public
>>> + * License along with this library; if not, see <http://www.gnu.org/=
licenses/>.
>>> + */
>>> +#ifndef _PPC_PNV_HOMER_H
>>> +#define _PPC_PNV_HOMER_H
>>> +
>>> +#include "qom/object.h"
>>> +
>>> +/*
>>> + *  HOMER region size 4M per OCC (1 OCC is defined per chip  in stru=
ct PnvChip)
>>> + *  so chip_num can be used to offset between HOMER region from its =
base address
>>> + */
>>> +#define PNV_HOMER_SIZE        0x300000
>>> +#define PNV_OCC_COMMON_AREA_SIZE      0x700000
>>> +
>>> +#define PNV_HOMER_BASE(chip)                                        =
    \
>>> +    (0x7ffd800000ull + ((uint64_t)(chip)->chip_num) * PNV_HOMER_SIZE=
)
>>> +#define PNV_OCC_COMMON_AREA(chip)                                   =
    \
>>> +    (0x7fff800000ull + ((uint64_t)(chip)->chip_num) * PNV_OCC_COMMON=
_AREA_SIZE)
>>> +
>>> +#define PNV9_HOMER_BASE(chip)                                       =
     \
>>> +    (0x203ffd800000ull + ((uint64_t)(chip)->chip_num) * PNV_HOMER_SI=
ZE)
>>> +#define PNV9_OCC_COMMON_AREA(chip)                                  =
     \
>>> +    (0x203fff800000ull + ((uint64_t)(chip)->chip_num) * PNV_OCC_COMM=
ON_AREA_SIZE)
>>> +
>>> +#endif /* _PPC_PNV_HOMER_H */
>>>
