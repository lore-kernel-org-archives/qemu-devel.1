Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1E9C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:28:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32D0420BED
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yQ7avooO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D0420BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUrgG-0001L1-6M
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 09:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUrX3-0003iI-IS
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 09:18:29 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:34017)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUrX1-0007YC-Qi
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 09:18:29 -0400
Received: by mail-ed1-x544.google.com with SMTP id x1so1821236eds.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 06:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vT1G1kvK3lhqk11HtM78VdvxvEcSlQA8MO76SiygWQw=;
 b=yQ7avooOSX0g1FVsUiH6bWuLn/Otxr7emUZ58/64hNGiaXa7tAdsamRzKPO74qcwww
 WQcdPnwS40MaQSL0oIB4adrA9Xf6KHmqycQTNXAgKZJu3gpEcVwbyrlzEiTBJOVNH+us
 5b09l9mBLN3xOtAvAod9BASi9HCm6lEWcgc2UWI/6b+GZExY0wx3HMxwOXFaCygQmtoe
 o1rzkaelBTJRipm6N0pwhVUpY8BmbuHj1eHFkxcXTAFXJPaAjyRp9YpN/iamU57G7bQb
 YoErp71UjxgwaDntElSdr6wRiL6sdyRg7d2sWOgGeFxz/Ydie/aEnZc6+2gGwuVUzWXs
 8BxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vT1G1kvK3lhqk11HtM78VdvxvEcSlQA8MO76SiygWQw=;
 b=Z/4w0FSkboaMI95vY0be8DU7p0fzGEZBB11/kyu/298WMEgOuLCjonp405AOdT1s2s
 yYIyDhgXTpqnXhiPAI+n74lnawyqqgbn4ZkJ1ECW+oMqHTNIgpI/k/QmTpcm6Au18Xuv
 Hio17T+s218XXRYIwWzCpjSdi+AZnN32JqrsuIuH8GxfMFH6gb86Am+JQwzFCpAbsxsz
 nW9t6lOjgWjf162a45suGWJFHTMAG7nHGvehu9GNIU3KigEzQ+nAuICrIRPgeBDeXdFS
 PT6fNkHk+cOLVHBTznBMVW2Mb6kmmS3GNy0VxiJkbIMf+1gFM0FoEFFx8NbPCavwHZBg
 C5Sg==
X-Gm-Message-State: AOAM530MIQO3COwgc2cutF+XyGA08MfLbWLfLhzTNBEOkywQWU19Bsh0
 V//YLW3MfpwCz37/RQdZ6NU23guZTfJmvdrOrohrpw==
X-Google-Smtp-Source: ABdhPJwYyQVOuwDGI7hr2YWVJAkz775gi95h6qZSdsAMRW/HkDGIJ1MEDE6VClO5W5lJ6j5EIGEOT9o1dtlfU//srDQ=
X-Received: by 2002:a50:d64c:: with SMTP id c12mr2671633edj.44.1603199906167; 
 Tue, 20 Oct 2020 06:18:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201015095147.1691-1-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20201015095147.1691-1-e.emanuelegiuseppe@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Oct 2020 14:18:14 +0100
Message-ID: <CAFEAcA_uJA1eihsR-OCLaGMqJpTjHYrhD4aDYfQtXX=5GrmxYQ@mail.gmail.com>
Subject: Re: [PATCH] loads-stores.rst: add footnote that clarifies GETPC usage
To: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x544.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 15 Oct 2020 at 10:51, Emanuele Giuseppe Esposito
<e.emanuelegiuseppe@gmail.com> wrote:
>
> Current documentation is not too clear on the GETPC usage.
> In particular, when used outside the top level helper function
> it causes unexpected behavior.
>
> Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>



Applied to target-arm.next, thanks.

-- PMM

