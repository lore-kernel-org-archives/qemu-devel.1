Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCC9C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 23:07:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9721720449
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 23:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VJS0Pl+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9721720449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55939 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO9BM-0003VE-Qb
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 19:07:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hO9AW-0003AU-2J
	for qemu-devel@nongnu.org; Tue, 07 May 2019 19:06:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hO9AU-0003Y4-70
	for qemu-devel@nongnu.org; Tue, 07 May 2019 19:06:40 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:41963)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hO9AS-0003LL-GY
	for qemu-devel@nongnu.org; Tue, 07 May 2019 19:06:38 -0400
Received: by mail-ot1-x32b.google.com with SMTP id g8so16604233otl.8
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 16:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=v59+G3txdigVLPUAwnTR2jZ/wtpRLqd7Qu9iELG8Wt0=;
	b=VJS0Pl+gUSpEmmG9UbUJcGH/d8zAS92qUWKUJ63mhnCSTJYJ6zqmfnhQQjnZ+rwd37
	dh2G9giUSxHjkPz0smV3n65lKP3cDeptFTbb+yPBh2E9k8GQBLR80RiToMwh8X+7FFhl
	Dt9zZ5rmlVwjFw1Fhrh70qEHVbDAvGQq09rIpUisZG3FOZlhqBidsHtkXtHRkitoTG07
	I7y2+It1Lj+EkseBduwjMU5HE/CDolfbrIo3LaAE5R0UYEP81+DwdNUbzB+Jtza05Sb6
	qEeMygDVBQiw+7+ukC/e6G+n8s+HDJ/r3CujHoi+cNvFcdMs6ZTqFDosCBcLXJUKZswO
	vR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=v59+G3txdigVLPUAwnTR2jZ/wtpRLqd7Qu9iELG8Wt0=;
	b=Zjc1KcCfelRgZVeSib9ZHGw0gfOC3iB7TZ+vKzyfozNlNewC8BDv0Qbeo1la8rpJHw
	cb2ZzhzgSxCUHTUHDCXFgEM0pHWXyG2EolOtzvYm/8ncflaJ3ZupfzODQPChCKYgorcC
	aGlQM1ZYpmUgFgdNGGijgm81qvgcxj1dGPCGlDLEjnOWDJJjdwvXYkrhSf0isoZXmXZJ
	2MxtdjzJyJd9W3FrtkeSCbH9UjVgTbfrhO1c4yS/VT2ReEUg8CVne23trbLhGsoYtL8m
	UkfPSgP4J4BvAaoTWBLmXu9jXHBnDU2ygXvo0xj9CAJHrqW5VzEhj6jSosM5Syr1XaVr
	wx3Q==
X-Gm-Message-State: APjAAAX98A1IsAn/GWQ5A8KyQGzppmf6lsgy5M6OXu3VCuLttrFnzrez
	apSnf5xyWiWrJmgwEkD337Lt28hLJ5wA9ilD5NVZYA==
X-Google-Smtp-Source: APXvYqxkinOq1DvvIY7+2WsPGkGGTQnJY2ilbe+gfbSa2BUY0aPczYMYLaOOZIqnfFcnvD1GJ5ex+kXeWrlM68F2OJo=
X-Received: by 2002:a9d:61c6:: with SMTP id h6mr23206628otk.316.1557270394584; 
	Tue, 07 May 2019 16:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190507081946.19264-1-kraxel@redhat.com>
In-Reply-To: <20190507081946.19264-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 May 2019 00:06:23 +0100
Message-ID: <CAFEAcA_c8pc01K7hyjJHzyjJ1JGCpi_Nf1iSwOt1Q9GwWs-i=Q@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::32b
Subject: Re: [Qemu-devel] [PULL 0/8] Vga 20190507 patches
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
Cc: Alistair Francis <alistair@alistair23.me>,
	QEMU Developers <qemu-devel@nongnu.org>,
	qemu-arm <qemu-arm@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 May 2019 at 09:19, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit a6ae23831b05a11880b40f7d58e332c45a6b04f7:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-request' into staging (2019-05-03 15:26:09 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/vga-20190507-pull-request
>
> for you to fetch changes up to 6306cae275c7091aa4e785809d956b475bfedab4:
>
>   i2c-ddc: move it to hw/display (2019-05-07 09:56:10 +0200)
>
> ----------------------------------------------------------------
> vga: bugfixes for qxl, cirrus, ati.
> vga: add "-vga help" support.
> vga: move i2c-ddc to display.
>
> ----------------------------------------------------------------
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

