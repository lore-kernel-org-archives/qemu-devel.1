Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FA7C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 10:53:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC2B72070D
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 10:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC2B72070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51937 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRE1F-0006sq-TV
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 06:53:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRDzr-0005uW-G6
	for qemu-devel@nongnu.org; Thu, 16 May 2019 06:52:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRDwE-0005JQ-22
	for qemu-devel@nongnu.org; Thu, 16 May 2019 06:48:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hRDwD-0005I2-S8
	for qemu-devel@nongnu.org; Thu, 16 May 2019 06:48:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id r7so2781074wrr.13
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 03:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=EL5XeZ6ZEjOu0qnM3/aAyABVy9SsjXOZjQ3nQ8HNn7s=;
	b=LmQtszi3iTPaQKdRgCIuCPaQytsoWR6esngTY9g1v+XdxXxKCr4wPNcb3dcpM6YBDd
	b3wGF2q8dsFh3I8JE9pB+veFROtfMUDVXhvLKuFi092RIwdvpqeVncbRmH8lS3RDIq1t
	dd8qnWOGxrIW6SkHByBd0PqxopnfS8JVWRD3ISUbby2D5fZWfnCIQynqcEupTZ4qiALK
	Ce1ll6ydO3DvL6LrZtQerlyK0Fz1S2SqNklPCl2/QlppGT1TddauK7FmnXMdbzXnh6E9
	3zz4HyhG408yzboypu9D2wDBq0BjTAHZtJ8XFUuLm6B2hMqC+RjhZouWoUmeQrTSP6FV
	EpCg==
X-Gm-Message-State: APjAAAWZgYatQR6c+Bi6Cfn/hsaSpiiWU/lv3SlupD8Tsd1SoPo7nxz/
	6NQ0WGesM2zeJhFg8Exq5swCJw==
X-Google-Smtp-Source: APXvYqwc8zDiDFrVPtMlrnhlFR/WRYIsD600YbpfwuVRy6pYn3/3qXiFVJWSIe/+QeG5ZYGlM96F0g==
X-Received: by 2002:adf:df8f:: with SMTP id z15mr25905376wrl.140.1558003715785;
	Thu, 16 May 2019 03:48:35 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228])
	by smtp.gmail.com with ESMTPSA id a4sm6414078wmf.45.2019.05.16.03.48.34
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 03:48:34 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190516055244.95559-1-ysato@users.sourceforge.jp>
	<20190516055244.95559-10-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <b7552dcd-0962-d257-d521-d5dfd6a47bb4@redhat.com>
Date: Thu, 16 May 2019 12:48:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516055244.95559-10-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v13 09/12] Add rx-softmmu
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
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Using only CONFIG_RX=y:

Richard: Can you drop the previous "Using only CONFIG_RX=y" line?
It was related to an older series. Thanks!

> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

One S-o-b is enough ;) I'm not asking you to respin this series however!

> ---
>  configure                      | 8 ++++++++
>  default-configs/rx-softmmu.mak | 3 +++
>  include/sysemu/arch_init.h     | 1 +
>  arch_init.c                    | 2 ++
>  hw/Kconfig                     | 1 +
>  5 files changed, 15 insertions(+)
>  create mode 100644 default-configs/rx-softmmu.mak
> 
> diff --git a/configure b/configure
> index 8999698bc2..28782762dd 100755
> --- a/configure
> +++ b/configure
> @@ -7547,6 +7547,11 @@ case "$target_name" in
>      gdb_xml_files="riscv-64bit-cpu.xml riscv-64bit-fpu.xml riscv-64bit-csr.xml"
>      target_compiler=$cross_cc_riscv64
>    ;;
> +  rx)
> +    TARGET_ARCH=rx
> +    bflt="yes"
> +    target_compiler=$cross_cc_rx
> +  ;;
>    sh4|sh4eb)
>      TARGET_ARCH=sh4
>      bflt="yes"
> @@ -7767,6 +7772,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
>    riscv*)
>      disas_config "RISCV"
>    ;;
> +  rx)
> +    disas_config "RX"
> +  ;;
>    s390*)
>      disas_config "S390"
>    ;;
> diff --git a/default-configs/rx-softmmu.mak b/default-configs/rx-softmmu.mak
> new file mode 100644
> index 0000000000..a3eecefb11
> --- /dev/null
> +++ b/default-configs/rx-softmmu.mak
> @@ -0,0 +1,3 @@
> +# Default configuration for rx-softmmu
> +
> +CONFIG_RX_VIRT=y
> diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
> index 10cbafe970..3f4f844f7b 100644
> --- a/include/sysemu/arch_init.h
> +++ b/include/sysemu/arch_init.h
> @@ -25,6 +25,7 @@ enum {
>      QEMU_ARCH_NIOS2 = (1 << 17),
>      QEMU_ARCH_HPPA = (1 << 18),
>      QEMU_ARCH_RISCV = (1 << 19),
> +    QEMU_ARCH_RX = (1 << 20),
>  };
>  
>  extern const uint32_t arch_type;
> diff --git a/arch_init.c b/arch_init.c
> index f4f3f610c8..cc25ddd7ca 100644
> --- a/arch_init.c
> +++ b/arch_init.c
> @@ -74,6 +74,8 @@ int graphic_depth = 32;
>  #define QEMU_ARCH QEMU_ARCH_PPC
>  #elif defined(TARGET_RISCV)
>  #define QEMU_ARCH QEMU_ARCH_RISCV
> +#elif defined(TARGET_RX)
> +#define QEMU_ARCH QEMU_ARCH_RX
>  #elif defined(TARGET_S390X)
>  #define QEMU_ARCH QEMU_ARCH_S390X
>  #elif defined(TARGET_SH4)
> diff --git a/hw/Kconfig b/hw/Kconfig
> index 88b9f15007..63a071092e 100644
> --- a/hw/Kconfig
> +++ b/hw/Kconfig
> @@ -53,6 +53,7 @@ source nios2/Kconfig
>  source openrisc/Kconfig
>  source ppc/Kconfig
>  source riscv/Kconfig
> +source rx/Kconfig
>  source s390x/Kconfig
>  source sh4/Kconfig
>  source sparc/Kconfig
> 

