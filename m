Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE9BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 22:37:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17774207DA
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 22:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cb+TFCbU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17774207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcGHy-0006ae-8U
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 18:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jcGHJ-0005rK-WA
 for qemu-devel@nongnu.org; Fri, 22 May 2020 18:36:34 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40999)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jcGHH-0003wq-RU
 for qemu-devel@nongnu.org; Fri, 22 May 2020 18:36:32 -0400
Received: by mail-oi1-x243.google.com with SMTP id 23so9438146oiq.8
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 15:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BpJAg1XIXd/ISIxTkFxzxRhLVvFnLTEUj2xmWIvEEc8=;
 b=Cb+TFCbUfYWx15RVsYhw0a3Z37jHFWmnnnX6T9Yir0ejQSw+Spk5OglNvy7pdvJVSV
 /9+HbkL7Wt36FGKWwSbY84EwXppE7+/DSMMscXpkjp/uYTdhOCUWf/QP1F0RS7NJ8eKQ
 Ihfhgj/QVwF42IHV1w5j8Y4PjkxZEdawt+SQXfHUHv3GZQke+qwdM6iZgmxbNfAH3YJQ
 g70SrWA9zouyAYH2zl0ZGLAUbUlh8fbKiGfyR1OPYQZZLwaEIt00yTTT/qaJAgZNxQUT
 lSCYw9PgIu5eLIs3k+CmISRxe5NMJbbD+J6F53kF+fWGfzzH/MAVjP6dGyiPtwQJKleN
 MhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BpJAg1XIXd/ISIxTkFxzxRhLVvFnLTEUj2xmWIvEEc8=;
 b=sG7lmfLdsC0F52CgzP37tgYVRstJ8z7TSMz42J7K3NN/Boj38TyxCjwiGSReK1fm9x
 RGh0OKLf7Y4z25s35lGHcFS1Nr9KVVI9ZVU1FZnnybFBlWJek1nq1PVQw/OlvUZLfpp8
 4yNl/4VO7uSFHJ1cO826WhvH87AVfA38xkLcGGKeyHpH3FbgNNFM3yIsKb3P7a+1PHfd
 4Hsk1q55pIs4rswXdDgcTQ8BNVKltKq2idrmFQBc1C/fhLprA6hJrk7ciJ0Ju235f5TS
 4rFCSyDat9AdS7O6A0+OS/RAV7snUNfbIOWxATAwbRPpwvJN5E4NzYgTCMgPMsvR5MHU
 VqJg==
X-Gm-Message-State: AOAM530aK9+EG5TV9pIrS74EuWoqy38n6TsZ/aU0tWZJbsdngCxCZ7Zo
 H2W/5TRy5o9a8Vl9RebeEX/ZxFxY/0A4mGcv8aa3WA==
X-Google-Smtp-Source: ABdhPJyhjXoyu2ejo1nLwGuTP7f624Rc/OKDEh0x3V52XQ0wBozORCCggnBx/USfb0qjs1++webFVSa9u51sH4KxU7o=
X-Received: by 2002:aca:eb96:: with SMTP id j144mr3881018oih.48.1590186989703; 
 Fri, 22 May 2020 15:36:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200522160755.886-1-robert.foley@linaro.org>
 <20200522160755.886-19-robert.foley@linaro.org>
 <CAFEAcA8gqM1vn4eV5XK-2qOQ47ugO9OsFWA_+MgRpO4Vb5JFOQ@mail.gmail.com>
 <CAEyhzFsS3g-OQ0JzcDVfaaKAt9632XmKfzC0tfy0VmF_RRB2Og@mail.gmail.com>
In-Reply-To: <CAEyhzFsS3g-OQ0JzcDVfaaKAt9632XmKfzC0tfy0VmF_RRB2Og@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 May 2020 23:36:18 +0100
Message-ID: <CAFEAcA-u_vAGtn7htspqkN56Xhb-WH_x8dF7GYs46zWaBLMEvA@mail.gmail.com>
Subject: Re: [PATCH 18/19] target/arm: Fix tsan warning in cpu.c
To: Robert Foley <robert.foley@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
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
Cc: Peter Puhov <peter.puhov@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Emilio G. Cota" <cota@braap.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 22 May 2020 at 22:33, Robert Foley <robert.foley@linaro.org> wrote:
> On Fri, 22 May 2020 at 13:44, Peter Maydell <peter.maydell@linaro.org> wrote:
> > Every target's has_work function seems to access
> > cs->interrupt_request without using atomic_read() :
> > why does Arm need to do something special here?
> >
> > More generally, the only place that currently
> > uses atomic_read() on the interrupt_request field
> > is cpu_handle_interrupt(), so if this field needs
> > special precautions to access then a lot of code
> > needs updating.
>
> TSan flagged this case as a potential data race. It does not mean
> necessarily that there is an issue here, just that two threads were
> accessing the data
> without TSan detecting the synchronization.  TSan gives a few options
> to silence the
> warning, such as changing the locking, making it atomic, or adding
> various types
> of annotations to tell TSan to ignore it.  So in this case we had a
> few options, such as
> to change it to atomic or to simply annotate it and silence it.
>
> We started our TSan testing using arm, and have been working to iron out the
> TSan warnings there, and there alone initially.  Assuming that we are OK
> with making this particular change, to silence the TSan warning,
> then certainly it is a good point that we need to consider changing the
> other places that access this field, since they will all see similar
> TSan warnings.

So is this:
 (a) a TSan false positive, because we've analysed the use
     of this struct field and know it's not a race because
     [details], but which we're choosing to silence in this way
 (b) an actual race for which the correct fix is to make the
     accesses atomic because [details]

?

Either way, the important part is the analysis which fills
in the "[details]" part, which should be in the commit message...

thanks
-- PMM

