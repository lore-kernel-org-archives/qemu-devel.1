Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F44C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:51:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40D0E207E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D0E207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51314 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZFGx-0006BX-CF
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 09:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41862)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hZFAo-0002Pv-Nx
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hZFAn-0006dP-DH
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:44:50 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51921)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hZFAn-0006bR-4K
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:44:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id f10so2160648wmb.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 06:44:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h7pXsDj1TDs862cd965Vv9Lfimkl4ikd0Xk/EqtijUE=;
 b=WxFyKNq995dfTvj08jIooNuce9F2LRcJqlqAcBbb91fEsHKk+63V5ipMhAY0Sa7Nsn
 tMo3qLBsTxCdp8dgNd3dJMAdlooduvchmCj6AdBgg1QKBYkDaGPBCSycJw9GyKWaIUl5
 O4K4X8npKMEvrhZn0r8QQ6YaNj3lw+yg7F4OoksUL+F4qNvNU3zCnkpGtBKB70fS+75f
 abKcWROJO1SgozOe/k/Yb322tNhvH4KeNSFTejhHXaeDiPxGGLtllgmp8iQhV86daht0
 keu45pdj8M26qImjTLuC8sSNJNDiEwJYAFK2y0FdoEEIMKy0Vi+uG4d4FZeoO6UJI1on
 rxaw==
X-Gm-Message-State: APjAAAUTWfMA7fNcpTfCm1b9Y6PhfvJqwX+zxjwB/JuFnPdBawYqDlE7
 lRKtSkgKUzD/xfWL6hQkM+haeg==
X-Google-Smtp-Source: APXvYqxGUyVhy2MnW0OqIYGBZcxQvfxPK09vJTrr+Y2xE9QCSe3HPjK62M7t6Cy7Y+NEZqW8AGSvGQ==
X-Received: by 2002:a1c:7d4e:: with SMTP id y75mr3791344wmc.169.1559915088058; 
 Fri, 07 Jun 2019 06:44:48 -0700 (PDT)
Received: from [192.168.0.156] ([78.192.181.46])
 by smtp.gmail.com with ESMTPSA id b8sm1863529wrr.88.2019.06.07.06.44.47
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 06:44:47 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190607091116.49044-1-ysato@users.sourceforge.jp>
 <20190607091116.49044-17-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6e4b77b4-f05c-74e8-e128-1555ead951fc@redhat.com>
Date: Fri, 7 Jun 2019 15:44:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190607091116.49044-17-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v17 16/24] Add rx-softmmu
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/7/19 11:11 AM, Yoshinori Sato wrote:
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> Message-Id: <20190516055244.95559-10-ysato@users.sourceforge.jp>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
> index b091b82cb3..d6e16c58c3 100755
> --- a/configure
> +++ b/configure
> @@ -7595,6 +7595,11 @@ case "$target_name" in
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
> @@ -7815,6 +7820,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
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
> index 195f541e50..b0c7221240 100644
> --- a/hw/Kconfig
> +++ b/hw/Kconfig
> @@ -54,6 +54,7 @@ source nios2/Kconfig
>  source openrisc/Kconfig
>  source ppc/Kconfig
>  source riscv/Kconfig
> +source rx/Kconfig
>  source s390x/Kconfig
>  source sh4/Kconfig
>  source sparc/Kconfig
> 

Again:

Please squash in:

-- >8 --
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -26,6 +26,7 @@
 #pragma GCC poison TARGET_PPC
 #pragma GCC poison TARGET_PPC64
 #pragma GCC poison TARGET_ABI32
+#pragma GCC poison TARGET_RX
 #pragma GCC poison TARGET_S390X
 #pragma GCC poison TARGET_SH4
 #pragma GCC poison TARGET_SPARC
---

