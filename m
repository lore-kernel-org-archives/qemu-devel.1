Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3861FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 20:20:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3DA02071E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 20:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zrc0u3lk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3DA02071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv5RW-00018u-6P
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 15:20:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40229)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iv5Qc-0000ST-1i
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:19:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iv5Qb-0007jJ-1D
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:19:41 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46279)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iv5Qa-0007gf-QZ
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:19:40 -0500
Received: by mail-pg1-x542.google.com with SMTP id z124so1663470pgb.13
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 12:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hsseL/fG40ncZ8GxkywyzPPyNw4QEP0gpWO1eTZ9QQk=;
 b=Zrc0u3lkbi4jNnSBsSRPl28ZcNFTmFncatazh0zFTjfO8PZExFyQHZjB8nW5wZla/u
 clSutqDqO/m7h8DoPF9I5eXX1dfvCLYxcB/42yIFJvaQtFET/9XO59X8fhte4KHTQU72
 6I7dKuRpLrFV9PF1v042mhNIIc1aGqMcCiQaB7qOJGXp+srI6zCOoUOvslXQU10Lgktk
 2m9g6KFe74WSODj+kIt/gOizIKQtpbFCAZdg8aWszcwDzK3gg9p13juwQQiNVRbNxPWW
 GfoBSCi0+GdSBihjeCSDz7n8VWrPkIQOHxQL3lzWxBfPwGEBlVMvJykmyNG4SbJLE92c
 Cs0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hsseL/fG40ncZ8GxkywyzPPyNw4QEP0gpWO1eTZ9QQk=;
 b=ZAtCQmsOvIr/TLLHFfJms4YcGpaj6oFk3dGzNgKlAUZGAlCZ/DTqvCteldjk8S1SFA
 r1C52t67o12U+a1kam6JCl8Lpwsb7QaQapWOx4F8ZeH1z1+XiykFlnz94+eAWjj8foNu
 pF6bdoV3Iwr/Up/cok7jhOc/P2ks0PRQQYldL/f/aaDt0WSExYELlFtgxEf+e0rA+C0D
 KCTsTOVFIqkNhlgaKNKRsXCYpWO2uB8dxQNPi2oW3iFg68Yw4ZKweUhx3fc3IZklqZqF
 aeLkAzbuiHOQ70zw6XbbNSI2BDcIfym1HczYzw/yufUFNwVYx8Gs8liKL3tRGF1OKGUK
 K6wg==
X-Gm-Message-State: APjAAAUbSsqLXK+3DzHfE+7kjshirJICkdgYW1AIA+4pCwuZNnFdGbGd
 WHV8bvIaI3aqSZ6XRx0LvSSGI0xXshg=
X-Google-Smtp-Source: APXvYqxDKXWCvLqq1y+7UxuIgYfg8Ij4aMR+lhZUGLovaWY1SEGA75gQogEyoAdI4ZsJpc6DMI7mdA==
X-Received: by 2002:a63:6704:: with SMTP id b4mr6231910pgc.424.1579897179031; 
 Fri, 24 Jan 2020 12:19:39 -0800 (PST)
Received: from [10.5.50.117] (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id l1sm2806647pjb.28.2020.01.24.12.19.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2020 12:19:38 -0800 (PST)
Subject: Re: Booting Debian in qemu-system-alpha
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 debian-alpha@lists.debian.org
References: <b71832b2-8b2e-a49b-1bf9-6590056bbdbe@physik.fu-berlin.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f3843562-cd89-d1b1-19ed-6ae505a94148@linaro.org>
Date: Fri, 24 Jan 2020 10:19:35 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b71832b2-8b2e-a49b-1bf9-6590056bbdbe@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/24/20 6:16 AM, John Paul Adrian Glaubitz wrote:
> Hi!
> 
> Has anyone had any success recently booting Debian on qemu-system-alpha?
> 
> I just built qemu-system using the alpha-softmmu target from git and tried
> to run Debian's Alpha port but the output hangs very early:
> 
> root@nofan:/local_scratch/alpha-system> ./qemu-system-alpha -m 512 -nographic -drive file=disk.img,media=disk,format=raw,index=0 -L pc-bios/ -kernel vmlinux -append ‘console=ttyS0’ -initrd initrd.gz -net nic -net user -drive file=debian-10.0-alpha-NETINST-1.iso,if=ide,media=cdrom
> PCI: 00:00:0 class 0300 id 1013:00b8
> PCI:   region 0: 10000000
> PCI:   region 1: 12000000
> PCI: 00:01:0 class 0200 id 8086:100e
> PCI:   region 0: 12020000
> PCI:   region 1: 0000c000
> PCI: 00:02:0 class 0101 id 1095:0646
> PCI:   region 0: 0000c040
> PCI:   region 1: 0000c048
> PCI:   region 3: 0000c04c

Works for me, from this morning's git (ba2ed84fe6a7).  I certainly get all the
way to the "Select a language" screen of the installer.

Oh.  Hah!  I just tried again, cutting and pasting your command-line.  You've
got unicode quotes, not ascii ' (\x27).  That gets passed through to the kernel
as-is and prevents console=ttyS0 from being parsed properly.

So the kernel output simply isn't going where you thought, and in this case,
nowhere at all.


r~

