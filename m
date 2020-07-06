Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E15C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 11:34:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 892992073E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 11:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ASWZAnTH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892992073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsPOH-0003On-O5
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 07:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jsPNR-0002fv-Ii
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 07:33:37 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:34069)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jsPNN-0001UQ-PS
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 07:33:36 -0400
Received: by mail-io1-xd42.google.com with SMTP id q74so15347067iod.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 04:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tZGkrNl8CzTBjY5AC4TjWc0AkVA9Eu53h+1+B6Lf/kU=;
 b=ASWZAnTHVIcczfpx0tumasTWPoZ0ZQokqU81ZL/P+BjrXrnI8abkjRiWlcACXAjErP
 PhA82OHQG7czTz4Q3GxPDhJyKtDbFD7Pcdrh9vyvlZXa5h2RMAsnR+mK6ezYuH2Up/W0
 IZ7yI8fz9K52dVFrPChE6hEXyJY4CvU5eg4F/6Tt/ozNS/sGf3PPu7/kcZGVHrOVTAgg
 S9ItUol/jxJr00WySCrbJuMKYkJgWDLhT3XG78cvEiaoGATTXh+ysM4JL3t6gHhrj3gS
 TOWkM1EnF6rtkmKJeJVnROfhpinL1Q/25RIQoGrUw3jDLmBwBk5f/UNaQqhHCHjk1SNn
 MScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tZGkrNl8CzTBjY5AC4TjWc0AkVA9Eu53h+1+B6Lf/kU=;
 b=Ohd3PW5hXlsmqSdCwn+WCDH76xV5Q2dW2bVQvPA68hb6jMTZ2r2BMHRVapOfXgJWRB
 VGjRZSZHGz0dgdJDKc8pHn9M6tvQp3d98MYGAkhoRDUUzZZFNSuSaBXP3QuMdgJFcpfG
 5n9JLMFMt4BsN6OOsImtgAtVXvnyCrfl1fbqkxNiZIRuzjzKWglNxAyics99EX+G79Xs
 9Gk6SA4ZLZ3hE2+mkEZaCtUn1i/thA1ua8RrvutEBZSlvrW3ov8uQ6w/QAxVdNlZpCLV
 ekSXpSsbXYiqe4R4HNNiKIit3ty1+y5TNM97oABxjjNu4ozvYFsgjoxeqVEA+8feXI00
 ECwQ==
X-Gm-Message-State: AOAM530pXU40nNoH0BvwE0saxsD07Tz5CXQnZKu7iMkAUc0azf/dASNl
 IoLtAqAScSaJh67lgbKjKGfSLjwu/Mqrf9F+pIZpnQ==
X-Google-Smtp-Source: ABdhPJyXiOgXeD0ioYUDwi6V02F8ZVi33E9fP0lnUCINIsIBi7lkDTNn8dL1CEjaxJZHLML/IkEgjyUXrxnzZ4vG5Uc=
X-Received: by 2002:a05:6638:14d3:: with SMTP id
 l19mr52759436jak.25.1594035212431; 
 Mon, 06 Jul 2020 04:33:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200519185645.3915-1-richard.henderson@linaro.org>
 <20200519185645.3915-2-richard.henderson@linaro.org>
In-Reply-To: <20200519185645.3915-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jul 2020 12:33:21 +0100
Message-ID: <CAFEAcA9snF5B7w1HLSkwxCCeXep-iYLC1_0J+Pn7zzjgkJqD+A@mail.gmail.com>
Subject: Re: [PATCH 1/2] linux-user: Validate mmap/mprotect prot value
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=peter.maydell@linaro.org; helo=mail-io1-xd42.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 19 May 2020 at 19:57, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The kernel will return -EINVAL for bits set in the prot argument
> that are unknown or invalid.  Previously we were simply cropping
> out the bits that we care about.
>
> Introduce validate_prot_to_pageflags to perform this check in a
> single place between the two syscalls.  Differentiate between
> the target and host versions of prot.  Compute the qemu internal
> page_flags value at the same time.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

