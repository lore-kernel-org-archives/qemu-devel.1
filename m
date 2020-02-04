Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42412C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 00:04:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E4182084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 00:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R/E55Io2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E4182084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iylhJ-0001do-5y
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 19:04:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57383)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jkz@google.com>) id 1iylgZ-00017g-U1
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 19:03:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jkz@google.com>) id 1iylgY-0007XM-Kw
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 19:03:23 -0500
Received: from mail-ua1-x942.google.com ([2607:f8b0:4864:20::942]:43870)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jkz@google.com>) id 1iylgY-0007Nd-EC
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 19:03:22 -0500
Received: by mail-ua1-x942.google.com with SMTP id o42so6056998uad.10
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 16:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gRmNYce1eOKaxM/fJD/59plzYqzDIfQ7dGXxY9gpig8=;
 b=R/E55Io2HauqQTjTXOQVgNtF4x9u1dTjeCmkT6sfdf3PWWaJEjQMueZyEGj/WQsEVF
 z9EGz9g2tXXTB6sJP3Pmt79yE8rE+hioG7dxssWy2kX+axlYYJIjy8C7kbtyUdPq2qni
 JduNMtPKt/tpV2wVkzRqNGS7atV7CjNsIipmzE8cVuRFwVzeJrwk3XdHfigB7f7Lmwmd
 jP2hzDC8GawsJGC3e0xa3O9LsFNUu+/dw6bmHivHntdVG4KmQiIy/wvwk+T0pgItX1oy
 iEAfewyVAnWaEmCAye1pEZpMFZ3DzSA8IUvX1LG3k0hgnXFoLQ6opg7rxpzDwsj9aM4Z
 oiew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gRmNYce1eOKaxM/fJD/59plzYqzDIfQ7dGXxY9gpig8=;
 b=tF73njh966bvQO8yPHta6YTbVx5/29UDymiyf63NUdY7NYrp1wts1/95/cUjlu7VLl
 p7MkEnhiF2o+8/RrR7FOGj6+G7q0K5tonQlm6sW3EhfbsJ+JLoBwT0YEzw1gYGrj/aLb
 Zv+GzYTsbbkETF8BmTm3KfY6DWp0AWF6egL4Orr+ZT5mnuiLrWCVvetxs0cGjFb2QVFe
 eIccel13xvo8pQI9BIS9ewvt1gQKpIzIGZkWGqrY3WDG2PcWzunMK+JeqUqWIJ9HuPzK
 T1qJqrq5v/4GDpu6C8EmrFrqwM4vq8FVkRBd2Rg0gdbi4SBbkIRrnkfNT/vaT2agT5Ip
 5Sqw==
X-Gm-Message-State: APjAAAWll/YZIaaH+LSX3Y2VdLyoGNe95Y8S3big2r2pRRz94iRHXAnA
 a1KEbxSL9euKOOPJbDli9pLArjoH/Yp7X6Y698pUUQ==
X-Google-Smtp-Source: APXvYqwkolW/IxPEy8mRtPTPbSI/K6XbUq5rGHLtcgXlIGtpps6aeDguMEOPyXwPNgOc83lcGy5g5VgtaQADq/QVM8Q=
X-Received: by 2002:a9f:3e9e:: with SMTP id x30mr16282092uai.122.1580774600783; 
 Mon, 03 Feb 2020 16:03:20 -0800 (PST)
MIME-Version: 1.0
References: <20200201122746.1478003-1-laurent@vivier.eu>
In-Reply-To: <20200201122746.1478003-1-laurent@vivier.eu>
From: Josh Kunz <jkz@google.com>
Date: Mon, 3 Feb 2020 16:03:09 -0800
Message-ID: <CADgy-2uVp2hyqFncFa2T7m8W5vPt=kigdiqosLQFgdB8Df81Gw@mail.gmail.com>
Subject: Re: [PATCH 0/4] linux-user: fix use of SIGRTMIN
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, milos.stojanovic@rt-rk.com, 
 Matus Kysel <mkysel@tachyum.com>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, 
 Marlies Ruck <marlies.ruck@gmail.com>, Peter Maydell <peter.maydell@linaro.org>,
 Taylor Simpson <tsimpson@quicinc.com>, Riku Voipio <riku.voipio@iki.fi>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::942
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Feb 1, 2020 at 4:27 AM Laurent Vivier <laurent@vivier.eu> wrote:
> This has been tested with Go (golang 1.10.1 linux/arm64, bionic) on x86_64
> fedora 31. We can avoid the failure in this case allowing the unsupported
> signals when we don't provide the "act" parameters to sigaction, only the
> "oldact" one. I have also run the LTP suite with several target and debian
> based distros.

This breaks with go1.13+ (I also verified at hash 753d56d364)[1]. I
tested using an aarch64 guest on an x86 system, but this should
manifest on any architecture when the guest/host have the same number
of signals (and glibc reserves some host signals). From the traceback,
you can see it dies in `initsig` which is called at startup. Any Go
program should fail.

Since go does not use a libc, it assumes that all signals from
[1.._NSIG) are available[2], and will panic if it cannot do an
rt_sigaction for all of them. Go already has some special handling for
QEMU where it silently discards failing rt_sigaction calls to signals
32, 33, and 64 [3]. Since this patch reserves an extra signal for
__SIGRTMIN+1 as well, it blocks out guest signal 63 and Go fails to
initialize.

While I personally support this patch series (current handling of
guest glibc signals is broken), it *will* break Go binaries. I don't
know of a way to avoid this while supporting guest __SIGRTMIN+1,
without either doing true signal multiplexing, or patching Go.

[1] https://gist.github.com/joshkunz/b6c80724072cc1dce79a6253d40b016f
[2] https://github.com/golang/go/blob/67f0f83216930e053441500e2b28c3fa2b667581/src/runtime/signal_unix.go#L123
[3] https://github.com/golang/go/blob/master/src/runtime/os_linux.go#L466-L473

>
> Laurent Vivier (4):
>   linux-user: add missing TARGET_SIGRTMIN for hppa
>   linux-user: cleanup signal.c
>   linux-user: fix TARGET_NSIG and _NSIG uses
>   linux-user: fix use of SIGRTMIN
>
>  linux-user/hppa/target_signal.h |   1 +
>  linux-user/signal.c             | 110 +++++++++++++++++++++++---------
>  linux-user/trace-events         |   3 +
>  3 files changed, 85 insertions(+), 29 deletions(-)
>
> --
> 2.24.1
>

