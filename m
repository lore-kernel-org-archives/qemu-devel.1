Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DACCC4727F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 11:25:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AACB20691
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 11:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y279SwrB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AACB20691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNwiS-0000Gc-IC
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 07:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNwgA-0007GT-JD
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 07:23:18 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534]:35517)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNwg6-0007jx-Nn
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 07:23:18 -0400
Received: by mail-ed1-x534.google.com with SMTP id i1so5234438edv.2
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 04:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xySL5VQqL4BUYQTB2jhg5a64LEKQGIQJaxw03S1Jtos=;
 b=Y279SwrBCWZ1OCvFtwRkQPnsWyzyUqLTX3HZbvRhlCo4slosifkJfSq1GzzJbWTiBa
 AJ/FiaM+cIk9CJ3Ncq1Z3ppSfz7Cbg3ODf5Y1EBVLA5o6Ulv+NmkLlgy1OziqsDEjLpT
 pso6h5isTfsjBbseCIwVnu5jAZi8zlPTDqCvbRnxorGZoulUEwiq++Th0bus975yGphn
 Y5vknEen8C4STQKND0QfqLdKq+r4aR54R6jqyPGn8OO4BAXTDZeBNounAbwWiVrE0SEE
 10yLk3X58+NWFCorGkqfU7xP/hB6OhHolzjXvwjP3ITHt+kXtvp8bSJjmblMJqhFmK1d
 Z1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xySL5VQqL4BUYQTB2jhg5a64LEKQGIQJaxw03S1Jtos=;
 b=RmXupoT50UmGXZXwlJ0cdEYH8NGB9XJsU3TG5r3uz8tfSJIIhMJ1btgqwebL5FvzHe
 bSp1khwdKTQPNInpKx8CPYW9g9CqQhjb/i9TApHJ/OGsAf4a8xKs0yB3YCEgGJeBMlIh
 phK/wpeqWZI259uow5fb98YCr1cEWj1sFUNVkZ1C6UQcpO08pims6mjNx/vp0gTcGzVG
 Lmhj+3r+OsFfDs9IZa9AtR94C0ItOxC9dEk6w1+A1Yr/7e2a/9v4UCHnepnqSlbuzz7X
 RDMRfvhECkCPPQvXq5wAXJSx5EpcvHGZ93lv00cX7IXCx2fG0W1nobtlTyFo6qr7WGNN
 UsOQ==
X-Gm-Message-State: AOAM531vSoi7R2tPQU0YoRYLMBCBmFHFJoyZbTNxXQAhXSSoNLCbxLXm
 1TL9uO40uLiqeQ3qRpoRqKWeTIKQkjdYQfyaNDqoAw==
X-Google-Smtp-Source: ABdhPJwKQC0VPI/9o7TqlWVa2GWHAFEDClhlvxp7J55Rgu7Sf8HrHzsSGGhdj301DH68iCQdw4IP+auzmMe+lKDGbuc=
X-Received: by 2002:a50:f1cf:: with SMTP id y15mr7766364edl.204.1601551391844; 
 Thu, 01 Oct 2020 04:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200930101305.305302-1-stefanha@redhat.com>
In-Reply-To: <20200930101305.305302-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Oct 2020 12:23:00 +0100
Message-ID: <CAFEAcA87+50vkXLkLwVtrtNn4No4Fvsjd+LDEEu2cmhJcQdZ=A@mail.gmail.com>
Subject: Re: [PULL 00/17] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Wed, 30 Sep 2020 at 11:13, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit b150cb8f67bf491a49a1cb1c7da151eeacbdbcc9:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2020-09-29 13:18:54 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to bc47831ff28d6f5830c9c8d74220131dc54c5253:
>
>   util/vfio-helpers: Rework the IOVA allocator to avoid IOVA reserved regions (2020-09-30 10:23:05 +0100)
>
> ----------------------------------------------------------------
> Pull request
>
> Note I have switched from GitHub to GitLab.
>
> ----------------------------------------------------------------

This produces this error message on ppc64be Linux:

make: Entering directory `/home/pm215/qemu/build/all'
make[1]: Entering directory `/home/pm215/qemu/slirp'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory `/home/pm215/qemu/slirp'
Generating qemu-version.h with a meson_exe.py custom command
Generating qemu-options.def with a meson_exe.py custom command
Generating block-gen.c with a custom command
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
Compiling C object libqemuutil.a.p/util_qemu-error.c.o
Compiling C object libqemuutil.a.p/util_qemu-sockets.c.o
Compiling C object libqemuutil.a.p/util_aio-posix.c.o
Compiling C object libqemuutil.a.p/util_osdep.c.o

The error does not cause the build to fail, which seems
like it's also a bug...

(My guess is this is due to some script implicitly wanting
a newer version of something or other than the PPC box
happens to have installed, rather than being an endianness
issue.)

thanks
-- PMM

