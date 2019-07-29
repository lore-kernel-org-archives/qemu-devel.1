Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABB0C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 09:14:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6A42206DD
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 09:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="itEl3xP5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6A42206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs1jv-00019L-Ue
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 05:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55533)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hs1jW-0000kx-I9
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 05:14:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hs1jV-00057R-H2
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 05:14:18 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:40839)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hs1jV-00055g-BJ
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 05:14:17 -0400
Received: by mail-ot1-x335.google.com with SMTP id l15so4579264oth.7
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 02:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WfwmneNpdYSmSj1xK8RigfohyWd4Vq0IkEKZeWpChiA=;
 b=itEl3xP5dthsrRdj+GQMw/tCsoCtOdQ+GTZFDy3kFx3ZR6LBD1vsTOg9ZvUvO7r4oz
 eDf7thYGUlgmUqj0hCqlsuyrSVrXAs2Pu75cHmxncPD2oXM9ECvuYYl/k3QCfA73WNCu
 vsYQdd9/1pHMPp+QpQJE+VpHwLRFdRHDO8AyL7IZD6iI/3jU1DeFPDNOSehDX7utngMe
 G2e3cpk7wwZSyrikaI0M7E3EMUOldFMdJySm/ywZaW2liWaY+qIERmVWYUp/U9EgD77I
 yr8t60ehosxjFrOf/i9TlUGfCWT6TqXYcBHC4GOdEugqdoldV6bXRpcJ4sn6is6lBDP4
 EJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WfwmneNpdYSmSj1xK8RigfohyWd4Vq0IkEKZeWpChiA=;
 b=cEhcWy+QtcWG3CHaY9vF/Ne29GO/VLF0FZp8m5Y+C4Q6opeCKpUv2Pl/cvH66jIWuC
 5qStNbyyWApPhLJRfXblWkUL3DKFGxLLjgLmWX9IsOuNP6XFSR297Xfq0gK5JD5CTTIm
 UVsp+slC8R/YWFWMqeTtJrQdyhoSaQh8QKHNx+oU4ZupkQSpbkedLUrYlCwJEQRkJ+M8
 qKxvyoa3W1L1pG5P+eSKPAJBOtw595ZqHscCVItgXekteDiQKfRoiyuNkK6X+lCJtFhy
 GpaueLhxZUO8Suw/OvZtjx4mpwhk1+YfuPbR7TcL05B7LGfX5pUCZW87MS9yXRGDEbO8
 LOpg==
X-Gm-Message-State: APjAAAUKwYEqJ+/q241yXrpww0kgNVMSUNGRQd7t4vG/aegwcGtldCKt
 kAhKFUrPyW4foE7WPDHESx4GLZTSXHkrKl4vXsyYXg==
X-Google-Smtp-Source: APXvYqzh53XaAEzBgN51bBS98U6s4sN8/riCNUXSl57Ynv/KffBkxTCkwSI7uOiBbnnvSKBr9fTSs/Fx48WMu/AwBjI=
X-Received: by 2002:a9d:4d81:: with SMTP id u1mr31804154otk.221.1564391655439; 
 Mon, 29 Jul 2019 02:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190726173502.17172-1-laurent@vivier.eu>
In-Reply-To: <20190726173502.17172-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2019 10:14:04 +0100
Message-ID: <CAFEAcA8ZGA2LOixnBy31LUick1xu0=weaHwqfk0oHx2UXipxag@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::335
Subject: Re: [Qemu-devel] [PULL 0/1] Linux user for 4.1 patches
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jul 2019 at 18:35, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit fff3159900d2b95613a9cb75fc3703e67a674729:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190726' into staging (2019-07-26 16:23:07 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-4.1-pull-request
>
> for you to fetch changes up to 5bfce0b74fbd5d53089bb866919d685c47edad9e:
>
>   linux-user: Make sigaltstack stacks per-thread (2019-07-26 19:24:33 +0200)
>
> ----------------------------------------------------------------
> Fix multi-threaded go runtime crash
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

