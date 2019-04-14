Return-Path: <SRS0=wjfX=SQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B1AC10F13
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2019 18:14:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCFA0206B7
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2019 18:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ua5ArwJE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCFA0206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38613 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFjeM-0000Wh-24
	for qemu-devel@archiver.kernel.org; Sun, 14 Apr 2019 14:14:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hFjcZ-0007rP-L1
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 14:12:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hFjcY-0003bx-H9
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 14:12:51 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:47058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hFjcY-0003bL-A0
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 14:12:50 -0400
Received: by mail-ot1-x341.google.com with SMTP id s24so12540190otk.13
	for <qemu-devel@nongnu.org>; Sun, 14 Apr 2019 11:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=qfFArth8MuA38PJT7ObzDekzJhUIbFwv4ir1LVT9OLY=;
	b=Ua5ArwJEyRA6QQeZjHjM3Vh+63AYsoR2xYxL6GZZG6QOwrY5v0ZPA0UZxMMIxgdhkQ
	EpBcchgQv+w4ZbEpbH/H6XpFS2XRXBdUmUYtHZ9FJBOLlGDWhVE6k70WCJcsrlKEstH0
	nzlGWreOTiMa6dnmNhjCxsi/+oVTDqqMuwhkl/brUuGazC2+d6v2qzszYtThs+/PeNRK
	jWANJNGySNop/0SdFLfrwd5D6ahgLHYdXw/nukzxInu7009C24yESU7Xl7vEzP8sdC2V
	MP1838yWs71zpbHmH1Gp6ktycHZAyGOA/oNI7omdKPikfucIeyGsVUb9tHpYeo4ztykx
	KFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=qfFArth8MuA38PJT7ObzDekzJhUIbFwv4ir1LVT9OLY=;
	b=NwfGoNMCny38VA3xPn3X3mwqCRZRytBROrh8DRD6mIhBrIOP5RVCOMPc3CvgzyWm4d
	4Gif1VJyW6eO1ChGn36hZteDcDu40iu7g5imi9tOK3/kLEC9FNKz/zHc6UbY9+uiTbUV
	ac1/lF0Ygs4/H5zRH77DjMG9DJ0ZCE0rC0JYtIjAa96a9/bQCF8ym/0lx+ymcpzm5DSg
	RsbpJ7qjlpLtUxLNY6Gu0wbCLPsvzhWqvnBIvxEI0qjby8cunLdsbR7fu3c/9v2o6sIT
	7/tWefG/DaUOQvm+kQSIW5QNMYvM5p1rEzSyF2C1Avv/ZYTX95s0AVqXNGl5yTgsChC1
	4fjw==
X-Gm-Message-State: APjAAAUojLfhI2i134OyHSt8F34LxAYvrgzvWP6kPkgQWUWimKOEr9YT
	hVOVwNg7TJYnThLEOXq78jpXQXaIecVo8WkDu90qJQ==
X-Google-Smtp-Source: APXvYqxIULwGaLQ3Ia0ybMjYnHxzIrU5YTmv7gnTjeklCTjNNhDY46YLugu0nmXyNzINrGGixw9s5s3DkeggwUqw4nw=
X-Received: by 2002:a05:6830:164a:: with SMTP id
	h10mr45679550otr.323.1555265568961; 
	Sun, 14 Apr 2019 11:12:48 -0700 (PDT)
MIME-Version: 1.0
References: <91dddf37-77fe-79c6-59f5-4e60d45c3c7e@durchholz.org>
	<CAMo8BfLEEF2_FVU88ydBWVmcRbCJ9T0ULrDEKRa-+hmCYo9cmg@mail.gmail.com>
	<0492144e-fcd1-c013-2211-fbc31a17ce2f@durchholz.org>
In-Reply-To: <0492144e-fcd1-c013-2211-fbc31a17ce2f@durchholz.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 14 Apr 2019 19:12:37 +0100
Message-ID:
 <CAFEAcA8vUhuEbtLnmOxui3K_UW8eOET3xbWap3E23EWeGzqv7w@mail.gmail.com>
To: Joachim Durchholz <jo@durchholz.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] How to I trigger a rebuild?
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190414181237.83PB_y3-jf1XtFrrG7_u1JdmODKa5Wdu_w79k1S8gXU@z>

On Sun, 14 Apr 2019 at 17:08, Joachim Durchholz <jo@durchholz.org> wrote:
>
> Am 14.04.19 um 03:15 schrieb Max Filippov:
> > On Sat, Apr 13, 2019 at 8:28 AM Joachim Durchholz <jo@durchholz.org> wrote:
> >> I did the usual ./configure; make dance.
> >> Then modified a source file (ui/curses.c), called make again, but didn't
> >> see curses.c recompiled, and the change was indeed ineffective.
> >> make clean; make didn't help either.
> >
> > Perhaps you don't have CONFIG_CURSES enabled?
> > Did you call configure with --enable-curses ?
>
> Strange. "make help" tells me that everything is enabled by default if
> possible, and I didn't tell configure to do anything specific.
>
> But I find that curses is disabled indeed.
> Heh. An explicit --enable-curses tells me it was missing the dev version
> of ncurses.

Configure's default behaviour is "enable everything that we can
enable, but don't complain about not enabling optional features
which we can't build (eg because of missing -dev libraries)".
For "insist that foo is built and error out if it can't be done",
use "--enable-foo". For "definitely don't build foo even if we
could", use --disable-foo.

> However... even with curses enabled, "make" does not do anything  after
> modifying ui/curses.c.
> In fact, just "make" tell's me I should have run ./config (WTF I did??),
> and "make all"
> But after ./configure is recompiles everything... nothing of this is
> something that "make" should do, so I'm pretty confused.

This sounds like maybe you got confused somewhere along the line
about whether you'd (re-)run configure or not (or didn't
do a 'make clean' after running configure with the curses
support enabled).

The other thing that might confuse you is that make will try
to spot when it needs to rerun configure and will rerun it
for you.

I recommend doing builds only in a separate directory, by the way:
 mkdir build
 (cd build && ../configure [configure args])
 make -C build -j8

Then you can always just rm -rf the build dir and it doesn't
leave stuff lying around in the source tree. You can also
do multiple different builds with different configure
setups without having to do a complete build from clean.
(If you've previously done an in-source-directory build
you'll need to 'make distclean' it before doing out of tree
builds.)

thanks
-- PMM

