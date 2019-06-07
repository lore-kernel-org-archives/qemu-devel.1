Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCDAC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 14:13:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A330206E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 14:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A330206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51556 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZFcL-00074H-9K
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 10:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49215)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hZFWF-0003Pl-Ns
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:07:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hZFWE-0004jT-Ef
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:06:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38229)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hZFWD-0004ff-7e
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:06:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id d18so2321143wrs.5
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 07:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uIbtuOuzG8f6L26TbK2FqLZnT6LXGJy6H4Ihys3Eo5c=;
 b=ERGO+YtuWeDdWM8tSo4EZfWEzsj1i6oym5zg78+Mxshpxqfp+IXk0sjTrp3CxFHzZO
 0OSgOijThbqdNE1bVQQeMNcdCiHDhYVA/aPtRXB7xIjHbLqm2dSjDw/DrfpnxFbCdJwE
 53zwwKDwNsPW9HLYPK+CmLfTzTTEd7eAQxD8uxs+V7jbRMF/RHJ1bjIDSkUBjQ9codRs
 tkmDNYjnv+BDldXdNsi52hjOT/vzOwUNzGozsdvnwUyjJlW6p9oS1RLBnJy87efrW4Gi
 UVQPqhHwQ0CvFu7jwEI9+SakbF0973PSsfN7Zgo+PincA6H98jppWFhCiUtFP26wUKOF
 nFtA==
X-Gm-Message-State: APjAAAU8WG+FSsvFh8frncp9/3HmkMzlBMjACvFJaINpUy3OsPP9FmKo
 mOloiFG8NZ4TwDUiLJMAFJzVMA==
X-Google-Smtp-Source: APXvYqxbt/FrcdGgQ5dmr/6KOlr7TLJ+pReZcZtN4JaUWI1JbAkipkGdTh7PaZZR3iUWI76A0wq+mg==
X-Received: by 2002:a5d:424f:: with SMTP id s15mr5602878wrr.37.1559916414973; 
 Fri, 07 Jun 2019 07:06:54 -0700 (PDT)
Received: from [192.168.0.156] ([78.192.181.46])
 by smtp.gmail.com with ESMTPSA id y17sm3914776wrg.18.2019.06.07.07.06.54
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 07:06:54 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190607091116.49044-1-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <0501e7a3-9a04-3712-18fe-d946acc86bca@redhat.com>
Date: Fri, 7 Jun 2019 16:06:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190607091116.49044-1-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v17 00/24] Add RX archtecture support
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Yoshinori,

On 6/7/19 11:10 AM, Yoshinori Sato wrote:
> Hello.
> This patch series is added Renesas RX target emulation.
> 
> Changes v17.
> Remove cpu class name suffix.

I was a bit annoyed you did not collect my review effort from the
previous series. It is time-saving for reviewers because you don't have
to re-review the same code twice.

> 
> My git repository is bellow.
> git://git.pf.osdn.net/gitroot/y/ys/ysato/qemu.git tags/rx-20190607
> 
> Testing binaries bellow.
> u-boot
> Download - https://osdn.net/users/ysato/pf/qemu/dl/u-boot.bin.gz
> 
> starting
> $ gzip -d u-boot.bin.gz
> $ qemu-system-rx -bios u-boot.bin
> 
> linux and pico-root (only sash)
> Download - https://osdn.net/users/ysato/pf/qemu/dl/zImage (kernel)
>            https://osdn.net/users/ysato/pf/qemu/dl/rx-qemu.dtb (DeviceTree)
> 
> starting
> $ qemu-system-rx -kernel zImage -dtb rx-qemu.dtb -append "earlycon"
> 
> 
> Richard Henderson (11):
>   target/rx: Convert to CPUClass::tlb_fill
>   target/rx: Add RX to SysEmuTarget
>   target/rx: Fix cpu types and names
>   tests: Add rx to machine-none-test.c
>   hw/rx: Honor -accel qtest
>   target/rx: Disassemble rx_index_addr into a string
>   target/rx: Replace operand with prt_ldmi in disassembler
>   target/rx: Use prt_ldmi for XCHG_mr disassembly
>   target/rx: Emit all disassembly in one prt()
>   target/rx: Collect all bytes during disassembly
>   target/rx: Dump bytes for each insn during disassembly
> 
> Yoshinori Sato (13):
>   target/rx: TCG translation
>   target/rx: TCG helper
>   target/rx: CPU definition
>   target/rx: RX disassembler
>   hw/intc: RX62N interrupt controller (ICUa)
>   hw/timer: RX62N internal timer modules
>   hw/char: RX62N serial communication interface (SCI)
>   hw/rx: RX Target hardware definition
>   qemu/bitops.h: Add extract8 and extract16
>   hw/registerfields.h: Add 8bit and 16bit register macros
>   Add rx-softmmu
>   MAINTAINERS: Add RX
>   target/rx: Remove suffix in cpu class.

I'd move the last patch directly after "target/rx: Fix cpu types and names".

Actually I rebased it this way:

[PATCH 01/24] target/rx: TCG translation
[PATCH 02/24] target/rx: TCG helper
[PATCH 03/24] target/rx: CPU definition
[PATCH 04/24] target/rx: RX disassembler
[PATCH 18/24] target/rx: Disassemble rx_index_addr into a string
[PATCH 19/24] target/rx: Replace operand with prt_ldmi in disassembler
[PATCH 20/24] target/rx: Use prt_ldmi for XCHG_mr disassembly
[PATCH 21/24] target/rx: Emit all disassembly in one prt()
[PATCH 22/24] target/rx: Collect all bytes during disassembly
[PATCH 23/24] target/rx: Dump bytes for each insn during disassembly
[PATCH 05/24] hw/intc: RX62N interrupt controller (ICUa)
[PATCH 06/24] hw/timer: RX62N internal timer modules
[PATCH 07/24] hw/char: RX62N serial communication interface (SCI)
[PATCH 08/24] hw/rx: RX Target hardware definition
[PATCH 09/24] qemu/bitops.h: Add extract8 and extract16
[PATCH 10/24] hw/registerfields.h: Add 8bit and 16bit register macros
[PATCH 11/24] target/rx: Convert to CPUClass::tlb_fill
[PATCH 13/24] target/rx: Fix cpu types and names
[PATCH 24/24] target/rx: Remove suffix in cpu class.
[PATCH 12/24] target/rx: Add RX to SysEmuTarget
[PATCH 14/24] tests: Add rx to machine-none-test.c
[PATCH 15/24] hw/rx: Honor -accel qtest
[PATCH 16/24] Add rx-softmmu
[PATCH 17/24] MAINTAINERS: Add RX

On Linux + win32 running u-boot + Linux as suggested:
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

