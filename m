Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90131C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 09:36:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C20232071A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 09:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C20232071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTMA1-0002yW-Q8
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 05:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kTM92-00026e-Mq
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 05:35:30 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:56860
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kTM8w-0005vX-TV
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 05:35:28 -0400
Received: from host86-148-246-80.range86-148.btcentralplus.com
 ([86.148.246.80] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kTM8s-0008Io-Ke; Fri, 16 Oct 2020 10:35:24 +0100
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20201014135416.1290679-1-pbonzini@redhat.com>
 <CABLmASGJOFbYUhSAbKhc9s1G00Jh0vN--WaFPtaoHqsL2WuvbQ@mail.gmail.com>
 <44d3eccf-3c64-82cd-b5b2-641de6960ab5@redhat.com>
 <CABLmASE55n6h=fr8UrKOHdu1Z_P-46a9t4L0KaRxvvf0hob01w@mail.gmail.com>
 <214e983c-b9e8-d03d-099e-d8fe506e6a7b@t-online.de>
 <3ea54584-e67c-579e-9f5f-900611d072a1@ilande.co.uk>
 <CABgObfaWkeiLEuigNoL3pmK05fKMbyEjtPG3SV2B4p6ZxEiQDQ@mail.gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <eb4db857-3a3c-3deb-e4c8-6e48634fe0ed@ilande.co.uk>
Date: Fri, 16 Oct 2020 10:35:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CABgObfaWkeiLEuigNoL3pmK05fKMbyEjtPG3SV2B4p6ZxEiQDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.148.246.80
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 0/7] build: replace ninjatool with ninja
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.019,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>,
 qemu-devel <qemu-devel@nongnu.org>, Howard Spoelstra <hsp.cat7@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/10/2020 22:41, Paolo Bonzini wrote:

> Il gio 15 ott 2020, 20:49 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk 
> <mailto:mark.cave-ayland@ilande.co.uk>> ha scritto:
> 
>     Is there any reason why
>     https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg06997.html
>     <https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg06997.html> still can't be
>     merged?
> 
> 
> Because it's not the right approach. There is no reason why building firmware cannot 
> be done with cross compilers, so moving those directories to Meson (not because Meson 
> can't handle them; more specifically, the issue is tying the firmware build to the 
> QEMU build system) is going in the wrong direction.
> 
> The "Canadian cross" scenario, where you build on Linux a mingw GCC but the compiler 
> is s390, is not even enough to describe the complexity in the case of QEMU, because 
> there are multiple firmware for different machines.
> 
> However we already have all the infrastructure to do such builds, we just don't use 
> it for the firmware. So, instead of the patch you recalled above, the tests/tcg 
> machinery should be extended into something that can be reused for firmware. As an 
> aside, orchestrating this multi-compiler part of the build is what the Makefiles will 
> keep on handling for the foreseeable future. As an aside to the aside, tests/tcg is 
> more than underdocumented and I forget everything about it 5 minutes after looking at it.
> 
> This is not something that I will be able to work on anytime soon. But still I don't 
> think that going in the wrong direction is a good idea, even if temporarily.

That's a shame, although I do appreciate the huge amount of time and effort that 
you've put into this release in order to get the Meson build up and running, and so 
why taking on another large task is going to be lower down the list :)

At the moment OpenBIOS doesn't have a docker image capable of building the required 
binaries: I did experiment with trying to use the QEMU docker images for openbios-ppc 
but whilst the binary built successfully, it did not run compared to my hand-rolled 
compilers. So there's still some debugging to be done there...


ATB,

Mark.

