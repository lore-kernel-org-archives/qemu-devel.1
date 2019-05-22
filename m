Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1796AC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 14:52:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCF1320881
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 14:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF1320881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44746 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTSbL-0000ik-83
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 10:52:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hTSaU-0000PR-V6
	for qemu-devel@nongnu.org; Wed, 22 May 2019 10:51:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hTSaT-0006AH-JK
	for qemu-devel@nongnu.org; Wed, 22 May 2019 10:51:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hTSaT-0004Il-AR
	for qemu-devel@nongnu.org; Wed, 22 May 2019 10:51:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id g12so2629954wro.8
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 07:50:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=by6dhmjpY2luTaGLOylIF5/4Kh1TMIZnGR9My4Wp+mc=;
	b=KIfFhsX5R/OuRZ3DqXWcr/3fwH0SMTpsLSnXHZdMJWaBmzmYdXIPzBpmlC8gtXzr8w
	Cp9ajJg+FsN3kAHh2U1KaZGrmTxOkMJUb6LIrXmQaXGq32SyVeghrPotMubI/bYNBP6s
	jzacrigR5Wo+JMdzsGs/VYfwW1LqIJmx5ln42moWgDc9cOvrsHySPrMDG6rsMg9N4+ME
	wM45qSznYiZc175X3vN0f16peAP3FPcw12OzdEUvzB6q0/zFoQmOY6Y/cIDJDITf5EZK
	IZDPRZHN6ICVuTdCDBSW+amUzA3Ce+YzO81sZX6QC5Tw1XOPurFkcPBniiHc6kpYRgEB
	G57Q==
X-Gm-Message-State: APjAAAVDGzfrqQbARAhuVEWlV4SOggTvE8ZgPVqHEaCTl1x6Gk5aNmr2
	c67mxWbvj4blSkoQkJS0GNP4Yg==
X-Google-Smtp-Source: APXvYqzcQe5v5YxHI9HX6J2EULCcJhCr6Ge2kZSDGhmkBuj9UjqXVRcI0gP1X1ZEGe/RXM6GJLlTEQ==
X-Received: by 2002:adf:e44b:: with SMTP id t11mr6193133wrm.151.1558536643489; 
	Wed, 22 May 2019 07:50:43 -0700 (PDT)
Received: from [10.201.33.53] ([195.166.127.210])
	by smtp.gmail.com with ESMTPSA id
	s10sm21905027wrt.66.2019.05.22.07.50.42
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 07:50:43 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190522142956.41916-1-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <dd7f9ae2-e7ae-790c-170b-81d127a6222c@redhat.com>
Date: Wed, 22 May 2019 16:50:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522142956.41916-1-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v15 00/12] Add RX archtecture support
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Yoshinori,

On 5/22/19 4:29 PM, Yoshinori Sato wrote:
> Hello.
> This patch series is added Renesas RX target emulation.
> 
> Fix is bellow.
> - Reorder patches.
> - Rewrite renesas_cmt.
>   Convert to RCMTChannelStatus
> - Use CPUClass::tlb_fill
> - Use tcg_gen_abs_i32
> - Fix racw instructions.
> - Cleanup for review comment.
>   target/rx/helper.c - fix spelling.
>   hw/intc/rx_icu.h - cleanup constant definition.
>   hw/registerfields.h - fix macro definion order.

$ git backport-diff -u rx14 -r origin/master..rx15
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences,
respectively

001/12:[----] [--] 'qemu/bitops.h: Add extract8 and extract16'
002/12:[0008] [FC] 'hw/registerfields.h: Add 8bit and 16bit register macros'
003/12:[0018] [FC] 'target/rx: TCG translation'
004/12:[0004] [FC] 'target/rx: TCG helper'
005/12:[0030] [FC] 'target/rx: CPU definition'
006/12:[----] [--] 'target/rx: RX disassembler'
007/12:[0003] [FC] 'hw/intc: RX62N interrupt controller (ICUa)'
008/12:[0178] [FC] 'hw/timer: RX62N internal timer modules'
009/12:[----] [--] 'hw/char: RX62N serial communication interface (SCI)'
010/12:[0004] [FC] 'hw/rx: RX Target hardware definition'
011/12:[----] [--] 'Add rx-softmmu'
012/12:[0004] [FC] 'MAINTAINERS: Add RX'

- you removed rx_abs(),
- one change in trans_RACW()
- fixed typos (Richard fixe them)
- LOT of changes in the timer device, you added RCMTChannelState()

Hmm you did reset some of the R-b T-b tags.


I guess Richard already prepared a pull request for your v14.

At this point I'd prefer the v14 get merged, and the v15 changes amended
as new commits. This would ease review/testing.

Maybe Richard can still amend the 'trans_RACW' one-line fix on his pullreq.

Richard what's your take on this?

Regards,

Phil.

> My git repository is bellow.
> git://git.pf.osdn.net/gitroot/y/ys/ysato/qemu.git tags/rx-20190522
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
> Yoshinori Sato (12):
>   qemu/bitops.h: Add extract8 and extract16
>   hw/registerfields.h: Add 8bit and 16bit register macros.
>   target/rx: TCG translation
>   target/rx: TCG helper
>   target/rx: CPU definition
>   target/rx: RX disassembler
>   hw/intc: RX62N interrupt controller (ICUa)
>   hw/timer: RX62N internal timer modules
>   hw/char: RX62N serial communication interface (SCI)
>   hw/rx: RX Target hardware definition
>   Add rx-softmmu
>   MAINTAINERS: Add RX

