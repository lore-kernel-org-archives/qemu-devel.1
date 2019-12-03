Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA879C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 16:07:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 870FA2053B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 16:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XvmZCG4i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 870FA2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icAi6-0008MH-O6
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 11:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1icA7M-0000YS-WC
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 10:29:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1icA7E-0003im-KG
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 10:29:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50680
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1icA78-0003aL-VX
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 10:29:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575386957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WeerkaiTznFWZe+uFrLFBE25ivmPwQ5NX0TUY7VdjnU=;
 b=XvmZCG4ik084askNBa1nVGrltkHqBTvNZzNgy50r/KOXeBAyLvEIxiuzxLZTUat91yPAaX
 ZqsQt7K6rZ6Hwe4fuHHpnmkBIehYtNiPSIQrZBYrPtaPacty5vV08uhu8R9iKxX/0HWfLJ
 sKYDz2fJVii3iya7SkpimMu0YmBivvo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-giLozA4MPYyyib0vhu5rEg-1; Tue, 03 Dec 2019 10:29:16 -0500
Received: by mail-wm1-f70.google.com with SMTP id f16so1071517wmb.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 07:29:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WeerkaiTznFWZe+uFrLFBE25ivmPwQ5NX0TUY7VdjnU=;
 b=iPsjCLd6EXm4bOPiIVxxQ9nw+tvEnhDO4PGmcrc4rbLrn0R5WiilMgcJU+lZoOaJoz
 kvo1KRC1sQsFnLo3aO0qlh7iq+CH2x5be3x8uwM+Y02C8JFdfQJmYOlDa72tnydDOPNZ
 BXkQpwB+ohIwgrXOM/++MkY7C0g9tMGqt2q3e9DpaGpUzT0ZHm6mtEECj+7xayILGOgc
 0in8H06WOCzlka9DjyLuvloTMOm2ZAQfuUJ1P1lkUQ4d19LI/09vLAlpeBlCVj9XU0ml
 TTiAWm844KFe+XuNiaLnoffxhT8rLpI740TAd5zBGsH0d96ymy/ETzXo7j4XcjCMMDir
 sj+w==
X-Gm-Message-State: APjAAAUpEY2q2jfoRk57PLdHa2fYDbIDTmvp+NakC/ByEThmld5GHVUp
 kx6CBU7fyUJAvuLqZnhcCaIVZJ0eAfIwtBk1d8T4kCtq3li2AKPOinjtYV3FazJTdJ64Vbcwyjx
 eL2UjyRS4jly5Ruo=
X-Received: by 2002:a5d:4acb:: with SMTP id y11mr6035633wrs.106.1575386955609; 
 Tue, 03 Dec 2019 07:29:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqz/vvJxh8a4QR3uEQLBa4OwtJoTVRBtcinj837XMBskPpwh+4Pji2CUM5XqlJ+5llaRfTGXzA==
X-Received: by 2002:a5d:4acb:: with SMTP id y11mr6035607wrs.106.1575386955402; 
 Tue, 03 Dec 2019 07:29:15 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id c1sm3105575wmk.22.2019.12.03.07.29.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2019 07:29:14 -0800 (PST)
Subject: Re: [PATCH v6 9/9] hw/arm/xilinx_zynq: connect uart clocks to slcr
To: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20190904125531.27545-1-damien.hedde@greensocs.com>
 <20190904125531.27545-10-damien.hedde@greensocs.com>
 <CAFEAcA96yu6Uttsi6eZokjyxE8At18ADF+Q6c7Na2ArvdLME+Q@mail.gmail.com>
 <f373af20-0df4-384f-b1a3-10bf873c315e@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <db2836fa-e2f1-d1ab-88be-1b24f5a18302@redhat.com>
Date: Tue, 3 Dec 2019 16:29:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <f373af20-0df4-384f-b1a3-10bf873c315e@greensocs.com>
Content-Language: en-US
X-MC-Unique: giLozA4MPYyyib0vhu5rEg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/3/19 3:59 PM, Damien Hedde wrote:
> On 12/2/19 4:34 PM, Peter Maydell wrote:
>> On Wed, 4 Sep 2019 at 13:56, Damien Hedde <damien.hedde@greensocs.com> wrote:
>>>
>>> Add the connection between the slcr's output clocks and the uarts inputs.
>>>
>>> Also add the main board clock 'ps_clk', which is hard-coded to 33.33MHz
>>> (the default frequency). This clock is used to feed the slcr's input
>>> clock.
>>>
>>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>>
>> Nothing obviously wrong in the body of the patch, but as with
>> 7 and 8, review from a Xilinx person would be helpful.
>>
>> /* board base frequency: 33.333333 MHz */
>> #define PS_CLK_FREQUENCY (100 * 1000 * 1000 / 3)
>>
>> This is interesting, because it's not an integer... I'll come back
>> to this topic in a reply to the cover letter in a moment.
> 
> For this precise case, what I wanted is the resulting integer which I
> got from the device trees in linux (btw I should probably add this point
> in  comment). Just thought it was more readable this way than "33333333".

FWIW I'm auditing if it is possible to use the float type for 
frequencies (before to ask on the list if this makes sense), because in 
hw/core/ptimer we use timers with periods, and loose some precision 
using 1/freq again.

Also we have MiB/KiB in "qemu/units.h" and I'd like to introduce MHz/KHz.


