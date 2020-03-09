Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEACC18E5B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 13:31:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98BD120727
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 13:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98BD120727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBIUl-00089j-KU
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 09:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBISh-0006cQ-7H
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 09:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBISf-0002ZB-Sy
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 09:28:51 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:53719)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jBISf-0002Yl-Jf
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 09:28:49 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MK3a4-1iuBXq0EbW-00LWUW; Mon, 09 Mar 2020 14:28:16 +0100
Subject: Re: [PATCH 1/2] cpu: Do not reset a vCPU before it is created
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200309121103.20234-1-philmd@redhat.com>
 <20200309121103.20234-2-philmd@redhat.com>
 <CAFEAcA_OHcfsYueYRpXjihgwEDericqkzGqB1EBqaSULAC1YDw@mail.gmail.com>
 <8e996314-695f-a742-b318-9df5a4f2be1b@vivier.eu>
 <CAFEAcA-sb5hFBuY1U=KrbsZdhNwQq3H__XBDK1nxmYB4hSGz0w@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5859e196-4ccd-e52e-4cfb-448ee1967643@vivier.eu>
Date: Mon, 9 Mar 2020 14:28:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-sb5hFBuY1U=KrbsZdhNwQq3H__XBDK1nxmYB4hSGz0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jQP+oyI0IoWJE2NokxmWsxrmkEfaqwb3BjNRJqoS2LsUNr1ioSY
 Es6TvvKFxS+3JODbifbbl8QECQGTnj9t7dmJ8kjpm5mspxQ1a2Hr9E2dRqWF2QVyrKkG3gL
 sAD8oRrKfkIdjmBBxKhhI5oID3LJYq2YVu/gFeybSQSWIU7hPQI0sh3r7zQvbFpOhBXxBNE
 aszgFuOkiU+VYyBMdu4kg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X96SyAmsr/s=:sr63MgU1ZX4LkeWhrEFUl9
 l03U4ZyBK3D8/WAkrQvgLw9Nl6SRO1MkRf3ImFuHFVh1rognJkHfMIEFvz4aKGTDJhUJP6r49
 E0gpp2GBYYeOAlJT//wY6ow8vAGDEqloHRvlDj7PM9p5cgUqhHqY7xI/kY9StU34+sXVQPLrx
 aOF4zYM/V6CECcipSUXXuDaeQ7hNoiyuu4DsrONU7cuW6N0J/NVDT7y8Kw/F+cscW693JYq6Z
 ZJOIPWX6kQ3UW0K9n5CZTUIKFPsMfGdcfQRImjWOu3exGuxXbZtLPwuU0GET0RK8G54LhCYb7
 qNjFPlFCiyZjeBaLqjjzetAKZoYkYLpXT69C87g8oMqCr0zytbjXqSxufWn5eErtuNDKG8nRF
 1WXhFWaerG3OJAR9PK0r35d8d/yOUdRHwC7yTDWy83lBjZT2qeesW9z10+16upV01KC5chWWM
 TccK5K2gwDpHzYZMuJjLYGQmWtBGqVq67MgFVRHfqU7v3PJWIlA2EmuV/7DXQVUEtKX2SNIug
 QBe/2MNgwBIKJY+fiIQ5/ZS6VrDT4mUHF6ht3SkBaA/piRUiKvi5eDf1n4ploEaX+K4vLhs/j
 5A0P0gGIHehwn4R65OPtswlNxB1e6kie1JANRZsL5zt5RuvVGHKrZURF/4isXwxJIsUbjtQJT
 iEZsxHYgPyB/sUs9Nnba3dDTu19Q2gDwiZ8LkcauUxsjqyroFY5FUcVq5z78Hk0h6qDRBia4b
 wGjmKKbeWEX55NozKo1yF4UhKf20zqx+wzVBYyRTQPslfDw+yeLsLhx016ms6RiV1qIgSEsS+
 5RN/XLk8tgEJm6ndFdo+NupY65hm5sYExGYaHLAMXw42XPumgkJ/SDdWad5S3Lx+7mUMBCD
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Michael Walle <michael@walle.cc>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 09/03/2020 à 14:18, Peter Maydell a écrit :
> On Mon, 9 Mar 2020 at 13:13, Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> Le 09/03/2020 à 14:09, Peter Maydell a écrit :
>>> On Mon, 9 Mar 2020 at 12:11, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>>>
>>>> cpu_reset() might modify architecture-specific fields allocated
>>>> by qemu_init_vcpu(). To avoid bugs similar to the one fixed in
>>>> commit 00d0f7cb66 when introducing new architectures, move the
>>>> cpu_reset() calls after qemu_init_vcpu().
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>
>>> Why do we need to call cpu_reset() from realize anyway?
>>> Generally for devices this is incorrect as they should be
>>> being reset by some other mechanism.
>>
>> I have this same change in my branch for q800 to set the initial PC and
>> stack pointer read from memory on cold boot.
>>
>> Do we have another way to do that?
> 
> The expectation at the moment is that the board code should
> register a reset function with qemu_register_reset() which
> calls cpu_reset(). Relying on doing a reset in realize won't
> work for the case where there's a QEMU system reset, because
> we don't re-init/realize everything, we just call all the
> reset hooks.
> 
> If m68k reads pc/sp from memory on reset you'll probably run
> into the same reset-ordering vs hw/cpu/loader.c that Arm M-profile
> has; we currently work around that in the arm reset function.
> I had hoped that 3-phase reset would resolve this reset order
> issue, but it has not turned out to be so easy.


Thank you for the hint, I'll have a look.

Laurent


