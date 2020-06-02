Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070FEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 19:17:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C45A1206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 19:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iSaG6kJg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45A1206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgCQ6-0001M2-0f
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 15:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgCP2-0007xM-R7
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 15:16:48 -0400
Received: from mail-oo1-xc42.google.com ([2607:f8b0:4864:20::c42]:35641)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgCP1-0002kf-W3
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 15:16:48 -0400
Received: by mail-oo1-xc42.google.com with SMTP id e12so848oou.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 12:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ic7fPz06RaWkgr64ftTjkfkKW1JNWUsa+NLTMAHbEVw=;
 b=iSaG6kJg1zB6sYpmQfl2djcDyKuTV2hjSzG2mQGK2BQ/ydnGysR0s/kXWH8WqNYqAM
 h9RoMtolIS7L9xGLZBdO4fbq8k9oZjAPeuZfMwbqhx6nhnylCqq86u8a8zhHwISBA/Sk
 hfd1YeglDcJOHwJpxnyDmYBm1B8+vcSP2P36CXcfuwSbiWmu9PbarwMLebgUAQTcx7gn
 CkPJXbyhq2Bn/lMmM54/U19TLvcR9Z7+wAkzLhywR4tw2yOTYsXrnQBjx/5r9vbBqy0f
 LftmfHXkQ4BXnVw6wBGjUXvxnD/DwBynkthJBLwqLd8S6tP90wunp3XMW7F+wTkb86dN
 8evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ic7fPz06RaWkgr64ftTjkfkKW1JNWUsa+NLTMAHbEVw=;
 b=sDbLXXCKWStuPT7/RhmAsvI5aQF1U1pYX8kDQkBZnm01lXpRK37CZgUBnVjTKFnpOK
 fbQv5Cz1QxaJmFOenJQCtbrCd9zm6sj9E+qqkX18y3/8yScesnv/5IW+4+oI1+sLJubT
 YHC6LR82DQ+g2zfV+1w5CTL2ECLnV8ll6XhFlVqjmiGfXOTfxq9enExdBjwP/t/DgVWk
 G3iWqRZZR79qXlNN3QaiNu/QRjTt/U9CkjZbxlUUR/r+Qg4CWiHcAcqt7avfLO1L+pCQ
 u4rcb6YUlnYHoH7g/D75AFgpFRwgtoLAJS6LqnbdY6LdyrxIui2XfO0tIwdLnflCrL3T
 93Wg==
X-Gm-Message-State: AOAM531C0XhDofyHO29F+OZK9dP5rA3SjtABUIa1XLFCJ47gNHpQMpli
 fUdsZrODjHi6MWl5D3pVBgVG7jbW/UAlIH+CbmU6OA==
X-Google-Smtp-Source: ABdhPJx4P1ej7L1wdHVmiBYmKcrTBjuOF594ddNMuG9VR+8NqnPfqOi3YffEXrPOyVS/zF1P0da7MdNbeNHQ1ILOI5Q=
X-Received: by 2002:a4a:381:: with SMTP id 123mr19822854ooi.85.1591125406730; 
 Tue, 02 Jun 2020 12:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200514212831.31248-1-richard.henderson@linaro.org>
In-Reply-To: <20200514212831.31248-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Jun 2020 20:16:36 +0100
Message-ID: <CAFEAcA8y=oF7N2NZCsw818rs__uviQgs7gdrfwC9iA7KvwFZDA@mail.gmail.com>
Subject: Re: [PATCH 0/6] target/arm: Convert crypto to gvec
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c42;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc42.google.com
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 14 May 2020 at 22:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> In addition, this fixes the missing tail clearing for SVE.
>
> The sha1, sha256, sm3 routines that are not fully generalized
> are not used by sve -- it only supports the newer algorithms.
>
> I'm not sure that this:
>
> Based-on: <20200508151055.5832-1-richard.henderson@linaro.org>
> ("tcg vector rotate operations")
>
> will be sufficient for patchew, because it also relies on
> today's target-arm.next merge to master.  But you get the idea.

Now I've just applied your latest tcg pull, are all the
prerequisites for this series in master?

thanks
-- PMM

