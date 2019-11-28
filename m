Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7957BC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 14:55:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41F7921787
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 14:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITdPEGUp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F7921787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaLCO-0006Vu-Ef
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 09:55:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iaKb5-0003vU-DG
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:16:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iaKb1-00039M-DN
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:16:41 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26271
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iaKb1-00033v-55
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:16:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574950593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LCVw4mrAw9FF5xe6tYaRDcNiKwElj0FBQRlhKCvaSnU=;
 b=ITdPEGUpzMQduuT7GjnPby5vS4SD+9FTWmjMqHxki9jzu/3oqQ1h8wcmuGIXaYFY/KOh/a
 d8qKsRykJzgXTvVme5YTEdfPGwcgDIw94Gf5saRkOQHoIXT2x9DDS3KdAh0Mv9tOautXVM
 vMTeL5CLAXJaFPxN8zoG/DKIqP2Xxeo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-TbsMH3a4OaemuJvquJpedg-1; Thu, 28 Nov 2019 09:16:31 -0500
Received: by mail-wm1-f72.google.com with SMTP id t203so3614415wmt.7
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 06:16:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LCVw4mrAw9FF5xe6tYaRDcNiKwElj0FBQRlhKCvaSnU=;
 b=j3XC04J1TuytTairJ6RkY3/FNdOeJuHp5v7AFmNiyisvc0voxJBefJAYpX5ZwZuPlr
 Wza6puwKUtV4xowSC41IX1JUOqA0WDg6v8dYb0w7tDVGIn5TiTBGtM+5rasVTOSIm+Vc
 4tGnKWPwHRqi2F2oeP7EvACh+bm99IZksscPjfGiC0zrMAHRbXs7O7o98jF3KhYmolJj
 7il1KZHemCNtZm170VGRDJ3YWixOwbPRSLUeMMFb4zQGjSh0H+UK40E0akafXDJbwMmU
 /YrYJCPGv3lB5y5tvBlscdLpSH97eK4WyNceOQUN9M7NoF/Jg/BQ6wr2TAytStvgknrd
 Mttw==
X-Gm-Message-State: APjAAAUSUyAw4QBRNipMQyORMcuRYVNLF/uRm+fZYUuvKjjcJ3P3tD2A
 pIFNZOpqabBOgl1A+H/t/qHL3vwheLEUK0ES3vO5tk11kmt/c/Tn9D5lZzqCvWHOR4aRlcVdOEd
 50VDceUo3LxeCRoI=
X-Received: by 2002:a5d:55ce:: with SMTP id i14mr2413244wrw.182.1574950590735; 
 Thu, 28 Nov 2019 06:16:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqy0L9kd3BPAw52AlSjzGsKFJbEleN58RYuZ08iVCbUoP50VSmiI+nJgobGnDpkGaF7A2Lhc/A==
X-Received: by 2002:a5d:55ce:: with SMTP id i14mr2413220wrw.182.1574950590490; 
 Thu, 28 Nov 2019 06:16:30 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id i127sm11086176wma.35.2019.11.28.06.16.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2019 06:16:29 -0800 (PST)
Subject: Re: [PATCH v37 00/17] QEMU AVR 8 bit cores
To: Michael Rolnik <mrolnik@gmail.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20191127175257.23480-1-mrolnik@gmail.com>
 <CAL1e-=isp_-zF71STK-v5D8r5sGYiZbRFmSzjfQtR2FC5YknHQ@mail.gmail.com>
 <CAK4993iniaLhSYCe9hfuNpujpEdqPtZqqsJirBwYG9HqUVx6dA@mail.gmail.com>
 <CAL1e-=h+ZHM9qOOMj2KASuN2J4rSYcn1KP1hOzTWp+EpBY3=5A@mail.gmail.com>
 <CAK4993jDe+c7XsNn=fBwMu6TLuF8KgxNvUziXkwAUuOVArjrsA@mail.gmail.com>
 <5a784557-f322-dc3a-4ff1-a7d9a0409448@redhat.com>
 <CAL1e-=jJ5uNvYq7yNQYFhMJ0k94-d6mrybs-NyVjVi9Agb4Aeg@mail.gmail.com>
 <CAK4993i8zPyYH2hGxx0hP4qQKr9oTJV2T5JDtQmKHZe2EpAsvw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2540f517-5662-2afb-fb2f-4720fddd7eb5@redhat.com>
Date: Thu, 28 Nov 2019 15:16:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAK4993i8zPyYH2hGxx0hP4qQKr9oTJV2T5JDtQmKHZe2EpAsvw@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: TbsMH3a4OaemuJvquJpedg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Thomas Huth <thuth@redhat.com>, Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, QEMU Developers <qemu-devel@nongnu.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/28/19 2:46 PM, Michael Rolnik wrote:
> I will rename them.

Please wait comments from Richard before a version respin.

> On Thu, Nov 28, 2019 at 3:41 PM Aleksandar Markovic 
> <aleksandar.m.mail@gmail.com <mailto:aleksandar.m.mail@gmail.com>> wrote:
[...]
> 
> 
>         If I understand Aleksandar correctly, the naming is incorrect
>         because too generic to AVR family, why Sarah only modeled the
>         Atmel implementation.
> 
>         Renaming devices such hw/char/avr_usart.c ->
>         hw/char/atmel_usart.c (similarly with the macros) would be
>         enough Aleksandar?
> 
> 
> 
>     Some renaming could help, perhaps not quite like the one above, but
>     my point (which I find hard to believe I can't explain to you) is
>     that peripherals inside the chip evolved over time, as starkly
>     opposed to external peripherals that are set in stone...


