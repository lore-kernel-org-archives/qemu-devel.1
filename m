Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670D7C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:04:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E9DA2067C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQOvH1Df"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E9DA2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDWBH-0005tc-BS
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 13:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDWAP-0004cQ-Th
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:03:25 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35958)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDWAO-0000VN-3n
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:03:25 -0400
Received: by mail-wm1-x342.google.com with SMTP id z9so134487wmk.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 10:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=f9Zn51oR4AS+8R6ONm+s6oMcQZaHVGGnrSVe/Q7ADgU=;
 b=SQOvH1DfD+Q/aQHMNQT8XWFsGgQGYr3RFoSpWsDeoU9g2zcLp+laVNyGjkMSOT7itD
 OZuQMM3WdVrVylYXzRt8SLz9/+j2KjaZUTrCpVV9fRgFF4nytO8lI4+XOUxrupoYuUsK
 7viJ9EwPiPwWGG9CI72qpx2AemosgQzZoXDMSRC+F137ePPWtK4Xnmbmb66nvIvkeNkC
 x5cVMWXs65KjIrD5VYJZq490cw9lJld/H2IKKphtZU1UXavaGxbeWUqdjPj68y96w0de
 eRbWMPG3QLNPbhp5N2S8VtK+v4GZIlHWuzymUy90pUBujoBAZHzBquUaIjfAsA8+EDI9
 SYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=f9Zn51oR4AS+8R6ONm+s6oMcQZaHVGGnrSVe/Q7ADgU=;
 b=lwUq+0lUP52evLPPvC6P14PBJ3pmzSlXTMRYxjXe1UBeJwzi9TZ7FFc9EjIz55rTPq
 ODLKrKq58ZSNgGw0Qt5bsktvCmlrjl80mzvyjxrlzcDrcWJZW90DWIzEiyX8ZdPbJig4
 neiDI6giUw5bpGs+rfjICLmLne5gWse9eh74I4ENi3xLgukxLNRlZmc9K2hU63C04Qi5
 MQDYLklDMMBiOnK+L8qQMPWM4MB7ABRWBQZFXJTKFONYaVCFEnD1sEKDAYbMnWPe63vi
 5paymIi0EGLVI7HMJ0PLGrNd2VR5UR8nuWeVHCmrtIJK9uJ1Yxzw5UvPgzsvZ757EVM6
 BqdQ==
X-Gm-Message-State: AOAM530jz7HmhVy0orHncVP5G9eLnviOAL3RnlNMuKIZXy7nvzh3PpqA
 zOpySjIYDvZsK/Zv+1qeDfg=
X-Google-Smtp-Source: ABdhPJwxSxjz0AMQTwRml57Ym4Re5mESr8PgXGjcu+BYQivQC6rnA8nZWGUmKS2ZJH0plr04yuzE6A==
X-Received: by 2002:a1c:1b93:: with SMTP id b141mr1530463wmb.166.1599066202362; 
 Wed, 02 Sep 2020 10:03:22 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id t4sm402583wre.30.2020.09.02.10.03.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 10:03:21 -0700 (PDT)
Subject: Re: hw/clock: What clock rate for virt machines?
To: Peter Maydell <peter.maydell@linaro.org>
References: <bbdacc80-a321-5f06-e430-973a38e7e037@amsat.org>
 <CAFEAcA8mwjWP-KhJ5bp_Qo_h81Mt_yn8k_5oepgMas9COBQgWQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f7b28480-c841-f0d7-a848-b5f1775ec12d@amsat.org>
Date: Wed, 2 Sep 2020 19:03:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8mwjWP-KhJ5bp_Qo_h81Mt_yn8k_5oepgMas9COBQgWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-0.324,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/2/20 6:49 PM, Peter Maydell wrote:
> On Wed, 2 Sep 2020 at 17:35, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> Peter said "'clock' is basically meaningless for virt machines",
>>
>> I understand and agree. But how to make that explicit/obvious in
>> the code, when a device expects a clock frequency/period?
> 
> When a particular *device* needs a clock, then presumably
> it has a defined purpose for it, and we can pick a
> frequency for it then.
> 
>> See for example hw/riscv/virt.c, it uses the following (confusing
>> to me) in virt_machine_init():
>>
>>    serial_mm_init(system_memory, memmap[VIRT_UART0].base,
>>        0, qdev_get_gpio_in(DEVICE(mmio_plic), UART0_IRQ), 399193,
>>        serial_hd(0), DEVICE_LITTLE_ENDIAN);
> 
> In this case, the board has a model of a 16550A UART on it,
> which uses its input clock to determine what the actual baud
> rate is for particular guest settings of the divisor registers.
> So we need to look at:
>  * what does guest software expect the frequency to be?

QEMU is supposed to model machine with no knowledge of the guest,
but the virt case is a particular one indeed... as it has to know
it is virtualized.

>  * what is a "good" frequency which gives the guest the best
>    possible choices of baud rate?

I'll think about it...

> and also at whether we need to tell the guest the frequency
> via a device tree or other mechanism.

Now I understand why the virt machines are so complicated...
Many dynamic information to provide to the guest.

> 
> In some devices the input clock genuinely doesn't affect the
> guest-visible behaviour, in which case we can pick an arbitrary
> or conventional value, or just implement the device to work OK
> without a clock connected.

I'm not sure all physical devices could work, but let's try this
way.

> 
> Note also that we don't have to make a single decision for the
> whole board -- we can run different devices with different clocks
> if that makes sense.
> 
> Incidentally the serial.c API seems to be slightly confused
> about the difference between setting the baudbase as a value
> in bps (ie the traditional 9600, 115200, etc values) or a
> frequency (where 115200 bps corresponds to a 1.8432MHz clock,
> apparently). Luckily nobody uses the serial_set_frequency()
> function :-)

Yes, it is a mess, I'm trying to not give up cleaning it.

Note, some boards correctly set the frequency:

musicpal, omap1 based, kzm, pxa2xx, boston.

lasi / jazz use an unlikely 8MHz clock.

For ppc405 I'm not sure this is an odd case:
  99MHz / 248 = 399193.54838709677419354838

Thanks!

> 
> thanks
> -- PMM
> 

