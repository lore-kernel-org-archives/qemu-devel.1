Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65625C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:43:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23A6820717
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lQhsFyP7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A6820717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBLzp-0002wT-4e
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 12:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54383)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iBLls-00039Q-Ki
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 12:28:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iBLlq-0003CO-VH
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 12:28:36 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33331)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iBLlq-0003CD-EA
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 12:28:34 -0400
Received: by mail-ot1-x341.google.com with SMTP id g25so6728825otl.0
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 09:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W+RrZzCeCmMgB4WeC6Z58QwhwbPLh+zvqQ+h5E+YFy0=;
 b=lQhsFyP7EGi0zd3IzccMmfFH7f5n9CHwoml1LUu95Nq3ujSvQSH3qgI9DLxIY9dKJ0
 liqrsHzilv8BflyTp038QYlN7/7HCADpoVmOb8t4NDgJ4cMFnWTr7AfHeElMtaPIvJco
 QJQz74iIccY8x2+xt9aFaW6IY2xpAf+2IJYdFfcua9TofSukEi8tVTNMYx0He8mJ5oIv
 ketaB7bBMxvljaziGilD+rw7yruXS5rRe9fAB9JE9o+uxDu22Uiyk3hwN6uKgSZWO0tt
 5IwYV3nZrQ0bM0S6GzaVrjLBDBbm9X3ynypeJ5Ftn9cPyP8vX7neySWL0RIxATbyjd3q
 jjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W+RrZzCeCmMgB4WeC6Z58QwhwbPLh+zvqQ+h5E+YFy0=;
 b=KTdVvCgkwJhrQqHmnmXZ3cynnk4f7LQTH66iIbDgsiUok9VfCNfNl8glDnhQfL6S46
 ICAcPE/M1aAjSt1zGVB/nIhRPAGRz6FFNHiFUKwTCoOCJuc8VurrvBGBOkdOgJoZ7RIi
 ZIpL7POkoLTXePiBwHMvWotYZJj54XcoJ7kJ7d7FcBXjxVuflp+wx2jN7l0LNbu49ONg
 YJTLLi+BIaJXQM8yL0BIdEuz+onurLQ0wLn4k9bKzOjpVpWF2q5I4ZS0g/bx1N9gvs5u
 234ahuW83umtS3yMeejPOnb1GHujrCFaA1mWvmoEXJMxXQrkcrRlo4MHzxk3P5itd8Fh
 XtaA==
X-Gm-Message-State: APjAAAWoR74ZDpxJuMzWEt/WDDB2fphsDMmOdu/wNjvOT9z8kK7wPeNO
 oli1T0XZ5cnywcvlLPMZkSKPozxw8AdJF0VJ3uZ/1Q==
X-Google-Smtp-Source: APXvYqyDdOKfkN5Qe3LvQ/BCDyQ0kpsTQYGlNQa8WCnsch5DrsihvG28xH16N9DYlxP5FflbJzgU2JZof58qtK0LusQ=
X-Received: by 2002:a9d:4615:: with SMTP id y21mr4921025ote.97.1568996913411; 
 Fri, 20 Sep 2019 09:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190919135443.15164-1-laurent@vivier.eu>
In-Reply-To: <20190919135443.15164-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Sep 2019 17:28:22 +0100
Message-ID: <CAFEAcA8QkkKQ_kMZ2x0xsW1Sp3sK+=i+QRGcDQ+rzq9emustSg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 0/8] Trivial branch patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 19 Sep 2019 at 15:02, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit f8c3db33a5e863291182f8862ddf81618a7c6194:
>
>   target/sparc: Switch to do_transaction_failed() hook (2019-09-17 12:01:00 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/trivial-branch-pull-request
>
> for you to fetch changes up to 754119198de633683d7af79bc08e73c2de9df011:
>
>   configure: Add xkbcommon configure options (2019-09-19 14:42:31 +0200)
>
> ----------------------------------------------------------------
> Trivial patches 20190919
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

