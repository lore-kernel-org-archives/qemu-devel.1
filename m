Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E95CC04AB7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 16:19:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 750DB20862
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 16:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 750DB20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50793 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQa9m-0001Wt-KE
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 12:19:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQa5L-0006Ve-Uc
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQa5I-0006Ab-AF
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:15:22 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hQa5I-000664-3J
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:15:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id x64so3486209wmb.5
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 09:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=mHFVRGKNxP6N2QG7Euyckvg/DF1mSDACPj3TCGfbuu4=;
	b=BELn8GS1H3mT9EoPzZEThcl2M0wOG3Y+rhbeqcoY16XKDkpgxwTr/sqYaeg3+z6kFO
	aVgAv1JbpsUQecDFWbObhMM6Y8hRAi+ZHkbZamW+zIIWbKngHHHdSKXBVXGGXfw0MG6L
	SiFI+AhhOZ7gqgqfD1InkUxxfkth+Y4PBIkGmY2vDqItmnTtfTpITjHOZiCfd0HJEsR4
	1+l7GBd1OqmOPFHQTQ2swElxixOzRW0p1NebvwJQBhSuHGBys1DBtM0m2UB8+5V2FG+W
	oto2RhRYhi45Fk+rEY7WAcBY0W3QI9sVGb/qSPtMZAYAGhqpa1RBLCUpTeTWfi1nKswS
	39+Q==
X-Gm-Message-State: APjAAAVxWA7YC4QCvLzhmFgO1ruJGYS39O40ua/pJ+GSM9OfDVMw+sGh
	taE9YOqJh0beeRJcCqLU4gfITPvrE/o=
X-Google-Smtp-Source: APXvYqwmK24rimFfI+tC88xHPjZ5x85yDiskVaUE4FbGZqXi5P0bkhYDsOBir4lid1jh2s0P5HX62g==
X-Received: by 2002:a1c:e916:: with SMTP id q22mr20046886wmc.148.1557850517364;
	Tue, 14 May 2019 09:15:17 -0700 (PDT)
Received: from [192.168.1.43] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id a4sm4093830wmf.45.2019.05.14.09.15.16
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 09:15:16 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190514155301.16123-1-alex.bennee@linaro.org>
	<20190514155301.16123-8-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <7d4041f5-3ef8-4e83-cea3-832afc0195b5@redhat.com>
Date: Tue, 14 May 2019 18:15:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514155301.16123-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [RFC PATCH 07/11] target/arm: add LOG_UNIMP
 messages to arm-semi
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/19 5:52 PM, Alex Bennée wrote:
> Clean-up our unimplemented bits with a proper message.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/arm/arm-semi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
> index 253c66b172a..a3bbef18ef7 100644
> --- a/target/arm/arm-semi.c
> +++ b/target/arm/arm-semi.c
> @@ -28,6 +28,7 @@
>  #include "cpu.h"
>  #include "hw/semihosting/semihost.h"
>  #include "hw/semihosting/console.h"
> +#include "qemu/log.h"
>  #ifdef CONFIG_USER_ONLY
>  #include "qemu.h"
>  
> @@ -366,7 +367,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>              return len - ret;
>          }
>      case TARGET_SYS_READC:
> -       /* XXX: Read from debug console. Not implemented.  */
> +        qemu_log_mask(LOG_UNIMP, "%s: SYS_READC not implemented", __func__);
>          return 0;
>      case TARGET_SYS_ISTTY:
>          GET_ARG(0);
> @@ -400,7 +401,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>              return buf.st_size;
>          }
>      case TARGET_SYS_TMPNAM:
> -        /* XXX: Not implemented.  */
> +        qemu_log_mask(LOG_UNIMP, "%s: SYS_TMPNAM not implemented", __func__);
>          return -1;
>      case TARGET_SYS_REMOVE:
>          GET_ARG(0);
> 

