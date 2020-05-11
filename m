Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0826BC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 07:04:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9366206F5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 07:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kh5djo/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9366206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY2UO-0008DS-SV
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 03:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jY2Tk-0007g1-Lu; Mon, 11 May 2020 03:03:56 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37776)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jY2Tj-0007FB-OR; Mon, 11 May 2020 03:03:56 -0400
Received: by mail-wr1-x441.google.com with SMTP id k1so9459315wrx.4;
 Mon, 11 May 2020 00:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PBbm2rT9MzHZvmOkHUsfFM7PIuWNpVS0isoEqsMJPYU=;
 b=kh5djo/qT1QepUQXmC7b/4aACZZDxutLcxDu6O8xdmYDaxjF4dT1cjorJbw/9g6vHo
 SGrJc7O2Rv2gqDt68meWMBvaymTZ75ycGNWmO+/MSnZsNu5CUVonp548GFcPXUi9o0Xk
 VR8stWqIJvcqyiyT+xj1XOJdPfJU2lwnm/YfV2aFU/v+NdJ0cVZtyB4KYyyQqVvTTbSw
 XHJPHiviDthU7PVmjovA1TrG9hw7g2WQFh+4HyJpdrqaWamY9axqksoTwA/BYKlJ6h0j
 cSkkiDhEN1vQTmTAuYqnwyyTK3HhJsmnbIvLtna52uy56CzvSOcMOU2FbciUqVa+n4ik
 +g8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PBbm2rT9MzHZvmOkHUsfFM7PIuWNpVS0isoEqsMJPYU=;
 b=lMiSeYd89YpKm8S6S5Tyty2LD0uHW8L0Rg+FG2H/bGHQX20igkigwgbIVf9O0m8FsB
 bhW3WQsorGDQqkgWpfHva3ha0chMrvz6YWh+u0IT885dvFgGCDrGQfNB4b92Y/X3rTPq
 lmGUrimI13E88ScPSi1YLMaCeGKo1qIkDO2O0cZ6N2X47WPC5rSLy+2JF5J78XpKN1Ih
 8xtbSfLt3Ik48Fh+WAXBnYxynw7KtTfOj9aelEcORxAw0MfilNf3UnUgCr8APng5BxE3
 U0u0HPbF4e+KpxnuMGeLm/Lziz35MPf2zgdLVmN+r3pLxaSUeOzw6kbxBY1bCoJMexcF
 HCew==
X-Gm-Message-State: AGi0PuabsU6/qtXHiqFpFoNZWjfes34EoUyDv6gKXz04Ko8Y8Llrhdco
 vDWpIZiiFlbY22k8O29zfTUgu0+j1Ko=
X-Google-Smtp-Source: APiQypJ4GwxuRJ2fTHQd2J6Fq/Gvpf5Jltc2DngGaFJ9IoI3A/GBMUfjbIhtapWindIVYs6f8pXctg==
X-Received: by 2002:a05:6000:12c2:: with SMTP id
 l2mr5358852wrx.133.1589180633670; 
 Mon, 11 May 2020 00:03:53 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id b2sm12300203wrm.30.2020.05.11.00.03.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2020 00:03:52 -0700 (PDT)
Subject: Re: [PATCH 0/7] hw/sparc/leon3: Few fixes and disable HelenOS test
To: KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20200331105048.27989-1-f4bug@amsat.org>
 <81737d76-06c6-4c83-1287-b0d14db4ce2f@amsat.org>
 <989bf2f5-0e23-f9c3-e9e1-0bd8c03f3231@adacore.com>
 <1b7a4c63-5a31-6efe-d807-7092e3ee0ffb@amsat.org>
 <230dbf6b-120a-f1f0-d48d-9fa4a04e05cd@adacore.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <23588fda-b95b-45a9-b788-e846d26a3bc3@amsat.org>
Date: Mon, 11 May 2020 09:03:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <230dbf6b-120a-f1f0-d48d-9fa4a04e05cd@adacore.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Fabien Chouteau <chouteau@adacore.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Jiri Gaisler <jiri@gaisler.se>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/14/20 12:00 PM, KONRAD Frederic wrote:
> Le 4/13/20 à 11:07 PM, Philippe Mathieu-Daudé a écrit :
>> [Cc'ing Peter]
>>
>> On 4/13/20 12:12 PM, KONRAD Frederic wrote:
>>> Le 4/11/20 à 7:30 PM, Philippe Mathieu-Daudé a écrit :
>>>> On 3/31/20 12:50 PM, Philippe Mathieu-Daudé wrote:
>>>>> Philippe Mathieu-Daudé (7):
>>>>>     hw/misc/grlib_ahb_apb_pnp: Avoid crash when writing to AHB PnP
>>>>>       registers
>>>>>     hw/misc/grlib_ahb_apb_pnp: Fix AHB PnP 8-bit accesses
>>>>
>>>> Ping ^^^ for 5.0?
>>>
>>> Hi Philippe,
>>>
>>> You already have my rb tag for those one, and IMHO they should be good
>>> candidate
>>> for 5.0 (if it's not too late).
>>
>> Yes, thanks for the reviews. I see Mark Cave-Ayland merged this file
>> first, but you are listed as maintainer :) I was hoping you could send a
>> pull request.
> 
> Yes that's usually Mark who take the patches, sorry I didn't get it.

No worries. As there are other sparc64 patches on the list, maybe Mark 
will prepare a pull request now.

> 
>>
>> $ scripts/get_maintainer.pl -f hw/misc/grlib_ahb_apb_pnp.c
>> Fabien Chouteau <chouteau@adacore.com> (maintainer:Leon3)
>> KONRAD Frederic <frederic.konrad@adacore.com> (maintainer:Leon3)
>> qemu-devel@nongnu.org (open list:All patches CC here)
>>
> 
>> This is a bug but not 'security critical', so it might wait 5.1 and go
>> via qemu-trivial tree.
> 
> Well let's do that then if you're ok.

OK, then ping? :)

> 
> Best Regards,
> Fred
> 
>>
>> Regards,
>>
>> Phil.
>>
>>>
>>> Cheers,
>>> Fred
>>>
>>>>
>>>>>     hw/misc/grlib_ahb_apb_pnp: Add trace events on read accesses
>>>>>     hw/timer/grlib_gptimer: Display frequency in decimal
>>>>>     target/sparc/int32_helper: Remove DEBUG_PCALL definition
>>>>>     target/sparc/int32_helper: Extract and use excp_name_str()
>>>>>
>>>>>    hw/misc/grlib_ahb_apb_pnp.c             | 24 
>>>>> ++++++++++++++++++++++--
>>>>>    target/sparc/int32_helper.c             | 23 
>>>>> ++++++++++++-----------
>>>>>    hw/misc/trace-events                    |  4 ++++
>>>>>    hw/timer/trace-events                   |  2 +-
>>>>>    tests/acceptance/machine_sparc_leon3.py |  4 ++++
>>>>>    5 files changed, 43 insertions(+), 14 deletions(-)
>>>>>
>>>
> 

