Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239FFC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:41:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1D39207E8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nt7XNOwB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D39207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmGKg-0001w0-5v
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 08:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmGIf-0007dx-3l
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:39:17 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:47029)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmGId-00053k-KL
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:39:16 -0400
Received: by mail-oi1-x230.google.com with SMTP id 25so8276815oiy.13
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 05:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YRgdsySkhJUAxDmmzByeHbt5ASUto+ff6rB+GwjpagQ=;
 b=Nt7XNOwBiZlxy6G62IrRmidcOxy0pPnJbOWNt2Eb1EL/Ovn2qAwcF081goHVpqcB9m
 6YSyVBXr1G+2nrHxYZwRb7FuWku/YBn366EzO4KYMRiiR7yajPh/nJfREmcDutDmRWxW
 Un4PxIcZ5S0bQiayatALRKP84zmqIOTn0BDApeBUii/h5ceCFwjmceEoiryYT+lk1BUo
 QIUgJEG7mGonZ6RkP+tSf0NN7MEc8FYnkkgOOCkWy3m3s1UyeQAUHPeocWDf8VW2a4Om
 5PgZ2972evDUnbvvKJ17+2kZlM28vASPnYtpqy2AVE3Wa1e0XAs2MumriCApUmXitSC0
 Q3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YRgdsySkhJUAxDmmzByeHbt5ASUto+ff6rB+GwjpagQ=;
 b=Zv90DDhG1sh1Co/24xHdlny31hP6d5MtjCHBGKsosRv1VDdQL3LFhDPHlwaPmTBueW
 UUaabUIkUn9kX0/vkRr0xTGUPzfLQSesAmnoNQfgfLwMaMuluw7NEO/5FKtiAS3HtRjI
 no7ywG6P0PZh/pBCx6PgucvexrV1+PXFVfIKVS5tsFGwXuT+VM4TVKRZkBexqr6KVD0h
 14T6me/w+96ctYRvVrILdQnbVEvsI0JrpXxn74uyStygNJgv0F/kw+XaW3TMux2y0Mve
 1hOCrJv+wmuDq4kwdv6M057V+HGNyIvW7rIS5EalsSS+ovf/Rs4hmf7CqIHFyBiIRLnH
 R0/A==
X-Gm-Message-State: AOAM5315go2ux7MZNEQUERog4VR8tC3YtxarWNGMUL1zwswbE3xuRfA4
 4RF51JG1nipmazgQEz1HlZ9QdbpoxXE1iU3Pd2RzXw==
X-Google-Smtp-Source: ABdhPJyuGag7zb6+FgxFsOqXs21ttu0wsyvNf5vp2UCHqfkLD1LcVdgClPCMElnB0ct4p9f7oczJRZxnhmgYHRhx1s4=
X-Received: by 2002:aca:1a07:: with SMTP id a7mr2820797oia.163.1592570354390; 
 Fri, 19 Jun 2020 05:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_HOxdK5rgKVnww6Bum3vGb=TrhDEp7oqDwsd=UbHmC_g@mail.gmail.com>
 <c47e9e4e-49eb-88c5-fdc7-8ebec121c165@ispras.ru>
 <f4fc4a1b-4054-cffd-0272-22c28d656aba@redhat.com>
 <CAFEAcA-=igrJfoiga7b7rcwZDj46nTNMiT2VEj11DKO7OiJpNA@mail.gmail.com>
 <1364f7e8-3283-8ca2-76f8-75e3eb74af7b@redhat.com>
In-Reply-To: <1364f7e8-3283-8ca2-76f8-75e3eb74af7b@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2020 13:39:03 +0100
Message-ID: <CAFEAcA-8aKX=Qa=i5pahhPTWOBx6MOWfo9ezhFFH+89du8Wf7Q@mail.gmail.com>
Subject: Re: what are the requirements on target/ code for -icount to work
 correctly?
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x230.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 19 Jun 2020 at 13:37, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 19/06/20 14:18, Peter Maydell wrote:
> > On Fri, 19 Jun 2020 at 12:16, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >>
> >> On 19/06/20 07:46, Pavel Dovgalyuk wrote:
> >>> I think, that we need some efforts from target maintainers to remove all such calls.
> >>
> >> I'll take care of target/i386 (which does need one of the three
> >> gen_io_end calls that are left).
> >
> > So why does it need it ? Why can't it just rely on "TB going to
> > end anyway which will clear the can_do_io flag" ?
>
> Because the TB is not always going to end in that case that is left.

OK, so when is it valid not to end the TB after an IO instruction ?
My initial belief was that the TB should *always* end.

thanks
-- PMM

