Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACF6C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 17:01:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA9D323CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 17:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BRgJythS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA9D323CB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55534 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYCok-0003dG-1L
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 13:01:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYCnR-000342-77
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 13:00:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYCnQ-0008TK-1R
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 13:00:25 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:40833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYCnP-0008PM-R2
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 13:00:23 -0400
Received: by mail-ot1-x342.google.com with SMTP id u11so20205895otq.7
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 10:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=evoANUUn+ebYEBACzBsc9xs3u/EbBchLyljVWn/+VK8=;
	b=BRgJythSyo4X/U0K1jA2MhhCdD8/OntUOhRuN3gMuqhkL9uv9Pp8f2Bv+8c8/qvXts
	mdIEpbJciYhMJQ5MPwDMykIg6ZvOelDXoyDYYYs1TZYbRNl2nW+Jo3e0qvYiF+5QL7Lv
	J3oEfzieklCW/7js6xSigzrqgWyMf6Hkbwxga9vi//dvvI9JKNIgU3jUgdwy+ZF+ldua
	VC0qPzVQBW/wurrlwW2hTazDx4mnQZwvc2eYLUHA/EKBk4TIUJpdNBcetNd9drNDiP/i
	gh9zPZTC1HjzGNj23vPqS/if5f+QddNb1zEYV8ImKAu5l636C5RDRAfL8ZEjqm40Zqu0
	ONpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=evoANUUn+ebYEBACzBsc9xs3u/EbBchLyljVWn/+VK8=;
	b=EOdjxfEpA801Kb+RuWiLRxl97rrVQWl95WIXqttPLdRbiDCJBCl6rIfBojmD/mwQ7r
	q9YMgxjp0cJhs7Oio9RG0AjxZSR9aEDQi2twhzPB5sj2o1QFQ/87CdS4ytw48ppiPGh1
	0c4WPQKzVIp6a7OBtWH642ok4ItFkveY6IvTN/Lc7H2FMsPiH+VvohQeg/QrXfQgyQNt
	FKb/WVcQOZhOmNXVSrsvu+0y0CtGACuHwoqWQ+cluJGbFKaLc//k5xpD61KrSajp1+RO
	sLI/FtPHwu5sAWH4ERjh975jVg6M3Jrw9b2Qxz2P9h7QyZww1MDPW3St49qGBau/c727
	HCrA==
X-Gm-Message-State: APjAAAX+Ct0zPFVyzGwC8bx2lqFVXQJoFZ7LjAqEKja/EgFjxLshbbT+
	ojXbxNe5qJiwGe4c3DRzku/PHj0++MCHbwiM1nCFag==
X-Google-Smtp-Source: APXvYqyq/e6iFngj3ipOE9rqDooukjZZ+7x1t3KenUc8/H8M4EW+SxrLLxQ1fzgAtBaoblDKcI5WnZCCy5GUdUZ7oEM=
X-Received: by 2002:a9d:d17:: with SMTP id 23mr5720514oti.221.1559667622887;
	Tue, 04 Jun 2019 10:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190604161430.32105-1-kwolf@redhat.com>
In-Reply-To: <20190604161430.32105-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Jun 2019 18:00:11 +0100
Message-ID: <CAFEAcA_jec5tVqOVkV=GyFS565YnXA7XV0Rww0HkUtVGHP=vew@mail.gmail.com>
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PULL v2 00/29] Block layer patches
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

On Tue, 4 Jun 2019 at 17:14, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit e2a58ff493a2e00db3e963c1839c5374500110f2:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2019-06-03 18:26:21 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 11ba81c3cde0bc070cced6e8ef2835fab4fe90c8:
>
>   iotests: Fix duplicated diff output on failure (2019-06-04 16:55:58 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - block: AioContext management, part 2
> - Avoid recursive block_status call (i.e. lseek() calls) if possible
> - linux-aio: Drop unused BlockAIOCB submission method
> - nvme: add Get/Set Feature Timestamp support
> - Fix crash on commit job start with active I/O on base node
> - Fix crash in bdrv_drained_end
> - Fix integer overflow in qcow2 discard
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

