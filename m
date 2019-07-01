Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E6CC5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 20:57:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05DF721721
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 20:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05DF721721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhyeK-0004Xo-VP
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 11:55:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48360)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hhyUJ-0006KQ-3f
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:45:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hhyUH-0004HJ-M9
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:45:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40931)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hhyUH-0004Fr-EM
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:45:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id p11so14402586wre.7
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 08:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UN3o+6UDPS3ZrABJXsjH4Uy8Wz/9XvwPA/jAWAdkpjE=;
 b=aZ2JeTfRCb+0fpAFY8gZ6VS+69gmz8I8nLEBAx+N2Z41fseFg0Id7KSotBxHK+3Sx0
 h/UGnU+yXYRCvmFYShJZGLVu+dnMUGrquTNbhhX3PbCbwzXnrXJeJUHm2hGJVyM9imac
 jOynT2jZlVF+2Zg4o8jl7D51Q7Nl3LmLjwYR/lEPufFyAZEt+2wUj8kpUIVkcGB9zldF
 HMf4OA0tGUR4nvCHIOHkcuPaA0gWom8HyEUwcMKbgJpjogSuIOlnWAZ4Srv96dbZmi9s
 XtNug1bJqtb7X+k6RLPCvwgJ/qEy12YVtHdNGhB1dFu9uTqkkiETneAeXMVTIKE5rr0P
 1AmQ==
X-Gm-Message-State: APjAAAUODfKrfteWaUGkBDpTZusnk1yu6Sw8tu5blXj0wA60WXcmMV4r
 zyvXnIz3CNXmg7N/Zgh6H2byJQ==
X-Google-Smtp-Source: APXvYqxTrhbST95SxLtqvUE5CalXJXJC1wCH03YLGHpkpBudkxD24uJaHSijK/ZLcML4yK8R7R/IPQ==
X-Received: by 2002:adf:dd8c:: with SMTP id x12mr19718536wrl.212.1561995900343; 
 Mon, 01 Jul 2019 08:45:00 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id h6sm10819669wre.82.2019.07.01.08.44.58
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jul 2019 08:44:59 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190701132516.26392-1-philmd@redhat.com>
 <CAFEAcA93x6zkbHe1hdg0c8cbo9ErSByP+g6UvwZefxn-6346zg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6222de8e-5b4e-db05-a453-ae4920c2002a@redhat.com>
Date: Mon, 1 Jul 2019 17:44:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA93x6zkbHe1hdg0c8cbo9ErSByP+g6UvwZefxn-6346zg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v3 00/27] Support disabling TCG on ARM
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
Cc: Yang Zhong <yang.zhong@intel.com>, Andrew Jones <drjones@redhat.com>,
 Samuel Ortiz <sameo@linux.intel.com>, Rob Bradford <robert.bradford@intel.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/19 5:41 PM, Peter Maydell wrote:
> On Mon, 1 Jul 2019 at 14:25, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> Paolo motived me to salvage this (other!) previous series fromi
>> Samuel Ortiz (NEMU project).
>>
>> v1 cover from Samuel [1]:
>>
>>   This patchset allows for building and running ARM targets with TCG
>>   disabled. It splits the target/arm/helper.c file into logical TCG and
>>   non TCG dependent files so that one can build and run QEMU binaries with
>>   or without TCG enabled.
>>
>>   The rationale behind this work comes from the NEMU project where we're
>>   trying to only support x86 and ARM 64-bit architectures, without
>>   including the TCG code base. We can only do so if we can build and run
>>   ARM binaries with TCG disabled.
> 
> I have applied to target-arm.next:
>  1-12
>  14-17
>  19-21
> 
> I had comments about 13 and 18. 22 has a conflict when I try to apply it:
> I think this is just accidental because the functions it's moving are
> next to changes in patch 13 so there's a minor textual conflict, so it
> would be fine with a fixed-up version of patch 13.
> 23-27 are still RFC status so I think best left for the next release.

Thanks a LOT!

I was not expecting this to be merged for this release,
this is very appreciated :)

Regards,

Phil.

