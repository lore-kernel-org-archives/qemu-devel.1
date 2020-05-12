Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A424CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 18:40:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F19120740
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 18:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hu/pT917"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F19120740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYZpV-0006nW-5Z
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 14:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYZnP-0004qq-Ij
 for qemu-devel@nongnu.org; Tue, 12 May 2020 14:38:27 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:44988)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYZnO-0003Pc-Be
 for qemu-devel@nongnu.org; Tue, 12 May 2020 14:38:27 -0400
Received: by mail-oi1-x242.google.com with SMTP id a2so18931458oia.11
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 11:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Qc/c0Jv7bY87BnKQmOEc9iv5lqCzVVFlOn1Ozh6qTjM=;
 b=Hu/pT917sskyvAnooAZWcGECUbN1aNVNXBzPOjfO+Be40LzJ8txBBC/Mb07CF3l3qg
 gKRwCjiQSaT6ZzhNnLmi5F+/GjH0UteLW8pBQ6WGtPMoJtYZ0J0eDdYv5rw17tNkVJKu
 Kg/hZnHqmK4DXAdNzi1ZvE8/Y9jp3mGGx/Ym4cgxgjvwlh1it0DOXzS6bzE29iwnzG10
 e/4UmfNBHXDVimAwA6nY9wlcfoD+B4j+wLOS4PtzZxtoEt/njypLe2zfDBqu7AALqGlp
 VIQrs/Gd8vkV022bTw3zjwVJha6VmYhJ/smAbhBcRQuuKDdnCLBPcCYmywhLqaVnsOW7
 OVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Qc/c0Jv7bY87BnKQmOEc9iv5lqCzVVFlOn1Ozh6qTjM=;
 b=f3McpN0PlehDCGyb4hLhLb/NedLkoZd5xd83otEwLsH+2/kCBthp7oXw0JOfVGY35X
 pWfr11qItUru3m9cW8tls95kbo9zaO8cXeQbqfGUhS7sPX/HoCizkeOHnX6JLTUjWGBD
 qW15DaHirnHvL5sRaetEIId3VAEEKBB4sTDUlChN/elzb/hmdYbhs044SSlxNfRSUN9R
 yxakd3sdxJXULzbULrWJohX5Z7LOsf3eQcvqsyKgMLoqE2HBOly+VRDCqEGZcY3IBg5C
 VU+RvEzNklaRRioY5MBh4BEAzl/uYTFlqZEinCnZOl6Dt69WshE72lgPE29K+7xEUDSl
 Xyiw==
X-Gm-Message-State: AGi0PuaKiBDXmxsxFoNe4TRpPomQpKsmkKkY4Fd8UQ0xfue5Z1IrMlbs
 lrE1B+FZCAypHJO1BFMQMTv1dK82AdM1HOCU9spKGA==
X-Google-Smtp-Source: APiQypJVWLOGRiKRzTnz8Llj1fuhO4ZYnunV33tU8xDsDf/7IFg3lUXPCfpvKvA9DA4Z8yFpyFlugTbHWvC7hZjCCAw=
X-Received: by 2002:aca:4a45:: with SMTP id x66mr22854374oia.48.1589308704989; 
 Tue, 12 May 2020 11:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAB-99Lsm1c6i45L2kQX6J6Wa+FJ+aRPhdVK=+zQC2M6K7RdXDg@mail.gmail.com>
In-Reply-To: <CAB-99Lsm1c6i45L2kQX6J6Wa+FJ+aRPhdVK=+zQC2M6K7RdXDg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 May 2020 19:38:14 +0100
Message-ID: <CAFEAcA_96H64pg5er6MNraDtU2Xcu-_XrAGJnrzp25BaH+Gvng@mail.gmail.com>
Subject: Re: Problem with QEMU usermode + jemalloc
To: Michael Goffioul <michael.goffioul@gmail.com>
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 12 May 2020 at 19:16, Michael Goffioul
<michael.goffioul@gmail.com> wrote:
> I'm running into a problem using QEMU in usermode and jemalloc (this is in the context of an ARM-to-x86 translation layer for Android). The issue is discussed here:
>
> https://github.com/jemalloc/jemalloc/issues/1844
>
> In a nutshell, the lack of madvise implementation is making jemalloc return non-zeroed memory on calloc. This then creates various crashes in the emulated code.
>
> What would be the QEMU devs point of view on this?

Yes, this is a QEMU bug. The comment in the QEMU code
suggests that making MADV_DONTNEED zero memory is not going
to be as straightforward as just passing through the call, though:

    case TARGET_NR_madvise:
        /* A straight passthrough may not be safe because qemu sometimes
           turns private file-backed mappings into anonymous mappings.
           This will break MADV_DONTNEED.
           This is a hint, so ignoring and returning success is ok.  */
        return 0;

That an "advice" function has been given guaranteed "actual
behaviour" requirements suggests somebody somewhere along the
line made a bad API design choice, but we're stuck with it now :-(

In general, QEMU's syscall emulation is not always perfect; you're
more likely to run into bugs if you do weird things, and using
madvise() to zero memory (rather than, say, just zeroing it) is
somewhat off the beaten path.

thanks
-- PMM

