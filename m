Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4D9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 10:21:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAAC9208A7
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 10:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JSWWXFR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAAC9208A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeFfH-0007Ls-1A
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 06:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jeFee-0006ca-WB
 for qemu-devel@nongnu.org; Thu, 28 May 2020 06:20:53 -0400
Received: from mail-oo1-xc43.google.com ([2607:f8b0:4864:20::c43]:40115)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jeFed-00013D-LJ
 for qemu-devel@nongnu.org; Thu, 28 May 2020 06:20:52 -0400
Received: by mail-oo1-xc43.google.com with SMTP id f39so2296724ooi.7
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 03:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zW2YWT/SpODMxoI1PK86DYWF4snZKzEY3GKX0O7oMxw=;
 b=JSWWXFR1/xRaRTe6l6AB3LayFS3lrZg1R1TxMTIRuMUeV8OPv/hr3v3aWHKjAdFdc/
 61T0wYD53nTiaQgd6PBoXMnAY607XSZbCfC3d2EANSGyStiQezLH7Kx7ClKSRjIkz0Ld
 6xNYRvxstvS7JarFnKZw0wmTCWi7BLxQiVKjdpS+wDIHI40onxAsVCunFhpG275GPWpG
 IViiQacIN60dKZjHDToMlNeUn6nEoNlnQhSQM7L/XD84vEHxee+ScF3tApAGonttyHQN
 eDq4gvDTRXQoiiQhzR91uBNk03WAG1lhkcaHiuRZdl7/3qncVVbDHr/sI6W+cJsXgRdA
 KihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zW2YWT/SpODMxoI1PK86DYWF4snZKzEY3GKX0O7oMxw=;
 b=PlSK0BGAwkPYUv5AovSiyk+O0FFOtlWPvyof+BKPo1Ht/vFtgLLpLhySQFfJK0q+n4
 g3fzTO8aehvNQIn6QdXjZms/bi5gmHdPdtEJJawUvPJFwCjtwLjSY0YF1SpKDuSLMu48
 Ol+yTfowONir3GV7slrKMSDU8NdDk/b4KQ9xEVPtUQx4wdHXf7K08ougksxEnbs+XwF2
 S63Sy2dEHj32P5pqKo58yLOrDVI4idhDn9FEUzgsXuWbhB0n61xBiTkxXmdRtDEn7rTg
 XBwipd18REZP2zJXBqsv6p5cfHp/WkUo9vQInnwa12T7mYPYglT9UiKUypg0Y1IEQWjy
 htoA==
X-Gm-Message-State: AOAM532X0pY2xsq2IF1x98Ld2hnE1ipjuED0/+QFL/fnbO+8jLT4vlLd
 1EDvM2XWF1owM+H1KdxXIRimfMcRKtF0a666U9pfmg==
X-Google-Smtp-Source: ABdhPJwGYpHrOJzgNcHNDSGHA9dqBImWKKQPjWFUZwT3NrQC2q1eleDucY0p5OAgdPDfK7+PWBjO00bwq+/Jtap0PRk=
X-Received: by 2002:a4a:a2c4:: with SMTP id r4mr825004ool.20.1590661250357;
 Thu, 28 May 2020 03:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200527053809.356168-1-david@gibson.dropbear.id.au>
In-Reply-To: <20200527053809.356168-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2020 11:20:39 +0100
Message-ID: <CAFEAcA_R5=tLwEqcUMa6tNB=kS4M+RPWSVbqYCkHVzXT_wp_zA@mail.gmail.com>
Subject: Re: [PULL 00/15] ppc-for-5.1 queue 20200527
To: David Gibson <david@gibson.dropbear.id.au>
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 27 May 2020 at 06:38, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit ddc760832fa8cf5e93b9d9e6e854a5114ac63510:
>
>   Merge remote-tracking branch 'remotes/gkurz/tags/9p-next-2020-05-26' into staging (2020-05-26 14:05:53 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-5.1-20200527
>
> for you to fetch changes up to 9c7c0407028355ca83349b8a60fddfad46f2ebd8:
>
>   vfio/nvlink: Remove exec permission to avoid SELinux AVCs (2020-05-27 15:29:36 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2020-05-27
>
> Here's the next pull request for qemu-5.1.  It includes:
>  * Support for the scv and rfscv POWER9 instructions in TCG
>  * Support for the new SPAPR_LMB_FLAGS_HOTREMOVABLE flag, which
>    provides a way for guests to know memory which should be removable
>    (so the guest can avoid putting immovable allocations there).
>  * Some fixes for the recently added partition scope radix translation
>    in softmmu
>  * Assorted minor fixes and cleanups
>
> It includes one patch to avoid a clash with SELinux when using NVLink
> VFIO devices.  That's not technically within the files under my
> maintainership, but it is in a section of the VFIO quirks code that's
> specific to the POWER-only NVLink devices, and has an ack from Alex
> Williamson.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

