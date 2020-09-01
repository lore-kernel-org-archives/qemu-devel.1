Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A881C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:57:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F453206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iJPso4Qu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F453206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD5qV-00014V-Dp
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 08:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD5pW-0007wZ-0K
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:56:06 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:38416)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD5pU-0002hh-E5
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:56:05 -0400
Received: by mail-ej1-x644.google.com with SMTP id i22so1481417eja.5
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 05:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1J2vSdyTtg9FrxAIybA+DnjZDIQEV7Yg4BzOl495Qfs=;
 b=iJPso4QuzDt33drrZ5NiIOdAG4v9B7bIullyKKK1p4jH4sw2AsdQWIObYBCsG/upxO
 xFjMKsb9gc5Z4GCCaudoaEKpMWorsCDFgbugXb/sIqab/acqXMSgyIbbVMFOau0jCd1O
 1W+IW4WQ75WJ/g8ByjDKGSElgYDjlwFTmVFcqzs0b9ZhWhK3H2Lhtjy4Y9VcaXMfvGNz
 GVvsV0hM+djRly6GA5iuXaA524eUYHzVPUg7n0N2/ZuIkRgovbM4T94QD1JNem9C/LWa
 sOpkTfxRy0VfNKzv4SYfQeyChvDawj397f2HmhTSfa8MMh2/5WU485QCV5b9N8AILacL
 1e7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1J2vSdyTtg9FrxAIybA+DnjZDIQEV7Yg4BzOl495Qfs=;
 b=Mgj3qJvJTxBE1Of8zEu7hPxPq+8PQsfuJXK+bTrxiZzujT3npO5EKRTmKfSX1oUfUf
 AAKBH1NKWNoVy6R9Rdz0533p0hKT1pbCE8asGuC14TwM/orydlJKWxWhz+gBiYeWynWM
 9uU4GWTYlz9ZhMSsBQ74RR6l3rwQ5ftbd88wencbZJZGXtM5dI6yW2T9Zmg4jBr7T7k/
 o9JXJ9DdA3pApEHxFyxUEABJ99/qyN1L0V3zlRrc2tPqK8UR6UqweMCCxUsm0qc/3iKC
 PhoBHk7SNl+dFt2OmjwL0dWzjiVk65UhUkX5aOMzedOYMd9zzlC/MOEsLzJ00opYjlXk
 lokQ==
X-Gm-Message-State: AOAM533r3KYw3zC61DHe5AyZAlyflyF/eNOoLsNLaSNPZOQnlzLNs1v3
 0snsKB/zo9um/c36wYiNb6R7F6LM4GYeCs9XrqxQ8Q==
X-Google-Smtp-Source: ABdhPJyXlw5PFJ8VAbXDek7Q7nQhf4tDnD3O8BqDiwh6/duKXPqq4bw7l5iCqyoWnrAN9ocVCpVrgPs4cIeJjelMGXc=
X-Received: by 2002:a17:906:f28b:: with SMTP id
 gu11mr1275999ejb.407.1598964962965; 
 Tue, 01 Sep 2020 05:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200827142915.108730-1-stefanha@redhat.com>
 <20200827142915.108730-2-stefanha@redhat.com>
In-Reply-To: <20200827142915.108730-2-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Sep 2020 13:55:51 +0100
Message-ID: <CAFEAcA_Qg5pBMkw2HjNwhBBhKwW9=h-rXUOtxHjTzFmu2bHA5Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] tracetool: add output filename command-line argument
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Aug 2020 at 15:29, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The tracetool.py script writes to stdout. This means the output filename
> is not available to the script. Add the output filename to the
> command-line so that the script has access to the filename.
>
> This also simplifies the tracetool.py invocation. It's no longer
> necessary to use meson's custom_build(capture : true) to save output.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

