Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1CDC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 17:56:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C83C206DA
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 17:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AxA3Dras"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C83C206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iot5V-0007ih-Hd
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 12:56:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iot3h-0004cr-At
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 12:54:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iot3g-0006Ma-4t
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 12:54:25 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:42883)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iot3g-0006M2-0J
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 12:54:24 -0500
Received: by mail-ot1-x336.google.com with SMTP id 66so785134otd.9
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 09:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OAq6J76cZsu2bVStGxW+pkCcF4Ho3l+ElJiJM6rBG1k=;
 b=AxA3DrastXZJjsoWi2t3oQcg/k/umR/BpAi44ROipGe7Yv+ESf+NY2D9CDEyOyzj45
 s0SCsvAOglEAp0L8H7w67YhIYu+vLTsu8Y9o3kpYoSfhDt57c9sr2VMrkzLtrtFgIxnY
 +81UN5ISgLYKGnvJGQJSnDZMOXvANOZCzJ6aJy+y90QCBp/5Ul2dAXPJecftDGWlTXgW
 Zr6FmBkcDaOGjvCVPMNQwkY+Ut9INbthw8xtiQ3Q+BlzYuDAu4Bi/uS+98naFzBhBGA3
 qFTEw8LYCFYfcb3DARFX7nEvlmP/b/ifTZyZ2Pa9nMnQl7RhHhbQZQMCEyqzCoVrFDat
 wrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OAq6J76cZsu2bVStGxW+pkCcF4Ho3l+ElJiJM6rBG1k=;
 b=Mt571Xe7UPbZOqXhakc35bSaTPHpoiF4DdN7eEtdcyS10EZ7kzTRvH7GUhH9vJC2g7
 yvBRy+Fsyimb+1Oi3XsjvaU29frLym3jnXnGmMruIN/eQ2cI7r55vC3EnoT585csRxaE
 tLvFl32dPnifQdJCGchGaMcPubDhisezvBCHYo/uBBoU9rJt8H0jeUAlsUYj/VHBNvHN
 AUC2+6T/iWpP7M6qfnByzJZlvvq/cJ2ekl/iIOK4fREEwgACAVrRd4W23j5AFrM8xISm
 Nw9iOxTvH/hKDIDYVeM+3+cFl144Lp5u/wnntZSA8VVx+LCQcbfZgmx7bgN8m/OLL4W1
 MITg==
X-Gm-Message-State: APjAAAX2F9PkldqEkXplidzZtQs7GpSKZ79P1tAe9BZgiI4d3PGkqOa/
 /2Cqd9frUThiocBfpRZa4zKg87Qk7zeNstYJaiZ7lEiz9BY=
X-Google-Smtp-Source: APXvYqwyz7lPo2RxviRoCu25XY78FM747/pA0m3OrxogNB2+NouYHDKT8N5q6l9NiogyOndTr1t+F4HbFjL/01C24IM=
X-Received: by 2002:a9d:8cb:: with SMTP id 69mr919657otf.221.1578419663149;
 Tue, 07 Jan 2020 09:54:23 -0800 (PST)
MIME-Version: 1.0
References: <20200107132715.722101-1-laurent@vivier.eu>
In-Reply-To: <20200107132715.722101-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Jan 2020 17:54:12 +0000
Message-ID: <CAFEAcA9F-GSqNTwL8oQ5Ft+YAOYBzB_qoPU3FL7_0L2ZbewPOA@mail.gmail.com>
Subject: Re: [PULL 0/4] Q800 for 5.0 patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::336
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

On Tue, 7 Jan 2020 at 13:57, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit cdbc5c51c8755e4e9ce964fc92ba755e1c71a914:
>
>   Merge remote-tracking branch 'remotes/xtensa/tags/20200106-xtensa' into staging (2020-01-07 10:31:07 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu-m68k.git tags/q800-for-5.0-pull-request
>
> for you to fetch changes up to 18b6102e51bb317d25ee61b49b7b56702b79560c:
>
>   target/m68k: only change valid bits in CACR (2020-01-07 14:21:18 +0100)
>
> ----------------------------------------------------------------
> m68k: fix CACR valid bits
> q800: add a fake mac rom reset (used by linux)
>       fix and improve PRAM emulation
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

