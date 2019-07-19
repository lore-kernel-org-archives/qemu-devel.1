Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3907EC76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 12:59:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 100ED21851
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 12:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100ED21851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoSTp-00005F-6b
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 08:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56942)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hoSTc-0007zv-8x
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 08:59:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hoSTb-0005px-5x
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 08:59:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32955)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hoSTa-0005oz-V5
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 08:59:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so32251528wru.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 05:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4B4nQdZGDsRrXe5YRYbfuq/NMdgbXHtZKN6m44/KPps=;
 b=ZihiHj9jraKAa5KbrXlPXtHyaomVJQX5OjIZl53lUhNe0o9VnW5uJUBZLAG8Ojajec
 nXUR6WxrrY3TogPsDR/9iMu0WK5lG/TfVOjC4XEXQIncUiLA+erVsramfCqxdg0OUv/B
 WyBXFOu/CjXZKBG0alPb8BQozc+GvVTBQ7ZIzfflUqBZ+3O0654wIzqWKbVNEdGC4iYg
 zJdMabhNF3J/AgZ+IYa7yOIUBRQO5/CG9SkoZ5vzAbmuX4yTgL7uFt5fBQlGu1DsFOyP
 NwgQQ61tXrKNjdzaUl6R9Ux4vR7ef5zk6vfvi8Hu/wE5y3Cxik13D5zK5uicmzNV28F9
 iXeg==
X-Gm-Message-State: APjAAAUVUFtvwdOEof0kAf8L52zCfhWCL4ipf4+L6MXTl48gQ3lNzy0/
 YxK70pfEgncrYAhX4jY6of7+Hw==
X-Google-Smtp-Source: APXvYqyS+0giYPyTPIfFWMnKDfT/03qnvjgNmr1R4+iJNviXzP+zikmaz44KB0YEFvpxTlAKTL75Aw==
X-Received: by 2002:a5d:540e:: with SMTP id g14mr9513693wrv.346.1563541145794; 
 Fri, 19 Jul 2019 05:59:05 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id v4sm25441083wmg.22.2019.07.19.05.59.04
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 19 Jul 2019 05:59:05 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190719111451.12406-1-philmd@redhat.com>
 <CAFEAcA92mCp6WYb5wVEYbVNEFkPb9TwpedjNwj4SdS9Mb_rNtw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <fb3221bd-3cfd-ebd7-9a80-3f531769fef4@redhat.com>
Date: Fri, 19 Jul 2019 14:59:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA92mCp6WYb5wVEYbVNEFkPb9TwpedjNwj4SdS9Mb_rNtw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH-for-4.1] target/arm: Add missing break
 statement for Hypervisor Trap Exception
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
 qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/19/19 1:47 PM, Peter Maydell wrote:
> On Fri, 19 Jul 2019 at 12:15, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> Reported by GCC9 when building with  -Wimplicit-fallthrough=2:
>>
>>   target/arm/helper.c: In function ‘arm_cpu_do_interrupt_aarch32_hyp’:
>>   target/arm/helper.c:7958:14: error: this statement may fall through [-Werror=implicit-fallthrough=]
>>    7958 |         addr = 0x14;
>>         |         ~~~~~^~~~~~
>>   target/arm/helper.c:7959:5: note: here
>>    7959 |     default:
>>         |     ^~~~~~~
>>   cc1: all warnings being treated as errors
>>
>> Fixes: b9bc21ff9f9
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  target/arm/helper.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index 20f8728be1..b74c23a9bc 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -7956,6 +7956,7 @@ static void arm_cpu_do_interrupt_aarch32_hyp(CPUState *cs)
>>          break;
>>      case EXCP_HYP_TRAP:
>>          addr = 0x14;
>> +        break;
>>      default:
>>          cpu_abort(cs, "Unhandled exception 0x%x\n", cs->exception_index);
>>      }
> 
> I think this is right, but EXCP_HYP_TRAP is a bit odd -- we appear
> to use this only for the case of "SMC instruction is trapped from
> NS EL1 to EL2 by HCR.TSC". I was expecting more traps-to-EL2
> to use this EXCP_ variable... Mostly we seem to use EXCP_UDEF,
> eg for CP_ACCESS_TRAP_UNCATEGORIZED_EL2 coprocessor/sysreg accesses:
> this has the same behaviour as EXCP_HYP_TRAP as long as we know
> we are going from an EL below 2 to EL2. Which I think we could
> also use in the one place we use EXCP_HYP_TRAP; or we could make
> wider use of EXCP_HYP_TRAP, since feeding everything through
> EXCP_UDEF is rather confusing.
> 
> Anyway, for 4.1 we should do this.
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Thanks, if you take this I forgot to mention:
Reported-by: Stefan Weil <sw@weilnetz.de>

Regards,

Phil.

