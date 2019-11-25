Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60D4C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:07:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B237D20740
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qaKEyrfZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B237D20740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZFxL-0001Ac-FH
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 10:07:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57335)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iZFw2-0000Zb-3H
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:05:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iZFw0-0004Fj-RN
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:05:53 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:46098)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iZFw0-0004En-J9
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:05:52 -0500
Received: by mail-oi1-x244.google.com with SMTP id n14so13319093oie.13
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 07:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8ASZVIXhIX0S0niEANhlr1mzqMC4z8i9B45QfiKZXfE=;
 b=qaKEyrfZ10IHKLNOzj7VT+EHAquOiVLmj+MQlQnlBmTf306zaaqXXOw4UTeQm2x507
 PuoWnUN2ByOHbwRwABnGmZpeFcoeMKViVPyWlsSoaayBiLCgn2GqDi8HzfXNxT/w8epo
 XAlRdsznbtY2drh8mHRR0zhiHYHp3ExFgq6X3icdtH5JGc9T0pRw/f8PRUyBzei+hEak
 l159zvVgpm9KRbUYEUT0OMME/Kby/2/DHG6VxMEuIWnCl6rkPSusDOLFqNqRukWDk33g
 OoYRBxnmYXRBMatiZ92bsrkxUNHedQIEQabUJDvl/kg4MqnMEYbIlDMAFTl9M5CkBpmL
 pBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8ASZVIXhIX0S0niEANhlr1mzqMC4z8i9B45QfiKZXfE=;
 b=JMq3OPahEuQzlMdlZ0ohkKTVCihCrfF8o6l+dA7pKrueZbGP0YR/iH6ZHI3ougSGNo
 wkTV1lkE4eEPwebAHiYH0jQr3JrLkrqBKjcUu4DgOuPgbRUuvZNW5UdXWIrUqOHQahb6
 5lA1f+Mzq2/dc6apMx4Eqb3RYftRAqYzCYsYHaQLRmWr/zYz8Hqd4xR1wJkY1vnu4fHC
 sLIQFrjGNF2OH/dHN8eWf1/w1wda1EvTg/IFKdv9+3DxXC3KICpyH2xZ93+89bQrc4uu
 PUwbWTPAsht7puoRHcVFXNfS19aJnlOnnC6XTQ5FmaItMD7Skn/jB+8qIW8E6p0ZI26U
 GMFQ==
X-Gm-Message-State: APjAAAX2suTJ2zGjp3VgpQmYZmxDpglMK9LU9WzWdSouOIRgBSyehwTM
 9ZqhEV8up6xETHHQpT5ZQ/7W5I0nGDpUnF0ou7YCgR5orOs=
X-Google-Smtp-Source: APXvYqwo/z2Y7WuRNXp3nFtyFmOzHGlWECXdNqiou/ofihtZUjVYIs1oTZVjh4esEva+79fGlFvCmLGAzr56YfPcWqk=
X-Received: by 2002:aca:cf12:: with SMTP id f18mr22103437oig.48.1574694351390; 
 Mon, 25 Nov 2019 07:05:51 -0800 (PST)
MIME-Version: 1.0
References: <20191123165915.1077842-1-groug@kaod.org>
In-Reply-To: <20191123165915.1077842-1-groug@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Nov 2019 15:05:40 +0000
Message-ID: <CAFEAcA_LO8oVDuUFvKCRC=M8CGW+zkPiR9hYaAiA43-NdSF9JA@mail.gmail.com>
Subject: Re: [PULL 0/1] 9p fixes for QEMU 4.2-rc3
To: Greg Kurz <groug@kaod.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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

On Sat, 23 Nov 2019 at 16:59, Greg Kurz <groug@kaod.org> wrote:
>
> The following changes since commit 2061735ff09f9d5e67c501a96227b470e7de69b1:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2019-11-21 17:18:40 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/gkurz/qemu.git tags/9p-fix-2019-11-23
>
> for you to fetch changes up to 68d654daee4364a0eca589a547d716084d9cb33d:
>
>   9pfs: Fix divide by zero bug (2019-11-23 15:51:48 +0100)
>
> ----------------------------------------------------------------
> 9pfs fixes for QEMU 4.2
>
> This fixes a potential QEMU crash if the underlying filesystem returns
> a null block size in statfs().
>
> ----------------------------------------------------------------
> Dan Schatzberg (1):
>       9pfs: Fix divide by zero bug
>
>  hw/9pfs/9p.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> --
> 2.21.0


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

