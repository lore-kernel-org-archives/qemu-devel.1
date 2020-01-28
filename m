Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DE4C33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 08:25:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28AD62173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 08:25:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28AD62173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwMBT-0008L4-Cb
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 03:25:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iwMAr-0007n2-OD
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 03:24:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iwMAq-0007Oj-Ie
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 03:24:41 -0500
Received: from 20.mo5.mail-out.ovh.net ([91.121.55.239]:54022)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iwMAq-0007Mp-CF
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 03:24:40 -0500
Received: from player692.ha.ovh.net (unknown [10.108.35.59])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 3DF8026A17E
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:24:38 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player692.ha.ovh.net (Postfix) with ESMTPSA id 03B71E9186F7;
 Tue, 28 Jan 2020 08:24:28 +0000 (UTC)
Subject: Re: [PATCH v3 1/5] hw/sd: Configure number of slots exposed by the
 ASPEED SDHCI model
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200114103433.30534-1-clg@kaod.org>
 <20200114103433.30534-2-clg@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <149987eb-a657-b7e0-7ca8-198281ed1713@kaod.org>
Date: Tue, 28 Jan 2020 09:24:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200114103433.30534-2-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 17277215546196396864
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrfeefgdduudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheiledvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.121.55.239
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Joel Stanley <joel@jms.id.au>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Peter, 

[ ... ]

> +static Property aspeed_sdhci_properties[] = {
> +    DEFINE_PROP_UINT8("num-slots", AspeedSDHCIState, num_slots, 0),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void aspeed_sdhci_class_init(ObjectClass *classp, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(classp);
> @@ -181,6 +187,7 @@ static void aspeed_sdhci_class_init(ObjectClass *classp, void *data)
>      dc->realize = aspeed_sdhci_realize;
>      dc->reset = aspeed_sdhci_reset;
>      dc->vmsd = &vmstate_aspeed_sdhci;
> +    dc->props = aspeed_sdhci_properties;

This will require a change to use device_class_set_props(). 

Do you want a resend ?  

Thanks,

C.

