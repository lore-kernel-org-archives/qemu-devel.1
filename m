Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC9AC5ACD3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:51:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6297420754
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6297420754
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDsxZ-0003Ef-J9
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jDrOl-0008H9-Ml
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 11:11:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jDrOk-0006tY-6i
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 11:11:23 -0400
Received: from 8.mo6.mail-out.ovh.net ([178.33.42.204]:53762)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jDrOj-0006bB-Tp
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 11:11:22 -0400
Received: from player158.ha.ovh.net (unknown [10.108.54.108])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id D3624204F47
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 16:11:19 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player158.ha.ovh.net (Postfix) with ESMTPSA id AF6E410729FFD;
 Mon, 16 Mar 2020 15:11:03 +0000 (UTC)
Subject: Re: [PATCH v2 1/4] m25p80: Convert to support tracing
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200206183219.3756-1-linux@roeck-us.net>
 <488b3355-4467-e01e-d6a0-a2d5bc959428@kaod.org>
 <5589b5ce-1ff3-bf1e-ceae-fe82e1e1265c@kaod.org>
 <CAFEAcA_Zg65ebyTH+7i8ZGf4jzmf1tRPYdVz590UP0rQoz86pg@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a6af95d9-f95c-f9fc-eac0-60d9c8517dec@kaod.org>
Date: Mon, 16 Mar 2020 16:11:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_Zg65ebyTH+7i8ZGf4jzmf1tRPYdVz590UP0rQoz86pg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 10887170627504671664
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudeffedgjedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucffohhmrghinhepohiilhgrsghsrdhorhhgnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrudehkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.42.204
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
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Andrew Jeffery <andrew@aj.id.au>, Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 3:58 PM, Peter Maydell wrote:
> On Mon, 16 Mar 2020 at 14:14, C=C3=A9dric Le Goater <clg@kaod.org> wrot=
e:
>>
>> Hello,
>>
>> On 2/17/20 4:47 PM, C=C3=A9dric Le Goater wrote:
>>> Hello all,
>>>
>>> On 2/6/20 7:32 PM, Guenter Roeck wrote:
>>>> While at it, add some trace messages to help debug problems
>>>> seen when running the latest Linux kernel.
>>>
>>> Through which tree do you think it is best to merge this patchset ?
>>> block or arm ?
>>
>> It would be nice to have these 4 patches for 5.0. All are reviewed and
>> tested.
>=20
> Do you have a pointer to the cover letter? Not sure
> which platforms (and so which tree) they're aiming for...

Not having a cover letter clearly doesn't help ...

Here is the patchset diffstat :

 block/m25p80.c     |   58 ++++++++++++++++++++++++++++------------------=
-------
 block/trace-events |   16 ++++++++++++++
 ssi/aspeed_smc.c   |    2 -
 3 files changed, 48 insertions(+), 28 deletions(-)

http://patchwork.ozlabs.org/patch/1234532/
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

http://patchwork.ozlabs.org/patch/1234533/
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

http://patchwork.ozlabs.org/patch/1234535/
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

http://patchwork.ozlabs.org/patch/1234536/
Fixes: f95c4bffdc4c ("aspeed/smc: snoop SPI transfers to fake dummy cycle=
s")
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks,

C.=20

