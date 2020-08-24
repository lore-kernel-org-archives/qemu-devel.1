Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C40C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 15:02:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 791A2206B5
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 15:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XsCySBue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 791A2206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kADzd-00077J-NJ
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 11:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kADyO-000617-RU
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 11:01:24 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:33009)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kADyN-0008Cc-Am
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 11:01:24 -0400
Received: by mail-ej1-x642.google.com with SMTP id u21so11661548ejz.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 08:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5QQZFfKmiN4x/jvCiWb3vKnwE+Dwwj/ayaYHLvhSp2M=;
 b=XsCySBueoXC1+4WtqMIxuoGYkAxZuj6zayjJ3AbVLvqp2ejEF7cAdvxOjYzgsUyJri
 KraneBi/vnKNvINB45o6BnKZBXa5AT9eh40/5otVbDKd9nn5HfwLZCsZVyCM8zkjBTj3
 Xq/cOErKovXIm6KNLRdB69spHJmaGPXfXUYWUuw/Y8N53j2YDLsehHRaVnxY4fo8zxo4
 lW0S3GIKtpHnuF0p79I8v5Fz5O3OrBihZkwychKLx1POulC7M9CCENG3FBxqTMz57Y6P
 AwSbb6hH/0eLrjTThhPwSGrWVrGFBKyBR9JfrIHijN3YrUm+nDgXcw6HKDAwnEd/phB6
 DR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5QQZFfKmiN4x/jvCiWb3vKnwE+Dwwj/ayaYHLvhSp2M=;
 b=bImKEjCXMvMNGiSI7hKcB6OKjmVx//O1DkRzAzJID8yuEdkLfRRaTzigWUF2Q0/9Nx
 qXMCUwYbMT8kHIKkvRAeQjQGD5Wvx/zNPa1jsq8GS3ovzcaCWo01liy5p0j3Yd83GluX
 7ILYwOnbIuqtJKvO+NdinPmLuFFR32FFyKhodFqIMay4eIyuyKeBJoIk89bzyPjc9Ipu
 O/tujTGySHACpdL6XUGgG+uzPS9adp5lzG/LiJkTbpYvqC7mlnfUBAWSWquAwOudTXRw
 av/HzDW6FQiWPut5i3WvRN1AQ77g7Ayx8gsfXnfcYcbjxkzT3Ko1UtwmDoZZqz5Vjv+s
 KiFQ==
X-Gm-Message-State: AOAM531prhWdCWaPfZxhR9vkDdt2eL64pZyLlGbEWjPkc4DE38HCq+5c
 WKYfWaWZkkTG+Ng9m9Au7lNDz+VcQRP46g0MrlEBDA==
X-Google-Smtp-Source: ABdhPJxcDjtDEzYUye6x3Dmzg9ujqCZ3q1JWqsI1T/KJO2NJFYT7C0yQKEAOoevS9VYORj54vtxQ75ponhqtDc2LUgA=
X-Received: by 2002:a17:906:59b:: with SMTP id 27mr6296618ejn.56.1598281280785; 
 Mon, 24 Aug 2020 08:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200812190206.31595-1-f4bug@amsat.org>
 <1ccf070b-7abd-ebfd-2788-92a81b4fc8fe@amsat.org>
In-Reply-To: <1ccf070b-7abd-ebfd-2788-92a81b4fc8fe@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2020 16:01:09 +0100
Message-ID: <CAFEAcA-nLLM3dqC=71JSfu9+8=xsnpfavD0Wk4Lkuf+EOytgQA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] hw/misc/unimp: Improve how offset/value are
 displayed
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 22 Aug 2020 at 21:02, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> On 8/12/20 9:02 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > This series aims to ease looking at the '-d unimp' output reported
> > by the UnimplementedDevice.
> >
> > - read/write accesses are now aligned
> > - the value format width uses the access size
> > - the offset (address) uses the size of the memory region it belongs
> >
> > Series fully reviewed.
>
> ping?

What tree were you expecting these to go in via? Probably worth
being specific about who you're pinging in this kind of case ;-)

-- PMM

