Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319F6C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 12:37:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECFBB2071E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 12:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="joWB6r1e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECFBB2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZa5d-0006mn-3L
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 07:37:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52380)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iZa4t-0006Mz-6d
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 07:36:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iZa4r-0003Pc-G0
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 07:36:22 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:41078)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iZa4r-0003Ov-9D
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 07:36:21 -0500
Received: by mail-oi1-x244.google.com with SMTP id e9so16470111oif.8
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 04:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2oSkHUS0hjLAuta86IDGh6g6WXkdAG3lcs5yhXBqyxM=;
 b=joWB6r1ew42d4vGjM5Z8CN3lkIe7SiqXoy89W+hkHkGMMz0OfIvXb28rMHYTXxHfmb
 bwcev+qWLqCLSMKEJ7H0B9jeE9N1YMCFg862n3DVwTGWfCN/SwgCb+QtavdiNzS5KD79
 NXmo58mxv1qGump4sT1XEu1ikbClFVwFci8IdV1srMjcCMZMkAUpcmv4+6Y9k62uwaQc
 SGp1hK49+sT1qLg7UWh6E2KqCnMw7HZBUouNbUyzr4pGZSjMTrgqZnfIGaCiF+hsoyDj
 o/+cC0RXVKfxNS6FY+xMvLVwAMeUIxqLH51wLqXSPOz9TOlHMy1mmVWDIiyj6409jZh0
 VDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2oSkHUS0hjLAuta86IDGh6g6WXkdAG3lcs5yhXBqyxM=;
 b=ZVL6oc2BbeZiAFyHcHmnUo6D99CZ1AOFN8D+AZcD+RMfbFZMTALImjz/IGuNrMlxbZ
 DEXoXZkaDtH1+CM2N1464jLezyGEiblEbfd2XNuFCHfNu8gS7ONt4XV6sXpdIeKCh1ih
 xZtsYUhfJWxKbZK7ZZ3OYHj54VqsZutjZnaGh0eJU3tJAQDWU4TCGTlMzDs71ijX+0Ex
 s5Om4vc9/WsCxTCswvqrFAdrTPxWPnI0sHLbq5t30QkD0QmJgaecpDYtBiUdEdclQszH
 7o3N2jApVVeswJeuwKLmUZ6lEwrFxZopD1ag9qB+4+wg6fzdUEW9Y/GrjYKJ1UYHO7tb
 ipGg==
X-Gm-Message-State: APjAAAWzrVdRjnM+KvFAxgDtsLEenvDA8cZIaRaLypbwt5PohmKMWrWi
 idKdnIF2YNXeibiwOSEjVCZj5dtY3DzTj6evybxqeZDQn+4=
X-Google-Smtp-Source: APXvYqzo0DaRV35FupoQKykfw6XoKMRnOFLBU89fbVyGirgAOYfXVIvrx3Ger/Uk/ObgoRNVhuVQPnNyEXYsc1v6NuY=
X-Received: by 2002:aca:cf12:: with SMTP id f18mr3263289oig.48.1574771780038; 
 Tue, 26 Nov 2019 04:36:20 -0800 (PST)
MIME-Version: 1.0
References: <1574696407-4188-1-git-send-email-jasowang@redhat.com>
In-Reply-To: <1574696407-4188-1-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Nov 2019 12:36:09 +0000
Message-ID: <CAFEAcA-+pYoLmS_rHYPgpMiZaoma=qBHu_LPF9d94ebKS18JOA@mail.gmail.com>
Subject: Re: [PULL 0/4] Net patches
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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

On Mon, 25 Nov 2019 at 15:40, Jason Wang <jasowang@redhat.com> wrote:
>
> The following changes since commit 122e6d2a9c1bf8aa1d51409c15809a82621515b1:
>
>   Merge remote-tracking branch 'remotes/gkurz/tags/9p-fix-2019-11-23' into staging (2019-11-25 13:39:45 +0000)
>
> are available in the git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to 4d0e59ace29277b2faa5b33c719be9baaa659093:
>
>   net/virtio: return error when device_opts arg is NULL (2019-11-25 23:30:29 +0800)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
> Jens Freimann (4):
>       net/virtio: fix dev_unplug_pending
>       net/virtio: return early when failover primary alread added
>       net/virtio: fix re-plugging of primary device
>       net/virtio: return error when device_opts arg is NULL
>
>  hw/net/virtio-net.c | 58 +++++++++++++++++++++++++++++++++++------------------
>  migration/savevm.c  |  3 ++-
>  2 files changed, 40 insertions(+), 21 deletions(-)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

