Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468FEC4649B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 10:53:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7D3F216E3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 10:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s+4wTve/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7D3F216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjLqc-0004gq-SI
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 06:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59830)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hjLpS-0004HO-1S
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:52:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hjLpQ-0004bv-Pi
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:52:33 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34374)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hjLpQ-0004XK-IS
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:52:32 -0400
Received: by mail-ot1-x341.google.com with SMTP id n5so8669062otk.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 03:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=s9m8SkKZNrCygBnm5ajgKd3iqwTp3zz9Uvroz0OzYng=;
 b=s+4wTve/cMw+UDeUP/dsJW300Lc3kXpLRJGH4XaSThomH8J7TgXmUsZrAm+s7rAh3V
 G4bX8f4Rsl3ydF/hG7EYJlaNQfy0VyQbK4NIA2pXpZXY6j2BY4c5uNr99PAaoMGU4bKm
 qrKQpVlb/rBMJcIhSQAAlhNj2/zm/ison8iZ/cbzwhGw1o5TP/LFkfZiIBeJ/3sKLH+W
 Wq/64WnEhUAaNIBFZKHMSh0NteLSgu00RnAV02ZrMivHYmVLkUkR06sV2x8mMWFxcRSe
 HHLUFN56fI8ts/qh5vflREqvOjeRfZCb7+AU6dvVOAp/NpC3TygUMGyPUxfGUJrpMQ76
 +Rjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=s9m8SkKZNrCygBnm5ajgKd3iqwTp3zz9Uvroz0OzYng=;
 b=bDXp9zabdXO4eU+URbEyiz2QPwYzqi0FsbUvgsvhrXtiZv9v+FKOanaRtsqBANiSzZ
 X0PZR2UcYCHCK9X6MGu5Pjd3qEtRVkUws53vkY6H/gsyJjrpE4wtGH1y45G2UDKnc2+U
 4RaqOpuQzesizxwLiWTAb2shMWIgNtZ66WQs0fqxvTGR/vEn02dJLhQPVpO3liWIRGeV
 Cmgqyo9kFqWQEAfSjpsDYbVsse3S2SP/R76yQGMJ96nUBUp7dr/ic5Nib1k2wG1+jjle
 gmTlYRcVb8aUd2d/cNLPMJOIotr+clBkefFO/HpgKzHLtVYJRpJ/tR0W141j/gjtsz6G
 Jf6w==
X-Gm-Message-State: APjAAAWnXTWw/xH5/1WkOU+yzU4fI6J/+U7+mk+jR27bxth9zBTp729S
 6gUArah7czcuEHbkglZZnZJFQtAVq37V4O+edQNgtw==
X-Google-Smtp-Source: APXvYqz+pDQVvaDuCXxXmMhUJkytRfZSlXppccDQx3X23gOwOUCOUZCi2xRo8U3vnzze7fpkfL+j1b4aNxZFU1yayls=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr2150035otj.97.1562323951083; 
 Fri, 05 Jul 2019 03:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190617043858.8290-1-kraxel@redhat.com>
 <20190617043858.8290-10-kraxel@redhat.com>
 <87zhlsvkx1.fsf@zen.linaroharston>
 <5d0e35f4-964e-e6e0-d644-ea19fc9cd029@gmx.com>
In-Reply-To: <5d0e35f4-964e-e6e0-d644-ea19fc9cd029@gmx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Jul 2019 11:52:20 +0100
Message-ID: <CAFEAcA9yGCXB0XTNeZwzKyX+WtMNjG2s-RPRSc6GSOLN0nh6fQ@mail.gmail.com>
To: Kamil Rytarowski <n54@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v4 09/11] tests/vm: netbsd autoinstall,
 using serial console
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
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Kamil Rytarowski <kamil@netbsd.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 5 Jul 2019 at 11:43, Kamil Rytarowski <n54@gmx.com> wrote:
>
> On 05.07.2019 12:24, Alex Benn=C3=A9e wrote:
> >
> > Gerd Hoffmann <kraxel@redhat.com> writes:
> >
> >> Instead of fetching the prebuilt image from patchew download the insta=
ll
> >> iso and prepare the image locally.  Install to disk, using the serial
> >> console.  Create qemu user, configure ssh login.  Install packages
> >> needed for qemu builds.
> >
> > I've had to drop this from my v3 PR as Peter was seeing a very
> > slow/hanging install when running his merge tests. I've tried to
> > reproduce and I see it stall while installing packages but nowhere near
> > the delay Peter has seen.
> >
> > Any pointers on how to debug gratefully received.
> >
>
> Does it use virtio? There were performance issues with virio disk device.

The symptoms I see with this patch are that the VM appears to
completely stall, rather than progressing but slowly.
(I do also see on the current NetBSD tests/vm setup that sometimes
'make check' runs pretty slowly, but in that case it does make
progress, it just completes much slower than either the openbsd
or freebsd VMs. 'make check' is not particularly IO intensive,
certainly not compared to the actual compile phase, though.
And sometimes the initial "wait for VM to boot and ssh in"
phase just hits our 6 minute timeout.)

thanks
-- PMM

