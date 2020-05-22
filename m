Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CBCC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 22:17:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDC2020723
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 22:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QNfbd0zL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC2020723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcFyX-0001V2-55
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 18:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jcFxo-0000uQ-7Z
 for qemu-devel@nongnu.org; Fri, 22 May 2020 18:16:24 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40248)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jcFxn-0008UV-6g
 for qemu-devel@nongnu.org; Fri, 22 May 2020 18:16:23 -0400
Received: by mail-ot1-x341.google.com with SMTP id d26so9405149otc.7
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 15:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hyJbzYvz9no+JvZT0ZyCwUOfZMKd4VDuNu9gDBwudFQ=;
 b=QNfbd0zLHGqNQJ1BpmxVfvvr/7AgClRq1BzI0n1xe1MjAfUrC3WL7PvhuN4NeTtln0
 WLYSqR3Tygnw9FienGwOBzBxI4VT4PegV5XirrutE7X+sfuCgH9OdRx8CGH49ZLkJkio
 +6n5k1S4fv1jHoK/cEs3K3kAlwO4YR9Y7VczekV/gcXE79qws1pkZiIcwWRo4/Q03O9H
 kbBkmq37RlOc3uNHwK2/29U9vbub9XwrBQ3CiDlcR0I6YOCmq8cFWCXv9GjET4KnfN0y
 1Hx7YRDAEmI0eTgsiulj6g1nddB7Jbdi+33RUIiXKDcTehX1nFEC2SpHbHRh3tiZcIXd
 VQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hyJbzYvz9no+JvZT0ZyCwUOfZMKd4VDuNu9gDBwudFQ=;
 b=mOu7BToQVGpGhop+2ROwdjRA4Iz7uBVJNHPur88MWodsXwzbLrskDV5gfSBwkJpTsZ
 0akMIGYJk6kNkBDOKyaU4hhZ8bqSrrU49LsG54RmiaM1Tq9o4QqUGiEIaHarHRp58Ss1
 hRIQqC4TjlbnT1mcgKVrT1HW8nk3bFvvbbb1nMR/Edu1ZHGZjIJxkJsyVK85FSc/8kZ2
 X45rGIO1D7YFrMDLzjhtQkpOCpNKUzUrVzepGDJ4qMQKFnj2DqxvrArV3X6rzSNP3exD
 eQVmEx5c2m4AnKOKUA6of3WJXSJPnXoYB24FOuTxCUEEVxIFP8Zyh2kIo4n+4IBROfbP
 MJQQ==
X-Gm-Message-State: AOAM5308mviYFSxTi5jzjScRxfIhQ5xu50sYUmsS27MduJLT3rlA/Ure
 0Sh5vEyXTxd9pELuMDm9IQ4WYt2WX+Gp5J99siCxMw==
X-Google-Smtp-Source: ABdhPJyZ3G2a+bPfYyjHv/OEM10DQ65+PJcVZPLynIyPEP7Vmt8EX3n0VjUzDmgzcLyZVDHjOhcmD6vOEY0DOKQSfaA=
X-Received: by 2002:a9d:3623:: with SMTP id w32mr12317395otb.91.1590185781562; 
 Fri, 22 May 2020 15:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200522145520.6778-1-peter.maydell@linaro.org>
 <20200522145520.6778-6-peter.maydell@linaro.org>
In-Reply-To: <20200522145520.6778-6-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 May 2020 23:16:10 +0100
Message-ID: <CAFEAcA-WmDWvBP=3GauiiOEGvCWdKUb9ENM_8F7zLLHY8po8MA@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] target/arm: Convert Neon narrowing shifts with
 op==8 to decodetree
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 22 May 2020 at 15:55, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Convert the Neon narrowing shifts where op==8 to decodetree:
>  * VSHRN
>  * VRSHRN
>  * VQSHRUN
>  * VQRSHRUN
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---


> +    // todo expand out the shift-narrow and the narrow-op

Oops. I fixed this todo item but forgot to delete the comment.
The code should be correct, though.

-- PMM

