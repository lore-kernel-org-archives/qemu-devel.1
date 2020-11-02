Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16705C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 10:58:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C9372225E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 10:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pJMvn3P4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C9372225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZXXv-0008Gv-SF
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 05:58:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZXX3-0007BK-6e
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 05:57:49 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a]:33151)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZXWz-0006az-Ds
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 05:57:48 -0500
Received: by mail-ed1-x52a.google.com with SMTP id v4so13943993edi.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 02:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kRJDsFf++5w28jvN7jyZCDy8wvmMEEIc5KDDQmrxtqM=;
 b=pJMvn3P4ZNaa0PlRxzep/LciyrUV/QTO2sx3iQUiOfeDvFy6GdWsWc72FYrOmX2P9U
 Dc3NPk9fl8Z5km95FmfoVGnl+948OeWMk6YRqOgXxds8XpVsZQPMcz3Fj0r2NOQho1ro
 oOPkUbUlynnKYOGdTQg309EdCMZ0e0O34ju3s/e+mS095C9Sd40vlHaRE2tppXErrccy
 95twX94f0CaEnoinRXdVZAVw/7BzSgjYWA8Rr/Zy1JCvFQwFAGqGi8O00DNBFjR5deDl
 VsjSsElr3b/NXLWEuBmKGxEwHzNQUm1UmfelZMAIIyITjcF7EatpZumEMj+UmUaXuAtp
 Jlvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kRJDsFf++5w28jvN7jyZCDy8wvmMEEIc5KDDQmrxtqM=;
 b=ihowpap7icKLxapysrY9oUPQbTtCp3DQjwG9Dk05z2X6ksLencsL7V8UUqKnbzi3vp
 t6mJHXNa5/MnSbo8Tkf+m2SCRoVRKp3xh49OIvxUhvLYA3xYRm6zPDNJsIoLjtQMjmXJ
 zfSYPlm6NLtiOyr/CY4HTNbTR3tbpN62yqGoFbe2plzzX9gsNjOO7ApSog3R63ET2pvD
 J4t9RNB++QcWBmKvv4n7g1vOueXEasDMBa0SjQPcRj17NDCIR/1Ev6XjYS3bqEj0tKCm
 6AjjrTu2FXkMDh/l9lf/hzf+3D95pH3fNUrEjWhIrbAJtfG+RxPjAmdpCc0zrG6Wzu9Y
 tA+Q==
X-Gm-Message-State: AOAM530bIyFyZPJwRaL46KdtHNQz8bOQULxu71Dx9eCVpnyUbpPytlxP
 xlq9Ajlp7bu90d6I1o+v/5qgWywkhYaUjnuEMC9yiQ==
X-Google-Smtp-Source: ABdhPJwxqfAF7T2x01AStrCGVgJPFO+ygRR2jFVFkdrMaOj/ijrgAtp+y8QCm5l4zAliD7/wez+Ywj3HVSfFuB02Pvw=
X-Received: by 2002:aa7:c683:: with SMTP id n3mr15543431edq.146.1604314662382; 
 Mon, 02 Nov 2020 02:57:42 -0800 (PST)
MIME-Version: 1.0
References: <160426371498.24886.12193840637250368669.stgit@gimli.home>
In-Reply-To: <160426371498.24886.12193840637250368669.stgit@gimli.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2020 10:57:31 +0000
Message-ID: <CAFEAcA_a-heHs=2HS9SxKnSQfCyEq_eX+HeAUuSMT8KH3T_8Ow@mail.gmail.com>
Subject: Re: [PULL v3 00/32] VFIO updates 2020-11-01 (for QEMU 5.2 soft-freeze)
To: Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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
Cc: Artem Polyakov <artemp@nvidia.com>, Zhengui li <lizhengui@huawei.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Zhi Wang <zhi.wang.linux@gmail.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Neo Jia <cjia@nvidia.com>,
 Amey Narkhede <ameynarkhede03@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 1 Nov 2020 at 21:01, Alex Williamson <alex.williamson@redhat.com> wrote:
>
> Aggregated interdiff versus v1 pull request below.  Thanks,
>
> Alex
>
> The following changes since commit 700d20b49e303549b32d3a7a3efbfcee8c7a4f6c:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2020-11-01 14:02:19 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/awilliam/qemu-vfio.git tags/vfio-update-20201101.0
>
> for you to fetch changes up to c624b6b312680b76d2a19a4c65cfdb234e875e1b:
>
>   vfio: fix incorrect print type (2020-11-01 12:30:52 -0700)
>
> ----------------------------------------------------------------
> VFIO update 2020-11-01
>
>  * Migration support (Kirti Wankhede)
>  * s390 DMA limiting (Matthew Rosato)
>  * zPCI hardware info (Matthew Rosato)
>  * Lock guard (Amey Narkhede)
>  * Print fixes (Zhengui li)
>  * Warning/build fixes
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

