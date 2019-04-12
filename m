Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B9CC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 04:37:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E10A42084D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 04:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E10A42084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58838 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEnwq-0003oL-5D
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 00:37:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hEnvz-0003Pk-JL
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 00:37:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hEnvy-00075a-A3
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 00:37:03 -0400
Received: from 2.mo3.mail-out.ovh.net ([46.105.75.36]:48950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hEnvx-00073J-Vj
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 00:37:02 -0400
Received: from player799.ha.ovh.net (unknown [10.109.159.68])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 76B0F2070BE
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 06:36:59 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-40-22.w86-201.abo.wanadoo.fr
	[86.201.133.22]) (Authenticated sender: clg@kaod.org)
	by player799.ha.ovh.net (Postfix) with ESMTPSA id 06BBD4ADE0E4;
	Fri, 12 Apr 2019 04:36:53 +0000 (UTC)
To: Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>
References: <20190411161013.4514-1-clg@kaod.org>
	<20190411161013.4514-3-clg@kaod.org>
	<CACPK8XezRXPFFiiK7_xXLs-ipnfw9400E1dSRHN0XnF2cc4=vA@mail.gmail.com>
	<c007d615-4dbf-4525-9fb0-6e4feb28c344@www.fastmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e9c90082-5312-5707-539b-3ab3c2e7d885@kaod.org>
Date: Fri, 12 Apr 2019 06:36:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c007d615-4dbf-4525-9fb0-6e4feb28c344@www.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-Ovh-Tracer-Id: 1579356097962150720
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrvddtgdekfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.75.36
Subject: Re: [Qemu-devel] [PATCH 2/3] aspeed: add a per SoC mapping for the
 memory space
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412043648.W3E1-Z4nr8Ctb03-a_D3KTBEbWWRtfqKLMvJMbepvLk@z>

On 4/12/19 5:24 AM, Andrew Jeffery wrote:
>=20
>=20
> On Fri, 12 Apr 2019, at 11:48, Joel Stanley wrote:
>> On Thu, 11 Apr 2019 at 16:10, C=C3=A9dric Le Goater <clg@kaod.org> wro=
te:
>>>
>>> This will simplify the definition of new SoCs, like the AST2600 which
>>> should use a slightly different address space and have a different se=
t
>>> of controllers.
>>>
>>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>
>>> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
>>> index 5bbd1fb87d18..9b601709e93c 100644
>>> --- a/hw/arm/aspeed_soc.c
>>> +++ b/hw/arm/aspeed_soc.c
>>
>>> +static const hwaddr aspeed_soc_ast2400_memmap[] =3D {
>>
>>> +static const hwaddr aspeed_soc_ast2500_memmap[] =3D {
>>
>> Most of these arrays is common. And some of it will stay common in the
>> 2600. Any ideas how we could avoid duplication?
>=20
> I dunno, I feel that any attempt to create some "common" layout concept=
 is
> more distracting than having soc-specific, complete layouts described.

yes. I rather duplicate some values and see in one glance the full=20
address space.

Thanks,

C.
 =20
>=20
> There's no reason why they're common beyond coincidence (i.e. it's at
> ASPEED's whim). I think this is fine.
>=20
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
>=20
>>
>> This is fine for now.
>>
>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>>


