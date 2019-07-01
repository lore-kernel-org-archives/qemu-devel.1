Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD56C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 05:56:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 170422089F
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 05:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 170422089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhpIJ-000114-Vx
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 01:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38237)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hhpHV-0000KR-GW
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 01:55:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hhpHU-0001ev-C2
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 01:55:13 -0400
Received: from 1.mo173.mail-out.ovh.net ([178.33.111.180]:40931)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hhpHU-0001dl-5z
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 01:55:12 -0400
Received: from player759.ha.ovh.net (unknown [10.109.143.189])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 573521101FD
 for <qemu-devel@nongnu.org>; Mon,  1 Jul 2019 07:55:09 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player759.ha.ovh.net (Postfix) with ESMTPSA id CF894770C93E;
 Mon,  1 Jul 2019 05:55:03 +0000 (UTC)
To: David Gibson <david@gibson.dropbear.id.au>
References: <156112873945.115975.15513090884722011930.stgit@bahia.lan>
 <dad9ca85-4849-bfb0-0e09-8082ed64ecbc@kaod.org>
 <20190701050715.GJ2138@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <49091393-008a-2e58-1d0d-a47d1389678c@kaod.org>
Date: Mon, 1 Jul 2019 07:55:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190701050715.GJ2138@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 11546103544750574419
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrvdehgddutddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.111.180
Subject: Re: [Qemu-devel] [PATCH] spapr/xive: H_INT_ESB is used for LSIs only
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

On 01/07/2019 07:07, David Gibson wrote:
> On Fri, Jun 21, 2019 at 05:05:45PM +0200, C=E9dric Le Goater wrote:
>> On 21/06/2019 16:52, Greg Kurz wrote:
>>> As indicated in the function header, this "hcall is only supported fo=
r
>>> LISNs that have the ESB hcall flag set to 1 when returned from hcall(=
)
>>> H_INT_GET_SOURCE_INFO". We only set that flag for LSIs actually.
>>>
>>> Check that in h_int_esb().
>>
>> Indeed. H_INT_ESB should work on any IRQ, but I think it's better=20
>> to check that the HCALL is only used with the IRQ requiring it.
>=20
> I'm not so convinced.  It seems to me that specifically limiting this
> to certain things limits our options if we ever need future
> workarounds for problems with ESB mapping.
>=20
> In addition using H_INT_ESB for non-LSIs could be useful for minimal
> guests (e.g. kvm-unit-tests) where mapping memory might be awkward.

Ah yes. This is true. There is no real reason for enforcing this
restriction in QEMU as H_INT_ESB should work on any irq. We can
keep it that way I guess. It would be a small deviation from PAPR.

Thanks,

C.=20

> So, I'm not really seeing a compelling reason to apply this.
>=20
>>
>>> Signed-off-by: Greg Kurz <groug@kaod.org>
>>
>> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
>>
>> Thanks,
>>
>> C.
>>
>>> ---
>>>  hw/intc/spapr_xive.c |    6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
>>> index 58c2e5d890bd..01dd47ad5b02 100644
>>> --- a/hw/intc/spapr_xive.c
>>> +++ b/hw/intc/spapr_xive.c
>>> @@ -1408,6 +1408,12 @@ static target_ulong h_int_esb(PowerPCCPU *cpu,
>>>          return H_P2;
>>>      }
>>> =20
>>> +    if (!xive_source_irq_is_lsi(xsrc, lisn)) {
>>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: LISN " TARGET_FMT_lx "=
isn't LSI\n",
>>> +                      lisn);
>>> +        return H_P2;
>>> +    }
>>> +
>>>      if (offset > (1ull << xsrc->esb_shift)) {
>>>          return H_P3;
>>>      }
>>>
>>
>=20


