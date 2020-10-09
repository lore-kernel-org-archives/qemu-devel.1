Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEB8C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 13:50:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D607222BA
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 13:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dgMez5Yo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D607222BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQsmU-00012k-8S
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 09:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQskV-0008ON-W0
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 09:47:57 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530]:38116)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQskS-0001f7-BK
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 09:47:55 -0400
Received: by mail-ed1-x530.google.com with SMTP id i5so9415498edr.5
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 06:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=duWop+e731ht/Xspc/oaKxTuhDscVIFeOyQZBik6qDA=;
 b=dgMez5YoNbJV92eEH89GFDIO0zVsRe28Dz3HExYPllPYPx96K8IubCSAnnfdZbb4sV
 mkWRfyCcj0x40CD9UBNv2/+uKKPxEUQtV+U7U0QBHgFTHm2utJRlCtpEmhW1RK9/dI4A
 cVumoNxvHzCIBEp5KzE03MLRMGJo4NRbMnEcNBLxIzLkm+3TwUYFbAQOKQQvg9Z05PIO
 aEba8ErLAwYHdzQsSs91LRKrFHSPdw0U1p/pP2BwI1d8KkOiY36bdnhBagSMMGqqwSIL
 HnsN+sGQ7qVC9dk4I4xqm879QgYEVw0IUmXgFPHYQO+e1o8xiFeGM+Q3K8rb2Pa+DdrZ
 YGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=duWop+e731ht/Xspc/oaKxTuhDscVIFeOyQZBik6qDA=;
 b=Yj6raGoxQwHjN4QvT454k9a4r/Heq6E1hhGevK2Qrn5ioTLuQEyuN9iX1hHBdqiq09
 LQBF8uZ9GnG/O1vksjIjx+M00Nw2adV4RqzNYjmjbb5M2d+uhMm5FH9nZ6QuASlSM8hv
 b6k65j7TVoz7pHAZhfVLtvyoyYhk8pCgupBCDB7OFsQ9RQ+LdcHTzRXwL7f3YQHVStPR
 1sXWeVQZN8N2H6K0RJrJ4yb5hbmzG4ER1HwUB0BhK6vFtHtZX2dIj7t6gmfODsDFOiDu
 pj3F9ZVpAvKI92cOKNaNaGKnzReBwc6pplh4KckloAdpm9k/u4SVhqLOrRFi/5mqEGB9
 VNKw==
X-Gm-Message-State: AOAM532lfKRQ/+fvC1oDBqkh2pVbbYYhsmbx+2MH3OebOPWbtfOiVTCY
 Cyn8SbcnSP5H3dKK+511jek6eoRWGnGLI1Nzgqh/VA==
X-Google-Smtp-Source: ABdhPJwvVcXL21uAdiFmyR7xvXky39Rg5LqmW+RjAY8/Heu5FRE3VD3otJOquF2Hlxq8Tk5gsqskI7B8q+dj1mTlaDw=
X-Received: by 2002:a50:c34a:: with SMTP id q10mr15159710edb.36.1602251265854; 
 Fri, 09 Oct 2020 06:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <20201009063432.303441-1-armbru@redhat.com>
In-Reply-To: <20201009063432.303441-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Oct 2020 14:47:34 +0100
Message-ID: <CAFEAcA8=CmXq4hOy8M16mj+UyszXFE2kxC=C06DTMp_O_7MoTw@mail.gmail.com>
Subject: Re: [PULL 00/14] Monitor patches for 2020-10-09
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 9 Oct 2020 at 07:37, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit 497d415d76b9f59fcae27f22df1ca2c3fa4df64e:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20201008-1' into staging (2020-10-08 21:41:20 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-monitor-2020-10-09
>
> for you to fetch changes up to eb94b81a94bce112e6b206df846c1551aaf6cab6:
>
>   block: Convert 'block_resize' to coroutine (2020-10-09 07:08:20 +0200)
>
> ----------------------------------------------------------------
> Monitor patches for 2020-10-09
>
> * QMP command block-resize and HMP command block_resize no longer
>   block the main loop.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

