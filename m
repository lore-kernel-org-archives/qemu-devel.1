Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E80C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:58:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43A612070D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fWXqvhpH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A612070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46949 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP8qg-000295-K9
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 12:58:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hP8iL-0000my-Cn
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:49:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hP8iK-0005gc-Fh
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:49:41 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41031)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hP8iK-0005g8-96
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:49:40 -0400
Received: by mail-oi1-x242.google.com with SMTP id y10so4990576oia.8
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 09:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=gCX+seDemu8LJPPgW5WuGOwnjcJKRB79k4K8XCw1BT4=;
	b=fWXqvhpH0fVitQT36Y+CZG9+X9EFLkxRGjmv5cJnnhAdM9AMkYOaY7h4GBDvd4WWz/
	9qdIk2WdTQYhUKZ0JdnQYSdoPZk0USGqpCoSf3/g+EfKRbDF3uq3O8jbujtPs/w0MknM
	+7m01BfmrfrZy8SWbbuiQKQCdG/xES4PByXrtUHB249CdACw1mbJxrMpRHnDGAsW5TN8
	520oIWL9gKDlVkT3DPUZJ4hAz19gzaoIQgNk3e+SVB3wyXRKozxDkGkxvaYmIFvIcifD
	6Nw6S9n8NbGW2LnhTd3zIYyRMBVQcZvbQyyK1GFwuQtLMIYaB1Qldxf/achR4TNdwwa0
	jCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=gCX+seDemu8LJPPgW5WuGOwnjcJKRB79k4K8XCw1BT4=;
	b=SxVgCaf4uuNKo8NwmQ1X3iIZ/s4huFoSgVhSxCM1lM72ckBHynBUDp3wlpYmQEiLqB
	1y9ZHFIN4R3EjioZeA9zY+14KLNspw29bRLm8bqYnos6GLITeueivOZBCdZE899UlZjP
	UdNwhieoJcpreWN+eDuYq0gom0FH4m5uaruAum7QkDS9QvU8+LuPbB1C8fTnnvjsFs1X
	3SGxQXgcaVNCFUdultJXOct9FDPjsK4IaSRcTrWFWd9/Rs7tXWFPAiTuqvQXK920jkS5
	Nr/SIdk3LPylufzQdPAYlm796Qtrqp64NBiIxiifYzF8t8vRNwLDrCEL77mhix/q7YO7
	rKDA==
X-Gm-Message-State: APjAAAUnvak3Ve169Xs3NHbgf2P7Vv81jwkFPMq0OC4KvLzZuUUeWWpx
	tJlSJ1cvtL6h1FoYfhtetBBtE2M4qMc59DWH6tIptg==
X-Google-Smtp-Source: APXvYqxxznaOj0KQ57jzIBYNB2SwLVqDywtBH3Er9UIsY3yOkiiyjPZS9CtqdI1mYltMaraMZ9DQZvJE/bhynXTdU/Q=
X-Received: by 2002:aca:5785:: with SMTP id l127mr5358148oib.48.1557506979339; 
	Fri, 10 May 2019 09:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190510163536.4242-1-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190510163536.4242-1-mark.cave-ayland@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 May 2019 17:49:28 +0100
Message-ID: <CAFEAcA8tHGciDGyDwCZ02S5km8XNf32PfgSbtbRzqLxcT9JWhA@mail.gmail.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH] configure: copy MacOS NDRV driver into
 sharedir for out-of-tree builds
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
Cc: Howard Spoelstra <hsp.cat7@gmail.com>, qemu-ppc <qemu-ppc@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 May 2019 at 17:37, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> Make sure that we include *.ndrv files with those being copied to sharedir
> during out-of-tree builds. This ensures that the MacOS driver is correctly
> located and loaded by qemu-system-ppc.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  configure | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configure b/configure
> index 63f312bd1f..9493537301 100755
> --- a/configure
> +++ b/configure
> @@ -7886,6 +7886,7 @@ for bios_file in \
>      $source_path/pc-bios/*.dtb \
>      $source_path/pc-bios/*.img \
>      $source_path/pc-bios/openbios-* \
> +    $source_path/pc-bios/*.ndrv \
>      $source_path/pc-bios/u-boot.* \
>      $source_path/pc-bios/edk2-*.fd.bz2 \
>      $source_path/pc-bios/palcode-*

The comment above this bit of code says:

# Caution: do not add files or directories here using wildcards. This
# will result in problems later if a new file matching the wildcard is
# added to the source tree -- nothing will cause configure to be rerun
# so the build tree will be missing the link back to the new file, and
# tests might fail.

The pc-bios/ directory is awkward legacy which we
can't really apply the next part of the comment to
("Prefer to keep the relevant files in their own
directory and symlink the directory instead"), but since
there is only one *.ndrv file we can at least avoid the
wildcard by writing "qemu_vga.ndrv" instead of "*.ndrv".

thanks
-- PMM

