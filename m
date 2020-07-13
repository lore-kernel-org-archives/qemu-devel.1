Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AA8C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:22:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 078A6206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0rTd40i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 078A6206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juvbi-00049a-8y
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 06:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1juvav-0003bv-1y; Mon, 13 Jul 2020 06:21:57 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:38221)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1juvat-0006j4-KP; Mon, 13 Jul 2020 06:21:56 -0400
Received: by mail-ed1-x542.google.com with SMTP id n2so12926174edr.5;
 Mon, 13 Jul 2020 03:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ew0LjgKxer7dMgC7YCWEb0Y+JHoLrJwh3azB8gzNQDI=;
 b=O0rTd40iYT+XrcUDZAjopzJ0O9Wv/k8PhITw7omLxOtBDxoXECxEZDUxpFVbnQsEtd
 K0F1LhvpGixWcdzW0ysB6ezG9ERkX2Bn2xXuf4ta/DhC3SurFOPrMDyQUQC9pAcNq64H
 mN23x5tWEvposfmcrRMPUhd/XecCEbngM+Ttk4XST9jY/vinNp3SfJ6CqPsQsasLuKB5
 Y2E3yQJ4ULl1B3vZMI3jSa5o1W62v7KZL30yLHpEYxlqW1sZleVMnmXDbPQdlY8Dd+I2
 UIsbVX4B6Og7vRgExjp/2tiJmp58o7zTNX752lC8oHRya0xOcju/GKdP7sWXf83NVwfY
 rpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ew0LjgKxer7dMgC7YCWEb0Y+JHoLrJwh3azB8gzNQDI=;
 b=dus7NT1rljb4DC8acSnx1wIskJb+ev3B+tK6huvH7OuILLGfZzENin4kAz55c0AV7J
 fJdYmlg6G14yfYBpaJfjngyG/5JnzhIReEFccyFgn+baoO7XkJH/T/ITYu1x1HQ6TOJw
 u5ojQlBjfD3kvVboDTzuDfIK0fka/NYfp0Nf1g4wk+Q+nRzIHk9F70SA8/xI14Y2AvyS
 Ou+dspf21DtH/EiTa4Nh8kjitPBtpBzwDPNI/J79Ds+oOsRqPfGCoz4D52KnLWIYBUJD
 FEsU9C2tLouq0zmC+OHHQKsVtOkWEG+tQQpBsMvQ0BjuWlIXLc7/msKMkWRlw/2qhYnv
 p3qw==
X-Gm-Message-State: AOAM532L+MfipPFelUicR4ZhQRIV6jQ8ojyQNJ8T7SDFP8TNtE9K6eVv
 UK5YUySj+Cm5TEdJsPSfsrc=
X-Google-Smtp-Source: ABdhPJyfvFX+/K2gG+MjsfracCfzyZI+uNlIDyYOecCJoQfFMO1+Sa2SYzYuOkVahcWXRZgroDwUMw==
X-Received: by 2002:a05:6402:742:: with SMTP id
 p2mr69106542edy.135.1594635713807; 
 Mon, 13 Jul 2020 03:21:53 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id q6sm3385641ejn.30.2020.07.13.03.21.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 03:21:53 -0700 (PDT)
Subject: Re: [PATCH 2/2] hw/arm/palm.c: Encapsulate misc GPIO handling in a
 device
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200628214230.2592-1-peter.maydell@linaro.org>
 <20200628214230.2592-3-peter.maydell@linaro.org>
 <4c049b0c-f305-729a-748d-0a7742b496ed@amsat.org>
 <CAFEAcA_JCSs6BCCw-MYOO8RcyXQ_iNZ63KjuwqEPM7yuvWsdTA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c9fe0637-9870-b155-3b50-0da3f03d279f@amsat.org>
Date: Mon, 13 Jul 2020 12:21:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_JCSs6BCCw-MYOO8RcyXQ_iNZ63KjuwqEPM7yuvWsdTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/13/20 12:05 PM, Peter Maydell wrote:
> On Mon, 13 Jul 2020 at 09:57, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> Why not make it a generic container in the MachineState and create
>> the container in hw/core/machine.c::machine_initfn()?
> 
> I don't think we create containers like that for any other
> machine, do we?

No but maybe we could. Most boards have some GPIO/LED/reset switch
button. Do all machines have a NUMA memory device? Do all machines
have a dtb? Do all machines use NVDIMM devices? I think we have
more machines using GPIOs than machine using NVDIMM. Anyway I don't
mind, I was just trying to figure where this container belong on QOM.

