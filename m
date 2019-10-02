Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A8AC35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 07:32:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F827206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 07:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F827206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFZ7c-0005qJ-OK
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 03:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iFZ6d-0005Gs-5r
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 03:31:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iFZ6b-0006vf-R0
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 03:31:26 -0400
Received: from 4.mo177.mail-out.ovh.net ([46.105.37.72]:45992)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iFZ6b-0006up-H2
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 03:31:25 -0400
Received: from player738.ha.ovh.net (unknown [10.109.143.189])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 5582710CB3F
 for <qemu-devel@nongnu.org>; Wed,  2 Oct 2019 09:31:22 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player738.ha.ovh.net (Postfix) with ESMTPSA id 57F88A963622;
 Wed,  2 Oct 2019 07:31:09 +0000 (UTC)
Subject: Re: [PATCH v3 22/34] spapr, xics, xive: Move cpu_intc_create from
 SpaprIrq to SpaprInterruptController
To: David Gibson <david@gibson.dropbear.id.au>
References: <20191002025208.3487-1-david@gibson.dropbear.id.au>
 <20191002025208.3487-23-david@gibson.dropbear.id.au>
 <360fd118-81c2-7ba1-2faf-d735d887d955@kaod.org>
 <3118503c-10a2-507a-46e5-da0847d7135e@kaod.org>
 <20191002064015.GY11105@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a6058ebc-9d52-ecf2-9b6f-2329bcbec550@kaod.org>
Date: Wed, 2 Oct 2019 09:31:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191002064015.GY11105@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 5929270385812999065
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgeehgdduvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.37.72
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/10/2019 08:40, David Gibson wrote:
> On Wed, Oct 02, 2019 at 08:13:55AM +0200, C=E9dric Le Goater wrote:
>>>> @@ -527,6 +471,30 @@ static int spapr_irq_check(SpaprMachineState *s=
papr, Error **errp)
>>>>  /*
>>>>   * sPAPR IRQ frontend routines for devices
>>>>   */
>>>> +#define ALL_INTCS(spapr_) \
>>>> +    { SPAPR_INTC((spapr_)->ics), SPAPR_INTC((spapr_)->xive), }
>>>
>>> I would have expected this array to be under the machine.
>>>
>>>> +int spapr_irq_cpu_intc_create(SpaprMachineState *spapr,
>>>> +                              PowerPCCPU *cpu, Error **errp)
>>>> +{
>>>> +    SpaprInterruptController *intcs[] =3D ALL_INTCS(spapr);
>>>> +    int i;
>>>> +    int rc;
>>>> +
>>>> +    for (i =3D 0; i < ARRAY_SIZE(intcs); i++) {
>>>
>>> but it would have been difficult to use ARRAY_SIZE. OK then.
>>>
>>>> +        SpaprInterruptController *intc =3D intcs[i];
>>>> +        if (intc) {
>>>
>>> Is that test needed ?=20
>>
>> I understand now : spapr->ics and spapr->xive can be NULL.=20
>>
>> I think using a list would be better.
>=20
> Uh.. a list in what sense?

an interrupt controller list under the machine.=20

when created, an interrupt controller would self register in that list.

C.

