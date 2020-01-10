Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04148C33CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 12:47:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2F4620721
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 12:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qM05hBK0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F4620721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipthU-0004yo-RW
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 07:47:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1iptgr-0004Lt-It
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 07:47:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1iptgq-0003P2-FQ
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 07:47:01 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:34527)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1iptgq-0003J8-8N
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 07:47:00 -0500
Received: by mail-pg1-x531.google.com with SMTP id r11so982114pgf.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 04:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WdHnzZO32ty3v+k78hcRl2oqOefzkslYRsYqFmopqDY=;
 b=qM05hBK0Y6Os3wpIt+uOzEf+OhcYbmrdsyXu50wDLFs88Gf68o2Hul5IT3wfctZx5D
 D2WWvT75wHeJtrOT/Da5rY/ekVqiEG5MyCifT38Q0tUDFyXkVF2CCrTOaxe7KZUhYCWU
 rSnaSSnnlaeiFtKk8lBec81nzfMggtj4d7K5joGpde/X/gpFlvVZ4ND3Sxwn+t6cv1RP
 RU4Orump1O8VYPSwNAHXkmTZWFFM4G9BZwfc59cg2YltUayuSxTTxNc12+yVUUQTofHw
 cx6VhyvfeSvkcbcvs5OCFZxLvHlv61NCK39EFTutsoysaal86xlCPFBogpAvMvVjXGGq
 IZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WdHnzZO32ty3v+k78hcRl2oqOefzkslYRsYqFmopqDY=;
 b=CWNsGKAuO0sAo1fPKITRlnfePSzHV54C+L3S7wxJIWv/VyOHzywHIn20F+xKna4DJT
 ZZ5AApYC/s7HrD8gXcbhby7+EcWaQCL+FuuNNa805SM5ITo8EAGzdh8jc4D7c/vsZ1SS
 c5cXJDp8edidqnam8EnRI7escGUZJ3XosyES/9KDl1PqO/jZosql94tFAPEdNTzkyENs
 JINj+DueQLcfaNlmxSr5zfBQO+lDXRXHHWP7k4I71mNRHNZY4vibzRFhqcUZ2L3Y4+45
 6pR3n2bYGP5TRb8Yw49cl8hzWu42nlQZcIxqNG173mREfZEno0mVBPY9Kf0/JCnpseEE
 r2Jw==
X-Gm-Message-State: APjAAAWkWXFKsEO6xMtV3iowgj6OYe29GEEzkFk2hqF0LStf0X/8Xw2A
 V2EmFFogMO0G0kGQRkkfZdzNLDny
X-Google-Smtp-Source: APXvYqwyLvsNzfGW6hxKhFggqFcuoj4qMkJ5E9T/ErmGkWpcZutXsQqi5mTck7F1e/qpyOFmHMR9UQ==
X-Received: by 2002:aa7:86c3:: with SMTP id h3mr3974980pfo.225.1578660418405; 
 Fri, 10 Jan 2020 04:46:58 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 a28sm2980941pfh.119.2020.01.10.04.46.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2020 04:46:57 -0800 (PST)
Subject: Re: How to tell DMA controller in qemu to terminate transfer ?
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200108183553.GA5608@roeck-us.net>
 <CAFEAcA9t4X5Xnk0aS4C-vhKX2c3GA9XQ3zZRGYVGLEQsG=EgeQ@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <ece7c830-0561-2a4b-dc25-847a454b2fd6@roeck-us.net>
Date: Fri, 10 Jan 2020 04:46:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9t4X5Xnk0aS4C-vhKX2c3GA9XQ3zZRGYVGLEQsG=EgeQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::531
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 1/10/20 2:36 AM, Peter Maydell wrote:
> On Wed, 8 Jan 2020 at 18:36, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Hi,
>>
>> I am trying to fix DMA support with Exynos4210. The original commit
>> 59520dc65e ("hw/arm/exynos4210: Add DMA support for the Exynos4210") doesn't
>> really work, primarily because it assigns wrong interrupt lines (no idea
>> how I thought I tested that).
>>
>> Problem I have right now is that the pl330 peripheral DMA in Exynos4210
>> depends on a signal from the peripheral device (here: serial ports)
>> to end a DMA transfer. To make this work, I need a signal from
>> exynos4210_uart.c to pl330.c to terminate the DMA after the receive
>> buffer is empty.
>>
>> How can I implement this in qemu ?
> 
> That depends. How does the UART signal the DMA controller
> in real hardware? If there's a signal line of some kind,

Yes, that is my understanding.

> then you can model that with a qemu_irq line which the UART
> exposes and raises/lowers at the right time, that's then
> plumbed through by the SoC to the DMA controller.
> 

Makes sense. Can you give me some hints on how to do that, or point me
to an example ?

The pl330 dma code registers a set of gpio pins tied to pl330_dma_stop_irq().
I suspect that is what I am looking for, I just have no idea how to tie
it to the serial driver code.

Thanks,
Guenter

