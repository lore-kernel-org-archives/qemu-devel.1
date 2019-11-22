Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E60C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 15:58:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95F462071B
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 15:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F462071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYBKQ-0000kq-CL
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 10:58:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iYBHk-0006zC-S8
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 10:55:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iYBDm-0005Mq-6y
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 10:51:47 -0500
Received: from 5.mo7.mail-out.ovh.net ([178.32.120.239]:36292)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iYBDm-0005L8-0l
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 10:51:46 -0500
Received: from player737.ha.ovh.net (unknown [10.108.54.209])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 82A35140261
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 16:51:36 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player737.ha.ovh.net (Postfix) with ESMTPSA id 71C472FF523F;
 Fri, 22 Nov 2019 15:51:29 +0000 (UTC)
Subject: Re: [PATCH] ipmi: add SET_SENSOR_READING command
To: cminyard@mvista.com
References: <20191118092429.16149-1-clg@kaod.org>
 <20191122142800.GT3556@minyard.net>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e1108da3-b211-13a8-8383-3da78a393006@kaod.org>
Date: Fri, 22 Nov 2019 16:51:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191122142800.GT3556@minyard.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 290482176950373350
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudehgedgkeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.32.120.239
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
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/11/2019 15:28, Corey Minyard wrote:
> On Mon, Nov 18, 2019 at 10:24:29AM +0100, C=C3=A9dric Le Goater wrote:
>> SET_SENSOR_READING is a complex IPMI command (see IPMI spec 35.17)
>> which enables the host software to set the reading value and the event
>> status of sensors supporting it.
>>
>> Below is a proposal for all the operations (reading, assert, deassert,
>> event data) with the following limitations :
>>
>>  - No event are generated for threshold-based sensors.
>>  - The case in which the BMC needs to generate its own events is not
>>    supported.
>=20
> Ok, I've included this in my tree.  I made one small change mentioned
> below.  Beyond that, I think you could make this function shorter, but =
I
> think that would actually make it harder to understand.  Breaking it
> into multiple functions doesn't make sense to me, either.
>=20
> If you are including this in the ppc tree:
>=20
> Acked-by: Corey Minyard <cminyard@mvista.com>
>=20
> with the change below and I can remove it from mine.

I don't think there is a strong need to have it in the PPC tree. It's=20
a stand alone function adding an extra IPMI command.


>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> Reviewed-by: Corey Minyard <cminyard@mvista.com>
>> ---
>> +
>> +    switch (do_gen_event) {
>> +    case SENSOR_GEN_EVENT_DATA: {
>> +        unsigned int bit =3D evd1 & 0xf;
>> +        uint16_t mask =3D (1 << bit);
>> +
>> +        if (sens->assert_states & mask & sens->assert_enable) {
>> +            gen_event(ibs, cmd[2], 0, evd1, evd2, evd3);
>> +        }
>> +
>> +        if (sens->deassert_states & mask & sens->deassert_enable) {
>> +            gen_event(ibs, cmd[2], 1, evd1, evd2, evd3);
>> +        }
>> +    }
>> +        break;
>=20
> I moved this break statement above the brace before it to keep the
> indention consistent.  It just screwed with my brain too much :).
>
> I looked and there is nothing in the coding style about this, and I
> found this done in three different ways:
>=20
>   case x: {  /* in vl.c */
>       ....
>       break;
>   }
>   case y: /* in thunk.c */
>       {
>            ....
>       }
>       break;
>   case z: /* In vl.c */
>   {
>       ....
>       break;
>   }
>=20
> Oddly enough, I didn't find anything about this in the Linux coding
> style document, either (I was curious).  One could argue, I suppose,
> that according to the "Block structure" section in the qemu style and
> the similar section in the Linux style that the first is correct,
> but then case statements violate the "Every indented statement is
> braced" statement in the qemu style.  This has always bugged me in
> C, sorry for the diatribe on this.

Thanks,

C.=20

>=20
> -corey
>=20
>> +    case SENSOR_GEN_EVENT_BMC:


