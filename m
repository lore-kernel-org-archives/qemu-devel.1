Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F0DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:43:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0227A20679
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="auPz830n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0227A20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgUcT-0000WU-AH
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 10:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgUbs-0008Vr-Du
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:43:16 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35833)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgUbp-0006ll-VK
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:43:15 -0400
Received: by mail-wr1-x442.google.com with SMTP id x14so2678062wrp.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 07:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=DjAH5kKbPQ5oXwiHz2Kq2eVaizOIcD+8eJ104DXgaYE=;
 b=auPz830naYK4wdapGfC2R93ehrjo0DfN3WkLG1GQ+ETJ4sP0W8wh+6p6SAwMxNRvx4
 PhbuPx0jHSpEmcFeOEgXmum72dWRD23xz3y78y573mil/Q4BZP/Ot1hqd/WmVo0jwOCQ
 6aNUt+7A+Q3ruo2XRPdpVa42nQ4daRqELVUFh32Bgr5pq9AfAwsS84LRzSHHvY4gzdtX
 MJX6tAm3wZ9cVKdZLCMqbqtePcN9n6EdkaED55klG/bxgArVu7z5EVnhN0r9Y+28BJWo
 RjJ8PqEq6M2Gzyo3ZmWh4HlTMsk1JUECegMCsX7laNtPGDYdwp9zv6evESEjQvLANpdZ
 rp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=DjAH5kKbPQ5oXwiHz2Kq2eVaizOIcD+8eJ104DXgaYE=;
 b=RY9KtUUpA+e/AsuexQlrG9N7mSmrQDo7NAr25WFpXpSoTphreQBTjZMZRXsTwPZj5+
 Xz3boI3rr5X3nxJbfOnIlywDMLr+7+20XqwaylVFMIGdn2tZDIX5kj4YJlXnOd9q5ofQ
 4TIIRG/LXRdINctwDcpf5ixqly/x/+3cVon+LbFcHgfyG0rdg9k/AZIGJcYGSws5dO9U
 WrI8V517EEgGT1Pmk9xHV8u+NP1BWVZjgyH/UjvV26ep5L7OatFzzto6tUDHtvkdkVci
 ejmtQFvr+q90ubzUuKDWE0ubktA97zqO6aRuWjsIiVismxOn2tyRui91lUtUQ0ZFjCZG
 74dw==
X-Gm-Message-State: AOAM532gR6ekQfYlC++AeAEzgpOqHB1oAudw09swTjLiP81Pk3mJOQwr
 q9Bp+YTxXffyW7ZvOEUYSbdoGGlFOHc=
X-Google-Smtp-Source: ABdhPJwWHNpTI+kQs7DIT+P7QMUj4FG+KnSbvphdTHgStbUbEYmRZfFZwh7LLTjSwxuSgf9PbsHrlA==
X-Received: by 2002:adf:f5d0:: with SMTP id k16mr32976490wrp.288.1591195391425; 
 Wed, 03 Jun 2020 07:43:11 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u14sm3330201wmd.0.2020.06.03.07.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2020 07:43:09 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3BB871FF7E;
 Wed,  3 Jun 2020 15:43:09 +0100 (BST)
References: <20200602115331.1659-1-filip.bozuta@syrmia.com>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Filip Bozuta <filip.bozuta@syrmia.com>
Subject: Re: [PATCH 0/5] Add strace support for printing arguments of
 selected syscalls
In-reply-to: <20200602115331.1659-1-filip.bozuta@syrmia.com>
Date: Wed, 03 Jun 2020 15:43:09 +0100
Message-ID: <87pnag5hxe.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: laurent@vivier.eu, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Filip Bozuta <filip.bozuta@syrmia.com> writes:

> From: Filip Bozuta <Filip.Bozuta@syrmia.com>
>
> This series covers strace support for printing arguments of following sys=
calls:
>
>     *acct()         *lgetxattr()        *lseek()
>     *fsync()        *fgetxattr()        *chown()
>     *fdatasync()    *listxattr()        *lchown()
>     *listen()       *llistxattr()       *fallocate()
>     *getxattr()     *flistxattr()
>
> The implementation details for strace support is described in this series=
 patch
> commit messages.
>
> Testing method:
>
>     Mini test programs were written that run these syscalls for different=
 arguments.
>     Those programs were compiled (sometimes using cross-compilers) for th=
e following
>     architectures:

How big is this mini-test? Is it worth adding to tests/tcg?

>
>         * Intel 64-bit (little endian) (gcc)
>         * Power pc 32-bit (big endian) (powerpc-linux-gnu-gcc)
>         * Power pc 64-bit (big endian) (powerpc64-linux-gnu-gcc)
>         * Mips 32-bit (little endian) (mipsel-linux-gnu-gcc)
>         * Mips 64-bit (little endian) (mips64el-linux-gnuabi64-gcc)
>
>     The corresponding native programs were executed with strace, without =
using
>     QEMU, on Intel Core i7-4790K (x86_64) host.
>
>     All applicable compiled programs were in turn executed with "-strace"
>     through QEMU and the strace printing results obtained were the same=20
>     ones gotten for native execution.

If we have reference traces from real HW we can compare them using
diff-out or conditional-diff-out make rules. See the run-float_%:
float_% rules in tests/tcg/multiarch/Makefile.target.

>
> Filip Bozuta (5):
>   linux-user: Add strace support for a group of syscalls
>   linux-user: Add strace support for printing argument of syscalls used
>     for extend attributes
>   linux-user: Add strace support for printing arguments of lseek()
>   linux-user: Add strace support for printing arguments of
>     chown()/lchown()
>   linux-user: Add strace support for printing arguments of fallocate()
>
>  linux-user/strace.c    | 174 +++++++++++++++++++++++++++++++++++++++++
>  linux-user/strace.list |  28 +++----
>  2 files changed, 188 insertions(+), 14 deletions(-)


--=20
Alex Benn=C3=A9e

