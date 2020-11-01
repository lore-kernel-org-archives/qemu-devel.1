Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09434C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 10:43:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A77D2072C
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 10:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vxN1e/X/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A77D2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZApa-000296-Bn
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 05:43:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZAoo-0001k8-Ry
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 05:42:38 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636]:39929)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZAom-00026v-U0
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 05:42:38 -0500
Received: by mail-ej1-x636.google.com with SMTP id s25so658030ejy.6
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2020 02:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=D2sHfExj/leOr50ovkTi4PQ2PK2u6JdkAnUkU1hWfXo=;
 b=vxN1e/X/s4yKXRAgH9lDRp3P5QEcLBhflLVkHYV8XOog0d+w8m76qWPQiHyuWVS166
 Gc+R11KbLdoYQKEb06vjJAHK3HYCC4eTygaMq0YJY7TYrNdd5Lc3FKsyU7bMUxXD5k9Y
 J7ABydrIfTCpWCOmytN6L72+1UVbM2M8DyZjY+Ki/96FpZtqSzUxE0E4/FAV/KlQ+cBE
 wNwOmEfiJPl0slO6m9WCk2r1M/19+Lc3hkxyCQDGjXvntD4d8xXZLlYAR3IJEe56CObY
 yb1JJ1wQ/L+63xT6pu+4cxQgtuChR10OOoE2yCUY6+RaEwNFXns3D+keDPEwy0Fw+Jnj
 vvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=D2sHfExj/leOr50ovkTi4PQ2PK2u6JdkAnUkU1hWfXo=;
 b=MQxd7wrSkrcUm3YmjNnO0KePfwlwjEr/R/PnAiXHw2QCmOcN7zwuv+XH9lEztL5AVO
 ZgUTqMJYBdoQ49PPYrfZ7YBnrcs/dB9bLsVQJJhdKJG/QG/rnNgUJFED8N4GeyDM2n/R
 1D7pNodptgcmr6RVRS2uW0bDhHyjVNgIIuFYoXwYa6qwqRhqkIQ2my1+w5Ni9Uxfj38I
 XUZQCNwNuwnhVgJHkUwFzJJejY3oFk02hVULKCWfzb5M0u5uJHTsfIhWcFpgIT7RGJRn
 pGmj985si9By90ABN7tjLapR56SrRMXrCZ2k6c43ITVvRPL8EiWSDYGAQ2xCtf7ea8Qh
 7B+A==
X-Gm-Message-State: AOAM530imjvb0trdGcscjM0q3xH9Z7UeAnr5MDuCoc/0AXE8OqpjvIKh
 su+ZmS1X3+qsiyfaqsoe+DWc/9LXjFLVAxMBA0JXLg==
X-Google-Smtp-Source: ABdhPJzL0dInRTT8XVX+qRfW9mjmbx1dYQotZBab8sePLxwPcpkzpRKbqj3icL/7XmPATCEJoCiwaXEEnJUNdy5ilrY=
X-Received: by 2002:a17:906:7254:: with SMTP id
 n20mr10093514ejk.382.1604227355151; 
 Sun, 01 Nov 2020 02:42:35 -0800 (PST)
MIME-Version: 1.0
References: <20201029110957.11062-1-kraxel@redhat.com>
In-Reply-To: <20201029110957.11062-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 1 Nov 2020 10:42:23 +0000
Message-ID: <CAFEAcA-TvVfcf41t48b-UOL6f3xnVTzfeZW1y5gjpdCspYUCTA@mail.gmail.com>
Subject: Re: [PULL 0/5] Modules 20201029 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 29 Oct 2020 at 11:16, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit bbc48d2bcb9711614fbe751c2c5ae13e172fbca8:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/renesas-20201027' into staging (2020-10-28 16:25:31 +0000)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/modules-20201029-pull-request
>
> for you to fetch changes up to 546323bdac18984c771ebefae1046ee61742f9ca:
>
>   modules: turn off lazy binding (2020-10-29 06:37:24 +0100)
>
> ----------------------------------------------------------------
> modules: build virtio-gpu-pci & virtio-vga modular.
> modules: various bugfixes, mostly for macos.
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

