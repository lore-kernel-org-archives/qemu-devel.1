Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81598C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 17:41:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0F2822254
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 17:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u8VHIjqo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F2822254
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWNXs-00038q-Pg
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 13:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWNWT-0002X3-H1
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 13:40:09 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42832)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWNWR-0001JT-Ru
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 13:40:09 -0400
Received: by mail-wr1-x441.google.com with SMTP id j7so6517429wrt.9
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2020 10:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ooqbihq6iHUmi3zjx1nDHhAOsxRSOmn+FbPGa60W5aA=;
 b=u8VHIjqoe+IwvN7ir5g3wnvwCwVczIGRN5ncqmWidezvrdEQgW72VIuxmnX1KPn8yb
 87GdNY722s7hvKhbUpErsr5dC4NgF5wKg2NOBD41Q1waPctizUHuXeg3A+KMjx7fvyRn
 m72HeizXWRYRMxegYZoaiJur0YCUetFa7jckgaLbV4tgKHtC6CwrqMslJuNUWVWQyucR
 xb531PGCUwQg14aKRvttMq4735aXd/2xkEOxnWjAc0UyOO1Cl8WuddtVmbOUwegcAIRZ
 8nCQNGAc+BD3Z6Vcrf3nTRDkvqw0L8kJVrtX6Ctxj/7XzqxGnoDMTZKNqYTWZpas2AYO
 mKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ooqbihq6iHUmi3zjx1nDHhAOsxRSOmn+FbPGa60W5aA=;
 b=Cbt6jD0xVqTeGZa2t5dnZSIPXGqOU8P/85OsO9TbpjNsaITomLAPtoO89XzzhzHr8o
 7c5zVPIYyTmZlCKSOe6Fh4ngkmiiP5C8rce94AwHj6WBioUhb+MV+aUMDQtta+5zvHPO
 zjBgaRPdetRwgXtFxfk9MZjMbsj4wSoOedeH0gQCUy9cDwldBZ1uSmb5R0km7WhMLdll
 os+yrM4BbFWBQRu/h488dGOiOUhLaiykW6lokv2VimLHr1cyN0m2yArKSB0wIJF1DaKJ
 xhkqA61Gk/BwNvPq7jGVVMJw80n63tVrLgE8nJe5X/6jp8q4Hh4yPjRrIkp4cXcK2c1f
 FiiA==
X-Gm-Message-State: AOAM533svauHmph+cQdhS7u1Zr6m2iiKtnJslz4LD9nNYFOFMgRRX1Gm
 fzuLo7T6h88itD+b5T2bJd0=
X-Google-Smtp-Source: ABdhPJx+X6MgiVP3O+YTL5AZRSX/qwtRDiAGT+6LifEBmqwPmgPfLDM3iQ3x8c4n4JwwqLarHOoqTA==
X-Received: by 2002:adf:97da:: with SMTP id t26mr8599729wrb.321.1603561204788; 
 Sat, 24 Oct 2020 10:40:04 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id q10sm11924670wrp.83.2020.10.24.10.40.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2020 10:40:04 -0700 (PDT)
Subject: Re: [PATCH 4/6] tests/acceptance: Introduce tesseract_ocr() helper
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20201021105035.2477784-1-f4bug@amsat.org>
 <20201021105035.2477784-5-f4bug@amsat.org>
 <0b31c367-f054-ce03-c1f8-d6fb6cbffc28@redhat.com>
 <3cd8bd76-2115-1317-f852-fb1ffdde544a@redhat.com>
 <87b084e3-8e6e-359d-784d-2f1353522f98@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <82f65042-abd3-36e0-b384-99dd87298163@amsat.org>
Date: Sat, 24 Oct 2020 19:40:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <87b084e3-8e6e-359d-784d-2f1353522f98@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.107,
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
Cc: Huacai Chen <zltjiangshi@gmail.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Cleber Rosa <crosa@redhat.com>,
 Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/24/20 9:37 AM, Philippe Mathieu-Daudé wrote:
> On 10/24/20 8:40 AM, Thomas Huth wrote:
>> On 24/10/2020 08.35, Thomas Huth wrote:
>>> On 21/10/2020 12.50, Philippe Mathieu-Daudé wrote:
>>>> We are going to reuse the tesseract OCR code.
>>>> Create a new tesseract_ocr() helper and use it.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>> ---
>>>>   tests/acceptance/machine_m68k_nextcube.py | 21 +++++----------------
>>>>   tests/acceptance/tesseract_utils.py       | 18 ++++++++++++++++++
>>>>   2 files changed, 23 insertions(+), 16 deletions(-)
...

>>>
>>> Would it make sense to completely hide the tesseract version handling in
>>> this new tesseract_utils.py file now, so that the tests themselves do 
>>> not
>>> have to worry about this anymore

The problem is the recognized strings differ between versions,
see in tests/acceptance/machine_m68k_nextcube.py:

         lines = tesseract_ocr(screenshot_path, tesseract_version=3)
         text = '\n'.join(lines)
         self.assertIn('Backplane', text)
         self.assertIn('Ethernet address', text)

and:

         lines = tesseract_ocr(screenshot_path, tesseract_version=4)
         text = '\n'.join(lines)
         self.assertIn('Testing the FPU, SCC', text)
         self.assertIn('System test failed. Error code', text)
         self.assertIn('Boot command', text)
         self.assertIn('Next>', text)

> 
> Yes, good idea.
> 
>> (i.e. would it be possible to merge
>>> test_bootrom_framebuffer_ocr_with_tesseract_v3 and
>>> test_bootrom_framebuffer_ocr_with_tesseract_v4 into one single test 
>>> that way?)
>>
>> If I've got that right, there is also now a proper release 4 of 
>> Tesseract,
>> so maybe we can simply scratch the testing with version 3 now?
> 
> Good to know, I'll have a look. Thanks!
> 
>>
>>   Thomas
>>
> 


