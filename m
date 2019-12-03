Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C417C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 11:08:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA5B3206EC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 11:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h+Fvj1P2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA5B3206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic62q-0008O4-J7
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 06:08:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49251)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ic5yk-0006OG-JZ
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:04:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ic5y5-0004qE-Fu
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:03:47 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:40655)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ic5y3-0004gj-N4
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:03:43 -0500
Received: by mail-oi1-x230.google.com with SMTP id 6so2866217oix.7
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 03:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mAFofRSmgqPrPh0loGDyj1uY2IZMnz9aNohH5BEXoKY=;
 b=h+Fvj1P2+tAfVae2fKhdVWOTISTPmJFA6l+6IFdzGfhKNZNPva5kjDuc+RZ2mErxdy
 5GtFmQrr6nS7bCL97krGhH8Tm3ESFhrHCxLR/Qi84EmoHwBl2k94waDITq7uqdCQtCPn
 ma17Lihat+V86FEGx7jUwF4prVXDgiZsFqAqMFCA/GoIa5wgDjRLDIkeSN2ADNriJfP5
 yWiHhIzmIAyZtxsm5SE0cyHoFqdvoe4RzYynC58gwEbNekHVQMk64rYG9Z0gkt4v3IVH
 oRjg+EBWbD8V6Jr8T6Mxj6l5MwDF2QtYy1f46B0JwbOqgVVAnDpIuHh88J3sPokVjwhn
 94dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mAFofRSmgqPrPh0loGDyj1uY2IZMnz9aNohH5BEXoKY=;
 b=P6ATN3Gs56gw9QxyYe3YMi6slVuuBeBVruyoTmSx7o/IbW94LGiakD+Lvf22SXVyGu
 XeLgBzKZltaVevDW/u1H/lQp/dDQBmPUgEKchXKRJXWZCWPal4CYqF9PoEbLhHw5WffI
 6vH8znt9MMa4bh1J1u4Nd9F8/vFOU8/EB14PuGI0er2i84Kq6J1fMf/v2pZ2fAyx/pZO
 KUfFYKnfWThT0OfDBFgFIq6oijmauTvJyp2vub6kSx5EDCLfDzg1kwGjHGNPgft1VDV6
 Qhi/XxM28K2+yHXpH5N1mMGF3FvyRzsNGrBWYeVuftLv6I7vHZW7LvwNu7GwlYd+n7Zr
 NAng==
X-Gm-Message-State: APjAAAVZ8dbxOxTSGUDYEt5ERGf3ErPlsdzXMRh8BsBZE9QPF8MpHZMl
 z1wrTzqDgrDxZQyXuDE6pzQpevZ9289SSjaj5TVVqkRvUZk=
X-Google-Smtp-Source: APXvYqz2FuBFT/V+8W6t4vECp1Y+1/t+lIDN8C1k0iuq20NvRPOp9Q3wkCiDe6Fdw7bwK9rqJgGHqmO5y7zy0PUpAto=
X-Received: by 2002:aca:edd5:: with SMTP id l204mr3152308oih.98.1575371016007; 
 Tue, 03 Dec 2019 03:03:36 -0800 (PST)
MIME-Version: 1.0
References: <20191203081259.906-1-pbonzini@redhat.com>
In-Reply-To: <20191203081259.906-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Dec 2019 11:03:25 +0000
Message-ID: <CAFEAcA-n2aRb2Lp=Gs9oJkRBiVtPm4eAgCzWrjwMKBAwrWh0Bw@mail.gmail.com>
Subject: Re: [PULL 0/1] HVF fix QEMU 4.2-rc
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 3 Dec 2019 at 08:16, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 39032981fa851d25fb27527f25f046fed800e585:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2019-12-02' into staging (2019-12-02 16:29:41 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 64bef038e777208e4c35beae7f980fbd994b87eb:
>
>   hvf: correctly inject VMCS_INTR_T_HWINTR versus VMCS_INTR_T_SWINTR. (2019-12-03 09:11:42 +0100)
>
> ----------------------------------------------------------------
> * last HVF fix (Cameron)
>
> ----------------------------------------------------------------
> Cameron Esfahani (1):
>       hvf: correctly inject VMCS_INTR_T_HWINTR versus VMCS_INTR_T_SWINTR.
>
>  target/i386/hvf/hvf.c    |  4 +++-
>  target/i386/hvf/x86hvf.c | 14 +++++++++-----
>  2 files changed, 12 insertions(+), 6 deletions(-)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

