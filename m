Return-Path: <SRS0=AG+E=EA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC618C388F7
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 11:21:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6C75222E8
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 11:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C75222E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWe5i-0007xG-0T
	for qemu-devel@archiver.kernel.org; Sun, 25 Oct 2020 07:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kWe3L-00073n-O3
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 07:19:11 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:46054
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kWe3K-0007fD-47
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 07:19:11 -0400
Received: from host86-148-246-80.range86-148.btcentralplus.com
 ([86.148.246.80] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kWe3C-0001jt-9U; Sun, 25 Oct 2020 11:19:06 +0000
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201021105035.2477784-1-f4bug@amsat.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <54a947e4-929c-aaa4-52b0-339827a010b8@ilande.co.uk>
Date: Sun, 25 Oct 2020 11:18:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201021105035.2477784-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.148.246.80
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 0/6] tests/acceptance: Test the Fuloong 2E machine
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
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

On 21/10/2020 11:50, Philippe Mathieu-Daudé wrote:

> This series add tests for the MIPS Fuloong 2E machine.
> 
> I have been using these tests for over 1 year now.
> After recent discussions with Huacai and Mark regarding
> how to contribute tests for machines using private blob,
> I think it is time to publish this series, to see how
> the final part will be discussed, as it tests a blob
> which Lemote company doesn't publish the sources. The
> binary is know to work and has been used for various
> years on real hardware. Its MD5 is also know (I am not
> using SHA-1 because it has been published with MD5).
> 
> The idea is to be able to share tests without infringing
> licenses issues.
> 
> Please comment :)
> 
> Phil.
> 
> Philippe Mathieu-Daudé (6):
>    tests/acceptance: Remove unused import
>    tests/acceptance: Use .ppm extention for Portable PixMap files
>    tests/acceptance: Extract tesseract_available() helper in new
>      namespace
>    tests/acceptance: Introduce tesseract_ocr() helper
>    tests/acceptance: Test Linux on the Fuloong 2E machine
>    tests/acceptance: Test PMON on the Fuloong 2E machine
> 
>   MAINTAINERS                                |   1 +
>   tests/acceptance/machine_m68k_nextcube.py  |  51 ++---------
>   tests/acceptance/machine_mips_fuloong2e.py | 101 +++++++++++++++++++++
>   tests/acceptance/tesseract_utils.py        |  46 ++++++++++
>   4 files changed, 158 insertions(+), 41 deletions(-)
>   create mode 100644 tests/acceptance/machine_mips_fuloong2e.py
>   create mode 100644 tests/acceptance/tesseract_utils.py

In general this looks good: certainly I don't see any reason why the tesseract_ocr 
helper changes shouldn't be merged, since I expect that this is something that will 
be used more in future.

Looking at the fuloong test it seems that it stops fairly early in the kernel boot: 
one of the problems that Zoltan's VIA southbridge patches were trying to solve 
earlier in the year was because of problems with PCI IRQ routing, so it would be nice 
to include a small OS image that can be used to boot to userspace to ensure that such 
problems can be detected in future.


ATB,

Mark.

