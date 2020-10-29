Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3E6C55179
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:53:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D30FD206E5
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zjHFCTbb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D30FD206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY9Iu-0005YY-L9
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 10:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kY9Hz-00056r-HZ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:52:31 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c]:46572)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kY9Hx-000112-OI
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:52:30 -0400
Received: by mail-ej1-x62c.google.com with SMTP id t25so4146882ejd.13
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 07:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=c0c81XyIvbfbtaVG/V3R6Wg36NdRXlguYGKz+utD0nk=;
 b=zjHFCTbb8x45RhyD46/Fo3J6IOfiOuIiGL4Hi5THAG1bNNh+ZQapHSJiwvnyHnu9Si
 ogZ14v+oKVBictXZdMDv7Adq8WwyqOgoIjOS1KsvsF/LDT5MFgJgMb4NB1t2h/coIjSm
 H01FquqSz8hv4c+/0hU0AyyJxdbA944FPxJC2ave79wC4c5LePAHf2zKCqQ0jCTUTvdM
 EnOXyeO/CLjWmir4MzKTAy/UIZO2cNEPexQ6eqcpT0baJnpL14qQQW6xUFMcaarXeyGo
 45Ph6mxxfetUTOr4elj8N6Dn23wiNC6paKLFg/U0WhwwDnZhpchajpxNYk9LxzEpJBNU
 p4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c0c81XyIvbfbtaVG/V3R6Wg36NdRXlguYGKz+utD0nk=;
 b=atzuQBTk/CXBqaciJeClO6fwBK3MsxwTAUAcxOib15H6VZ01eETjgAR92eyZY0DYZF
 IwxVA9BzvszneCSTODqES/j5zUdgDCdOUqrpLiC0QWmx+7G+TbvkacAF91ZAA5SWgdRI
 LeY2jARH91KMY79ZgR6N7pa6NGLOx3Bo34P0gj6HvBXX5azjVmB7M4mKql0C8yKoawSN
 6sbcgBsadlnb1ebLhzaMwpLdfWux+hgidK56pBYqACwhtoSvK2R9Ou489sqyF9t1F1bF
 P2uSNDeUJKVhvLYlTkGlXVCWVaSuGyW+1sotNXtzoGoT0ao+tIyk/mrIojHYXAzyHq5O
 AW+Q==
X-Gm-Message-State: AOAM532A1/wNHBJfzMOKbf+QyGc8IuvOi0AnPtoS9wbAckfhyF4SgMZn
 pfJg13G7764CMiwp9mIjFUtef3wkN9Dpg+X48KEMlg==
X-Google-Smtp-Source: ABdhPJy8/1wqny8fDcW0tSRtRtitcwSaaJ1Psd/ou4NJY/fnS3WeL7b5ZnotXMFiAiepUxaFy37RTA0/w7NQVNvr5co=
X-Received: by 2002:a17:906:7254:: with SMTP id
 n20mr4207902ejk.382.1603983148126; 
 Thu, 29 Oct 2020 07:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603452058.git.qemu_oss@crudebyte.com>
 <5649161.sut93UlCx4@silver>
 <CAFEAcA-+4Ac7tGyXxDjkPrsJw7NmH3bijkuXLY9gF=Vr7p1LWQ@mail.gmail.com>
 <3209306.Oi7kq7t7ax@silver>
In-Reply-To: <3209306.Oi7kq7t7ax@silver>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Oct 2020 14:52:16 +0000
Message-ID: <CAFEAcA9KYtb7tFp5tnPGMiYg0gpurao7GbcU_ND934tvFiU-aw@mail.gmail.com>
Subject: Re: [PULL 00/13] 9p queue 2020-10-23
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62c.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 29 Oct 2020 at 14:31, Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
>
> On Donnerstag, 29. Oktober 2020 15:15:19 CET Peter Maydell wrote:
> > On Thu, 29 Oct 2020 at 14:06, Christian Schoenebeck
> >
> > <qemu_oss@crudebyte.com> wrote:
> > > Ok, I'll use mkdtemp() instead, that avoids other potential parallel
> > > config
> > > colissions that I may not have considered yet.
> > >
> > > The original motivation against mkdtemp() was that /tmp is isually a
> > > ramfs,
> > > hence very limited regarding large file tests. But that's not an issue
> > > right now.
> >
> > How large is "large" here ?

> E.g. ~10 GiB which might be a problem for cloud based CI platforms.

Yeah, 10GB is too big by an order of magnitude for anything in the
standard "make check" set. It could go in an optional "I'm the 9p
maintainer and I want to run a wider set of tests" target though.

thanks
-- PMM

