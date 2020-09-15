Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E24DC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:06:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2FE7206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pgYvI4lq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2FE7206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI9jX-0007fF-Kr
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 08:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kI9hv-0005w3-4C
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 08:05:11 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:35925)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kI9ht-0006pc-C6
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 08:05:10 -0400
Received: by mail-ed1-x542.google.com with SMTP id w1so2777136edr.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 05:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZHwFZD2iS8lX03gcG5etkJBgj7sK0DAkBxeIMUOryCU=;
 b=pgYvI4lq6KtyS9uNLXUgZQybuagTfy8p6+6dS9Eu+JBxA38eQjfn/XPrVon1lVXUNj
 59QPrbAfQi7dY4tD8856Pa85cW67H0UWlfIr5NpMjwRgS1t/C95Ld/OpNvxg74x8qjqr
 PNPM3cMr9YVb7BecDrKZrsov+wH8ktq2OtSv14pdimO/+5F7IruGMHOGe8Honsln0Q0C
 BW853a4GHbKwCUTMNO3B4xqhrvuu0t4VdMoLhNoIyGmhApemUHhhXo/YNmSJCK63csZI
 JK+6+mlseZ2U7l13+3RG6wjBdtrtTRginwp21GFmjeTfFPP5oDUPiSFWWoGWgOfT6q2/
 2dcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZHwFZD2iS8lX03gcG5etkJBgj7sK0DAkBxeIMUOryCU=;
 b=WSvFPiiV/Z0auG/uqLw5ln632pHf0tHvHb1EHTpFEs8UMnmYWkpqMGFvDOjguoNGN8
 AEoUH115dPjctQMvI8zmZ4UIIQcC0DJbyjQOMXJn+NguUIEtUIZ3oJJkButpgQEsVHUD
 Aezi+LxQFbpMUAAdUQwpqHWkl9sZ6TAbOaIylME/QQvQ0Ns4BXGYz+xaz0L1eNU+GhBs
 d0BMChYMCCcTTokP5SYAT5g8T1730WOIkXFo4xRJTU8fd7yV3ehbSpL92Pkn2tzxPFJl
 UmhFNAA+vc3OxYvQtp6NVmfCRZ3PX432fWNJq9W7xYpRV2YKRuRBwOgUb6zis0devcph
 REkw==
X-Gm-Message-State: AOAM533rzb06JHg/tLlRJ3UbT6Of77ylOG1yXvNdqgH38TJrWyZ5+SNt
 Y32N9SMUNE0Zlv0yfX9+eU9NFoE++VRB7VIUhSdBnw==
X-Google-Smtp-Source: ABdhPJyfaxJJTmjJherotcp9AByVrz3XfkQPVtyLHCmKZkVBpeBspW4QKMPEfXHJm8ShbMUauRkPHBb/5tjnYyt6pKo=
X-Received: by 2002:aa7:d58e:: with SMTP id r14mr4152052edq.52.1600171507338; 
 Tue, 15 Sep 2020 05:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200915104627.699552-1-mreitz@redhat.com>
In-Reply-To: <20200915104627.699552-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Sep 2020 13:04:56 +0100
Message-ID: <CAFEAcA_K=AVuc77c+JQ01Dp=9rp0CChhQ3VN4M8RMZSJW++Qhw@mail.gmail.com>
Subject: Re: [PULL 00/22] Block patches
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 15 Sep 2020 at 11:46, Max Reitz <mreitz@redhat.com> wrote:
>
> The following changes since commit 2d2c73d0e3d504a61f868e46e6abd5643f38091b:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200914-1' into staging (2020-09-14 16:03:08 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/XanClic/qemu.git tags/pull-block-2020-09-15
>
> for you to fetch changes up to 7bae7c805d82675eb3a02c744093703d84ada2d6:
>
>   block/rbd: add 'namespace' to qemu_rbd_strong_runtime_opts[] (2020-09-15 11:31:10 +0200)
>
> ----------------------------------------------------------------
> Block patches:
> - Several qcow2 fixes and refactorings
> - Let qemu-img convert try to stay at cluster boundaries
> - Stable child names for quorum (with x-blockdev-change)
> - Explicitly drop vhdx 4k sector support, as it was never actually
>   working
> - rbd: Mark @namespace a strong runtime option
> - iotests.py improvements
> - Drop unused runtime_opts objects
> - Skip a test case in 030 when run through make check-block
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

