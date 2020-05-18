Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AADC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DBCA20758
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Di4ETJRO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DBCA20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaiA0-00050J-JX
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 11:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jai5U-00049g-6Z
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:53:56 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:42891)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jai5T-0000CT-B3
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:53:55 -0400
Received: by mail-oi1-x241.google.com with SMTP id l6so3505150oic.9
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 08:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0Rb6a9OPTQfJpHlc1CG4uedHUCEuT+PZYr3btHlYQhE=;
 b=Di4ETJRO5q5f8bBE35pvXw/jjtjjOj5kXsC8bhXm9n3IQBPP3hSFqAnyN1Yq/+RvDo
 BqI05Vbq/2b6fTUbMgkjQdsOzBEDZbUmfocSUwbL561/Kqt9PtBlaluWZsxLqNS9O3Zk
 g0bJ0+xzvPxQgHkB41Avu/Gu6kcXmQV6U8sSWqq6Pcktic8cH6lp4FnBC+mqcOKV/3jQ
 pqb22zTSylFa+2zof4GGkYco+h7FZrz4Nfuh02LJndSAXEKn2T5v5WyDfaDi+XsaY893
 doA+CIB6cRym6sS/vG+s5GJ05NH+LJkm/oKros37oj2gvU9QSOqAJ70UwD4E4xdTDHGc
 MW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0Rb6a9OPTQfJpHlc1CG4uedHUCEuT+PZYr3btHlYQhE=;
 b=Pf/0WVp7kPYesDhuOt7ZZC3gdepSo864kxMrzlfD3hSJEpSZtJSRicnauz2+ypqhhI
 ee2tyM+MLxyOmSPjQlkPgFU+TQbgAKkts/KmcPp7hAU74gecVzzcC/bR0tXooANoe14p
 r9Il1hJyr8fnNhJlJh6T68C8uH/x2UHSBMVMujIeM8ZTWteyRBA10YnnAZYGbq9ocV6d
 YyPE/uQ8Af72jzIsDxBK3z0LObxhLlBbrSmLQk2gsTWHJ0mbQde4tNkcbhJMZd3rGtwy
 F0ULgk6dHujtNKghHEeW4vYfjb6cr5YIDVAC3oOu1I51sYRwOnC+oplq3qvsQTAXI7Fl
 4Dow==
X-Gm-Message-State: AOAM531tDNHCZTY05uHjvfxl0u5HHG3ibxH9rzDKFWpLTMHnWlCLgdtA
 RYO45OkvGcpLV4QcX1YQB4V2nxQ1ua8Ed8z6LGF1pH6v
X-Google-Smtp-Source: ABdhPJwVKAsnPjJ3YGlhbLTvqtmEgFDz42Lunrn4vZkG7iuNcWQEttXlhhWgcJisI3w2fczJpkSYGothWGaWwEpTz3c=
X-Received: by 2002:a54:400c:: with SMTP id x12mr22444oie.146.1589817234388;
 Mon, 18 May 2020 08:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200513180953.20376-1-richard.henderson@linaro.org>
 <20200513180953.20376-5-richard.henderson@linaro.org>
In-Reply-To: <20200513180953.20376-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 May 2020 16:53:42 +0100
Message-ID: <CAFEAcA_2OOnajZ7xHC0FuZzeNj5GiwLpV-bWCtX-tKpihiwKLg@mail.gmail.com>
Subject: Re: [RISU 4/9] Adjust tracefile open for write
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 13 May 2020 at 19:10, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Truncate the new output file.  Rely on umask to remove
> group+other file permissions, if desired.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  risu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/risu.c b/risu.c
> index 1c66885..f404d8f 100644
> --- a/risu.c
> +++ b/risu.c
> @@ -368,7 +368,7 @@ int main(int argc, char **argv)
>              comm_fd = ismaster ? STDOUT_FILENO : STDIN_FILENO;
>          } else {
>              if (ismaster) {
> -                comm_fd = open(trace_fn, O_WRONLY | O_CREAT, S_IRWXU);
> +                comm_fd = open(trace_fn, O_WRONLY | O_CREAT | O_TRUNC, 0666);
>              } else {
>                  comm_fd = open(trace_fn, O_RDONLY);
>              }

I dunno why we were giving it execute permissions...

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

