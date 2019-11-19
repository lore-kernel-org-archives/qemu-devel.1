Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE68C432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 06:51:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4434222D1
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 06:51:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4434222D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWxMO-00055x-OZ
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 01:51:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37612)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iWxLa-0004FN-2C
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 01:50:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iWxLZ-0003Im-0D
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 01:50:45 -0500
Received: from 3.mo3.mail-out.ovh.net ([46.105.44.175]:33571)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iWxEW-000682-Ur
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 01:43:29 -0500
Received: from player789.ha.ovh.net (unknown [10.109.146.240])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id A3FC42319E8
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 07:43:25 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player789.ha.ovh.net (Postfix) with ESMTPSA id 02D57C3701A4;
 Tue, 19 Nov 2019 06:43:21 +0000 (UTC)
Subject: Re: [PATCH] ppc/pnv: Add a LPC "ranges" property
To: David Gibson <david@gibson.dropbear.id.au>
References: <20191118091908.15044-1-clg@kaod.org>
 <20191119004938.GG5582@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <087a43b4-a376-f593-b23f-391b3779e466@kaod.org>
Date: Tue, 19 Nov 2019 07:43:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191119004938.GG5582@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 10307895122580769619
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudegjedgleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefheenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejkeelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.44.175
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

On 19/11/2019 01:49, David Gibson wrote:
> On Mon, Nov 18, 2019 at 10:19:08AM +0100, C=E9dric Le Goater wrote:
>> And fix a typo in the MEM address space definition.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> Applied to ppc-for-5.0.  AFAICT this is a bugfix (amongst other
> things), but I don't think pnv is widely used enough to put this into
> 4.2 during hard freeze.

yes. I am trying to fix the dtc warnings before and after OPAL runs.=20

C.
=20
>> ---
>>  hw/ppc/pnv_lpc.c | 14 +++++++++++++-
>>  1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
>> index fb9f93032020..c5a85c38c783 100644
>> --- a/hw/ppc/pnv_lpc.c
>> +++ b/hw/ppc/pnv_lpc.c
>> @@ -86,7 +86,7 @@ enum {
>>  #define ISA_FW_SIZE             0x10000000
>>  #define LPC_IO_OPB_ADDR         0xd0010000
>>  #define LPC_IO_OPB_SIZE         0x00010000
>> -#define LPC_MEM_OPB_ADDR        0xe0010000
>> +#define LPC_MEM_OPB_ADDR        0xe0000000
>>  #define LPC_MEM_OPB_SIZE        0x10000000
>>  #define LPC_FW_OPB_ADDR         0xf0000000
>>  #define LPC_FW_OPB_SIZE         0x10000000
>> @@ -143,6 +143,16 @@ int pnv_dt_lpc(PnvChip *chip, void *fdt, int root=
_offset)
>>                              cpu_to_be32(PNV9_LPCM_SIZE >> 32),
>>                              cpu_to_be32((uint32_t)PNV9_LPCM_SIZE),
>>      };
>> +    uint32_t lpc_ranges[12] =3D { 0, 0,
>> +                                cpu_to_be32(LPC_MEM_OPB_ADDR),
>> +                                cpu_to_be32(LPC_MEM_OPB_SIZE),
>> +                                cpu_to_be32(1), 0,
>> +                                cpu_to_be32(LPC_IO_OPB_ADDR),
>> +                                cpu_to_be32(LPC_IO_OPB_SIZE),
>> +                                cpu_to_be32(3), 0,
>> +                                cpu_to_be32(LPC_FW_OPB_ADDR),
>> +                                cpu_to_be32(LPC_FW_OPB_SIZE),
>> +    };
>>      uint32_t reg[2];
>> =20
>>      /*
>> @@ -211,6 +221,8 @@ int pnv_dt_lpc(PnvChip *chip, void *fdt, int root_=
offset)
>>      _FDT((fdt_setprop_cell(fdt, offset, "#size-cells", 1)));
>>      _FDT((fdt_setprop(fdt, offset, "compatible", lpc_compat,
>>                        sizeof(lpc_compat))));
>> +    _FDT((fdt_setprop(fdt, offset, "ranges", lpc_ranges,
>> +                      sizeof(lpc_ranges))));
>> =20
>>      return 0;
>>  }
>=20


