Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D835C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:29:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0238B205CB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0238B205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD2bL-0005fT-6i
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 05:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD2OY-0003VJ-J3; Tue, 01 Sep 2020 05:16:02 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:39783)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD2OV-0007P8-Ho; Tue, 01 Sep 2020 05:16:02 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MNKqC-1jx9P70JGk-00Onv2; Tue, 01 Sep 2020 11:15:55 +0200
Subject: Re: [PATCH] docs/system/target-avr: Improve the AVR docs and add to
 MAINTAINERS
To: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org,
 Michael Rolnik <mrolnik@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>
References: <20200812155304.18016-1-huth@tuxfamily.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f3f8e218-a78e-5a98-5b06-c588170f105a@vivier.eu>
Date: Tue, 1 Sep 2020 11:15:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200812155304.18016-1-huth@tuxfamily.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1ceeWEXpsnsLa6emFXf2oNCdRoMhB4wNYSzpIcyO1lWMEWGfA5L
 xqUlJSjHvNGv2gqCqFZkXmk3hn7ZgCCsesildJ7UrAkpAPnkUfZ+5QFYm7QyzZbPWJN1Rn7
 PiW81NtYkJmP+imNz1NIoxD7Og5mg6TjEaimaCf67FyuWKSs3a/emOJEKz4NirFQZobhE48
 b8b48Bo9z3719ekx9LvCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eYZ9f7lVI60=:o7QwIOEC3FYy0JFqysOdZ0
 WIMUvTAhlm74e6e420b+R40VZcNoQoOoPKLfdwysfwtgvpZkMQJH5oaVQjnjxjQ6ZN9HFQDrw
 b8HhsPP0IcmNcomKMxOQ+wPqrz2Yezf2XCMYkR+9CNtAseCfvnjRxdpquYGOMh0bIjkX1bNFu
 cddOVaJ8tgmHk0rNd5gDQTvtvBulOu3GxaGRaEBP7m2psERk3LM2/1cis2zKnBOAf1sQwaCjE
 oR+O74AVuBI5hfxv6M867TASxb9ACYJPFtRwq5K+N/d+4/HK3xopgyiT+t7BgNuHPuA3/7cVo
 2sjNh5rECHbIXVLykdTpDJ7UE1e24GKgzX+v4wMqjHlNh7BZ+QJNcp57nxfpLfunuHT9ujXqi
 keInbhDXmZSaFUldcN+wF7sROBg4LU+ZpqTiAoF8SqPY1TGsf+0owuUVCTcw+Yllelm34Vgek
 8A/oL5kbqjPCSWH2Js59pLUBynHw4Z3Njqqn45CKSZwoBuyZyA4AVMXdujQzHpBzU05RxBZuF
 oiQeMvmRU2RWOQapD0ZwfmRME9CSiGw2i3l9S7XS3dp0ZLxZfI6RHi/Inx6kw+DbiwUvRCeUB
 9SIfXHWNKSFqEozyvpMXVmRzvtLiCSqHx/pIJfvI3c1nkNK7lAZLmEZorh9/4/kFts/ESvd0V
 4Wr/v+IdpXYxXWufXvo/AcI7iyWeLgCAz2v7K7fyFYUvknVLzwIpYboIVzOJSGrkXv4d8Tt2U
 wcYcrTLst3bepDzqGV9L0ROhlhKv6M9NbtwivwxDUtQaLBGOodIzL/SM0gCQkRC54g8TDlWie
 EL694pwRQDwbf52r0JmvaR9EHEZs03+n2Zfi7NXGsaHDKL5iqtLs3X2Ic4MnyTyLOHPaYtM
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 05:13:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.13,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Sarah Harris <S.E.Harris@kent.ac.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 12/08/2020 à 17:53, Thomas Huth a écrit :
> The examples look nicer when using "::" code blocks.
> Also mention that "-d in_asm" only outputs instructions that have not
> been translated by the JIT layer yet.
> And while we're at it, also add the AVR doc file to the MAINTAINERS file.
> 
> Signed-off-by: Thomas Huth <huth@tuxfamily.org>
> ---
>  MAINTAINERS                |  1 +
>  docs/system/target-avr.rst | 47 +++++++++++++++++++++++---------------
>  2 files changed, 30 insertions(+), 18 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0886eb3d2b..5b21962bc6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -171,6 +171,7 @@ AVR TCG CPUs
>  M: Michael Rolnik <mrolnik@gmail.com>
>  R: Sarah Harris <S.E.Harris@kent.ac.uk>
>  S: Maintained
> +F: docs/system/target-avr.rst
>  F: gdb-xml/avr-cpu.xml
>  F: target/avr/
>  F: tests/acceptance/machine_avr6.py
> diff --git a/docs/system/target-avr.rst b/docs/system/target-avr.rst
> index dc99afc895..1410031f5e 100644
> --- a/docs/system/target-avr.rst
> +++ b/docs/system/target-avr.rst
> @@ -17,21 +17,32 @@ https://github.com/seharris/qemu-avr-tests/blob/master/free-rtos/Demo/AVR_ATMega
>  Following are examples of possible usages, assuming demo.elf is compiled for
>  AVR cpu
>  
> - - Continuous non interrupted execution:
> -   ``qemu-system-avr -machine mega2560 -bios demo.elf``
> -
> - - Continuous non interrupted execution with serial output into telnet window:
> -   ``qemu-system-avr -machine mega2560 -bios demo.elf -serial
> -   tcp::5678,server,nowait -nographic``
> -   and then in another shell
> -   ``telnet localhost 5678``
> -
> - - Debugging wit GDB debugger:
> -   ``qemu-system-avr -machine mega2560 -bios demo.elf -s -S``
> -   and then in another shell
> -   ``avr-gdb demo.elf``
> -   and then within GDB shell
> -   ``target remote :1234``
> -
> - - Print out executed instructions:
> -   ``qemu-system-avr -machine mega2560 -bios demo.elf -d in_asm``
> +- Continuous non interrupted execution::
> +
> +   qemu-system-avr -machine mega2560 -bios demo.elf
> +
> +- Continuous non interrupted execution with serial output into telnet window::
> +
> +   qemu-system-avr -M mega2560 -bios demo.elf -nographic \
> +                   -serial tcp::5678,server,nowait 
> +
> +  and then in another shell::
> +
> +   telnet localhost 5678
> +
> +- Debugging wit GDB debugger::
> +
> +   qemu-system-avr -machine mega2560 -bios demo.elf -s -S
> +
> +  and then in another shell::
> +
> +   avr-gdb demo.elf
> +
> +  and then within GDB shell::
> +
> +   target remote :1234
> +
> +- Print out executed instructions (that have not been translated by the JIT
> +  compiler yet)::
> +
> +   qemu-system-avr -machine mega2560 -bios demo.elf -d in_asm
> 

Applied to my trivial-patches branch.
(I have removed the trailing whitespace)

Thanks,
Laurent


