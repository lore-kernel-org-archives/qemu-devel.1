Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150B6C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 14:20:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF64F206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 14:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF64F206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic92D-0007xN-VA
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 09:20:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52119)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Harish_Kandiga@mentor.com>) id 1ic0xb-0004om-2x
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 00:42:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Harish_Kandiga@mentor.com>) id 1ic0xY-0007qY-D7
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 00:42:53 -0500
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:50578)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Harish_Kandiga@mentor.com>)
 id 1ic0xX-0007nL-RW
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 00:42:52 -0500
IronPort-SDR: syicz+cHMc/HQAWLMcXWkQLvr+9IMiX9BfPX5nyNaotlMNKlzaf2NwYzUqUWYeQlSEM11Z3BpU
 DxsQjEzAMpQ+rwjiJGDirFRMfyxqh0KtmS3yGM+L/j5xeTlaPA40MAqJ65gX6scnEsx4GG7XMi
 QTWF2KFpJD9WvXFNFESfp4ngWbQylu9z061hfcmBHsJX6SW65W1zkTa823IRE3xWsb/yeE/JVk
 JSIXCj+9uzAeE89YGPcftbar93/IiN9R465Y9ml5GaGE083YrqxXYz5hUNqXjVhbJB0Y+cGttx
 cHM=
X-IronPort-AV: E=Sophos;i="5.69,272,1571731200"; d="scan'208";a="43647687"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa2.mentor.iphmx.com with ESMTP; 02 Dec 2019 21:42:50 -0800
IronPort-SDR: 6qW7kvfV2RJQ+o/o5f2nDujbmBSwumb85KO+OiaQHueozhtxi3wK5lBcFsz8N2dtJn1QT92VPT
 Qgv43tx44fcY6bo6t1sgDkAQ2/TB6bY50B/bcNaNCkLbDDm0xne8hal71H0BF7iCi91KHq8gYV
 l4H+1KNiIKYYMMtq23CtXeCb0XUbkF3MqlcarsOUStxXqUmileh72a7vzHfPC790pHde63/MTs
 gsV2+TivzEA3wls2h/41pYkDHtbxnyvWVV/rC52Hep9lVTvn/oImikOQ6lqgMEgARN2n4oTAx6
 phw=
Subject: Re: [PATCH v3 5/7] gpio: Add GPIO Aggregator/Repeater driver
To: Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Eugeniu Rosca <erosca@de.adit-jv.com>
References: <20191127084253.16356-1-geert+renesas@glider.be>
 <20191127084253.16356-6-geert+renesas@glider.be>
From: Harish Jenny K N <harish_kandiga@mentor.com>
Message-ID: <585c4ad9-31fc-e87e-07c4-b8d6aa09c7e4@mentor.com>
Date: Tue, 3 Dec 2019 11:12:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191127084253.16356-6-geert+renesas@glider.be>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-08.mgc.mentorg.com (139.181.222.8) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.141.98
X-Mailman-Approved-At: Tue, 03 Dec 2019 09:05:26 -0500
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 linux-doc@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, Alexander Graf <graf@amazon.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Phil Reid <preid@electromag.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> +static int gpio_aggregator_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct gpio_desc **descs;
> +	struct gpiochip_fwd *fwd;
> +	int i, n;
> +
> +	n = gpiod_count(dev, NULL);
> +	if (n < 0)
> +		return n;
> +
> +	descs = devm_kmalloc_array(dev, n, sizeof(*descs), GFP_KERNEL);
> +	if (!descs)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < n; i++) {
> +		descs[i] = devm_gpiod_get_index(dev, NULL, i, GPIOD_ASIS);

can you please add this check as well as we need to return EPROBE_DEFER.

if (desc[i] == ERR_PTR(-ENOENT))
<                 return -EPROBE_DEFER;


> +		if (IS_ERR(descs[i]))
> +			return PTR_ERR(descs[i]);
> +	}
> +
> +	fwd = gpiochip_fwd_create(dev, n, descs);
> +	if (IS_ERR(fwd))
> +		return PTR_ERR(fwd);
> +
> +	platform_set_drvdata(pdev, fwd);
> +	return 0;
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id gpio_aggregator_dt_ids[] = {
> +	{ .compatible = "gpio-repeater" },
> +	/*
> +	 * Add GPIO-operated devices controlled from userspace below,
> +	 * or use "driver_override" in sysfs
> +	 */
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, gpio_aggregator_dt_ids);
> +#endif
> +
> +static struct platform_driver gpio_aggregator_driver = {
> +	.probe = gpio_aggregator_probe,
> +	.driver = {
> +		.name = DRV_NAME,
> +		.groups = gpio_aggregator_groups,
> +		.of_match_table = of_match_ptr(gpio_aggregator_dt_ids),
> +	},
> +};
> +
> +static int __init gpio_aggregator_init(void)
> +{
> +	return platform_driver_register(&gpio_aggregator_driver);
> +}
> +module_init(gpio_aggregator_init);
> +
> +static void __exit gpio_aggregator_exit(void)
> +{
> +	gpio_aggregator_remove_all();
> +	platform_driver_unregister(&gpio_aggregator_driver);
> +}
> +module_exit(gpio_aggregator_exit);
> +
> +MODULE_AUTHOR("Geert Uytterhoeven <geert+renesas@glider.be>");
> +MODULE_DESCRIPTION("GPIO Aggregator/Repeater");
> +MODULE_LICENSE("GPL v2");




