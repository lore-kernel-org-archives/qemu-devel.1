Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252EFC43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 21:50:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23404206C0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 21:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23404206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35552 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJmFt-00057D-NT
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 17:50:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJmET-0004Rr-0I
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 17:48:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJmER-0001uJ-6b
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 17:48:40 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJmEQ-0001tV-TP
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 17:48:39 -0400
Received: by mail-wm1-f67.google.com with SMTP id h18so1339864wml.1
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 14:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=hJatKdPVxanwTTmFXYxtRR78VeW99Db8Ei/S5bsheSU=;
	b=fE1JuwWTDROLV4GdjbPD2f6PJonV0P0dYwl25pQK11n/USpHgceX+TVEaThGq1YGCc
	zKBpEIeerBhPSm+74c6vNS/XamANH7ree4a7WhlicTJBz3UIEGCbGeGBlOiaAEYwO4fU
	c637Qn/+0+cAUsL5Pyt6s9xzENvknQl6Fh3ebP3R9hiOlLtRAxjBUkByK6Ip2OftQN7g
	AQT16y6D+RgHYJuhEM9mp9BBkRmcryLNVWziVsLhQHzokffVZFgegbYgVxpwiHs4lmDG
	LbHsLH30tY7XyODiW5wv96RrG7dRkl3s5x8M59w5p3QwP6NcSnKO5Qyricr0nYE1Gn65
	jyXQ==
X-Gm-Message-State: APjAAAWFTAb2M5ROKBlDVKMw1EhZsH6UWRWl5bKnCqEzLYdnz9gv1ILK
	A+0AKytZ3wqPlf34/2RfG4DXyw==
X-Google-Smtp-Source: APXvYqxfpTEvMrYqi1gROtQzpjxoeuoz6SMSQOyPeRxZqt0O+Njk7hjmI9my4KIiK4Pc7MpfeqgDLw==
X-Received: by 2002:a1c:6c17:: with SMTP id h23mr5046170wmc.122.1556228917367; 
	Thu, 25 Apr 2019 14:48:37 -0700 (PDT)
Received: from [192.168.1.25] (abayonne-654-1-209-122.w109-222.abo.wanadoo.fr.
	[109.222.216.122]) by smtp.gmail.com with ESMTPSA id
	r16sm19186256wrx.37.2019.04.25.14.48.35
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 14:48:36 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	Stefan Hajnoczi <stefanha@redhat.com>
References: <20190103144124.18917-1-stefanha@redhat.com>
	<CAFEAcA-B_T9E3ezWFXg-wp3RotMjv3-z3qY7hSJZEoqFBqCWnQ@mail.gmail.com>
	<62b29bc1-cc78-cd64-4377-fc4007ba7189@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <9f20517f-dea4-cbc9-86ad-bab5c66d2d5c@redhat.com>
Date: Thu, 25 Apr 2019 23:48:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <62b29bc1-cc78-cd64-4377-fc4007ba7189@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH] Revert "armv7m: Guard against no -kernel
 argument"
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
Cc: Jim Mussared <jim@groklearning.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Steffen Gortz <qemu.ml@steffen-goertz.de>,
	qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
	Thomas Huth <thuth@redhat.com>, Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425214834.AxyqVkN40Q-h5QhC9viX4pem99Fc_-diLTDEVpJ8TL4@z>

On 4/25/19 8:07 PM, Philippe Mathieu-Daudé wrote:
> Hi Peter, Stefan,
> 
> On 1/4/19 4:16 PM, Peter Maydell wrote:
>> On Thu, 3 Jan 2019 at 14:41, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>>
>>> This reverts commit 01fd41ab3fb69971c24a69ed49cde96086d81278.
>>>
>>> The generic loader device (-device loader,file=kernel.bin) can be used
>>> to load a kernel instead of the -kernel option.  Some boards have flash
>>> memory (pflash) that is set via the -pflash or -drive options.
>>>
>>> Allow starting QEMU without the -kernel option to accommodate these
>>> scenarios.
>>>
>>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> 
> Previous to this commit (v3.1), we have:
> 
> $ qemu-system-aarch64 -M netduino2
> qemu-system-aarch64: Guest image must be specified (using -kernel)
> 
> Now (v4.0) we get:
> 
> $ qemu-system-aarch64 -M netduino2
> qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1)
> 
> R00=00000000 R01=00000000 R02=00000000 R03=00000000
> R04=00000000 R05=00000000 R06=00000000 R07=00000000
> R08=00000000 R09=00000000 R10=00000000 R11=00000000
> R12=00000000 R13=ffffffe0 R14=fffffff9 R15=00000000
> XPSR=40000003 -Z-- A handler
> FPSCR: 00000000
> Aborted (core dumped)

(gdb) bt
#0  0x00007fd14f39457f in raise () at /lib64/libc.so.6
#1  0x00007fd14f37e895 in abort () at /lib64/libc.so.6
#2  0x000056286da2695c in cpu_abort (cpu=0x5628705c43c0,
fmt=0x56286dfdc450 "Lockup: can't escalate %d to HardFault (current
priority %d)\n") at /source/qemu/exec.c:1282
#3  0x000056286dada4ea in do_armv7m_nvic_set_pending
(opaque=0x5628705a5030, irq=3, secure=false, derived=false) at
/source/qemu/hw/intc/armv7m_nvic.c:632
#4  0x000056286dada568 in armv7m_nvic_set_pending
(opaque=0x5628705a5030, irq=6, secure=false) at
/source/qemu/hw/intc/armv7m_nvic.c:650
#5  0x000056286db3ae1b in arm_v7m_cpu_do_interrupt (cs=0x5628705c43c0)
at /source/qemu/target/arm/helper.c:8822
#6  0x000056286dad2e9e in cpu_handle_exception (cpu=0x5628705c43c0,
ret=0x7fd13d9fbe2c) at /source/qemu/accel/tcg/cpu-exec.c:504
#7  0x000056286dad350a in cpu_exec (cpu=0x5628705c43c0) at
/source/qemu/accel/tcg/cpu-exec.c:709
#8  0x000056286da77497 in tcg_cpu_exec (cpu=0x5628705c43c0) at
/source/qemu/cpus.c:1431
#9  0x000056286da77caf in qemu_tcg_cpu_thread_fn (arg=0x5628705c43c0) at
/source/qemu/cpus.c:1735
#10 0x000056286deb5dce in qemu_thread_start (args=0x5628705ea850) at
/source/qemu/util/qemu-thread-posix.c:502
#11 0x00007fd14f52a58e in start_thread () at /lib64/libpthread.so.0
#12 0x00007fd14f459683 in clone () at /lib64/libc.so.6

Running with -d in_asm,int:
----------------
IN:
0x00000000:  00000000  andeq    r0, r0, r0

Taking exception 18 [v7M INVSTATE UsageFault]
...BusFault with BFSR.STKERR
...taking pending nonsecure exception 3
----------------
IN:
0x00000000:  00000000  andeq    r0, r0, r0

Taking exception 18 [v7M INVSTATE UsageFault]
qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1)

Since I didn't provided anything to bootstrap the guest, the bootvector
in flash is obviously empty.

> 
> This is confusing.
> 
> (same happens with emcraft-sf2, microbit, musca-*)
> 
> Regards,
> 
> Phil.
> 

