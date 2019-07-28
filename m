Return-Path: <SRS0=P1lm=VZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E43C433FF
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2019 09:07:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BFFE2070D
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2019 09:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BFFE2070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hrf98-00018l-B5
	for qemu-devel@archiver.kernel.org; Sun, 28 Jul 2019 05:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38798)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hrf8c-0000di-Rn
 for qemu-devel@nongnu.org; Sun, 28 Jul 2019 05:06:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hrf8b-0000kD-Fk
 for qemu-devel@nongnu.org; Sun, 28 Jul 2019 05:06:42 -0400
Received: from 6.mo6.mail-out.ovh.net ([87.98.177.69]:35718)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hrf8b-0000XV-6N
 for qemu-devel@nongnu.org; Sun, 28 Jul 2019 05:06:41 -0400
Received: from player756.ha.ovh.net (unknown [10.109.160.153])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id D01711D7419
 for <qemu-devel@nongnu.org>; Sun, 28 Jul 2019 11:06:31 +0200 (CEST)
Received: from kaod.org (bad36-1-78-202-132-1.fbx.proxad.net [78.202.132.1])
 (Authenticated sender: clg@kaod.org)
 by player756.ha.ovh.net (Postfix) with ESMTPSA id A5BF278F29F5;
 Sun, 28 Jul 2019 09:06:27 +0000 (UTC)
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190718115420.19919-1-clg@kaod.org>
 <20190718115420.19919-10-clg@kaod.org> <20190728074602.GF5110@umbus>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <024c66ef-b622-54ce-1ed3-3716cf6102f1@kaod.org>
Date: Sun, 28 Jul 2019 11:06:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190728074602.GF5110@umbus>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 7320319720980843347
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrkeelgddufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.177.69
Subject: Re: [Qemu-devel] [PATCH v2 09/17] ppc/xive: Extend XiveTCTX with a
 XiveRouter pointer
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

On 28/07/2019 09:46, David Gibson wrote:
> On Thu, Jul 18, 2019 at 01:54:12PM +0200, C=E9dric Le Goater wrote:
>> This is to perform lookups in the NVT table when a vCPU is dispatched
>> and possibily resend interrupts.
>>
>> Future XIVE chip will use a different class for the model of the
>> interrupt controller and we might need to change the type of
>> 'XiveRouter *' to 'Object *'
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> Hrm.  This still bothers me.=20

Your feeling is right. There should be a good reason to link two objects=20
together as it can be an issue later on (such P10). It should not be an=20
hidden parameter to function calls. this is more or less the case.=20
=20
See below for more explanation.

> AIUI there can be multiple XiveRouters in the system, yes? =20

yes and it works relatively well with 4 chips. I say relatively because=20
the presenter model is taking a shortcut we should fix.=20

> And at least theoretically can present irqs from multiple routers?=20

Yes. the console being the most simple example. We only have one device=20
per system on the LPC bus of chip 0.=20
=20
> In which case what's the rule for which one should be associated with=20
> a specific.
> I guess it's the one on the same chip, but that needs to be explained
> up front, with some justification of why that's the relevant one.

Yes. we try to minimize the traffic on the PowerBUS so generally CPU=20
targets are on the same IC. The EAT on POWER10 should be on the same
HW chip.


I think we can address the proposed changes from another perspective,=20
from the presenter one. this is cleaner and reflects better the HW design=
.=20

The thread contexts are owned by the presenter. It can scan its list=20
when doing CAM matching and when the thread context registers are being=20
accessed by a CPU. Adding a XiveRouter parameter to all the TIMA=20
operations seems like a better option and solves the problem.
=20

The thread context registers are modeled under the CPU object today=20
because it was practical for sPAPR but on HW, these are SRAM entries,
one for each HW thread of the chip. So may be, we should have introduced
an other table under the XiveRouter to model the contexts but there
was no real need for the XIVE POWER9 IC of the pseries machine. This=20
design might be reaching its limits with PowerNV and POWER10. =20


Looking at :
=20
  [PATCH v2 15/17] ppc/pnv: Grab the XiveRouter object from XiveTCTX in p=
nv_xive_get_tctx()

we see that the code adds an extra check on the THREAD_ENABLE registers=20
and for that, its needs the IC to which belongs the thread context. This=20
code is wrong. We should not be need to find a XiveRouter object from a=20
XiveRouter handler.

This is because the xive_presenter_match() routine does:
                      =20
    CPU_FOREACH(cs) {
        XiveTCTX *tctx =3D xive_router_get_tctx(xrtr, cs);
=20
we should be, instead, looping on the different IC of the system=20
looking for a match. Something else to fix. I think I will use the
PIR to match the CPU of a chip.


Looking at POWER10, XIVE internal structures have changed and we will
need to introduce new IC models, one for PowerNV obviously but surely=20
also one for pseries. A third one ... yes, sorry about that. If we go=20
in that direction, it would be good to have a common XiveTCTX and not=20
link it to a specific XiveRouter (P9 or P10). Another good reason not
to use that link.


So I will rework the end of that patchset. Thanks for having given me=20
time to think more about it before merging. I did more experiments and
the models are now more precise, specially with guest and multichip
support.=20


C.

=20
>=20
>> ---
>>  include/hw/ppc/xive.h | 2 ++
>>  hw/intc/xive.c        | 9 +++++++++
>>  2 files changed, 11 insertions(+)
>>
>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
>> index 4851ff87e795..206b23ecfab3 100644
>> --- a/include/hw/ppc/xive.h
>> +++ b/include/hw/ppc/xive.h
>> @@ -320,6 +320,8 @@ typedef struct XiveTCTX {
>>      qemu_irq    os_output;
>> =20
>>      uint8_t     regs[XIVE_TM_RING_COUNT * XIVE_TM_RING_SIZE];
>> +
>> +    struct XiveRouter  *xrtr;
>>  } XiveTCTX;
>> =20
>>  /*
>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>> index 88f2e560db0f..1b0eccb6df40 100644
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
>> +    tctx->xrtr =3D XIVE_ROUTER(obj);
>> +
>>      obj =3D object_property_get_link(OBJECT(dev), "cpu", &local_err);
>>      if (!obj) {
>>          error_propagate(errp, local_err);
>> @@ -666,6 +674,7 @@ Object *xive_tctx_create(Object *cpu, XiveRouter *=
xrtr, Error **errp)
>>      object_property_add_child(cpu, TYPE_XIVE_TCTX, obj, &error_abort)=
;
>>      object_unref(obj);
>>      object_property_add_const_link(obj, "cpu", cpu, &error_abort);
>> +    object_property_add_const_link(obj, "xrtr", OBJECT(xrtr), &error_=
abort);
>>      object_property_set_bool(obj, true, "realized", &local_err);
>>      if (local_err) {
>>          goto error;
>=20


