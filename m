Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FE5C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 17:45:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3238D21881
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 17:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3238D21881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hijJv-0004Af-FF
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 13:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49204)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hij4P-0008A4-0U
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:29:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hij4N-0000V5-Ry
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:29:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40371)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hij4N-0000UO-Lj
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:29:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id p11so3722482wre.7
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 10:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MEn7K/TgOp/IuaIZLgOCuQC1NjhtCJuVxJS1zARlZn8=;
 b=hcQhC+14pWgKjJ3YobzQgn/YuKS0Tebegn0sI62PjjNSKhfYupEl595NcFTjVwZetm
 Wd+zwb0g/jGyiBda64bK+o3vfVp23K5rsyP9H0gijFrooiOmGsd0HaR3Ei/xO2w7/5Wy
 jNO8y6xdTOEmD/R+PzZyauh0TBcAhUPhDBeeJkAtKLoY9U2q2d9MFQfpj4/pmZLW2u4h
 jz8+OwQ5KzhtXSazdjacwj4PuRIPyKZa2wvX6WRDvgbMay3MlVbnXYfeU9pK7d8mkmTa
 dc2x3HQXMwb5Y1YgZqs0mkuOw90UE0mT4YlQq8RK5Hxc1s81wpClP21P2nSUIHRCT3l5
 CzBw==
X-Gm-Message-State: APjAAAXszA79vvjCZxhnZlU0BP9npPMxi3PmrurTaoRR00ckSZONjiYh
 Fh5ssEVEr8YUeDnRyENCl2PPYw==
X-Google-Smtp-Source: APXvYqz4dwrdn7d72Zb6rx8+AvLe5LwgV4X7Z3Kp84py24LdPiAd5HQemNBO4HwOFPI50tHsZg2TuQ==
X-Received: by 2002:a05:6000:1285:: with SMTP id
 f5mr14595394wrx.315.1562174962604; 
 Wed, 03 Jul 2019 10:29:22 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id h6sm3478029wre.82.2019.07.03.10.29.21
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jul 2019 10:29:22 -0700 (PDT)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20190703171005.26231-1-philmd@redhat.com>
 <20190703172501.GI23082@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <68e01f65-7dc2-232f-0b7b-436867a1f28b@redhat.com>
Date: Wed, 3 Jul 2019 19:29:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190703172501.GI23082@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [RFC PATCH-for-4.2] tracing: Allow to tune tracing
 options via the environment
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
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/19 7:25 PM, Daniel P. Berrangé wrote:
> On Wed, Jul 03, 2019 at 07:10:05PM +0200, Philippe Mathieu-Daudé wrote:
>> We can pass trace trace options with the -trace command line
>> argument.
>>
>> Tracing might be useful when running qtests. To avoid to have
>> to modify the tests and recompile, add the possibility to pass
>> trace options via the shell environment.
>>
>> We add:
>> - QEMU_TRACE_EVENTS:    List of events to enable (coma separated)
>> - QEMU_TRACE_EVENTFILE: File with list of events to enable
>> - QEMU_TRACE_LOGFILE:   File to log the trace events.
>>
>> Example of use:
>>
>>   $ QEMU_TRACE_EVENTS=pl011\* make check-qtest-arm
>>     TEST    check-qtest-arm: tests/boot-serial-test
>>   18650@1562168430.027490:pl011_can_receive LCR 0x00000000 read_count 0 returning 1
>>   18650@1562168430.027535:pl011_can_receive LCR 0x00000000 read_count 0 returning 1
>>   18650@1562168430.027544:pl011_can_receive LCR 0x00000000 read_count 0 returning 1
>>   18650@1562168430.028037:pl011_can_receive LCR 0x00000000 read_count 0 returning 1
>>   18650@1562168430.028049:pl011_can_receive LCR 0x00000000 read_count 0 returning 1
>>   18650@1562168430.028057:pl011_can_receive LCR 0x00000000 read_count 0 returning 1
>>   18653@1562168430.053250:pl011_write addr 0x00000000 value 0x00000054
>>   18653@1562168430.053276:pl011_irq_state irq state 0
>>   [...]
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>> I'm not sure where to document that...
>> ---
>>  trace/control.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/trace/control.c b/trace/control.c
>> index 43fb7868db..aea802623c 100644
>> --- a/trace/control.c
>> +++ b/trace/control.c
>> @@ -288,6 +288,8 @@ void trace_fini_vcpu(CPUState *vcpu)
>>  
>>  bool trace_init_backends(void)
>>  {
>> +    char *trace_env;
>> +
>>  #ifdef CONFIG_TRACE_SIMPLE
>>      if (!st_init()) {
>>          fprintf(stderr, "failed to initialize simple tracing backend.\n");
>> @@ -306,6 +308,13 @@ bool trace_init_backends(void)
>>      openlog(NULL, LOG_PID, LOG_DAEMON);
>>  #endif
>>  
>> +    trace_init_file(getenv("QEMU_TRACE_LOGFILE"));
>> +    trace_init_events(getenv("QEMU_TRACE_EVENTFILE"));
>> +    trace_env = getenv("QEMU_TRACE_EVENTS");
>> +    if (trace_env) {
>> +        trace_enable_events(trace_env);
>> +    }
>> +
> 
> I don't think it is a nice idea to add this via environment variables
> to QEMU itself. Why not modify libqtest qtest_init_without_qmp_handshake
> to read the env vars and then pass a suitable -trace arg when spawning
> QEMU ?

Fine by me.

