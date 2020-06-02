Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B91C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 19:14:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D824206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 19:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tI4SU1I2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D824206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgCN0-00068Y-Jk
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 15:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgCMR-0005Y8-0q
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 15:14:07 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39036)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgCMQ-0002Fd-4j
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 15:14:06 -0400
Received: by mail-oi1-x244.google.com with SMTP id d67so8013946oig.6
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 12:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Q22uLXcm8fCaLcZwsI/bM8xs70lPNORKeZA3nuPJLUw=;
 b=tI4SU1I2z5ZAD/ZEcPRbJN8SRghczLInaR8Iu3GtocLrqc3/iQDIBtcD9ip9z/f06z
 UTjuWe0zaz11yZBH6DkGg99dmA1006rQD4ViD72yjweFdqb/ZmK/EdpJM2yFfZL7msZp
 oomKw0HVgg9nv66rkKWfz17dHLIC75KynR2rgnUsANehGbJ1dfDE6fEOPJTMYxn/2BTw
 23bD/pp6GdUWwfZ2vMngayiPhx1rhPpwG2/kBnvdp4W1Oa07c5G47XiwC70kmyREdyO8
 i/zl189pR+jKo4tYfnQv/jzu9ktbV7ZkLRtc7tPxq058d0RMorOUdhoTgveanpnCPFWm
 bb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q22uLXcm8fCaLcZwsI/bM8xs70lPNORKeZA3nuPJLUw=;
 b=neMAwBKWQgTLM9RzmGpN5mYz7T4BNflvn1jHwJuJ1hkqVu3N60R01w6mNWEhs9Kb0V
 iaebgRVG6fJ9ED9UOSjWqCWkSaNxFhLoq6hUqEqIei8FefkStLeI6VRtL4F+sSx3DY6c
 dDMVOG+afafZAP9U5pt4ibI+v2kuR1NIMp2vJp7y5abptX/9NZzqjwIldzaybzLSadmV
 1QnL+fxPuwPwRedwZlL1dtYgx8alSkjFPVQ4rocPMyUE87U/9FhLe3XvwOEE3i7ZXJjE
 NufGtj30fKnaJ1ODnT/ernpeD/2GEaTJNN18qc7Pq9foqkw5+pwiQOTHH4/gFhpd3D2x
 1rQQ==
X-Gm-Message-State: AOAM530nwQ/vsuo4DUa5ste+0vpq/crkSuau2ZB1aMswrht6FV7A1aCy
 b66+dL3wXFpAZNZMuhaEuiecej8FNGwPd2UJzxTJAg==
X-Google-Smtp-Source: ABdhPJwuk0/g19UYAYl/TpIr8aAcNxkzyuvLc49gN+ATnAQHP92xy6prnRyezdBncOKSTkZm9Krim+AANfbRr2bTFwU=
X-Received: by 2002:aca:5152:: with SMTP id f79mr3823960oib.146.1591125244839; 
 Tue, 02 Jun 2020 12:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200518164052.18689-1-richard.henderson@linaro.org>
 <20200518164052.18689-8-richard.henderson@linaro.org>
In-Reply-To: <20200518164052.18689-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Jun 2020 20:13:53 +0100
Message-ID: <CAFEAcA9goz6quKG7zEGtOkYEUhfX10PB_MNMr6Vzvfz1OCZgSw@mail.gmail.com>
Subject: Re: [PATCH 7/8] decodetree: Implement non-overlapping groups
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 May 2020 at 17:41, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Intended to be nested within overlapping groups.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  scripts/decodetree.py | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/scripts/decodetree.py b/scripts/decodetree.py
> index 0ba01e049c..a9739f671d 100755
> --- a/scripts/decodetree.py
> +++ b/scripts/decodetree.py
> @@ -1021,21 +1021,22 @@ def parse_file(f, parent_pat):
>          del toks[0]
>
>          # End nesting?
> -        if name == '}':
> +        if name == '}' or name == ']':
>              if len(toks) != 0:
>                  error(start_lineno, 'extra tokens after close brace')
>              if len(parent_pat.pats) < 2:
>                  error(lineno, 'less than two patterns within braces')
>
> +            # Make sure { } and [ ] nest properly.
> +            if (name == '}') != isinstance(parent_pat, IncMultiPattern):
> +                error(lineno, 'mismatched close brace')
> +
>              try:
>                  parent_pat = nesting_pats.pop()
>              except:
> -                error(lineno, 'mismatched close brace')
> +                error(lineno, 'extra close brace')
>
>              nesting -= 2
> -            if indent != nesting:
> -                error(lineno, 'indentation ', indent, ' != ', nesting)
> -

Why do we lose this error check ?


>              toks = []
>              continue

thanks
-- PMM

