Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DE6C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 13:05:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2A2920856
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 13:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tkm7ub0Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A2920856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35393 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hShyh-0007DI-8H
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 09:05:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hShxD-0006ZM-EL
	for qemu-devel@nongnu.org; Mon, 20 May 2019 09:03:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hShxC-0005l3-0A
	for qemu-devel@nongnu.org; Mon, 20 May 2019 09:03:47 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hShxB-0005cA-Hl
	for qemu-devel@nongnu.org; Mon, 20 May 2019 09:03:45 -0400
Received: by mail-wm1-x344.google.com with SMTP id 198so13212513wme.3
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 06:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=o8BzmYWwsSmpDO0IODzAjibHc/1QIz0ZyvNfpvYYa9s=;
	b=Tkm7ub0Y3rKmCvRqgHR5I78zX3thUVhgSTbJTe+U5y2fqdO8QB1JKtRBxfQ/C9pRuS
	fK5wjq125wL6zJM1GUHVagRloyDZ8RUX92DGPZY1YS+GI1Zku2FqQK6ThP+I/DmfBjkS
	hnXpnqYUuInhGodh1rSl/frS8IpruRrmi1429rt1dBz4i3nGPPEyVBCYbWRhLwAQ+3j6
	9PbZ0BHiphQKMMoZJjSSQmIw5dGgNY9FbjUhwNvVEFStVsAS/8or+OkzyTmJ4HFSmo3h
	ad1tcKcY2yVUWnJh5TNElRwrCQuntleqCuJmnvvh6CLptNtjNfDOWHiZvgWRcU41qFoi
	bdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=o8BzmYWwsSmpDO0IODzAjibHc/1QIz0ZyvNfpvYYa9s=;
	b=kuVUGam56xmb2fko42RglLdpVs+1XoW8mGx+cNgp859EFQ7UfR5I/mLUbH5AtgU4wM
	asnIhQrfjmxZKiUcImDJTnFa6fjwolfGJXYEYvi6AR98rGx4rX1ZI/FCL/825j30i5Z6
	N7sM2F6VyBmkj+S728eXuRheLv3mCNBce+BGBL07q2B13MCCRbeNQtRdakOUnt9f3Icr
	VeczhPit4Wn0VuV8/tE0aplb20bXVp20K5xPJ87GuQxhdXfKrpy09u34kSkhnZgJrboq
	RKapTdJ2W3cYPAp7aK7PypYBIWfCkRHmRis+JHWTF+ji+3DldaW1CD60DRLjfyAIvfoz
	WHWw==
X-Gm-Message-State: APjAAAVVe4EnZlkacUZ8fTqyYbdFbkAAZ9nDu6Gbgvf8fchMNVPhY9ix
	muULaC+8CWGYqWdIsz1m91n5rg==
X-Google-Smtp-Source: APXvYqxdI9dxuVt1uz4Cws99q3mlNUceL4FSrq7eZYXvQS2rEGZPuV0n7NNXQKxxmRpzVexb8lVptw==
X-Received: by 2002:a1c:ce:: with SMTP id 197mr2352325wma.48.1558357404269;
	Mon, 20 May 2019 06:03:24 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	t7sm21999110wrq.76.2019.05.20.06.03.23
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 20 May 2019 06:03:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 1C6261FF87;
	Mon, 20 May 2019 14:03:23 +0100 (BST)
References: <20190514155301.16123-1-alex.bennee@linaro.org>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190514155301.16123-1-alex.bennee@linaro.org>
Date: Mon, 20 May 2019 14:03:23 +0100
Message-ID: <87pnodgtwk.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [RFC PATCH 00/11] semihosting cleanup and re-factor
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
	Aleksandar Rikalo <arikalo@wavecomp.com>, riku.voipio@iki.fi,
	Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Hi,
>
> This collects together some fixes from last weeks RFC clean-up patch
> as well as a generalised version of the chardev console tweak I made
> last week for testing/next. As it happens it only really made sense
> for ARM and MIPs logging semihost calls but there is certainly scope
> for handling all the semihost syscalls in a more common way. I didn't
> make the changes to xtensa as that already has a bi-directional
> console-via-chardev setup and that would be quite a bit of extra work
> to support.

Ping?

Philippe has already done a bunch of review (no changes suggested so
far) but could ARM/MIPS people look over the changes I made to their
architectures?

> I've added myself to the MAINTAINERS section for the common code but
> my focus at the moment is really just to improve the use of
> semihosting in our expanding system tests. Hopefully this is enough to
> ensure future enhancements (common open/read/write/close?) can be done
> and easily enabled for all semihost targets.
>
> Please review.
>
>
> Alex Benn=C3=A9e (11):
>   semihosting: move semihosting configuration into its own directory
>   semihosting: introduce CONFIG_SEMIHOSTING
>   semihosting: implement a semihosting console
>   semihosting: enable chardev backed output for console
>   target/arm: fixup some of the commentary for arm-semi
>   target/arm: use the common interface for WRITE0/WRITEC in arm-semi
>   target/arm: add LOG_UNIMP messages to arm-semi
>   target/arm: correct return values for WRITE/READ in arm-semi
>   target/mips: only build mips-semi for softmmu
>   target/mips: convert UHI_plog to use common semihosting code
>   MAINTAINERS: update for semihostings new home
>
>  MAINTAINERS                                 |   7 +
>  default-configs/arm-softmmu.mak             |   1 +
>  default-configs/lm32-softmmu.mak            |   2 +
>  default-configs/m68k-softmmu.mak            |   2 +
>  default-configs/mips-softmmu-common.mak     |   1 +
>  default-configs/nios2-softmmu.mak           |   2 +
>  default-configs/xtensa-softmmu.mak          |   2 +
>  gdbstub.c                                   |   7 +-
>  hw/Kconfig                                  |   1 +
>  hw/Makefile.objs                            |   1 +
>  hw/mips/mips_malta.c                        |   2 +-
>  hw/semihosting/Kconfig                      |   3 +
>  hw/semihosting/Makefile.objs                |   2 +
>  hw/semihosting/config.c                     | 186 ++++++++++++++++++++
>  hw/semihosting/console.c                    |  77 ++++++++
>  include/exec/gdbstub.h                      |  11 ++
>  include/hw/semihosting/console.h            |  38 ++++
>  include/{exec =3D> hw/semihosting}/semihost.h |  17 +-
>  include/sysemu/sysemu.h                     |   1 +
>  linux-user/Makefile.objs                    |   2 +
>  linux-user/arm/semihost.c                   |  24 +++
>  qemu-options.hx                             |   6 +-
>  stubs/Makefile.objs                         |   1 +
>  stubs/semihost.c                            |  70 ++++++++
>  target/arm/arm-semi.c                       |  98 ++++++-----
>  target/arm/helper.c                         |   2 +-
>  target/arm/translate-a64.c                  |   2 +-
>  target/arm/translate.c                      |   2 +-
>  target/lm32/helper.c                        |   2 +-
>  target/m68k/op_helper.c                     |   2 +-
>  target/mips/Makefile.objs                   |   3 +-
>  target/mips/helper.h                        |   2 +
>  target/mips/mips-semi.c                     |  14 +-
>  target/mips/translate.c                     |  10 +-
>  target/nios2/helper.c                       |   2 +-
>  target/xtensa/translate.c                   |   2 +-
>  target/xtensa/xtensa-semi.c                 |   2 +-
>  vl.c                                        | 128 +-------------
>  38 files changed, 545 insertions(+), 192 deletions(-)
>  create mode 100644 hw/semihosting/Kconfig
>  create mode 100644 hw/semihosting/Makefile.objs
>  create mode 100644 hw/semihosting/config.c
>  create mode 100644 hw/semihosting/console.c
>  create mode 100644 include/hw/semihosting/console.h
>  rename include/{exec =3D> hw/semihosting}/semihost.h (78%)
>  create mode 100644 linux-user/arm/semihost.c
>  create mode 100644 stubs/semihost.c


--
Alex Benn=C3=A9e

