Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AC8C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:38:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 773282177B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VQzbz7L/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 773282177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBHAw-0007UZ-JT
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 08:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1kBHAP-00073y-OL
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:38:09 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:33766)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1kBHAN-0005lU-Th
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:38:09 -0400
Received: by mail-il1-x144.google.com with SMTP id o16so744114ilq.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 05:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cmdH3yWeYBD60VPxQHZezno7K2Q8G/epvZsrPgeEEcI=;
 b=VQzbz7L/rOyV1fAqwPrfpYfupay0z0CkMxIfV4PgKEep1Qq8esSzJO4V6jCJWDoHq/
 qzlXONTOcwfA4lKPIGqZgWkbMoT+LpKCi0ZtSGood+csLKy9oYH28euWcFHB0dsHbOR/
 7MsA4JHbv10izNc79Kl4aojOE86iNRdYHmSppbxGbbtl268peRPEQK7rsnnpPGM+ULQG
 +PDbWAWwib+YRj58KwDx/HjCqN1vOZwBtLhcmxXMmbE4d6nqVESegS3Vt/xIve5s4Isc
 oowXUk2H9gW2LyGlrO1rCCJowAdv1nIxSRJxbT1c59skkL1VThtw9UXnZfEBcnjEOmrr
 4PoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cmdH3yWeYBD60VPxQHZezno7K2Q8G/epvZsrPgeEEcI=;
 b=CtvcPCUWm8ZRUUP9mVjFTjiFhOpY/y68u49wzMDfwMeMOwOSxBnwE7yIhkDVm1/pSZ
 vlxajKVYapmelrELsCQKAgAV3w/mqvyoJFyIfyXhz1XNg56SM2B9VpvPfzfmd9R8a3Do
 hEqWwcFz9jg3grJbnL4tS+uQcIrCNT36V4OXthAGj8Jslcjoor3aUN4Gd4p5b+eP1Ts8
 mS97IKHRxaMX5BmFCYguMGZDwzpqXfFK4w40nw5sXrdYdNa35P3ckb4AIMwCWQUxTVkU
 +1r1ZhXScULe+QXC0UvUQvhVLUOIfaKv94s45AKAf9hYOMNucTB3U3QPRF1t+IgtiQ+P
 AsIw==
X-Gm-Message-State: AOAM533uzC7PQMOldTz+/Hhhtns2sTbIePoswL6FlYW8+TdqzlgtbxdV
 HSIkxGJrpG/2XDzft3iZ3XnjPt0K+VHVgW7l1Gaixg==
X-Google-Smtp-Source: ABdhPJyMgjaiZMfhJfcr0aK7IDEmG+Hww/Cym5Bi9F+VNBngzeWC+vBuikrzJ8v3QLhNhr4tGG/ZNY3SPES+nwGtzaQ=
X-Received: by 2002:a05:6e02:d46:: with SMTP id
 h6mr17231138ilj.230.1598531885251; 
 Thu, 27 Aug 2020 05:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200819182856.4893-1-robert.foley@linaro.org>
 <20200821125544.73fc1d7b.cohuck@redhat.com>
In-Reply-To: <20200821125544.73fc1d7b.cohuck@redhat.com>
From: Robert Foley <robert.foley@linaro.org>
Date: Thu, 27 Aug 2020 08:38:35 -0400
Message-ID: <CAEyhzFvKAGVSpACvkJZuyAy9SQxXe7nxVkUj6Di8+TzHJup4vQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] accel/tcg: remove implied BQL from
 cpu_handle_interrupt/exception path
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=robert.foley@linaro.org; helo=mail-il1-x144.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>, Anthony Green <green@moxielogic.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stafford Horne <shorne@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Michael Walle <michael@walle.cc>, Palmer Dabbelt <palmer@dabbelt.com>,
 Peter Puhov <peter.puhov@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 21 Aug 2020 at 06:56, Cornelia Huck <cohuck@redhat.com> wrote:
> >
> > As the first step in removing the BQL from this path, we will make
> > changes to the core/common functions of cpu_handle_interrupt/exception
> > to drop the holding of the BQL. The holding of the BQL is pushed down
> > to the per-arch implementation code.
>
> I have only skimmed the patches I was cc:ed on so far, but the series
> seems sane to me in general.

Thanks for the feedback !
>
> >
> > This patch goes through several transitions of the code in order to
> > maintain correctness (bisectability).  In order to maintain
> > bisectability across these steps some patches need to touch many
> > files across different arches, however most of the changes are trivial.
> >
> > The general order of the changes is below where each step
> > represents one patch.
> >
> > 1) rename all *_do_interrupt functions to *_do_interrupt_locked
>
> I'm wondering whether this renaming could be done in an automated way
> (e.g. via Coccinelle). Reviewing the method for the renaming is often
> easier than looking at a lot of similar code patterns.

Good point.   We will look into this.

Thanks,
-Rob Foley
>
> >
> > 2) add a new function *_do_interrupt that takes the BQL and calls
> > *_do_interrupt_locked, point ->do_interrupt to it, and remove
> > the BQL from cpu-exec.c's cpu_handle_exception.
> >
> > 3) modify the BQL critical sections around
> > ->cpu_exec_interrupt, so that the BQL critical section covers just the
> > call to ->cpu_exec_interrupt.
> >
> > 4/5) same as 1/2 for ->cpu_exec_interrupt.  This removes the BQL
> > from cpu_handle_exception.
>
> The method of doing this in steps looks fine, although the patches
> produced are a bit unwieldy -- that's something we have to live with, I
> guess.
>

