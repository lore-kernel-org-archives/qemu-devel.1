Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA20C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:04:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C54F92088E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:04:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C54F92088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrNEi-0005s7-2f
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 11:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jrNCk-0002qz-Rb
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 11:02:18 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:38253)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jrNCi-0007j1-QB
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 11:02:18 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MQeI4-1jTgBW2yta-00NiVq; Fri, 03 Jul 2020 17:02:04 +0200
Subject: Re: [PULL v2 00/12] Linux user for 5.1 patches
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200702152710.84602-1-laurent@vivier.eu>
 <CAFEAcA_CDZqch-dB2LhTrwQ1pGi_GGn=6RE2CWM8WvLducZigw@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8fc1ffef-e77b-40f8-5a62-fcb964a18796@vivier.eu>
Date: Fri, 3 Jul 2020 17:02:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_CDZqch-dB2LhTrwQ1pGi_GGn=6RE2CWM8WvLducZigw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2UhItBtfNyQ/KUN3gOFNagsBf9rZX2Z5i4eIKz2gdvYBzA7u5VT
 wCP1HSKcFNEd/ff3TXyewUkmaNN4aooCqrRyjtkrdXEZBcS9Q7QaZHvmzX4FIXu7MtZgFiS
 i9yAnLjQb01Mn1mv7SpQLebzBidGw3+stVOruptMv8k5h6PVPwvtExyE1qCLpmxMQnP6RGF
 LmrjDdIg9nUDhLQ4GCh3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FaR9rBRyAj0=:bDF1NWxuVxo0WR6h1vIAnD
 OmNBUJuFOd/PLhg45Cb8cYbg+MxeXNhSSHR8XpTBWbHuVb4u8D6/4FOtTei8zYFvez4qrjrt/
 0t0vd/5fHXRK+Bz5r62gzyDRQX1sClxw4B7fqDFNVek+q/iGWfUuDmfC2Q37/3GDQDWbRpJfz
 Y6OdEmT933Hi6bvbBfn59w2Ffs0pFntq16sMvU1Y6+TMWx50QhGLaxoGpG/S8zR1JbELm5fEh
 CHP36F0dmSnPzEncBmKLIZc/hzDYQfP1NyTJs0+hXKeWrueow7xWOh3VG3hrwpK7THN5nNjjv
 jDSakYYbVv1owss9TDp1x5O52rLQIWRv/OWFyetbGfm1b9oOokjGFVolGwbhD7InE5e+P47Hl
 ts3nYoJM/snDx3YZQsJuODj3qUawhm+wxB8a/3/amHLO1BIGT9hPES9dXpoqMLv8E62/Bcs5Q
 oU/WYWBG3P9ItR4GFTwg40zNn36utlCTqPigzyipBww4PWd72PN9dN1oLRKjOcIwMIL5maAXm
 zOqYdNCrc7SvOFkY10jYnYaThSJ4Szt499HimZ7F0bDDNh8w/S7HgEENP9OEj6F3/F1qjLhZB
 JdDF8xHjfH005j45JGx740RbKE3B6eV/aH7dDNWyluOxwffdcXytz6VEtFT+j6cxFF2DLUBtx
 T+sk74PtiLn+nDq6buAGz8X+VsCShWpVPU5CF/Hfehv4gZuk4zgageJhKXfVBtkdADZIhB/8S
 2Y4R4XSH9hXM3DIIkBk9ZsYwqyygpAEWLP3vMYodC/+eaCOgzKBRzCHnjk4OzyT+nDbYjkroM
 Tc/3Tqxsf/KbZ5/rQZN0EaeC2/XkULNVSgM/AIH/wuiGsPi1vw=
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 11:02:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 03/07/2020 à 16:23, Peter Maydell a écrit :
> On Thu, 2 Jul 2020 at 16:31, Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> The following changes since commit e7651153a8801dad6805d450ea8bef9b46c1adf5:
>>
>>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-gsoc-queue-jun-27-2020' into staging (2020-06-27 22:57:36 +0100)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/vivier/qemu.git tags/linux-user-for-5.1-pull-request
>>
>> for you to fetch changes up to 89ddeec7f060a9f403aead414bb883a52f2b5024:
>>
>>   MAINTAINERS: update linux-user maintainer (2020-07-02 16:55:16 +0200)
>>
>> ----------------------------------------------------------------
>> linux-user pull request 2020-07-02
>>
>> Update linux-user maintainer
>> Improve strace output for some syscalls
>> Display contents of ioctl() parameters
>> Fix sparc64 flushw operation
>>
> 
> Hi; I'm afraid this failed to build on 32-bit arm:
> 
> /home/peter.maydell/qemu/thunk.c: In function 'thunk_print':
> /home/peter.maydell/qemu/thunk.c:304:51: error: expected expression
> before ')' token
>          qemu_log("%" PRIu32, tswap32(*(uint32_t *))arg);
>                                                    ^
> /home/peter.maydell/qemu/rules.mak:69: recipe for target 'thunk.o' failed
> 
> Looks like a misplaced close-bracket in a section of code
> that's inside #if HOST_LONG_BITS == 32 && TARGET_ABI_BITS == 32.

Thank you, I will fix that.

Laurent

