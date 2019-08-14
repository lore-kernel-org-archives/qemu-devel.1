Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16387C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 12:47:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE9EE2083B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 12:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE9EE2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxsgA-0001vJ-9l
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 08:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1hxseT-0000vu-6R
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:45:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hxseS-0005X9-7c
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:45:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46485)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hxseS-0005Wd-1a
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:45:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id z1so110969060wru.13
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 05:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3spmdXjoXaNLWcQVMlsSQgaqA5ymeCeQN+tvICLsCZE=;
 b=qRuTPkVgXCJlFXaySKfySC7YOFbI5c0J0fDYM3xETxjzrDBPacReict/ISG2tA505H
 aiB1sfn0dXyFLs1T8VBKOVQ4iU9S5uuWWVBC0Ny5eukU0MZD/nSZcWHCZ+GPtzSeRB9V
 CFtV6mXFG30HxtQV9I/xlDbOTZCb8JxEq0VpCv6kuOzxyP0rOxgMlwu+/4vbz3QAW+hS
 BHJTkEo15pTT0EBcRzqrEKomfbJ0Yd8INEnlSGfr46zWxZUCaFxp3IjLGzOrL7/SEkXs
 +ndtUUbCs3+BL3R/lexSMtOHobhbfapY6HxZpH0T61lqsruUXt/Pvm7EcDhiQDvjqtm2
 RmXg==
X-Gm-Message-State: APjAAAVhJywNjVcFtmMQ7LUlC2v0hfFrRGwDE9owPy57qvLPhhHHP2zb
 A11ry00zB8RUFUwuG9N7fipicg==
X-Google-Smtp-Source: APXvYqwvqmvGi/W2FZdFfdVHImgftr9lXW08aRjp9r5zvW3tNskwtUcFjHNcGEfoYMVJp7tse82I2A==
X-Received: by 2002:a5d:54ce:: with SMTP id x14mr27035053wrv.237.1565786715001; 
 Wed, 14 Aug 2019 05:45:15 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id f10sm16539190wrm.31.2019.08.14.05.45.13
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 14 Aug 2019 05:45:14 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190712133928.21394-1-philmd@redhat.com>
 <421f2fb2-6e8d-7579-029a-e8de726c6a5e@redhat.com>
 <56d102b4-3f55-7070-c012-56ad65138873@redhat.com>
 <CAFEAcA8axpVeXjWV+2cz8PL-gR_6GvU=i0BMt01pYhff_1LOwQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <4ed2e2b7-91b0-197f-7532-bf9daac075bf@redhat.com>
Date: Wed, 14 Aug 2019 14:45:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8axpVeXjWV+2cz8PL-gR_6GvU=i0BMt01pYhff_1LOwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH-for-4.1? 0/7] vl: Allow building with
 CONFIG_BLUETOOTH disabled
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
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Miroslav Rezanina <mrezanin@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/13/19 4:04 PM, Peter Maydell wrote:
> On Tue, 13 Aug 2019 at 15:01, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>> On 7/15/19 3:13 PM, Thomas Huth wrote:
>>> On 12/07/2019 15.39, Philippe Mathieu-Daudé wrote:
>>>> A series of obvious patches to build without the deprecated
>>>> bluetooth devices. Still worth for 4.1 or too late?
>>>> It is clearly not a bugfix.
>>>
>>> I wonder whether this series is worth the effort right now, or whether
>>> we should simply nuke the bluetooth code after 4.1 has been released?
>>
>> Well, perfect is the enemy of good :)
>>
>> This series is already done and is an improvement to what we have.
>>
>> Regarding nuking it, it depends on the Nokia N-series boards, they might
>> become useless without BT support.
> 
> Er, they're not useless at all without BT support. The BT
> hardware is a really tiny part that I doubt many users of
> the board models ever used. As long as we retain a "simulate
> doing nothing much" model of the BT device to show the guest
> I don't care whether the BT backend code disappears.

OK, I won't insist then.

