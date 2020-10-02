Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F224C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 13:03:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D82B8206E3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 13:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T0x5v7kT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D82B8206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOKj6-0001h6-Qm
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 09:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kOKhP-0000q2-3k
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 09:02:12 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:34544)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kOKhK-0001Kj-Aq
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 09:02:10 -0400
Received: by mail-ed1-x543.google.com with SMTP id k14so1559592edo.1
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 06:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Zvd6yyznKT3VhFvh7aYq8+alNawaBmyOGQ2UXQ82+II=;
 b=T0x5v7kTtMbtXloWtmXytu6ge73seoUM6f5Ac5bkAa6XnoNcVKJSkVJFQHJrYPYWPG
 ur+I38KnpPmpOe+gFA/CE1G6MBBxy54fMLWGxtyXFah0RbrAlq76YECAvaJqD5haD0HV
 S/kQhIVmtDaynMH8OGGuTl2bCLvfHNLG3BYCECGbVymH29VPKlm0HZbILNH7brJ7WYEa
 Dw07/5dJauGuJfPRf0qJ8uCyoKREKQf1rETzubpEmYPGOT23iiej+uscC3zY1lkZwOqi
 ef/ytO4GIX5E3OtXD+ApS+i2Xt+UWB1YWT/wuOfT/1MmrkqbG6+UYBXgcaF523WH4+DD
 Nq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Zvd6yyznKT3VhFvh7aYq8+alNawaBmyOGQ2UXQ82+II=;
 b=tDlBGcWZY2TJciEUeLmwHkSY5y6i+frAiaBTNosDCTzH2rpuInvnt6X6n6B4hhkaBO
 fVqBljsBbcHZ+LT+600eT4mvAj4oLUUJFbA+TgjFBP93QB/mxtQ4HcB+Q+lGKbMqcwkf
 Rom8JJAGKenTcMufQXh4KRzRZeekDNLBiwPWpNJVyerm5t4YHoeTkwrXM5r2DTWgzUyk
 s8ZUPhX+Gry8c42TdV0+7j6/iZV9RDY+ybh0eNSsY46GVwzBdZMn0WRQwhhMnHvmvDpY
 v0L2w9zkhLjgLetS/OA4luHSgR1MD/Z7+TIDjJsmR6SUFmSZYcR9HvC9oUqR58TT1BJJ
 5B6Q==
X-Gm-Message-State: AOAM533P76gz8xCwDF4uV7e1KP1QFSs+VdTQ4wFTzIfscVLjmrg0pQXZ
 2K0qFLfMiIuLcM2SWRXREsU0+6qKGMMfSzk8o367ZQ==
X-Google-Smtp-Source: ABdhPJxDDjD0eBYO2A78fdV+3lsqXDafT2YXmTOABggQ3rzCL1Wx44D9gxfcpev1/LId/+/PBK1/5u36xB5Wq0iwgek=
X-Received: by 2002:aa7:c7d7:: with SMTP id o23mr2139271eds.44.1601643724093; 
 Fri, 02 Oct 2020 06:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <20201002105239.2444-1-peter.maydell@linaro.org>
 <b1a6000a-c9a1-43fb-7646-b6ea87797b2e@redhat.com>
 <CAFEAcA9PbBByROzJ3+pfxycAoP-C5JnmfxQEt5jm6+3A3n2fbw@mail.gmail.com>
 <CAFEAcA96sZqqSNSJT7TET8qfArLnWJr5tu1YLqFGBsnca3YoFQ@mail.gmail.com>
 <b6303051-496f-2fee-bd89-54b37982142e@redhat.com>
In-Reply-To: <b6303051-496f-2fee-bd89-54b37982142e@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Oct 2020 14:01:53 +0100
Message-ID: <CAFEAcA8kbOff3Wu=0nOCua5f1dboXofs5Q+0jz1vY7Mzg7zt7g@mail.gmail.com>
Subject: Re: [PATCH] meson.build: Don't look for libudev for static builds
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2 Oct 2020 at 13:44, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 02/10/20 14:36, Peter Maydell wrote:
> > On Fri, 2 Oct 2020 at 13:35, Peter Maydell <peter.maydell@linaro.org> wrote:
> >>
> >> On Fri, 2 Oct 2020 at 13:02, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >>> - the workaround: just leave things as they are and add
> >>> --disable-libudev to your script.
> >>
> >> There is no --disable-udev !
> >
> > ...and there's no --disable-libudev either :-)
>
> You're right---I was sure I used some get_option but it's not
> --disable-libudev; it's --disable-mpath.  That made sense when mpath was
> the only thing that used libudev, but probably now we should add a
> separate --disable-libudev.

Well, this gets into the question of what --disable-foo options
should be doing. They're user facing, so really they ought to be
for user-facing features. So for instance:
  seccomp         seccomp support
  libssh          ssh block device support
  dmg             dmg image format support
  gtk             gtk UI

are all enabling or disabling features the user might plausibly
have an opinion about whether they want or not.

These are bit more dubious -- they are enabling/disabling
a specific library, and so the help text has had to do
the translation of that for the user into "what actual
feature in QEMU am I losing here if I disable this?";
  libxml2         for Parallels image format
  libusb          libusb (for usb passthrough)

and then these give the user no hints at all:
  libpmem         libpmem support
  libdaxctl       libdaxctl support

so it's not clear what they're intended for (unless it's
solely for the niche use case of "work around the build
machinery not correctly detecting whether the library is
available"...)

Having a --disable-libudev seems to me strictly worse
than either
 (a) the build system actually being able to correctly
identify that the host has a libudev available to link to
 (b) having an option with a name and help text that tells
the user what they're actually gaining or losing by the
feature being enabled/disabled

thanks
-- PMM

