Return-Path: <SRS0=NumX=A5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BB1C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 22:59:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C841E2076D
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 22:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vOe9D99H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C841E2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwvnt-0005xK-1F
	for qemu-devel@archiver.kernel.org; Sat, 18 Jul 2020 18:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jwvnL-0005YO-Br
 for qemu-devel@nongnu.org; Sat, 18 Jul 2020 18:59:03 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35846)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jwvnI-0000lh-Tb
 for qemu-devel@nongnu.org; Sat, 18 Jul 2020 18:59:02 -0400
Received: by mail-oi1-x243.google.com with SMTP id h17so11260812oie.3
 for <qemu-devel@nongnu.org>; Sat, 18 Jul 2020 15:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=k2z/J7I/91BotfY0gJ5Z5JbxHGl12U2srWijKMRqr5E=;
 b=vOe9D99HF9OYV9m+GbMeH1pBUdNFUHAEI6n3B+QJG8H4PEyLoI8j6aPWAH7etAX3I5
 P9vgJJjCmxE90YUQaX6qsAlKMFsmj/vveIShtYRkeefAzy/fZ41L1IhXm70qJfszYJB1
 IUibOdeb1As0PMNhl/SeZ7WrQ21Z/DZtzoeADhXtG8NF3SJsF+/Nor1Krm01Jn74eCNS
 L95u/oMrHxlWToVxrn4fj+xZYCJNPkSLuetQFSxkWiGyjvyC1Zfgkc1/tPO54p6ZI0HJ
 0GWDhW4R7AXGiXwd+n8+bV4WERREqPxPdwTjoS2MSDWtTiU8HpfIjgjNW7Mu5nDehzN8
 R6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=k2z/J7I/91BotfY0gJ5Z5JbxHGl12U2srWijKMRqr5E=;
 b=Ms4un3vPEgI7yamA7pOXmgRrXO38grrHBW7+D9KafYQB9UOsLpFXC+jQDpiTATJFFk
 xT8yVpfVlCuVi6tK8lMOuY1gSevKiU0xMN2kjUpNhWCAwdvrJEshknSuWPDfgpldMK1X
 BP0EXvDP9WZs9XlsS7gwWirMMnHDSn2BlYLe/cgiceQgzfhPwk2tb79wo4G8nTvM7us9
 JUO0DlBt2NfUpYWTvcsPxXEvEfrCzlXj0K0CsWdyyN+T1xUfd33hKGxLaG5wdCT8VUnP
 VqoNqm23LI1YPtcNEH/nzmW5J5Rn9Ml/DJiViM5MBUNzAT/vEUbzoTapahcc7DRgM41b
 fV0Q==
X-Gm-Message-State: AOAM533yPFNsyAMFZw1bit90nhXpUiFnkq3KkBWP5bXa7t2qKAFkVJez
 5AHdZ09b6i/jAEuVPv+7vmiSyP2FIBjzT2/eO6C/Bg==
X-Google-Smtp-Source: ABdhPJx9TUUUdfHoRbjRos7ckn8JVHQL4dy8eR1hHupoiV4uyQu4302iIkAWMshgzEYDlvvnLcyNXtMJtJn7QqlZ320=
X-Received: by 2002:aca:54c9:: with SMTP id
 i192mr12712960oib.163.1595113139578; 
 Sat, 18 Jul 2020 15:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200717151446.655571-1-eblake@redhat.com>
In-Reply-To: <20200717151446.655571-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 18 Jul 2020 23:58:48 +0100
Message-ID: <CAFEAcA80KdFODWRpa2fOt71B7kfqKNUpA-N=D+8LcE_UxAOJSA@mail.gmail.com>
Subject: Re: [PULL 0/1] bitmaps patches for 2020-07-17 [-rc1]
To: Eric Blake <eblake@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Jul 2020 at 16:17, Eric Blake <eblake@redhat.com> wrote:
>
> The following changes since commit 151f76c689b1ff4c2c59e6d8469a0d4fe5346f55:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2020-07-16 21:46:18 +0100)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/ericb.git tags/pull-bitmaps-2020-07-17
>
> for you to fetch changes up to 7cb015197b383a62f5729d2c92b1050db0185c1c:
>
>   migration/block-dirty-bitmap: fix add_bitmaps_to_list (2020-07-17 08:18:51 -0500)
>
> I had been waiting to see if I had more than one patch to bundle, but
> given that we are now coming up on -rc1 and this is a bugfix, it's time
> for the pull request of this in isolation.
>
> ----------------------------------------------------------------
> bitmaps patches for 2020-07-17
>
> - improve corner-case of bitmap migration
>
> ----------------------------------------------------------------
> Vladimir Sementsov-Ogievskiy (1):
>       migration/block-dirty-bitmap: fix add_bitmaps_to_list


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

