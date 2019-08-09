Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A4EC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 23:07:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 550552086D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 23:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 550552086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwDzF-0002ul-Af
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 19:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59393)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <nsoffer@redhat.com>) id 1hwDyr-0002Qj-D2
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 19:07:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nsoffer@redhat.com>) id 1hwDyq-00018R-5h
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 19:07:29 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40070)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1hwDyq-00017g-0p
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 19:07:28 -0400
Received: by mail-ot1-f68.google.com with SMTP id l15so81596881oth.7
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 16:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AwUyG7nK0qXh19Ew1JV4YKTP28NVFDCB/AYSYSxZVxc=;
 b=IaGbLuWUaPCiDy7y5vUObvuigEXtzozxZMqmXlTEDtht9+vZpdrINBt2ne+WQGoQ63
 /ZTASo7NULCHpGdrQfKwkLF4XHwC43sCxffB/sKUq4M+qqT8FEehPh2dJK+JenBABDea
 eBVociIlN/efagm+PX5moy/qMjQVBoRcbCmkvvBGpZ4Ap9CNg7Z30rxUo7JJ2oUJ6WH9
 CeGsPGBnFodBHrEuPpfl8dczZQX8/iSSfEytD1kD4rmyBSdPZ+XMrIUxGizCF6W1Czox
 r6yC8IPuaFRer0lVHVtWPIk+130dl0mG6RCDbp7JyW3THNVVYKM4L3Vq3MGbIFULItmR
 dMQg==
X-Gm-Message-State: APjAAAUN9ptldXVw/CUOMOWOQ+HIBfI2dU5fDuN70NyOFxhBtpVaoVp3
 n7VEQVeodCJZPM/drTbbHBWUehIDwXH/oEKYP8t7sg==
X-Google-Smtp-Source: APXvYqxIjanLUkRxF+rZv3+kcmiLtH6r7jSa0gaQEl4Lzut2+1lc5E5acTFEzvV2EZP9syxctqThKC/57b+SkMTjOg8=
X-Received: by 2002:a9d:7ad9:: with SMTP id m25mr9399717otn.315.1565392046288; 
 Fri, 09 Aug 2019 16:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190809091107.11161-1-kwolf@redhat.com>
In-Reply-To: <20190809091107.11161-1-kwolf@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Sat, 10 Aug 2019 02:07:14 +0300
Message-ID: <CAMRbyyubaVQ5rdnKMNYAsZK1NtSH2gHG-0L5XjT7uxqtZgXTsg@mail.gmail.com>
To: Kevin Wolf <kwolf@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.68
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qemu-img convert: Deprecate
 using -n and -o together
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 9, 2019 at 12:11 PM Kevin Wolf <kwolf@redhat.com> wrote:

> bdrv_create options specified with -o have no effect when skipping image
> creation with -n, so this doesn't make sense. Warn against the misuse
> and deprecate the combination so we can make it a hard error later.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qemu-img.c           | 5 +++++
>  qemu-deprecated.texi | 7 +++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/qemu-img.c b/qemu-img.c
> index 79983772de..d9321f6418 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -2231,6 +2231,11 @@ static int img_convert(int argc, char **argv)
>          goto fail_getopt;
>      }
>
> +    if (skip_create && options) {
> +        warn_report("-o has no effect when skipping image creation");
> +        warn_report("This will become an error in future QEMU versions.");
> +    }
> +
>      s.src_num = argc - optind - 1;
>      out_filename = s.src_num >= 1 ? argv[argc - 1] : NULL;
>
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index fff07bb2a3..7673d079c5 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -305,6 +305,13 @@ to just export the entire image and then mount only
> /dev/nbd0p1 than
>  it is to reinvoke @command{qemu-nbd -c /dev/nbd0} limited to just a
>  subset of the image.
>
> +@subsection qemu-img convert -n -o (since 4.2.0)
> +
> +All options specified in @option{-o} are image creation options, so they
> +have no effect when used with @option{-n} to skip image creation. This
> +combination never made sense and shows that the user misunderstood the
> +effect of the options, so this will be made an error in future versions.
>

The user misunderstood by not reading qemu code?

Both the online help and the manual page do not mention anything about
that, so I think
they should be fixed to explain the behavior, and this text should mention
that the behavior
was never documented.

Nir


> +
>  @section Build system
>
>  @subsection Python 2 support (since 4.1.0)
> --
> 2.20.1
>
>
>
