Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520FCC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:55:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB24920936
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMD6Miz1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB24920936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL838-0002ak-JM
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 12:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kL81h-0001kF-Uw; Wed, 23 Sep 2020 12:53:53 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33794)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kL81g-0005Zs-1j; Wed, 23 Sep 2020 12:53:53 -0400
Received: by mail-wr1-x444.google.com with SMTP id t10so828725wrv.1;
 Wed, 23 Sep 2020 09:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:cc:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9Nls0ul5VAwvp9pDKm8eM8JbcgCJdrcZ66msakCrgWw=;
 b=MMD6Miz1NJz2LUkf2Qz7Sv8FUPQHr4mDjSVjCQ7m/tfd2v2OMAdQg7TRf1X7oU+pzd
 JH/jkZ1TVIFFEVv86+rcGSUnnF9AO5BrmNUZcw1HiWOtW/40GcdP76giHHCGv3PL/5Fw
 a1x/zpyso1K+rPv6YSEyEmnIsW+40ovVCUMNrRF4lrt7fFFJVWioPCAj6y3HEbmGKC0q
 ul/7GoMWFtAI3a38aYUEC5gMdNSw8/F95svtkoXhihmcV5+594yVzKXuJFemF4qEj9Aq
 Pf7/nreW947alNsy3mWVUTKNG8KQ/BKUibyov+BENMcNStM5YvUTuFC9yrJLQuA3urw5
 PkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:cc:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9Nls0ul5VAwvp9pDKm8eM8JbcgCJdrcZ66msakCrgWw=;
 b=Mc+nuBxNRWAAbb1b8ZFDeEFvz1vx3ZiDxdp+Sf4TEcCoSN1pQTVovHfq9t6O3KtVmr
 8YZJum3SV06MkZ5jZVXaDK7IB7cGDuIEQcJfYfkowXOzjaIxzrAyZtzxcVBPLxjlI/5x
 gHyJbw+IAIBQ9PW16tG83dSS3F7mxY6crofzxhPXN+YPaciP8c/x4xc1WwkyYtk1L9c4
 IUxsIoQV2mRRUmkrCGSLVWN4HW9tQBvkn3jViZLXewBIwh5EdU3/poxnLzoUfmjDGFA7
 PNCGPgfx1U8GJHO4kDH4Al+UoaYOO+hiAhVMsHTWdaeXGeMK1LISP/9s39vzfikaktSZ
 ztNw==
X-Gm-Message-State: AOAM532W1b5zhG66ycQ9QuQCtRYFD4HU4HpaH+EGjZ79enag5s37VmIQ
 0jRgD4eKCThOY8RcEzJ2BcJGhbx5Slc=
X-Google-Smtp-Source: ABdhPJwvI3YERQjI/yTKE8miMJuL/qf/Uvx6Pi6QToYQGMiSRkAFK1IAjz2BKtPZ+4yOkzK9htS2yg==
X-Received: by 2002:adf:8162:: with SMTP id 89mr590258wrm.237.1600880026042;
 Wed, 23 Sep 2020 09:53:46 -0700 (PDT)
Received: from [192.168.1.34] (234.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.234])
 by smtp.gmail.com with ESMTPSA id 63sm417682wrh.71.2020.09.23.09.53.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2020 09:53:45 -0700 (PDT)
Subject: Re: Minix 1.1 with QEMU
To: Will Senn <will.senn@gmail.com>, qemu-discuss@nongnu.org,
 qemu-devel <qemu-devel@nongnu.org>
References: <5e534cc7-2a99-baa5-fc8f-63d0d8e85c97@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <edc82d55-e5d1-abba-9a8e-7954b1dbe66e@amsat.org>
Date: Wed, 23 Sep 2020 18:53:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <5e534cc7-2a99-baa5-fc8f-63d0d8e85c97@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Will,

On 9/23/20 6:45 PM, Will Senn wrote:
> Long time user, first time poster :)
> 
> So, I'd like to be able to run Minix 1.1 on my Macbook Pro mid-2012
> w/16gb RAM (MacOS 10.14.6 Mojave). Qemu will run pretty ancient OS'es
> such as DOS 2.0, which I use all of the time. However, I'm having some
> difficulty getting Minix to run. I am able to boot the first floppy, but
> when I change to the second floppy, the system freezes and I can't tell
> what is going on. Here's what I did to get this far:
> 
> brew install qemu
> 
> qemu-system-i386 --version
> QEMU emulator version 5.1.0
> 
> mkdir ~/workspaces/retro-workspace/minix-1.1
> cd ~/workspaces/retro-workspace/minix-1.1
> aria2c
> http://download.minix3.org/previous-versions/bzipped/Intel-1.1.tar.bz2
> tar xvjf Intel-1.1.tar.bz2
> cp Intel-1.1/floppy_disk1 ./Disk01.img
> cp Intel-1.1/floppy_disk2 ./Disk02.img
> cp Intel-1.1/floppy_disk3 ./Disk03.img
> cp Intel-1.1/floppy_disk4 ./Disk04.img
> 
> 
> qemu-system-i386 -drive
> file=Disk01.img,format=raw,if=floppy,media=disk,readonly=off,index=0,snapshot=on
> \
>   -boot a \
>   -no-fd-bootchk \
>   -monitor telnet::2222,server,nowait -serial mon:stdio
> 
> Qemu boots to the Minix 1.1 Boot screen and says to swap to floppy 2, so
> in the monitor:
> change floppy0 Disk02.img raw
> 
> I press l (el) and it scans the disk, lists the files on the disk and
> reports no errors, but when I press =, it does a carriage return and
> just sits there. I'm pretty sure this is the Minix going bye bye and not
> necessarily QEMU, but I'm wondering if there is a way to see what QEMU
> thinks it is doing or if it is what's hung? Usually, at this point,
> Minix reads the disk contents into a Ramdisk and boots Minix.
> 
> Food for thought... Minix expects to run on an IBM PC (5150), IBM PC XT
> (5160), or compatible, and therefore the I/O is written for whatever
> floppy controller was extant at that time (I'm guessing here), so if
> that's different than modern day floppies, I suppose this could cause
> the problem I'm experiencing here. Is there a way to see the floppy
> controller activity in QEMU? Similarly, I gather it expects a CGA
> compatible monitor (EGA/VGA, etc should be fine).

Can you try adding '-machine isapc', which is closer to the 5150?

> 
> I appreciate your help on this.
> 
> Minix 1.1 works 'ok' in 86Box and other IBM PC emulations, so I know the
> floppies are fine.
> 
> Thanks!
> 
> Will
> 
> 
> 
> -- 
> GPG Fingerprint: 68F4 B3BD 1730 555A 4462  7D45 3EAA 5B6D A982 BAAF
> 


