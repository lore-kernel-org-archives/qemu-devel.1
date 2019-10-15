Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3241ECE588
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 11:03:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C9E32086A
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 11:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N1cUEP9p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C9E32086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKKba-00084T-Mn
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 07:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iKKZ3-0006Z3-QW
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 07:00:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iKKZ2-0001sl-Lq
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 07:00:29 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:36069)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iKKZ2-0001sG-FS
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 07:00:28 -0400
Received: by mail-oi1-x232.google.com with SMTP id k20so16400365oih.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 04:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1l25ZRTMtzF0RnF2kNRiBZ+skS+nPGhkOu1fQcaoNVM=;
 b=N1cUEP9pUuy0/zyetK8/O6lMN/+Ah/T33de9shMBY0fX168FfQw/Ohk8zcgvbcmT75
 vprc6SiiFmrCTZ9q0LtMQUQ4w+K5Fvv13AAbvseqBaSmqotWrG94klT8zm4A7/5A2q69
 pxC3nOTw2F0yvlnImoIe5//rXJWnF3VhDGINQNJLR7nf/3W7ZV8VPU2ffVnnOFLWozLW
 lpIAWIjq/Sw+wKfwWfeZh86+/RKnnTXdXvlwBM5SHgKst/I6mDyfD0PFJcVZ+OQhsnV0
 5CdiofzsuEpfdvb5qf7Qm3YpB/GHfoteLnrItJiWbNWLgCMQUBZ4/v4w1fPYq+Hkjjei
 y76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1l25ZRTMtzF0RnF2kNRiBZ+skS+nPGhkOu1fQcaoNVM=;
 b=K3h0hnXWyyif0mZe7n6GsvSEK0Q6LIRWXYU2A486um8vzb6D4at1ygguypXS5bw4Y9
 MC4X9Hr8JS+YvQF6UdfRBFgBSmN7fSE1lZ8bijBJUb1JVwGsjxEsphtsBslt6mMNHO4k
 oQGBfpXaqWGHRKMSaXAshHUjqTE1MX5r5XU+Fa8xdye6AvJjkioEfEmPQfAuMv3L1NT9
 Q4vOlcO/a4hV6YSrC94rx7Hm6/UEnLsOOetnKYtDRaYLkVEyvYTk3dzk9xkhubCjAEvU
 pGRrf6AdYhspBTgyqbA8amV//zl8y645kCqCt5TKGatYTgfhvFRG7K0Ciwi3gNUYStwk
 70vQ==
X-Gm-Message-State: APjAAAXxDCE5ayzpMk3aFmupfT8nlzvfJohuDI/i4tRJBYSibcOoRJck
 LbO2WzAyZj1LQVogurVGH4CkDPkFGDdDkHtPwtRryA==
X-Google-Smtp-Source: APXvYqycOjPiuT7ZNopWaTjMR+I3qNjIX8jlep7LnVGOmQ+UvZIDf8AFb68mJZMF2j4dVN3V2rXUEhHv9RR7LAeNQpk=
X-Received: by 2002:aca:2b08:: with SMTP id i8mr26910196oik.146.1571137227210; 
 Tue, 15 Oct 2019 04:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <20191014085211.25800-1-stefanha@redhat.com>
In-Reply-To: <20191014085211.25800-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Oct 2019 12:00:15 +0100
Message-ID: <CAFEAcA-fyftWrXRetNjBHB16+QLdJh0HXmEipkfixxZa+MCQzA@mail.gmail.com>
Subject: Re: [PULL 0/1] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::232
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 14 Oct 2019 at 09:52, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 98b2e3c9ab3abfe476a2b02f8f51813edb90e72d:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-10-08 16:08:35 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 69de48445a0d6169f1e2a6c5bfab994e1c810e33:
>
>   test-bdrv-drain: fix iothread_join() hang (2019-10-14 09:48:01 +0100)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------
>
> Stefan Hajnoczi (1):
>   test-bdrv-drain: fix iothread_join() hang
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

