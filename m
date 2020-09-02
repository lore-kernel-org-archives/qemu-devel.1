Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD92C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 10:42:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9166620773
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 10:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1Fzr8Ow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9166620773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDQDg-0000te-Q4
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 06:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDQDA-0000Tf-A0
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 06:41:52 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42928)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDQD8-0006BM-KK
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 06:41:51 -0400
Received: by mail-wr1-x441.google.com with SMTP id c18so4680311wrm.9
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 03:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=h/L5jEMkU/jx6yKnHP6i9LPShAhUaqGHDVzZOAVjN9Q=;
 b=T1Fzr8OwKH32et4gsqb6HoiYBhf2aTWofcIh4minbauEbeLmWPi4sQDFQd/FpznXxZ
 ljhmx3RuTK544/MaJpz+ujaxI8d4vro76esIjSNKyo820iIwgd2hVGBHEUxnTJ5Uo7uz
 XUe53gxHpmaCasFAJ19B0C61B0m6O0I9VJavvor+6c5Ys0nZZh5DCr494BEIMrbC3P7l
 +KkOnDod6sXAiDObyWJ/tIx/cujb8XLtma7yPKEsC3Spd+27QgMLJgB7g061rm5tCUAr
 3EtqJfI8Ttsju4fJzLxDHfNYLiqS5ogiWN/8QNCZg4HtvWK6+8pFJsw1jrj6mA1X/bb+
 Zkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h/L5jEMkU/jx6yKnHP6i9LPShAhUaqGHDVzZOAVjN9Q=;
 b=frOHBm/wAYITKlYQI+0apyKoCWCrqlaiVediCZ9fR76CibYFKEsrr9JpweqcOtBltB
 x4J5Ca5Q8bnW/ZI1KBtrCf+mkt2nVBvmJhUll8bYeZzhAKFI8O0/NroaCW3cbAF7DoGk
 /CHSx9T/cFeB3fDFOWfavY5F/E6lOUiN6V4lTFtEJuIzHcQuodjF+KZuC0AuX9x4vd9I
 EP699dGQz2Du9rWjE0t5DQhge1HcZkQOMss2+eW+PjiM6ecM6AOL7xcy2aDZvfNrfibH
 W1UajUbAbJMpHzDFHgczIXVPVCTwKDafp20/6vxO8WguQrbissXzvrs50StNIRGxX5Dl
 mN7A==
X-Gm-Message-State: AOAM530w0UMQZprzhVcabysNIZiVR9Hpbf8abhSjgJyQ633yk4mH44Q+
 D/JjYQXz+3n0QiD7P21J2kw=
X-Google-Smtp-Source: ABdhPJykqw+sZjqvZ0F5uV0AZP1YPJG0oLmcnZRt4FK8uf/cWqpOWCNY/lYZrYcsTWAiUTomKYobpA==
X-Received: by 2002:adf:f7d0:: with SMTP id a16mr6197725wrq.381.1599043309092; 
 Wed, 02 Sep 2020 03:41:49 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id s11sm6407667wrt.43.2020.09.02.03.41.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 03:41:48 -0700 (PDT)
Subject: Re: [PATCH-for-5.2 0/4] hw/char/serial: Use the Clock API to feed the
 UART reference clock
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200806130340.17316-1-f4bug@amsat.org>
 <c02e70ec-2567-5c0e-f85d-2acfb8ba009a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <39b07d18-7dfd-60b3-6a6a-c6a49cdcd025@amsat.org>
Date: Wed, 2 Sep 2020 12:41:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <c02e70ec-2567-5c0e-f85d-2acfb8ba009a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-2.13,
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
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/1/20 7:02 PM, Paolo Bonzini wrote:
> On 06/08/20 15:03, Philippe Mathieu-Daudé wrote:
>> This series improve tracing of multiple UART device in the same
>> chipset, and allow to use the Clock API to feed each device with
>> an (updatable) input clock.
>>
>> Based-on: <20200730165900.7030-1-philmd@redhat.com>
>> "hw/char: Remove TYPE_SERIAL_IO"
>>
>> Philippe Mathieu-Daudé (4):
>>   hw/char/serial: Replace commented DPRINTF() by trace event
>>   hw/char/serial: Remove old DEBUG_SERIAL commented code
>>   hw/char/serial: Let SerialState have an 'id' field
>>   hw/char/serial: Use the Clock API to feed the UART reference clock
>>
>>  include/hw/char/serial.h |  4 +++
>>  hw/char/serial.c         | 55 +++++++++++++++++++++++-----------------
>>  hw/char/trace-events     |  5 ++--
>>  3 files changed, 39 insertions(+), 25 deletions(-)
>>
> 
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Are you planning to deprecate the baudbase property, and instead setting
> up the clock already in serial_mm_init?

I'd love to get there, but unfortunately most of serial_mm_init() have
the baudrate/frequency argument wrong, because it has never been very
clear it was the uart input clock, so most users sets the default
baudrate expected by their guest.

Maybe a sane way to get this slowly fixed is to add a new
serial_mm_init2() documenting it expects an input clock rate
argument (or even better, a connected clock), use it where possible,
deprecate serial_mm_init(), let the maintainer eventually adapt...

I'm not comfortable adding yet another deprecation that will stay
during years.

> 
> Thanks,
> 
> Paolo
> 
> 

