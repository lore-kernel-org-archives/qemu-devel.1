Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEECC388F9
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:36:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D221208A9
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QWZ06nMQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D221208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZdkb-0006Dp-7F
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 12:36:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdSV-0002BO-6R
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:17:32 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a]:36210)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdSS-0007Mh-7K
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:17:30 -0500
Received: by mail-ej1-x62a.google.com with SMTP id o21so12894544ejb.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 09:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XGRW0P85vubc8Mkx0vN2N/OeC7sS23ThAUPQR2NCAt8=;
 b=QWZ06nMQEI4DytQUM+lYgbqeydsrOlDqNjSUBHW4nMSWjv7sb3n6X3BL+Y/524awUF
 uke38eR9fSAo6UnX28TfU3eI4PD9pDwu3PIQOWUo74OiXOcQie40t+BJlXz9yKuTa6YL
 OJYMlfFECNibtD7fL/vNE9sO6X9GDe42M65C/WUKs+8eQzJwryqh0stdXjVfEgRCWl6h
 Shq2PaPNsdZoOTiM8TXm4BEnMqMvde3IJJSHe5dOlk+015AH1Q1NQdfqC0C8yVMb1LnJ
 HNnJ+/IZ5MOl7tXiqF2S2F49HHp0s0k53liRruyZ1/Y5O8iju1n7Z2QzLOZj9NDiU64Y
 HPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XGRW0P85vubc8Mkx0vN2N/OeC7sS23ThAUPQR2NCAt8=;
 b=sxKCXWm5fsgxO+BVU24ty487CAP/7Xy3Gf00MZhs1sRVlE3q+TwchQ7vVP3kBVjZTH
 /q2XkGuK7XD7XNjbX+ChS0BnWGp/Pyc2rmmv2Tj3YxXsHzkMG7Lt0jylU4e+Y52tMh5t
 Nt8m/HSOPO5qnlve0oPMbLIfusY9WlbOUTY9KcE0AMV01BEqQRJwQYwaspgdG7TxgMOg
 FtUEaDOD0X2c13zHoGKvvdlzJJYZPllluQEi0EQV21REkk3aNkHkbUsPjTGbQfak/SIj
 0u1+rdjwa1AxhOWxuypSPM5o3GukhAIqIDtZDU7fdePKqK5WJ75b2/qTyNZkoRL8WqqH
 OiyA==
X-Gm-Message-State: AOAM530FIDPUjc4yp1JPH8m/j5oIC2p/LtxKacgzxwK5R/ASCbWoGXSe
 W9eY9lqETAqE+R4iU1otMfQlwvLnzMh5zNBO2oyh5g==
X-Google-Smtp-Source: ABdhPJzd4SAoBQAtsrmnXmKMrxholBZRxAq4plGgvjJQkLNmIGb3giUdvoZrJQu0rxObHjC8hZCbpJyDRyTC+/rCSSY=
X-Received: by 2002:a17:906:7254:: with SMTP id
 n20mr15577768ejk.382.1604337446627; 
 Mon, 02 Nov 2020 09:17:26 -0800 (PST)
MIME-Version: 1.0
References: <20201102144454.995592-1-anthony.perard@citrix.com>
In-Reply-To: <20201102144454.995592-1-anthony.perard@citrix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2020 17:17:15 +0000
Message-ID: <CAFEAcA9fUBTFqQ_oM1SN5qPP9me9tJ1KvFpAr4RSQuteKFKv3w@mail.gmail.com>
Subject: Re: [PULL 0/1] xen queue 2020-11-02
To: Anthony PERARD <anthony.perard@citrix.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Nov 2020 at 14:51, Anthony PERARD <anthony.perard@citrix.com> wrote:
>
> The following changes since commit 2c6605389c1f76973d92b69b85d40d94b8f1092c:
>
>   Merge remote-tracking branch 'remotes/awilliam/tags/vfio-update-20201101.0' into staging (2020-11-02 09:54:00 +0000)
>
> are available in the Git repository at:
>
>   https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git tags/pull-xen-20201102
>
> for you to fetch changes up to 045b1d4dbb44da67f1f86efa75b02843c0e951ef:
>
>   xen: rework pci_piix3_xen_ide_unplug (2020-11-02 11:56:55 +0000)
>
> ----------------------------------------------------------------
> xen patch
>
> - Rework Xen disk unplug to work with newer command line
>   options.
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

