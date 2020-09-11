Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68147C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 15:53:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C952521D7E
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 15:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AUy3LNkB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C952521D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGlMV-0003Wc-Cd
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 11:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kGlLK-0002BQ-5c
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 11:52:06 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f]:46047)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kGlLG-0002jU-D2
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 11:52:05 -0400
Received: by mail-ej1-x62f.google.com with SMTP id i26so14405718ejb.12
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 08:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=905/LmpI1rmTbzQvyJT7mh2m5Eyt7bbtxYznlZ3RBaI=;
 b=AUy3LNkB0kAB7CVPN04aeBzUTbFmI5PqLxNTCCh0GuokYYSPWeucQppDJGFoGw2gCc
 UC1C8x7CiT24CAkZR5dT5Rp8qAQ6R/fA12t9MeRWExQu+SR9O7rpCVoSKz4Y0DoPhLZR
 fW8RqujRjbN8sSCcgaLoqi282uSGPIWoK0DqirUHrfRyuMNaB3shSKz5oe5xYQYlNjwG
 0dVC0LXnwxHNrh9Ygc/tPXWoAgcM4Dl38/A/sqjXqTyA1cuB+8itTgh8Y66hRu1IIiYw
 49KTCi2/plEgdguEVX11q1JMtXWDpBM5qR6ujUdKNRUhb9tLQCl+1HGFX1/2zkzog595
 d95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=905/LmpI1rmTbzQvyJT7mh2m5Eyt7bbtxYznlZ3RBaI=;
 b=T/zagjeoBfdVPyxGyeRhlHHRDOSlR3nqo+q1Zlpu+0ofIuUOTquWWeLsQv00nN4NdM
 bOn63CfoSZKqEb3aBrWnc1sIFAFcj2eWv0fKiTy6x0Ji/rThB9UmOlAWX/tGgXbOzQ51
 kiN4rJdPZnCiVCrVixpZMfrXrxH4XZlkl2GSDHd9uSpesUEdeRdhGXTGncFTpNuZOjMv
 SuG+msiadfiUQgqgZJNAuRQU8O3rfNSQywDadzrXbWiupHCyS24Q1OHJk1aV4RNnMsK9
 HMFvxhKDRDbDeu9hpcw2Fm0ltZAtO1Ac6RComPhBXG8IlgtWlBf/GWNlwLedoQLdrrn2
 ZQ9w==
X-Gm-Message-State: AOAM531kjMRHpluZGcAxVGgVQ5ZV5aVSyysKYby8DWueJtSZ4VYVa/AR
 Wb/A3yxCudllbPezW3NkeUegGAAOVKd5aytqdeY5vw==
X-Google-Smtp-Source: ABdhPJwgdtmTN6N0YRdTELR66ro07JQFQtcZRXHnQQC/WHpkAVqRP0fLF7S6P4qEXylRaGBP6/gdjKYffE5akddH6FQ=
X-Received: by 2002:a17:906:71c9:: with SMTP id
 i9mr2638308ejk.250.1599839520807; 
 Fri, 11 Sep 2020 08:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.YSQ.7.78.906.2009111910280.36374@xnncv>
In-Reply-To: <nycvar.YSQ.7.78.906.2009111910280.36374@xnncv>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Sep 2020 16:51:49 +0100
Message-ID: <CAFEAcA_9BVbqFCHJqS8jj6L3OqVNc60NCjAjRs516VyLH2EFfw@mail.gmail.com>
Subject: Re: About 'qemu-security' mailing list
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62f.google.com
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 11 Sep 2020 at 15:22, P J P <ppandit@redhat.com> wrote:
> Proposal: (to address above limitations)
> =========
>
> * We set up a new 'qemu-security' mailing list.
>
> * QEMU security issues are reported to this new list only.
>
> * Representatives from various communities subscribe to this list. (List maybe
>    moderated in the beginning.)
>
> * As QEMU issues come in, participants on the 'qemu-security' list shall
>    discuss and decide about how to triage them further.

Way way back, the idea of a qemu-security list was proposed, and
it was decided against because there wasn't a clear way that
people could send encrypted mail to the security team if it
was just a mailing list. So that's why we have the "handful
of individual contacts" approach. Is that still something people
care about ?

My question is, who decides who's on the qemu-security list?
Is this just "it's the same handful of contacts, but they
have a mailing list for convenience" ? It sounds like you
want it to be a larger grouping than that and maybe also
want to use it as a mechanism for informing downstream distros
etc about QEMU security issues, which is to say you're
proposing an overhaul and change to our security process,
not merely "we'd like to create a mailing list" ?

thanks
-- PMM

