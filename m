Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC12C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 10:11:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1CBC20C09
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 10:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YQ4PZ9q6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1CBC20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNCbQ-0006nh-Sc
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 06:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNCaW-0006H1-4P
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 06:10:24 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a]:38093)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNCaU-00031o-D3
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 06:10:23 -0400
Received: by mail-ej1-x62a.google.com with SMTP id dd13so1423908ejb.5
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 03:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gPFXdRcg8Q5KgDH6d8ngGhkH9XJlP2hCvCHiQOUVass=;
 b=YQ4PZ9q69zgnYAcx9ZCn4bNpwlr8vIgH9EHslpRshk2yBVI/2KCJS4grZrOkQdJkju
 1Ac3QFqMzpWLROeUsNx1Un/PX4aLF1F3z8/RA/xWgeYULrL84RgY1fuu4pg//vtfJ6uG
 4oO6zx6HbpzqKHW/ecTcpZDzhbDcNfpmI/y0qgttOdCPaewGWwribSjDFLtJAYAfTOWn
 m/Ks/Dgps6DJvLBowQReKfgOd41fTSx1UQJlFQA+Qqij8zcJZrWudb4OT5av5Cml3j7U
 0vVJw+TLjeXiWfNRoqmU9bTMT5zPh0HAjTO4gplfDEgtUAxQKXQDHo5w5Ov0LTV4mMMg
 1W4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gPFXdRcg8Q5KgDH6d8ngGhkH9XJlP2hCvCHiQOUVass=;
 b=m7q2uY1rbiT/1Yynekzyu2K/KDRo31jfbh8n/6M8ij8XwCUE3Z9NpDxWk31T6q9UFu
 wVRf6jvAZvCFB72vnZwdAcIA/a324YfNSz+qprBzxKQWk8+rvghlN5Lmk01TxcbgSU0F
 XdTt0EmmtmtiCv1qI2BGqzRqYWAzz/2edtJ9fw961H1sqa0B36yZEeagrmPh9GwbMqxV
 RgOFdFkPjnxZ4paTMiXQkUnyGP6boektPzDkZ3dgwvmWo9i4LlgbnstVKxePDZCfzWqB
 2g8YCNKQs002e66FLs+aKbz+AMSJCYHaytuPtngZQmZin88Ih9O5ep2cHFvGNzbyt0vT
 RINg==
X-Gm-Message-State: AOAM532nuTzgX+MT6Jz8gaeChvoJsLfUCGvW/9vffNai06qLXhKkVQYE
 Qf9OvpNSsEuFkXyYEv5ORC3zsBveN5mOyQl4TvyIeLbAWDRIbw==
X-Google-Smtp-Source: ABdhPJwlvZ6XZFHiO1yrZxTWMLT4ZKq5TeAYGLXm4yXqRxFFWQDzlDwwqv19dCjVn4T6aGn6/e2eyoGDFgf6Cri/U8c=
X-Received: by 2002:a17:906:4a53:: with SMTP id
 a19mr3205259ejv.56.1601374215978; 
 Tue, 29 Sep 2020 03:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200928152024.209894-1-dgilbert@redhat.com>
In-Reply-To: <20200928152024.209894-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Sep 2020 11:10:04 +0100
Message-ID: <CAFEAcA9q6xsR_Mny9B_tMBACY3XNuFd0YJe=bzKKTCryhaARJw@mail.gmail.com>
Subject: Re: [PULL 0/1] migration queue
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62a.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 28 Sep 2020 at 16:23, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 8d16e72f2d4df2c9e631393adf1669a1da7efe8a:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20200925a' into staging (2020-09-25 14:46:18 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20200928a
>
> for you to fetch changes up to 1783c00fc998220f9ca13b7eeca1d610243bc11b:
>
>   Revert "migration: Properly destroy variables on incoming side" (2020-09-28 16:18:02 +0100)
>
> ----------------------------------------------------------------
> Migration: Revert one patch for 068 fix
>
> One patch in the last pull broke test 068 which
> does a pair of vmload's.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
> ----------------------------------------------------------------
> Dr. David Alan Gilbert (1):
>       Revert "migration: Properly destroy variables on incoming side"


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

