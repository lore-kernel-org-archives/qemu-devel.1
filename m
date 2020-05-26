Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A807DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:06:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70BA92084C
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WmR2KiwW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70BA92084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdZHr-0007Fg-Ny
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 09:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jdZHI-0006p5-BQ
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:05:56 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:42592)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jdZHG-0001GF-FB
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:05:55 -0400
Received: by mail-oi1-x22f.google.com with SMTP id l6so18558900oic.9
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 06:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GRY+xzPVTaAZmVXkqMKMo72JrVNxvzKKCB8bjW9i2dU=;
 b=WmR2KiwWCW6QyXaycpT1QySyG6MhFCqkWKZeityuCt8nvHIX7mYoIAsYjuh2WdVFw0
 IRy3iWebrTVOjuNIBc3JfeqgRtCWn5Uf7ttiISn65C7HZjJ2PZfyX3H3jqG+yc29c7tj
 zie1UJZchG/8QKNhSVGXDoZr7LJSCeu6sLy5nLIzCvoSyhs0jGWr49Y75aC88FGr0ixA
 KCd0TPvbPTFNUiwt0vS7JhAlWUaUUV1ShwNBbiqKs0jWu+f1eS9ItOBBqRcI0yrMGGzq
 6DIw5lR6LkUG0rJE/DasxJTMbZg5zibxwx0ybzuZrHyxxnZsshGFVyKadbKM1yIRfCiq
 CTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GRY+xzPVTaAZmVXkqMKMo72JrVNxvzKKCB8bjW9i2dU=;
 b=G16hL5qMUVCcqBzKLLbBIgDZj0DSAzq8KPJ7D3f11zdNH9oXDViAO8E6Dpenkz5dcu
 PTcm4VSepth55TR+zHwh7D5oeh+mBthl7kWW6GI51Mu0UseBhSNlbaIb3ph/OfiH6GNP
 4lCh0mnCHKtaga1JBlvg7WiGzANBCZup4pDTZnRUoxv6izGWvCSs+5+qy6QiVfpKd9DA
 jeq2cmrp601Mao71KiNFVI7eerdAOrCEWNNB98qak9/S8uacLFR96wXIzNbcc8Xl+uPs
 /hSRnj7BRp8NL4wCrqI8ybItgKzgvANI7nItt1FOxMzVKtSt6DZBYl1dGBJ+stVspAoI
 x8Lg==
X-Gm-Message-State: AOAM5331FMtTx8AIwakppQz5EWZsA0jpyuRyZPC+s/dFr3GMkBymXFaE
 zubeoG2MJyUrku3ctaDAcD3tZNVJo3aM7yPY3zOsSQ==
X-Google-Smtp-Source: ABdhPJxTKPj7xZzjI4CcmshmnIC5Gx/nFsm2ExnHSoyBO4gfOhJ7bKVk6gNy1+OzylA1Nh2CVgYWccqADP1FKty/6+Y=
X-Received: by 2002:a54:469a:: with SMTP id k26mr9170665oic.163.1590498353044; 
 Tue, 26 May 2020 06:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200526075639.27949-1-kraxel@redhat.com>
In-Reply-To: <20200526075639.27949-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 May 2020 14:05:42 +0100
Message-ID: <CAFEAcA_Rf_uUtkAY_8fZ3pL0hZMphs_xRC_7Nb6YDcnLU+rpVw@mail.gmail.com>
Subject: Re: [PULL 0/8] Audio 20200526 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22f.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 26 May 2020 at 08:59, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit fea8f3ed739536fca027cf56af7f5576f37ef9cd:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/pflash-next-20200522' into staging (2020-05-22 18:54:47 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/audio-20200526-pull-request
>
> for you to fetch changes up to b3b8a1fea6ed5004bbad2f70833caee70402bf02:
>
>   hw/mips/mips_fulong2e: Remove unused 'audio/audio.h' include (2020-05-26 08:46:14 +0200)
>
> ----------------------------------------------------------------
> audio: add JACK client audiodev.
> audio: bugfixes and cleanups.
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

