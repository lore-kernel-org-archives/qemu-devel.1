Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5A8C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 15:22:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 033362076E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 15:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FaflX1lD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 033362076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k98s4-0002fe-AN
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 11:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k98r7-0002F9-F0
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 11:21:25 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:42827)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k98r5-0005HB-Ms
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 11:21:25 -0400
Received: by mail-ej1-x642.google.com with SMTP id g19so2699304ejc.9
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 08:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eZaNIlGORyhq1nAJnzNsDfEUaXHZjkLWL6RGrnJs73k=;
 b=FaflX1lDhmEMUWzcXqT48JkeM0YFJteLEgJyDQwEKlcCeZGeN+Y11Y++ClVbMkNj5n
 vf39LJJ6Ix52yoJD4BI3hlZL4qlUZc16f48zVjISIlHywE5XJldbJPQvodk0ZggC7/iF
 PbTB4lt1OZTd+OhzAHOPTI4tkbf8M7mHKK8vpvZVoAxxs5cEpNr+r1DU8rPcYUeiI1j0
 ONp9bp/25iKVne3+gFbFK1oNG6z7EAszOfhL2hcpBC6Xc8RmGM3LjZEFuTMstK8ZG+NR
 hnjInoRP2gW7t0NvIGCdw2CeRcyQG7zz7XX5Hghg+ua03QlTfDb2AiXmpwkfDdJWY9DY
 kigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eZaNIlGORyhq1nAJnzNsDfEUaXHZjkLWL6RGrnJs73k=;
 b=bnvAwf/ZniI64UckQdyZ+AOV6ocKOJvrGikEFgsR+N4FhVgXuId0ttEQAZukE9tjoo
 yB1J30RiEB3cqIWmd9VDynCYT09LhleXjLiWbjmQnBMjyKVHmIMxFvZQrWHtgEJrMyZl
 Gqzb8UitmVp37BKO5AeEbawSmjGj3x0nK1BuIZQxzTBXUFI5nn65JJYonwV7eQ8n53fh
 f23vVjYm/H5Wbop9/xx3asWamGIL4ultUP3vHTVIS2we1LkBRCnSz3v0PNrYVlxb0nPZ
 Rlz0GB1lqovkrKFjsWQ7AE023yaRrYJ5Pords7gNyupHepF4JvL6uuoPFGTLu3LSfhOR
 rjbA==
X-Gm-Message-State: AOAM531E//aFowt/SOsL8jczt1W/uOGyRe+oduHIRVelSWWN+0GP7Lzc
 Iyt+2EUnMvV6zoGaLhRShytXKerHXLQC/HmU7Yd1ig==
X-Google-Smtp-Source: ABdhPJx2D6uTpDR8LepoozPmHbSBPiISIQNFWiZbRQx9AQXnPSTCj+6oGwbGbIeBBoPM8cSNTxGvcRu0DteHVNoUHqY=
X-Received: by 2002:a17:906:b248:: with SMTP id
 ce8mr3243617ejb.85.1598023281615; 
 Fri, 21 Aug 2020 08:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200821150014.42461-1-sgarzare@redhat.com>
In-Reply-To: <20200821150014.42461-1-sgarzare@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Aug 2020 16:21:10 +0100
Message-ID: <CAFEAcA9zUDeig8TB4JDd_48v2AXcr7HGyjGq6r7KVx=sQyrjXA@mail.gmail.com>
Subject: Re: [PATCH] configure: silence 'shift' error message in version_ge()
To: Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 21 Aug 2020 at 16:00, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> If there are less than 2 arguments in version_ge(), the second shift
> prints this error:
>     ../configure: line 232: shift: shift count out of range
>
> Let's shut it up, since we're expecting this situation.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configure b/configure
> index 4e5fe33211..de4bd0df36 100755
> --- a/configure
> +++ b/configure
> @@ -229,7 +229,7 @@ version_ge () {
>          set x $local_ver1
>          local_first=${2-0}
>          # shift 2 does nothing if there are less than 2 arguments
> -        shift; shift
> +        shift; shift 2>/dev/null

POSIX says
https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#shift

"If the n operand is invalid or is greater than "$#", this may be
considered a syntax error and a non-interactive shell may exit"

so I think that we need to actually avoid the excess shift,
not just suppress any warning it might print. (I'm not sure
Philippe's "shift || shift" patch can work for that, though,
as the exit status doesn't distinguish "valid shift but don't
do it again" from "valid shift and more args to come".)

thanks
-- PMM

