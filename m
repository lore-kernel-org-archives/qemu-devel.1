Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D88C3A59E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 14:32:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E22EB20673
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 14:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2lI6F/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22EB20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i05Bs-0003Ic-3k
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 10:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1i05AJ-0002Iy-KR
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:31:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1i05AI-0002qx-EO
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:31:15 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:42508)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1i05AF-0002mw-NA; Tue, 20 Aug 2019 10:31:11 -0400
Received: by mail-pf1-x443.google.com with SMTP id i30so3495391pfk.9;
 Tue, 20 Aug 2019 07:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TjKlcReLpXlh05Iw2h9/M1+xRcBBUqLQ42/Ni8tXUE4=;
 b=F2lI6F/cZRER26JlzzNhSMSLlWa4hkfpA2x2x/ATPMby5dDloMYTFav06T5D+aWU0D
 RNRyLCKDLQgSVMEdoc2wPH16SX/cJAr6RszFJ6zFIgL7rBryHIGt3VzMnSx1f9SZvAND
 fLyP+InrAEkRaQkI14uccmILO5gXL3JizU47Mf2laMjrn86sRR9eHpTiMprumIK13EmJ
 iSWHgpUwyuKHT5L+QY9TwEG3+rpqmlPzDbuwfgFA0W2j044LDSEYCe3FRUbhVjE6bQmJ
 fCJDe3uoQpeYWQxvaOJyAlRsLDptNbqdCXLMVzoz9Ka0t3/q8qYvZiQZ0pqFUN7dm2vP
 tv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TjKlcReLpXlh05Iw2h9/M1+xRcBBUqLQ42/Ni8tXUE4=;
 b=UvjL+l1aF6jGMm9Mcv8HM2Fltr6pK1px3FncB/+Hv2ho95KWmmE2ARNLTuPspQ9/hf
 2+J3dedbKQhGdIhJdKVwdxxqS0lxzV3lzqeO2rO/OOnwu6hmmgKXwpU2TEzU7qKiMC0A
 qgqFb7BL78xE4Dd/2dTI5n38d3xRNLgNVcdYxhNvKb5FYE7wQPtcy/2LdPJ7eINkKk2h
 pUQ8iVb78muGCImWFOhbtMK7XRzlv13gz9sJgXFBuSyph6+pCY9UlxqPWeOGIFJZPULq
 SCPp5W2HVHzzwe31i8OCK32+37mDLtHfw8JufQg7/AGlOmFV3qx782+d2+dc/0QMArMb
 MORw==
X-Gm-Message-State: APjAAAUZUY2/n/xpj+qD69LPTvDhMm8gfkVAumBGCGFE8HTNN+ym5Rov
 AkrJuBhd2iAE885FRL44WbA=
X-Google-Smtp-Source: APXvYqzFnxJKwql/pLpKx2TdUkWS7UE7XTemWxsZYnOjOnisgjcLAD0qccfRw+xe6/ULwEGhCHi4zg==
X-Received: by 2002:aa7:8f2e:: with SMTP id y14mr30446880pfr.113.1566311470241; 
 Tue, 20 Aug 2019 07:31:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 b19sm10936832pgs.10.2019.08.20.07.31.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 20 Aug 2019 07:31:09 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190820123417.27930-1-philmd@redhat.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <3e3fcb30-1e12-eaf4-07a2-47d09aea2511@roeck-us.net>
Date: Tue, 20 Aug 2019 07:31:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820123417.27930-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] hw/char/bcm2835_aux: Provide full
 16550 UART support
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/20/19 5:34 AM, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> Since there has been some activity on the list asking about
> Rasberry PI USB support, I had a look a some previous unfinished
> work and rebased it to share, in case it helps hobbyist interested
> in improving these machines.
> 
> This series is some proof-of-concept on improving the AUX UART
> support. See the commit description for various TODO/questions.
> 
> This can be tested using files documented by Peter Maydell in
> his blog post:
> https://translatedcode.wordpress.com/2018/04/25/debian-on-qemus-raspberry-pi-3-model/
> 
> And using the kernel command line arguments suggested by Guenter Roeck:
> 
> qemu-system-aarch64 -M raspi3 -m 1024 \
>    -kernel raspi3/bootpart/vmlinuz-4.14.0-3-arm64 \
>    -initrd raspi3/bootpart/initrd.img-4.14.0-3-arm64 \
>    -dtb raspi3/bootpart/bcm2837-rpi-3-b.dtb \
>    -append 'earlycon=uart8250,mmio32,0x3f215040 rdinit=/sbin/init panic=-1 console=ttyS1,115200' \
>    -drive file=raspi3/2018-01-08-raspberry-pi-3-buster-PREVIEW.img,format=raw,if=sd \
>    -serial null -serial stdio \
>    -d unimp,guest_errors -trace bcm283\*

[ ... ]

> [    3.123313] Unpacking initramfs...
> 
> Here it hangs, even with CPRMAN patch from Guenter:
> https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg03153.html
> 

This command line works for me:

qemu-system-aarch64 -M raspi3 -kernel arch/arm64/boot/Image -no-reboot \
	-nographic -snapshot -smp 4 -m 1G \
	-drive file=rootfs.ext2,format=raw,if=sd \
	-serial null -serial stdio -monitor none -no-reboot \
	--append 'panic=-1 slub_debug=FZPUA root=/dev/mmcblk0 rootwait earlycon=uart8250,mmio32,0x3f215040 console=ttyS1,115200' \
	-dtb arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dtb

or, with initrd:

qemu-system-aarch64 -M raspi3 -kernel arch/arm64/boot/Image -no-reboot \
	-nographic \
	-initrd rootfs.cpio \
	-m 1G -serial null -serial stdio -monitor none -no-reboot \
	--append 'panic=-1 slub_debug=FZPUA rdinit=/sbin/init earlycon=uart8250,mmio32,0x3f215040 console=ttyS1,115200' \
	-dtb arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dtb

This is with the mainline kernel.

I don't see a significant difference to your patch series.

I tested with qemu 4.0, 4.1, and mainline (with my patch series applied on top of each).
One problem I do see is that booting mainline (as of right now) is _slow_ compared
to released versions of qemu. It takes some 35 seconds to get to "Unpacking initramfs",
compared to ~8 seconds for v4.1 and earlier. Otherwise it works.

One possibility might be that your initrd has a problem. Can you boot without your patch
series, or is it always stuck ?

Thanks,
Guenter

