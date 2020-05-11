Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7D2C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:24:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98A712080C
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BdvMGhsl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A712080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY5bl-0005tz-RV
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 06:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY5XM-0000Bp-SZ
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:19:52 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39300)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY5XL-00038O-OS
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:19:52 -0400
Received: by mail-ot1-x343.google.com with SMTP id m13so7092634otf.6
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 03:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6p361W+9SNoRv3u3+vgwbIUzgFekB4gxuXrzmtgq1rM=;
 b=BdvMGhslcO6EF62v1y1tsezno584rxCKYhfnJ4xGDM/KnJo8eoR0p3tl8EpttXKW3G
 ffHHME75nSRQ4Y4XcxQU97rxp5Kzyb2D43L0vx2a5P0eeZy538lYh8m1PEspu32F2NfX
 f5YO6AYTkRnWGei5/Lu5ySHSwa94BNSnd6lmpb4tE3sDAuv2YZSYtpm2BkM6ERyeYaCM
 B2hC1EH0S5nWO+r+pUmJu+I4BWktzzex9BLDDvLRSJUpktcbVItO8s5QuGOp0LPZwwlO
 eT0OR1d+kSCwhjhVpmOC66huFOosnKPtsFphGJTlujy8wxG0m64F7igOF7R2HvxNurIa
 UoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6p361W+9SNoRv3u3+vgwbIUzgFekB4gxuXrzmtgq1rM=;
 b=BrGHdzeqhYWP6Q8gDYlj7emotjOzfEVRnDrnOecN60CoZX0nxCWAfh6XYSAerloBBo
 C8U71JPhm6unS0RuUOXrYJUr+p2Mace7z7jMYg1bf8k+MaqbAJPHn4JXXfM0clMcPgGh
 Um56vVV0wGH8JzePMePOOnnb50/nY4XYntFpoXnen/oyQkppzK3VGEUyJjcsMT2k1nuU
 tXUfgLq6vcS4dkLRhfj6fGR8zoc6lYX5wBamwPpTKtaEdpKSxXk2EEYDfS6NAhPkl2BV
 8xIhZEK6TYv5H8YvcH/n8uPoLpfqc9HrEK76ciZTcoM72HRHoeTNhtGh3K3aFaf9toD5
 JMsA==
X-Gm-Message-State: AGi0PuYzn3d0zCnRIkG6uZW42QV1BZtMrG9kUN2kesptN5Rz0HdnNx62
 u3843w3IMqw/okRo4XtNJ4QGHBB3IzldaKEMpTDIVw==
X-Google-Smtp-Source: APiQypIW/Tzn6P0IdTmHXqYVS3Vx5mG3OLonazxAC9EE2o2mgKaLkw+o2ywwqgqwBK896q22epxanAjn0qm4PXtSRkQ=
X-Received: by 2002:a05:6830:1e4e:: with SMTP id
 e14mr11855173otj.91.1589192390336; 
 Mon, 11 May 2020 03:19:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200508154359.7494-1-richard.henderson@linaro.org>
 <20200508154359.7494-5-richard.henderson@linaro.org>
 <CAFEAcA-9bd11QTUGYdta+pDRFvd-9qtiBiBCGUCCX7Mi+swQbA@mail.gmail.com>
 <62eca244-78dd-0359-d82b-30089d893d39@linaro.org>
In-Reply-To: <62eca244-78dd-0359-d82b-30089d893d39@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2020 11:19:39 +0100
Message-ID: <CAFEAcA9wULdkxfzr0BDknqGpB6zuJjQXkvzL4WbsoMiZpfOOUA@mail.gmail.com>
Subject: Re: [PATCH v5 04/19] accel/tcg: Adjust probe_access call to
 page_check_range
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
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

On Fri, 8 May 2020 at 17:57, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 5/8/20 9:13 AM, Peter Maydell wrote:
> > We've gone round this multiple times now so I feel like
> > I must be missing something here.
>
> While probe_access() has a size parameter, probe_access_flags() does not.
>
> For probe_access_internal(), I currently have a "fault_size" parameter that
> gets passed to tlb_fill, which is "size" for probe_access() and 0 for
> probe_access_flags().
>
> I *could* add another "check_size" parameter to probe_access_internal, to be
> passed on to page_check_range(). It would be "size" for probe_access() and 1
> for probe_access_flags().  But what's the point?  Always passing 1 to
> page_check_range() has the same effect.
>
> I feel like I'm missing something with your objection.

The thing I was missing was that probe_access_flags() doesn't
have a size to pass usefully to probe_access_internal() and
so the size is zero in that case, but that tlb_fill() and
probe_check_range() want different values for the "just
tell me about this address" case.

thanks
-- PMM

