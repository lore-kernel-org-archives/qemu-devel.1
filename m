Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AE3C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 16:04:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8C4020989
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 16:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C4020989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39756 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOP3P-00058g-Jp
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 12:04:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOP0K-0002p4-8U
	for qemu-devel@nongnu.org; Wed, 08 May 2019 12:01:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOP0J-00048Y-2u
	for qemu-devel@nongnu.org; Wed, 08 May 2019 12:01:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42802)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hOP0I-00045D-Ss
	for qemu-devel@nongnu.org; Wed, 08 May 2019 12:01:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id l2so27924831wrb.9
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 09:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=EAXN85iWcSvVugmH9SjMJiZ9BMA/+q4OTtXbeK8SdLo=;
	b=WbKizP9kycJ3LgbSCHnsKjgqNqO40Tz3DQMj2wXRhOl4AuGw/8cJmzitkMXlUvK1uE
	NdudjD0XXtKGaeaTRM4i0Qtv1V0CnEE/Ypg/+b4G+pKRPPT7WdjIzj7Utw/1JFGerB2F
	YMz/283pXzPF07ovcGC9pGLtLWL2hTzHObv1va8EN+AYaysyd3UW6+OEA3bjXHu90l0X
	937k1mtfP/Bg1fcteDiJxp2BcnimolHgzKXOYlXf2xOJpdDfd8h6ICxhFUoz7iwpZCVi
	ZLH3bw/Dx/A4ns+Js1wac5zLyEWY1okd//QZVCYv7af+csiG8HtZBG6X4+YYjw+aPNty
	u1PA==
X-Gm-Message-State: APjAAAVAYwhZjfz1uPpUbb5W+MTrmBi1ASJ4V1UHkEwdVJ2kTdp3I4f3
	eXL9BYTta3g2a9m8sCq17mW9xA==
X-Google-Smtp-Source: APXvYqwrfKKoVvqPz4emaEfybqslsdFYb5aeb50sOSbF7HobJGWhmFd13JsKUjt5juPWuoAnfPSSAA==
X-Received: by 2002:adf:eb0c:: with SMTP id s12mr26449807wrn.229.1557331269743;
	Wed, 08 May 2019 09:01:09 -0700 (PDT)
Received: from [10.201.33.53] ([195.166.127.210])
	by smtp.gmail.com with ESMTPSA id
	a125sm4547710wmc.47.2019.05.08.09.01.08
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 09:01:09 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190508145611.107133-1-ysato@users.sourceforge.jp>
	<20190508145611.107133-11-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <9f4a80c6-5115-c11c-f257-cf8f344c9ae3@redhat.com>
Date: Wed, 8 May 2019 18:01:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508145611.107133-11-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v10 10/13] Add rx-softmmu
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

On 5/8/19 4:56 PM, Yoshinori Sato wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  configure                      | 8 ++++++++
>  default-configs/rx-softmmu.mak | 7 +++++++
>  include/sysemu/arch_init.h     | 1 +
>  arch_init.c                    | 2 ++
>  hw/Kconfig                     | 1 +
>  5 files changed, 19 insertions(+)
>  create mode 100644 default-configs/rx-softmmu.mak
> 
> diff --git a/configure b/configure
> index 5b183c2e39..40132c5391 100755
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
> index 0000000000..3f62f04e9b
> --- /dev/null
> +++ b/default-configs/rx-softmmu.mak
> @@ -0,0 +1,7 @@
> +# Default configuration for rx-softmmu
> +
> +CONFIG_SERIAL=y
> +CONFIG_RX=y
> +CONFIG_RENESAS_SCI=y
> +CONFIG_RENESAS_TMR=y
> +CONFIG_RENESAS_CMT=y

See previous patch comments, you should only use CONFIG_RX=y here.

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Using only CONFIG_RX=y:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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

