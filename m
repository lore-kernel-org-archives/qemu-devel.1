Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4BAC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:50:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A9DE212CC
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A9DE212CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT8Ke-0002g9-7f
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 14:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kT8JO-0001r3-0z
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 14:49:14 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:55848
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kT8JL-0007l9-Se
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 14:49:13 -0400
Received: from host86-148-246-80.range86-148.btcentralplus.com
 ([86.148.246.80] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kT8JH-0001S3-Pc; Thu, 15 Oct 2020 19:49:12 +0100
To: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>,
 Howard Spoelstra <hsp.cat7@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20201014135416.1290679-1-pbonzini@redhat.com>
 <CABLmASGJOFbYUhSAbKhc9s1G00Jh0vN--WaFPtaoHqsL2WuvbQ@mail.gmail.com>
 <44d3eccf-3c64-82cd-b5b2-641de6960ab5@redhat.com>
 <CABLmASE55n6h=fr8UrKOHdu1Z_P-46a9t4L0KaRxvvf0hob01w@mail.gmail.com>
 <214e983c-b9e8-d03d-099e-d8fe506e6a7b@t-online.de>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <3ea54584-e67c-579e-9f5f-900611d072a1@ilande.co.uk>
Date: Thu, 15 Oct 2020 19:49:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <214e983c-b9e8-d03d-099e-d8fe506e6a7b@t-online.de>
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/10/2020 18:39, Volker Rümelin wrote:

>> Thanks Paolo,
>>
>> Then only the issue regarding the pcbios/optionrom stuff remains ;-)
>>
>> make[1]: *** No rule to make target 'multiboot.bin', needed by 'all'.  Stop.
>> make: *** [Makefile:171: pc-bios/optionrom/all] Error 2
>> make: *** Waiting for unfinished jobs....
>>
>> Best,
>> Howard
>>
> 
> Hi Howard,
> 
> one solution for this issue is to uncomment the following line in msys2_shell.cmd.
> 
> rem To activate windows native symlinks uncomment next line
> set MSYS=winsymlinks:nativestrict
> 
> Then tell Windows 10 it's okay to create symlinks without elevated rights. Here is a link with a description how to do this.
> https://www.joshkel.com/2018/01/18/symlinks-in-windows/
> 
> I think since commit bf708f3c4a "optionrom: simplify Makefile" pc-bios/optionrom/Makefile in your build directory has to be a symbolic link. Without 'set MSYS=winsymlinks:nativestrict' msys2 ln -s copies the Makefile instead of creating a symbolic link.

Wow thanks for this. I had the same issue as Howard, and I can confirm that this 
fixes the problem for me. Having said that it was quite fiddly to get this working 
correctly - is there any reason why 
https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg06997.html still can't be 
merged?


ATB,

Mark.

