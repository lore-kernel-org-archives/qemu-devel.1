Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E29DC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 16:33:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34B9021D56
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 16:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B9021D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBLLV-0005AQ-C1
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 12:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jBLKZ-0003yD-Ex
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 12:32:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jBLKX-0007YA-BD
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 12:32:39 -0400
Received: from 8.mo3.mail-out.ovh.net ([87.98.172.249]:60759)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jBLKU-0007Al-0u
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 12:32:37 -0400
Received: from player762.ha.ovh.net (unknown [10.110.103.202])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 965E924687F
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2020 17:32:24 +0100 (CET)
Received: from kaod.org (unknown [129.41.47.1])
 (Authenticated sender: clg@kaod.org)
 by player762.ha.ovh.net (Postfix) with ESMTPSA id 78E5C1038647F;
 Mon,  9 Mar 2020 16:32:16 +0000 (UTC)
Subject: Re: [PATCH 0/2] aspeed/smc: fix data corruption on witherspoon
 machines
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200206112645.21275-1-clg@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <7ab3522d-54ae-ca24-592e-68d54e47de7d@kaod.org>
Date: Mon, 9 Mar 2020 17:32:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200206112645.21275-1-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 8041177135570979648
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedruddukedgleduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpuddvledrgedurdegjedrudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejiedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.172.249
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Andrew Geissler <geissonator@gmail.com>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/6/20 12:26 PM, C=C3=A9dric Le Goater wrote:
> Hello,
>=20
> We have been seeing a squashfs corruption on the witherspoon-bmc
> machine for quite some time. It boots but quickly after boot
> corruption errors start to fill the console. This machine has two BMC
> chips with UBIfs on them. The romulus-bmc machine has a similar
> problem when both PNOR are enabled.
>=20
> After some investigation, it appeared that the SPI transfers on the
> two chips were getting mixed and after more investigation, the User
> mode select/unselect scheme of the Aspeed SMC model proved to be
> broken. It's been there since the right beginning of the model. Here
> is a fix.
>=20
> Kudos to Andrew J. for the time he spent on this and Andrew G. for his
> patience.
>=20
> I pushed the code on my github branch aspeed-5.0 for more testing.
>=20
> Thanks,
>=20
> C.
>=20
> C=C3=A9dric Le Goater (2):
>   aspeed/smc: Add some tracing
>   aspeed/smc: Fix User mode select/unselect scheme
>=20
>  Makefile.objs       |  1 +
>  hw/ssi/aspeed_smc.c | 56 ++++++++++++++++++++++++++++++++-------------
>  hw/ssi/trace-events | 10 ++++++++
>  3 files changed, 51 insertions(+), 16 deletions(-)
>  create mode 100644 hw/ssi/trace-events

Hello Peter,=20

If you have some time to take a look, it would be nice to get this=20
fix in QEMU 5.0.=20

Thanks,

C.

