Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7496C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 03:56:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F415206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 03:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6LY3fn5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F415206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33994 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLgLs-0002Qa-NM
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 23:56:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hLgL0-0001j2-HP
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 23:55:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hLgKx-0006bi-Fp
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 23:55:18 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:40047)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hLgKx-0006a8-63
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 23:55:15 -0400
Received: by mail-lf1-x144.google.com with SMTP id o16so12418351lfl.7
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 20:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=+xo5jvc/rBRh9ekPC+pCSkHWIimdbJZrueLfMiYvsiE=;
	b=T6LY3fn5XHcCJpAn0I1qFj39eeaT7HedxEP8C5WaI5eR5LkDwnH/E7cePzA/BeK4Jy
	Mf/pSfcVB3xmySkBGSiaLbDGDWTvM55OdhBfb+ZN5pinXsFIOY5izIHdl0i6QOmjtz9g
	bmTZJNJsUaorpLitq/m/1DJVt6FBcaGO51BMI2aGsuTyBXoHEv5RRMLyKO0yD/+eTwag
	s6taMS4Jyf2gX6zn/Flr9DTNgn35DwRQleOhM3COQuVItVhKpAHkUiI5O97r+K3N/+cj
	waWiBagy+nWG4VlqBkTG+OH8Os1lIiWafQY7kWk9HPWiLYot0eEQ27eF3Z46k2qv9T1u
	b3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=+xo5jvc/rBRh9ekPC+pCSkHWIimdbJZrueLfMiYvsiE=;
	b=EZbZy07KUGr5FhsP2R7Xc9I+qraERa+I+/oItZZYE0eXAlax/PuS26BHBHwma0AODR
	8Eq0uEfzaV+r1rcHlSF3uJsZko63uBRUjdqXznBuXio+0XO3X0IW8Vj8gxw5GcCmtj4F
	0+/VIyL8do+DbF/JbMgz8HyYUzAp3cPtZXV83FkKdEgSR3N7kVxy+GkkBXmBmdsUMIPq
	jfl38xAhPwjpXFcyYZ1oJG6unHCQK7R/l/GxQLgja6C2RQaFqNvpc1HWoUEBhNyU4Q0U
	UjntrC+SnqVkOtznHj77PFDdOE/k8XSS1aFGt5yWZ1g/WUynZV/pxc34A/Hej2ZGOo2T
	uYRA==
X-Gm-Message-State: APjAAAVJ+CWqpMYGxUscj5Mg5Y6zwzwhuzu5molyIEn0U0sN5Kv6Xhab
	OI4ePIhyGg/YUo3+4WotsXm6jzwxBY+j7pFdiJY=
X-Google-Smtp-Source: APXvYqz8w+SWTybd2q5sDR6Rb/eY+PaFM+0h7u9VxEeNL3Kh5zHb+WgkLVfdXUhLkHAJdy+so+xfplrqgU1mex/DwAs=
X-Received: by 2002:ac2:4205:: with SMTP id y5mr106863lfh.15.1556682913663;
	Tue, 30 Apr 2019 20:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556515687.git.alistair@alistair23.me>
	<PSXP216MB0277192E4A6C255E30EFE627DD390@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
	<CAFEAcA_rJT3NxMAyoVFCbxNi0vNfCRg1bhHTsOmd5pa1pb_DzA@mail.gmail.com>
In-Reply-To: <CAFEAcA_rJT3NxMAyoVFCbxNi0vNfCRg1bhHTsOmd5pa1pb_DzA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Apr 2019 20:54:44 -0700
Message-ID:
 <CAKmqyKPGkgYNntZV70pys3PvzdneWWsk=jMiWJQ6SpHCA8rUXQ@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::144
Subject: Re: [Qemu-devel] [PATCH v1 1/5] armv7m: Allow entry information to
 be returned
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
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501035444.nr0lT0_QtO8teopSbphpV_fRtnYPDbOsAwiefZgiF2k@z>

On Tue, Apr 30, 2019 at 9:04 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 29 Apr 2019 at 06:34, Alistair Francis <alistair@alistair23.me> wrote:
> >
> > Allow the kernel's entry point information to be returned when loading a
> > kernel.
> >
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > ---
> >  hw/arm/armv7m.c      | 6 +++---
> >  hw/arm/microbit.c    | 2 +-
> >  hw/arm/mps2-tz.c     | 3 ++-
> >  hw/arm/mps2.c        | 2 +-
> >  hw/arm/msf2-som.c    | 2 +-
> >  hw/arm/musca.c       | 3 ++-
> >  hw/arm/netduino2.c   | 2 +-
> >  hw/arm/stellaris.c   | 3 ++-
> >  include/hw/arm/arm.h | 4 +++-
> >  9 files changed, 16 insertions(+), 11 deletions(-)
>
> > -void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size)
> > +void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size,
> > +                        uint64_t *entry)
>
> If we need to return the entry point, why not just return it
> as the return value of the function rather than having the
> caller pass in a pointer which we fill in ?

There wasn't really a reason, it was just following along with load_elf().

Alistair

>
> thanks
> -- PMM

