Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E82C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 15:11:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30408206E3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 15:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zGcZkzKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30408206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxtvw-0005oH-86
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 11:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxtuh-0004kl-RV
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 11:10:39 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44549)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxtuf-0003On-9H
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 11:10:39 -0400
Received: by mail-ot1-x344.google.com with SMTP id 5so15262570oty.11
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 08:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LncD1hw+2oF5tyXzRx3gTl9IJJGzp+imbaeln9QC0t8=;
 b=zGcZkzKHtjoUu3dbnoS9BEmZlSsEQ2/LBkvmlTyXbqfXm5xNzVR5Ngt7+o4C4mmAVE
 c6oBRDSCgBEakhWY609qpJwwhDdHukC6K73VbmIqJ8ssBcLP4ANuTLr5LgfqznCp0iKP
 EB/vfWOp+ZyoZ/aw/ZcQSxa+JFs7M3lMIOYBES5vPfpEy4TOg8S++IVOU1sujR/ROZ1+
 Zl82i0XGghUI1411FC0n38ukQ3Wp/Hv+YjwtYncbYRUavjsoGNu25mlhtAgC7MQIdnS0
 VfJrxuqKAaQ+kpuJ0J+ELqZs40HJxvpeA+Bg0BM8tEv2Q97hfCVXU5gvTjj8ZGvYUgpx
 /5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LncD1hw+2oF5tyXzRx3gTl9IJJGzp+imbaeln9QC0t8=;
 b=cgx3ZG8+wrAO0olHni25s6+2daGSKkktk8wIK7fh5U4pxY3eacuxDzhz/MTy0nPutE
 Vz1ervix/M3QDSfwHEQ1kYW1RTZd0N7toDEBnxaxckdGMqSbgzArC9C/6TDCY99Sf4wg
 M6cETcXPfrLyyRHlPGeE6soEhmG4hREqVAUb1YX/2rJo7CLKTAxc/4BxGTPkZ3cJyjv4
 8m6DkkAPvmSox72cjZZhC4UbnOQuKwKkYXKd6H8wRySQG9Zy0S48+hr9wezwH05jVoDl
 AnfyChKyL0jDWXBQFJhkd4J/qJ6uV0U08HqgLIrp2wYz/a7YA1yL1HHfTJYNVWAXHclP
 T8NA==
X-Gm-Message-State: AOAM5317bKE2YQKVQrgxiupkZgYy/KIhlg+r25ctXKh97kEnKSm2Ksbs
 qsp+iOOeDP4LyfDJ/gT8mDjiSEQk09LV8xHNPq1UsQ==
X-Google-Smtp-Source: ABdhPJzxflDAEg59YNYNVxklxfpVgnrGAuoOfNBCb1j1uakS7BXFDUT1QOooBKN+plWsry0L8KG2qgKVDxKRWUBrfmE=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr24541592ota.91.1595344233979; 
 Tue, 21 Jul 2020 08:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200721114920.1174149-1-mreitz@redhat.com>
In-Reply-To: <20200721114920.1174149-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Jul 2020 16:10:23 +0100
Message-ID: <CAFEAcA8rMZ4kKkdRun-WanYBKt+DQoAysL0jprBh1tG0DavgaA@mail.gmail.com>
Subject: Re: [PULL 0/3] Block patches for 5.1
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 21 Jul 2020 at 12:49, Max Reitz <mreitz@redhat.com> wrote:
>
> The following changes since commit af3d69058e09bede9900f266a618ed11f76f49f3:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200720' into staging (2020-07-20 15:58:07 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/XanClic/qemu.git tags/pull-block-2020-07-21
>
> for you to fetch changes up to 1d719ddc35e9827b6e5df771555874df34301a0d:
>
>   block: fix bdrv_aio_cancel() for ENOMEDIUM requests (2020-07-21 12:00:38 +0200)
>
> ----------------------------------------------------------------
> Block patches for 5.1:
> - Let LUKS images only be shared between VMs if the guest device was
>   configured to allow that
> - Fix abort() from bdrv_aio_cancel() for guest devices without a BDS
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

