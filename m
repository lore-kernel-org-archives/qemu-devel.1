Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9361FC33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 11:40:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E7E020705
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 11:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gNPP107J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E7E020705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixUem-00040U-G6
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 06:40:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44556)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixUeA-0003X8-VZ
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 06:39:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixUe9-0001wT-L6
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 06:39:38 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:33810)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixUe9-0001sA-Eg
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 06:39:37 -0500
Received: by mail-oi1-x234.google.com with SMTP id l136so6955419oig.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 03:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4xTuiqoNw+1zuI46zAKJV8CXfZD36avB25VVgYaA4e8=;
 b=gNPP107JK1QqEaUtuCESfG3mOXQpklvlbp8vTEBjHxaJUpwcQpOcW8a5FcQW1ssT2m
 JwyNbzGztHp0YQKPG2/C9gma5rgYXRv0fhekpg5NRdHgCCbbNSnH6qPQckZgJBQ0M8CG
 Zny7DplWeZszH+NmsyaWqn/9IZI7Zj5q3+dKfXJ/3tZRDnzcE2OMb0rkN+JrjEqVhmub
 STk+JSEUe8Qscv845wviECoOEwGipIs6YE8uCTma8gCZwwWFAYyeooL5K+FIcTVPtmSN
 6PGffULMpXcWFrC+loGuORSP8sYTeRBYYbeuYKiIVjZ3RblGK+47eAP6sp2y85fF66vX
 x9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4xTuiqoNw+1zuI46zAKJV8CXfZD36avB25VVgYaA4e8=;
 b=qNpftfVecX3Jh0//1xnyPwDd0eO1XdoLjtIVQ2aEl1++oweYG3G4vFtkSXA9c3z327
 KkNnGq0Qdn6Frb4tSK+xYgBoFJo3Ny0EUKgn/i7GNe5z8261wYsTDyLPCFoKTze1u+ks
 +agG+/bzqSh7S4GrZdtAYQsQ4T24Dfd6N9dy0TF+YDc6XIWOKxxaB94UU14YZ35KWpek
 3ipVNDRGUK+S62L+fdmqpkQhOjgMuCDG0MTvJNHOwmaX6e9Rmeps1kjSJiqQdcPzBR1A
 YxUGYgGGRKDRqrwFT+lRSGgVh7BDef72za0bG7FlW/+Z3AB4N+osKXiPMH9C234czgpr
 3kRA==
X-Gm-Message-State: APjAAAXod2yFVrK1Xelyi6AVNzOcglTr9g60MHH6UoLKABwQKNgxp6/K
 l0auxzVyj2u9UTedecldPQHm/xNU1BdytSMMeAZqFg==
X-Google-Smtp-Source: APXvYqzjwuylFTtx9IVZUzYDbN9DNXTwCPfsavI+XGheHO4SJ8tF0x5zpb/f3W/tm7kXN2CzGYHGWji5oT/9wXycd1s=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr6028588oid.98.1580470776213;
 Fri, 31 Jan 2020 03:39:36 -0800 (PST)
MIME-Version: 1.0
References: <20200130213114.325157-1-stefanha@redhat.com>
In-Reply-To: <20200130213114.325157-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Jan 2020 11:39:25 +0000
Message-ID: <CAFEAcA9jp26mt2=faegEbcGh2v4aEDqkqW8Oo8Srok84NRkBMw@mail.gmail.com>
Subject: Re: [PULL 00/18] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::234
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Qemu-block <qemu-block@nongnu.org>, Julia Suvorova <jusual@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Jan 2020 at 21:31, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 928173659d6e5dc368284f73f90ea1d129e1f57d:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200130' into staging (2020-01-30 16:19:04 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 8dff69b9415b4287e900358744b732195e1ab2e2:
>
>   tests/qemu-iotests: use AIOMODE with various tests (2020-01-30 21:01:40 +0000)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------
>
> Aarushi Mehta (15):
>   configure: permit use of io_uring
>   qapi/block-core: add option for io_uring
>   block/block: add BDRV flag for io_uring
>   block/io_uring: implements interfaces for io_uring
>   stubs: add stubs for io_uring interface
>   util/async: add aio interfaces for io_uring
>   blockdev: adds bdrv_parse_aio to use io_uring
>   block/file-posix.c: extend to use io_uring
>   block: add trace events for io_uring
>   block/io_uring: adds userspace completion polling
>   qemu-io: adds option to use aio engine
>   qemu-img: adds option to use aio engine for benchmarking
>   qemu-nbd: adds option for aio engines
>   tests/qemu-iotests: enable testing with aio options
>   tests/qemu-iotests: use AIOMODE with various tests
>
> Paolo Bonzini (3):
>   block: eliminate BDRV_REQ_NO_SERIALISING
>   block/io: wait for serialising requests when a request becomes
>     serialising
>   block/io: take bs->reqs_lock in bdrv_mark_request_serialising


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

