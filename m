Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF63C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 06:45:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3956024BA4
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 06:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3956024BA4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46760 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY3C0-0003ml-EL
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 02:45:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hY3AM-0002qG-QO
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 02:43:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hY35j-0006v3-5i
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 02:38:40 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hY35i-0006iI-TV
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 02:38:39 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so6200573wms.2
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 23:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=A7Ii10XbzUbNNfivjS0mvdNKtJDuK6ZemMPpi7au3Ms=;
	b=XR81F/eRyL3MfWfja7TvrsT3EdgrIgLItbB6ZuPqcDMDDUw9ZwhiDEdLGLZzT+F7Cv
	h2MHBjh0bSBRXIGhniEmqyc4AJAP3WYQFnqrlBDXON6B9IE87RYZ05kbznEuVb29cZfz
	jUalSeCsmHkTQ3L4J7SlI74xgh9c0G8CPX1SrF6KbvYuHx8r47qRawPSEE+PTJERP3ED
	5De4TuChIuxZ1M82Ky4HdcH+efrbA4hFpROuJ2ELMvTCTKIKKW6XyOTI5ovb63d2hY3C
	NYB0S8Kv+JXsWxiPqN1v7zF9FPIaIAmdqkuL4kAJQGwQDqsu1Vjw+KnJat35cEd9CFl2
	14ew==
X-Gm-Message-State: APjAAAWvMcXB9utohLNTzh1veA7qMtacAQwTsNz+o/o+QvN7VdaKsFxr
	FVx/UaNnQOTiDQkPS20XLODiZg==
X-Google-Smtp-Source: APXvYqzoU2FssW62+1xYkOQKrfqCAsttVb90O8qgAuwc126qa3GcSey2SY1wN6u9aNm87Ht/zGPOSg==
X-Received: by 2002:a1c:9d86:: with SMTP id g128mr5230789wme.51.1559630317463; 
	Mon, 03 Jun 2019 23:38:37 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
	[88.21.202.183])
	by smtp.gmail.com with ESMTPSA id b2sm3676649wrp.72.2019.06.03.23.38.36
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 23:38:36 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190531134315.4109-1-richard.henderson@linaro.org>
	<20190531134315.4109-17-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1c0e8496-6005-f875-a7ee-5913a485fd08@redhat.com>
Date: Tue, 4 Jun 2019 08:38:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531134315.4109-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v16 16/23] Add rx-softmmu
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
Cc: ysato@users.sourceforge.jp
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Richard,

On 5/31/19 3:43 PM, Richard Henderson wrote:
> From: Yoshinori Sato <ysato@users.sourceforge.jp>
> 
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> Message-Id: <20190516055244.95559-10-ysato@users.sourceforge.jp>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/sysemu/arch_init.h     | 1 +
>  arch_init.c                    | 2 ++
>  configure                      | 8 ++++++++
>  default-configs/rx-softmmu.mak | 3 +++
>  hw/Kconfig                     | 1 +
>  5 files changed, 15 insertions(+)
>  create mode 100644 default-configs/rx-softmmu.mak
> 
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
> diff --git a/configure b/configure
> index 6cdcfb2dc3..7e5477e487 100755
> --- a/configure
> +++ b/configure
> @@ -7605,6 +7605,11 @@ case "$target_name" in
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
> @@ -7825,6 +7830,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
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

Thanks!

Phil.

