Return-Path: <SRS0=AG+E=EA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAFCC388F7
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 12:24:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8856223AE
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 12:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yuks+cAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8856223AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWf43-0005b2-Mf
	for qemu-devel@archiver.kernel.org; Sun, 25 Oct 2020 08:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWf2m-00055f-OK
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 08:22:41 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35853)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWf2k-0005SM-Rt
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 08:22:40 -0400
Received: by mail-wr1-x444.google.com with SMTP id x7so9417442wrl.3
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2020 05:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xbDFpkldMCQMjOuYmPHkQCEwhVMi1pfU+Fnv+neJ5qU=;
 b=Yuks+cAYToOkcwlrfFPj2E9mo3QbP9wCNEfsePcDnHG7im7ZByMK56279x/0kwrsBZ
 v6GM0/Bx7/OKoCJsFsms+5FVR/LgmNbO8l+ZfT2A+banwOC5dAIwCPtZhd09uFuOizb/
 CU1ncxBhLLbmp23s/a4bHShHR+dEvCoO9VdTNez1Zc8mKnyiGhhOzb8B+IiXQvZ9bMWg
 PcAMUXoU3p/9pVspmhKvrc9FPW6n70JnXmIUk6q4tBBRad79YO0qXXJ1hE0FVN6MWOgw
 rtPauQ8jeqUxTEtIquehkENGCW/WcpZodCuY47JJoakDKyDFQuRLLMq2jDe/LvR7EYSE
 vHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xbDFpkldMCQMjOuYmPHkQCEwhVMi1pfU+Fnv+neJ5qU=;
 b=kUGF5rusPI0JjzEfq90lvy7XuUJ+nwFEGrm878MmEJHFRyyBVfwLCMaGCLj39/aPjP
 8qiyxJJe6azgx8x/qKgv4mHRTZhX0lmh69THHMeLCmASBb+gcopXvIF56wDVb4RAsnv3
 35h0aC3VvEwA1MMwBA3HXSRfxj2IBMXYdkrkenNkwuDaACgimMYR19X8OvNGVhmfd5Gr
 DPCWLSzUULTg81oZdXhrFFXk1RVcqKgmRJtooj3AKmTtBNZKQc/0cBJIz6XcIhIOussi
 P0zwQKYjy7N2umkK9D+bAgYf/4WWAt2GrEnQ494uKZS3NBsFxCi1ERvuMUeNa9kj39VZ
 hpaA==
X-Gm-Message-State: AOAM533lunW7yb7G39xLRQAVu/TNhsvTFhwutvtpcAxiivDaztdwCVqi
 /1UR9Ku0M+LDMVss1uNzoxQ=
X-Google-Smtp-Source: ABdhPJwW3YhtF2aqNAzUckEOffQMc+YXDPNKFMwd4RPjuSJyHjxKL3H1ZNCjmlhi11z2D/95INmjPQ==
X-Received: by 2002:a5d:5748:: with SMTP id q8mr12559095wrw.299.1603628556821; 
 Sun, 25 Oct 2020 05:22:36 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id q8sm16977560wro.32.2020.10.25.05.22.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Oct 2020 05:22:35 -0700 (PDT)
Subject: Re: [PATCH 0/6] tests/acceptance: Test the Fuloong 2E machine
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20201021105035.2477784-1-f4bug@amsat.org>
 <54a947e4-929c-aaa4-52b0-339827a010b8@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d2851fba-040c-9f39-ccf7-2d22b862ec2b@amsat.org>
Date: Sun, 25 Oct 2020 13:22:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <54a947e4-929c-aaa4-52b0-339827a010b8@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
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
Cc: Huacai Chen <zltjiangshi@gmail.com>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Cleber Rosa <crosa@redhat.com>,
 Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/25/20 12:18 PM, Mark Cave-Ayland wrote:
> On 21/10/2020 11:50, Philippe Mathieu-Daudé wrote:
> 
>> This series add tests for the MIPS Fuloong 2E machine.
>>
>> I have been using these tests for over 1 year now.
>> After recent discussions with Huacai and Mark regarding
>> how to contribute tests for machines using private blob,
>> I think it is time to publish this series, to see how
>> the final part will be discussed, as it tests a blob
>> which Lemote company doesn't publish the sources. The
>> binary is know to work and has been used for various
>> years on real hardware. Its MD5 is also know (I am not
>> using SHA-1 because it has been published with MD5).
>>
>> The idea is to be able to share tests without infringing
>> licenses issues.
>>
>> Please comment :)
>>
>> Phil.
>>
>> Philippe Mathieu-Daudé (6):
>>    tests/acceptance: Remove unused import
>>    tests/acceptance: Use .ppm extention for Portable PixMap files
>>    tests/acceptance: Extract tesseract_available() helper in new
>>      namespace
>>    tests/acceptance: Introduce tesseract_ocr() helper
>>    tests/acceptance: Test Linux on the Fuloong 2E machine
>>    tests/acceptance: Test PMON on the Fuloong 2E machine
>>
>>   MAINTAINERS                                |   1 +
>>   tests/acceptance/machine_m68k_nextcube.py  |  51 ++---------
>>   tests/acceptance/machine_mips_fuloong2e.py | 101 +++++++++++++++++++++
>>   tests/acceptance/tesseract_utils.py        |  46 ++++++++++
>>   4 files changed, 158 insertions(+), 41 deletions(-)
>>   create mode 100644 tests/acceptance/machine_mips_fuloong2e.py
>>   create mode 100644 tests/acceptance/tesseract_utils.py
> 
> In general this looks good: certainly I don't see any reason why the 
> tesseract_ocr helper changes shouldn't be merged, since I expect that 
> this is something that will be used more in future.
> 
> Looking at the fuloong test it seems that it stops fairly early in the 
> kernel boot: one of the problems that Zoltan's VIA southbridge patches 
> were trying to solve earlier in the year was because of problems with 
> PCI IRQ routing, so it would be nice to include a small OS image that 
> can be used to boot to userspace to ensure that such problems can be 
> detected in future.

The Linux tests (ab)use of the rescue image prepared for the Yeeloong
machine which we don't model (Loongson 2F CPU, 1GB of DRAM). The kernel
triggers DATA ABORT while accessing >256MB because we do not model
mapping more than 256MB :/ (The Fuloong comes with 512MB extensible to 
1GB). I have a branch adding that but had the idea nobody was interested
in the Fuloong 2E so I didn't insist (I have more interest in embedded
32-bit CPUs). I might try to post it after the release, as it makes this
test complete.

Thanks for giving it a try!

Phil.

