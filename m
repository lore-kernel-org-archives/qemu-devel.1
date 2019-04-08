Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0928C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 11:03:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE98C20857
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 11:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE98C20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51103 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDS3I-0006zg-VT
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 07:03:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDS1X-0005zC-1W
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:01:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDS1W-0004cF-0C
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:01:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hDS1V-0004bu-Ok
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:01:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id s15so15769493wra.12
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 04:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=++MaNOo1tzTWdIO6xVrlsXW707sGfPG0yedpq/4Tvrw=;
	b=sr6pla2bAstJ14dgOST3+irliAdlxByxZOZjxst9ck2jAAdcYrDUm2ZLpxcFVwGtjU
	rvA/30PxwteliobT/+G/VToPU/CJ7NdmyXHoGVGYLFAthKu0aWjhcn6kK+Zd3KM8Yrhp
	GMK6g/b0aq7C7YT00/m4Rfrqi5MAPRXJXcrKsvBP+nPIAOEb73we9E8hGaIqrjzNDecl
	9jyCZ7nE40RVBfNRFKs+4udCpztnQ8AXwrUXVHnH+czz/15IjzDvYBFvNbobByuN7CuD
	paPE6jxlamVZn+nKuzPiUfyBGcobUNL/4BE9dLJQp3iodT/iCfvLwURIe+7mIIqZdkT0
	/yNw==
X-Gm-Message-State: APjAAAXTWBaxrESIe6wG0oB5jrYLB88l/lhSfqLxvWxZkCp225Q1kqib
	bugyR8dGH3/gUp3moR+QGHM+og==
X-Google-Smtp-Source: APXvYqyjAHco8taHXkGw4cp/TkQgZtuKn24XRAbCcdFdTa2SuvH34Q9FtCNMx3/w8uzrfYKHA1979g==
X-Received: by 2002:a5d:6150:: with SMTP id y16mr17869432wrt.13.1554721268957; 
	Mon, 08 Apr 2019 04:01:08 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	w16sm42444709wrt.84.2019.04.08.04.01.07
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 08 Apr 2019 04:01:08 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-14-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <3fd43de9-8dd8-67c9-0525-0d4f44dd7422@redhat.com>
Date: Mon, 8 Apr 2019 13:01:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408083627.7479-14-armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH 13/15] blockdev: Make -drive format=help
 print to stdout
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408110107.W_uOjizZtdo5xwp55UfqJqT3RPtWXnFEn0HOTpj_FkA@z>

On 4/8/19 10:36 AM, Markus Armbruster wrote:
> Command line help explicitly requested by the user should be printed
> to stdout, not stderr.  We do elsewhere.  Adjust -drive to match: use
> qemu_printf() instead of error_printf().  Plain printf() would be
> wrong because we need to print to the current monitor for "drive_add
> ... format=help".
> 
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: qemu-block@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  blockdev.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/blockdev.c b/blockdev.c
> index 4775a07d93..79fbac8450 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -40,6 +40,7 @@
>  #include "monitor/monitor.h"
>  #include "qemu/error-report.h"
>  #include "qemu/option.h"
> +#include "qemu/qemu-print.h"
>  #include "qemu/config-file.h"
>  #include "qapi/qapi-commands-block.h"
>  #include "qapi/qapi-commands-transaction.h"
> @@ -301,7 +302,7 @@ DriveInfo *drive_get_next(BlockInterfaceType type)
>  
>  static void bdrv_format_print(void *opaque, const char *name)
>  {
> -    error_printf(" %s", name);
> +    qemu_printf(" %s", name);
>  }
>  
>  typedef struct {
> @@ -530,11 +531,11 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
>  
>      if ((buf = qemu_opt_get(opts, "format")) != NULL) {
>          if (is_help_option(buf)) {
> -            error_printf("Supported formats:");
> +            qemu_printf("Supported formats:");
>              bdrv_iterate_format(bdrv_format_print, NULL, false);
> -            error_printf("\nSupported formats (read-only):");
> +            qemu_printf("\nSupported formats (read-only):");
>              bdrv_iterate_format(bdrv_format_print, NULL, true);
> -            error_printf("\n");
> +            qemu_printf("\n");
>              goto early_err;
>          }
>  
> 

