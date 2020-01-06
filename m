Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6518C2D0D1
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 10:33:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 916DC20731
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 10:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UZs6C4V5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916DC20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioPht-0004Vq-NE
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 05:33:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ioPgr-0003up-Ve
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 05:32:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ioPgp-0005Hx-PH
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 05:32:53 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:39180)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ioPgp-0005Gi-G8
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 05:32:51 -0500
Received: by mail-ot1-x32d.google.com with SMTP id 77so71104362oty.6
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 02:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=hwtqCkMxywEpIh2oK4AK06EfpyPRdVNgeCMmDK3kAWE=;
 b=UZs6C4V51LEH2pNcqxgkGgyNcZHVPZkeVTPoX2M50KsN0n6wNnDO7SNt376q1rqRUO
 nWuVHBspe3FV1UPWDtvj0xGVaJ74RrEifqH1kkKtTWPDKVhX+K5BSR/1Kq1EPWpxgFrZ
 MifzM6Ezwo77vJ2ibi4uLvdrjV/TrHz19grPClxDhsbmeUKRmAVUqzzliguPdT/rK4Xv
 /OaNHZtDAePR8IZ9WHZyYrbVoBb55yAlFnYX5bKOXRH0ny43oq2Pzal/oAlZk1CC3fzW
 tSay4htKqDTVBo2xrPzFbdcE/rX7xvwmOyhf+IX6s4ckkc0g6XxuTcjZX3R5nyrCjKxG
 0rww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=hwtqCkMxywEpIh2oK4AK06EfpyPRdVNgeCMmDK3kAWE=;
 b=WPXRZVD+cYZN9Ts6/rE3KJoFjj4VO0hEBZXfRHSYBr+7uFyb2ZY3TjeYR1+VPIPY3E
 wYg1+CKBKroIPe6SfiLZyp2c2IAZ3B2tnJ/8PQNz7IpXP8t0bmN8KzF+iY8YdvTlNTTu
 QNDbmVww7BaXwJhXeTdJBTjmwHtaqurZ7wNSo+da3+m1HAUYQr3gxUYb4v8F9V9T+524
 cEN82JrzDfHvwxllzTfRZM2qy+ql7Ctz4AWmEMDRlzToSrZvJm75HRy4bz6WTti86fjs
 etXcqc3rLnkYgryYplvVG6Uzh11vEipdYCFMVrL95W2VPh2WiZcGphCe6gZnchS+JxJb
 twWQ==
X-Gm-Message-State: APjAAAVnfkGpMmSDBCrOowSKXxJJuFO9mi5eMZlLeMlQS8xfQ+sRSw4e
 YMxZFMWi2PPy+A4Wb5mCIz8LAS1i0WbJnn0kReciB4GP6MY=
X-Google-Smtp-Source: APXvYqwNOBsJR5EoZYqzQbiIwIPrVwnNDhinacyjz3foh3dRKcsZZvyRkHf1XtCSx1myAPr17yIf2Bq7lhR//OzaX48=
X-Received: by 2002:a9d:644a:: with SMTP id m10mr11605392otl.97.1578306769618; 
 Mon, 06 Jan 2020 02:32:49 -0800 (PST)
MIME-Version: 1.0
References: <20191220142644.31076-1-peter.maydell@linaro.org>
In-Reply-To: <20191220142644.31076-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jan 2020 10:32:38 +0000
Message-ID: <CAFEAcA_rS-ZYNuvoKPuTFdzpjizMATNDQc5dLqrrBP+q6nJoDw@mail.gmail.com>
Subject: Re: [PULL 00/12] target-arm queue
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32d
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Dec 2019 at 14:26, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> One last arm pullreq before I stop work for the end of the year...
>
> -- PMM
>
> The following changes since commit 8e5943260a8f765216674ee87ce8588cc4e7463e:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-pull-request' into staging (2019-12-20 12:46:10 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20191220
>
> for you to fetch changes up to c8fa6079eb35888587f1be27c1590da4edcc5098:
>
>   arm/arm-powerctl: rebuild hflags after setting CP15 bits in arm_set_cpu_on() (2019-12-20 14:03:00 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * Support emulating the generic timers at frequencies other than 62.5MHz
>  * Various fixes for SMMUv3 emulation bugs
>  * Improve assert error message for hflags mismatches
>  * arm-powerctl: rebuild hflags after setting CP15 bits in arm_set_cpu_on()
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

