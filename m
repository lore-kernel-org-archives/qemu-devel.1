Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A80C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 11:04:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D22CA20857
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 11:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D22CA20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51115 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDS4b-0007iA-NR
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 07:04:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDS30-0006xr-O9
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDS2z-0005ZT-M5
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:02:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44151)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hDS2z-0005YS-D9
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:02:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id y7so219627wrn.11
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 04:02:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=xDtd5G3/ppbBBUwlknM5bTzNhjx08BE7xBreQlVUb8k=;
	b=fTn2vws4d4mofdqGqW0pEAxJotPXKn/LLn6J0n2zrv6llOqcJg6YN4Z9fnYIazSQJa
	XUhOL52dQwRgy53lHV+F0a59hUf4B/oCU3ZpvpmMdtUOjYPvAv0wLxcfLlFWtB0MU/86
	SZ4oiLpcS+G1BJH8kyouklcl3+iJWikKqb2c5j8EiJvhd86al9oE/uV2/lzws3tSylfU
	ij6Ey9uRQBEWhTh7qxWp2BKT5+iPPIZIdFRxZujtrwlg+9EHRZXuKVv7NXPc3kmICVwF
	/zetFbZ4Nqi/kf4wZfOxan3ZoSnOzOzQfutzTTjUSfqfSvHONhTkKFvrvp06HHYBW2sw
	FW7g==
X-Gm-Message-State: APjAAAWs0qqPmGPB/A1yRIvUGMrDpSwaoEO2kLDhWrHNcVCgbLHWK8mn
	U5mhXBBG3mSqlGruHnAt4KVLgQ==
X-Google-Smtp-Source: APXvYqyV0q84rBK6MJGWaJR8fFNcHYw4L1GIkHeDsKzYblOMYuwSC03KtNy55YQ2JIAcCBpNiBbuzA==
X-Received: by 2002:adf:ce8c:: with SMTP id r12mr17741343wrn.60.1554721360276; 
	Mon, 08 Apr 2019 04:02:40 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	f128sm12034224wme.28.2019.04.08.04.02.39
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 08 Apr 2019 04:02:39 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-15-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <606bbd80-1981-55d3-d42e-6a0c8f8a32e8@redhat.com>
Date: Mon, 8 Apr 2019 13:02:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408083627.7479-15-armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH 14/15] char: Make -chardev help print to
 stdout
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408110238.iZTDZqOqmAMChbzfrCOIu1OqM8UB8WwPcMMlXPFoDpU@z>

On 4/8/19 10:36 AM, Markus Armbruster wrote:
> Command line help explicitly requested by the user should be printed
> to stdout, not stderr.  We do elsewhere.  Adjust -chardev to match:
> use qemu_printf() instead of error_printf().  Plain printf() would be
> wrong because we need to print to the current monitor for chardev-add
> help".
> 
> Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  chardev/char.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/chardev/char.c b/chardev/char.c
> index 514cd6b0c3..54724a56b1 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -28,6 +28,7 @@
>  #include "sysemu/sysemu.h"
>  #include "qemu/config-file.h"
>  #include "qemu/error-report.h"
> +#include "qemu/qemu-print.h"
>  #include "chardev/char.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-char.h"
> @@ -651,7 +652,7 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
>  
>          chardev_name_foreach(help_string_append, str);
>  
> -        error_printf("Available chardev backend types: %s\n", str->str);
> +        qemu_printf("Available chardev backend types: %s\n", str->str);
>          g_string_free(str, true);
>          return NULL;
>      }
> 

