Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFBEC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 11:39:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C850208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 11:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PlCIeRrb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C850208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48714 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZDDH-0007lI-LA
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 07:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56898)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hZBdZ-0006Vo-Ic
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:58:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hZBdY-00025a-1a
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:58:17 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45242)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hZBdX-00024w-SZ
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:58:15 -0400
Received: by mail-oi1-x241.google.com with SMTP id m206so998245oib.12
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TfQzKcyg1PVpT8m6wVBob6f7bCfHtbYg2TNpRuAV0j8=;
 b=PlCIeRrbxf/MgV/xAvmHE55XadSPPiGi69+uallc2hJqc3eotwX9+m4IbPbGkm3Ydl
 x094Yb3b8PP1sYemiWCDoLyK4ZaFudUDNhVeOv14qCa8LURqm3CAC33f2SXfzXpCTvFm
 fPNoKcMZ6bee8tfPOKotOsoHykhEL73iLt00+izLBbGTs3whQNY1F3oz1f6ygixm7z75
 SL58f7dag7zNpIZ0jxwo3wL4G1hxQdgaYfPhZJr89dslQi7SJ0icnnqprL1Bs557yHWb
 YOlvHtkl3hvOTM6JJ6GlMYHkGUd5zm6bWpxaD9mEMWMSbHwEy+zfTfoSImu8lHOzU9U+
 Fs+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TfQzKcyg1PVpT8m6wVBob6f7bCfHtbYg2TNpRuAV0j8=;
 b=VKWGHjrK8YtuRz00H7MNQYOtKg45bPtU+1S4Q/Q+qn4X4u2kSm5uwVtfeI6w0rZIk/
 1GBZ1Hh+C6WQEIiImVuvOBEKWCDJMaoFaGsWj2/y0b2wptZj2FCusjyyitqE143DMwhF
 LfjKpMkKMc4WnQzL8BfFqr5TrHvnV2QlyoAH/0ca8D8OqAlKw/ki12cAXT1ysy1yJYpu
 xC8Zp4uvVq5wWihzL2YFPI/0JNqwPvIcBUfwOCEhCXwOpbuVKYDq+wDso3d0g3EJ5OnC
 T9ZRRdaXzfXiqNLiMWqcLWCG4ip2jn2G3JvKJSiVN3Wuf3WQ/hyMBysnI1JmdR8iAatJ
 MaGw==
X-Gm-Message-State: APjAAAW9PwaK2tD5h7SsJHj8p/oEiwNeYrzJNYR4QSvQr3Qz2N3bDP68
 k3GhrYTWyJSldslGWOLqW2rzRJXH1dncl88aaYTaAA==
X-Google-Smtp-Source: APXvYqxHbBBSyR1T5qsrTjY4+HjpSbe/sMmnEgJhOAICwSctI87uu6VMa0IFWp98HpKEoCBo06n0tMuq8DNmxyMHDPY=
X-Received: by 2002:aca:c786:: with SMTP id x128mr3117105oif.146.1559901494948; 
 Fri, 07 Jun 2019 02:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190607095237.11364-1-cohuck@redhat.com>
 <CAFEAcA8FXh-jPMwpGN-4ES4v=nE4ZOSNB8+rkdB03E=BBDh-jw@mail.gmail.com>
In-Reply-To: <CAFEAcA8FXh-jPMwpGN-4ES4v=nE4ZOSNB8+rkdB03E=BBDh-jw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Jun 2019 10:58:03 +0100
Message-ID: <CAFEAcA9hMt4TZC0DEzJ6JTV9OxLbXZbmHKshWv_20sLxLw4M6Q@mail.gmail.com>
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PULL 00/35] s390x updates
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Jun 2019 at 10:57, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 7 Jun 2019 at 10:52, Cornelia Huck <cohuck@redhat.com> wrote:
> >
> > The following changes since commit 47fbad45d47af8af784bb12a5719489edcd89b4c:
> >
> >   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-06-04 17:22:42 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/cohuck/qemu tags/s390x-20190607-1
> >
> > for you to fetch changes up to 39f04d18406862bd98d6bef5415dbe7360c652de:
> >
> >   Merge tag 's390x-tcg-2019-06-05' into s390-next-staging (2019-06-07 11:38:42 +0200)
> >
> > ----------------------------------------------------------------
> > s390x updates:
> > - tcg: finalize implementation for the vector facility and
> >   add it to the 'qemu' cpu model
> > - linux-user: properly generate ELF_HWCAP
> > - vfio-ccw: support async command subregion (for halt/clear
> >   subchannel handling)
> >
> > ----------------------------------------------------------------
>
> Hi -- this fails to link on the windows build for me:
>   LINK    s390x-softmmu/qemu-system-s390xw.exe
> hw/s390x/css.o: In function `sch_handle_halt_func_passthrough':
> /home/petmay01/qemu-for-merges/hw/s390x/css.c:1213: undefined
> reference to `vfio_ccw_handle_halt'
> hw/s390x/css.o: In function `sch_handle_clear_func_passthrough':
> /home/petmay01/qemu-for-merges/hw/s390x/css.c:1223: undefined
> reference to `vfio_ccw_handle_clear'
> collect2: error: ld returned 1 exit status

...and same link error on OSX host.

-- PMM

