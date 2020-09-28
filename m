Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F15C4727F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 10:54:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B79A52080A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 10:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="29XnbIk3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B79A52080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMqnu-0002TP-6P
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 06:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien.hedde@greensocs.com>)
 id 1kMqeo-0002gU-Cq
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 06:45:22 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:45268)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien.hedde@greensocs.com>)
 id 1kMqem-0006Vs-0U
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 06:45:21 -0400
Received: from [172.16.11.103] (unknown [172.16.11.103])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 73E5221C3A;
 Mon, 28 Sep 2020 10:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1601289917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7//spBWddOiCXkW45mWewK3nF5bO1KzCasLeaE0khzw=;
 b=29XnbIk39p+yY9DQEvKWSRHfbQkYD+kxOcbwc5P1iEx3IUrLWM0DFOonZ78I/TO+A6QPrt
 MRNG/aOapnzdp12cU4IZ327Qd5yGRv6yWGGV5pr0FrKYdZEPE590kbtGRRlrYsKBXvV1CC
 udMYzgd830dhSGf8aSrorQWT5dkIY30=
Subject: Re: [PATCH 3/3] hw/qdev-clock: Display error hint when clock is
 missing from device
To: Luc Michel <luc@lmichel.fr>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>
References: <20200927090820.61859-1-f4bug@amsat.org>
 <20200927090820.61859-4-f4bug@amsat.org>
 <20200928075300.q5ngcywiz5fyu6du@sekoia-pc.home.lmichel.fr>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <20f0ab00-8ca4-1a8f-43de-3b86dacc2124@greensocs.com>
Date: Mon, 28 Sep 2020 12:45:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200928075300.q5ngcywiz5fyu6du@sekoia-pc.home.lmichel.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.135.226.135;
 envelope-from=damien.hedde@greensocs.com; helo=beetle.greensocs.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 06:45:18
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.011,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Havard Skinnemoen <hskinnemoen@google.com>, qemu-devel@nongnu.org,
 Tyrone Ting <kfting@nuvoton.com>, Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/28/20 9:53 AM, Luc Michel wrote:
> On 11:08 Sun 27 Sep     , Philippe Mathieu-Daudé wrote:
>> Instead of directly aborting, display a hint to help the developer
>> figure out the problem (likely trying to connect a clock to a device
>> pre-dating the Clock API, thus not expecting clocks).
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Reviewed-by: Luc Michel <luc@lmichel.fr>

Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>

> 
>> ---
>>  hw/core/qdev-clock.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
>> index 47ecb5b4fae..33bd4a9d520 100644
>> --- a/hw/core/qdev-clock.c
>> +++ b/hw/core/qdev-clock.c
>> @@ -12,6 +12,7 @@
>>   */
>>  
>>  #include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>>  #include "hw/qdev-clock.h"
>>  #include "hw/qdev-core.h"
>>  #include "qapi/error.h"
>> @@ -153,6 +154,11 @@ Clock *qdev_get_clock_in(DeviceState *dev, const char *name)
>>      assert(name);
>>  
>>      ncl = qdev_get_clocklist(dev, name);
>> +    if (!ncl) {
>> +        error_report("can not find clock-in '%s' for device type '%s'",
>> +                     name, object_get_typename(OBJECT(dev)));
>> +        abort();
>> +    }
>>      assert(!ncl->output);
>>  
>>      return ncl->clock;
>> @@ -165,6 +171,11 @@ Clock *qdev_get_clock_out(DeviceState *dev, const char *name)
>>      assert(name);
>>  
>>      ncl = qdev_get_clocklist(dev, name);
>> +    if (!ncl) {
>> +        error_report("can not find clock-out '%s' for device type '%s'",
>> +                     name, object_get_typename(OBJECT(dev)));
>> +        abort();
>> +    }
>>      assert(ncl->output);
>>  
>>      return ncl->clock;
>> -- 
>> 2.26.2
>>

