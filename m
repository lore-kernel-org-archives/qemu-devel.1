Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3335EC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 10:38:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CD83206CD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 10:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dJQJPXO7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CD83206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOIRv-0005zy-I7
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 06:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kOIQg-00050c-Tc
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 06:36:46 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530]:43420)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kOIQd-0000gc-RZ
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 06:36:46 -0400
Received: by mail-ed1-x530.google.com with SMTP id dn5so1131627edb.10
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 03:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aQBKucmsqhMu5/8eikVxjpOVLK65C0ZaPvuenTBIsj4=;
 b=dJQJPXO7BIAwb9ypGEgOLOisu6I/15dm4cwBYtD3D0+t4C5NoUMA2sgtUpdQsfapUb
 BMml63vpV7kRfeJhVn8GM4Hbgs/vpdMdzD904zq3fgLmcGDK7Qe9HraRqX5mJQbvA2R/
 hcJ/H9etqF2ww9jnUy/qaTOGYy+QHXPRp6S3Tx6+b6PWNCV3jfa/aNHbmZ5CZhURaZ7y
 MAP3lh4BY0Z3xiO2MWEojRqjgDfJyL+LBgMXa9ktlIW1NvLz7vdB0hBBrDIoYaNxFxU0
 RPms3JOzmVA4+W3qhpMQ1KjIZX3FHaT58TfpqsNn/sFSAcvIDbkT5SFrcK+dzxtoQdW0
 rkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aQBKucmsqhMu5/8eikVxjpOVLK65C0ZaPvuenTBIsj4=;
 b=X/u7moRZm02MZDDWJci5ShTmMIR6w7hIXN9CezzlHgRUEKcKt9Oru1tW3kq0vgBi1d
 wGyLPfCLGryr2I+v3OePHjiZlGUJ15KiAP/Q4wFFmsj+GSUhYA4KAYywzQQRWTiQcs3u
 lSiSavQh50MsDxzM2mndM27/EmK1U2453bpK6o6bmDLAP/DU3ECQjmURNlzvrvsgmOdv
 +wLqx0/e3kN0dGQWhnRBNRcJ4PuWGt2wbKHPeylkvXIHYnGWKrYlIjlsSOpwW8lHc9EN
 tYx5MtzIaM+NI6E1zJLv9LyM2EztqULFs6TwfmyR+PXP0+LF0fUUVP+8mQfgPmreeVl/
 pxsQ==
X-Gm-Message-State: AOAM533sT5KLlHOOGqrUSGiT1jD+xGxvB13W9F/0Vwi9PsvWqThjjEZE
 YxkW0fmlWlEaaMYDX3s4812UYEGp/yjKWbsDPEU9vQ==
X-Google-Smtp-Source: ABdhPJzg/pJ1LGUR7Qp2qU19/2tSNObgIULQDxRKC7zAtMRrPmxVecSjfJj5kDRtRmkvF09ETbwv+qcbK04KWyWEiaI=
X-Received: by 2002:aa7:dd4b:: with SMTP id o11mr1534660edw.251.1601635001996; 
 Fri, 02 Oct 2020 03:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200930101305.305302-1-stefanha@redhat.com>
 <CAFEAcA87+50vkXLkLwVtrtNn4No4Fvsjd+LDEEu2cmhJcQdZ=A@mail.gmail.com>
 <20201001150248.GB559957@stefanha-x1.localdomain>
In-Reply-To: <20201001150248.GB559957@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Oct 2020 11:36:30 +0100
Message-ID: <CAFEAcA8OvE9amQjOznBJgvYjvadNifD2xHn+bwJUz3B32=KwGg@mail.gmail.com>
Subject: Re: [PULL 00/17] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 1 Oct 2020 at 16:03, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> Please rerun with make -j1 V=1 so the full command is printed. I'm not
> sure what is emitting these errors.

Vladimir's guess was correct:

/usr/bin/python3
/home/pm215/qemu/block/../scripts/block-coroutine-wrapper.py
block/block-gen.c ../../block/../include/block/block.h
../../block/coroutines.h && if test -e block/block-gen.c; then printf
'%s\n' block/block-gen.c > block/block-gen.c.stamp; fi
YAML:1:83: error: unknown enumerated scalar
{"IndentWidth": 4, "BraceWrapping": {"AfterFunction": true},
"BreakBeforeBraces": "Custom", "SortIncludes": false,
"MaxEmptyLinesToKeep": 2}

           ^~~~~~~~
Error parsing -style: Invalid argument, using LLVM style
YAML:1:83: error: unknown enumerated scalar
{"IndentWidth": 4, "BraceWrapping": {"AfterFunction": true},
"BreakBeforeBraces": "Custom", "SortIncludes": false,
"MaxEmptyLinesToKeep": 2}

           ^~~~~~~~
Error parsing -style: Invalid argument, using LLVM style

thanks
-- PMM

