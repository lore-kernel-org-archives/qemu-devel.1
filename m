Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB280C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 12:35:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87A3E20656
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 12:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGgM59t3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A3E20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlAo5-0004VC-NI
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 08:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlAmf-00035x-2e; Tue, 16 Jun 2020 08:33:45 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39552)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlAmd-0005D7-Bx; Tue, 16 Jun 2020 08:33:44 -0400
Received: by mail-wr1-x443.google.com with SMTP id t18so20596657wru.6;
 Tue, 16 Jun 2020 05:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=47eh3HGocx2BK0pc1Z1UhwE4Gua/bYH9z9fQuBPCvh4=;
 b=gGgM59t3vr6et+ra+VyAFd+8DUJSFtyhHNrZHDpVGSv0aNDG4V1miZZ3vAhv+yzM5p
 fnEjp0hcTCP3VVLpo/5faJmXd/jYwDOrmOoSL/yZzdhpjzkoLaC+wO25/STBPgmHtvrJ
 MLgsv/p+N8A0YjG/La576P4LxD2/01Ho+acOZTK1BSep/FLF0om4oCKiLHNaeuACmU5l
 c6LC2WFw5b21f8sivOrMWH9n70Ds7EA/4GzewTrubHWGZKYgpu/reGi8w5RcOWQ+gLpO
 88AxsriJp6htF+OET0OAhmsjR24uVQrrbz9lquz+V0Z7F0pO6mcslAauqiyYYKnEroxb
 6OnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=47eh3HGocx2BK0pc1Z1UhwE4Gua/bYH9z9fQuBPCvh4=;
 b=ewmkI1BTLRuUIarbeX16yyxrpyIwPAO+iVjYui4K5G8tRupteIaoiVoqgVRxgUUmn3
 PtVM+zlp1BNZjrZgaZ6+wDWzE3fu3H5oxxFG0Le18zL8lzAV/JR8Y8jKBunwHEMrHBRV
 hLoSATTOSDBBleVZvp1roayVCwz+R9PM3jYPbSaj3lYKHAXd+x1KJFSssCPpzMp71ApU
 t2DeoounujX7YhISa+cwj4XB0pGowA/v6M7+tUzO0c/TjCssD3XJKZfqqUCeuLMChZy6
 lVQ9hWYGFEhYutd+crbWNA8j3E3t6ylgBpHyMR2WCn5igxzkOdJlKKh7b3/+BUFcos1N
 4gsA==
X-Gm-Message-State: AOAM532zXp+g44N3P3CKPnd2mK18GWr1gTlq+7N/y84U1cr4TcEvK2+1
 8JSOU5nSmmbUpMtJ88ginXLVakf8
X-Google-Smtp-Source: ABdhPJyRemYpzMMzWVTZUIyH2hBSszCpbwn8rmsNLMitmTRjCx9hdCZwgZjtyb9b+DWs/z/CNvaJ0g==
X-Received: by 2002:a5d:6b83:: with SMTP id n3mr2842496wrx.395.1592310821204; 
 Tue, 16 Jun 2020 05:33:41 -0700 (PDT)
Received: from [192.168.1.37] (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id h12sm28895026wro.80.2020.06.16.05.33.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2020 05:33:40 -0700 (PDT)
Subject: Re: [PATCH 7/7] hw/misc/mps2-fpgaio: Implement push-buttons
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200616063157.16389-1-f4bug@amsat.org>
 <20200616063157.16389-8-f4bug@amsat.org>
 <CAFEAcA8c3QVD=PcfMOXn720E0ExSdV+mb3qoA61AFrFVstFHHw@mail.gmail.com>
 <84c3ce87-fefd-5741-7588-7a8ca12fde4c@amsat.org>
 <CAFEAcA_GuCQRuwAgbQfHRKh732Kfzwj-zxX48tjBBnWCBjKLnQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ba21ad8a-e4a3-ca61-9e31-41d9163db1b3@amsat.org>
Date: Tue, 16 Jun 2020 14:33:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_GuCQRuwAgbQfHRKh732Kfzwj-zxX48tjBBnWCBjKLnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: Esteban Bosse <estebanbosse@gmail.com>,
 Joaquin de Andres <me@xcancerberox.com.ar>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/16/20 2:29 PM, Peter Maydell wrote:
> On Tue, 16 Jun 2020 at 11:40, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> On 6/16/20 12:27 PM, Peter Maydell wrote:
>>> This change seems kind of pointless unless these GPIO lines are
>>> actually wired up to something.
>>
>> Yes, I should have kept it out of this series, or documented
>> better the goal in the cover.
>>
>> I'm setting the roots to motivate a team of developers to
>> work on a visualization of the MPS2 board. The push-button is
>> supported by Zephyr, so the the idea is the visualizer generates
>> QMP GPIO event to be processed such in pca9552_set_led(), and
>> interact with the guest firmware.
> 
> I think that having a framework so we can better model this kind
> of push button / LED / similar thing is definitely good. I just
> think we need to review it at the framework level first -- it
> might turn out that actually the right way to wire up the push
> button to the UI framework isn't with a GPIO wire at all.
> Similarly with the other patchset that sends QMP events for
> LEDs -- that also seems like it's half of a design and a bit
> awkward to review without the context for what it connects to.

On my side feedback are helpful, but I understand.
I'll see if there are still any motivated soul left,
else wait for next GSoC.

> 
> thanks
> -- PMM
> 

