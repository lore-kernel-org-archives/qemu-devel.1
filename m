Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C8FC47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:56:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE6A7206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmezD+k/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE6A7206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVvFI-0007MK-Ul
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 06:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVvEW-0006tf-2c
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:55:28 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40036)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVvEV-0007gT-DH
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:55:27 -0400
Received: by mail-wr1-x442.google.com with SMTP id e16so2181553wra.7
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 03:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rWMiUvo8WeQfd1tzIff+04v99VH2uf5Z7aHqw5sV7Y4=;
 b=WmezD+k/UGqd2zTFGiE003ygZ2ypZDksKRSvEsTgKxrx1I8KRJEnfyuYsND/tWCQ2c
 dW4atOzeCFLTBvwQmFFMvyTsIuJaeJTbXZWP2+hrEVaLG0D89vvJ+qVOGxN7IH+8qqzM
 ywzaJBjRz434yDy86CEx31I3bMGGlrncOTl5QRyYZE4MfcST9Hc2k39E3PuR2Am01I2a
 41V1Wg8JpKSTXYNkzyov/zS9ljetDTZ4MjbfEaF/2QpXUITXnPAYhitk0iL7JZo+v3qA
 TyPmFuVOqCVj8bMYwSpabMPsmbjerrsb0/lWqA/0AzMGCbH3qyaVa53Kfy9ADET0MXjV
 /c9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rWMiUvo8WeQfd1tzIff+04v99VH2uf5Z7aHqw5sV7Y4=;
 b=Chykh5qIBD9ot0B5jGmQPcC6ULM7QbUDaW0WUVqFiV4zuVq3O6LDvgkEBgvgcmUyxI
 QHaV3mgyqB+qieLXjGxfHFYjJMCsS0xA+05I4u32znPEAq6xLfM/DijKvccaEyYCC7La
 CGkeH6GfyGGgVrnrlz50V0u6iJUBMWxwYnf77Hj3FQHk10MXQlCr0igUbDBiHep/Gnyz
 ni8T0gXonNOJRwho+My/ZNdmnvgfLwFqUeSlkZvHT5KzcW86RaE69ahLkCOctSUq9J42
 sc3cAXpljcpjAIyRiJce5qroUQf9KR3eVutBP3nrdkYCgC6T+NsYdZVMmmQYSSpjSJ0S
 dULw==
X-Gm-Message-State: AGi0PuZNwfbJnJJF7GPQ0E9SVmoHqFX71lv1RBYeP5b9mgFQ5FHBRnZA
 MiIgy6itBbxJrqMHfF5saKs=
X-Google-Smtp-Source: APiQypKb04mvmnDxZ0f1pijVT+MlqfucdGJ0eXg7OFI/sd1tIONVb18BVARtVBp4M/hlLOK1kkfdhQ==
X-Received: by 2002:adf:e8c4:: with SMTP id k4mr2913507wrn.209.1588676126121; 
 Tue, 05 May 2020 03:55:26 -0700 (PDT)
Received: from [192.168.1.38] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id k17sm3133560wmi.10.2020.05.05.03.55.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2020 03:55:25 -0700 (PDT)
Subject: Re: [PATCH] hw/audio/gus: Use AUDIO_HOST_ENDIANNESS definition from
 'audio/audio.h'
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200505100750.27332-1-f4bug@amsat.org>
 <bc9f6295-9c1a-9617-ecd9-f38ea0ad5d79@redhat.com>
 <79194c5a-ea10-3921-aeb4-1e0432b38c3d@amsat.org>
 <e4de9abb-114b-239e-ec33-ef1f4a5a7f85@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c55f934e-fc41-073a-fbfb-806f1b5b4527@amsat.org>
Date: Tue, 5 May 2020 12:55:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <e4de9abb-114b-239e-ec33-ef1f4a5a7f85@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/5/20 12:49 PM, Paolo Bonzini wrote:
> On 05/05/20 12:45, Philippe Mathieu-Daudé wrote:
>> On 5/5/20 12:10 PM, Paolo Bonzini wrote:
>>> On 05/05/20 12:07, Philippe Mathieu-Daudé wrote:
>>>> Use the generic AUDIO_HOST_ENDIANNESS definition instead
>>>> of a custom one.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>> ---
>>>> Who/what machine is using this device anyway?
>>>
>>> PC, like all old ISA audio cards.
>>
>> I imagined, but any particular project in mind? I'm wondering if we
>> should add a test for it, and what kind of testing.
> 
> Old games and demos use it.  Most demos don't work that well on QEMU though.

Good. Cc'ing Max in case he knows a such demo we can use for testing.

Thanks!

> 
> Paolo
> 

