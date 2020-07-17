Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95848C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 13:59:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FED120717
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 13:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V4Q/PTVb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FED120717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwQtJ-00010C-Ln
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 09:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jwQsS-00005j-9m
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 09:58:16 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:42287)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jwQsQ-0003b6-CO
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 09:58:15 -0400
Received: by mail-oi1-x22d.google.com with SMTP id t4so8047656oij.9
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 06:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QM6ysHUKSlNt1+LikxilGhqoByUyrjfbmRz9A/P7wT0=;
 b=V4Q/PTVbVLhbciLildxjOdDXkaUfIF6Pmm/o8BIACWe93oPYVmiFFFCoTZnunW2r7y
 5XENvlhbixoj328I2O7oOtAWWTd9BG4T0ocbVYz0VLQ0KT8Rx4zaLGarmdQjXwmHuwLs
 NoNqljLl/VYS4D+tm+FRblQd+1bVSmm15SOVNLBahI9Fxk1FlDoGgtqdVCLsBUs3m49a
 maWuEYIcu4NaH+PyAjMMMzJhx5tY8RJDC7H0fltiemd2ZTscEPDTnbDZPW+J3Tkxfu4S
 td410PPeDshbJDlrGsheVbbrg0a8wcPonBrQF5nD+rNOJoOZk1923Rqz7/xO2TBOj9UZ
 zF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QM6ysHUKSlNt1+LikxilGhqoByUyrjfbmRz9A/P7wT0=;
 b=nESK1vtk8wumZhiwSadHB/8DISU/SJRarir4wmVY1K+hp9rBBvAY27gzwSpABa60up
 GZ6fhgjoiZRlT/A0w5mta0/rzM5Y/yLXyrDmAvwTKQVZRfYlTI6+FkExYPc0jKLM3JPt
 kCJFgo3KVvEtPaScGWcHbJgZ20yixrBRx/95h7TfTzs1W2oMFC5M0bXWX9ILdj1NWdn9
 92mfiAI/dYMvhmCOuwECvWg0vVnWTugVP36+JHGaufrywWejTOQmnF3Ob0hfXa0fWRZf
 45n0hvWH42gpiI574XUN8hkm5TVjP0IssyW4pW0LYHJ6OOhmtfX0J/mVIQezpUcit5n+
 i7/A==
X-Gm-Message-State: AOAM530T+jAV35WYMoUBALFb+KI40wx6wI+Gyoi8Hyr2xQBmIr+yO0so
 IqhYVXUjQiRem0I2f2FqqpPo04Oo8hb9nUmBNbdlgA==
X-Google-Smtp-Source: ABdhPJxPHa1V0b47pxFxPvCkRSOKvEQ+wU5zXXFv46wDhpcrNNHZdnyW1QxzDEUFoAOfG4/sxS7OXMGBeGXJuaZNcyM=
X-Received: by 2002:aca:1706:: with SMTP id j6mr7297232oii.146.1594994292617; 
 Fri, 17 Jul 2020 06:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200717095605.27589-1-thuth@redhat.com>
In-Reply-To: <20200717095605.27589-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jul 2020 14:58:01 +0100
Message-ID: <CAFEAcA_7fgx1Vcn0K1f1bVNGD08sbYdADg_h2TkcpMo7KojjUA@mail.gmail.com>
Subject: Re: [PULL 0/6] Leak fixes for qtests + fuzzer CI
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22d.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Jul 2020 at 10:56, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter,
>
> the following changes since commit 95d1fbabae0cd44156ac4b96d512d143ca7dfd5e:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/fixes-20200716-pull-request' into staging (2020-07-16 18:50:51 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2020-07-17
>
> for you to fetch changes up to b610eba335d5c8ac7484dbb1c886b125e2dea058:
>
>   gitlab-ci.yml: Add fuzzer tests (2020-07-17 10:44:23 +0200)
>
> ----------------------------------------------------------------
> * Leak fixes
> * One fix for running with --enable-werror on macOS
> * Add fuzzer test to the Gitlab-CI
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

