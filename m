Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CCCC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 04:43:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E8F520704
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 04:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="JMsLgPnx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8F520704
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1katar-0000SN-0Z
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 23:43:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1katZw-0008Ry-4R
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 23:42:24 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:47004)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1katZt-0006jn-NI
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 23:42:23 -0500
Received: by mail-pg1-x52b.google.com with SMTP id w4so2977407pgg.13
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 20:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=r3YLGzm7snfxXqcurkqYtMnrfBi4+eIbtPBIHL19ksk=;
 b=JMsLgPnxvu5BzI3WurFwRSXdC1FAZMqP2+UdpodA6Q5sksCkfTAVmxJ+QRssqFImrU
 jABGGfujiylxHFzDMyLjKlFOzydV3Wg0YspKKNdiRD86JBnlWv8Rcbye3b6Jr6+DVHKk
 y8W5DovayL/VeDRcReAGawPTxQ3Gckn5chxN3IgrmNz0lHXJB0xCnmAPoHhSY2Zm7nD6
 qCR8D/omYKqNy2y0nm61FRAC39wi+svaeCVNA2VMdG49bkCRRtHGzQIzDSHV2mupSh/T
 d3EeZhPx2GzNSCBhrpoWOQajYfEIH/8p1cjTTQ5Pi1StFT+BSUKBG7UtaNFZp9qWRwmi
 Cf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=r3YLGzm7snfxXqcurkqYtMnrfBi4+eIbtPBIHL19ksk=;
 b=Js44/Mi29tvZqChznR/euU8qtvKMunyRZ9ARpTfuFJ2yjVDBW8kEmE0S0EeDVzdamY
 zwZx+9NgsgZowc4UYRgJeggfphCGHNwAKJoXANTZ4mNx8bvki6tGk1Bsu3CQFsjn2UGV
 Qd9of4URySNRMn9SwH68gW+PCnxyINklo2pjiGcLc/MXHkmBnXRjmNha+CRvlsXNePB1
 2P8NUGJnqlLng6TbwXk700mrlAlEbBsGhu3YWJBFKgr6nto0Yq6SqBPBCugYMLCgfwjV
 kuEGPc6TqijXpCj28RWVXuFm7unGggrhZtWi81Lmb+2gnE2Zfeg5d5lfBJO/Zky1w++V
 BmkA==
X-Gm-Message-State: AOAM533eEWSM+nzSQSg5RV6Vl5eOpYKMvr0/22ZY3SXxUXcdEDdUwfHo
 h0+LTHWsEXXJYodchwpiAx1maQ==
X-Google-Smtp-Source: ABdhPJyXg5zYtGxkmuIrcmMya/9/UiW9vKF04hBpE8fsrQAHdqH9w4wNH3fyl4woCRGgzGT/mz+dRA==
X-Received: by 2002:a17:90a:3fcb:: with SMTP id
 u11mr436398pjm.128.1604637739788; 
 Thu, 05 Nov 2020 20:42:19 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net.
 [76.210.143.223])
 by smtp.gmail.com with ESMTPSA id d22sm12562pgv.87.2020.11.05.20.42.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 20:42:19 -0800 (PST)
Date: Thu, 05 Nov 2020 20:42:19 -0800 (PST)
X-Google-Original-Date: Thu, 05 Nov 2020 19:54:42 PST (-0800)
Subject: Re: Emulation for riscv
In-Reply-To: <CAKmqyKNoUg9f-NdgAoGrq_DuBwWv_ZgusArvOobxEYM1mpzbRA@mail.gmail.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: alistair23@gmail.com
Message-ID: <mhng-5ca93c0e-3134-4384-915f-23c4aed71712@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=palmer@dabbelt.com; helo=mail-pg1-x52b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, moyarrezam@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 22 Oct 2020 17:56:38 PDT (-0700), alistair23@gmail.com wrote:
> On Thu, Oct 22, 2020 at 4:58 PM Moises Arreola <moyarrezam@gmail.com> wrote:
>>
>> Hello everyone, my name is Moses and I'm trying to set up a VM for a risc-v processor, I'm using the Risc-V Getting Started Guide and on the final step I'm getting an error while trying to launch the virtual machine using the cmd:
>
> Hello,
>
> Please don't use the RISC-V Getting Started Guide. Pretty much all of
> the information there is out of date and wrong. Unfortunately we are
> unable to correct it.
>
> The QEMU wiki is a much better place for information:
> https://wiki.qemu.org/Documentation/Platforms/RISCV

Ya, everything at riscv.org is useless.  It's best to stick to the open source
documentation, as when that gets out of date we can at least fix it.  Using a
distro helps a lot here, the wiki describes how to run a handful of popular
ones that were ported to RISC-V early but if your favorite isn't on the list
then it may have its own documentation somewhere else.

>> sudo qemu-system-riscv64 -nographic -machine virt \
>> -kernel linux/arch/riscv/boot/Image -append "root=/dev/vda ro console=ttyS0" \
>> -drive file=busybox,format=raw,id=hd0 \
>> -device virtio-blk-device,drive=hd0
>>
>> But what I get in return is a message telling me that the file I gave wasn't the right one, the actual output is:
>>
>> qemu-system-riscv64: -drive file=busybox,format=raw,id=hd0: A regular file was expected by the 'file' driver, but something else was given
>>
>> And I checked the file busybox with de cmd "file" and got the following :
>> busybox: ELF 64-bit LSB executable, UCB RISC-V, version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-riscv64-lp64d.so.1, for GNU/Linux 4.15.0, stripped
>
> That looks like an ELF, which won't work when attached as a drive.
>
> How are you building this rootFS?
>
> Alistair
>
>>
>> So I was wondering if the error message was related to qemu.
>> Thanks in advance for answering any suggestions are welcome

