Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F39C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 07:52:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88F7A2575C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 07:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F7A2575C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48757 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWFru-0001oN-R5
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 03:52:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hWFr2-0001T9-VI
	for qemu-devel@nongnu.org; Thu, 30 May 2019 03:52:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hWFr2-0005Lr-0Y
	for qemu-devel@nongnu.org; Thu, 30 May 2019 03:52:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39989)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hWFr1-0005L3-Po
	for qemu-devel@nongnu.org; Thu, 30 May 2019 03:52:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id t4so3474681wrx.7
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 00:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=eJjS/MRqzqE0sIL10+qCT0dzG9nNq8vdzAqaZF0I5e8=;
	b=CsVwpABTAjQIo/HqsY00WAhgNxBCDzvsx1jSaLqrg5jZEr3N2TC/vMmrBDYA0IP7h8
	SUEQ8rgOGEHm/eUGRIG1KfYEu1E3kVOwTnykadHsXJyUOrd+A5gcZxoU8J1TOELZszeH
	K1rWq2SCeH6Pu/PlItzp/OUOKOjVVp9pu0CVqlhUwhRKSXEB9ZiqgF2eywulX7U02Oxk
	j4MMhD7laULcKFpwI630KUqIAHnWXN5JM8aDzqoTAa1a7zfGaXWaKlxtXjUiECxkKP+F
	Wpp3bsFkJHUqoB7GG7CBazSPjgZUY4y1qJRv3zbp2UgAU9xy16DoiMp92OGtEl05mYyw
	kGuw==
X-Gm-Message-State: APjAAAV+1BFAYSHroBQKfzER0q4fjclL6iL075mgla345LHF3nR+Pb4g
	S98lEnoO+0grOcSptdFrwABoIQ==
X-Google-Smtp-Source: APXvYqxDN89A5FbnMfd/Dr0VmvGIGEyI8ZuKye8lNrZxJ7RoC6a7jqnrT/sv60RG6oFtfx0yyh8RTA==
X-Received: by 2002:a5d:6588:: with SMTP id q8mr1575116wru.259.1559202721543; 
	Thu, 30 May 2019 00:52:01 -0700 (PDT)
Received: from steredhat.homenet.telecomitalia.it
	(host253-229-dynamic.248-95-r.retail.telecomitalia.it.
	[95.248.229.253])
	by smtp.gmail.com with ESMTPSA id t4sm1806146wmi.41.2019.05.30.00.52.00
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 30 May 2019 00:52:00 -0700 (PDT)
Date: Thu, 30 May 2019 09:51:58 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <20190530075158.nxwed37oqs5qqjzb@steredhat.homenet.telecomitalia.it>
References: <20190529114624.23107-1-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529114624.23107-1-dplotnikov@virtuozzo.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] qemu-io: add pattern file
 for write command
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
Cc: kwolf@redhat.com, den@virtuozzo.com, qemu-block@nongnu.org,
	qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 29, 2019 at 02:46:24PM +0300, Denis Plotnikov wrote:
> The patch allows to provide a pattern file for write
> command. There was no similar ability before.
> ---
>  qemu-io-cmds.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 54 insertions(+), 4 deletions(-)
> 
> diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
> index 09750a23ce..148f2ff92a 100644
> --- a/qemu-io-cmds.c
> +++ b/qemu-io-cmds.c
> @@ -21,6 +21,7 @@
>  #include "qemu/option.h"
>  #include "qemu/timer.h"
>  #include "qemu/cutils.h"
> +#include "string.h"
>  
>  #define CMD_NOFILE_OK   0x01
>  
> @@ -343,6 +344,35 @@ static void *qemu_io_alloc(BlockBackend *blk, size_t len, int pattern)
>      return buf;
>  }
>  
> +static void *qemu_io_alloc_from_file(BlockBackend *blk, size_t len,
> +                                     char *file_name)
> +{
> +    void *buf;
> +    FILE *f = fopen(file_name, "r");
> +
> +    if (!f) {
> +        printf("cannot open file '%s'\n", file_name);
> +        return NULL;
> +    }
> +
> +    if (qemuio_misalign) {
> +        len += MISALIGN_OFFSET;
> +    }
> +    buf = blk_blockalign(blk, len);
> +    memset(buf, 0, len);
> +
> +    if (!fread(buf, sizeof(char), len, f)) {
> +        printf("file '%s' is empty\n", file_name);
> +        qemu_vfree(buf);
> +        return NULL;
> +    }

Should we close the FILE *f at the end of this function or when fread()
returns with an error?

Thanks,
Stefano

