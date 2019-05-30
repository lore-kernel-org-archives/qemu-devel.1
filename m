Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68468C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 08:27:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4026B24143
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 08:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4026B24143
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49129 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWGPj-0000ky-EJ
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 04:27:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hWGOt-0000Nu-EZ
	for qemu-devel@nongnu.org; Thu, 30 May 2019 04:27:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hWGOs-0001LG-G9
	for qemu-devel@nongnu.org; Thu, 30 May 2019 04:27:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50353)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hWGOs-0001BW-9J
	for qemu-devel@nongnu.org; Thu, 30 May 2019 04:27:02 -0400
Received: by mail-wm1-f65.google.com with SMTP id f204so3355261wme.0
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 01:26:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=EX4LlcqkCxD7/huDiw4NjSsRbLPn8U0EjLF7be5EeRU=;
	b=UzhjpocNZkjAnP2xF658C1q2S2hv/3Tu1FCJ0heBqIOYDfjwKuPeYFQhuVFfJxFHwa
	SBnn8HMfggwSEJ40G2yNCLmJykyg6+4aq14XOOxqVkf979vBjR52sxepYGxc6r9c3mZo
	1v2oe2OwGZoM/SVCQAGJBQAR38zPd9hklU7viaher7Z4gsNr487U18gffXH9wPPDN/3V
	4sXGLek0FBU0dBrbHw4op5tpY/KZOHFJ0oMUJxW1QSi49MEl6OSuTLI0NFHqa/S4e3TN
	T8yF25HCynHOEd9/A0elepofXQPIWRG2DWGsglBqU5eZfPMUwfVY1dHZu0RoV5F2WJPn
	M9wQ==
X-Gm-Message-State: APjAAAVd0L4L9dFU6bZqt5qsYfmlQ8x/zfuB9z341i+5EeVkjMk+jSRl
	1VzqoD2ZIsyNgYgpnJhUD8WaDw==
X-Google-Smtp-Source: APXvYqxTGGSadDLNCTgjDFRZTEHSvGsteNl4rOw+UI4IXXotZq3PfU0LsWRu4Xqb+FoparKUWQJuhg==
X-Received: by 2002:a1c:5f09:: with SMTP id t9mr1509893wmb.112.1559204809450; 
	Thu, 30 May 2019 01:26:49 -0700 (PDT)
Received: from steredhat.homenet.telecomitalia.it
	(host253-229-dynamic.248-95-r.retail.telecomitalia.it.
	[95.248.229.253])
	by smtp.gmail.com with ESMTPSA id a4sm4114577wrf.78.2019.05.30.01.26.48
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 30 May 2019 01:26:48 -0700 (PDT)
Date: Thu, 30 May 2019 10:26:46 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <20190530082646.ltwaew7jlaybumiv@steredhat.homenet.telecomitalia.it>
References: <20190530081055.9560-1-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530081055.9560-1-dplotnikov@virtuozzo.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v4] qemu-io: add pattern file
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

On Thu, May 30, 2019 at 11:10:55AM +0300, Denis Plotnikov wrote:
> The patch allows to provide a pattern file for write
> command. There was no similar ability before.
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---

Hi Denis,
for next versions I suggest to describe here, after the ---, the changes
with previous versions. In this way the review should be easier.

>  qemu-io-cmds.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 75 insertions(+), 6 deletions(-)
> 
> diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
> index 09750a23ce..1c6a5e4faf 100644
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
> @@ -343,6 +344,61 @@ static void *qemu_io_alloc(BlockBackend *blk, size_t len, int pattern)
>      return buf;
>  }
>  
> +static void *qemu_io_alloc_from_file(BlockBackend *blk, size_t len,
> +                                     char *file_name)
> +{
> +    char *buf, *buf_pos;
> +    FILE *f = fopen(file_name, "r");
> +    int l;
> +
> +    if (!f) {
> +        printf("'%s': %s\n", file_name, strerror(errno));
> +        return NULL;
> +    }
> +
> +    if (qemuio_misalign) {
> +        len += MISALIGN_OFFSET;
> +    }
> +    buf = blk_blockalign(blk, len);
> +    memset(buf, 0, len);
> +
> +    buf_pos = buf;
> +
> +    while (len > 0) {
> +        l = fread(buf_pos, sizeof(char), len, f);
> +
> +        if (feof(f)) {
> +            rewind(f);
> +        }
> +
> +        if (ferror(f)) {
> +            printf("'%s': %s\n", file_name, strerror(errno));
> +            goto error;
> +        }
> +
> +        if (l == 0) {
> +            printf("'%s' is empty\n", file_name);
> +            goto error;
> +        }

Could it happen that we read some bytes, than we reached the EOF, so we made
the rewind() and fread() returns 0?
If that can happen, maybe we should change it in this way:

        if (l == 0 && buf_pos == buf) {
            printf("'%s' is empty\n", file_name);
            goto error;
        }

Thanks,
Stefano

