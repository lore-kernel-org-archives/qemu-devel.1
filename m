Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2794DC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 17:45:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECFE6206B6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 17:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zHYpBfPy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECFE6206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39503 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSmLu-0002Ep-5I
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 13:45:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hSlmU-0004Qe-TA
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:09:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hSlmT-0004S8-7t
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:08:58 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:43261)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hSlmS-0004QH-Jj
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:08:57 -0400
Received: by mail-ot1-x334.google.com with SMTP id i8so13643910oth.10
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 10:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=SgE2AMvWBHVKOffOws4dRNRkNqPzU98MET8fUXMY+VI=;
	b=zHYpBfPy7Q5hvOHn2jGck1mriKXaoRJEATHyirTs4c5oROAjjDMkdNMEQWryxrBaVo
	SeMd8tjN+GieiMy0DnuCXJsDq+d8CL3ezn5p2FAIeQZjiq76sbwPa63+oUNxYnsXDSuP
	VRZs61hh9SiIwzhmpfwgEboS470LXwhzqTQljt+xfhOjQwDmoFm9k4+FGxBWruA+8GFI
	9tlAecug0nG7R4Bi56xd/+PlT3SfVDn0g6iRpX6hYsZ+qEE7qQaUbtANiPU+u6QFF52K
	wyG47CJqt4jKjMjYzxxJFZGeCAtU3UJ1LUAIfgKh8qMM/9KJB3v1kK9cIR8EhNhBWniN
	5B6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=SgE2AMvWBHVKOffOws4dRNRkNqPzU98MET8fUXMY+VI=;
	b=tHEX/9/JOF8fU9/H3H6D634Dn+6LK+ISKkWWHvaw1F2+F5FMJ2ZG0Ly/Ixnfjgk9U2
	PQPUxZKZ4jD2XBTYpWgUcAI5ln8Nfmjp7qkjSa7M1Ao7uAg/Tu5IURDmWH1w1AFP8VWE
	ozB3RIj9JhWtmCb/vsCL40czZ6od+tkSREKt2OlsoY3EoLV3pRfNop+G3lFKjx4eHyrk
	brqEUXj1skq9yafpyOHF80JDzrkUzYQWPV1R/bg4XdhFDWTU4ulCFzujU3SDhkAm2K2Q
	HNZWQ1fjJwO5mkYaQ4v4s7al2ZreMPfvZbrSnPxyMs05TQv0vpE2YfN/VtffOAnuPijh
	xuBw==
X-Gm-Message-State: APjAAAW/ZAel78S9KnDzCXF0AC97Vs4mjFuvBdRpNcBVpNW596GMI2Pa
	W4Fk6/BsX9DWK78jLyIRtYIIAR3L16bQFSJJeagdgw==
X-Google-Smtp-Source: APXvYqzq8rMJ6mrn1EpYAdgzPfkQWWhUFjPrT5OylkuVwR8gguyLBxKeN3hPlzgECuvj5l/5oms3xAVTEnyDnY80Edc=
X-Received: by 2002:a9d:77d5:: with SMTP id w21mr281507otl.97.1558372131590;
	Mon, 20 May 2019 10:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190520161453.30723-1-kwolf@redhat.com>
In-Reply-To: <20190520161453.30723-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 May 2019 18:08:40 +0100
Message-ID: <CAFEAcA8YxNj_0-fupAbDxP2hv3=esqLG0B0-FY6yUkARz8K-JA@mail.gmail.com>
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::334
Subject: Re: [Qemu-devel] [PULL 00/24] Block layer patches
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

On Mon, 20 May 2019 at 17:17, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 6d8e75d41c58892ccc5d4ad61c4da476684c1c83:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-axp-20190519' into staging (2019-05-20 11:38:36 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to c423a6af592cf36b4f149c54e2966dd0016b7e96:
>
>   iotests: Make 245 faster and more reliable (2019-05-20 17:08:57 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - block: AioContext management, part 1
> - qmp: forbid qmp_cont in RUN_STATE_FINISH_MIGRATE
> - nvme: fix copy direction in DMA reads going to CMB
> - file-posix: Fix block status for unaligned raw images with O_DIRECT
> - file-posix: Fix xfs_write_zeroes() after EOF
> - Documentation and iotests improvements
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

