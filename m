Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093ACC4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 17:27:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC09121924
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 17:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XBsQWm3T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC09121924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7NRr-0007Cn-Tx
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 13:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i7NQq-0006PJ-OC
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:26:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i7NQp-0000JF-EA
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:26:28 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36867)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i7NQp-0000IN-6S
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:26:27 -0400
Received: by mail-ot1-x343.google.com with SMTP id s28so13336237otd.4
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 10:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tXMId7I+i+NTMdFyH54cE0CLqkIK6GEeR6dKwYtK1+s=;
 b=XBsQWm3TaFgBZcxw2MulQMln2C4O4bHZNgWQTGoHoCInUX7OwLIjUZxp/gf/5i7Hmp
 dWVZ4T9Df7EqLM9OoLvqC+2geFN+bZourbkgPdEmEIt6j6xIsCkPCArShsFUHZoA3XAg
 umakg5bzjwiahLLAWhaOUawaFpXiltff250AGCX/gT3S+Cm6RgVFptHwj97kfu1CRFiS
 KVMsEeHD2rakJ6kmPwIKEylkmVXGsXeb4jgK2N5zvWIhUMbSjzwxMrtazKcamXmxC4ED
 ZdMRZq3EdluCgUgGQugOPVnnt/Pr8AsUJ13oTYmXb4D48kggy0dDJT3UUbCeIITIeJee
 muMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tXMId7I+i+NTMdFyH54cE0CLqkIK6GEeR6dKwYtK1+s=;
 b=RCGfW1zTP0qkwyXFo1NdwL+e1wz8jtgsbw+a9o0zITcqzTV18ECFdJWCjfPdR65gKq
 gaSscP8chJnHQjbZn96OIZHhRHac0UqaqX6G2nd36p9S64LFoa1qYY+p/wx4GSaDBO/R
 lPlOtAhlamidl7gI45yWg2a5xGyraSZs4Akg+E5hEBaTddTpCx70oT/DYfj57LueAGEc
 sdfxh3JP62BWr6RCZEiCL+ey+pVHcOwkns6UwU3IHP5WUkPsGwnHKzD9g2x2opyrqnmx
 /6FFXcOxKT02IuZk1RVhCVpub0KZuQZeLDW55JLWBs3/lVugxh1C4oZSnUAb3d4xYD76
 bzlw==
X-Gm-Message-State: APjAAAWNAew819q9NbKaI1lmKKXywSHzUy0bVmE/orUh8H8d0TOcMSDL
 q6fwaPjiSEzXhSWPwRssYWtL6I1C6DEW3ISrzRo4iw==
X-Google-Smtp-Source: APXvYqzTcCCMLptgbbBWzAFHjpdvlHoqQzC7x2cd8ll1mEul4qisBMNUkfaz6o+xumF3yFhQKAdpKRSwKucQVL4y9Eg=
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr21134480oti.135.1568049986333; 
 Mon, 09 Sep 2019 10:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190903133553.6500-1-mreitz@redhat.com>
 <20190903133553.6500-2-mreitz@redhat.com>
In-Reply-To: <20190903133553.6500-2-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Sep 2019 18:26:15 +0100
Message-ID: <CAFEAcA_Gpw14Hjr7rW0Z-9Ngj5Udbxv0ZEMZAo0W0PT0nCwe2g@mail.gmail.com>
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PULL v2 01/16] qemu-io: add pattern file for
 write command
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
Cc: Denis Plotnikov <dplotnikov@virtuozzo.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Sep 2019 at 14:35, Max Reitz <mreitz@redhat.com> wrote:
>
> From: Denis Plotnikov <dplotnikov@virtuozzo.com>
>
> The patch allows to provide a pattern file for write
> command. There was no similar ability before.
>
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> Message-id: 20190820164616.4072-1-dplotnikov@virtuozzo.com
> Reviewed-by: Eric Blake <eblake@redhat.com>
> [mreitz: Keep optstring in alphabetical order]
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Hi; Coverity finds a FILE* leak in this code (CID 1405303):



> +/*
> + * qemu_io_alloc_from_file()
> + *
> + * Allocates the buffer and populates it with the content of the given file
> + * up to @len bytes. If the file length is less than @len, then the buffer
> + * is populated with the file content cyclically.
> + *
> + * @blk - the block backend where the buffer content is going to be written to
> + * @len - the buffer length
> + * @file_name - the file to read the content from
> + *
> + * Returns: the buffer pointer on success
> + *          NULL on error
> + */
> +static void *qemu_io_alloc_from_file(BlockBackend *blk, size_t len,
> +                                     const char *file_name)
> +{
> +    char *buf, *buf_origin;
> +    FILE *f = fopen(file_name, "r");

Here we allocate the FILE*...

> +    int pattern_len;
> +
> +    if (!f) {
> +        perror(file_name);
> +        return NULL;
> +    }
> +
> +    if (qemuio_misalign) {
> +        len += MISALIGN_OFFSET;
> +    }
> +
> +    buf_origin = buf = blk_blockalign(blk, len);
> +
> +    if (qemuio_misalign) {
> +        buf_origin += MISALIGN_OFFSET;
> +        buf += MISALIGN_OFFSET;
> +        len -= MISALIGN_OFFSET;
> +    }
> +
> +    pattern_len = fread(buf_origin, 1, len, f);
> +
> +    if (ferror(f)) {
> +        perror(file_name);
> +        goto error;

...but in this error-exit path...

> +    }
> +
> +    if (pattern_len == 0) {
> +        fprintf(stderr, "%s: file is empty\n", file_name);
> +        goto error;

...and this one...

> +    }
> +
> +    fclose(f);
> +
> +    if (len > pattern_len) {
> +        len -= pattern_len;
> +        buf += pattern_len;
> +
> +        while (len > 0) {
> +            size_t len_to_copy = MIN(pattern_len, len);
> +
> +            memcpy(buf, buf_origin, len_to_copy);
> +
> +            len -= len_to_copy;
> +            buf += len_to_copy;
> +        }
> +    }
> +
> +    return buf_origin;
> +
> +error:
> +    qemu_io_free(buf_origin);
> +    return NULL;

...we go to the 'error' label and leave the function without
ever calling fclose(f).

> +}

thanks
-- PMM

