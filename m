Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64465C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 05:30:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 408A224D66
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 05:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 408A224D66
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45968 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY21x-00011G-DE
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 01:30:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hY20a-0000Lr-LC
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 01:29:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hY1vF-0002SJ-1m
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 01:23:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hY1vE-0002RW-SC
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 01:23:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id b18so14295826wrq.12
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 22:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=x3UKgrrRXwZkH3ro1qCFPnUWEcfDskYjDMs8ukOsXQA=;
	b=puxvxTgqtQZIZec0cQAMwrulwMsVaM4elPl7Nwe8dwH6oMP04lEGTOOjHAvhWdOvV0
	VjLA9ybTaG7F2sS8dDtd1jmJqkGO6rvP43fqJFvLNnfFlUHW+U09IZh47t/afckhAI5/
	POk4+yobN2ppybl2DcEzDgLELftV0gGEM/aJTESsjThMe7sv8N0GLkP3HsGG20e04TEb
	Aa8acs6JfD0ooSsjyLGYz3xvfu2oCgn1wDREZ1GFLzl6JU2r2i1KF8JUx2R2qT/mF6oK
	/7iVGocSfiG7awnn8gNNVzp5JNO1nzquJGDVSK8imB3FLK/2eM1AbxUPJFDjt7vVrH9d
	P19g==
X-Gm-Message-State: APjAAAVTPLGiut9BJyGkYAojTOo2Rz4tarcUd9M7iR0NK8ViG+Rq1ziv
	Rk+AeNb4D7eFFFZ5lWXT2WMTiA==
X-Google-Smtp-Source: APXvYqy5uhlwrEyqI3ZxVAEsMdnrFlLWVcI8glgAvTShEPWx9zalQf88vB55Z4P1MSr2GzCSA3saIQ==
X-Received: by 2002:a5d:6b12:: with SMTP id v18mr19005095wrw.306.1559625823111;
	Mon, 03 Jun 2019 22:23:43 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
	[88.21.202.183]) by smtp.gmail.com with ESMTPSA id
	m17sm5735164wrx.12.2019.06.03.22.23.42
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 22:23:42 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190531134315.4109-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <24299757-dab4-52cb-b64d-6fa944d0daac@redhat.com>
Date: Tue, 4 Jun 2019 07:23:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531134315.4109-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v16 00/23] Add RX architecture
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: ysato@users.sourceforge.jp
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/31/19 3:42 PM, Richard Henderson wrote:
> The v14 patch set, from which I had prepared the pull request,
> contained errors within make check-qtest-rx.  I have added 4
> new patches, 12 through 15, to address those failures.  These
> are placed before the enablement patch 16 so that there is no
> point at which these tests both run and fail.
> 
> I have not tried to extract the changes that Sato-san made in
> his v15 patch set and folded in to previous patches.
> 
> I have appended the disassembler patches that have been reviewed.
> 
> Hopefully this is the version that can be merged, so that normal
> development can proceed from there.
> 
> 
> r~
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
> Yoshinori Sato (12):
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

Series:
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

You might want to include this test:
https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg05747.html

To run it:

$ make check-venv
$ ./tests/venv/bin/python -m avocado --show=console run -t arch:rx
tests/acceptance/boot_linux_console.py
console: U-Boot 2016.05-rc3-23705-ga1ef3c71cb-dirty (Feb 05 2019 -
21:56:06 +0900)
console: Linux version 4.19.0+ (yo-satoh@yo-satoh-debian) (gcc version
9.0.0 20181105 (experimental) (GCC)) #137 Wed Feb 20 23:20:02 JST 2019
console: Built 1 zonelists, mobility grouping on.  Total pages: 8128
console: Kernel command line:
console: Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
console: Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
console: Memory: 14648K/32768K available (871K kernel code, 95K rwdata,
140K rodata, 96K init, 175K bss, 18120K reserved, 0K cma-reserved)
console: NR_IRQS: 256
console: rx-cmt: used for periodic clock events
console: clocksource: rx-tpu: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 1274173631191 ns
console: 96.00 BogoMIPS (lpj=480000)
console: pid_max: default: 4096 minimum: 301
console: Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
console: Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
console: clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 19112604462750000 ns
console: clocksource: Switched to clocksource rx-tpu
console: workingset: timestamp_bits=30 max_order=12 bucket_order=0
console: SuperH (H)SCI(F) driver initialized
console: 88240.serial: ttySC0 at MMIO 0x88240 (irq = 215, base_baud = 0)
is a sci
console: console [ttySC0] enabled
console: 88248.serial: ttySC1 at MMIO 0x88248 (irq = 219, base_baud = 0)
is a sci
console: random: get_random_bytes called from 0x01002e48 with crng_init=0
console: Freeing unused kernel memory: 96K
console: This architecture does not have kernel memory protection.
console: Run /sbin/init as init process
console: Run /etc/init as init process
console: Run /bin/init as init process
console: Run /bin/sh as init process
console: Sash command shell (version 1.1.1)
console: /> printenv
console: HOME=/
console: TERM=linux

