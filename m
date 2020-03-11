Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0575DC10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:00:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C350820873
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C350820873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC020-0001t8-RK
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 08:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuzenghui@huawei.com>) id 1jC01J-0001Kp-5s
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 07:59:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuzenghui@huawei.com>) id 1jC01H-0000zy-SA
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 07:59:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3276 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuzenghui@huawei.com>)
 id 1jC01F-0000ef-1J; Wed, 11 Mar 2020 07:59:25 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 84AEF31DAF8532D5D5B4;
 Wed, 11 Mar 2020 19:59:14 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Wed, 11 Mar 2020
 19:59:07 +0800
Subject: Re: [kvm-unit-tests PATCH v5 10/13] arm/arm64: ITS: INT functional
 tests
To: Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
 <maz@kernel.org>, <kvmarm@lists.cs.columbia.edu>, <kvm@vger.kernel.org>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <20200310145410.26308-1-eric.auger@redhat.com>
 <20200310145410.26308-11-eric.auger@redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <d3f651a0-2344-4d6e-111b-be133db7e068@huawei.com>
Date: Wed, 11 Mar 2020 19:59:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200310145410.26308-11-eric.auger@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: andre.przywara@arm.com, drjones@redhat.com, alexandru.elisei@arm.com,
 thuth@redhat.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eric,

On 2020/3/10 22:54, Eric Auger wrote:
> Triggers LPIs through the INT command.
> 
> the test checks the LPI hits the right CPU and triggers
> the right LPI intid, ie. the translation is correct.
> 
> Updates to the config table also are tested, along with inv
> and invall commands.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---

[...]

> +static void test_its_trigger(void)
> +{
> +	struct its_collection *col3, *col2;
> +	struct its_device *dev2, *dev7;
> +
> +	if (its_prerequisites(4))
> +		return;
> +
> +	dev2 = its_create_device(2 /* dev id */, 8 /* nb_ites */);
> +	dev7 = its_create_device(7 /* dev id */, 8 /* nb_ites */);
> +
> +	col3 = its_create_collection(3 /* col id */, 3/* target PE */);
> +	col2 = its_create_collection(2 /* col id */, 2/* target PE */);
> +
> +	gicv3_lpi_set_config(8195, LPI_PROP_DEFAULT);
> +	gicv3_lpi_set_config(8196, LPI_PROP_DEFAULT);
> +
> +	its_send_invall(col2);
> +	its_send_invall(col3);

These two INVALLs should be issued after col2 and col3 are mapped,
otherwise this will cause the INVALL command error as per the spec
(though KVM doesn't complain it at all).

> +
> +	report_prefix_push("int");
> +	/*
> +	 * dev=2, eventid=20  -> lpi= 8195, col=3
> +	 * dev=7, eventid=255 -> lpi= 8196, col=2
> +	 * Trigger dev2, eventid=20 and dev7, eventid=255
> +	 * Check both LPIs hit
> +	 */
> +
> +	its_send_mapd(dev2, true);
> +	its_send_mapd(dev7, true);
> +
> +	its_send_mapc(col3, true);
> +	its_send_mapc(col2, true);
> +
> +	its_send_mapti(dev2, 8195 /* lpi id */, 20 /* event id */, col3);
> +	its_send_mapti(dev7, 8196 /* lpi id */, 255 /* event id */, col2);
> +
> +	lpi_stats_expect(3, 8195);
> +	its_send_int(dev2, 20);
> +	check_lpi_stats("dev=2, eventid=20  -> lpi= 8195, col=3");
> +
> +	lpi_stats_expect(2, 8196);
> +	its_send_int(dev7, 255);
> +	check_lpi_stats("dev=7, eventid=255 -> lpi= 8196, col=2");
> +
> +	report_prefix_pop();
> +
> +	report_prefix_push("inv/invall");
> +
> +	/*
> +	 * disable 8195, check dev2/eventid=20 does not trigger the
> +	 * corresponding LPI
> +	 */
> +	gicv3_lpi_set_config(8195, LPI_PROP_DEFAULT & ~LPI_PROP_ENABLED);
> +	its_send_inv(dev2, 20);
> +
> +	lpi_stats_expect(-1, -1);
> +	its_send_int(dev2, 20);
> +	check_lpi_stats("dev2/eventid=20 does not trigger any LPI");
> +
> +	/*
> +	 * re-enable the LPI but willingly do not call invall
> +	 * so the change in config is not taken into account.
> +	 * The LPI should not hit
> +	 */
> +	gicv3_lpi_set_config(8195, LPI_PROP_DEFAULT);
> +	lpi_stats_expect(-1, -1);
> +	its_send_int(dev2, 20);
> +	check_lpi_stats("dev2/eventid=20 still does not trigger any LPI");
> +
> +	/* Now call the invall and check the LPI hits */
> +	its_send_invall(col3);
> +	lpi_stats_expect(3, 8195);
> +	its_send_int(dev2, 20);
> +	check_lpi_stats("dev2/eventid=20 now triggers an LPI");
> +
> +	report_prefix_pop();
> +
> +	report_prefix_push("mapd valid=false");
> +	/*
> +	 * Unmap device 2 and check the eventid 20 formerly
> +	 * attached to it does not hit anymore
> +	 */
> +
> +	its_send_mapd(dev2, false);
> +	lpi_stats_expect(-1, -1);
> +	its_send_int(dev2, 20);
> +	check_lpi_stats("no LPI after device unmap");
> +	report_prefix_pop();
> +
> +	/* Unmap the collection this time and check no LPI does hit */
> +	report_prefix_push("mapc valid=false");
> +	its_send_mapc(col2, false);

And as for the MAPC, the spec says:

" When V is 0:
Behavior is unpredictable if there are interrupts that are mapped to the
specified collection, with the restriction that further translation
requests from that device are ignored. "

So this collection-unmap test may not make sense?

> +	lpi_stats_expect(-1, -1);
> +	its_send_int(dev7, 255);
> +	check_lpi_stats("no LPI after collection unmap");
> +	report_prefix_pop();
> +}

[...]

Otherwise looks good.


Thanks,
Zenghui


