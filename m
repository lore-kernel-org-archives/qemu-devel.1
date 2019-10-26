Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7313CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 09:14:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4B00206DD
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 09:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sHqFSjQJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4B00206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOI9O-0000bv-Q5
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 05:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54676)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iOI8c-0007O6-NE
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 05:13:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iOI8b-0003jO-Cq
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 05:13:34 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:46616)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iOI8a-0003is-6f
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 05:13:33 -0400
Received: by mail-oi1-x229.google.com with SMTP id c2so3149950oic.13
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 02:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=z+R6I5Bucm1WWx5M0wVgBbnsTt989/qZAMSmjWjUg+M=;
 b=sHqFSjQJPLT15Olm8Y/5M7wkBn5Ig9Ju29GKzjASnUh5kdDzhXNLglEz7uvecI3p31
 9t1c2nVBISPEVANiVlUrDIfduD9srII/QwwCv7D0GEIRrb4aVQoqtBbMcIgnL8v3TMBp
 qe9s8bARRdF0gDlwYBwHbBFxx5Aeks5O/qrn41fOzj7k3FAbjvw0CExQoD34thkz/M53
 2vDSI6Y2SSbs9ViN7ZAPXyRsbDgIG6vkpAaR8RPBMLSM1YK8+S+NLk/vbk+6e6jo8c1G
 9o/uwZsKo5H10Z7YgQxaxhWP0WN+uUk8d4XO4hMpvfLjuq8kUezgNHNW59+xsuxlkq9O
 4TAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z+R6I5Bucm1WWx5M0wVgBbnsTt989/qZAMSmjWjUg+M=;
 b=b3brB2l6p5U4AhLDRz8hZlhGyN9eZcUDGTVw1zIAJXzuekrUEYMwa+ZkLgAPZcuMKi
 J0a9oam4bLWm/rD0qd4iU5b7eA7EvDsW+1edUHhPieSgUms0/3pC63rEJnwhDl2TLdQb
 eYBZ8BrPtlrGBczDGtUFdOx8zq9r1wCngzFokkL4dh/0chBOT7RrVtnkjkNPEEjAc2TE
 /rCbDtmqBXnZv9ioDbzRLBVbGuYUK9KQmOif3QcUT2Tei5IgJtWjoyOJdcdqUzn+rw+P
 ZbNDXrD9pJW5+JJhHHmyFzEDvc5KpOqYoC2OB3Aj2Q44uQpTCHLpNbuj2kDlbRTmRMee
 P/Tg==
X-Gm-Message-State: APjAAAVd86hCyDsFrrNxtEYsZlhZ5v98/Gert7l5SWR8cvsSMXfvW7xO
 PY+R19vcKyuCxA9ZqOC9mxQFYGOvUuLNvl4ktN69Cw==
X-Google-Smtp-Source: APXvYqzd/QXQ1PelulvUKRYB/j36Gn0ZQOXVQ9DW8CeXKv3TcwGYHapP9+L9CihYHb3Ga84mwn+JTneEkLyKq07E80o=
X-Received: by 2002:a05:6808:7d1:: with SMTP id
 f17mr5737292oij.163.1572081211139; 
 Sat, 26 Oct 2019 02:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <20191025191839.1215-1-stefanha@redhat.com>
In-Reply-To: <20191025191839.1215-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 26 Oct 2019 10:13:19 +0100
Message-ID: <CAFEAcA8OTFq=huMCZDMCUiahOg1qT5w9KeWEr6cEYkKHYkUcqQ@mail.gmail.com>
Subject: Re: [PULL 0/2] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::229
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Qemu-block <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 25 Oct 2019 at 20:18, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 58560ad254fbda71d4daa6622d71683190070ee2:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.2-20191024' into staging (2019-10-24 16:22:58 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to d154ef37ff885918fa3e512fd7a8e42870291667:
>
>   yield_until_fd_readable: make it work with any AioContect (2019-10-25 14:38:29 +0200)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------
>
> Dietmar Maurer (1):
>   yield_until_fd_readable: make it work with any AioContect
>
> Julia Suvorova (1):
>   virtio-blk: Add blk_drain() to virtio_blk_device_unrealize()


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

