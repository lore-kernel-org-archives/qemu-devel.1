Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC25CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 15:34:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A86462089C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 15:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kq9cyCdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A86462089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMZht-0004S7-JK
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 11:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMZcw-0000aP-06
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:29:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMZcu-0000FJ-64
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:29:45 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43474)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMZct-0000FC-Ox
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:29:44 -0400
Received: by mail-oi1-x244.google.com with SMTP id t84so11357425oih.10
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 08:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5L9UxbereI2RbBa2nE37Ox54yIUtB/+BI3Op+ShCjbc=;
 b=kq9cyCdXnRfGEPZq9bTi/sKzPIoeIk/X6acc4GyJB/wYS+FrQDIggMihiFVd+hYwfB
 WId9LW7h/w2mOJfYs08CVmkoWVwY4A1oztaOnQf0ZxGzlyGeNBMgVwRdyFpYy7GmWpjH
 lpzMoCbWOf4KvCmrmtNVp5E10eNPQqZCtTGrGrf1OZCWYXctCfhz9i+bNIDWqj1vfcCX
 A8MEi4e70bZi5OWOpqVf5jEDkJUG3FkOxmHKGlIbJKt5CsSTXcBqDrgyZwt2s3B1Ae35
 CS9+fbj5TeRa73S/9NjcnSTK26hQ3s8W5poc/33gV4oTUHF5bM5SWwxJwMydl+GOmSV2
 JwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5L9UxbereI2RbBa2nE37Ox54yIUtB/+BI3Op+ShCjbc=;
 b=Zl2dYw5HzXEptQwOisvU3y1KI2UsGGE0HLjpefHbNzeaiXpGgYoIqOCq1QR6GRJj1/
 2wQN9qUFlUchdp4rZRDtbDP2qfoWBrtAvFhllsvQsVJihfSuw/dCggnJiZChnK7ho8q5
 3yGHAo6TfdRK3cbr7POuSnXOEscMWR2kCUM7uSdhXgzy5DXnQzhXilFMVr+6vtcZ9IUz
 ba/6cZaB+6Iu59JK/kExY71BiBAfWtKl0ppwxHa8JyVBQoj3kE34QzejZ55j3dqOu9Cq
 zdRZUewWKHLuH33Jj/UW4VmWnrUVeag19qVvqO8+EKBrw6HIMJ0I+Z48VgjkMfoufbVG
 NVlg==
X-Gm-Message-State: APjAAAW+hS02OvPSYMugjJDW+KaIp/FpCf9X4tj6mlnyXBo1Za6edACD
 LdIBOfMx9v97eqN0A7aUnrrN6tEZgjO1GDzsWIxZCQ==
X-Google-Smtp-Source: APXvYqyOQ4m36Nl39Js69p0ZX6EiZkGdXCK7h5XGhpfxk+E33RIn9eyz3sy/7u/ahTfiMfcgiClpgAGiHtS3Yx144iw=
X-Received: by 2002:a54:4e83:: with SMTP id c3mr20010601oiy.170.1571671782916; 
 Mon, 21 Oct 2019 08:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191021145839.12684-1-peter.maydell@linaro.org>
 <1f02b1f0-1e09-9e89-50e4-5201eac00173@redhat.com>
In-Reply-To: <1f02b1f0-1e09-9e89-50e4-5201eac00173@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Oct 2019 16:29:31 +0100
Message-ID: <CAFEAcA-EgmT0_OxqBLaXmDysP_cRZq7EnkW87FkVkPhTj1qtEQ@mail.gmail.com>
Subject: Re: [PATCH] tcg/LICENSE: Remove no-longer-true statement that TCG is
 BSD-licensed
To: Paolo Bonzini <pbonzini@redhat.com>
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Claudio Fontana <claudio.fontana@gmail.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 21 Oct 2019 at 16:19, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 21/10/19 16:58, Peter Maydell wrote:
> > Does having tcg/ be BSD-licensed gain the project anything?
> > From my point of view I don't really see it as a cleanly
> > separable module of code -- it's quite tightly integrated
> > with the rest of QEMU, including code in accel/tcg which
> > is variously GPL or LGPL.
>
> I think the original idea was to reuse it outside QEMU, for example in
> TCC (which is LGPLv2.1+) but that was a while ago.

I just downloaded and had a quick look at TCC and its
current codegen implementation seems to be entirely
unrelated to TCG.

thanks
-- PMM

