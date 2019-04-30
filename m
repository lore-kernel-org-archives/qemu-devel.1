Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9887C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:22:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 731F72147A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GFkGnoxY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 731F72147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50608 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLWSu-00010U-L5
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 13:22:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLW4i-0006aR-Pc
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLW4g-0003Sv-RQ
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:57:48 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:34961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLW4f-0003PM-2X
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:57:46 -0400
Received: by mail-oi1-x229.google.com with SMTP id w197so11851254oia.2
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=8CjWopWf189I269XlZcNba6PnTBXf0n9YcIAnuqwl1o=;
	b=GFkGnoxYQDZHxi1rJrUiSYqAe5/gBKQepe8866VmspSt8XAD978GetGNw1VlE43oY9
	ufCT61p6H/yfcdgptnnGkPUBS7poobDTR8hSEJcBumlY6U3G30ECjvnJ7QiHoHhaSiKq
	oJq9yP7sNHPDGcmg3q0FhDlyrSMFuIbqtfBWXTzoNhOjIaWZS+3NudPQeK7Qn4+Tl/W4
	jNRJTQz5W0POIB2uKQfas8EnWmdJbCeSVAUbHMg+phuKBxbzP0yGUUOxLt2xoEEksI6r
	8QnJOErJv0ZCATGauzG8QDGwLDv6R6Qj6r3FtW6zBkPI6rf9sZM59RQk7FdcGCm6neLf
	HD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=8CjWopWf189I269XlZcNba6PnTBXf0n9YcIAnuqwl1o=;
	b=ZNzAcvg2bnReF8ZJodxBodslNkR6H5GbDjO9WpheBhKGeWxbG0TLux0v0CRrtGYUAA
	YWOdhgDGSCw5hSgv76Q7/zg23c/kLqaNjmN2SOg9AezRgIEHDW6YOGU2b9R4jifWgo2Y
	oPvs++2f/Yim5OAymPSuMGVoD7MnRxupWE85tJghbEhA3cchpgi1TF9VGF+m+OTTfRZp
	ufbaJBd2X+/lZN6HU9hYpP/O1yCucWTt7/iIy9rJyUJq3QhDMtga/QWT2Afy5rHeKLZo
	a0a/6jTqaLy1NuC+sLxI4uWnRwt2dlgiYxv5P3NPOjgV6eJUfgH6J2Flno8u26GW1IBX
	7QJQ==
X-Gm-Message-State: APjAAAU98kdP5viy9vyJsiX1nEE5PCVMMx2IxNz5CJEuqoIQ2ap0mXqj
	T/GiKMfqMOH8YhvZOPN+IDQNFqTO0NDv4SwMFRLQfw==
X-Google-Smtp-Source: APXvYqznS6Jzaw5/D9tG58Bm3xnGl6P2uFSSXvDkZn1DAHSqUvVX6yIyESawI5b1GKyX6H4tya3DXaMXvKryf3EgwUo=
X-Received: by 2002:aca:ab12:: with SMTP id u18mr3412973oie.48.1556643459726; 
	Tue, 30 Apr 2019 09:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190430154244.30083-1-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 17:57:28 +0100
Message-ID:
 <CAFEAcA-rW3OLKt2a8+1cdcMa-=Hp+ppqp_HdC1=ZNVxSXtKqeA@mail.gmail.com>
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::229
Subject: Re: [Qemu-devel] [PULL 00/27] Block layer patches
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430165728.Pf4P2HaGb0hO52mp5aHs-oVQ4ZF0bbq--SnUsh-D1NY@z>

On Tue, 30 Apr 2019 at 17:01, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 22d96eac64877c4d96f9928babb6f2fcc68faacf:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-request' into staging (2019-04-29 19:11:15 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 54277a2aab876aba7b55c7e88e2b372691849741:
>
>   block/qed: add missed coroutine_fn markers (2019-04-30 15:29:00 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - iotests: Fix output of qemu-io related tests
> - Don't ignore bdrv_set_aio_context() for nodes with bs->drv = NUL
> - vmdk: Set vmdk parent backing_format to vmdk
> - qcow2: Preallocation fixes (especially for external data files)
> - Add linear-buffer-based APIs (as wrappers around qiov-based ones)
> - Various code cleanups and small corner case fixes
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

