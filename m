Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4B6C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 20:41:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9B6F206BE
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 20:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iHm0XWXQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9B6F206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsuPR-0000LK-65
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 16:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jsuOp-0008B1-5D
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 16:41:07 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43850)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jsuOm-0007vf-GZ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 16:41:06 -0400
Received: by mail-oi1-x243.google.com with SMTP id x83so28421248oif.10
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 13:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6Ng2CENiWLAVEpAm3mKaYc/1hthGN0bN4M0BnZhOfgY=;
 b=iHm0XWXQQ9BPtI782Xq06LZzLBS1UJ6dTD+ccLh1YrSROgjCGsLJdOrCDqBayW/5UX
 xAmED1n6Bion2Pwpcl0jtCC8t37ZSGhPef2+rbKGvCxrt6yqNZiOUMOtVvEqaNv9LxXm
 JDCdhRpO9BGohLeLPB4wxvB/WzIvcp9N5Wo+3BU/SpSsXebklTp10Zom9QNlP2OozF4n
 H9PsJE6ZGulKX3XZxVKCfK5b9TA0zCo0kHWYbBHGz25g8DofJVR+6BnR37VLiMFWiF8m
 zBYvwJojn8rDQ2aw4++RI0zuOQCiPGIMApzOiDu6LnWr2dVXoU6tCGHKdMFLZkgjTO0m
 uYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6Ng2CENiWLAVEpAm3mKaYc/1hthGN0bN4M0BnZhOfgY=;
 b=texnuQnbAKkjDNNgSTuNOQBELClkLeHTc95HRxfp5xQS9gAIKmQYE7VNNqvSwQegCA
 5bPDt9+AR9ClGmGeqeUpaq0UKNj0rxIg6ZQF3DBM/3M3PFVBm3rb8O1u+brDP+4t/Wrk
 xH1QKx9gkhcJ+0hpUtN7qVWXK1mdN2/81ywASQ3xDSDw2sYm7eX1+WX7XrhUCLmbJmgT
 H9Re5KUo9JQiq48eYNQ/zdr/wSq2mj+Jp2moUrVrIDTXqMHOnpN1qnlTltFZV9IfhO38
 pcQyvgJBt4idGcKI+ZxN4ctW3midfvMYHbwJuC+aWQeti0CPLJD9aq4qc4/2H6vwyumQ
 Ofww==
X-Gm-Message-State: AOAM533KSy1W4lqeAyslxBfrkqvnNT149jQXiKDgGWgjitzJE87MTRhc
 ZjhWs/FswxlbYoK9jEq7N1B0CBhDowdgl05MW0u1lA==
X-Google-Smtp-Source: ABdhPJxWJzpaNYuAu/ptAJzPo07U62LvVoFeie8jLu/NcCbmOmd4tIcLVcZwsW9SCT5JZGCcgy+6d1wSfZqVxtQOIQA=
X-Received: by 2002:aca:54c9:: with SMTP id i192mr4769826oib.163.1594154463202; 
 Tue, 07 Jul 2020 13:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200706100432.2301919-1-mreitz@redhat.com>
In-Reply-To: <20200706100432.2301919-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Jul 2020 21:40:51 +0100
Message-ID: <CAFEAcA-jzUkr9dyKS6_ZFemQ-ojdLjA1zMwXhmWH=PSr7QAR7w@mail.gmail.com>
Subject: Re: [PULL 00/31] Block patches
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 6 Jul 2020 at 11:04, Max Reitz <mreitz@redhat.com> wrote:
>
> The following changes since commit eb6490f544388dd24c0d054a96dd304bc7284450:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200703' into staging (2020-07-04 16:08:41 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/XanClic/qemu.git tags/pull-block-2020-07-06
>
> for you to fetch changes up to 365fed5111b06d31c1632af63c7528dfe49d62a2:
>
>   qed: Simplify backing reads (2020-07-06 10:34:14 +0200)
>
> ----------------------------------------------------------------
> Block patches for 5.1:
> - LUKS keyslot amendment
>   (+ patches to make the iotests pass on non-Linux systems, and to keep
>      the tests passing for qcow v1, and to skip LUKS tests (including
>      qcow2 LUKS) when the built qemu does not support it)
> - Refactoring in the block layer: Drop the basically unnecessary
>   unallocated_blocks_are_zero field from BlockDriverInfo
> - Fix qcow2 preallocation when the image size is not a multiple of the
>   cluster size
> - Fix in block-copy code
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

