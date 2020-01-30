Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAB8C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 14:19:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75F462051A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 14:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tMYSPo+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F462051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixAfM-0005b7-KY
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 09:19:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32884)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixAeb-0004mJ-N2
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:18:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixAea-0006O1-CZ
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:18:45 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:34948)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixAea-0006NO-5o
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:18:44 -0500
Received: by mail-oi1-x230.google.com with SMTP id b18so3658120oie.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 06:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=BjRBXr0Gmyh1NvX1u4lGv0Gf6VTORDxufiDUXzX4Was=;
 b=tMYSPo+msz4gLrrqNuK9NXHUTrszpiMXIgiCtxLg/F19v6HJwFDUTvHfMopUVcoHRf
 Pnmwrez1MfvuXeEOGrE7+2WhN7BGzMOPnnew9GlQqEIdQtMHoKCs70wwoFHhN8KhMGKg
 DHqDNNMGvZN6xz0tXz/k8eNBnZkTnLHnATbs/kp3/Yhc0/i2RiLUjFxNS3S/1q3pW/bO
 GTtrnmFVzhbdm4VfRmOKFUI+s1F7b0Wp0Sj2zb6byPeZfKtB7s16R/VV0TkdHo4vC48G
 5XEjGYnJhZyCXnXhmyoxXyDvFlmicvPtpRu1bAhSwGc0F6oJDOtxxSFDVxBOUPfB7z7s
 zlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BjRBXr0Gmyh1NvX1u4lGv0Gf6VTORDxufiDUXzX4Was=;
 b=fzcQuGhYsK/bHquX5ArAhNgWlrfnlJrqsdwAk7eMK3dDy6k+43ja6F0KlKVRRbhe5h
 mmGf3jD6MZVqOcNc6Wvm1DK9CUSiceXFoBAmUF2EXgJueBUV87jWcI9xH7eIRd/KRuRp
 tyZJQLU1hA8S+IpbZa+IfdGExsjmeZAew6HjRHFZCVAp248knGL2KqWqlud0qq6ZL+xz
 gmnsgIllm2YshXvRhdrEstlmS0bkQJkOpFfA36AorQ7qdbKvo/Uuevu+K26moGAW0zlP
 TEpdBlRlDzqBiJXFbg2dK/Vo1Q4YfZlo/E3Kz4VQ5mBO32B/3c5h8KbgKbMX/FrWcTfo
 gVww==
X-Gm-Message-State: APjAAAUnM9Kr9+sSTobDYfiRfiyD03IDA+PidTxieRmZosZTqG62yM17
 6LFpk3wOZm2WXtQMSZbP26GbLt/W/YSjKxE6XFyA2A==
X-Google-Smtp-Source: APXvYqzj4zYtIKp42eVi/trP6Dvi8dGmz+BLBoxQhcUOHbZR/kM3F43qx2QvPMVZwB31yLSg6u+2FpcdUhMrbo5ADnU=
X-Received: by 2002:a05:6808:3b2:: with SMTP id
 n18mr2897170oie.146.1580393923291; 
 Thu, 30 Jan 2020 06:18:43 -0800 (PST)
MIME-Version: 1.0
References: <20200129130845.1886915-1-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20200129130845.1886915-1-stefanb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jan 2020 14:18:32 +0000
Message-ID: <CAFEAcA89n7bsdvG9kpxUhu35DvpYrtv4ngrMwtDM8UeKw8zApw@mail.gmail.com>
Subject: Re: [PULL v1 0/1] Merge tpm 2020/01/29 v1
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::230
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

On Wed, 29 Jan 2020 at 13:09, Stefan Berger <stefanb@linux.vnet.ibm.com> wr=
ote:
>
> This patch fixes a post-copy migration error due to an unaligned start ad=
dress.
>
>    Stefan
>
> The following changes since commit 4c60e3289875ae6c516a37523bcecb87f68ce6=
7c:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-pa-20200127' into s=
taging (2020-01-28 15:11:04 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2020-01-29-1
>
> for you to fetch changes up to 71e415c8a75c130875f14d6b2136825789feb297:
>
>   tpm-ppi: page-align PPI RAM (2020-01-29 07:27:07 -0500)
>
> ----------------------------------------------------------------
> Merge tpm 2020/01/29 v1
>
> ----------------------------------------------------------------
> Marc-Andr=C3=A9 Lureau (1):
>       tpm-ppi: page-align PPI RAM
>
>  hw/tpm/tpm_ppi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

