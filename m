Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE81C433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 21:32:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A16820708
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 21:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWt9HlpU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A16820708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsCFR-0002Rh-Nr
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 17:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsCE1-0001GD-3O
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 17:31:01 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36606)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsCDz-0008JW-C9
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 17:31:00 -0400
Received: by mail-wr1-x442.google.com with SMTP id k6so38842607wrn.3
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2020 14:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JQM8AK5k5Mip6gDTriExAQgMfv03R4iIq87pBAy5fas=;
 b=GWt9HlpUAHuDcD8hppjkUURxC4OvYru8nhNGap1zuegPDltjNrveqBCyEIhH18J43W
 3s85qn7KBfi2TzYMnKuSw3ywR8YJO6DBKwcDzbP6LdPuPkIhPgcQygtOO6sqYz1mUjBw
 oZCyMHYijHpostngkPDYrGsQ8mwlVYUloT1JNbnSdRpFCftC8i7PuCfoKDGDIfKKbuuP
 IBPx7W56qkkQu8QmZ0EvCHtG886vWHJw4uL5pQjOhvhBIPA8m+sr6lhhIccZiUEr7C2G
 /lki5OhcO6LeN/R1wIJRm98qETACOSvbvCMg8Rl2IUcpfdas2J2S/nCOJrcSDuKvh6kF
 2gDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JQM8AK5k5Mip6gDTriExAQgMfv03R4iIq87pBAy5fas=;
 b=RJXFw3HPtMlW2kRiX7Sne8NDIErsdEXvbQtuRLTs/G+ZYniETFQDCtLR8DCBEn6oSe
 gTr8/2bJxJOJmrCYBdBlj8dEb9IC+faUmJN1K+DXk0b6WlBYQmBBRDRB3IKeb2cGSpLi
 xwE2zsFtlIl1B8XMA9SC/R3GV1nMgtJYijYGjAfcpgR+9w+SxMl2nryxbsm0rN8ZjGE7
 7J43Eb8+El9KQ6bEb2NVikLkKm/B6/l1bGZNHpPNiY2ZLP3G+jEb253e6Aa4diGYk1Z4
 351v+jWr4WNwKLiKOOb95jagqpH0BRcS2931dS01PwXm3LyyJVldtKpNuustpjsLHwXG
 z1Xw==
X-Gm-Message-State: AOAM531d2TV2fQp0Fqx8q8qiFYrKPNq+19QYUyhtTHHYbu1Z6LQ/Iw6d
 x7g8YiJ27SWISnTChwDj660=
X-Google-Smtp-Source: ABdhPJzAVGZbW/cjWKKbuDr8c1llFfzZwX9nCczdsJJ4YTCprHbGO2UuRoPweiWud0KWJG+WfTqVTg==
X-Received: by 2002:a5d:6cce:: with SMTP id c14mr43710958wrc.377.1593984657930; 
 Sun, 05 Jul 2020 14:30:57 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id c194sm8738178wme.8.2020.07.05.14.30.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Jul 2020 14:30:57 -0700 (PDT)
Subject: Re: [PATCH rc6 26/30] target/avr: Update build system
To: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org,
 Michael Rolnik <mrolnik@gmail.com>, Richard Henderson <rth@twiddle.net>
References: <20200705140315.260514-1-huth@tuxfamily.org>
 <20200705140315.260514-27-huth@tuxfamily.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3861d3c6-74a8-be30-27b4-e8e5edc3500e@amsat.org>
Date: Sun, 5 Jul 2020 23:30:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200705140315.260514-27-huth@tuxfamily.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/5/20 4:03 PM, Thomas Huth wrote:
> From: Michael Rolnik <mrolnik@gmail.com>
> 
> Make AVR support buildable.
> 
> [AM: Remove word 'Atmel' from filenames and all elements of code]
> Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Thomas Huth <huth@tuxfamily.org>
> ---
>  MAINTAINERS                     |  1 +
>  configure                       |  7 +++++++
>  default-configs/avr-softmmu.mak |  5 +++++
>  target/avr/Makefile.objs        | 34 +++++++++++++++++++++++++++++++++
>  4 files changed, 47 insertions(+)
>  create mode 100644 default-configs/avr-softmmu.mak
>  create mode 100644 target/avr/Makefile.objs

IMO this belongs to patch #22 "target/avr: Register AVR support with the
rest of QEMU". Trivial conflict in MAINTAINERS while squashing.

> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0ab0a0e40b..79e7470f5c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -982,6 +982,7 @@ AVR MCUs
>  M: Michael Rolnik <mrolnik@gmail.com>
>  R: Sarah Harris <S.E.Harris@kent.ac.uk>
>  S: Maintained
> +F: default-configs/avr-softmmu.mak
>  F: hw/avr/
>  F: include/hw/char/avr_usart.h
>  F: hw/char/avr_usart.c
> diff --git a/configure b/configure
> index 8a65240d4a..e84b532bf5 100755
> --- a/configure
> +++ b/configure
> @@ -8105,6 +8105,10 @@ case "$target_name" in
>      mttcg="yes"
>      gdb_xml_files="aarch64-core.xml aarch64-fpu.xml arm-core.xml arm-vfp.xml arm-vfp3.xml arm-neon.xml arm-m-profile.xml"
>    ;;
> +  avr)
> +    gdb_xml_files="avr-cpu.xml"
> +    target_compiler=$cross_cc_avr
> +  ;;
>    cris)
>    ;;
>    hppa)
> @@ -8349,6 +8353,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
>        disas_config "ARM_A64"
>      fi
>    ;;
> +  avr)
> +    disas_config "AVR"
> +  ;;
>    cris)
>      disas_config "CRIS"
>    ;;
> diff --git a/default-configs/avr-softmmu.mak b/default-configs/avr-softmmu.mak
> new file mode 100644
> index 0000000000..80218add98
> --- /dev/null
> +++ b/default-configs/avr-softmmu.mak
> @@ -0,0 +1,5 @@
> +# Default configuration for avr-softmmu
> +
> +# Boards:
> +#
> +CONFIG_ARDUINO=y
> diff --git a/target/avr/Makefile.objs b/target/avr/Makefile.objs
> new file mode 100644
> index 0000000000..7523e0c6e2
> --- /dev/null
> +++ b/target/avr/Makefile.objs
> @@ -0,0 +1,34 @@
> +#
> +#  QEMU AVR CPU
> +#
> +#  Copyright (c) 2019 Michael Rolnik
> +#
> +#  This library is free software; you can redistribute it and/or
> +#  modify it under the terms of the GNU Lesser General Public
> +#  License as published by the Free Software Foundation; either
> +#  version 2.1 of the License, or (at your option) any later version.
> +#
> +#  This library is distributed in the hope that it will be useful,
> +#  but WITHOUT ANY WARRANTY; without even the implied warranty of
> +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> +#  Lesser General Public License for more details.
> +#
> +#  You should have received a copy of the GNU Lesser General Public
> +#  License along with this library; if not, see
> +#  <http://www.gnu.org/licenses/lgpl-2.1.html>
> +#
> +
> +DECODETREE = $(SRC_PATH)/scripts/decodetree.py
> +decode-y = $(SRC_PATH)/target/avr/insn.decode
> +
> +target/avr/decode_insn.inc.c: $(decode-y) $(DECODETREE)
> +	$(call quiet-command, \
> +	  $(PYTHON) $(DECODETREE) -o $@ --decode decode_insn --insnwidth 16 $<, \
> +	  "GEN", $(TARGET_DIR)$@)
> +
> +target/avr/translate.o: target/avr/decode_insn.inc.c
> +
> +obj-y += translate.o cpu.o helper.o
> +obj-y += gdbstub.o
> +obj-y += disas.o
> +obj-$(CONFIG_SOFTMMU) += machine.o
> 

