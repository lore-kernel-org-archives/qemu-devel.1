Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEBBC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 10:50:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A86F20575
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 10:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pImwibdb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A86F20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZBRe-0003bb-FX
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 06:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZBQa-0002rS-5g
 for qemu-devel@nongnu.org; Thu, 14 May 2020 06:49:24 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:35647)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZBQY-0006q7-Fz
 for qemu-devel@nongnu.org; Thu, 14 May 2020 06:49:23 -0400
Received: by mail-ot1-x32e.google.com with SMTP id k110so1982972otc.2
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 03:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GV5lqhAY+tBv4jATCiY79ElnboAEtYYM4byhYtPi2e4=;
 b=pImwibdbVFvkvrscK5VHHZl/uw8zqdmDVkM0sil9jXyWkkyBXoMyFu1UAueF2iqZl2
 ptBHahtftxSwm851H8xSG92CstcTMKz7v/P8NEFAxvpcErjZs3QbxEzQE0Kke+itQ1pQ
 lL83Vp6aag+CGvG0hB+czZhjeohw+62TIs07m3IHOnr8LF3si0/phS6Clwsnj1O4BpbY
 B7CoTi0YxapXoCZTjKL5VXHtrRbmJQ7+ZE0ybAm5dCWgyBPOZpXQWzsvelHSRW1BUleY
 0H/99EA7HYcvNO/XvK6oMi8+FQp1PV6Gmeatz+NzDvMs3k29hCjQAmUq7OqfuvDI11bJ
 vtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GV5lqhAY+tBv4jATCiY79ElnboAEtYYM4byhYtPi2e4=;
 b=bIi3DmKY70Ay+E1H2Xx7V2dXCcBFyRlsd9c+9OuoRxvfmI3a/cyzxPqjUu4R1PRHyF
 D4zobawSvZp3L+bSWETC1+/Tv2UpS2fyYm1WEWbwVLbiEuib3WT8wmPVe+UbsZ5sQEyE
 d9XMHR1XbasGDtnUJSmz7qwBQhvXesJHZnPKN5EnGpbblrPu3ZJx+CVcQxM97GmHTHuy
 DtI8TgY7TQZbQhShMy8RqXa0VkF6j5u6PFW98PBNtjaml7eTBDvcmnBO5Kj0qDfzUkfq
 UTvjbLNgiwhrPY7GePdBuwI0+wUyEwRy2oVUu0P3H6+ftZPOHPTQD3Xa6a6wKXX+Sjb/
 8tbg==
X-Gm-Message-State: AOAM530FcmJSl1xsjz+0dyql0iU7X0zcDJrOIicq++I39fqqZNGx1U93
 2HoprHpF8OHNu3/qmuhJwQ3e7sEChQAtLqTO2u0VjQ==
X-Google-Smtp-Source: ABdhPJx0nEcPZdaCthimDmhJ0jfBQnrWj6hBzuDQE2iClt88o+YLen2hrkfam8O4AHswqmYqMMkUFBakYvaCvgDFojg=
X-Received: by 2002:a05:6830:1e4e:: with SMTP id
 e14mr2942220otj.91.1589453361169; 
 Thu, 14 May 2020 03:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200514090511.256550-1-groug@kaod.org>
In-Reply-To: <20200514090511.256550-1-groug@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 May 2020 11:49:10 +0100
Message-ID: <CAFEAcA9-9Q9hh-6gx5uU7yDrniuB3__fKU4SLFi4SW5SQVyi+A@mail.gmail.com>
Subject: Re: [PULL 0/4] 9p patches 2020-05-14
To: Greg Kurz <groug@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 14 May 2020 at 10:05, Greg Kurz <groug@kaod.org> wrote:
>
> The following changes since commit d5c75ec500d96f1d93447f990cd5a4ef5ba27fae:
>
>   Merge remote-tracking branch 'remotes/stefanberger/tags/pull-tpm-2020-05-08-1' into staging (2020-05-12 17:00:10 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/gkurz/qemu.git tags/9p-next-2020-05-14
>
> for you to fetch changes up to 9bbb7e0fe081efff2e41f8517c256b72a284fe9b:
>
>   xen-9pfs: Fix log messages of reply errors (2020-05-14 08:06:43 +0200)
>
> ----------------------------------------------------------------
> Changes:
> - Christian Schoenebeck is now co-maintainer for 9pfs
> - relax checks for O_NOATIME
> - minor documentation updates


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

