Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5E2C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 14:09:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C409622242
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 14:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cRBY0iyy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C409622242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZE3J-0005fD-Ss
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 09:09:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZDxs-00031v-Iz
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 09:04:12 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c]:45977)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZDxo-0005gK-TY
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 09:04:12 -0500
Received: by mail-ej1-x62c.google.com with SMTP id dk16so14362455ejb.12
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2020 06:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Pj5h8g/hFUrUEnoxVhmM8FsQNthXkpXS3vn/Xg9zEYc=;
 b=cRBY0iyy2swBY4wdMYxMME64D9hJleXqT450KRIFtN6Gj3zix9qz1rr9R5FqZ0VVY0
 nD4RuSN6n8OkMmD4oD2fpiqCgpanGRATvcyfqvuPAAEz8zZSusIFRjekSkqRTGQCHfB2
 q5OMzUN6H2GVAWp+hDuCgiiON47Y/OzgOsV79JVYAyGEWyriqi3Eo1ioLelDpkI0Jdhc
 qfqDSxUjLEXMfXFTiUcM0C6OQu00mJ3R/5NW/X0Tgnu0tHE0IcgeIZRQi7BhlyDO/VvP
 edjdOGcvWNhqZJK7yNbaQ+1k0OyNbSoEyJFfXYNGhj7TPMwkV3XEyJNqvwBdCbCAIiYv
 AwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Pj5h8g/hFUrUEnoxVhmM8FsQNthXkpXS3vn/Xg9zEYc=;
 b=qYR5+zh0vY7LWY2aCw6602GAp2zr23P+VRfUEI0kr9xGCnslWeK9pIMQXZDHS2S/96
 psDSgbOSykfsMo3Ei77EAMD+8mKWcfaRYrE4fejcWH6k5e6XRd0WKIvBJZFwcy/qdiBZ
 tHJMQh2UdLIrSpecoANHXAYDDNK0ggt+3P+4DZWQ8AG/+lXWYXOjoPe525muT3YPuD0N
 fseLZE0VC2n7A+ZXTt4GU/LYqrl59kbW9uuwTjF+wCurLLw2Ip6jMIUd00d39eFokEcz
 fK8QHGznOfOrkPHOwInTx4ZtfSx/LuZmTzXBwp6CoR2Wc70L+aQ7hboe0MXBzq646jBA
 ioyA==
X-Gm-Message-State: AOAM530M7tvMf+Ar0Yw8xmnN4tF5lOmUuyItJ7q7FUClS4VRzuE8/GVh
 hul4TkOCqXVZhwcwC4LmkjmDG0QNGb5ED8Wji2q/CkJorVI=
X-Google-Smtp-Source: ABdhPJyOjoh5lA45sTRznzLxy8zJOM1GYKYv2IbEKYujrvUjKt8LnHhVfuXXJ18pV90uhOLe/Mywkh8wKERzegyubQk=
X-Received: by 2002:a17:906:af8c:: with SMTP id
 mj12mr10786539ejb.85.1604239447062; 
 Sun, 01 Nov 2020 06:04:07 -0800 (PST)
MIME-Version: 1.0
References: <20201030141136.1013521-1-mst@redhat.com>
 <160406842210.5222.16586020334648182159@66eaa9a8a123>
In-Reply-To: <160406842210.5222.16586020334648182159@66eaa9a8a123>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 1 Nov 2020 14:03:56 +0000
Message-ID: <CAFEAcA_vzpTivJSGmM2aR56-z5adXe0hn9A8K+2Hb0KdR6sXkA@mail.gmail.com>
Subject: Re: [PULL 00/15] pc,pci,vhost,virtio: misc fixes
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62c.google.com
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 30 Oct 2020 at 14:33, <no-reply@patchew.org> wrote:
>
> Patchew URL: https://patchew.org/QEMU/20201030141136.1013521-1-mst@redhat.com/

I'll apply this pullreq (unless it has other more serious
issues), but could you look at the coding style warnings in
a followup patch, please?


> 9/15 Checking commit 660b206b990b (pc: Implement -no-hpet as sugar for -machine hpet=on)
> WARNING: Block comments use a leading /* on a separate line
> #53: FILE: hw/i386/pc.c:1152:
> +        /* For pc-piix-*, hpet's intcap is always IRQ2. For pc-q35-1.7
>
> WARNING: Block comments should align the * on each line
> #54: FILE: hw/i386/pc.c:1153:
> +        /* For pc-piix-*, hpet's intcap is always IRQ2. For pc-q35-1.7
> +            * and earlier, use IRQ2 for compat. Otherwise, use IRQ16~23,
>

> 13/15 Checking commit e013e462e230 (vhost-blk: set features before setting inflight feature)
> ERROR: trailing whitespace
> #45: FILE: hw/virtio/vhost.c:1651:
> + $
>
> ERROR: trailing whitespace
> #50: FILE: hw/virtio/vhost.c:1656:
> + $

These all look like nits that should be fixed.

thanks
-- PMM

