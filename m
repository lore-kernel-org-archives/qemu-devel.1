Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F82C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 17:21:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CF9E206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 17:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x3emrL1G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CF9E206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k30dK-0008Fr-KO
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 13:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k30ce-0007XT-Cn
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 13:21:08 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:37170)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k30cc-0008JC-O0
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 13:21:08 -0400
Received: by mail-oi1-x241.google.com with SMTP id e6so16800433oii.4
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 10:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=t7VmFSxjy/ThZ0efOei4Vu5UYq36uY2GFltfBnNnmsQ=;
 b=x3emrL1G7gPlr+qXIRNhbsPuduHOCCajwVHViK2c5q9Uy/gRDZVYFcUbsbEj9r/vwX
 Q7tJvXUtposWn2jm1n2oatwefmt/X1K7NXpGFLbB549zW/MOAbs77idFPbv81+MuqlKF
 fd4STih02qGPVGXFzWTf/u30XytdkfGFAcjJlITna4kzCjsec+UlGh1u+oum+vLPaE59
 l1/o68qAwHo0+7fL951JkqUP/qSxkCrdCPtuHGWB7EYumFGDbsBsKf2fCutmJxMI8YVL
 D1fmMZIAf35T35uCdqskZadpkKP2LR6OtOQL1lGc4C5agOIiVf1VVMzTbkjOYcMOO+kr
 EeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=t7VmFSxjy/ThZ0efOei4Vu5UYq36uY2GFltfBnNnmsQ=;
 b=qVV/eCT0JKWxXG+GH9yWfpZgeXPb36TwfuC7sZ6kFIGKLdLAL2OTpxgWVNzAtcHG3y
 0siFSbepa/lGPToONRjMnhsQvQRLf+0QMxJ0VpyJY9b35BFpUvK1USrykGe2YUTfBe6J
 Gi9oZKXDlgQOprmNYCK/s6pRF2EqAYzOY3lTx27ZUM00tU/kwvecoC+QSiVMl0WdHicU
 A59fOWqVYz2hcYh1S9go5HiYunRR/92a4MQrUCmZWexdHueG2sjc3fb77gQQaRZ0+lXz
 oEGnheJ/ZHg1LmmrB+dYZSxZnFZFwFsCF63pO64vvne1gsnNRZqWKH8lunUBypvx+37V
 8Ecw==
X-Gm-Message-State: AOAM532F5O7CtPsFL5bQSRC8O3IAxe/X/riNvW5IjQFurlCSkfJChR4z
 wlDEfBpgpWpoHe9n3Tua1x0S6iT4T6OIyrPtyDlOnQ==
X-Google-Smtp-Source: ABdhPJzTxYp6QkFxhUGaNKeIJ5MghdSnrEyAKeOip6ni8byE9XJqoA0sHaBtiEG/CVU0jy4tlWa/nP3xigwi/ef4xrw=
X-Received: by 2002:aca:50c4:: with SMTP id e187mr4098517oib.146.1596561665163; 
 Tue, 04 Aug 2020 10:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200804141640.591031-1-mst@redhat.com>
In-Reply-To: <20200804141640.591031-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Aug 2020 18:20:53 +0100
Message-ID: <CAFEAcA_38GRFmdOyxtN+KbO=PtuvRmsgJ2QN0zcpwm4a5Hypmg@mail.gmail.com>
Subject: Re: [PULL 0/3] virtio,acpi: bugfixes
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

On Tue, 4 Aug 2020 at 15:17, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit 5c1c3e4f02e458cf280c677c817ae4fd1ed9bf10:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200803' into staging (2020-08-03 20:34:26 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 5957b49b423fe456896e10f7e4a6c69be07f9407:
>
>   virtio-mem: Correct format specifier mismatch for RISC-V (2020-08-04 09:13:34 -0400)
>
> ----------------------------------------------------------------
> virtio,acpi: bugfixes
>
> A couple of last minute bugfixes.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------
> Bruce Rogers (1):
>       virtio-mem: Correct format specifier mismatch for RISC-V
>
> Michael S. Tsirkin (2):
>       i386/acpi: fix inconsistent QEMU/OVMF device paths
>       arm/acpi: fix an out of spec _UID for PCI root


I applied your updated pull with just the virtio-mem fix.

thanks
-- PMM

