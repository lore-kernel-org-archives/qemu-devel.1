Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA877C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 17:00:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84DE5205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 17:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UUsg0ciF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84DE5205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAFq0-0006Ci-Hh
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 13:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAFpJ-0005fJ-LG
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 13:00:09 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:33755)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAFpH-0002w0-2s
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 13:00:09 -0400
Received: by mail-ed1-x542.google.com with SMTP id w14so8223071eds.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 10:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wZbw3UHMSz+IRsH/75+LtFDjuBJru32Zz03dInUxx9k=;
 b=UUsg0ciF7SJBslFA642HmTUl2nZekwBBGkVmwhlEm4cB3qtydtvoXENaMsOOjrrzUW
 zZFQ89NpRzVDOAxRDYB9BcHUXbW/cRBxZfgtA+UDh+CZsgCPu3V2lcObQkg2BqdGxihm
 CnQ2Nj3r2/SFBU30fN2Md6ixuARzrgoQ6IOV1yRHFrJKBGYd7HGBw5PgpjC4LBgijy8b
 aJr9g5q1cs5Q7qkdSKYBTOjC0A5SkDBTOnjgTOaeZdtIlxwhDfMJl+vOZVqPwoND56Eo
 ohZbgQLbNDepN3SvZXn5fwVP5nGVxd3EpJ+sTy8yZYReeHAZIe+EzmX1B5mHkq8/fslk
 cM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wZbw3UHMSz+IRsH/75+LtFDjuBJru32Zz03dInUxx9k=;
 b=AbQok+JqAVOD+KPtpT+9Ih/GYrGZABOLkcQ56Hb2hZVFx6hGVz/+PwOEdKzy3tStTV
 Owloqr7VaEwu/G27hOC447P2axT/sah/iYgePQd1ZlDTrnJsuwX+pVmTj/uTMdltjFgA
 3sLhyOUIwAAhacbjSCv7zWn/tcZZ0d2WwWOnX4bpIbkqFhEFvR+IrKFR3Et3eeWuKUnf
 wEDiQIW+PypkakMl9/YJ80wDTKa4iV67OnJM8A6DPYBpq+11kFq3u2Nfuda/l0jLmz7o
 xaUEgj8S7XWaRIwuxqjIINO/YFRt7mo7xs8S3RgltrIFCWTEBDdDPMCVp9my5GDDFZqE
 FTUg==
X-Gm-Message-State: AOAM532mpzAgWXxlhbjnWBKqyw8vYPKPUYJyrzt7NtsYJeGAKBaF4DS+
 rit3GnXqZALT5ffzW0vMCHnQe+xAzQPcwmykE+ycKg==
X-Google-Smtp-Source: ABdhPJzer0NKcr8SN5BNzXHf8MVJHYRJ8XmR2CCGBsZjJ5XqoKMwa1Alv0+7FC6wtb/cFBfZ/eHicUQ/+pj95WIrEE8=
X-Received: by 2002:a50:da44:: with SMTP id a4mr6489203edk.36.1598288404708;
 Mon, 24 Aug 2020 10:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200815013145.539409-1-richard.henderson@linaro.org>
 <20200815013145.539409-5-richard.henderson@linaro.org>
In-Reply-To: <20200815013145.539409-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2020 17:59:53 +0100
Message-ID: <CAFEAcA9a1m1w6=Ohdv1x0YpFioWLxV+AKSsi4BpHAv196c3raA@mail.gmail.com>
Subject: Re: [PATCH 04/20] target/arm: Rearrange {sve,fp}_check_access assert
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, 15 Aug 2020 at 02:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We want to ensure that access is checked by the time we ask
> for a specific fp/vector register.  We want to ensure that
> we do not emit two lots of code to raise an exception.
>
> But sometimes it's difficult to cleanly organize the code
> such that we never pass through sve_check_access exactly once.
> Allow multiple calls so long as the result is true, that is,
> no exception to be raised.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.h     |  1 +
>  target/arm/translate-a64.c | 27 ++++++++++++++++-----------
>  2 files changed, 17 insertions(+), 11 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

> diff --git a/target/arm/translate.h b/target/arm/translate.h
> index 16f2699ad7..ad7972eb22 100644
> --- a/target/arm/translate.h
> +++ b/target/arm/translate.h
> @@ -64,6 +64,7 @@ typedef struct DisasContext {
>       * that it is set at the point where we actually touch the FP regs.
>       */
>      bool fp_access_checked;
> +    bool sve_access_checked;

Is there anywhere it's worthwhile to put in an equivalent
of assert_fp_access_checked() for sve_access_checked, or is
there no point that's both (a) common to SVE accesses and
(b) not common to generic FP accesses ? One could put it
in pred_full_reg_offset() I suppose but I dunno if that
really gains us much. The existing fp_access_checked will
catch "forgot the check entirely" which seems more likely
as a bug than "put in the FP check when we wanted SVE".

thanks
-- PMM

