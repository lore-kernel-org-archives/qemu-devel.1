Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76732C433E8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 08:15:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B98420672
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 08:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pnoQaKty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B98420672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Klk-0007Yc-Hw
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 04:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0Kl8-00076p-Vb
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 04:14:50 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35720)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0Kl7-0007os-4l
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 04:14:50 -0400
Received: by mail-oi1-x241.google.com with SMTP id k4so16752211oik.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 01:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jZmLVwaJb+7MUJARjYNIfs7wBH+N6us3PNnhKbScvrY=;
 b=pnoQaKtyGrqgIVMM2XdIuz+GCgEPEuF++y6Ut8jEnO9KxiGJGQNmBWAh69p367PUME
 J8ExeK0cDaFnE2mBkhBcx5O3q+s2r+ixlqq0d6bey3fQ4DROafYlgoa+AsNSYGUmsaMD
 Quwye5w3xRonmuINoe3NSAf7tP8vm0aC21sTahN9SbJ/KBx9aOOeXl397Rw7eUo+cSYp
 tZEPnDcSgVRRqm4YhVVeFNP+lyMx8N4JKBVmk5E4m2UYBAXvXkly+XXi2jOTK3DOx9At
 tP7eBz0RkEHZykFkxRAYywfzDafP/3tjVRd1zs1ERNzyk4vRkzrJBaYvehO5/iV2KtMK
 rJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jZmLVwaJb+7MUJARjYNIfs7wBH+N6us3PNnhKbScvrY=;
 b=g8DL/I8NhXsrn8GdLkk3esOPlC2FqRXaTVarBzdH0kb2b/OLjySXD3OQXQRiAUzzDX
 y08MbNK20Q24O7Ng5sSVnEMFUzjrZiL6kFaKYnlsZk1ZAktYG/L3Wxlw6LRc5ihD4V5b
 WFwbLORRrI/M8FNmGcQEnWtb8hxZAZikr0odrkQwgqx+Wm6NH6Mp1mt8IMUdTnJmsPh/
 HjaIDARuDsr0Ds3cuZRB1Et6xS+Y/XEAj7kyLLM+CIdkFl0fR1+T7T12BF+A/Uwp0XXp
 9liFMNX82Fo8wUWlwiauT9VZd2nchVVB63CrMrD1XgJCy9+JJGjXcuNvpPdPGlZPo469
 RoDQ==
X-Gm-Message-State: AOAM533PwvDoKyXJCSl+aEQsbqtjb3LOzmwSnKfPMJfWwm6UYVwwoZ85
 3E3OorrU//4m3WK4nUvIi0mtSl7JUnQBNy7+m0BPYg==
X-Google-Smtp-Source: ABdhPJySyrxz+9iMtRBJU7ox8HlD8C4aQrRSQLhLIpPbEfzPd7cXHmy5NSXTvCAw61z4UHW0Vnui81Gx+55F2w3iCrk=
X-Received: by 2002:aca:50c4:: with SMTP id e187mr2442624oib.146.1595924087697; 
 Tue, 28 Jul 2020 01:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200727143104.97776-1-mst@redhat.com>
In-Reply-To: <20200727143104.97776-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2020 09:14:36 +0100
Message-ID: <CAFEAcA-Q9N8+2-6PJ1whVsn_2SQ8Xm9-85mSCfTPuN9VrJzoDQ@mail.gmail.com>
Subject: Re: [PULL v2 0/6] virtio,pci: bugfixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
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

On Mon, 27 Jul 2020 at 15:32, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> v2 due to issues noticed by dgilbert in v1.
> Changes from v1:
>     dropped a work around for pci migration for old machine types.
>
>
> The following changes since commit 4215d3413272ad6d1c6c9d0234450b602e46a74c:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-5.1-20200727' into staging (2020-07-27 09:33:04 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to d0d89526f70ded5ac41a4c6bb071c0d919b772db:
>
>   MAINTAINERS: Cover the firmware JSON schema (2020-07-27 10:28:28 -0400)
>
> ----------------------------------------------------------------
> virtio,pci: bugfixes
>
> Minor bugfixes all over the places, including one CVE.
>
> Additionally, a fix for an ancient bug in migration -
> one has to wonder how come no one noticed.
>
> The fix is also non-trivial since we dare not break all
> existing machine types with pci - we have a work around
> in the works, for now we just skip the work-around for
> old machine types.
>
> Great job by Hogan Wang noticing, debugging and fixing it,
> and thanks to Dr. David Alan Gilbert for reviewing the patches.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

