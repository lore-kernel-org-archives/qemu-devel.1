Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4F6C3A5A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 05:45:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC34E20835
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 05:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC34E20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCH9v-0007XP-Sa
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 01:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49771)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iCH92-00070V-G6
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 01:44:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iCH91-0003vo-6i
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 01:44:20 -0400
Received: from 8.mo173.mail-out.ovh.net ([46.105.46.122]:55692)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iCH91-0003ul-0i
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 01:44:19 -0400
Received: from player794.ha.ovh.net (unknown [10.108.35.211])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id F27F511A540
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 07:44:16 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player794.ha.ovh.net (Postfix) with ESMTPSA id E0DB0A1041F6;
 Mon, 23 Sep 2019 05:44:11 +0000 (UTC)
Subject: Re: [PATCH 03/21] hw: aspeed_scu: Add AST2600 support
To: Joel Stanley <joel@jms.id.au>
References: <20190919055002.6729-1-clg@kaod.org>
 <20190919055002.6729-4-clg@kaod.org>
 <139c3f7e-465e-4efb-b6c7-213dcd2ec6b7@www.fastmail.com>
 <2a267d68-2463-ae0d-00d0-d9a33ba845b2@kaod.org>
 <CACPK8Xd2aR9tJKfVjNn7ZCnNw1XK4X7A+fe-5Z62N_HyCOiAWQ@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <3d4e0b9c-f658-bebb-e0f5-6c513c5434cf@kaod.org>
Date: Mon, 23 Sep 2019 07:44:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CACPK8Xd2aR9tJKfVjNn7ZCnNw1XK4X7A+fe-5Z62N_HyCOiAWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 6606780653786532672
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdejgddutdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.46.122
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/09/2019 06:37, Joel Stanley wrote:
> On Fri, 20 Sep 2019 at 15:15, C=C3=A9dric Le Goater <clg@kaod.org> wrot=
e:
>>
>> On 20/09/2019 06:10, Andrew Jeffery wrote:
>>>
>>>
>>> On Thu, 19 Sep 2019, at 15:19, C=C3=A9dric Le Goater wrote:
>>>> From: Joel Stanley <joel@jms.id.au>
>>>>
>>>> The SCU controller on the AST2600 SoC has extra registers. Increase
>>>> the number of regs of the model and introduce a new field in the cla=
ss
>>>> to customize the MemoryRegion operations depending on the SoC model.
>>>>
>>>> +    switch (reg) {
>>>> +    case AST2600_PROT_KEY:
>>>> +        s->regs[reg] =3D (data =3D=3D ASPEED_SCU_PROT_KEY) ? 1 : 0;
>>>> +        return;
>>>> +    case AST2600_HW_STRAP1:
>>>> +    case AST2600_HW_STRAP2:
>>>> +        if (s->regs[reg + 2]) {
>>>> +            return;
>>>> +        }
>>>> +        /* fall through */
>>>> +    case AST2600_SYS_RST_CTRL:
>>>> +    case AST2600_SYS_RST_CTRL2:
>>>> +        /* W1S (Write 1 to set) registers */
>>>> +        s->regs[reg] |=3D data;
>>>> +        return;
>>>> +    case AST2600_SYS_RST_CTRL_CLR:
>>>> +    case AST2600_SYS_RST_CTRL2_CLR:
>>>> +    case AST2600_HW_STRAP1_CLR:
>>>> +    case AST2600_HW_STRAP2_CLR:
>>>> +        /* W1C (Write 1 to clear) registers */
>>>> +        s->regs[reg] &=3D ~data;
>>>
>>> This clear should respect the protection register for each strap case=
.
>>
>> Joel,
>>
>> You are the expert ! :)
>=20
> Someone could implement this if they wanted to. In the future it might
> be useful to create a detailed model for the OTP and secure boot
> behavior, and that can affect the strapping.
>=20
> However it is not critical for running guests under qemu. I think we
> should defer it until there is some guest code that needs the detailed
> behavior.

ok. It think we could trap the invalid writes with a simple mask
array at the beginning of the write op .

Thanks,

C.=20


