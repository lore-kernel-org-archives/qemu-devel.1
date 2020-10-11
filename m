Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E77C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 18:35:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E314D2078B
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 18:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EJWDOjZ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E314D2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRgC6-0001of-4W
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 14:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRg9h-0007hL-5I
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 14:33:14 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535]:46936)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRg9f-00005M-01
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 14:33:12 -0400
Received: by mail-ed1-x535.google.com with SMTP id 33so14574536edq.13
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2020 11:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Tpi+7dRKkWT1yjfojDlWe/S7y3xFeQxX1gyb8bS9NBY=;
 b=EJWDOjZ9WHrrBBBykB/8XRH6ga8W8SOx+mCP+ASLsnYmnuqnKyye5y/iNzrKUacThi
 mADGJF8fIMEU5o6SzDwnAFZ3i1OIhEN135ZKZq9CD2zaVsCbuunFiuTpPmO3zzbC57P1
 boQKq7l1sd9fKzrJWMLJm+ZJ5FmMua7rmcwszxS9L2JsfSdSony6gZSLyB85wEeK/VbS
 CG4YYGqt9LDFXS761MHk86QxIe//wh7Nq+aLs3Ir1HtIB7HGII0zrtrweJSCfndFPuTN
 XyYqcHNj0MfaRHtRyYhqoE55L4DtBFBBjiUVGHLkOuxHZ6LJbr5teqb+2WiF2GHOwUFW
 KflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Tpi+7dRKkWT1yjfojDlWe/S7y3xFeQxX1gyb8bS9NBY=;
 b=iPHlEENVIFTtvDethR6sClAaUZycgbq7rG+/8frQ8QojAzJ63MU8F8ZGi3msnSNZcO
 edLH+762Hf9qRguilcz4fX9HKenw8hPw8/3faXDUbVhgKS/rPvolUVqV1DmUIVhk/VYE
 jUT3S4/zYyPZ+/ut5D2nTaElIA/9eSyGDGkoPg6NKE3k95USmIxdUgAExbq7JHsL473q
 ld0J8wEDe2GidBADMRLYOY6qIf85+FnHqJR4yg+H//BPgEg0toX1dkW3ltWpei35lEkG
 GkH+KdnP4g860VA2kcN+rPp++Dblq8djI7A7nlSZmZVsgG9SeNOyXuWB+WsKObnvZE5W
 pIfw==
X-Gm-Message-State: AOAM530IVeMO35z7ANrXNvBVr/RmaKLIb0Ghqoc3SaxF9YE20XYmwPUr
 TqxXUTjecPNY9iO9iWsczQdenGWWioSz+ec1NOTBdw==
X-Google-Smtp-Source: ABdhPJwjjEhUh75P7UAFOajhept+nwj8k8faWkhMv05KDKfoLrVTS4U4Bvk2pUwJKY+PMX8J4uHCTMCM11fVk+xCm10=
X-Received: by 2002:aa7:c683:: with SMTP id n3mr10116565edq.146.1602441189317; 
 Sun, 11 Oct 2020 11:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201009193529.322822-1-stefanha@redhat.com>
In-Reply-To: <20201009193529.322822-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 11 Oct 2020 19:32:58 +0100
Message-ID: <CAFEAcA98=xnV0H_RmFqbfCONiOGC070M0-JjvmR_5drtpd1=xQ@mail.gmail.com>
Subject: Re: [PULL 00/30] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Coiby Xu <Coiby.Xu@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 9 Oct 2020 at 20:35, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 497d415d76b9f59fcae27f22df1ca2c3fa4df6=
4e:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-202=
01008-1' into staging (2020-10-08 21:41:20 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to e969c7b045c90368bc3a5db3479e70b6f0ecb828:
>
>   iotests: add commit top->base cases to 274 (2020-10-09 14:32:24 +0100)
>
> ----------------------------------------------------------------
> Pull request
>
> This pull request includes the vhost-user-blk server by Coiby Xu, the blo=
ck
> coroutine code generator by Vladimir Sementsov-Ogievskiy, nvme block driv=
er
> statistics by Philippe Mathieu-Daud=C3=A9, and cleanups/fixes/additions t=
o the
> vhost-user-blk server by me.
>

Hi; this seems to have a conflict in qemu-nbd.c with something
that landed in the latest nbd pullreq. Could you fix up and
resend, please?

thanks
-- PMM

