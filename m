Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36032C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:25:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01F1920671
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qifUWqtL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F1920671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaiaT-0007la-6z
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jaiZv-0007DC-Dj; Mon, 18 May 2020 12:25:23 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52575)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jaiZu-0001Jz-Iu; Mon, 18 May 2020 12:25:22 -0400
Received: by mail-wm1-x343.google.com with SMTP id z4so131354wmi.2;
 Mon, 18 May 2020 09:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=g+OkLPH00natUE/QeEo1Oz57yS1HlKJlItfC1StyQqo=;
 b=qifUWqtLdWbTxI1zNUx+2H5Inz2Qn/OiRWatuoEM8sp168ruVfdMJMwassXPSoiUiy
 soVGgFZARyBMDihGcb8XVoRmJLtY8TynCyIcdGKoMy0GuXqxm9NFV4Bpl7fU32LBYN10
 WVagPmba0TP2u52pfB1zXyDjCrc8bjOFk28m+BSO+akX6vHDEbj3DqIGqAYt+Qg8BeOR
 77t5gcxyUisQXKMWKnnhFOS8o5GrWrvfbUan6HfUnvRzZ62Ya5tG+wx8/cIxLerTdja+
 2iIvYvagWe2ezq4blq1p/Gzk1c/c6xBvDGHN7jcEvs+viUAcJUIG4+4KBhn1AFpFG2BC
 gnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=g+OkLPH00natUE/QeEo1Oz57yS1HlKJlItfC1StyQqo=;
 b=TL8YN4x7ua9mMw2V2hqahN2RusMaEBhHYfQtj3B1uMygZDLFETt20+9J1LhIO8JmqG
 sXUr8OzLJYYdw43tp7BpsqKPb4UKYLUad6kzx7ABVDdpqbcLrngqOH8Zmdj+DEx1w7k5
 FHq8GrxpY7OEEjZkbQc0b8kqgKM1SLOLhUYFbxx3DLtHS/oFGfvmAstUXGBwrbgw5zDr
 fabLhrq1+jDE47FKsSN/Cn7+nGOHSmAMHm7AfWN3G8hT3cUoLt9v4MgMUe6c4fhKaNXI
 RGIkaiVd1nlOCM4MGaYx13rIgeXCebsUh+6P/LCdW30FiVzogF5pYI5RMHgAPm/aJwQP
 2bGg==
X-Gm-Message-State: AOAM531mt9gZGdCk991HU+m9RWgDE+ezZ4cjoxEAXrLnAHm3TtzSYEqF
 tLqF83NEhOICO/S9PScO6zM=
X-Google-Smtp-Source: ABdhPJwgP6cEp+GRltPGLnvb5dZednwNrKy/G61xUoGcKIDYpxV/+qZajUU3wOBHNQQIR+cOefblOA==
X-Received: by 2002:a7b:c939:: with SMTP id h25mr171618wml.9.1589819120346;
 Mon, 18 May 2020 09:25:20 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id 37sm17501667wrk.61.2020.05.18.09.25.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 09:25:19 -0700 (PDT)
Subject: Re: [RFC PATCH v2 7/7] hw/core/loader: Assert loading ROM regions
 succeeds at reset
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200518155308.15851-1-f4bug@amsat.org>
 <20200518155308.15851-8-f4bug@amsat.org>
 <CAFEAcA97bYXyN-GSXUk_OetroaHFExXFwYH1bhexHwRW0+NEVw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <02f900f6-26e8-f809-5d96-2092db260cf3@amsat.org>
Date: Mon, 18 May 2020 18:25:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA97bYXyN-GSXUk_OetroaHFExXFwYH1bhexHwRW0+NEVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, kvm-devel <kvm@vger.kernel.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 6:12 PM, Peter Maydell wrote:
> On Mon, 18 May 2020 at 16:53, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> If we are unable to load a blob in a ROM region, we should not
>> ignore it and let the machine boot.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> RFC: Maybe more polite with user to use hw_error()?
>> ---
>>   hw/core/loader.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/core/loader.c b/hw/core/loader.c
>> index 8bbb1797a4..4e046388b4 100644
>> --- a/hw/core/loader.c
>> +++ b/hw/core/loader.c
>> @@ -1146,8 +1146,12 @@ static void rom_reset(void *unused)
>>               void *host = memory_region_get_ram_ptr(rom->mr);
>>               memcpy(host, rom->data, rom->datasize);
>>           } else {
>> -            address_space_write_rom(rom->as, rom->addr, MEMTXATTRS_UNSPECIFIED,
>> -                                    rom->data, rom->datasize);
>> +            MemTxResult res;
>> +
>> +            res = address_space_write_rom(rom->as, rom->addr,
>> +                                          MEMTXATTRS_UNSPECIFIED,
>> +                                          rom->data, rom->datasize);
>> +            assert(res == MEMTX_OK);
> 
> We shouln't assert(), because this is easy for a user to trigger
> by loading an ELF file that's been linked to the wrong address.
> Something helpful that ideally includes the name of the ELF file
> and perhaps the address might be nice.
> 
> (But overall I'm a bit wary of this and other patches in the series
> just because they add checks that were previously not there, and
> I'm not sure whether users might be accidentally relying on
> the continues-anyway behaviour.)

I understand. Thanks for reviewing, I'll rework this one and the 
previous set_kernel_args().

> 
> thanks
> -- PMM
> 

