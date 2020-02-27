Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71465C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:33:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C15D2469D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M8iV+GY0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C15D2469D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7JHv-0006xf-EK
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 08:33:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33674)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7JGG-0004zo-Ml
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:31:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7JGF-0006h2-Ib
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:31:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31987
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7JGF-0006gx-EY
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:31:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582810290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zhtu/CiTrf8+XY7umgJTohHMTw/mnHbl8+T315nQ0Ss=;
 b=M8iV+GY0paun8Dxhgn7zOhrt0OZLByYa5idpezeLVYqPxhRXaFH0WyJZhHHIbjF+CcA2lM
 BFRqn0Hsr2whV96lL0W3EN7otP5jyHsUEfADjKBMi0fqmuV0XpObf0M32i08U1vbOuJOIP
 KoKPIHEuOp/y2d+alhb10TVrK0vJ8rg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-B-xb7wOWOpyjH3ftDAxsrQ-1; Thu, 27 Feb 2020 08:31:29 -0500
X-MC-Unique: B-xb7wOWOpyjH3ftDAxsrQ-1
Received: by mail-wm1-f69.google.com with SMTP id t17so701232wmi.7
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 05:31:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zhtu/CiTrf8+XY7umgJTohHMTw/mnHbl8+T315nQ0Ss=;
 b=fVG4B6B1XDjWkpSyK2MHRJGfVBG65BNJ9702GT2IZQLSWyy17H4ic9edbHLUlL6ZhN
 wVOEZO+TQCsy0XFe+hysn7dTy64c2YGfX8UO3nURU4rSvidz2rWMWl3Oqk/fl00c54f8
 dYf3+ZR89UZR/5x61jcqMVlZZwJfmDT5duiioFkC2QwnfRxsrK/tAzqwdRCjRRFRqiSe
 Hil45K+0tUNYVcop1TPPocRAnpeX5pEuPXvI+jC0omA4t4ZbqKjbDJ2L5hJvxkxdhI8k
 nDIwCfciysFG4IGkp7AzBXXs99SExDvohLnVUTjo1Uo/SxlVVhT3Vvvuk4OU5armI5uf
 dAOQ==
X-Gm-Message-State: APjAAAVZguTpy8QmBcRiYdh56mQ0t0n53i6vO5T9sqskhtp+ERSUqMad
 632TmfUbASRnJfl44cWUKHMww3SKqZJo9I8ERmC7yfZWgRnZh69asWXEDF3iXJeQzDw4MeEMoad
 5qbfEabAINp2WIFg=
X-Received: by 2002:a5d:628e:: with SMTP id k14mr4706063wru.425.1582810287164; 
 Thu, 27 Feb 2020 05:31:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqx2AkFrT5UP3pJovZ7jcGIWRP6plQ5aGE7YzdWeBK3KtEeMUxBc40jVe7WNbNUNyFXjdxKqoQ==
X-Received: by 2002:a5d:628e:: with SMTP id k14mr4705994wru.425.1582810285986; 
 Thu, 27 Feb 2020 05:31:25 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id a7sm7189589wmj.12.2020.02.27.05.31.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 05:31:24 -0800 (PST)
Subject: Re: [PATCH v2 2/2] hw/arm/armv7m: Downgrade CPU reset handler priority
To: Stephanos Ioannidis <root@stephanos.io>,
 Alistair Francis <alistair@alistair23.me>
References: <20200227115005.66349-1-root@stephanos.io>
 <20200227115005.66349-3-root@stephanos.io>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <88ad7129-9654-088d-6569-066949973a86@redhat.com>
Date: Thu, 27 Feb 2020 14:31:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200227115005.66349-3-root@stephanos.io>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stephanos,

On 2/27/20 12:51 PM, Stephanos Ioannidis wrote:
> The ARMv7-M CPU reset handler, which loads the initial SP and PC
> register values from the vector table, is currently executed before
> the ROM reset handler (rom_reset), and this causes the devices that
> alias low memory region (e.g. STM32F405 that aliases the flash memory
> located at 0x8000000 to 0x0) to load an invalid reset vector of 0 when
> the kernel image is linked to be loaded at the high memory address.

So we have armv7m_load_kernel -> load_elf_as -> rom_add_blob_fixed_as -> 
rom_add_blob -> rom_insert.

arm_cpu_reset is called before rom_reset, rom_ptr is NULL, we call 
initial_pc = ldl_phys(cpu_as) from an empty flash.

Then later rom_reset -> address_space_write_rom.

I think Alistair and myself use the 'loader' device with Cortex-M boards 
and never hit this problem.

> 
> For instance, it is norm for the STM32F405 firmware ELF image to have
> the text and rodata sections linked at 0x8000000, as this facilitates
> proper image loading by the firmware burning utility, and the processor
> can execute in place from the high flash memory address region as well.
> 
> In order to resolve this issue, this commit downgrades the ARMCPU reset
> handler invocation priority level to -1 such that it is always executed
> after the ROM reset handler, which has a priority level of 0.
> 
> Signed-off-by: Stephanos Ioannidis <root@stephanos.io>
> ---
>   hw/arm/armv7m.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
> index 7531b97ccd..8b7c4b12a6 100644
> --- a/hw/arm/armv7m.c
> +++ b/hw/arm/armv7m.c
> @@ -352,7 +352,8 @@ void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size)
>        * way A-profile does it. Note that this means that every M profile
>        * board must call this function!
>        */
> -    qemu_register_reset(armv7m_reset, cpu);
> +    qemu_register_reset_with_priority(
> +        QEMU_RESET_PRIORITY_LEVEL(-1), armv7m_reset, cpu);
>   }
>   
>   static Property bitband_properties[] = {
> 


