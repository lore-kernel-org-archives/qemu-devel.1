Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8348C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:16:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 781612080F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 781612080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBKeL-0000lp-Mx
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 11:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41873)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iBKdL-0008HT-Ah
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:15:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iBKdJ-0008Pk-8J
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:15:43 -0400
Received: from 9.mo178.mail-out.ovh.net ([46.105.75.45]:52664)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iBKdH-0008Ns-Dy
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:15:41 -0400
Received: from player158.ha.ovh.net (unknown [10.108.57.53])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 9B74F79E3A
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 17:15:36 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player158.ha.ovh.net (Postfix) with ESMTPSA id 483EC9F38821;
 Fri, 20 Sep 2019 15:15:31 +0000 (UTC)
Subject: Re: [PATCH 03/21] hw: aspeed_scu: Add AST2600 support
To: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>
References: <20190919055002.6729-1-clg@kaod.org>
 <20190919055002.6729-4-clg@kaod.org>
 <139c3f7e-465e-4efb-b6c7-213dcd2ec6b7@www.fastmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2a267d68-2463-ae0d-00d0-d9a33ba845b2@kaod.org>
Date: Fri, 20 Sep 2019 17:15:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <139c3f7e-465e-4efb-b6c7-213dcd2ec6b7@www.fastmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 17084123714722892755
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvddvgdekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.75.45
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/09/2019 06:10, Andrew Jeffery wrote:
>=20
>=20
> On Thu, 19 Sep 2019, at 15:19, C=C3=A9dric Le Goater wrote:
>> From: Joel Stanley <joel@jms.id.au>
>>
>> The SCU controller on the AST2600 SoC has extra registers. Increase
>> the number of regs of the model and introduce a new field in the class
>> to customize the MemoryRegion operations depending on the SoC model.
>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> [clg: - improved commit log
>>       - changed vmstate version
>>       - reworked model integration into new objet class ]
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/misc/aspeed_scu.h |   7 +-
>>  hw/misc/aspeed_scu.c         | 190 +++++++++++++++++++++++++++++++++-=
-
>>  2 files changed, 189 insertions(+), 8 deletions(-)
>=20
> ...
>=20
>> +static void aspeed_ast2600_scu_write(void *opaque, hwaddr offset,=20
>> uint64_t data,
>> +                                     unsigned size)
>> +{
>> +    AspeedSCUState *s =3D ASPEED_SCU(opaque);
>> +    int reg =3D TO_REG(offset);
>> +
>> +    if (reg >=3D ASPEED_AST2600_SCU_NR_REGS) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "%s: Out-of-bounds write at offset 0x%"=20
>> HWADDR_PRIx "\n",
>> +                      __func__, offset);
>> +        return;
>> +    }
>> +
>> +    if (reg > PROT_KEY && !s->regs[PROT_KEY]) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: SCU is locked!\n",=20
>> __func__);
>> +    }
>> +
>> +    trace_aspeed_scu_write(offset, size, data);
>> +
>> +    switch (reg) {
>> +    case AST2600_PROT_KEY:
>> +        s->regs[reg] =3D (data =3D=3D ASPEED_SCU_PROT_KEY) ? 1 : 0;
>> +        return;
>> +    case AST2600_HW_STRAP1:
>> +    case AST2600_HW_STRAP2:
>> +        if (s->regs[reg + 2]) {
>> +            return;
>> +        }
>> +        /* fall through */
>> +    case AST2600_SYS_RST_CTRL:
>> +    case AST2600_SYS_RST_CTRL2:
>> +        /* W1S (Write 1 to set) registers */
>> +        s->regs[reg] |=3D data;
>> +        return;
>> +    case AST2600_SYS_RST_CTRL_CLR:
>> +    case AST2600_SYS_RST_CTRL2_CLR:
>> +    case AST2600_HW_STRAP1_CLR:
>> +    case AST2600_HW_STRAP2_CLR:
>> +        /* W1C (Write 1 to clear) registers */
>> +        s->regs[reg] &=3D ~data;
>=20
> This clear should respect the protection register for each strap case.

Joel,

You are the expert ! :)=20

Thanks,

C.



