Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D773BC10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 09:24:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AECAB2133F
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 09:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AECAB2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFxLr-0005FG-U6
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 05:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iFxKh-0004Qx-Cs
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 05:23:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iFxKf-00086m-Hs
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 05:23:35 -0400
Received: from 5.mo1.mail-out.ovh.net ([178.33.45.107]:36304)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iFxKf-00085Z-6R
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 05:23:33 -0400
Received: from player759.ha.ovh.net (unknown [10.109.143.72])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id BBF381921E1
 for <qemu-devel@nongnu.org>; Thu,  3 Oct 2019 11:23:30 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player759.ha.ovh.net (Postfix) with ESMTPSA id 4EEFAA8E23F6;
 Thu,  3 Oct 2019 09:23:26 +0000 (UTC)
Subject: Re: [PATCH v4 14/25] ppc/xive: Introduce helpers for the NVT id
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190918160645.25126-1-clg@kaod.org>
 <20190918160645.25126-15-clg@kaod.org>
 <20191003021258.GL11105@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <65827861-df95-93f0-85cf-e0bae0816cdb@kaod.org>
Date: Thu, 3 Oct 2019 11:23:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191003021258.GL11105@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 13696009420371168153
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgeekgdduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.45.107
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/10/2019 04:12, David Gibson wrote:
> On Wed, Sep 18, 2019 at 06:06:34PM +0200, C=E9dric Le Goater wrote:
>> The NVT space is 19 bits wide, giving a maximum of 512K per chip. When
>> dispatched on a HW thread, the NVT identifier of a vCPU is pushed/stor=
ed
>> in the CAM line (word2) of the thread interrupt context.
>=20
> Ok, that's interesting, but how does it lead to this patch?  Connect
> the dots, please.

ok. These are helpers for the next patch. It's a clarification of the
values also.


When a vPCU is dispatched on a HW thread, the NVT identifier is pushed
in the CAM line (QW1W2). This identifier is used to fetch a NVT structure=
,
in the presenter subengine, which might contain pending interrupts that=20
need a resend. So we will use these helpers to do :=20

 xive_router_get_nvt(xrtr, nvt_blk, nvt_idx, &nvt)
 xive_router_write_nvt(xrtr, nvt_blk, nvt_idx, &nvt, 4)

and notify a cpu.

C.


>=20
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ppc/xive.h      |  5 -----
>>  include/hw/ppc/xive_regs.h | 21 +++++++++++++++++++++
>>  2 files changed, 21 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
>> index a461753f5da5..794dfcaae0f8 100644
>> --- a/include/hw/ppc/xive.h
>> +++ b/include/hw/ppc/xive.h
>> @@ -469,11 +469,6 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, Mon=
itor *mon);
>>  Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp)=
;
>>  void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t ring, uint8_t ipb);
>> =20
>> -static inline uint32_t xive_nvt_cam_line(uint8_t nvt_blk, uint32_t nv=
t_idx)
>> -{
>> -    return (nvt_blk << 19) | nvt_idx;
>> -}
>> -
>>  /*
>>   * KVM XIVE device helpers
>>   */
>> diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
>> index 08c8bf7172e2..3d7b6fd09664 100644
>> --- a/include/hw/ppc/xive_regs.h
>> +++ b/include/hw/ppc/xive_regs.h
>> @@ -251,4 +251,25 @@ typedef struct XiveNVT {
>> =20
>>  #define xive_nvt_is_valid(nvt)    (be32_to_cpu((nvt)->w0) & NVT_W0_VA=
LID)
>> =20
>> +/*
>> + * The VP number space in a block is defined by the END_W6_NVT_INDEX
>> + * field of the XIVE END
>> + */
>> +#define XIVE_NVT_SHIFT                19
>> +
>> +static inline uint32_t xive_nvt_cam_line(uint8_t nvt_blk, uint32_t nv=
t_idx)
>> +{
>> +    return (nvt_blk << XIVE_NVT_SHIFT) | nvt_idx;
>> +}
>> +
>> +static inline uint32_t xive_nvt_idx(uint32_t cam_line)
>> +{
>> +    return cam_line & ((1 << XIVE_NVT_SHIFT) - 1);
>> +}
>> +
>> +static inline uint32_t xive_nvt_blk(uint32_t cam_line)
>> +{
>> +    return (cam_line >> XIVE_NVT_SHIFT) & 0xf;
>> +}
>> +
>>  #endif /* PPC_XIVE_REGS_H */
>=20


