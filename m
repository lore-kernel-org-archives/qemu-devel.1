Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61EDC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 15:58:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B7E621A44
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 15:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B7E621A44
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWjPw-0006Ln-N1
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 10:58:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42601)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iWjPE-0005nY-28
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:57:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iWjPC-0005Fa-Rx
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:57:35 -0500
Received: from 15.mo4.mail-out.ovh.net ([91.121.62.11]:34559)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iWjPC-0005Ef-MG
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:57:34 -0500
Received: from player798.ha.ovh.net (unknown [10.109.143.223])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 0E8A72131B5
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 16:57:31 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player798.ha.ovh.net (Postfix) with ESMTPSA id 07141C493617;
 Mon, 18 Nov 2019 15:57:26 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v5 01/23] ppc/xive: Record the IPB in the
 associated NVT
To: Greg Kurz <groug@kaod.org>
References: <20191115162436.30548-1-clg@kaod.org>
 <20191115162436.30548-2-clg@kaod.org> <20191118164411.2045c2e2@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <34679878-fa5d-2e03-f699-5e6218fe4f08@kaod.org>
Date: Mon, 18 Nov 2019 16:57:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191118164411.2045c2e2@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 13793118284528061267
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudegiedgiedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejleekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.121.62.11
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

On 18/11/2019 16:44, Greg Kurz wrote:
> On Fri, 15 Nov 2019 17:24:14 +0100
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> When an interrupt can not be presented to a vCPU, because it is not
>> running on any of the HW treads, the XIVE presenter updates the
>> Interrupt Pending Buffer register of the associated XIVE NVT
>> structure. This is only done if backlog is activated in the END but
>> this is generally the case.
>>
>> The current code assumes that the fields of the NVT structure is
>> architected with the same layout of the thread interrupt context
>> registers. Fix this assumption and define an offset for the IPB
>> register backup value in the NVT.
>>
>=20
> Does this fix a visible bug in the powernv machine ? If so,
> maybe worth describing the symptoms.

no. this is a preliminary work for escalation suppport and to dump=20
the contents of the NVT table.
=20
> Anyway, this seems conforment to the XIVE spec I have, so FWIW:

FYI, the NVT structure evolves in the XIVE2 specs.

C.
=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ppc/xive_regs.h |  1 +
>>  hw/intc/xive.c             | 11 +++++++++--
>>  2 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
>> index 55307cd1533c..530f232b04f8 100644
>> --- a/include/hw/ppc/xive_regs.h
>> +++ b/include/hw/ppc/xive_regs.h
>> @@ -255,6 +255,7 @@ typedef struct XiveNVT {
>>          uint32_t        w2;
>>          uint32_t        w3;
>>          uint32_t        w4;
>> +#define NVT_W4_IPB               PPC_BITMASK32(16, 23)
>>          uint32_t        w5;
>>          uint32_t        w6;
>>          uint32_t        w7;
>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>> index 3d472e29c858..177663d2b43e 100644
>> --- a/hw/intc/xive.c
>> +++ b/hw/intc/xive.c
>> @@ -1607,14 +1607,21 @@ static void xive_router_end_notify(XiveRouter =
*xrtr, uint8_t end_blk,
>>       * - logical server : forward request to IVPE (not supported)
>>       */
>>      if (xive_end_is_backlog(&end)) {
>> +        uint8_t ipb;
>> +
>>          if (format =3D=3D 1) {
>>              qemu_log_mask(LOG_GUEST_ERROR,
>>                            "XIVE: END %x/%x invalid config: F1 & backl=
og\n",
>>                            end_blk, end_idx);
>>              return;
>>          }
>> -        /* Record the IPB in the associated NVT structure */
>> -        ipb_update((uint8_t *) &nvt.w4, priority);
>> +        /*
>> +         * Record the IPB in the associated NVT structure for later
>> +         * use. The presenter will resend the interrupt when the vCPU
>> +         * is dispatched again on a HW thread.
>> +         */
>> +        ipb =3D xive_get_field32(NVT_W4_IPB, nvt.w4) | priority_to_ip=
b(priority);
>> +        nvt.w4 =3D xive_set_field32(NVT_W4_IPB, nvt.w4, ipb);
>>          xive_router_write_nvt(xrtr, nvt_blk, nvt_idx, &nvt, 4);
>> =20
>>          /*
>=20


