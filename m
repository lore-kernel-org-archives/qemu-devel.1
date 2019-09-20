Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347A2C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:19:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A67A2080F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A67A2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBKgh-0002Yg-2b
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 11:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42119)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iBKf0-0001IS-Q4
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:17:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iBKez-0000Xi-N6
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:17:26 -0400
Received: from 7.mo4.mail-out.ovh.net ([178.33.253.54]:39003)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iBKez-0000Wi-HP
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:17:25 -0400
Received: from player758.ha.ovh.net (unknown [10.108.35.128])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id A1DB920819D
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 17:17:23 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player758.ha.ovh.net (Postfix) with ESMTPSA id A6D12A15B613;
 Fri, 20 Sep 2019 15:17:18 +0000 (UTC)
Subject: Re: [PATCH 17/21] aspeed/soc: Add AST2600 support
To: Joel Stanley <joel@jms.id.au>
References: <20190919055002.6729-1-clg@kaod.org>
 <20190919055002.6729-18-clg@kaod.org>
 <CACPK8XffSK65RAc-kgbZrvxbr9cEF3uYEu6_tpN=9oDwrNgs-w@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <176fc141-f928-2d54-c951-c3e3e2b99675@kaod.org>
Date: Fri, 20 Sep 2019 17:17:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CACPK8XffSK65RAc-kgbZrvxbr9cEF3uYEu6_tpN=9oDwrNgs-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 17114523011765210027
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvddvgdekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.253.54
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

On 20/09/2019 06:35, Joel Stanley wrote:
> On Thu, 19 Sep 2019 at 05:52, C=C3=A9dric Le Goater <clg@kaod.org> wrot=
e:
>>
>> Initial definitions for a simple machine using an AST2600 SoC (Cortex
>> CPU).
>>
>> The Cortex CPU and its interrupt controller are too complex to handle
>> in the common Aspeed SoC framework. We introduce a new Aspeed SoC
>> class with instance_init and realize handlers to handle the difference=
s
>> with the AST2400 and the AST2500 SoCs. This will add extra work to
>> keep in sync both models with future extensions but it makes the code
>> clearer.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> Reviewed-by: Joel Stanley <joel@jms.id.au>
>=20
> One small addition below. If you don't resend I can do a follow up patc=
h for it:
>=20
>> +
>> +static const int aspeed_soc_ast2600_irqmap[] =3D {
>=20
>> +    [ASPEED_ETH1]      =3D 2,
>> +    [ASPEED_ETH2]      =3D 3,
>=20
> We need to add ETH3 and ETH4 here. They look like this:
>=20
>     [ASPEED_ETH3]      =3D 32,
>     [ASPEED_ETH4]      =3D 33,
>=20

I will include them in :=20

  [PATCH 19/21] aspeed: Parameterise number of MACs

Thanks,

C.

