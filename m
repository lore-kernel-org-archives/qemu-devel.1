Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2741C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 13:20:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9809620818
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 13:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9809620818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56808 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRGJH-00008M-S0
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 09:20:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRGGA-0006uN-JC
	for qemu-devel@nongnu.org; Thu, 16 May 2019 09:17:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRGG7-0006ID-Ij
	for qemu-devel@nongnu.org; Thu, 16 May 2019 09:17:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hRGG7-0006HP-Dl
	for qemu-devel@nongnu.org; Thu, 16 May 2019 09:17:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id s17so3402642wru.3
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 06:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=iHWMjzB0bghySYRBS19KMrKpotaAEq1EEQ+JesJxvgc=;
	b=Bg48VRhzv0z55ITG7btvvhnuTeJrQ/qKCehKjVjYY80hbOvtWyQZ0bUbvPiRHBAN/8
	5c9YJw39oeiOpX4o0RL2F/vph1IWrE9Vuq4uXU1jpqSAzTBcTL5MlNXqQI4mBhN+MsBY
	8/+SepNhO8dq7+jWxpuvw31q+Gt57yyQAguqEXb+XfH02gr4AbGJi1qSVwFGuJ5WuPqV
	Y2ydB05Xu/wz+dG0qUlPMJMUo1sZEPQpUIVAkcRgbXSyQwF93YXGc0PzJMD967B9IZcb
	IPBE/Bdei5w2YV1BQJbFeOllnSJI1v/bygV6cR2389dTKboTWZ+TI8Sp6doJo7oeNdNt
	TQPQ==
X-Gm-Message-State: APjAAAW2BFkBA4PNtdxhxQOG9b7GyVrunBzIiL4boXT04WLZNszPMvcz
	vpQgXgKQry1gmIQ93drJWzkJIQ==
X-Google-Smtp-Source: APXvYqwwZNqXMi8UM4JbwKlwCoNvoTL3veVtsDt8RAckcnvOoqBfUiqJfxA66a12oF6hfocCzfgYeA==
X-Received: by 2002:a5d:4fd2:: with SMTP id h18mr5683134wrw.117.1558012638399; 
	Thu, 16 May 2019 06:17:18 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	j82sm7145340wmj.40.2019.05.16.06.17.17
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 06:17:17 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190516055244.95559-1-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <ecbbd813-abef-2f45-f957-610049377a44@redhat.com>
Date: Thu, 16 May 2019 15:17:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516055244.95559-1-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v13 00/12] Add RX archtecture support
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

On 5/16/19 7:52 AM, Yoshinori Sato wrote:
> Hello.
> This patch series is added Renesas RX target emulation.
> 
> Add "Reviewed-by" for all changes.
> 
> My git repository is bellow.
> git://git.pf.osdn.net/gitroot/y/ys/ysato/qemu.git tags/rx-20190514
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
> Changes for v12.
> - None
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
>   Add rx-softmmu
>   hw/registerfields.h: Add 8bit and 16bit register macros.
>   qemu/bitops.h: Add extract8 and extract16
>   MAINTAINERS: Add RX

Series:
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>


