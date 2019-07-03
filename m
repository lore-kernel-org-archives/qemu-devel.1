Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB578C5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 05:55:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B179D21871
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 05:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B179D21871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiYFG-0005nN-NQ
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 01:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42564)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hiYEZ-0005Az-H0
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 01:55:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hiYEY-0001Hz-49
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 01:55:11 -0400
Received: from 11.mo7.mail-out.ovh.net ([87.98.173.157]:37459)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hiYEX-0001Dq-U8
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 01:55:10 -0400
Received: from player787.ha.ovh.net (unknown [10.109.159.248])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id B1E64125356
 for <qemu-devel@nongnu.org>; Wed,  3 Jul 2019 07:55:06 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player787.ha.ovh.net (Postfix) with ESMTPSA id 44D5179B4CCF;
 Wed,  3 Jul 2019 05:54:58 +0000 (UTC)
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190630204601.30574-1-clg@kaod.org>
 <20190630204601.30574-9-clg@kaod.org> <20190703020748.GD9442@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <08faf669-72a7-8f30-d33c-2e285405005c@kaod.org>
Date: Wed, 3 Jul 2019 07:54:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190703020748.GD9442@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 4843902875255343955
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrvdelgddutddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.173.157
Subject: Re: [Qemu-devel] [PATCH 08/10] ppc/xive: Extend XiveTCTX with an
 router object pointer
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/07/2019 04:07, David Gibson wrote:
> On Sun, Jun 30, 2019 at 10:45:59PM +0200, C=E9dric Le Goater wrote:
>> This is to perform lookups in the NVT table when a vCPU is dispatched
>> and possibly resend interrupts.
>=20
> I'm slightly confused by this one.  Aren't there multiple router
> objects, each of which can deliver to any thread?  In which case what
> router object is associated with a specific TCTX?

when a vCPU is dispatched on a HW thread, the hypervisor does a store=20
on the CAM line to store the VP id. At that time, it checks the IPB in=20
the associated NVT structure and notifies the thread if an interrupt is=20
pending.=20

We need to do a NVT lookup, just like the presenter in HW, hence the=20
router pointer. You should look at the following patch which clarifies=20
the resend sequence.

=20
>> Future XIVE chip will use a different class for the model of the
>> interrupt controller. So use an 'Object *' instead of a 'XiveRouter *'=
.
>=20
> This seems odd to me, shouldn't it be an interface pointer or
> something in that case?

I have duplicated most of the XIVE models for P10 because the internal=20
structures have changed. I managed to keep the XiveSource and XiveTCTX=20
but we now have a Xive10Router, this is the reason why.

If I was to duplicate XiveTCTX also, I will switch it back to a XiveRoute=
r=20
pointer in the P9 version.=20

C.


>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
>> ---
>>  include/hw/ppc/xive.h |  4 +++-
>>  hw/intc/xive.c        | 11 ++++++++++-
>>  hw/ppc/pnv.c          |  2 +-
>>  hw/ppc/spapr_irq.c    |  2 +-
>>  4 files changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
>> index d922524982d3..b764e1e4e6d4 100644
>> --- a/include/hw/ppc/xive.h
>> +++ b/include/hw/ppc/xive.h
>> @@ -321,6 +321,8 @@ typedef struct XiveTCTX {
>>      qemu_irq    os_output;
>> =20
>>      uint8_t     regs[XIVE_TM_RING_COUNT * XIVE_TM_RING_SIZE];
>> +
>> +    Object      *xrtr;
>>  } XiveTCTX;
>> =20
>>  /*
>> @@ -416,7 +418,7 @@ void xive_tctx_tm_write(XiveTCTX *tctx, hwaddr off=
set, uint64_t value,
>>  uint64_t xive_tctx_tm_read(XiveTCTX *tctx, hwaddr offset, unsigned si=
ze);
>> =20
>>  void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon);
>> -Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp)=
;
>> +Object *xive_tctx_create(Object *cpu, Object *xrtr, Error **errp);
>> =20
>>  static inline uint32_t xive_nvt_cam_line(uint8_t nvt_blk, uint32_t nv=
t_idx)
>>  {
>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>> index f7ba1c3b622f..56700681884f 100644
>> --- a/hw/intc/xive.c
>> +++ b/hw/intc/xive.c
>> @@ -573,6 +573,14 @@ static void xive_tctx_realize(DeviceState *dev, E=
rror **errp)
>>      Object *obj;
>>      Error *local_err =3D NULL;
>> =20
>> +    obj =3D object_property_get_link(OBJECT(dev), "xrtr", &local_err)=
;
>> +    if (!obj) {
>> +        error_propagate(errp, local_err);
>> +        error_prepend(errp, "required link 'xrtr' not found: ");
>> +        return;
>> +    }
>> +    tctx->xrtr =3D obj;
>> +
>>      obj =3D object_property_get_link(OBJECT(dev), "cpu", &local_err);
>>      if (!obj) {
>>          error_propagate(errp, local_err);
>> @@ -657,7 +665,7 @@ static const TypeInfo xive_tctx_info =3D {
>>      .class_init    =3D xive_tctx_class_init,
>>  };
>> =20
>> -Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp)
>> +Object *xive_tctx_create(Object *cpu, Object *xrtr, Error **errp)
>>  {
>>      Error *local_err =3D NULL;
>>      Object *obj;
>> @@ -666,6 +674,7 @@ Object *xive_tctx_create(Object *cpu, XiveRouter *=
xrtr, Error **errp)
>>      object_property_add_child(cpu, TYPE_XIVE_TCTX, obj, &error_abort)=
;
>>      object_unref(obj);
>>      object_property_add_const_link(obj, "cpu", cpu, &error_abort);
>> +    object_property_add_const_link(obj, "xrtr", xrtr, &error_abort);
>>      object_property_set_bool(obj, true, "realized", &local_err);
>>      if (local_err) {
>>          goto error;
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index b87e01e5b925..11916dc273c2 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -765,7 +765,7 @@ static void pnv_chip_power9_intc_create(PnvChip *c=
hip, PowerPCCPU *cpu,
>>       * controller object is initialized afterwards. Hopefully, it's
>>       * only used at runtime.
>>       */
>> -    obj =3D xive_tctx_create(OBJECT(cpu), XIVE_ROUTER(&chip9->xive), =
&local_err);
>> +    obj =3D xive_tctx_create(OBJECT(cpu), OBJECT(&chip9->xive), &loca=
l_err);
>>      if (local_err) {
>>          error_propagate(errp, local_err);
>>          return;
>> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
>> index b2b01e850de8..5b3c3c50967b 100644
>> --- a/hw/ppc/spapr_irq.c
>> +++ b/hw/ppc/spapr_irq.c
>> @@ -353,7 +353,7 @@ static void spapr_irq_cpu_intc_create_xive(SpaprMa=
chineState *spapr,
>>      Object *obj;
>>      SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
>> =20
>> -    obj =3D xive_tctx_create(OBJECT(cpu), XIVE_ROUTER(spapr->xive), &=
local_err);
>> +    obj =3D xive_tctx_create(OBJECT(cpu), OBJECT(spapr->xive), &local=
_err);
>>      if (local_err) {
>>          error_propagate(errp, local_err);
>>          return;
>=20


