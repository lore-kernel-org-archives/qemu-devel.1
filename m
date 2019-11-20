Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9976CC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 08:40:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 713F421852
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 08:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 713F421852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXLXP-0005Xn-Ju
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 03:40:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34332)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iXLWj-0004WM-PG
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 03:39:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iXLWi-0000El-E3
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 03:39:53 -0500
Received: from 13.mo1.mail-out.ovh.net ([178.33.253.128]:32862)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iXLWi-0000E1-7a
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 03:39:52 -0500
Received: from player734.ha.ovh.net (unknown [10.108.57.18])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id DCE3719C12A
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 09:39:48 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player734.ha.ovh.net (Postfix) with ESMTPSA id BD0CCC3E00B7;
 Wed, 20 Nov 2019 08:39:43 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v5 04/23] ppc/pnv: Dump the XIVE NVT table
To: David Gibson <david@gibson.dropbear.id.au>
References: <20191115162436.30548-1-clg@kaod.org>
 <20191115162436.30548-5-clg@kaod.org> <20191119220655.GY5582@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a0a83e1a-a861-2644-a7bf-854fd5cdde77@kaod.org>
Date: Wed, 20 Nov 2019 09:39:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191119220655.GY5582@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 18146128798643227475
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudegledguddvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeehnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeefgedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.253.128
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

On 19/11/2019 23:06, David Gibson wrote:
> On Fri, Nov 15, 2019 at 05:24:17PM +0100, C=E9dric Le Goater wrote:
>> This is useful to dump the saved contexts of the vCPUs : configuration
>> of the base END index of the vCPU and the Interrupt Pending Buffer
>> register, which is updated when an interrupt can not be presented.
>>
>> When dumping the NVT table, we skip empty indirect pages which are not
>> necessarily allocated.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ppc/xive_regs.h |  2 ++
>>  hw/intc/pnv_xive.c         | 30 ++++++++++++++++++++++++++++++
>>  2 files changed, 32 insertions(+)
>>
>> diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
>> index 1a5622f8ded8..94338b4b551e 100644
>> --- a/include/hw/ppc/xive_regs.h
>> +++ b/include/hw/ppc/xive_regs.h
>> @@ -252,6 +252,8 @@ typedef struct XiveNVT {
>>          uint32_t        w0;
>>  #define NVT_W0_VALID             PPC_BIT32(0)
>>          uint32_t        w1;
>> +#define NVT_W1_EQ_BLOCK          PPC_BITMASK32(0, 3)
>> +#define NVT_W1_EQ_INDEX          PPC_BITMASK32(4, 31)
>>          uint32_t        w2;
>>          uint32_t        w3;
>>          uint32_t        w4;
>> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
>> index a4d80fd5e79c..02faf4135e48 100644
>> --- a/hw/intc/pnv_xive.c
>> +++ b/hw/intc/pnv_xive.c
>> @@ -1554,6 +1554,27 @@ static const MemoryRegionOps pnv_xive_pc_ops =3D=
 {
>>      },
>>  };
>> =20
>> +/*
>> + * skiboot uses an indirect NVT table with 64k subpages
>> + */
>> +#define XIVE_NVT_COUNT          (1 << XIVE_NVT_SHIFT)
>> +#define XIVE_NVT_PER_PAGE       (0x10000 / sizeof(XiveNVT))

First of all, this is an optimization to skip ranges of NVTs when=20
an indirect page is empty. two assumptions are made : indirect table
and page size.

> Hrm.  So skiboot uses 64kiB pages, but how does the hardware know
> that? Is the hw fixed to 64kiB pages, or is there some register
> controlling the subpage size? =20

The indirect page size is a field of the VSD structure describing the
pages.

> In which case shouldn't you be looking at that rather than assuming
> 64kiB?

Something cleaner would be :=20

+static uint64_t pnv_xive_vst_per_page(PnvXive *xive, uint32_t type)
+{
+    uint8_t blk =3D pnv_xive_block_id(xive);
+    uint64_t vsd =3D xive->vsds[type][blk];
+    const XiveVstInfo *info =3D &vst_infos[type];
+    uint64_t vsd_addr;
+    uint32_t page_shift;
+
+    /* Get the page size of the indirect table. */
+    vsd_addr =3D vsd & VSD_ADDRESS_MASK;
+    vsd =3D ldq_be_dma(&address_space_memory, vsd_addr);
+
+    if (!(vsd & VSD_ADDRESS_MASK)) {
+#ifdef XIVE_DEBUG
+        xive_error(xive, "VST: invalid %s entry %x !?", info->name, idx)=
;
+#endif
+        return 0;
+    }
+
+    page_shift =3D GETFIELD(VSD_TSIZE, vsd) + 12;
+
+    if (!pnv_xive_vst_page_size_allowed(page_shift)) {
+        xive_error(xive, "VST: invalid %s page shift %d", info->name,
+                   page_shift);
+        return 0;
+    }
+
+    return (1ull << page_shift) / info->size;
+}
+
+
 #define XIVE_NVT_COUNT          (1 << XIVE_NVT_SHIFT)
-#define XIVE_NVT_PER_PAGE       (0x10000 / sizeof(XiveNVT))
+#define XIVE_NVT_PER_PAGE(xive) pnv_xive_vst_per_page(xive, VST_TSEL_VPD=
T)
=20

I will rework that patch and try to keep the info pic command simple.=20

C.

>> +static void xive_nvt_pic_print_info(XiveNVT *nvt, uint32_t nvt_idx,
>> +                                    Monitor *mon)
>> +{
>> +    uint8_t  eq_blk =3D xive_get_field32(NVT_W1_EQ_BLOCK, nvt->w1);
>> +    uint32_t eq_idx =3D xive_get_field32(NVT_W1_EQ_INDEX, nvt->w1);
>> +
>> +    if (!xive_nvt_is_valid(nvt)) {
>> +        return;
>> +    }
>> +
>> +    monitor_printf(mon, "  %08x end:%02x/%04x IPB:%02x\n", nvt_idx,
>> +                   eq_blk, eq_idx,
>> +                   xive_get_field32(NVT_W4_IPB, nvt->w4));
>> +}
>> +
>>  void pnv_xive_pic_print_info(PnvXive *xive, Monitor *mon)
>>  {
>>      XiveRouter *xrtr =3D XIVE_ROUTER(xive);
>> @@ -1562,6 +1583,7 @@ void pnv_xive_pic_print_info(PnvXive *xive, Moni=
tor *mon)
>>      uint32_t nr_ipis =3D pnv_xive_nr_ipis(xive, blk);
>>      XiveEAS eas;
>>      XiveEND end;
>> +    XiveNVT nvt;
>>      int i;
>> =20
>>      monitor_printf(mon, "XIVE[%x] Source %08x .. %08x\n", blk, srcno0=
,
>> @@ -1590,6 +1612,14 @@ void pnv_xive_pic_print_info(PnvXive *xive, Mon=
itor *mon)
>>      while (!xive_router_get_end(xrtr, blk, i, &end)) {
>>          xive_end_eas_pic_print_info(&end, i++, mon);
>>      }
>> +
>> +    monitor_printf(mon, "XIVE[%x] NVTT %08x .. %08x\n", blk, 0,
>> +                   XIVE_NVT_COUNT - 1);
>> +    for (i =3D 0; i < XIVE_NVT_COUNT; i +=3D XIVE_NVT_PER_PAGE) {
>> +        while (!xive_router_get_nvt(xrtr, blk, i, &nvt)) {
>> +            xive_nvt_pic_print_info(&nvt, i++, mon);
>> +        }
>> +    }
>>  }
>> =20
>>  static void pnv_xive_reset(void *dev)
>=20


