Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB84ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:42:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 044EE206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 044EE206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIx4B-0001mB-32
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 11:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58729)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iIwu8-0005bM-2o
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:32:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iIwu6-0007tn-R4
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:32:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33982)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iIwu6-0007te-IS
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:32:30 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 84BB036955
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 15:32:29 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id g67so2926540wmg.4
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 08:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TTNwXGAH3v0yrumASKaZWVZxIJF8Ky07UUwhTxJXXXc=;
 b=WtYb6pJ3U7GEwcqHih7GbDKezZHdmMWafXdEyrldepCw/wPh6Jc1DyFzbYTIw3S9KI
 aNkT1DmnOamXYtntlNltnPvgFbiaCxnirHkuNKfWfs0lsNt4RvnSO0P58mUME7BQJhbs
 6C4vJl7WL0+netmZhiaYB1HLfE/fyNktHRXHnJF0t9ubzTJeRQqjP7cxN4rYgcO2mU1w
 mbdEgILXNsY7HcvZ3RBnAjNEZySl29MoOQQC+6fHGeDPbK8ne6jd+SRfKiIQ/v4i8P45
 Yd1h07J1HHCSnxgd2Vk3GPeQ2ygOHjeRr6TQ0EGkzhmDU5bhACFw+hWl7vuRPsCuxIiT
 OVkA==
X-Gm-Message-State: APjAAAWmsK1kMjQk25HefCPjet83DlJsPvr2qHuSjujnq/VilF4AGop2
 O9v1FI0G1mX6PGN3kKIWdmGtOf9yBKddCQvkW3jR0gYm41nulrnAGetclPx5SKHGoltJxY66xua
 cqWiDf06AchNOyMo=
X-Received: by 2002:a7b:c006:: with SMTP id c6mr3829846wmb.45.1570807948218;
 Fri, 11 Oct 2019 08:32:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzUk8h5TuXXshN6EoWdGpX+50n4inGmd7EwsHFh69jU/Tvht+OEebUck4F/14DqYxg6/lrBsA==
X-Received: by 2002:a7b:c006:: with SMTP id c6mr3829832wmb.45.1570807948009;
 Fri, 11 Oct 2019 08:32:28 -0700 (PDT)
Received: from [192.168.50.31] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id r2sm16556080wma.1.2019.10.11.08.32.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2019 08:32:27 -0700 (PDT)
Subject: Re: [PATCH v30 0/8] QEMU AVR 8 bit cores
To: Michael Rolnik <mrolnik@gmail.com>, qemu-devel@nongnu.org
References: <20190902140134.74081-1-mrolnik@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <949009b8-58ec-4a9e-cfd7-7d4611fad380@redhat.com>
Date: Fri, 11 Oct 2019 17:32:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190902140134.74081-1-mrolnik@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: dovgaluk@ispras.ru, thuth@redhat.com, richard.henderson@linaro.org,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Michael,

On 9/2/19 4:01 PM, Michael Rolnik wrote:
> This series of patches adds 8bit AVR cores to QEMU.
> All instruction, except BREAK/DES/SPM/SPMX, are implemented. Not fully tested yet.
> However I was able to execute simple code with functions. e.g fibonacci calculation.
> This series of patches include a non real, sample board.
> No fuses support yet. PC is set to 0 at reset.
> 
> the patches include the following
> 1. just a basic 8bit AVR CPU, without instruction decoding or translation
> 2. CPU features which allow define the following 8bit AVR cores
>       avr1
>       avr2 avr25
>       avr3 avr31 avr35
>       avr4
>       avr5 avr51
>       avr6
>       xmega2 xmega4 xmega5 xmega6 xmega7
> 3. a definition of sample machine with SRAM, FLASH and CPU which allows to execute simple code
> 4. encoding for all AVR instructions
> 5. interrupt handling
> 6. helpers for IN, OUT, SLEEP, WBR & unsupported instructions
> 7. a decoder which given an opcode decides what istruction it is
> 8. translation of AVR instruction into TCG
> 9. all features together
> 
[..]
> Michael Rolnik (7):
>    target/avr: Add outward facing interfaces and core CPU logic
>    target/avr: Add instruction helpers
>    target/avr: Add instruction decoding
>    target/avr: Add instruction translation
>    target/avr: Add example board configuration
>    target/avr: Register AVR support with the rest of QEMU, the build
>      system, and the MAINTAINERS file
>    target/avr: Add tests
> 
> Sarah Harris (1):
>    target/avr: Add limited support for USART and 16 bit timer peripherals

Overall architecture patches look good, but I'd like some more time to 
review the hardware patches. Unfortunately I won't have time until November.
There was a chat on IRC about your series, I suggested Richard we could 
merge patches 1-4 and 7. They are almost sufficient to run the 
qemu-avr-tests gdbstub tests (but not the FreeRTOS ones).

Regards,

Phil.

