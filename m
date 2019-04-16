Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDAAC10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 15:39:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36077205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 15:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d87ipYoQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36077205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38615 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGQBY-0004uq-Ge
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 11:39:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGQAC-0004Cs-Ck
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 11:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGQAB-0000YJ-C7
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 11:38:24 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:43118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGQAA-0000Ur-Rm
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 11:38:23 -0400
Received: by mail-oi1-x22f.google.com with SMTP id t81so17331678oig.10
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 08:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=3dRX2ZVJjnc63D9aV1WFofCsH5TIO9/qmrOMac70/Y0=;
	b=d87ipYoQxSasiZPS40WsfvGcL1clFpZX6EQ7xr7pAurh1vRcgwLab0FoR/xZbR5oYh
	YOp/Y7B2yCGq2vbtFTgQA6JKEpUwtQ/SP9HcSQ6MfmX4c2UMS4xwPllLFf6bQHUaBDiA
	JrMgtLG41XDJJ6lhotw5mFLLZ82driaX66WtjvGBv3hjx8BtNomkK+fbBnKu/u6+nyYL
	i9iCjQ33CKzcWG883ctcEtM54j+Q7nZvEDEV9crOVC6fNfrGD6//9YX0iSrSfM13jzZa
	hlcGHdPxEvkJQd26pelKgupNQ+P3kDpcHE1FfnlpuJBBQlIXBwrKQFck2OIq+vmEvdTU
	cXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=3dRX2ZVJjnc63D9aV1WFofCsH5TIO9/qmrOMac70/Y0=;
	b=Ad8uuNGt4bAoqM83YzsjdKsw7XN73Y7+0t4Sxgu9AcW4gLActZE7aoz8O0unaq5Ghe
	TFOCYkKRBFHJhA9T1IFh3rFnxIQ701ynsJ9QgctcVvNY1sgWZ4soIRHDSrzj0/J4xiIY
	1x+NW5cWPUB0M1l4rIR4RqCZ/JT8GpJEhWxLOqy//qkjfqOQv8bRxqVA3uizN4SpzV8D
	+MUNq593Mm6/m1zEoAyRJHnZWFT57j5+25fv+hbxPDizyjevfY5apkXTm+THuoZYxXAw
	9rZPFE/x3I28UZn6wdY/XWgM8evckA1tlAYqM7XsiJhFxA0iTydaoRhfdtMGIqlPTH/P
	y6YA==
X-Gm-Message-State: APjAAAWxBRVHJnF+1HrPaonShyO5a+qp8oJov4IsBjfDuki6Qag1xUt4
	mtxpnmSIC2g0gCXhKY5+ASlCmeLMe63VZ+CLCqZbVg==
X-Google-Smtp-Source: APXvYqwJoJJtc0gFMOpn60ytpIkKUVjJqCyJlEcQOOvTuwZoLqBG6rjzaqy8+zBVglrjRMMZ3SfXs28Mgtch/2V7wF8=
X-Received: by 2002:aca:e054:: with SMTP id x81mr23158378oig.146.1555429098311;
	Tue, 16 Apr 2019 08:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190416142802.11990-1-kwolf@redhat.com>
In-Reply-To: <20190416142802.11990-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Apr 2019 16:38:07 +0100
Message-ID:
 <CAFEAcA_=qyZZLj2sVacnCP0pEpkzSVwsA5YKk6VhB+0Z4HvPvg@mail.gmail.com>
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::22f
Subject: Re: [Qemu-devel] [PULL 0/1] qcow2: Fix potential corruption with
 external data file
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416153807._Fe2Z8KGEKbSwEqkuVf4iFwyQZ1mLGgmVGIoDzfGXvs@z>

On Tue, 16 Apr 2019 at 15:28, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit a9b305ba291fb74f7ff732b3d7b8f4c812431ddf:
>
>   socket: allow wait=false for client socket (2019-04-16 10:40:43 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 93e32b3e2012a668e4da1c2566d2935c24060435:
>
>   qcow2: Fix preallocation bdrv_pwrite to wrong file (2019-04-16 16:23:24 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - qcow2: Fix potential corruption for preallocated resize with external data file
>
> ----------------------------------------------------------------
> Kevin Wolf (1):
>       qcow2: Fix preallocation bdrv_pwrite to wrong file

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM

