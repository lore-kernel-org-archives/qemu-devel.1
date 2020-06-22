Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48828C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 16:20:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 149C52073E
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 16:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fl4eGnHT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 149C52073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnPBm-0006WW-8O
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 12:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnPAu-0005yR-S6
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 12:20:00 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38392)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnPAs-0002s2-Op
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 12:20:00 -0400
Received: by mail-oi1-x242.google.com with SMTP id c194so16140229oig.5
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 09:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5mMg9iynV/cpDMy59pZk2XtJ7d1nMm8XteN/6zDsW3w=;
 b=fl4eGnHTZVSit9agVoVD0K4/6xW3fySlX751muyH7u3AQoaYnASGsc7vUBobQbKLU1
 GO0RBH/gH6gWWuB567vSzCPcmn5U30iyk9jB/AchclYR4TP9Nzm2BelhAXrkt4nMEbsI
 klyeruZVWPkRTPM1p/FU5JhuYCbvpagixRj/idYmxGTEg7WJwVcpjIWOx3Zry7oOpZoJ
 b5N8vFlDGDwzaMpOnnyjOwbmVwDS1ML8Ep/WPtNA3dlHMfiRwvIGTtXlzvQkVOEftfaB
 sZPXks1X23sq7w1AhNseqXSs3frrnN+SlKtOUoyHw0lCxU8Sl+wA5yL15no6jzO6nTQH
 V9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5mMg9iynV/cpDMy59pZk2XtJ7d1nMm8XteN/6zDsW3w=;
 b=EF+f55bSecRcG/Nc/EMpUtlknRjn4eoXa3vnH/qJQzivYyAthIMJU/gWpAupIlrq/a
 2jU0DtPQKTleEr7rnZPU3pRgUuX+xjCwIijoEokUjKwXcV8P54Mqm+GmMSBeVLx8yyT2
 v8ZdvbdabYzEUWbVI4x9gvv8AxvSvOl5htuGee9EZZyB7DUJ8YVAdyHWbVzMPGYb4MVe
 jSQuN6MwVp+oX44HGp6yJhRlI1uuijQ1iOHnIZ/bcCT0ZuEl+iRnm0f/SyHATr8psHz1
 CuKtwoj1zJyJzuA2YXgCzWefEKtcK1GiG56P/UnhcPS8AhexpNnaOedvBurTixVWl8qF
 34pg==
X-Gm-Message-State: AOAM530dB4Vq8fBA1gCMbTLQTrUB5qsAYnfaDSEcJDjEyc+h6R/phInV
 mPhsY6kQUZRVV51saIN58WWcE4/He6bAHv/nhuC3MQ==
X-Google-Smtp-Source: ABdhPJxOnEzWxBNLYRNFZ9GNGidaXc12kff8Omv2KUB0MK12lYHzrlDnTRYK+6th1yjooTPRCsdu5UyVaMRum31twmk=
X-Received: by 2002:aca:568c:: with SMTP id k134mr12312489oib.48.1592842797309; 
 Mon, 22 Jun 2020 09:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200621124807.17226-1-f4bug@amsat.org>
 <CAFEAcA_5663fFNVqcr1maATB6v8R297LmJEtD+8V4LvhaSkjPA@mail.gmail.com>
In-Reply-To: <CAFEAcA_5663fFNVqcr1maATB6v8R297LmJEtD+8V4LvhaSkjPA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jun 2020 17:19:46 +0100
Message-ID: <CAFEAcA-w4DGH2wEwySZd+zj-m+YpL39tog9S9LNH2iTcL84F9Q@mail.gmail.com>
Subject: Re: [PULL 00/15] Renesas hardware patches for 2020-06-21
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 22 Jun 2020 at 17:01, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Sun, 21 Jun 2020 at 13:50, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> > Renesas hardware patches
> >
> > - Add a common entry for Renesas hardware in MAINTAINERS
> > - Trivial SH4 cleanups
> > - Add RX GDB simulator from Yoshinori Sato
> >
> > The Renesas RX target emulation was added in commit c8c35e5f51,
> > these patches complete the target by adding the hardware emulation.
> >
> > Thank you Yoshinori for adding this code to QEMU, and your patience
> > during the review process. Now your port is fully integrated.
> >
> > Travis-CI:
> > https://travis-ci.org/github/philmd/qemu/builds/700461815
>
> Hi; I'm afraid there's a format-string issue here (manifests
> on OSX, openbsd, and 32-bit platforms):
>
> /home/peter.maydell/qemu/hw/rx/rx-gdbsim.c: In function 'rx_gdbsim_init':
> /home/peter.maydell/qemu/hw/rx/rx-gdbsim.c:93:22: error: format '%lli'
> expects argument of type 'long long int', but argument 2 has type
> 'ram_addr_t {aka unsigned int}' [-Werror=3Dformat=3D]
>          error_report("Invalid RAM size, should be more than %" PRIi64 " =
Bytes",
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                       mc->default_ram_size);
>                       ~~~~~~~~~~~~~~~~~~~~

Also there appears to be a makefile/dependency bug somewhere,
because when I drop this merge attempt and retry building
with current master I get this error:

make[1]: Entering directory '/home/petmay01/qemu-for-merges/slirp'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory '/home/petmay01/qemu-for-merges/slirp'
  CC      qga/main.o
  CC      qemu-io.o
  CC      monitor/qmp-cmds-control.o
make: *** No rule to make target
'/home/petmay01/qemu-for-merges/hw/rx/Kconfig', needed by
'aarch64-softmmu/config-devices.mak'.  Stop.
make: *** Waiting for unfinished jobs....
make: Leaving directory '/home/petmay01/qemu-for-merges/build/w64'

This seems to be because aarch64-softmmu/config-devices.mak.d
in the build tree says that aarch64-softmmu/config-devices.mak
depends on all the Kconfig files; this means that if a Kconfig
file gets deleted then incremental build stops working?

thanks
-- PMM

