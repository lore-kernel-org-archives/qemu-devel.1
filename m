Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6A3C10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 08:03:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93EF321A4C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 08:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93EF321A4C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFw5N-0004iM-KK
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 04:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iFw4U-0004HW-WE
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 04:02:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iFw4T-0002oG-9T
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 04:02:46 -0400
Received: from 9.mo177.mail-out.ovh.net ([46.105.72.238]:59314)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iFw4T-0002ib-3I
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 04:02:45 -0400
Received: from player158.ha.ovh.net (unknown [10.108.57.14])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 30E0210CD2A
 for <qemu-devel@nongnu.org>; Thu,  3 Oct 2019 10:02:34 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player158.ha.ovh.net (Postfix) with ESMTPSA id 0F93DA6A324C;
 Thu,  3 Oct 2019 08:02:29 +0000 (UTC)
Subject: Re: [PATCH] spapr/xive: skip partially initialized vCPUs in presenter
To: David Gibson <david@gibson.dropbear.id.au>
References: <20191001085722.32755-1-clg@kaod.org>
 <20191001130614.226ef6a2@bahia.w3ibm.bluemix.net>
 <fad6aae9-8722-498c-730d-fa204f07e3c5@kaod.org>
 <20191001185629.0b284ba1@bahia.lan> <20191002010245.GT11105@umbus.fritz.box>
 <20191002162142.7ce18dcb@bahia.lan>
 <3db4ae61-a4f0-3ddf-e734-5795c7176559@kaod.org>
 <20191002223741.GC11105@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <34e6d579-104b-38ff-dbb4-ca5fe449e7d5@kaod.org>
Date: Thu, 3 Oct 2019 10:02:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191002223741.GC11105@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 12329166929907977043
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgeejgdduvdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.72.238
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

On 03/10/2019 00:37, David Gibson wrote:
> On Wed, Oct 02, 2019 at 04:47:56PM +0200, C=E9dric Le Goater wrote:
>> On 02/10/2019 16:21, Greg Kurz wrote:
>>> On Wed, 2 Oct 2019 11:02:45 +1000
>>> David Gibson <david@gibson.dropbear.id.au> wrote:
>>>
>>>> On Tue, Oct 01, 2019 at 06:56:28PM +0200, Greg Kurz wrote:
>>>>> On Tue, 1 Oct 2019 13:56:10 +0200
>>>>> C=E9dric Le Goater <clg@kaod.org> wrote:
>>>>>
>>>>>> On 01/10/2019 13:06, Greg Kurz wrote:
>>>>>>> On Tue,  1 Oct 2019 10:57:22 +0200
>>>>>>> C=E9dric Le Goater <clg@kaod.org> wrote:
>>>>>>>
>>>>>>>> When vCPUs are hotplugged, they are added to the QEMU CPU list b=
efore
>>>>>>>> being fully realized. This can crash the XIVE presenter because =
the
>>>>>>>> 'tctx' pointer is not necessarily initialized when looking for a
>>>>>>>> matching target.
>>>>>>>>
>>>>>>>
>>>>>>> Ouch... :-\
>>>>>>>
>>>>>>>> These vCPUs are not valid targets for the presenter. Skip them.
>>>>>>>>
>>>>>>>
>>>>>>> This likely fixes this specific issue, but more generally, this
>>>>>>> seems to indicate that using CPU_FOREACH() is rather fragile.
>>>>>>>
>>>>>>> What about tracking XIVE TM contexts with a QLIST in xive.c ?
>>>>>>
>>>>>> This is a good idea. =20
>>>>>>
>>>>>> On HW, the thread interrupt contexts belong to the XIVE presenter=20
>>>>>> subengine. This is the logic doing the CAM line matching to find
>>>>>> a target for an event notification. So we should model the context=
=20
>>>>>> list below the XiveRouter in QEMU which models both router and=20
>>>>>> presenter subengines. We have done without a presenter model for=20
>>>>>> the moment and I don't think we will need to introduce one. =20
>>>>>>
>>>>>> This would be a nice improvements of my patchset adding support
>>>>>> for xive escalations and better support of multi chip systems.=20
>>>>>> I have introduced a PNV_CHIP_CPU_FOREACH in this patchset which=20
>>>>>> would become useless with a list of tctx under the XIVE interrupt
>>>>>> controller, XiveRouter, SpaprXive, PnvXive.
>>>>>>
>>>>>
>>>>> I agree. It makes more sense to have the list below the XiveRouter,
>>>>> rather than relying on CPU_FOREACH(), which looks a bit weird from
>>>>> a device emulation code perspective.
>>>>
>>>> That does sound like a better idea long term.  However, for now, I
>>>> think the NULL check is a reasonable way of fixing the real error
>>>> we're hitting, so I've applied the patch here.
>>>>
>>>
>>> Fair enough.
>>>
>>> Reviewed-by: Greg Kurz <groug@kaod.org>
>>>
>>>> Future cleanups to a different approach remain welcome, of course.
>>>>
>>>
>>> I've started to look. This should simplify Cedric's "add XIVE support
>>> for KVM guests" series, but I'll wait for your massive cleanup series
>>> to get merged first.
>>
>>
>> This is a combo patchset.=20
>>
>>
>> These are prereqs fixes related to the presenter and how CAM lines
>> are scanned. This is in direct relation with the CPU_FOREACH() issue.
>>
>>   ppc/xive: Introduce a XivePresenter interface
>>   ppc/xive: Implement the XivePresenter interface
>>   ppc/pnv: Introduce a PNV_CHIP_CPU_FOREACH() helper
>>   ppc/pnv: Introduce a pnv_xive_is_cpu_enabled() helper
>>   ppc/xive: Introduce a XiveFabric interface
>>   ppc/pnv: Implement the XiveFabric interface
>>   ppc/spapr: Implement the XiveFabric interface
>>   ppc/xive: Use the XiveFabric and XivePresenter interfaces
>>
>> These are for interrupt resend (escalation). To be noted, the removal=20
>> of the get_tctx() XiveRouter handler which has some relation with=20
>> the previous subserie.
>>
>>   ppc/xive: Extend the TIMA operation with a XivePresenter parameter
>>   ppc/pnv: Clarify how the TIMA is accessed on a multichip system
>>   ppc/xive: Move the TIMA operations to the controller model
>>   ppc/xive: Remove the get_tctx() XiveRouter handler
>>   ppc/xive: Introduce a xive_tctx_ipb_update() helper
>>   ppc/xive: Introduce helpers for the NVT id
>>   ppc/xive: Synthesize interrupt from the saved IPB in the NVT
>>
>> This is a bug :
>>
>>   ppc/pnv: Remove pnv_xive_vst_size() routine
>>   ppc/pnv: Dump the XIVE NVT table
>>   ppc/pnv: Skip empty slots of the XIVE NVT table
>>
>> This is a model for the block id configuration and better support
>> for multichip systems :=20
>>
>>   ppc/pnv: Introduce a pnv_xive_block_id() helper
>>   ppc/pnv: Extend XiveRouter with a get_block_id() handler
>>
>> Misc improvements :=20
>>
>>   ppc/pnv: Quiesce some XIVE errors
>>   ppc/xive: Introduce a xive_os_cam_decode() helper
>>   ppc/xive: Check V bit in TM_PULL_POOL_CTX
>>   ppc/pnv: Improve trigger data definition
>>   ppc/pnv: Use the EAS trigger bit when triggering an interrupt from P=
SI
>>
>>
>> I should move some in front to have them merged before hand if=20
>> possible. They have been on the list for 3 months.
>=20
> Sorry :(.  I've been kind of overwhelmed.

That's fine. The latest issue with CPU_FOREACH and Greg's ideas on how
to cleanly handle the CAM line scan should improve the models even more.

The XiveTCTX should be disconnected from the CPU and tied to the presente=
r
engine, XiveRouter will do, using parenthood or a list to speed up the sc=
an.


C.

