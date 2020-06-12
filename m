Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF82C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:52:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C11A207F7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WziJrXWY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C11A207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjlz8-00038K-NE
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 11:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jjlyG-0002Vz-79; Fri, 12 Jun 2020 11:51:56 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54727)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jjlyE-0005cV-Bi; Fri, 12 Jun 2020 11:51:55 -0400
Received: by mail-wm1-x342.google.com with SMTP id g10so8605381wmh.4;
 Fri, 12 Jun 2020 08:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5VtSQOdZrFGmtMpANsJ2uU35ZiAG6TcbZUdFC2WXhb8=;
 b=WziJrXWYOB9Y325Xgut4XQdicUVMFZFIp19WhsoZiZrnS4Ap7lHlTlMDHpmGASE5UT
 0XYbkrX3opSRQWIf8bffu0BsC4gNfKYf8x6gACqpK6zAFaOjUdDUsckHvF0IOi0kKs0B
 6+mF7PNgJSN3qNoBq3CjN82ZWfdnVM8MAfYFj1yXywjhkeiEFejIYXdM5SWPTJQWrTZP
 7v1v7owsRDx15w+zEUsmZkPOuC8FrWAvAd4zg7YuQB/y7Z6XxUBCKe1CRfemARO/2DoI
 B7TYjcF/WvYoki+klQCThV+sTBY2dxuIrW3sX6GLS2RTe56daCjM5a9Y0ShuXNmJ3Hs8
 hh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5VtSQOdZrFGmtMpANsJ2uU35ZiAG6TcbZUdFC2WXhb8=;
 b=MM++6jlpVHTbMfivXsbFwUMYTG0Ob1PRU17aVPbEzmHKBcSCDrN4YyParVX9sxqiAW
 BajVlb+hZJq9BA2ML1fToaIDdCVizCz6jasrIGHNAAbws40tuM9IODUVTQ0J4fg7GjxO
 WIES98nDfZyMFXxZAUKkTdtlvJ604hZyMW0cIiPqrw875nXQv5Nhs/hydOGX0qLZBWQT
 z7G25bhV1BQ/atj5nMdylO67Fg4lQrG0f0zq0Qsia54JgRikris/dp4RF0ciPqfvRKKx
 Ml9zkIJpctcYqtPwKpXQ+XetK5a8KFS91qXIhBu7OL+se/Nd1P3g5Kkw6ESprXaATFe1
 tzOQ==
X-Gm-Message-State: AOAM532Ob1xraY0MMviKJ3qdsL/Xzg+pkW3xAkXBZfJajNnROPUcPppn
 yqd/zlzEqam902qqbpdCwEs=
X-Google-Smtp-Source: ABdhPJxhUA8kDZHAdWJ+TpW1lO7ELIeOmOOWvr0xKe7zvpbOay7HxSBV/wZRoa6q/C+oYeVutIUMhw==
X-Received: by 2002:a1c:de55:: with SMTP id v82mr13994415wmg.148.1591977100230; 
 Fri, 12 Jun 2020 08:51:40 -0700 (PDT)
Received: from [192.168.1.40] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id c68sm3423851wmd.12.2020.06.12.08.51.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jun 2020 08:51:38 -0700 (PDT)
Subject: Re: [RFC PATCH 2/5] hw/misc/led: Add LED_STATUS_CHANGED QAPI event
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
References: <20200609123425.6921-1-f4bug@amsat.org>
 <20200609123425.6921-3-f4bug@amsat.org>
 <8e5154ba-0d80-d6f3-0da0-c20072173d9a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <906c2a2e-f823-f132-dc7e-f050b69364e7@amsat.org>
Date: Fri, 12 Jun 2020 17:51:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <8e5154ba-0d80-d6f3-0da0-c20072173d9a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eric,

On 6/9/20 4:29 PM, Eric Blake wrote:
> On 6/9/20 7:34 AM, Philippe Mathieu-Daudé wrote:
>> Allow LED devices to emit STATUS_CHANGED events on a QMP chardev.
>>
>> QMP event examples:
>>
>> {
>>      "timestamp": {
>>          "seconds": 1591704274,
>>          "microseconds": 520850
>>      },
>>      "event": "LED_STATUS_CHANGED",
>>      "data": {
>>          "name": "Green LED #0",
>>          "status": "on"
>>      }
>> }
>> {
>>      "timestamp": {
>>          "seconds": 1591704275,
>>          "microseconds": 530912
>>      },
>>      "event": "LED_STATUS_CHANGED",
>>      "data": {
>>          "name": "Green LED #0",
>>          "status": "off"
>>      }
>> }
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
> 
> The QAPI addition looks reasonable, however,
> 
>> +++ b/hw/misc/led.c
>> @@ -7,6 +7,7 @@
>>    */
>>   #include "qemu/osdep.h"
>>   #include "qapi/error.h"
>> +#include "qapi/qapi-events-led.h"
>>   #include "hw/qdev-properties.h"
>>   #include "hw/misc/led.h"
>>   #include "hw/irq.h"
>> @@ -19,6 +20,9 @@ static void led_set(void *opaque, int line, int
>> new_state)
>>         trace_led_set(s->name, s->current_state, new_state);
>>   +    /* FIXME QMP rate limite? */
> 
> s/limite/limit/
> 
> Yes, this is under guest control, so you MUST rate limit to avoid the
> guest being able to DoS qemu by changing the LED so frequently as to
> overwhelm the QMP connection with events.

Commits f544d174dfc and 7f1e7b23d5 refers to the qmp-events.txt
for documentation on rate-limiting QMP events, but I can't find
it in the codebase. Two files matches 'qmp-events' but don't have
documentation: qapi/qmp-event.c and include/qapi/qmp-event.h.

Last trace of it is in commit 231aaf3a8217. Apparently it was
somehow split qapi/event.json, then later c09656f1d392 move it
to qapi-schema.json, finally eb815e248f50 moved it to qapi/.

Is the referred documentation now in docs/devel/qapi-code-gen.txt?
There is only one occurence of 'limit' but it is unrelated to
rate-limit.

Thanks,

Phil.

