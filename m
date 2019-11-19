Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77AFC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:24:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C9312082F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C9312082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX6Il-0004jj-G0
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 11:24:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34233)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iX66y-0007C1-5A
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:12:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iX66w-0008GS-Qn
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:12:15 -0500
Received: from 9.mo6.mail-out.ovh.net ([87.98.171.146]:46078)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iX66w-0008En-I1
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:12:14 -0500
Received: from player786.ha.ovh.net (unknown [10.109.146.32])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id A04A81ED15F
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 17:12:10 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player786.ha.ovh.net (Postfix) with ESMTPSA id 3D157C5F4A84;
 Tue, 19 Nov 2019 16:12:06 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v5 02/23] ppc/xive: Introduce helpers for the NVT
 id
To: Greg Kurz <groug@kaod.org>
References: <20191115162436.30548-1-clg@kaod.org>
 <20191115162436.30548-3-clg@kaod.org> <20191119150403.02a78ace@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <384b6e95-feda-de56-4131-43da3165b3d8@kaod.org>
Date: Tue, 19 Nov 2019 17:12:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191119150403.02a78ace@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 1466484632900111187
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudegkedgkeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpudelhedrvdduvddrvdelrdduieeinecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejkeeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.171.146
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/11/2019 15:04, Greg Kurz wrote:
> On Fri, 15 Nov 2019 17:24:15 +0100
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> Each vCPU in the system is identified with an NVT identifier which is
>> pushed in the OS CAM line (QW1W2) of the HW thread interrupt context
>> register when the vCPU is dispatched on a HW thread. This identifier
>> is used by the presenter subengine to find a matching target to notify
>> of an event. It is also used to fetch the associate NVT structure
>> which may contain pending interrupts that need a resend.
>>
>> Add a couple of helpers for the NVT ids. The NVT space is 19 bits
>> wide, giving a maximum of 512K per chip.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ppc/xive.h      |  5 -----
>>  include/hw/ppc/xive_regs.h | 21 +++++++++++++++++++++
>>  2 files changed, 21 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
>> index 8fd439ec9bba..fa7adf87feb2 100644
>> --- a/include/hw/ppc/xive.h
>> +++ b/include/hw/ppc/xive.h
>> @@ -418,11 +418,6 @@ Object *xive_tctx_create(Object *cpu, XiveRouter =
*xrtr, Error **errp);
>>  void xive_tctx_reset(XiveTCTX *tctx);
>>  void xive_tctx_destroy(XiveTCTX *tctx);
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
>> index 530f232b04f8..1a5622f8ded8 100644
>> --- a/include/hw/ppc/xive_regs.h
>> +++ b/include/hw/ppc/xive_regs.h
>> @@ -272,4 +272,25 @@ typedef struct XiveNVT {
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
>=20
> Shouldn't we ensure nvt_idx fits in the 19 bits ?

yes. We should use the END_W6_NVT_INDEX mask. We are fine today because
the NVT index is extracted from the end w6 using xive_get_field32() or=20
computed from the PIR using the appropriate mask.

Something to improve.=20

>=20
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


