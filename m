Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA43C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 19:13:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E20FC2072C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 19:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qVlnmQgL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E20FC2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYZpo-0007L5-Ls
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 15:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYZox-0006nG-86
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 15:12:19 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:32862)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYZov-0006HM-19
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 15:12:18 -0400
Received: by mail-ej1-x642.google.com with SMTP id 7so10104325ejm.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 12:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=a+I9/Zjvz2J5eLjkQXvFz7xCwkpDBv1az2NfHEPAieY=;
 b=qVlnmQgLUvucO9BykMfnvSMo9H/sq/HGSi4aRWzZwlF2QIMb1dp/P6Xa4F+uEbUHqp
 yVhZQJU6R4E+oLmSYAugKFG8L73ZCNEUasWKwkE3u+kSMr/sDM5wWK4Hm8zdCusjHh/Y
 Fe1ucJa8PFbS8VdF2FqZvDPelgccpeRhQgbH+m2VTuy82FdN1f5on1XEh2G2BPwYweR/
 2VMn9GGIw4eIoz1F4N8vnPw2/oa37tSiB2D/jWVy19LZPvEQOo8Lc6+nXFN77qPE74Vm
 R/tPZZGv+yhjApH2cZhGmdRCOsAHmcPeuKqv/v3B+/FZrzF0MtEPq7cMfXoE+rdPSAgQ
 XM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a+I9/Zjvz2J5eLjkQXvFz7xCwkpDBv1az2NfHEPAieY=;
 b=S/Jej7HN3OtjQORfVBuT7FiprbOIz1YP09WKF+kSWi6URsFMnuO159dqG509R6BDYa
 sAOn5r/Ef+s4DXtgbNbCHaURxRwWq18XJPdJUeknLr/SE0fI811h+lO2S0PaD5x5uiiG
 +saHmI3+aJ/T28gsjC0+tfLk1p/kJBomnIWHZZHDIu0WVMzsI/t/mZ7/3IHMz+VYo9jF
 Fno1IHi7HtvJ8wnKaiOYV15VPdAEewA7xpw5bxUC0Y8A5L4Hx+jPaptjuqoD8UK2km7c
 /aWZAgQi56TEC/he1YDKPAvUnoTSK+8KieOwKzeXZ48Qu4ryGjIYSwiGjhSE63vvqwhy
 0+Lw==
X-Gm-Message-State: AOAM530MjDoDdYlTas27T0IZfu8j1YglFbgGtUpvby2w/+/EGJBg4H8o
 wuQyFpakEEowNCGFjWct43dj2AiKHWugu7HVh8ImCQ==
X-Google-Smtp-Source: ABdhPJzd+ZX1TduC7Z6aYQaTr8E4EU3pJYy7z9bI5TwvfVIRXMC9Mmv2CiMCy2weRSzDrHQKXzW6I9KAxs7y7fbh6hk=
X-Received: by 2002:a17:906:3b59:: with SMTP id
 h25mr4257946ejf.56.1604085132514; 
 Fri, 30 Oct 2020 12:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <20201030174700.7204-1-peter.maydell@linaro.org>
 <7ef49ead-40e1-1705-afc3-e94cac2bf5c9@redhat.com>
In-Reply-To: <7ef49ead-40e1-1705-afc3-e94cac2bf5c9@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Oct 2020 19:12:01 +0000
Message-ID: <CAFEAcA-qOWGvuzyvht+J_kmj+gBvqPdhiMPVj67R4ds50PjfPQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] docs: Fix building with Sphinx 3.2
To: Paolo Bonzini <pbonzini@redhat.com>
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
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 30 Oct 2020 at 18:20, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 30/10/20 18:46, Peter Maydell wrote:
> >
> > This does mean our kernel-doc gets another patch that makes
> > it diverge a little from the kernel's version, but we already
> > have one of those (commit 152d1967f650f67b7e). I do want to
> > try to upstream these to the kernel, but that will require
> > more work I suspect since the kernel makes much more extensive
> > use of kernel-doc and probably also has other issues when
> > building with newer Sphinxes. For the moment I would like us
> > to release QEMU 5.2 with docs that build with all the Sphinxes
> > we know about.
>
> FWIW I've sent to Linux our other two local patches, and if you are okay
> with it I can also do the sync in the other direction before 5.2 (the
> plan was to do it afterwards).

Probably safer to sync afterwards. Do you have a link to the
patches you've sent in the Linux direction ?

thanks
-- PMM

