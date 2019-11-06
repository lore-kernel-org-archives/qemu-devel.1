Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FDBC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:57:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1948A217D7
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F8k1ZxN9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1948A217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSJw9-00051H-6w
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 06:57:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45574)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iSJv6-0003xn-WC
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:56:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iSJv5-0005ra-UX
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:56:16 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39903)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iSJv5-0005r0-Om
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:56:15 -0500
Received: by mail-ot1-x341.google.com with SMTP id e17so12056903otk.6
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 03:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BF5WVbDYUK3OSejFY/4dScyQcQgZkzUxMmHAd5PUFgY=;
 b=F8k1ZxN9B9NDSiIpzg3oTNuBpt3n6EvpdjoMbB//094WH3UyXjTYN8ZTBjAYKThZlM
 Wi/a6K9AEZVe3oyKEET935OyOrNMRmT8FAtc8aSCbALc4QHIR4PXY0PNIOkJjAUon5C0
 XJ+cabhW/XQhFHmxl6u4qGjnC8yCU51siXS7QYGNI/gKg8NI0oodpmjdgv9U5FIyoxUf
 3JBOUsPb4LgK9SOmf//Z2P8FJYUYcIaNEG9AzjDlUsX/n+qdkZivT9nFScM0xFkDk74y
 Bf0GmMmYs/kjNQo8Z/PQZJVvtxghDgKLEalLuA3PBZe9Ff4QF3jUoKtfBraOliy3qb6i
 K9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BF5WVbDYUK3OSejFY/4dScyQcQgZkzUxMmHAd5PUFgY=;
 b=EZhWu+iRyAfWcMBYE6li7nQC/knwYh7znQ0kqajjYe4JLlAJRqwXRozvoUeUK+Y6hD
 bKdLvTvfmwgXyblYYHJLM/BbXLw0iPDZabO06v7yquhgbQmIPWPEQGDDK1p5rO4DLD8H
 JCsjvT6o+D8CV1pxiFvhD2ldfnm72VClbS8cufuM1PpUK+hfcGpsfQyYmr54IYjx2y+q
 gQcadOzyuVzOkfFQrwNqeLxAa4eM069QMZMZfxvXMdutnOOAvOdO0a4d5AxYAPSN46Ya
 L+kCHdQgcylv3QHDFsSR/csU3lwwWL0GAp5EbRquDOn8uN3aF/SS4lZJaIDrX6LTuUhf
 1xew==
X-Gm-Message-State: APjAAAVpFeJe/EODWD0HN2IspffeC0FZRgmwD4N24OwDxJJn4HG/nHPy
 2zBBauEFWbGPJqQRFnt7/vL0byvcoENayOZpuX8tiw==
X-Google-Smtp-Source: APXvYqwtpWrAqJiKJetxciiocJvuCHKQNEwUxhLuIehgctPzI4fPAnWEA4neyWhScK9MI2jdjw9kpjlsVvM/vvUq8ug=
X-Received: by 2002:a9d:12d2:: with SMTP id g76mr1570355otg.232.1573041374847; 
 Wed, 06 Nov 2019 03:56:14 -0800 (PST)
MIME-Version: 1.0
References: <20191104090347.27278-1-mreitz@redhat.com>
In-Reply-To: <20191104090347.27278-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Nov 2019 11:56:03 +0000
Message-ID: <CAFEAcA-fDZ7bb=88KbdmTcBWRhua_A66a41E9kr9O3AMWVbCmw@mail.gmail.com>
Subject: Re: [PULL 0/5] Block patches for 4.2-rc0
To: Max Reitz <mreitz@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 4 Nov 2019 at 09:03, Max Reitz <mreitz@redhat.com> wrote:
>
> The following changes since commit 36609b4fa36f0ac934874371874416f7533a5408:
>
>   Merge remote-tracking branch 'remotes/palmer/tags/palmer-for-master-4.2-sf1' into staging (2019-11-02 17:59:03 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/XanClic/qemu.git tags/pull-block-2019-11-04
>
> for you to fetch changes up to 292d06b925b2787ee6f2430996b95651cae42fce:
>
>   block/file-posix: Let post-EOF fallocate serialize (2019-11-04 09:33:51 +0100)
>
> ----------------------------------------------------------------
> Block patches for 4.2-rc0:
> - Work around XFS write-zeroes bug in file-posix block driver
> - Fix backup job with compression
> - Fix to the NVMe block driver header
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

