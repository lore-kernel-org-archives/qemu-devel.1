Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC9BC43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 08:17:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B16DF214D8
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 08:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRxiUadY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B16DF214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kH0im-0008Ed-Hs
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 04:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH0iE-0007pb-Il
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 04:16:46 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46991)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH0iC-0000h6-JI
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 04:16:46 -0400
Received: by mail-wr1-x442.google.com with SMTP id o5so13530007wrn.13
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2020 01:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rMZEHvZIRuVnZ3OVCcKxnjHuCwmEJv48j2+HBGKIhKo=;
 b=KRxiUadYbWVTMEDkJ4dLWBREsYDxo8EumMRZzYoEdvxZmJqvpld6AY42KQqUQt54S3
 sckcbuSkpBIbfdkIuU6LdwRXFtbyMRqGRhryYqedwsDLcB+/tGHgYzcL9+6afsg99JJo
 aCEDg2OBZD9TR9CiepE2haRuDQx+LGksGUauqTXycSQoUa+UhYq2kA24Ht+xrBifKxnH
 EFPJXWYDZKuA6vpAzVftzSUGziEGzm2OEDVWMWpoXO9To2XOyyNs8iL68T26WG2qFV1v
 KH21JysmENdkeokjY9MojSlXwzMu/x6ukZg62CK3QyloX17KZghsSs7YlUiLDRlwC91q
 TQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rMZEHvZIRuVnZ3OVCcKxnjHuCwmEJv48j2+HBGKIhKo=;
 b=GF6ZSjDUAo102lgxDOwAHG5kQzz0Btm6vQNldM/vua8GIM6+Zh13EnBABonUWkXXdx
 YqPLEftRlTIZELIgBoGXoxmjvyVZYb4R0eJAWPItZEDBQXn3/jlUaEIY0GcUpX/lCKAC
 TJ8P2FtPk/R60cKrQtcjEWPlCS2xCqwsyhyaoYilSbP6XZlIFGOKPpoeLhLtasgtc4AW
 j01IeWknJS8q2XJ17YoQ3q038NCLFp88y26HNk0aFEk33BH0xKtfvLsDjsLwaLTX1fX8
 rp9Zl+aQTROaDzMQhGtEWREwq1cfrQ6auHsnBgtu9MtR7TIYqqKvE4GVbkcMw5HcKco3
 2QwQ==
X-Gm-Message-State: AOAM531fShFLi0lsW2fLEfT6VpiymgwdXo+1q6MuTcsICBf50SGejk2y
 HKi0IjGT+V+COAeZ6coKZlU=
X-Google-Smtp-Source: ABdhPJzWu+F75a/adsaMbmC+y/vJsJBfWaFH6xDH5wnI+AEVuUPU28whVu7u/Lzk+YaQhePhc7Xb5Q==
X-Received: by 2002:adf:9f10:: with SMTP id l16mr6182301wrf.77.1599898602927; 
 Sat, 12 Sep 2020 01:16:42 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id p9sm8427985wma.42.2020.09.12.01.16.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Sep 2020 01:16:41 -0700 (PDT)
Subject: Re: Moving to C11? (was Re: Redefinition of typedefs (C11 feature))
To: Warner Losh <imp@bsdimp.com>, Eduardo Habkost <ehabkost@redhat.com>
References: <20200911184919.GV1618070@habkost.net>
 <CAFEAcA-dnKVyUQ3_ZifdDvrpCbKB1zciuu224BbB1WRV0npxzw@mail.gmail.com>
 <20200911200649.GW1618070@habkost.net>
 <CANCZdfq0CXqrLJgXQPi+eiDx+qmkNng7agQ40CyE9pH=z9g41g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <aaf6ea38-7b96-9295-12e8-8ba77b605fd1@amsat.org>
Date: Sat, 12 Sep 2020 10:16:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CANCZdfq0CXqrLJgXQPi+eiDx+qmkNng7agQ40CyE9pH=z9g41g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-2.469,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/11/20 10:10 PM, Warner Losh wrote:
> 
> 
> On Fri, Sep 11, 2020 at 2:07 PM Eduardo Habkost <ehabkost@redhat.com
> <mailto:ehabkost@redhat.com>> wrote:
> 
>     On Fri, Sep 11, 2020 at 08:06:10PM +0100, Peter Maydell wrote:
>     > On Fri, 11 Sep 2020 at 19:49, Eduardo Habkost <ehabkost@redhat.com
>     <mailto:ehabkost@redhat.com>> wrote:
>     > >
>     > > I'm wondering: do our supported build host platforms all include
>     > > compilers that are new enough to let us redefine typedefs?
>     > >
>     > > The ability to redefine typedefs is a C11 feature which would be
>     > > very useful for simplifying our QOM boilerplate code.  The
>     > > feature is supported by GCC since 2011 (v4.6.0)[1], and by clang
>     > > since 2012 (v3.1)[2].
>     >
>     > In configure we mandate either GCC v4.8 or better, or
>     > clang v3.4 or better, or XCode Clang v5.1 or better
>     > (Apple uses a different version numbering setup to upstream).
>     > So you should probably double-check that that xcode clang has
>     > what you want, but it looks like we're good to go otherwise.
> 
>     Can anybody confirm if the following is accurate?
> 
>     https://gist.github.com/yamaya/2924292#file-xcode-clang-vers-L67
>     # Xcode 5.1 (5B130a)
>     Apple LLVM version 5.1 (clang-503.0.38) (based on LLVM 3.4svn)
>     Target: x86_64-apple-darwin13.1.0
>     Thread model: posix
> 
>     If we know we have GCC 4.8+ or clang 3.4+, can we move to C11 and
>     start using -std=gnu11?
> 
> 
> All supported branches of FreeBSD tier 1 platforms would be fine since
> they all use clang. Most of the tier 2 ones do too, but the ports/pkg
> system we have will install a newer compiler if need be (the ones that
> don't are still stuck at gcc 4.2.1 for GPLv3 reasons).

See the quoted message from Peter: "In configure we mandate either
GCC v4.8 or better"... You shouldn't be able to build QEMU in ports/pkg.

Regards,

Phil.

