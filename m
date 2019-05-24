Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F4BC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 11:54:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2ECE20851
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 11:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BlNpRruZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2ECE20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53008 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU8mm-00021H-1U
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 07:54:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hU8lm-0001Vs-7L
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hU8ll-0007x5-0v
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:53:54 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hU8lk-0007wZ-Qc
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:53:52 -0400
Received: by mail-oi1-x244.google.com with SMTP id w144so6792848oie.12
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 04:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=3XPqUzk3HozC1D4y/i0GfNhdxZwVPvEy3RYFyk7zP0Y=;
	b=BlNpRruZBAftIIw1G6e69rGS7rA8tbDhBwMA3+znWr5lHY6spJZfLn9PyKg4ODa/6r
	G/7dGMwY2eihRO1sIivyn1+XluTl7wHeUHHClV6boCIAVNasyoyB3kS5HWYQDSTGES3C
	+qRaemjjS4M2RUn87VZQGwhPuOoQgW3mgcIbj7l8LKCp5inxUvPxTiJSgH/KtEereGbR
	pLqZxfKg5N6Wd/3eQWk2bldE8LfvCE3zyz3mc+RUGA46Mhw9kJ50sXWjetRuKvVDy6/k
	UVOi1lj6QfTvvO9CpFCMAje9QnV0fbliCQp9BiIaUA4uXXmPoeR5Yo1P4iv5o3Mfm+2Y
	X6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=3XPqUzk3HozC1D4y/i0GfNhdxZwVPvEy3RYFyk7zP0Y=;
	b=sNWQ61YBvGlBQOSE6nMs7qRAdzV/NB3IsLEbe4vxB/JHR75BoPxZJqXUMlpZTRseXM
	9ND//2g6kjGXUgJi07An8sAJwj03nCRVUrihuGGSbVoDYf8LDyun2UUkXh7uKkukp+f+
	5p497xRFYfAVPOqTvo2rWK+wJTb4PS241WFqsr4VVNfSXfTAeCkH1D8Dodn+elMkWxRF
	OFxEtsXxOyN1zjrUuHVPXS1Vp1M4b8pMILlvakhVw5Bb9dVuM2y/ps8ud/NoL7vTNSvw
	A8817ipS2+rwm/Xui+hQ8amU99YqAYSsA8qM1QvG1c8qvdgSgIaGJMet3qxQXbpk3Jql
	a5fg==
X-Gm-Message-State: APjAAAUap6+I0UCxfWzAwft1ZMKhrm1eKA3okWrq1WauOuLZjO/simaY
	F3lntsAoB3EUZKjl7OuD1haKf8biFJDX2uVwl3/O5n0M46s=
X-Google-Smtp-Source: APXvYqwYdLOwtTwtfFQ8J7uJttaVxkSiERhw/WX+o3zIQUlS4U+mlyMv2pjSgRPaYIoH5p2ZkUp04cA8XxOk/Jr8+oc=
X-Received: by 2002:aca:4e42:: with SMTP id c63mr6125970oib.170.1558698466859; 
	Fri, 24 May 2019 04:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190524085717.3493-1-kraxel@redhat.com>
In-Reply-To: <20190524085717.3493-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 May 2019 12:47:35 +0100
Message-ID: <CAFEAcA_FSWXBsSue6JSq5vQ7AtTAuPwcrBd_PB5qQj5t8FdAVg@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PULL 0/3] Vga 20190524 patches
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 May 2019 at 10:01, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 8dc7fd56dd4f56ab8ff1df3765ae6b5d3ac11c5e:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/fw_cfg-20190523-pull-request' into staging (2019-05-23 14:15:34 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/vga-20190524-pull-request
>
> for you to fetch changes up to f79081b4b71b72640bedd40a7cd76f864c8287f1:
>
>   hw/display/ramfb: initialize fw-config space with xres/ yres (2019-05-24 09:10:29 +0200)
>
> ----------------------------------------------------------------
> ramfb: misc improvements.
>
> ----------------------------------------------------------------
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

