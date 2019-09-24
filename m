Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6F2C432C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 09:55:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EB6020872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 09:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EB6020872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iChXy-0006O4-Ce
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 05:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57816)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iChV4-0003YK-Oi
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 05:52:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iChV3-0004WJ-2O
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 05:52:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58942)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iChV2-0004W2-Q7
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 05:52:49 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B889A59465
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 09:52:47 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id c1so364796wrb.12
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 02:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rhS2indaqmMBEEGNGdFHAyRHQsF9cA4TERCeJYzDnac=;
 b=SM6SMctxoGSJMv3emtw91ulEq3mVUoJOMjDWnou3hMYWIZWrZI84ZoqXECqhnRaVSl
 sjOHfkVerf/sw9S97wt3wvWTjMfgHcaVvPGugb/THccfeCKrW3FxJHID5ozCGtRewSD5
 CpqzsKIwwiNCet9mCb4da1p9vFJFn8POF7yI08IcD8Eu4jxhTLpRuLJsX4JjSjtuMl3t
 +UpMFRXUQnfUc3D3VM2MsrtHxsCPZMH8IhXwxmPBEeZo85JNqnJeIvQ3IFS1dP22rM/s
 xx1HRHD43JO1z1nEESXgT9uepg351YrP3toT/YbzMW0X28/tP6gUfKvGFiN9wcE08ode
 r5RQ==
X-Gm-Message-State: APjAAAWqKyICxeD3DHmYZhQ0w4KeDJAdC7XX6BxiIGDigSCh0Eu0bbaO
 o5OcHd62blUgyG6kxz/xgWVuyE4QmGhCM5D8QzhWkJSExqQ1zI6h4hjvAjnN6P1szqhOwSvB4/z
 gc+8/75qdF4m97+I=
X-Received: by 2002:a1c:96cd:: with SMTP id y196mr1900179wmd.67.1569318766527; 
 Tue, 24 Sep 2019 02:52:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwW5paPcSwe/XfxIaH6DDh5Writ3aSpqDyj380ZTd4QFWpB6OnZQtBo2z2/A0DTwye8cNn01Q==
X-Received: by 2002:a1c:96cd:: with SMTP id y196mr1900171wmd.67.1569318766376; 
 Tue, 24 Sep 2019 02:52:46 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id g138sm1703141wmg.29.2019.09.24.02.52.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Sep 2019 02:52:45 -0700 (PDT)
Subject: Re: [PATCH 2/4] target/arm: Move cortex-m related functions to new
 file v7m.c
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20190921150420.30743-1-thuth@redhat.com>
 <20190921150420.30743-3-thuth@redhat.com>
 <CAFEAcA9KbQF071ZWXm4Y2GcoxfksKLTH8OvcUJqkfY79_oNnMA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <7ddc5f77-98d4-3969-c405-bf09b9c0a803@redhat.com>
Date: Tue, 24 Sep 2019 11:52:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9KbQF071ZWXm4Y2GcoxfksKLTH8OvcUJqkfY79_oNnMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/19 4:34 PM, Peter Maydell wrote:
> On Sat, 21 Sep 2019 at 16:04, Thomas Huth <thuth@redhat.com> wrote:
>>
>> We are going to make CONFIG_ARM_V7M optional, so the related cortex-m
>> CPUs should only be created if the switch is enabled. This can best
>> be done if the code resides in a separate file, thus move the related
>> functions to a new file v7m.c which only gets compiled if CONFIG_ARM_V7M
>> is enabled.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  target/arm/Makefile.objs |   1 +
>>  target/arm/cpu.c         | 146 -----------------------------
>>  target/arm/v7m.c         | 193 +++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 194 insertions(+), 146 deletions(-)
>>  create mode 100644 target/arm/v7m.c
> 
> Calling the new file something with 'cpu' in it would help
> to convey that it does the same kinds of things as
> cpu.c and cpu64.c. Maybe cpu-m.c or cpu-v7m.c ?

I agree to your other comment:

  From a CONFIG switch point of view I don't think it's
  worth being able to #ifdef out the various flavours of
  M-profile individually.

So I'm in favor of using cpu-m.c.

