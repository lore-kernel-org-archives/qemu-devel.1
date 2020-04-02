Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA46C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 06:43:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50E5E206F5
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 06:43:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E5E206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJtZD-00084Q-FN
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 02:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jJtXj-0006Rq-KY
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 02:41:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jJtXg-0002sY-JH
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 02:41:35 -0400
Received: from 2.mo5.mail-out.ovh.net ([178.33.109.111]:48329)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jJtXe-0002h1-SH
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 02:41:31 -0400
Received: from player687.ha.ovh.net (unknown [10.108.42.83])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 3F2B3277CB7
 for <qemu-devel@nongnu.org>; Thu,  2 Apr 2020 08:41:28 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player687.ha.ovh.net (Postfix) with ESMTPSA id 85E1E10FD117A;
 Thu,  2 Apr 2020 06:41:24 +0000 (UTC)
Subject: Re: [PATCH] ppc/pnv: Introduce common PNV_SETFIELD() and
 PNV_GETFIELD() macros
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200401152633.1375-1-clg@kaod.org>
 <20200402003118.GJ47772@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b7663796-c9ad-c91e-104a-dcf78e467607@kaod.org>
Date: Thu, 2 Apr 2020 08:41:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200402003118.GJ47772@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 9878645786929826624
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrtdefgdduudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefheenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheikeejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.109.111
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/2/20 2:31 AM, David Gibson wrote:
> On Wed, Apr 01, 2020 at 05:26:33PM +0200, C=E9dric Le Goater wrote:
>> Most of QEMU definitions of the register fields of the PowerNV machine
>> come from skiboot and the models duplicate a set of macros for this
>> purpose. Make them common under the pnv_utils.h file.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> Hrm.  If we're touching these, would it make sense to rewrite them in
> terms of the cross-qemu generic extract64() and deposit64()?

I won't do that because we will loose compatibility with skiboot.

C.

>=20
>> ---
>>  include/hw/pci-host/pnv_phb3_regs.h | 16 ------
>>  include/hw/ppc/pnv_utils.h          | 29 +++++++++++
>>  hw/intc/pnv_xive.c                  | 76 ++++++++++++----------------=
-
>>  hw/pci-host/pnv_phb3.c              | 32 ++++++------
>>  hw/pci-host/pnv_phb3_msi.c          | 24 ++++-----
>>  hw/pci-host/pnv_phb4.c              | 51 ++++++++-----------
>>  6 files changed, 108 insertions(+), 120 deletions(-)
>>  create mode 100644 include/hw/ppc/pnv_utils.h
>>
>> diff --git a/include/hw/pci-host/pnv_phb3_regs.h b/include/hw/pci-host=
/pnv_phb3_regs.h
>> index a174ef1f7045..38f8ce9d7406 100644
>> --- a/include/hw/pci-host/pnv_phb3_regs.h
>> +++ b/include/hw/pci-host/pnv_phb3_regs.h
>> @@ -12,22 +12,6 @@
>> =20
>>  #include "qemu/host-utils.h"
>> =20
>> -/*
>> - * QEMU version of the GETFIELD/SETFIELD macros
>> - *
>> - * These are common with the PnvXive model.
>> - */
>> -static inline uint64_t GETFIELD(uint64_t mask, uint64_t word)
>> -{
>> -    return (word & mask) >> ctz64(mask);
>> -}
>> -
>> -static inline uint64_t SETFIELD(uint64_t mask, uint64_t word,
>> -                                uint64_t value)
>> -{
>> -    return (word & ~mask) | ((value << ctz64(mask)) & mask);
>> -}
>> -
>>  /*
>>   * PBCQ XSCOM registers
>>   */
>> diff --git a/include/hw/ppc/pnv_utils.h b/include/hw/ppc/pnv_utils.h
>> new file mode 100644
>> index 000000000000..8521e13b5149
>> --- /dev/null
>> +++ b/include/hw/ppc/pnv_utils.h
>> @@ -0,0 +1,29 @@
>> +/*
>> + * QEMU PowerPC PowerNV utilities
>> + *
>> + * Copyright (c) 2020, IBM Corporation.
>> + *
>> + * This code is licensed under the GPL version 2 or later. See the
>> + * COPYING file in the top-level directory.
>> + */
>> +
>> +#ifndef PPC_PNV_UTILS_H
>> +#define PPC_PNV_UTILS_H
>> +
>> +/*
>> + * QEMU version of the GETFIELD/SETFIELD macros used in skiboot to
>> + * define the register fields.
>> + */
>> +
>> +static inline uint64_t PNV_GETFIELD(uint64_t mask, uint64_t word)
>> +{
>> +    return (word & mask) >> ctz64(mask);
>> +}
>> +
>> +static inline uint64_t PNV_SETFIELD(uint64_t mask, uint64_t word,
>> +                                    uint64_t value)
>> +{
>> +    return (word & ~mask) | ((value << ctz64(mask)) & mask);
>> +}
>> +
>> +#endif /* PPC_PNV_UTILS_H */
>> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
>> index aeda488bd113..77cacdd6c623 100644
>> --- a/hw/intc/pnv_xive.c
>> +++ b/hw/intc/pnv_xive.c
>> @@ -21,6 +21,7 @@
>>  #include "hw/ppc/pnv_core.h"
>>  #include "hw/ppc/pnv_xscom.h"
>>  #include "hw/ppc/pnv_xive.h"
>> +#include "hw/ppc/pnv_utils.h" /* SETFIELD() and GETFIELD() macros */
>>  #include "hw/ppc/xive_regs.h"
>>  #include "hw/qdev-properties.h"
>>  #include "hw/ppc/ppc.h"
>> @@ -65,26 +66,6 @@ static const XiveVstInfo vst_infos[] =3D {
>>      qemu_log_mask(LOG_GUEST_ERROR, "XIVE[%x] - " fmt "\n",           =
   \
>>                    (xive)->chip->chip_id, ## __VA_ARGS__);
>> =20
>> -/*
>> - * QEMU version of the GETFIELD/SETFIELD macros
>> - *
>> - * TODO: It might be better to use the existing extract64() and
>> - * deposit64() but this means that all the register definitions will
>> - * change and become incompatible with the ones found in skiboot.
>> - *
>> - * Keep it as it is for now until we find a common ground.
>> - */
>> -static inline uint64_t GETFIELD(uint64_t mask, uint64_t word)
>> -{
>> -    return (word & mask) >> ctz64(mask);
>> -}
>> -
>> -static inline uint64_t SETFIELD(uint64_t mask, uint64_t word,
>> -                                uint64_t value)
>> -{
>> -    return (word & ~mask) | ((value << ctz64(mask)) & mask);
>> -}
>> -
>>  /*
>>   * When PC_TCTXT_CHIPID_OVERRIDE is configured, the PC_TCTXT_CHIPID
>>   * field overrides the hardwired chip ID in the Powerbus operations
>> @@ -96,7 +77,7 @@ static uint8_t pnv_xive_block_id(PnvXive *xive)
>>      uint64_t cfg_val =3D xive->regs[PC_TCTXT_CFG >> 3];
>> =20
>>      if (cfg_val & PC_TCTXT_CHIPID_OVERRIDE) {
>> -        blk =3D GETFIELD(PC_TCTXT_CHIPID, cfg_val);
>> +        blk =3D PNV_GETFIELD(PC_TCTXT_CHIPID, cfg_val);
>>      }
>> =20
>>      return blk;
>> @@ -145,7 +126,7 @@ static uint64_t pnv_xive_vst_addr_direct(PnvXive *=
xive, uint32_t type,
>>  {
>>      const XiveVstInfo *info =3D &vst_infos[type];
>>      uint64_t vst_addr =3D vsd & VSD_ADDRESS_MASK;
>> -    uint64_t vst_tsize =3D 1ull << (GETFIELD(VSD_TSIZE, vsd) + 12);
>> +    uint64_t vst_tsize =3D 1ull << (PNV_GETFIELD(VSD_TSIZE, vsd) + 12=
);
>>      uint32_t idx_max;
>> =20
>>      idx_max =3D vst_tsize / info->size - 1;
>> @@ -180,7 +161,7 @@ static uint64_t pnv_xive_vst_addr_indirect(PnvXive=
 *xive, uint32_t type,
>>          return 0;
>>      }
>> =20
>> -    page_shift =3D GETFIELD(VSD_TSIZE, vsd) + 12;
>> +    page_shift =3D PNV_GETFIELD(VSD_TSIZE, vsd) + 12;
>> =20
>>      if (!pnv_xive_vst_page_size_allowed(page_shift)) {
>>          xive_error(xive, "VST: invalid %s page shift %d", info->name,
>> @@ -207,7 +188,7 @@ static uint64_t pnv_xive_vst_addr_indirect(PnvXive=
 *xive, uint32_t type,
>>           * Check that the pages have a consistent size across the
>>           * indirect table
>>           */
>> -        if (page_shift !=3D GETFIELD(VSD_TSIZE, vsd) + 12) {
>> +        if (page_shift !=3D PNV_GETFIELD(VSD_TSIZE, vsd) + 12) {
>>              xive_error(xive, "VST: %s entry %x indirect page size dif=
fer !?",
>>                         info->name, idx);
>>              return 0;
>> @@ -232,7 +213,7 @@ static uint64_t pnv_xive_vst_addr(PnvXive *xive, u=
int32_t type, uint8_t blk,
>>      vsd =3D xive->vsds[type][blk];
>> =20
>>      /* Remote VST access */
>> -    if (GETFIELD(VSD_MODE, vsd) =3D=3D VSD_MODE_FORWARD) {
>> +    if (PNV_GETFIELD(VSD_MODE, vsd) =3D=3D VSD_MODE_FORWARD) {
>>          xive =3D pnv_xive_get_remote(blk);
>> =20
>>          return xive ? pnv_xive_vst_addr(xive, type, blk, idx) : 0;
>> @@ -295,9 +276,9 @@ static int pnv_xive_write_end(XiveRouter *xrtr, ui=
nt8_t blk, uint32_t idx,
>> =20
>>  static int pnv_xive_end_update(PnvXive *xive)
>>  {
>> -    uint8_t  blk =3D GETFIELD(VC_EQC_CWATCH_BLOCKID,
>> +    uint8_t  blk =3D PNV_GETFIELD(VC_EQC_CWATCH_BLOCKID,
>>                             xive->regs[(VC_EQC_CWATCH_SPEC >> 3)]);
>> -    uint32_t idx =3D GETFIELD(VC_EQC_CWATCH_OFFSET,
>> +    uint32_t idx =3D PNV_GETFIELD(VC_EQC_CWATCH_OFFSET,
>>                             xive->regs[(VC_EQC_CWATCH_SPEC >> 3)]);
>>      int i;
>>      uint64_t eqc_watch[4];
>> @@ -312,9 +293,9 @@ static int pnv_xive_end_update(PnvXive *xive)
>> =20
>>  static void pnv_xive_end_cache_load(PnvXive *xive)
>>  {
>> -    uint8_t  blk =3D GETFIELD(VC_EQC_CWATCH_BLOCKID,
>> +    uint8_t  blk =3D PNV_GETFIELD(VC_EQC_CWATCH_BLOCKID,
>>                             xive->regs[(VC_EQC_CWATCH_SPEC >> 3)]);
>> -    uint32_t idx =3D GETFIELD(VC_EQC_CWATCH_OFFSET,
>> +    uint32_t idx =3D PNV_GETFIELD(VC_EQC_CWATCH_OFFSET,
>>                             xive->regs[(VC_EQC_CWATCH_SPEC >> 3)]);
>>      uint64_t eqc_watch[4] =3D { 0 };
>>      int i;
>> @@ -343,9 +324,9 @@ static int pnv_xive_write_nvt(XiveRouter *xrtr, ui=
nt8_t blk, uint32_t idx,
>> =20
>>  static int pnv_xive_nvt_update(PnvXive *xive)
>>  {
>> -    uint8_t  blk =3D GETFIELD(PC_VPC_CWATCH_BLOCKID,
>> +    uint8_t  blk =3D PNV_GETFIELD(PC_VPC_CWATCH_BLOCKID,
>>                             xive->regs[(PC_VPC_CWATCH_SPEC >> 3)]);
>> -    uint32_t idx =3D GETFIELD(PC_VPC_CWATCH_OFFSET,
>> +    uint32_t idx =3D PNV_GETFIELD(PC_VPC_CWATCH_OFFSET,
>>                             xive->regs[(PC_VPC_CWATCH_SPEC >> 3)]);
>>      int i;
>>      uint64_t vpc_watch[8];
>> @@ -360,9 +341,9 @@ static int pnv_xive_nvt_update(PnvXive *xive)
>> =20
>>  static void pnv_xive_nvt_cache_load(PnvXive *xive)
>>  {
>> -    uint8_t  blk =3D GETFIELD(PC_VPC_CWATCH_BLOCKID,
>> +    uint8_t  blk =3D PNV_GETFIELD(PC_VPC_CWATCH_BLOCKID,
>>                             xive->regs[(PC_VPC_CWATCH_SPEC >> 3)]);
>> -    uint32_t idx =3D GETFIELD(PC_VPC_CWATCH_OFFSET,
>> +    uint32_t idx =3D PNV_GETFIELD(PC_VPC_CWATCH_OFFSET,
>>                             xive->regs[(PC_VPC_CWATCH_SPEC >> 3)]);
>>      uint64_t vpc_watch[8] =3D { 0 };
>>      int i;
>> @@ -518,7 +499,7 @@ static uint64_t pnv_xive_pc_size(PnvXive *xive)
>>  static uint32_t pnv_xive_nr_ipis(PnvXive *xive, uint8_t blk)
>>  {
>>      uint64_t vsd =3D xive->vsds[VST_TSEL_SBE][blk];
>> -    uint64_t vst_tsize =3D 1ull << (GETFIELD(VSD_TSIZE, vsd) + 12);
>> +    uint64_t vst_tsize =3D 1ull << (PNV_GETFIELD(VSD_TSIZE, vsd) + 12=
);
>> =20
>>      return VSD_INDIRECT & vsd ? 0 : vst_tsize * SBE_PER_BYTE;
>>  }
>> @@ -550,7 +531,7 @@ static uint64_t pnv_xive_vst_per_subpage(PnvXive *=
xive, uint32_t type)
>>          return 0;
>>      }
>> =20
>> -    page_shift =3D GETFIELD(VSD_TSIZE, vsd) + 12;
>> +    page_shift =3D PNV_GETFIELD(VSD_TSIZE, vsd) + 12;
>> =20
>>      if (!pnv_xive_vst_page_size_allowed(page_shift)) {
>>          xive_error(xive, "VST: invalid %s page shift %d", info->name,
>> @@ -582,7 +563,7 @@ static uint64_t pnv_xive_edt_size(PnvXive *xive, u=
int64_t type)
>>      int i;
>> =20
>>      for (i =3D 0; i < XIVE_TABLE_EDT_MAX; i++) {
>> -        uint64_t edt_type =3D GETFIELD(CQ_TDR_EDT_TYPE, xive->edt[i])=
;
>> +        uint64_t edt_type =3D PNV_GETFIELD(CQ_TDR_EDT_TYPE, xive->edt=
[i]);
>> =20
>>          if (edt_type =3D=3D type) {
>>              size +=3D edt_size;
>> @@ -604,7 +585,7 @@ static uint64_t pnv_xive_edt_offset(PnvXive *xive,=
 uint64_t vc_offset,
>>      uint64_t edt_offset =3D vc_offset;
>> =20
>>      for (i =3D 0; i < XIVE_TABLE_EDT_MAX && (i * edt_size) < vc_offse=
t; i++) {
>> -        uint64_t edt_type =3D GETFIELD(CQ_TDR_EDT_TYPE, xive->edt[i])=
;
>> +        uint64_t edt_type =3D PNV_GETFIELD(CQ_TDR_EDT_TYPE, xive->edt=
[i]);
>> =20
>>          if (edt_type !=3D type) {
>>              edt_offset -=3D edt_size;
>> @@ -632,7 +613,8 @@ static void pnv_xive_edt_resize(PnvXive *xive)
>>  static int pnv_xive_table_set_data(PnvXive *xive, uint64_t val)
>>  {
>>      uint64_t tsel =3D xive->regs[CQ_TAR >> 3] & CQ_TAR_TSEL;
>> -    uint8_t tsel_index =3D GETFIELD(CQ_TAR_TSEL_INDEX, xive->regs[CQ_=
TAR >> 3]);
>> +    uint8_t tsel_index =3D PNV_GETFIELD(CQ_TAR_TSEL_INDEX,
>> +                                      xive->regs[CQ_TAR >> 3]);
>>      uint64_t *xive_table;
>>      uint8_t max_index;
>> =20
>> @@ -667,7 +649,8 @@ static int pnv_xive_table_set_data(PnvXive *xive, =
uint64_t val)
>> =20
>>      if (xive->regs[CQ_TAR >> 3] & CQ_TAR_TBL_AUTOINC) {
>>          xive->regs[CQ_TAR >> 3] =3D
>> -            SETFIELD(CQ_TAR_TSEL_INDEX, xive->regs[CQ_TAR >> 3], ++ts=
el_index);
>> +            PNV_SETFIELD(CQ_TAR_TSEL_INDEX, xive->regs[CQ_TAR >> 3],
>> +                         ++tsel_index);
>>      }
>> =20
>>      /*
>> @@ -690,7 +673,7 @@ static void pnv_xive_vst_set_exclusive(PnvXive *xi=
ve, uint8_t type,
>>      XiveENDSource *end_xsrc =3D &xive->end_source;
>>      XiveSource *xsrc =3D &xive->ipi_source;
>>      const XiveVstInfo *info =3D &vst_infos[type];
>> -    uint32_t page_shift =3D GETFIELD(VSD_TSIZE, vsd) + 12;
>> +    uint32_t page_shift =3D PNV_GETFIELD(VSD_TSIZE, vsd) + 12;
>>      uint64_t vst_tsize =3D 1ull << page_shift;
>>      uint64_t vst_addr =3D vsd & VSD_ADDRESS_MASK;
>> =20
>> @@ -777,10 +760,10 @@ static void pnv_xive_vst_set_exclusive(PnvXive *=
xive, uint8_t type,
>>   */
>>  static void pnv_xive_vst_set_data(PnvXive *xive, uint64_t vsd, bool p=
c_engine)
>>  {
>> -    uint8_t mode =3D GETFIELD(VSD_MODE, vsd);
>> -    uint8_t type =3D GETFIELD(VST_TABLE_SELECT,
>> +    uint8_t mode =3D PNV_GETFIELD(VSD_MODE, vsd);
>> +    uint8_t type =3D PNV_GETFIELD(VST_TABLE_SELECT,
>>                              xive->regs[VC_VSD_TABLE_ADDR >> 3]);
>> -    uint8_t blk =3D GETFIELD(VST_TABLE_BLOCK,
>> +    uint8_t blk =3D PNV_GETFIELD(VST_TABLE_BLOCK,
>>                             xive->regs[VC_VSD_TABLE_ADDR >> 3]);
>>      uint64_t vst_addr =3D vsd & VSD_ADDRESS_MASK;
>> =20
>> @@ -1456,7 +1439,8 @@ static XiveTCTX *pnv_xive_get_indirect_tctx(PnvX=
ive *xive)
>>          return NULL;
>>      }
>> =20
>> -    pir =3D (chip->chip_id << 8) | GETFIELD(PC_TCTXT_INDIR_THRDID, tc=
txt_indir);
>> +    pir =3D (chip->chip_id << 8) |
>> +        PNV_GETFIELD(PC_TCTXT_INDIR_THRDID, tctxt_indir);
>>      cpu =3D pnv_chip_find_cpu(chip, pir);
>>      if (!cpu) {
>>          xive_error(xive, "IC: invalid PIR %x for indirect access", pi=
r);
>> @@ -1583,7 +1567,7 @@ static uint64_t pnv_xive_vc_read(void *opaque, h=
waddr offset,
>>      uint64_t ret =3D -1;
>> =20
>>      if (edt_index < XIVE_TABLE_EDT_MAX) {
>> -        edt_type =3D GETFIELD(CQ_TDR_EDT_TYPE, xive->edt[edt_index]);
>> +        edt_type =3D PNV_GETFIELD(CQ_TDR_EDT_TYPE, xive->edt[edt_inde=
x]);
>>      }
>> =20
>>      switch (edt_type) {
>> @@ -1625,7 +1609,7 @@ static void pnv_xive_vc_write(void *opaque, hwad=
dr offset,
>>      AddressSpace *edt_as =3D NULL;
>> =20
>>      if (edt_index < XIVE_TABLE_EDT_MAX) {
>> -        edt_type =3D GETFIELD(CQ_TDR_EDT_TYPE, xive->edt[edt_index]);
>> +        edt_type =3D PNV_GETFIELD(CQ_TDR_EDT_TYPE, xive->edt[edt_inde=
x]);
>>      }
>> =20
>>      switch (edt_type) {
>> diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
>> index 74618fadf085..a2d5815d3485 100644
>> --- a/hw/pci-host/pnv_phb3.c
>> +++ b/hw/pci-host/pnv_phb3.c
>> @@ -16,6 +16,7 @@
>>  #include "hw/pci/pcie_host.h"
>>  #include "hw/pci/pcie_port.h"
>>  #include "hw/ppc/pnv.h"
>> +#include "hw/ppc/pnv_utils.h" /* SETFIELD() and GETFIELD() macros */
>>  #include "hw/irq.h"
>>  #include "hw/qdev-properties.h"
>> =20
>> @@ -171,11 +172,11 @@ static void pnv_phb3_check_m64(PnvPHB3 *phb, uin=
t32_t index)
>>      }
>> =20
>>      /* Grab geometry from registers */
>> -    base =3D GETFIELD(IODA2_M64BT_BASE, m64) << 20;
>> +    base =3D PNV_GETFIELD(IODA2_M64BT_BASE, m64) << 20;
>>      if (m64 & IODA2_M64BT_SINGLE_PE) {
>>          base &=3D ~0x1ffffffull;
>>      }
>> -    size =3D GETFIELD(IODA2_M64BT_MASK, m64) << 20;
>> +    size =3D PNV_GETFIELD(IODA2_M64BT_MASK, m64) << 20;
>>      size |=3D 0xfffc000000000000ull;
>>      size =3D ~size + 1;
>>      start =3D base | (phb->regs[PHB_M64_UPPER_BITS >> 3]);
>> @@ -217,8 +218,8 @@ static void pnv_phb3_lxivt_write(PnvPHB3 *phb, uns=
igned idx, uint64_t val)
>>      phb->ioda_LXIVT[idx] =3D val & (IODA2_LXIVT_SERVER |
>>                                    IODA2_LXIVT_PRIORITY |
>>                                    IODA2_LXIVT_NODE_ID);
>> -    server =3D GETFIELD(IODA2_LXIVT_SERVER, val);
>> -    prio =3D GETFIELD(IODA2_LXIVT_PRIORITY, val);
>> +    server =3D PNV_GETFIELD(IODA2_LXIVT_SERVER, val);
>> +    prio =3D PNV_GETFIELD(IODA2_LXIVT_PRIORITY, val);
>> =20
>>      /*
>>       * The low order 2 bits are the link pointer (Type II interrupts)=
.
>> @@ -233,8 +234,8 @@ static uint64_t *pnv_phb3_ioda_access(PnvPHB3 *phb=
,
>>                                        unsigned *out_table, unsigned *=
out_idx)
>>  {
>>      uint64_t adreg =3D phb->regs[PHB_IODA_ADDR >> 3];
>> -    unsigned int index =3D GETFIELD(PHB_IODA_AD_TADR, adreg);
>> -    unsigned int table =3D GETFIELD(PHB_IODA_AD_TSEL, adreg);
>> +    unsigned int index =3D PNV_GETFIELD(PHB_IODA_AD_TADR, adreg);
>> +    unsigned int table =3D PNV_GETFIELD(PHB_IODA_AD_TSEL, adreg);
>>      unsigned int mask;
>>      uint64_t *tptr =3D NULL;
>> =20
>> @@ -297,7 +298,7 @@ static uint64_t *pnv_phb3_ioda_access(PnvPHB3 *phb=
,
>>      }
>>      if (adreg & PHB_IODA_AD_AUTOINC) {
>>          index =3D (index + 1) & mask;
>> -        adreg =3D SETFIELD(PHB_IODA_AD_TADR, adreg, index);
>> +        adreg =3D PNV_SETFIELD(PHB_IODA_AD_TADR, adreg, index);
>>      }
>>      phb->regs[PHB_IODA_ADDR >> 3] =3D adreg;
>>      return tptr;
>> @@ -363,10 +364,11 @@ void pnv_phb3_remap_irqs(PnvPHB3 *phb)
>>      }
>> =20
>>      /* Grab local LSI source ID */
>> -    local =3D GETFIELD(PHB_LSI_SRC_ID, phb->regs[PHB_LSI_SOURCE_ID >>=
 3]) << 3;
>> +    local =3D PNV_GETFIELD(PHB_LSI_SRC_ID,
>> +                         phb->regs[PHB_LSI_SOURCE_ID >> 3]) << 3;
>> =20
>>      /* Grab global one and compare */
>> -    global =3D GETFIELD(PBCQ_NEST_LSI_SRC,
>> +    global =3D PNV_GETFIELD(PBCQ_NEST_LSI_SRC,
>>                        pbcq->nest_regs[PBCQ_NEST_LSI_SRC_ID]) << 3;
>>      if (global !=3D local) {
>>          /*
>> @@ -378,9 +380,9 @@ void pnv_phb3_remap_irqs(PnvPHB3 *phb)
>>      }
>> =20
>>      /* Get the base on the powerbus */
>> -    comp =3D GETFIELD(PBCQ_NEST_IRSN_COMP,
>> +    comp =3D PNV_GETFIELD(PBCQ_NEST_IRSN_COMP,
>>                      pbcq->nest_regs[PBCQ_NEST_IRSN_COMPARE]);
>> -    mask =3D GETFIELD(PBCQ_NEST_IRSN_COMP,
>> +    mask =3D PNV_GETFIELD(PBCQ_NEST_IRSN_COMP,
>>                      pbcq->nest_regs[PBCQ_NEST_IRSN_MASK]);
>>      count =3D ((~mask) + 1) & 0x7ffff;
>>      phb->total_irq =3D count;
>> @@ -735,10 +737,10 @@ static void pnv_phb3_translate_tve(PnvPhb3DMASpa=
ce *ds, hwaddr addr,
>>                                     bool is_write, uint64_t tve,
>>                                     IOMMUTLBEntry *tlb)
>>  {
>> -    uint64_t tta =3D GETFIELD(IODA2_TVT_TABLE_ADDR, tve);
>> -    int32_t  lev =3D GETFIELD(IODA2_TVT_NUM_LEVELS, tve);
>> -    uint32_t tts =3D GETFIELD(IODA2_TVT_TCE_TABLE_SIZE, tve);
>> -    uint32_t tps =3D GETFIELD(IODA2_TVT_IO_PSIZE, tve);
>> +    uint64_t tta =3D PNV_GETFIELD(IODA2_TVT_TABLE_ADDR, tve);
>> +    int32_t  lev =3D PNV_GETFIELD(IODA2_TVT_NUM_LEVELS, tve);
>> +    uint32_t tts =3D PNV_GETFIELD(IODA2_TVT_TCE_TABLE_SIZE, tve);
>> +    uint32_t tps =3D PNV_GETFIELD(IODA2_TVT_IO_PSIZE, tve);
>>      PnvPHB3 *phb =3D ds->phb;
>> =20
>>      /* Invalid levels */
>> diff --git a/hw/pci-host/pnv_phb3_msi.c b/hw/pci-host/pnv_phb3_msi.c
>> index d645468f4a6f..f283d5cd7dc1 100644
>> --- a/hw/pci-host/pnv_phb3_msi.c
>> +++ b/hw/pci-host/pnv_phb3_msi.c
>> @@ -13,6 +13,7 @@
>>  #include "hw/pci-host/pnv_phb3_regs.h"
>>  #include "hw/pci-host/pnv_phb3.h"
>>  #include "hw/ppc/pnv.h"
>> +#include "hw/ppc/pnv_utils.h" /* SETFIELD() and GETFIELD() macros */
>>  #include "hw/pci/msi.h"
>>  #include "monitor/monitor.h"
>>  #include "hw/irq.h"
>> @@ -105,14 +106,15 @@ static void phb3_msi_try_send(Phb3MsiState *msi,=
 int srcno, bool force)
>>          return;
>>      }
>> =20
>> -    server =3D GETFIELD(IODA2_IVT_SERVER, ive);
>> -    prio =3D GETFIELD(IODA2_IVT_PRIORITY, ive);
>> +    server =3D PNV_GETFIELD(IODA2_IVT_SERVER, ive);
>> +    prio =3D PNV_GETFIELD(IODA2_IVT_PRIORITY, ive);
>>      if (!force) {
>> -        pq =3D GETFIELD(IODA2_IVT_Q, ive) | (GETFIELD(IODA2_IVT_P, iv=
e) << 1);
>> +        pq =3D PNV_GETFIELD(IODA2_IVT_Q, ive) |
>> +            (PNV_GETFIELD(IODA2_IVT_P, ive) << 1);
>>      } else {
>>          pq =3D 0;
>>      }
>> -    gen =3D GETFIELD(IODA2_IVT_GEN, ive);
>> +    gen =3D PNV_GETFIELD(IODA2_IVT_GEN, ive);
>> =20
>>      /*
>>       * The low order 2 bits are the link pointer (Type II interrupts)=
.
>> @@ -169,7 +171,7 @@ void pnv_phb3_msi_send(Phb3MsiState *msi, uint64_t=
 addr, uint16_t data,
>>          if (!phb3_msi_read_ive(msi->phb, src, &ive)) {
>>              return;
>>          }
>> -        pe =3D GETFIELD(IODA2_IVT_PE, ive);
>> +        pe =3D PNV_GETFIELD(IODA2_IVT_PE, ive);
>>          if (pe !=3D dev_pe) {
>>              qemu_log_mask(LOG_GUEST_ERROR,
>>                            "MSI %d send by PE#%d but assigned to PE#%d=
",
>> @@ -334,16 +336,16 @@ void pnv_phb3_msi_pic_print_info(Phb3MsiState *m=
si, Monitor *mon)
>>              return;
>>          }
>> =20
>> -        if (GETFIELD(IODA2_IVT_PRIORITY, ive) =3D=3D 0xff) {
>> +        if (PNV_GETFIELD(IODA2_IVT_PRIORITY, ive) =3D=3D 0xff) {
>>              continue;
>>          }
>> =20
>>          monitor_printf(mon, "  %4x %c%c server=3D%04x prio=3D%02x gen=
=3D%d\n",
>>                         ics->offset + i,
>> -                       GETFIELD(IODA2_IVT_P, ive) ? 'P' : '-',
>> -                       GETFIELD(IODA2_IVT_Q, ive) ? 'Q' : '-',
>> -                       (uint32_t) GETFIELD(IODA2_IVT_SERVER, ive) >> =
2,
>> -                       (uint32_t) GETFIELD(IODA2_IVT_PRIORITY, ive),
>> -                       (uint32_t) GETFIELD(IODA2_IVT_GEN, ive));
>> +                       PNV_GETFIELD(IODA2_IVT_P, ive) ? 'P' : '-',
>> +                       PNV_GETFIELD(IODA2_IVT_Q, ive) ? 'Q' : '-',
>> +                       (uint32_t) PNV_GETFIELD(IODA2_IVT_SERVER, ive)=
 >> 2,
>> +                       (uint32_t) PNV_GETFIELD(IODA2_IVT_PRIORITY, iv=
e),
>> +                       (uint32_t) PNV_GETFIELD(IODA2_IVT_GEN, ive));
>>      }
>>  }
>> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
>> index 23cf093928ed..ac824f877cf1 100644
>> --- a/hw/pci-host/pnv_phb4.c
>> +++ b/hw/pci-host/pnv_phb4.c
>> @@ -19,6 +19,7 @@
>>  #include "hw/pci/pcie_port.h"
>>  #include "hw/ppc/pnv.h"
>>  #include "hw/ppc/pnv_xscom.h"
>> +#include "hw/ppc/pnv_utils.h" /* SETFIELD() and GETFIELD() macros */
>>  #include "hw/irq.h"
>>  #include "hw/qdev-properties.h"
>> =20
>> @@ -26,22 +27,6 @@
>>      qemu_log_mask(LOG_GUEST_ERROR, "phb4[%d:%d]: " fmt "\n",         =
   \
>>                    (phb)->chip_id, (phb)->phb_id, ## __VA_ARGS__)
>> =20
>> -/*
>> - * QEMU version of the GETFIELD/SETFIELD macros
>> - *
>> - * These are common with the PnvXive model.
>> - */
>> -static inline uint64_t GETFIELD(uint64_t mask, uint64_t word)
>> -{
>> -    return (word & mask) >> ctz64(mask);
>> -}
>> -
>> -static inline uint64_t SETFIELD(uint64_t mask, uint64_t word,
>> -                                uint64_t value)
>> -{
>> -    return (word & ~mask) | ((value << ctz64(mask)) & mask);
>> -}
>> -
>>  static PCIDevice *pnv_phb4_find_cfg_dev(PnvPHB4 *phb)
>>  {
>>      PCIHostState *pci =3D PCI_HOST_BRIDGE(phb);
>> @@ -196,8 +181,8 @@ static void pnv_phb4_check_mbt(PnvPHB4 *phb, uint3=
2_t index)
>>      }
>> =20
>>      /* Grab geometry from registers */
>> -    base =3D GETFIELD(IODA3_MBT0_BASE_ADDR, mbe0) << 12;
>> -    size =3D GETFIELD(IODA3_MBT1_MASK, mbe1) << 12;
>> +    base =3D PNV_GETFIELD(IODA3_MBT0_BASE_ADDR, mbe0) << 12;
>> +    size =3D PNV_GETFIELD(IODA3_MBT1_MASK, mbe1) << 12;
>>      size |=3D 0xff00000000000000ull;
>>      size =3D ~size + 1;
>> =20
>> @@ -252,8 +237,8 @@ static uint64_t *pnv_phb4_ioda_access(PnvPHB4 *phb=
,
>>                                        unsigned *out_table, unsigned *=
out_idx)
>>  {
>>      uint64_t adreg =3D phb->regs[PHB_IODA_ADDR >> 3];
>> -    unsigned int index =3D GETFIELD(PHB_IODA_AD_TADR, adreg);
>> -    unsigned int table =3D GETFIELD(PHB_IODA_AD_TSEL, adreg);
>> +    unsigned int index =3D PNV_GETFIELD(PHB_IODA_AD_TADR, adreg);
>> +    unsigned int table =3D PNV_GETFIELD(PHB_IODA_AD_TSEL, adreg);
>>      unsigned int mask;
>>      uint64_t *tptr =3D NULL;
>> =20
>> @@ -318,7 +303,7 @@ static uint64_t *pnv_phb4_ioda_access(PnvPHB4 *phb=
,
>>      }
>>      if (adreg & PHB_IODA_AD_AUTOINC) {
>>          index =3D (index + 1) & mask;
>> -        adreg =3D SETFIELD(PHB_IODA_AD_TADR, adreg, index);
>> +        adreg =3D PNV_SETFIELD(PHB_IODA_AD_TADR, adreg, index);
>>      }
>> =20
>>      phb->regs[PHB_IODA_ADDR >> 3] =3D adreg;
>> @@ -369,7 +354,7 @@ static void pnv_phb4_ioda_write(PnvPHB4 *phb, uint=
64_t val)
>>      case IODA3_TBL_MIST: {
>>          /* Special mask for MIST partial write */
>>          uint64_t adreg =3D phb->regs[PHB_IODA_ADDR >> 3];
>> -        uint32_t mmask =3D GETFIELD(PHB_IODA_AD_MIST_PWV, adreg);
>> +        uint32_t mmask =3D PNV_GETFIELD(PHB_IODA_AD_MIST_PWV, adreg);
>>          uint64_t v =3D *tptr;
>>          if (mmask =3D=3D 0) {
>>              mmask =3D 0xf;
>> @@ -476,7 +461,7 @@ static void pnv_phb4_update_xsrc(PnvPHB4 *phb)
>>      phb->xsrc.esb_shift =3D shift;
>>      phb->xsrc.esb_flags =3D flags;
>> =20
>> -    lsi_base =3D GETFIELD(PHB_LSI_SRC_ID, phb->regs[PHB_LSI_SOURCE_ID=
 >> 3]);
>> +    lsi_base =3D PNV_GETFIELD(PHB_LSI_SRC_ID, phb->regs[PHB_LSI_SOURC=
E_ID >> 3]);
>>      lsi_base <<=3D 3;
>> =20
>>      /* TODO: handle reset values of PHB_LSI_SRC_ID */
>> @@ -747,12 +732,13 @@ static uint64_t pnv_phb4_xscom_read(void *opaque=
, hwaddr addr, unsigned size)
>>              return ~0ull;
>>          }
>>          size =3D (phb->scom_hv_ind_addr_reg & PHB_SCOM_HV_IND_ADDR_4B=
) ? 4 : 8;
>> -        offset =3D GETFIELD(PHB_SCOM_HV_IND_ADDR_ADDR, phb->scom_hv_i=
nd_addr_reg);
>> +        offset =3D PNV_GETFIELD(PHB_SCOM_HV_IND_ADDR_ADDR,
>> +                              phb->scom_hv_ind_addr_reg);
>>          val =3D pnv_phb4_reg_read(phb, offset, size);
>>          if (phb->scom_hv_ind_addr_reg & PHB_SCOM_HV_IND_ADDR_AUTOINC)=
 {
>>              offset +=3D size;
>>              offset &=3D 0x3fff;
>> -            phb->scom_hv_ind_addr_reg =3D SETFIELD(PHB_SCOM_HV_IND_AD=
DR_ADDR,
>> +            phb->scom_hv_ind_addr_reg =3D PNV_SETFIELD(PHB_SCOM_HV_IN=
D_ADDR_ADDR,
>>                                                   phb->scom_hv_ind_add=
r_reg,
>>                                                   offset);
>>          }
>> @@ -799,12 +785,13 @@ static void pnv_phb4_xscom_write(void *opaque, h=
waddr addr,
>>              break;
>>          }
>>          size =3D (phb->scom_hv_ind_addr_reg & PHB_SCOM_HV_IND_ADDR_4B=
) ? 4 : 8;
>> -        offset =3D GETFIELD(PHB_SCOM_HV_IND_ADDR_ADDR, phb->scom_hv_i=
nd_addr_reg);
>> +        offset =3D PNV_GETFIELD(PHB_SCOM_HV_IND_ADDR_ADDR,
>> +                              phb->scom_hv_ind_addr_reg);
>>          pnv_phb4_reg_write(phb, offset, val, size);
>>          if (phb->scom_hv_ind_addr_reg & PHB_SCOM_HV_IND_ADDR_AUTOINC)=
 {
>>              offset +=3D size;
>>              offset &=3D 0x3fff;
>> -            phb->scom_hv_ind_addr_reg =3D SETFIELD(PHB_SCOM_HV_IND_AD=
DR_ADDR,
>> +            phb->scom_hv_ind_addr_reg =3D PNV_SETFIELD(PHB_SCOM_HV_IN=
D_ADDR_ADDR,
>>                                                   phb->scom_hv_ind_add=
r_reg,
>>                                                   offset);
>>          }
>> @@ -860,7 +847,7 @@ static void pnv_phb4_set_irq(void *opaque, int irq=
_num, int level)
>>      if (irq_num > 3) {
>>          phb_error(phb, "IRQ %x is not an LSI", irq_num);
>>      }
>> -    lsi_base =3D GETFIELD(PHB_LSI_SRC_ID, phb->regs[PHB_LSI_SOURCE_ID=
 >> 3]);
>> +    lsi_base =3D PNV_GETFIELD(PHB_LSI_SRC_ID, phb->regs[PHB_LSI_SOURC=
E_ID >> 3]);
>>      lsi_base <<=3D 3;
>>      qemu_set_irq(phb->qirqs[lsi_base + irq_num], level);
>>  }
>> @@ -910,10 +897,10 @@ static void pnv_phb4_translate_tve(PnvPhb4DMASpa=
ce *ds, hwaddr addr,
>>                                     bool is_write, uint64_t tve,
>>                                     IOMMUTLBEntry *tlb)
>>  {
>> -    uint64_t tta =3D GETFIELD(IODA3_TVT_TABLE_ADDR, tve);
>> -    int32_t  lev =3D GETFIELD(IODA3_TVT_NUM_LEVELS, tve);
>> -    uint32_t tts =3D GETFIELD(IODA3_TVT_TCE_TABLE_SIZE, tve);
>> -    uint32_t tps =3D GETFIELD(IODA3_TVT_IO_PSIZE, tve);
>> +    uint64_t tta =3D PNV_GETFIELD(IODA3_TVT_TABLE_ADDR, tve);
>> +    int32_t  lev =3D PNV_GETFIELD(IODA3_TVT_NUM_LEVELS, tve);
>> +    uint32_t tts =3D PNV_GETFIELD(IODA3_TVT_TCE_TABLE_SIZE, tve);
>> +    uint32_t tps =3D PNV_GETFIELD(IODA3_TVT_IO_PSIZE, tve);
>> =20
>>      /* Invalid levels */
>>      if (lev > 4) {
>=20


