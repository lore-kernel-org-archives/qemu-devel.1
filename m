Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CC5C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:48:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBB022074F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t0SG5iTD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB022074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc8So-0000nh-PN
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 09:48:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kc8Q7-0007fw-2o; Mon, 09 Nov 2020 09:45:23 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39451)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kc8Q5-000680-9Q; Mon, 09 Nov 2020 09:45:22 -0500
Received: by mail-wm1-x341.google.com with SMTP id s13so8166317wmh.4;
 Mon, 09 Nov 2020 06:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5GSgk6kQ6yXsnJXDMm15hYEtz1aUgz+bK4w0F6YNx5c=;
 b=t0SG5iTDqzLYCtrEgDxmsitwPaieRJCS04Ph7KlAsyeiOstmPpOSGu84rqoPiuDSaz
 uCx8Ck8sURxH6tfdYaUeg0it42e5yAFvtFMYEbOPUfGRJU0LvWlRBU1GSTPo4fK71FxW
 kWTpqCQD5k/7rMB2OhBMcszW9p/G1XH0ya+gvEdgNqTRnaopBA+pDJDctugNL9ai7s2n
 R2TDUJW7WHl/4/JDmxE9ee2Eaz8rBKcDOKftKndN2o69pKMAC1lktlKyiS7hDEv2t1vo
 blsJd2xlG0zPcf902OXenMykC8B4EI8TPKtoykQNQ6FmXnoYa8uwQoDOEipImgMV0dI5
 o4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5GSgk6kQ6yXsnJXDMm15hYEtz1aUgz+bK4w0F6YNx5c=;
 b=TX/npbDLmQFsa+N8WGC5rZ0idVUBEu04YZAtO70P0L4CqXvq3XTfW/0mi8rubF2qQU
 BYJetKmwS3/1jKAjlo/ziTbQqKf3TOL+hNRDro+BazIYJPktDaCTheR5yRJzlPyMAh1d
 MTQrcg61WQyfF/Omrb3vprE+JpA5tW8FZKE4URTCX0R8noFPqBlOdz60KkWSriBQ/zMm
 jKNnMV+uRQgauRGhfcRj/O1vdzOB0m05yZipsEFZh+kv4OHlO7bo6h0fZpTvImV+Tv0o
 K9lCrbiulxPS3medrwOKu2oxUgXyFm9bWQovVwfAfIRYg9ptCT5trQaXqNWfb0frgYWU
 8VSg==
X-Gm-Message-State: AOAM53095S1n+EH5XVSdqFuAZp90/ZbHI6v2lQLBTiIRsI2eDdaAipyG
 WCH4+wVqF+nfW+k7IQgFgAA=
X-Google-Smtp-Source: ABdhPJw87ZgNiMOZjM32n0SZCmBzCHVDXvQbZKwqdsY2Br6TGAh2yHZVUrYt3A3DqnRtXmnjH87bLg==
X-Received: by 2002:a7b:c202:: with SMTP id x2mr8957861wmi.48.1604933118960;
 Mon, 09 Nov 2020 06:45:18 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id g66sm13369945wmg.37.2020.11.09.06.45.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 06:45:18 -0800 (PST)
Subject: Re: [PATCH-for-5.2 0/5] hw/arm: Fix various incorrect IRQ handling
To: Peter Maydell <peter.maydell@linaro.org>
References: <20201107193403.436146-1-f4bug@amsat.org>
 <CAFEAcA-O7vrAAaMpMWyeUzAO3BOQf3A28XoSY72SB7zOgeedkw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b78c53ba-8330-fd60-4741-a1ce172a7097@amsat.org>
Date: Mon, 9 Nov 2020 15:45:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-O7vrAAaMpMWyeUzAO3BOQf3A28XoSY72SB7zOgeedkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-arm <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/9/20 3:23 PM, Peter Maydell wrote:
> On Sat, 7 Nov 2020 at 19:34, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> This series is inspired by Peter's following patch:
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg758178.html
>>
>> I started to audit the IRQ uses and fixed the easy problems.
>>
>> Unresolved ones:
>> - stellaris_init() connects different TYPE_STELLARIS_GPTM
>>   to the same ADC input (seems some weird kludge)
>> - platform_bus_link_device() uses sysbus_has_irq() to check
>>   if an device has IRQ mapped but it doesn't seem to work.
> 
> Were you finding these by inspection, or did you add some
> kind of assert or other check for double-irq-line-connections?

I was not sure adding a field to IRQState would be accepted,
so I added a trace event in qdev_connect_gpio_out_named():

 trace_qdev_connect_gpio_out(pin, n, name,
                             object_get_typename(OBJECT(dev)));

And lookup up when 'pin' pointer value appears more than 1 time.

For 6.0 I am wondering about replacing --enable-qom-cast-debug
by --maintainer-mode and add a field in IRQState guarded for
that mode. Maybe it is not too bad and we can use it normally.

> 
> Applied to target-arm.next, thanks (deletion of omap_uart_attach()
> can be a separate followup cleanup).

Yes, I have *some* OMAP patches for 6.0 ;)

> 
> -- PMM
> 

