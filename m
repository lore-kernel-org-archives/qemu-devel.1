Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BA3C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:53:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BB1D2073E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9ZuN7yN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB1D2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDst-0006ni-8m
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqDs1-0005Yy-5J
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:52:09 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:46485)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqDry-0004aq-J4
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:52:08 -0400
Received: by mail-ed1-x543.google.com with SMTP id dm19so9462240edb.13
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 03:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=oUAvepZBmnXl7GmsAkefYWPuWcrszgJ5Nyplb1cfUcQ=;
 b=e9ZuN7yNwMl1YsvtUjSYGKr7MLS92s/Lv3V3XbNa661qXPnApkd4IwUdCp/L5z77nt
 eXAIVNpMvB/S4jjDWOgAqkRwih6bgz5vqhHXSQXSyFzZs6aga2zhuSbZ6hAvnHyCW0dc
 7HzlfuDJHCEGftD2RJQIsUHE0dP2x7lxB6w+9l3pThBzRH5+ivdXr740oT2rU4X6uGo3
 TFBRF+F2JNlWY4zsJsBAu//VkQ2rm185GCW7wLykRIIcM8U8Lcs1lBcJBy/2GFwncgZU
 oWgGy7uvFYzn04SfIYYAvpEKKF/b/Jn+RsZXIOqUYyFuIVVKitYSFtuZ6ftlpRPDF34h
 PZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oUAvepZBmnXl7GmsAkefYWPuWcrszgJ5Nyplb1cfUcQ=;
 b=oAc+VzugFGFa0EbmhLiRJIarILYhwQ8BHogTL9/TmYQVSyil0s+YJvs8TZgAgaTrwK
 YELf7YvqC7DfuaLOGPuWJdAR8dNDq7XLRyGl28vX/W6wBd7ZmeeLaE/S2TIjMyJHwrYp
 DdbxvnShDMZlgSEnf030FGbPm9+gtBnZeLsp0/Y+zxV02XaP2dA2XaUjRVveE7qpdsqC
 y5Zmw7kcOH2pHvV7DSmF5UezQMlyE+71Kesvt28Cw87vx1764q9NHCD2+096PSNoPHls
 Sdhj140dtZ75XeA9sHaXxyaWMWEQO6t4GmMM0Y2/G9pH4gCbKRUCAk93u2Zx7ihjxR6E
 3Skg==
X-Gm-Message-State: AOAM531eW5q0cfrMNHfy36grBWITMMmx9nUkKm1HG52WDwtx5qVMWR1Q
 20TLwIYw234N+WCvYt+g54E=
X-Google-Smtp-Source: ABdhPJwvuslu5wgzbwXdBTD4wXEABc5LC1zfyTgHnKMaT9sW2WzI/aR/fvGKZxFU+w5snJywxkk1aw==
X-Received: by 2002:a50:9306:: with SMTP id m6mr22283040eda.216.1593514324904; 
 Tue, 30 Jun 2020 03:52:04 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id y7sm1659667ejd.73.2020.06.30.03.52.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 03:52:04 -0700 (PDT)
Subject: Re: [PATCH 0/7] hw/mips/malta: Rework to allow more than 2GB of RAM
 on 64-bit
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <20200630081322.19146-1-f4bug@amsat.org>
 <CAHiYmc6coeBBOvCAs+=Ccw2aXfw0m3gTdSM1Pc8AQvJ4QNBhow@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <da6c2f55-b8b7-3492-37b3-d24a25106d72@amsat.org>
Date: Tue, 30 Jun 2020 12:52:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHiYmc6coeBBOvCAs+=Ccw2aXfw0m3gTdSM1Pc8AQvJ4QNBhow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x543.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yunqiang Su <ysu@wavecomp.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/30/20 12:48 PM, Aleksandar Markovic wrote:
> 
> 
> уторак, 30. јун 2020., Philippe Mathieu-Daudé <f4bug@amsat.org
> <mailto:f4bug@amsat.org>> је написао/ла:
> 
>     Hi,
> 
>     Following Jiaxun Yang's patch and discussion:
>     https://patchwork.kernel.org/patch/11416915/
>     <https://patchwork.kernel.org/patch/11416915/>
> 
>     - Rename the current machine as 'malta-virt' (keeping 'malta' aliased)
>       Suggestions for better names are welcome, maybe 'malta-unreal' or
>       'malta-unleashed' instead?
>     - Add 'malta-phys' which respects hardware restrictions (on RAM so far)
>     - Unleash 'malta-virt' to allow more than 2GB on 64-bit
> 
>     Philippe Mathieu-Daudé (7):
>       hw/mips/malta: Trivial code movement
>       hw/mips/malta: Register the machine as a TypeInfo
>       hw/mips/malta: Rename 'malta' machine as 'malta-virt'
>       hw/mips/malta: Introduce MaltaMachineClass::max_ramsize
>       hw/mips/malta: Introduce the 'malta-phys' machine
>       hw/mips/malta: Verify malta-phys machine uses correct DIMM sizes
>       hw/mips/malta: Allow more than 2GB on 64-bit malta-virt
> 
>      hw/mips/malta.c | 121 +++++++++++++++++++++++++++++++++++++++---------
>      1 file changed, 99 insertions(+), 22 deletions(-)
> 
>     -- 
> 
> 
> 
> Thank you, Philippe, for providing this series.
> 
> However, in previous discussion on the patch you mention above, I
> already expressed serious reservations on the approach taken in that
> patch. These reservations stay today too.
> 
> There is nothing qualitatively different between the original patch and
> this series. Naming and related stuff are just cosmetic issues.

OK, what about considering all patches except the last one?
So we can run firmware on a real Malta board, not the QEMU
imaginary one (in the discussion you said QEMU should respect
real hardware, which I agree).

> 
> The good thing about this series is that one can apply it dowstream, if
> one finds it useful. However, it is not suitable for upstreaming 
> 
> Regards,
> Aleksandar
> 
>  
> 
>     2.21.3
> 

