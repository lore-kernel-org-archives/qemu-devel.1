Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374B3C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 11:42:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0090D20748
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 11:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mk0pDbbP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0090D20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtrQ1-000287-9W
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 07:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtrOs-0000qo-9S
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 07:41:06 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:42697)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtrOq-00050f-EW
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 07:41:05 -0400
Received: by mail-oi1-x241.google.com with SMTP id t4so4522522oij.9
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 04:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3T0hDFoXjZct1MYRBjV/af4+8ajm7JL9IUxKymfkXO4=;
 b=mk0pDbbP1gK483+10xs2EISdX6Ll1IgLvpDK3AtvDo6mdEcVn+Gv6XeO8QYdjIY/AI
 uVkFee1ZkTPjbLeqy6VfZMfdLX08qcIF5rV8wNhT9Kd/xHH9OFu7UYaGaE5E1sauArN8
 R1ftfSBHL0wuPlnPJdb//T2/pos6Brr/r6p/BTR8cDfWynGXKtc01lQAyyM1+a1IaMfH
 sYdi3HCu40G28PzJ6A3wn4TYcXiZjmuZuFwjnuNAIrFq5f+YsxqU14mpzRdgxNZsepTG
 bkEJSWoPtndEU1gdrbkS2SdPxcZ8EgZ2xI+eCtwoWgyXd5a75bJDN+JIcV+ybcPZDWHE
 e9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3T0hDFoXjZct1MYRBjV/af4+8ajm7JL9IUxKymfkXO4=;
 b=WcsS4/feIxVcTF+T4DtZZJcXo2D92Wr8pOX+3I4nCHNBUydrubML3R9mwBjUYpKvD+
 n2y0jFepI7iiu1igv1UYKrT6zrWkQhYL/9PJu8oFwmmzCr9O+zg+6vc4qVSPYkEHrEW2
 OsN373Ob8T8z8+tnr9mTP5vVkzf/ypcVVlIz+kZ2006PYdi6s8qmK1UqVbHER73VTgX/
 YUiiqDIUcnRzPtClBrJikrMKwip2VajRHpTZTtVH4jItj2K7lnb3QJOip1VmjcT3iZxj
 8YALzc9+YOCYo0O4KRNXO7l0zX8QNN0zyXGHbk3fcusvZhGHsbtQmBQCFulp0qtPlLCo
 vE3g==
X-Gm-Message-State: AOAM531wILkExV6gZjXPahfvTV3fG66tX67eEpll+Jut1HFfOkbG/Yqy
 Ei5x1Vdx9yq3fDnR5g45djopspDEy/OJ+1C9PIkURw==
X-Google-Smtp-Source: ABdhPJyZNvyqkIO6xdlpBymzIUd154W6oqkGslIT+zEfiGkBTIW+n1MAMYSoGWP/UQpH1yf4I5r35/uNykpLY6xlifg=
X-Received: by 2002:aca:1706:: with SMTP id j6mr3690942oii.146.1594381262241; 
 Fri, 10 Jul 2020 04:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200709160439.15088-1-thuth@redhat.com>
 <20200710125552.1ad24571.cohuck@redhat.com>
In-Reply-To: <20200710125552.1ad24571.cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2020 12:40:51 +0100
Message-ID: <CAFEAcA-+OTjANDWSBrsK4J6M=VCu9gPAjFuxfUo88-kk3O4O9Q@mail.gmail.com>
Subject: Re: [PATCH] docs/system/s390x: Improve the 3270 documentation
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Jul 2020 at 11:56, Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Thu,  9 Jul 2020 18:04:39 +0200
> Thomas Huth <thuth@redhat.com> wrote:
>
> > There is some additional information about the 3270 support in our
> > Wiki at https://wiki.qemu.org/Features/3270 - so let's include this
> > information into the main documentation now to have one single
> > source of information (the Wiki page could later be removed).
>
> No objection; but what should our general policy with regard to wiki
> pages vs. documentation be? The 3270 support is pretty much static, but
> e.g. for vfio-ccw, we use the wiki page as a place where we track
> things that should be worked on etc.

I think that (apart from docs/devel) the ideal would be that a
user should be able to look at the documentation to find what
they need to know and not have to look in the wiki. So "feature X
is unsupported" is useful to have in the documentation; developer
TODO lists, design notes, suggestions for improvements, etc
would be better on the wiki.

> (Related: What is the scope of our QEMU documentation? Is a libvirt XML
> snippet on topic? Kernel configuration options (as in here)?)

If we don't think they're liable to become rapidly out of date,
I guess we might as well err on the side of providing information
that's helpful to users. (I think a full-on "here is a tutorial
and how-to guide on setting up guest OS Foo on this model"
would perhaps be a bit out of place, but there's lots of space
between here and there.)

thanks
-- PMM

