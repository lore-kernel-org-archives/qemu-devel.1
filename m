Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DB9C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 16:12:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 077482173C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 16:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fXIaqCVQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 077482173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56413 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT7Mx-0003Ey-6b
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 12:12:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT7Lt-0002lU-0h
	for qemu-devel@nongnu.org; Tue, 21 May 2019 12:10:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT7Ls-0007dK-15
	for qemu-devel@nongnu.org; Tue, 21 May 2019 12:10:57 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:44902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hT7Lr-0007ck-O9
	for qemu-devel@nongnu.org; Tue, 21 May 2019 12:10:55 -0400
Received: by mail-ot1-x32f.google.com with SMTP id g18so16815822otj.11
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 09:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=w93YfPrOmAs4qkCtdxZTOpiZve+07OEGjo48CrtsEC4=;
	b=fXIaqCVQeMomJ9PAzfMg6o91BUxK/y5GhyN11kj9fnjw6TvjdYiuQUt7tiCULz+9UL
	vTLMCw1yn8mBLwx8wqYq0YwMs/Tcq9kq2MDLL8hOy0iCj1/lDwo4p5+dx8xwzZ1b9h7n
	dfv6xMwG41Pv7aKhH4cwq6EzNwx18GDaNkPJo+7XQVKPQh/tFDXNW0xFNI8RUIoHv2Ns
	G6BbzP9xmzUg0wuWtZKDSyPydMlqhzLtgpcMSX85JrtZ2EYloxUbQRJyhqD910Na5ScI
	DEL+LCYFpbF5ecur0dvf/oJwkEOJH0IIRqFDHk/TagBbJdnlUnNdzcan7UDBUqi/DIn+
	g36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=w93YfPrOmAs4qkCtdxZTOpiZve+07OEGjo48CrtsEC4=;
	b=gdmkkQYcrKOKjQw1P1ISuDz7nv8KTDmfC/x/Az2kcsU3sg9LvBZXiIXJGuLhfm3Irz
	Yz6Nx7fVfMKSwQ7oT2TiD+wyfu2Tv2GgS07gaDmGXRF4cTFHSD9CHu917H+TN43YXDjO
	mCQkrx4sL3TSkIkcAaytE1kP9umIvbyvTsdiGWCjtaPE+sF330KyQe1e6yDEgjE3MJcd
	+gQDBeBq5/JZkGbODirfuVW89JTGdA9ip9gOY9BWaAEA0l95UWEFpOwwhFRzQMdi/92a
	BbiB8vlFJzvvbG5hhhQ6qYdAPaZw6L6Nr7QHkHZ2dJF8Z2Kmd+uslYiM5EE/EXWkdHjw
	FBwQ==
X-Gm-Message-State: APjAAAW5BWt1nzfqWp0NzWgOfLlhpA1DvhU4wxsKrS072i/w9NIvfkwY
	a3eX6ueRSppW10bgyXrR6K65z9NCSaqx7uD4D3AV1Q==
X-Google-Smtp-Source: APXvYqwO2rTM6Yne1cyTkxvqaspMgK4XGAYF6UroU51YgXHJFieWriGtOtpwJ+tC5nYqNikdCKyhMLr1r/nRqoKatc8=
X-Received: by 2002:a05:6830:209a:: with SMTP id
	y26mr20134327otq.232.1558455054654; 
	Tue, 21 May 2019 09:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190521152810.21353-1-cohuck@redhat.com>
In-Reply-To: <20190521152810.21353-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 May 2019 17:10:43 +0100
Message-ID: <CAFEAcA9e7SuNJeJvAOGXWSs_MGZer7on-EBdkDynasJeKvpv2A@mail.gmail.com>
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::32f
Subject: Re: [Qemu-devel] [PULL v3 00/55] s390x update
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 May 2019 at 16:28, Cornelia Huck <cohuck@redhat.com> wrote:
>
> [Third time's the charm, I hope. Split out the change in the update headers
> script and copy to the right directory. Sending only these two patches; the
> rest are unchanged save for the commit ids.]
>
> The following changes since commit d8276573da58e8ce78dab8c46dd660efd664bcb7:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190510' into staging (2019-05-16 13:15:08 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/cohuck/qemu tags/s390x-20190521-3
>
> for you to fetch changes up to c657e84faee48d6ab36665da5a008b8f0649593d:
>
>   s390x/cpumodel: wire up 8561 and 8562 as gen15 machines (2019-05-21 16:59:16 +0200)
>
> ----------------------------------------------------------------
> s390x update:
> - have the bios tolerate bootmap signature entries
> - next chunk of vector instruction support in tcg
> - a headers update against Linux 5.2-rc1
> - add more facilities and gen15 machines to the cpu model
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

