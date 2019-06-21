Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B688C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 16:24:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73F7E20673
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 16:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73F7E20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36670 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heMKv-0004V0-JA
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 12:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41737)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1heMJe-0003jA-JE
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 12:23:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1heMJd-0002u0-J2
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 12:23:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35198)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1heMJd-0002oL-An
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 12:23:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id m3so7202891wrv.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 09:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3aNvMEr9wnkImNUwjGYiUWh/Dn54oSUD3Wq8cEaKBHk=;
 b=L4bZm7Eo4Cf6dh8IE9IiHohDrhhtM4124OYDGaglF+UgQfQ3MyL1Vg4LAtgLmHHASa
 r1fMRVP9eKmdDPMbby21oY9tBxMwDDIMpHzh+rkHRUFlntmwaWJnVXnhpxxCmgLx5Gce
 PaCxxI3fqXtg8qBRO5Ifbnjs5TYhi+dbIHXcguElB9NAaCmJ7rnhed9htDI4zYIxENc6
 6wK3vrPFfLrb0897fLZrFymlnMvGGC+VQ/rQEK8MLCR29lbbf0b2RaktVJQQ70hQMHNa
 GrgHNBzQB+CewviJY6tIHmGt5bz8EQP51EC3D/uuT0ov8TssQxqlVhPztBsv4bzan/yG
 5lYQ==
X-Gm-Message-State: APjAAAU/B1EVsLUdb8OpMWwYlvtE4C7S4WxswaGwpg8kKbSZ7tMXx3pN
 U5f6Oxa+f0448kfXr0kCMp9Idw==
X-Google-Smtp-Source: APXvYqyJ5nHLR8fNVp63a8SD2PbLl1P3CTvrKRST/Cb571PK8MVt6eVqvYh2hCDjIXd1I9JJvf+oZA==
X-Received: by 2002:adf:ec12:: with SMTP id x18mr64604638wrn.145.1561134183784; 
 Fri, 21 Jun 2019 09:23:03 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id z5sm2478018wmf.48.2019.06.21.09.23.02
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Jun 2019 09:23:02 -0700 (PDT)
To: Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
References: <cover.1560919807.git.alistair@alistair23.me>
 <PSXP216MB02772CA8ED100BB578388BA6DDE50@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <b071bbbe-a657-f7e3-de4b-cb3a448b5e2a@redhat.com>
Date: Fri, 21 Jun 2019 18:23:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <PSXP216MB02772CA8ED100BB578388BA6DDE50@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v3 1/6] armv7m: Allow entry information to
 be returned
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
Cc: "alistair23@gmail.com" <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/19/19 6:53 AM, Alistair Francis wrote:
> Allow the kernel's entry point information to be returned when loading a
> kernel.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/arm/armv7m.c       | 4 +++-
>  include/hw/arm/boot.h | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
> index b9efad6bac..8ee6291a47 100644
> --- a/hw/arm/armv7m.c
> +++ b/hw/arm/armv7m.c
> @@ -304,7 +304,7 @@ static void armv7m_reset(void *opaque)
>      cpu_reset(CPU(cpu));
>  }
>  
> -void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size)
> +uint64_t armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size)
>  {
>      int image_size;
>      uint64_t entry;
> @@ -351,6 +351,8 @@ void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size)
>       * board must call this function!
>       */
>      qemu_register_reset(armv7m_reset, cpu);
> +
> +    return entry;
>  }
>  
>  static Property bitband_properties[] = {
> diff --git a/include/hw/arm/boot.h b/include/hw/arm/boot.h
> index c48cc4c2bc..4e4db0416c 100644
> --- a/include/hw/arm/boot.h
> +++ b/include/hw/arm/boot.h
> @@ -29,11 +29,13 @@ typedef enum {
>   * @kernel_filename: file to load
>   * @mem_size: mem_size: maximum image size to load
>   *
> + * returns: location of the kernel's entry point
> + *
>   * Load the guest image for an ARMv7M system. This must be called by
>   * any ARMv7M board. (This is necessary to ensure that the CPU resets
>   * correctly on system reset, as well as for kernel loading.)
>   */
> -void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size);
> +uint64_t armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size);
>  
>  /* arm_boot.c */
>  struct arm_boot_info {
> 

