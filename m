Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17372C433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 11:55:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D873F20B1F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 11:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OyyL95zn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D873F20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huy3U-00069a-3t
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 07:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58507)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1huy2N-0005TV-OT
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 07:53:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1huy2M-0007sN-Jt
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 07:53:55 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:34745)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1huy2M-0007r9-EU
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 07:53:54 -0400
Received: by mail-oi1-x244.google.com with SMTP id l12so5484718oil.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 04:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wxjaPebcCxHz/LrJepfjlmo5iZ84lw+rqD3whYvUk9Y=;
 b=OyyL95zntFq0trUgwhLtcttLhEX7GXYTFgMtB9iaQsrN2FPKeySoxuDN0HRN9xJdEK
 BBmty5NFpUDUdk8TGYmGTvT+/WtZ6ZxURmFMNiNeN96ajAWOB4t9A0o7wY0WP2CmpUKk
 VX0ncLgXM05X+GQin2+NFWPnoGG+W/tLk980031ToZpD2ZTSsVonCuEXtsTaVPRxHsiY
 632QVTu9SbaPXML9ahCx1Gb/M4YHWsqKvfTr8wNzPfeQiKXqqYze8EQ/N3M5/cLzbEka
 y9ACk0JCw1nYobNC21/Hga0kWGJbGoKUNIWWlFRO4ujsQmuZoxpJB5D2Mp7DtdhZk86V
 wYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wxjaPebcCxHz/LrJepfjlmo5iZ84lw+rqD3whYvUk9Y=;
 b=PMUeCACyypgv2pcBQYYFw3g5GX0LRduS6UOF2I1YmEIZ8jTGEOJAwXb1Cf/nqGbmep
 5CjK4jnOy7v44/wS7l5ZDh7QbnOiG2ixk6ZAzPzTPAqqJs+pSwzYZ/d0WTTIq2Eklpk3
 RtEKiWV5Oa8h4cbeyyS3wkgMG8ZDF89+yViTB3mb3rVQIdSGZ23nKa498tXfvfXLwc1P
 FUwEYIf42A8Ze4BiSWpuMZrTGZqlw5VQaA8FtEbmlUxZp3x3zETW0allkHog38adyfCs
 yO0vvd6ZS2Kv8B3Jpm1eLpM2BUH1KcB5i9vKAdgC2XoAZoUU35DyzhykjAMJ1dVQkyUn
 XiRQ==
X-Gm-Message-State: APjAAAWdaiNh836kEHPvBUEAyKVKRT6CpCyDD65CdLYhFg+a3swFlCb3
 gJBxtkXFXAWuhcQXOrO12pw3x4XUlbD1eXgmUxyWRA==
X-Google-Smtp-Source: APXvYqyzMApIJdI4zNulTt22GPDGMn5ObRMD0iwKJGKAi85byAbr3/m5w5a43MDnddRyA+J+zDkrKw1m+qjBN93hgW4=
X-Received: by 2002:aca:4bcc:: with SMTP id y195mr2037327oia.146.1565092433179; 
 Tue, 06 Aug 2019 04:53:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190805163740.23616-1-mreitz@redhat.com>
 <d7a1adf8-d0a2-dead-b8d5-2576d9b05f47@virtuozzo.com>
 <3a38f834-7759-fe3b-c5e7-d6232dc04e56@redhat.com>
 <CAFEAcA9yBJWkg7a-4LJx-xOFrVON=5y5Tp+OOdf2pwCBkbWjXg@mail.gmail.com>
 <b4a2d9c1-a4ad-939b-64f4-c639e5bc4063@redhat.com>
In-Reply-To: <b4a2d9c1-a4ad-939b-64f4-c639e5bc4063@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Aug 2019 12:53:42 +0100
Message-ID: <CAFEAcA_BiNUZ_R4tX39hKMExBqMBpB-vLGeeDZ+0xwNRsehLEQ@mail.gmail.com>
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PULL 0/7] Block patches for 4.1.0-rc4
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 qemu-stable <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 6 Aug 2019 at 12:12, Max Reitz <mreitz@redhat.com> wrote:
>
> On 06.08.19 12:12, Peter Maydell wrote:
> > On Mon, 5 Aug 2019 at 18:01, Max Reitz <mreitz@redhat.com> wrote:
> >>
> >> On 05.08.19 18:59, Vladimir Sementsov-Ogievskiy wrote:
> >>> 05.08.2019 19:37, Max Reitz wrote:
> >>>> The following changes since commit 9bb68d34dda9be60335e73e65c8fb61bca035362:
> >>>>
> >>>>    Merge remote-tracking branch 'remotes/philmd-gitlab/tags/edk2-next-20190803' into staging (2019-08-05 11:05:36 +0100)
> >>>>
> >>>> are available in the Git repository at:
> >>>>
> >>>>    https://github.com/XanClic/qemu.git tags/pull-block-2019-08-05
> >>>>
> >>>> for you to fetch changes up to 07b0851c592efe188a87259adbda26a63c61dc92:
> >>>>
> >>>>    block/backup: disable copy_range for compressed backup (2019-08-05 18:05:05 +0200)
> >>>>
> >>>> ----------------------------------------------------------------
> >>>> Block patches for 4.1.0-rc4:
> >>>> - Fix the backup block job when using copy offloading
> >>>> - Fix the mirror block job when using the write-blocking copy mode
> >>>> - Fix incremental backups after the image has been grown with the
> >>>>    respective bitmap attached to it
> >>>>
> >>>> ----------------------------------------------------------------
> >>>> Max Reitz (5):
> >>>>    backup: Copy only dirty areas
> >>>>    iotests: Test backup job with two guest writes
> >>>>    iotests: Test incremental backup after truncation
> >>>>    mirror: Only mirror granularity-aligned chunks
> >>>>    iotests: Test unaligned blocking mirror write
> >>>>
> >>>> Vladimir Sementsov-Ogievskiy (2):
> >>>>    util/hbitmap: update orig_size on truncate
> >>>>    block/backup: disable copy_range for compressed backup
> >>>>
> >>>
> >>> As I understand, this all should go to stable too? CC it.
> >> Ah, yes.  Thanks.
> >
> > Are you planning to send a respin with the CC:stable tags?
> > (I did a test merge of this version which all passed OK.)
>
> I thought Vladimir just meant to physically CC qemu-stable on the series
> (which he did).  Should I respin with the tags?

If you could do a quick respin that's probably most reliable --
I'm not sure exactly how the qemu-stable process works, though.

thanks
-- PMM

