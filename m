Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B97C06513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 18:41:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D24C2184B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 18:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kGh7MueM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D24C2184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiNiV-00015N-I6
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 14:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60618)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hiMU0-0001uk-JZ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:22:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hiMTw-00065P-KC
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:22:19 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34967)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hiMTw-00063j-D3
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:22:16 -0400
Received: by mail-ot1-x341.google.com with SMTP id j19so18001124otq.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 10:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=q+CN6YBqnmrRrZoHgpVK5TMPU5z9BgHXPKy2dfZMNWA=;
 b=kGh7MueM4eFqxlXkV7JwtracJckX1z+xc1+oNJi/rfsVsnYfkwRinG3m97oI9Sftn6
 /OnCw/JoyHZ82eaTJzsmrlkhLD34G83rU4aliqwYa+9ceSf/o3WDl7Q5GFA/f/cfIEbq
 ZkY5DWnhLd8adj3hhTt3SZPsav0ZWEuvXD9vc2JfYEd4S9HY5Mq77oX1QCe/U3f/f31P
 82VubsFm2t9CmrojatcmX2vHdbsHa0DlXtG1YlDQxbTDIBGQO4STC4fOMm67uJJ3jt6v
 F0kVf+qQAFbdcv9y0ZmbxbtMPgJf5/mSKwpzVJReG0uUM5l/NDBY6EnOB4kHHM6bNJGa
 MT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=q+CN6YBqnmrRrZoHgpVK5TMPU5z9BgHXPKy2dfZMNWA=;
 b=EbPfvbBXVjZ5EIqrUtF3KMejqv/mF2c50aMdxlPoylEPktPFjHyVl/TV3woO5dUpab
 MNkUTzKwfIQE8eWuTzg2+SDi8NNoJNBB4M9AeZEvj5MpQ8XtlZo6HhkCOko5RKABmd0t
 7iWUZLVFUnX9Wr29CgUBKdd9DKt3f67WT3sYcCtpVZWNP0ARGem5Ev9Cy1LDljiD3TRA
 W39NxkTTKxwWT1pvJALXo5pCJbHjGc5iWDg++ZrAxL2xgAnxxiGj5m3alkiRGSVhBfzk
 R8+x+OA2Pv1ZDisnwS0GKRU2zdFOkmAJW/o0KyfQ/fXcYihe9ENywW8hVnixhBw/rX66
 ZTFw==
X-Gm-Message-State: APjAAAW4g6a4eQtx3pJx7PwaZgl4CHEbdXlAjXfR6oda4S4oBpguRgkD
 a0v1rwmg0mCtgQ8qwH5mZzIcPDaSjzTXuv8W/2rASw==
X-Google-Smtp-Source: APXvYqzhGJxGzMkyQQCP9Pcg+D3mFtaZbqITjpJ7jiQ28nZ/raL5xWO+9tNwsXBAVc+0yHMUa95tg8CjprJUaWj7L74=
X-Received: by 2002:a9d:4d81:: with SMTP id u1mr3152276otk.221.1562088133123; 
 Tue, 02 Jul 2019 10:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190702023905.32470-1-mreitz@redhat.com>
In-Reply-To: <20190702023905.32470-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Jul 2019 18:22:02 +0100
Message-ID: <CAFEAcA8O_6QpLDerPZspOzD+Jw2YOpKC4uVoXwVjgXdRuMaaPQ@mail.gmail.com>
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PULL 0/4] Block patches for rc0
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

On Tue, 2 Jul 2019 at 03:39, Max Reitz <mreitz@redhat.com> wrote:
>
> The following changes since commit 7d0e02405fc02a181319b1ab8681d2f72246b7c6:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-patches-pull-request' into staging (2019-07-01 17:40:32 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/XanClic/qemu.git tags/pull-block-2019-07-02
>
> for you to fetch changes up to c624b015bf14fe01f1e6452a36e63b3ea1ae4998:
>
>   block/stream: introduce a bottom node (2019-07-02 03:53:05 +0200)
>
> ----------------------------------------------------------------
> Block patches for 4.1-rc0:
> - The stream job no longer relies on a fixed base node
> - The rbd block driver can now accomodate growing formats like qcow2
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

