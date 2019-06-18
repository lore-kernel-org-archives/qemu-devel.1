Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA184C46477
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 12:09:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 931CB2133F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 12:09:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 931CB2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56438 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdCvC-0007Jm-Rf
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 08:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55395)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hdCuP-0006E6-6r
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 08:08:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hdCuN-0002AL-Up
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 08:08:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36983)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hdCuN-00029c-P5
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 08:08:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id f17so2985246wme.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 05:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4+N3SSk6PnSzYs/q3j1/lZtFbLDr9U6uRQqRH7reJyw=;
 b=aUEehNycTaV9XXGx978HHeikZMcw6jPURqCRb1AND2YC1PUatfwQl1azYdQUYsC04A
 f0PaiS9LxMo4rZ9zTldhL99+zYF6ioUuDYYC3ZHP+Ovx5oBo29JrYFj+IiYkU8lfxFfJ
 28EDEjTGOAJxFVRUMdLu9jmdvv4DH6wereKqtYDQoTrY5cK3oWrEeabeKrwtLCspULKA
 tOFVsz1ZsEA3YVm9G6bPs/SqGFKmWzGLreQO1azqPWNsRl5GF+A/zKWkjXygbo/b84Oc
 bHZ6n21tfSCELIbW6KJdZZ17jRfcBxbXXcZmAil/cYDVUhcD24eCmREHwCWg8Rcxj89e
 vbZQ==
X-Gm-Message-State: APjAAAWIE6wvrTBQzYzg/cz/lSDOcjiAjduZLuJbTyBnna2GyBptAD/B
 rrBfcgXSxYhXQkyorWhgHvvbs3DAprU=
X-Google-Smtp-Source: APXvYqwV4O1biVtNg43e/hCKlSlRNxFhHjoKWSs4YIH2zytG2Cc7vKAzlm3YY3aRWm8W362KF8lS5A==
X-Received: by 2002:a1c:6156:: with SMTP id v83mr3535410wmb.81.1560859694431; 
 Tue, 18 Jun 2019 05:08:14 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id t198sm2723335wmt.2.2019.06.18.05.08.13
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Jun 2019 05:08:13 -0700 (PDT)
To: Andrew Jones <drjones@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20190618083442.10407-1-drjones@redhat.com>
 <CAFEAcA9bwbev3efZ=LJPGgObBCbW-WX19fySMusLyMNC5ZExvA@mail.gmail.com>
 <20190618115558.uhygiqryxo4lbb5u@kamzik.brq.redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <307999bd-f1ee-9681-b770-e85587e1c5f1@redhat.com>
Date: Tue, 18 Jun 2019 14:08:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190618115558.uhygiqryxo4lbb5u@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH] hw/arm/boot: fix direct kernel boot setup
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/18/19 1:55 PM, Andrew Jones wrote:
> On Tue, Jun 18, 2019 at 12:02:37PM +0100, Peter Maydell wrote:
>> On Tue, 18 Jun 2019 at 09:34, Andrew Jones <drjones@redhat.com> wrote:
>>>
>>> We need to check ram_end, not ram_size.
>>>
>>> Fixes: 852dc64d665f ("hw/arm/boot: Diagnose layouts that put initrd or
>>> DTB off the end of RAM")
>>> Signed-off-by: Andrew Jones <drjones@redhat.com>
>>> ---
>>>  hw/arm/boot.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
>>> index b2f93f6beff6..8a280ab3ed49 100644
>>> --- a/hw/arm/boot.c
>>> +++ b/hw/arm/boot.c
>>> @@ -1109,7 +1109,7 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
>>>                               info->initrd_filename);
>>>                  exit(1);
>>>              }
>>> -            if (info->initrd_start + initrd_size > info->ram_size) {
>>> +            if (info->initrd_start + initrd_size > ram_end) {
>>>                  error_report("could not load initrd '%s': "
>>>                               "too big to fit into RAM after the kernel",
>>>                               info->initrd_filename);
>>> --
>>> 2.20.1
>>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>
>> I think I missed this because my test case doesn't have an
>> initrd -- direct kernel boot works fine if all you're
>> passing to QEMU is the kernel... I think we could clarify
>> the commit message a little:
> 
> I found it using kvm-unit-tests which uses a small initrd to
> pass environment variables to the guest. All the tests started
> to report FAIL.
> 
>>
>> hw/arm/boot: fix direct kernel boot with initrd
>>
>> Fix the condition used to check whether the initrd fits
>> into RAM; this meant we were spuriously refusing to do
>> a direct boot of a kernel in some cases if an initrd
>> was also passed on the command line.
> 
> Actually I think we need another fix for this error too. We
> weren't actually refusing do direct boot the kernel, but we
> should have been. We're missing the 'exit(1)' after the error
> message.
> 
>>
>> ?
>>
>> (if you agree I can just fix up the commit message when I apply it.)
> 
> I agree with the improved commit message if we also add the
> 'exit(1)', otherwise "refusing to boot" isn't the right thing
> to say.

Indeed. So for this patch + Peter comment + exit():

Fixes: 852dc64d665
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

