Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37533C4BA2D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 23:40:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01D4620658
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 23:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CGFSDCix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01D4620658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j76IE-0007GL-56
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 18:40:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57665)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jimw@sifive.com>) id 1j76Hd-0006j8-K0
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 18:40:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jimw@sifive.com>) id 1j76Hc-0007RK-JQ
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 18:40:05 -0500
Received: from mail-ua1-x944.google.com ([2607:f8b0:4864:20::944]:34642)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jimw@sifive.com>) id 1j76Hc-0007QA-Dq
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 18:40:04 -0500
Received: by mail-ua1-x944.google.com with SMTP id 1so305177uao.1
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 15:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JdiuV+GdGRCh1n9HezlTnphdYqvFzAF4vxfm9QBJHCo=;
 b=CGFSDCixgsNUv9iogiYVPW8enlLNSYoRLIgtGQBSi5HDygtN/LtrYZB3q9KR1FId6X
 zrd3CwXAYmOoHg2P5OkN1rvWSthxP267KO4L9CmbQU3DVHwun2VYhjfHp0KG54OdXaAe
 EDS7EezVpq9Sm1/yvwuoZi9jyX8icIbpVQPQD2WnuobqcK6WamR4wwFt38LPCY6DE/9a
 tiYKGCeMPRqi6l0PxFOoP5jCGXGUGjaKMSRN5pS1RTQHVfACuluBZ7dWZOOExs723jPF
 2RJ5Lsb0wmJTOgHtubXwsfPH95YBwBfFXeHNK/xLg8iC0bgMGmebxYlCUIjSxlSivdQk
 sc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JdiuV+GdGRCh1n9HezlTnphdYqvFzAF4vxfm9QBJHCo=;
 b=CXXI7W59xHGpeGmffBpeGLGmcND67u7nuSGThL+6CRNEBA54zJ/Ak22oEaTXzc1ZL6
 WXQZClJi8gUmGl97CVCGvZOA4j0S2XTf/zSNGduNNZJgYDKK14PVP1WK6QMO+/qWw/X+
 v8GBMXjO2NhTFfdxeI5k+U6eDwyR8HAhgVWK5Be3fdgbp0Jq/SKkGbf5asJ09Ye6qimh
 liwVzDK5JATb/UmIAaHaDDZNZOgbDBs4IyYHmeKuE80JnxzQcqxelzm9NL1mL7n7GdRl
 76pHCovupfLt+F89g/YYEwWY0aoCSux0zM74GFIiPkjQlU5zy7hHBJf/YKSPCygyZdIV
 wGVg==
X-Gm-Message-State: APjAAAWF1ZXzL5xFjeESwK99ElqJqM7ZDk0xq1PrtQJ39mLwPZe1HMaI
 JYTeQQjMOk2+IHHsbLPjNThXmkM9aZNgeF5KC35kCA==
X-Google-Smtp-Source: APXvYqxT2YVADip6SD/ekxXKaVKMWt1dNY9HQCfnOMxpIQgfyQUNK+96L8idN3KwZF0BnC6wtihFOlLPBsIyWv+kMiI=
X-Received: by 2002:ab0:2302:: with SMTP id a2mr1047878uao.21.1582760403728;
 Wed, 26 Feb 2020 15:40:03 -0800 (PST)
MIME-Version: 1.0
References: <20200221094531.61894-1-zhiwei_liu@c-sky.com>
 <ac290e38-bb39-6551-0758-95d087fa568c@sifive.com>
 <CAKmqyKOedrW3HZFfep4ErJ8H86V=KXeBL8LN2Cy_+669a6c9gQ@mail.gmail.com>
In-Reply-To: <CAKmqyKOedrW3HZFfep4ErJ8H86V=KXeBL8LN2Cy_+669a6c9gQ@mail.gmail.com>
From: Jim Wilson <jimw@sifive.com>
Date: Wed, 26 Feb 2020 15:39:52 -0800
Message-ID: <CAFyWVabLp78M2RGe0TDF5TyW4sJpa6Rm0sJLnc3-CPv8pW+TzA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] target-riscv: support vector extension part 1
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::944
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wxy194768@alibaba-inc.com, Chih-Min Chao <chihmin.chao@sifive.com>,
 wenmeng_zhang@c-sky.com, Palmer Dabbelt <palmer@dabbelt.com>,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 26, 2020 at 2:36 PM Alistair Francis <alistair23@gmail.com> wrote:
> On Wed, Feb 26, 2020 at 12:09 PM Jim Wilson <jimw@sifive.com> wrote:
> > If this rvv 0.7.1 implementation is considered a temporary solution,
> > maybe we can just remove all of this work when the official rvv spec if
> > available?  But presumably it is better if we can have both this
>
> That is generally the plan. When the final spec comes out this will be
> updated and we will only support that.

This solves my problem, but maybe creates one for Alibaba.  They have
apparently fabbed a chip using the 0.7.1 draft of the vector spec
proposal.  So for qemu to properly support their asic, the 0.7.1 draft
support will have to be retained.  But I think SiFive and everyone
else is waiting for the official spec before building asics with
vector support.  If Alibaba will update their processor as the spec
evolves, then maybe this isn't a problem for them.

Jim

