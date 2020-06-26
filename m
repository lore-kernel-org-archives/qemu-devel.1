Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B7AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:24:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5625C2075D
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UraXFW+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5625C2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jooKz-0000OW-Lp
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 09:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jooKS-0008Om-E6
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 09:23:40 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39599)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jooKQ-0002m7-Mg
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 09:23:40 -0400
Received: by mail-ot1-x342.google.com with SMTP id 18so8581328otv.6
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 06:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6v4KUOtWwsdyqJhOAij50HyooVa5temwCZtne/6b4K0=;
 b=UraXFW+rduRFVNjdWPBMt6YvwVv2+Zwo3MqCyXptDXVc+gLOzLqWFP7PRM2goXYMX1
 PQswvtuJu7Ai3qt0AVEfwrIW6W76ZmoZ4uUn0m0oXsRLoQm/24iLY6UUJXhEw0qXZSWK
 aaf1Pynl97lDB0XZWxDLdlL6R59cuRm7gYMLu1bIczugQwiABz+CP4y+ksEGjwwwR1Tw
 0JShSd5TtDOyJVBA8lrMJOkXj4byqzl7XmmGeML5QS+6FLdAHevr4kz03rDjOCj+3M4+
 SKw+BoWzAVHEmxK5HVUDGg6q+JbQSBWktkA07aqYLNY1hld2lWqQE4i2ofB4CXvWh0aF
 v5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6v4KUOtWwsdyqJhOAij50HyooVa5temwCZtne/6b4K0=;
 b=DOdGphpUBBiJVRHQejRAFScrKx2aGWrVq+5erVgSN20WQH7h0VZqVWJ/R4+KkY/vtR
 +kib+VjeNyJvTXDJlZ2b7bWxGDaTkne7EqKE/Y+w0bTsNQINVfZnb2SEAM6HEqu6g0H8
 wqjJ38oOAOI2+bw4kC9k4Nhmo1SjsNsnBjYd8c0FxkYgDBXTszaRMPzFiK7xZUSUOQfW
 wfZ7Zj5A5Iu+DXNZ9I7eO9/B+M36IYb1nMNqwsvJ3U0folaIeadwsHi4zCj8SaNajqDZ
 LAvGb5leGvrao45wAUBlTNDt3Mx/D0ATB3IKLY4mobx8cBncJDB0hrzOTZG13YfUGnvz
 332g==
X-Gm-Message-State: AOAM530F7jw/SCgK+xaKL9wqm9ibT462KOAwWkYMvAx3Up9pzIzlS1Ub
 OCI/6Xpz35jiQsizVyOfOQity9iyXz86PjOexd6qrg==
X-Google-Smtp-Source: ABdhPJwo3+dv4kcfvJ/oklHv7xfUvghuxZq6b28wfLwk3nPzPhdcdEVSHcFm8Bpm7bn8jVbl9JvptPfxvBuYF86u0WA=
X-Received: by 2002:a9d:5786:: with SMTP id q6mr2435528oth.135.1593177817291; 
 Fri, 26 Jun 2020 06:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200626033144.790098-1-richard.henderson@linaro.org>
 <20200626033144.790098-45-richard.henderson@linaro.org>
In-Reply-To: <20200626033144.790098-45-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2020 14:23:26 +0100
Message-ID: <CAFEAcA_tLoy8=ZJhmZhsHyCpRNBKOV1JG8ZJBhJHi6mMQ63AMQ@mail.gmail.com>
Subject: Re: [PATCH v9 44/46] target/arm: Add allocation tag storage for
 system mode
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
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
Cc: David Spickett <david.spickett@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jun 2020 at 04:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Look up the physical address for the given virtual address,
> convert that to a tag physical address, and finally return
> the host address that backs it.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

