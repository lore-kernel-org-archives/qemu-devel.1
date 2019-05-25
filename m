Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3F9C04AB0
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 09:16:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A16F2168B
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 09:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjYfaTKl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A16F2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38297 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUSnQ-0006HC-9X
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 05:16:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hUSmH-0005hA-Eh
	for qemu-devel@nongnu.org; Sat, 25 May 2019 05:15:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hUSmG-00085W-Fs
	for qemu-devel@nongnu.org; Sat, 25 May 2019 05:15:45 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>)
	id 1hUSmG-00084p-9j; Sat, 25 May 2019 05:15:44 -0400
Received: by mail-wr1-x444.google.com with SMTP id l2so12168982wrb.9;
	Sat, 25 May 2019 02:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=zGK830wyQt+q8sxGAuFKhEe3VX28HMwUMR/dPAeHO9E=;
	b=LjYfaTKl5DcGXuB+eQ5vf/DwKsh/uhQM84yRSlVFFRVuvInqWnW6xIZoUBF2+CZOqz
	ICYFt6KtbA5DQ207NXVW8HZ1alaSoTh/rwsB8rkZFvs3FCxv72vGWnXR2acHtCI4JdXS
	UDNc+2KyTdiFXLdVT//yW7KTWyIHGn5Hpgp/UZdgMGEpqh96xX64BY5zFEMsDDzrq25N
	hhfHSIM3HCRAkKiUS1EPx6upkyQFjd0+dTSL3OOXNjWzHnmTFHlKj+6hBrHIKddAzye6
	lTgkY/jmzrEDhHmhoHY6Dngw3ad38awOuyJwkPZZuybj56yDuyVBPuAKSOmdKNZTBxBU
	0eBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=zGK830wyQt+q8sxGAuFKhEe3VX28HMwUMR/dPAeHO9E=;
	b=b8V/7GEyRsQx/chYV/2tLb7HBBS8qtw2VTUBuu0nbBOJX7j3echYa/ld1QGXeWxylv
	WZiwbZiyMG5T6WTPNZU6noTmK0wmSg+4K/mT30yjUgWTS4CFO22MZKUA3aPOPBn/bEta
	GmmETr0kXK9hAeWl5X2fArMfw/daQvc3Dq1mg7RNdRWJJ2vNLjKenvLUj/grR2M1ZPNN
	HDIg8pINvQYcZxWwbG4Uz2xwItRz4q4IgXF7NHvO7IH3PiPXc2946v4od5rAAqX7MiMM
	P/2IAtAOyCZcZdDrxnkGhwCcWtkorBatmO8ggbryD8KjUYilLeniHkTO3ZbGKRFb+rCH
	O/oQ==
X-Gm-Message-State: APjAAAVDXIKMXX/fo6dSIMh0aPLccrD4qSeD4fjwouWQ9LyCiX0Ria33
	ugYShvmA2swMN0ZUUOWzmETjP5ZQotpSI6EUlYY=
X-Google-Smtp-Source: APXvYqwjko1Qc0mCew+f/Y4Yit5WaGath8nDpS89b8XIX7SUvDR66AX0coqfX40ZDV1cDoJmsz++tHP+V2BcxanFOYk=
X-Received: by 2002:adf:a4d2:: with SMTP id h18mr2037602wrb.149.1558775743017; 
	Sat, 25 May 2019 02:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190525090559.31914-1-stefanha@redhat.com>
In-Reply-To: <20190525090559.31914-1-stefanha@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sat, 25 May 2019 10:15:31 +0100
Message-ID: <CAJSP0QWo-JK1CW4tuwugxXDyuTbov0y_Tjs9S068beufVMQxeQ@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block/io_uring: use
 pkg-config for liburing
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu block <qemu-block@nongnu.org>,
	qemu-devel <qemu-devel@nongnu.org>,
	Max Reitz <mreitz@redhat.com>, Julia Suvorova <jusual@mail.ru>,
	Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, May 25, 2019 at 10:07 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:

Based-on: <20190524140337.13415-1-mehta.aaru20@gmail.com>
           "[RFC PATCH v2 0/9] Add support for io_uring"

> diff --git a/block/Makefile.objs b/block/Makefile.objs
> index 262d413c6d..eed8043740 100644
> --- a/block/Makefile.objs
> +++ b/block/Makefile.objs
> @@ -62,6 +62,7 @@ block-obj-$(if $(CONFIG_LZFSE),m,n) += dmg-lzfse.o
>  dmg-lzfse.o-libs   := $(LZFSE_LIBS)
>  qcow.o-libs        := -lz
>  linux-aio.o-libs   := -laio
> -io_uring.o-libs    := -luring
> +io_uring.o-flags   := $(LINUX_IO_URING_CFLAGS)

Oops, this should be -cflags instead of -flags.  The current
liburing.pc file doesn't define any special cflags so I didn't notice
this problem.

Please fix this up when integrating this into your patch series, thanks!

