Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417A9C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:47:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DAE6206B9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dSjJpeAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DAE6206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVznU-0000Xh-4A
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 11:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVzmJ-0007mw-2z
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:46:39 -0400
Received: from mail-oo1-xc43.google.com ([2607:f8b0:4864:20::c43]:39961)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVzmH-0003wl-P8
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:46:38 -0400
Received: by mail-oo1-xc43.google.com with SMTP id r1so648695oog.7
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 08:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jN0dwe0eTXkez3evEbeN2WcheQ3knEWM9MjTMz9A5f0=;
 b=dSjJpeAYWFrsx198OkMjCRO8T1Hw6VhsdUX/48KBDyFE/990XWummzx/ldrD39wEa0
 vlXBHJZSqDr6+MaRXTG5CLWCnbkXC7Bm2dKHLc+19ws8NvTuo76CGCJMsivJLbJqW7kb
 CYAms+/S7YWOdWoiLrbSZtNxkyQuGiucJx+9j98UfiwzvueNMx3gFRP2Zfw9K1wWKxyR
 EHXuues1anllBuiLIOKChvX4+zBxf/A1UdqikLDtvcxEfpzTqlqX7Fr1MisloGVS5btR
 96Z75aKQWAHH7Uk6FjZgPq48wYC1IuyWGhfV06bLi5ucuYtMEqNK/P36gj42q2ggs1e1
 /+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jN0dwe0eTXkez3evEbeN2WcheQ3knEWM9MjTMz9A5f0=;
 b=YlvqqGEGg0W+QkPb4CJRXPEbWvPoFn2UIHfef1LKvv4rkrg3ZS/LG5EZvtly/2lRZp
 wgJq9m1ySJa+HmB23Iv/s4R/OI9s/v4F7r3g0Y13WVQqPjbRJvsV7O7UfDhE1zCXjCiY
 FqG2jjU7/yhh5PtKgRuKmpa4VEYSxuiFuw0ZH+TlIuSAtWOpu1ggEWD3PvcQYOFjUvWU
 8S24oiIe5iJJTjwSlIS711abGSFcDPSg66vyE1+8sjzU1YAcPqgi438J+jP5tXBHNB6k
 zxm6JWTzgdh8YaBML+ia4yB0GYEkN0j4clZIO0y8qX7/lzG0mx7QWHOa4Vz25vxBOcLH
 rDsg==
X-Gm-Message-State: AGi0PuZft9fJAzxqoKrjPU23mQYQ1ryR5RYwkdNx8YQsZJd/9o9xNRRU
 BNvAYYVh79sGYSP82dJieZ7Ac3mJ1tCm8sUJjHHMXQ==
X-Google-Smtp-Source: APiQypJxIvZpfE/LBZFmuGnJotA2g+HWoi723gfPCYhCFWA4pffCkleDXXNUDIIUi1yWlTPFVP5S1pQMuXDqRTXEIrA=
X-Received: by 2002:a4a:8253:: with SMTP id t19mr3453635oog.69.1588693596062; 
 Tue, 05 May 2020 08:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200504211438.195926-1-eblake@redhat.com>
In-Reply-To: <20200504211438.195926-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 May 2020 16:46:25 +0100
Message-ID: <CAFEAcA9==C04W21nxi_jrEoK6KX1yCrTgC5rTvO_+4_aQ+Sq4g@mail.gmail.com>
Subject: Re: [PULL 0/4] NBD patches through 2020-05-04
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c43;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc43.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 4 May 2020 at 22:21, Eric Blake <eblake@redhat.com> wrote:
>
> Happy Star Wars Day! May the Fourth be with you as you apply this...
>
> The following changes since commit 5375af3cd7b8adcc10c18d8083b7be63976c9645:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2020-05-04 15:51:09 +0100)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2020-05-04
>
> for you to fetch changes up to 714eb0dbc5480c8a9d9f39eb931cb5d2acc1b6c6:
>
>   block/nbd-client: drop max_block restriction from discard (2020-05-04 15:16:46 -0500)
>
> ----------------------------------------------------------------
> nbd patches for 2020-05-04
>
> - reduce client-side fragmentation of NBD trim and status requests
> - fix iotest 41 when run in deep tree
> - fix socket activation in qemu-nbd
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

