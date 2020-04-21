Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3160FC54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 19:34:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0697206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 19:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oEpJ4gAn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0697206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQyey-00053B-Ez
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 15:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54788)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1jQydl-0004aU-D0
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 15:33:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1jQydj-00056r-SJ
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 15:33:05 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:53435)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmerdabbelt@google.com>)
 id 1jQydj-000541-EK
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 15:33:03 -0400
Received: by mail-pj1-x1041.google.com with SMTP id hi11so1799352pjb.3
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 12:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=HVse85FL1xmXxc9mv3/jgM4CIEFdCwr6uLhePKPC4Oo=;
 b=oEpJ4gAnXuHDCtgsVDYhilZlrboJ6tYlIskAu6GezGijd4v1NLlZMDKa2UH7WIslmg
 5H8lCUuB+yWybPRy9KgEezfJzMf6MsDArDWrB2dGAkvpRojBCOeJ03Vr9KxfBXE8uNh1
 grU19l9MDpOorc115vrjolPGfHInA2Cdlbm9bI3G28QqAh+wUXY6Q1ZzTvP0xFEYrYY9
 RQzcVq2fjdeQIP9yJILB/p73BVX/fIDiejpCT1xKwNVSHuay2xqP8Fh9d7urKFDPDJLF
 yIorjQ262wF3cimdNCnzhBiv8E0aAyWZkkfJXdCp2e/fxy9aVVYqcMRkb6lJaI18AK9K
 ahHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=HVse85FL1xmXxc9mv3/jgM4CIEFdCwr6uLhePKPC4Oo=;
 b=qqWnk2E5tIMlWFsl4E8Rs1Zx+F3iyErU/MCDPnL+guU7uDqgX2OP5lFHKrrGodTQI7
 nNhqRb/BEJ9uoM+1YNENUh6xECA1v8Lspb6XYxaDnziyx3e5R2M4N39BNRR6sLOdQW8V
 +43d5rqlWmCsWZ5dd9OCkokHUTH0m/J6ADldEssewsWkUA6CMF49vfLiiLP7JhtLc/cj
 g734bTvi0ouElilnx4IdlCbi8zOntPo28FKYZhLNfX9GYFjwmKeRk6PEPTeHQVvXRmqJ
 zrUuAJPAgITKx9bzOJpC4niI6fTwLJvSR22mvcdyS6sYBiKsFPL3hz4FQMqokiVhDbTF
 IYaA==
X-Gm-Message-State: AGi0PuY+B9lBx00wPtTcXuMN3auHuM5jjXuclNzSsvQoJpjp//XrIinl
 erCv5NvfCXi6vD6RsNnLCkR+2w==
X-Google-Smtp-Source: APiQypLk5HW4wwxU9bnCj25Obqg7v8pjLpqSoty9FQrXFKiuKCr8alZC4ghmIvt+m9d4GNFCUcWgmQ==
X-Received: by 2002:a17:902:5999:: with SMTP id
 p25mr23911623pli.189.1587497580140; 
 Tue, 21 Apr 2020 12:33:00 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net.
 [76.210.143.223])
 by smtp.gmail.com with ESMTPSA id g25sm3134065pfo.150.2020.04.21.12.32.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 12:32:59 -0700 (PDT)
Date: Tue, 21 Apr 2020 12:32:59 -0700 (PDT)
X-Google-Original-Date: Tue, 21 Apr 2020 12:32:55 PDT (-0700)
Subject: Re: [PULL] RISC-V Patches for 5.0-rc4
In-Reply-To: <CAFEAcA9ZrLDnU1KLmoPBqhS1fYVG05TzN3bojEGherL7PRhwFg@mail.gmail.com>
CC: Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <mhng-02e556f3-e3ba-477e-b579-7c70037177e1@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=palmerdabbelt@google.com; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1041
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Apr 2020 12:27:50 PDT (-0700), Peter Maydell wrote:
> On Tue, 21 Apr 2020 at 20:19, Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>> ----------------------------------------------------------------
>> RISC-V Patches for 5.0-rc4
>>
>> This contains handful of patches that I'd like to target for 5.0.  I know it's
>> a bit late, I thought I'd already sent these out but must have managed to miss
>> doing so.  The patches include:
>>
>> * A handful of fixes to PTE lookups related to H-mode support.
>> * The addition of a serial number fo the SiFive U implementetaion, which allows
>>   bootloaders to generate a sane MAC address.
>>
>> These pass "make check" and boot Linux for me.
>>
>> ----------------------------------------------------------------
>> Peter: Sorry I dropped the ball here.  I can understand if it's too late for
>> 5.0, but if there's still going to be an rc4 then I'd love to have these
>> included.
>> ----------------------------------------------------------------
>
> Nope, sorry. rc4 has technically not been tagged yet, but especially
> the serial-property stuff is too big a code change at this point
> (it includes one "let's just refactor and rearrange some code"
> patch which is really not rc4 material.)
> Also these patches have been on the list for over a month -- if
> they were 5.0-worthy there's been plenty of time for them to be
> put in.
>
> Plus the last email from Alistair on the "target/riscv: Don't set
> write permissions on dirty PTEs" patch thread is a note saying
> it shouldn't be applied, unless I've got confused.

OK, no problem.

>
> thanks
> -- PMM

