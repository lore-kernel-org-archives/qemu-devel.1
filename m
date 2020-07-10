Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3477C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:02:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 892C820767
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YEiRSt4a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892C820767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtuXO-000764-Jz
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 11:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtuWL-0006RP-Ka
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:01:01 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:33175)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtuWJ-0000rO-8o
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:01:01 -0400
Received: by mail-oi1-x242.google.com with SMTP id k22so5053280oib.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 08:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kLp7Mmn41ho74OOJMb8oyNchR1CoCv0nmdG1zJBn1LA=;
 b=YEiRSt4aIMjMYOarXf7Fq6LiVCcZUho0Ad76SkgiGo2QMRefbM6LBBcnBMqf048A2L
 pPjkP6PQQutLz72Iy1FEHhCnHUPRY8+i5GcjfpiVmv0knRs+g1FAgpQROjBEPFBdnU2F
 UQIs6mH4BMegTLGUc3LLLI/DEgG3LbggK6sMkBGXVFXQMq8A23m9SiwFueBz2gPG9ARj
 qcKUOCr8NIMZIbFBwaa4QQ56s+oxVKJTShcqlYl5XS82KuVjrYQEMPrAsRhFZ7FzF2yP
 sNJ6xH4cRwf68xq5vlYVtn2ASmrgEHak5lUDj0e3vJoqNtTnxzaV5vv1w2Hfk/mOU4fB
 DFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kLp7Mmn41ho74OOJMb8oyNchR1CoCv0nmdG1zJBn1LA=;
 b=tmUUNLSyztMO/AZFJXOW4s+3aPF1L+0Edm//ofX7SI2z+x/KyffwjAq8+n5Blm4C9s
 eyQoC1H029nhqVYh7sbIqHePBNPUSzGIASax9j7DLxrtQs0PvArcLJ+enwA4tgw6Bhkr
 JE1o+Y6+rNmSugbrS8dg+62PixOY9RgLzPJ9AUey8pzg95RaYWQ8tdqOSh0E21V3O8Fo
 F+zpa8edNR49jUnYAGI5/gbgk/9NdNyxvDZ0P2qYDHVvIjpGgqKUs6PL4gDYWBeFgoZP
 uoVWPOL6j0fC23yZT+uFQlw643GnvVpVJ3PwfUlS2IDKVkjIw2Or2teJ/6uMbPwkT9TA
 ilMw==
X-Gm-Message-State: AOAM532Lm3B2U5qiB9lLcY0T5it3Lfqo/DuhmYKK8321jX9eB0rCxokn
 Q35nC//ZO1Y17qDR7HWggaNZzKxjY4Mp95u25UssaA==
X-Google-Smtp-Source: ABdhPJzCNL8l6f1v+ct/3IqChwHXIJ1VDC/1LZcFsKjoljDXe6IJAkIHNthQGO0/ClMBldBUPLlaRN1qOnpWqJc7Etc=
X-Received: by 2002:aca:1706:: with SMTP id j6mr4318517oii.146.1594393256520; 
 Fri, 10 Jul 2020 08:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200710045515.25986-1-thuth@redhat.com>
 <CAFEAcA8vdzu0Td320VxOFHM9+Q3oxQ0ER9-FF4iOS+GsGuc=Zg@mail.gmail.com>
 <62455702-cda7-9918-1dca-92f7644fc82e@redhat.com>
In-Reply-To: <62455702-cda7-9918-1dca-92f7644fc82e@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2020 16:00:45 +0100
Message-ID: <CAFEAcA9FbJXcX0WyJSnGdQwh_3nMCG579TZnqRQTytszbbgvVQ@mail.gmail.com>
Subject: Re: [PATCH v2] Remove the CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE switch
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Jul 2020 at 15:09, Thomas Huth <thuth@redhat.com> wrote:
>
> On 10/07/2020 15.25, Peter Maydell wrote:
> > If we're going to mandate "at least gcc 4.6 or clang", perhaps
> > we should have a sanity check for it

> It's already there. Look for:
>
>  "You need at least GCC v4.8 or Clang v3.4 (or XCode Clang v5.1)"
>
> in the configure script.

Whoops, should have checked there :-)

thanks
-- PMM

