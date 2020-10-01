Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8613C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:48:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 865C7206A1
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tBrqR7Ai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 865C7206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO0p0-0002CI-Jx
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kO0hD-0001ey-Ow
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:40:39 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634]:39800)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kO0hB-0003wE-Pd
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:40:39 -0400
Received: by mail-ej1-x634.google.com with SMTP id p9so8725390ejf.6
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 08:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Afj7M3pKyFDf82BCHFLt5lNbz7+/s62EDCcB5isXrsU=;
 b=tBrqR7Ail8IZM9gxuRr9KcbioAmCsvpsfDohZgO0vQrAF3gxV4WfxKPw3HQ9z/fl4+
 ECU/RFtL4+0OyOtJk+9rEi22me19cVRuYc+w7EtrZ7QAQ59Gt9YFojmPnvUqaC/cym7+
 KV5E4pxMfNdFpJ4hlYj2fAM9+O9OmX9vsvPowWom3zs8XqfRcJjjKgxuwaxbzflZUrd0
 ONKoZHhaGV8y48kCiBVL7PXbiP66YBolNLiSuDEf7mPh5tR+617FXf6WvRdzfcGENNRt
 +/5dcSYFniXBzF8BwTdpt5B8awRG+nN1afieQEJjkIK2wC6DsALIG/y10Q0dzixAn0SL
 8E1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Afj7M3pKyFDf82BCHFLt5lNbz7+/s62EDCcB5isXrsU=;
 b=D1dMADwadlg6kNgmuFJP/AvmAULLu749RPSrjgrRQa2fOu0bLgttyd2ckx9lMQpw6b
 3bmNtH6lUfeYPfA76JXLb850j9q9DcF28cJkG8xARYkPE/stHGmHWS99TeKR5XVI/tx7
 sulxUgEKN30JV7Dh2Z81WxfqcjoHos/P6P6kRWejeN44pXVgrXN4G24tlNhC++paZNdJ
 QzQqegFIroxf8HLx2RaA34c5VjEa0MwwqCyOl+l5Hx1xRkLMSBFk13lFTrfXaqm5PNG4
 tqWcnF/UY8wL5nA4RImTd3qqDzMqfy6mJdr+4/YUufuf1MHD7SGvTu2Co/RfWCyIkLSM
 942w==
X-Gm-Message-State: AOAM532foylouQb70aPk3GtJP1SsalRuzRULkGP44OeA/U33XsNYRZ8Q
 qck5VA8FIXA86rapR7vOwtkdmVZ5qSlFgMSgarjiQg==
X-Google-Smtp-Source: ABdhPJyh9eyLFk0tmf4xhb2twYwDU4tKpMnA6pVV3lVfvmgz62F0hg1zO0e47EC4qVOtWmlw9qj3ly6286LOEAargG4=
X-Received: by 2002:a17:906:4a53:: with SMTP id
 a19mr9152321ejv.56.1601566836157; 
 Thu, 01 Oct 2020 08:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200930174856.11296-1-kraxel@redhat.com>
In-Reply-To: <20200930174856.11296-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Oct 2020 16:40:25 +0100
Message-ID: <CAFEAcA8XyMo03tzDeopw4bSb3NXYB6NozKLPwqFxUxqk-+TeDQ@mail.gmail.com>
Subject: Re: [PULL 00/12] Microvm 20200930 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x634.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Leif Lindholm <leif@nuviainc.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 30 Sep 2020 at 18:49, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit b150cb8f67bf491a49a1cb1c7da151eeacbdbcc9:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2020-09-29 13:18:54 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/microvm-20200930-pull-request
>
> for you to fetch changes up to 7f6c3d1a574bddcda6931eb00287089998725f71:
>
>   tests/acpi: update expected data files (2020-09-30 11:29:56 +0200)
>
> ----------------------------------------------------------------
> microvm: add pcie support.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

