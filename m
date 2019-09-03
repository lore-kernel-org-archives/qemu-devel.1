Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F14C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:57:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9055622CF8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eOGwp0fT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9055622CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5C7X-0006VQ-Mf
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5BXU-0003dC-3m
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:20:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5BXR-0000mQ-W1
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:20:15 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:46014)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5BXQ-0000kQ-1w
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:20:13 -0400
Received: by mail-ot1-x32c.google.com with SMTP id g16so5486064otp.12
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 09:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KluHt6gEpdKAIyMimk8QXrZrU/Xi8beJk4v/RxcDABs=;
 b=eOGwp0fT68Jr7gIbHsfMgllRrU1Fg6Tn0fwLYKZLjpglrsOmBV2y7UOEbUI2s63Rax
 NeFaan+ynHqHhOvt0vXhbJTEvB1AgnXeWxDiM3C0Ch75r1bQcFGn2BM16iFv+gWt9HwU
 ZS4KLlKjtRmrxqYRDz4b2rBY4sbY4e+6EGQdhog0wPQwDofSYcWeIMGegWk9ghHBYSjd
 FSKVg45gMRH0n7WCrZioFLlKT2dqjkJnFBJkcBwgWqLP2oydbZqD7H+VlpKh44j8ZuF2
 7A04WeQMB3C1a4/joclAnUL1K+jgCoTN1dooa0RqH7frN684TuMpXHRUihdTxn4qYFNy
 jH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KluHt6gEpdKAIyMimk8QXrZrU/Xi8beJk4v/RxcDABs=;
 b=JuY4rRI87fx/B8Xc4ytDOgre1wSZkNolDmm4rscAXX4Lcv29A3KKkrv+CZDO2OsWBl
 kbiC+2QKgvYcOYFr6p4YEGphA7LZHy1i+39MYkM26ATKHuEF+D6624raueTeIvS8cnBM
 jWJgSerC6ZyhnRJGwLg5OCn5gtfeET24oKaAOOfHT6iOehLdEKmcHQwFLT7OxFUOBPZv
 jWrxRLS1kiB3e/0Sdtp3Xy/gyoW7/kkuF8K3psbL+coIlUGplEJlnD45fQ3ueFGBF16H
 4XfFTU2ZFU/I6ZUBJsMrMV3GsoeXaABy4VMrKIHxrPZDce2xI80qp4YK8Eoyb+JfcC7D
 qL+A==
X-Gm-Message-State: APjAAAVOJU71kAJUjq/5n7DShaM2F11yR06MsvjxO0amDjJlPhmKFG7W
 2JiXQ94QxkvzQGHaC6eRG7qjjLT28jHurl/2zwhWUA==
X-Google-Smtp-Source: APXvYqz1AE02q4qmvHVf+xSBkQZh4TFzGlPHj8aB9zOaGLHaM/tnIOwPOE03B3NF52zNM6rro+TQ4knsXmoQczqSdw0=
X-Received: by 2002:a05:6830:1bc3:: with SMTP id
 v3mr10050097ota.97.1567527610680; 
 Tue, 03 Sep 2019 09:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190829010340.28873-1-crosa@redhat.com>
In-Reply-To: <20190829010340.28873-1-crosa@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Sep 2019 17:19:59 +0100
Message-ID: <CAFEAcA96Weh0YwEN5ak20ro_PXPYeJqZsVnA92+7bf31xd6vfQ@mail.gmail.com>
To: Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32c
Subject: Re: [Qemu-devel] [PULL 0/5] Python (acceptance tests) queue,
 2019-08-28
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 29 Aug 2019 at 02:04, Cleber Rosa <crosa@redhat.com> wrote:
>
> The following changes since commit 23919ddfd56135cad3cb468a8f54d5a595f024f4:
>
>   Merge remote-tracking branch 'remotes/aperard/tags/pull-xen-20190827' into staging (2019-08-27 15:52:36 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/clebergnu/qemu.git tags/python-next-pull-request
>
> for you to fetch changes up to d19818e50e5286f878a76a286b76d29e57140dd4:
>
>   VNC Acceptance test: simplify test names (2019-08-28 20:42:16 -0400)
>
> ----------------------------------------------------------------
>
> Cleber Rosa (4):
>   tests/requirements.txt: pin paramiko version requirement
>   Acceptance tests: drop left over usage of ":avocado: enable"
>   Boot Linux Console Test: add a test for ppc64 + pseries
>   VNC Acceptance test: simplify test names
>
> Satheesh Rajendran (1):
>   tests.acceptance.avocado_qemu: Add support for powerpc



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

