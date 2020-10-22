Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E549C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 05:57:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8AC521775
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 05:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HOYJSqfL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8AC521775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVTbe-0004km-N5
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 01:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kVTaW-0004AN-No
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 01:56:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51199)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kVTaU-0002iA-2d
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 01:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603346191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kv+aPmPypuWkjVdKZKVjI3OAQ8lkJLGF0uwQShcA2lk=;
 b=HOYJSqfLXGT7XcJy4O6Eysyae2JdaqXQOhop4mjRD9eYdVlalFyYamHokKTxaR6bkb61h4
 iI/DPZgiyOTrWW1OJ6ojd1XHnckXa1NrCUTAVeP/WB4BAWRzyFDG9cSSJTMEqv2fOmv/Yc
 +v6XborrsjskUWKGle2M/VzNb+W08qA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-F65nkHD3P1eNeWpZvSljoA-1; Thu, 22 Oct 2020 01:56:28 -0400
X-MC-Unique: F65nkHD3P1eNeWpZvSljoA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E05E35F9EA;
 Thu, 22 Oct 2020 05:56:25 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-77.ams2.redhat.com [10.36.112.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A190A7512A;
 Thu, 22 Oct 2020 05:56:22 +0000 (UTC)
Subject: Re: [PATCH v2 2/5] hw/timer: Adding watchdog for NPCM7XX Timer.
To: Havard Skinnemoen <hskinnemoen@google.com>, peter.maydell@linaro.org
References: <20201021213544.3399271-1-hskinnemoen@google.com>
 <20201021213544.3399271-3-hskinnemoen@google.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ba5f019a-1919-c5e9-d061-3d38ec075603@redhat.com>
Date: Thu, 22 Oct 2020 07:56:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201021213544.3399271-3-hskinnemoen@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 23:30:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: venture@google.com, qemu-devel@nongnu.org, wuhaotsh@google.com,
 kfting@nuvoton.com, qemu-arm@nongnu.org, Avi.Fishman@nuvoton.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/10/2020 23.35, Havard Skinnemoen via wrote:
> From: Hao Wu <wuhaotsh@google.com>
> 
> The watchdog is part of NPCM7XX's timer module. Its behavior is
> controlled by the WTCR register in the timer.
> 
> When enabled, the watchdog issues an interrupt signal after a pre-set
> amount of cycles, and issues a reset signal shortly after that.
> 
> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
> ---
[...]
> diff --git a/tests/qtest/npcm7xx_watchdog_timer-test.c b/tests/qtest/npcm7xx_watchdog_timer-test.c
> new file mode 100644
> index 0000000000..bfe0020ffc
> --- /dev/null
> +++ b/tests/qtest/npcm7xx_watchdog_timer-test.c
> @@ -0,0 +1,313 @@
> +/*
> + * QTests for Nuvoton NPCM7xx Timer Watchdog Modules.
> + *
> + * Copyright 2020 Google LLC
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
> + * for more details.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/timer.h"
> +
> +#include "libqtest-single.h"
[...]
> +/*
> + * Check a watchdog doesn't fire if corresponding flags (WTIE and WTRE) are not
> + * set.
> + */
> +static void test_enabling_flags(gconstpointer watchdog)
> +{
> +    const Watchdog *wd = watchdog;
> +    QTestState *qts;
> +
> +    /* Neither WTIE or WTRE is set, no interrupt or reset should happen */
> +    qts = qtest_start("-machine quanta-gsj");
> +    qtest_irq_intercept_in(qts, "/machine/soc/a9mpcore/gic");
> +    watchdog_write_wtcr(wd, WTCLK(0) | WTE | WTIF | WTRF | WTR);
> +    clock_step(watchdog_interrupt_steps(wd));
> +    g_assert_true(watchdog_read_wtcr(wd) & WTIF);
> +    g_assert_false(qtest_get_irq(qts, wd->irq));
> +    clock_step(watchdog_calculate_steps(RESET_CYCLES, watchdog_prescaler(wd)));
> +    g_assert_true(watchdog_read_wtcr(wd) & WTIF);
> +    g_assert_false(watchdog_read_wtcr(wd) & WTRF);
> +    qtest_end();

You are mixing functions from libqtest.h and libqtest-single.h ... e.g. you
use qtest_get_irq() from libqtest.h instead of get_irq() from
libqtest-single.h, on the other hand, you use clock_step() from
libqtest-single.h instead of qtest_clock_step() from libqtest.h ... there is
no real problem with this, but the style looks a little bit strange.

For new tests, we prefer nowadays to avoid libqtest-single.h since it causes
trouble if you have to track multiple test states (e.g. when writing tests
that include migration tests). Could you maybe try to rewrite your code
without libqtest-single.h? I.e. use qtest_clock_step() instead of
clock_step() etc. ?

> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 28d4068718..f7b0e3ca9d 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -139,6 +139,7 @@ qtests_arm = \
>     'microbit-test',
>     'm25p80-test',
>     'npcm7xx_timer-test',
> +   'npcm7xx_watchdog_timer-test',

Could you please fence this test with CONFIG_NPCM7XX ? ... since it won't
work if the quanta-gsj machine has not been compiled into the binary.

 Thanks,
  Thomas


