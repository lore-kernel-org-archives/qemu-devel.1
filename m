Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A97C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:33:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E110206B5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YWx45xqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E110206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3ykU-0007F2-IT
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 05:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3yi3-0004OK-PN
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:30:43 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:39207)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3yi1-0002wc-T2
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:30:43 -0400
Received: by mail-oi1-x241.google.com with SMTP id a24so1361217oia.6
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 02:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=p6CObgSy6lHIvCmzXCTrUl+FaKTxDExZUeGOK+BYGmU=;
 b=YWx45xqBuCkmY7bDSKBGssQ8VTLwL+hyFNueZ0QPXE4sqYNxyUPrrHqbETs2B2FDhw
 YdhW+XpGxh9N+hFyOp2gf2nHakygbquNJbSr2NNqn/bBD5j4+55AthVZ5bWaaETTXV7v
 447kSroVe1vzsRK9ckOPwklMcHLRT9Pev2aoTUIwDjcFzp86/Ke1izawWquzAyB28YR1
 B/G5yGL1Y+EDPHnFML/ZAxtHz1ItqNc8wnQn3kjhCjcid8a+BmJUZBd7syZA+zrUe96W
 pxSZi5i3vCkfvv3YqTNc/b4gHPZZyIaPDWkguIC1EPvyTzr+t4BEtr3naYCVjiqSrh1S
 TPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=p6CObgSy6lHIvCmzXCTrUl+FaKTxDExZUeGOK+BYGmU=;
 b=YYPx3SrG5nemMJrJti7SyXajU67fptHUjVlV4BAv4p7zHWfm2YUIkODYqraAJSsXsH
 rvcuhrCZ4ptYR2JYGa/xyslYAfBjd7WDgVgF2e0qF+PAOPgLpNVauUhMzIJmoQbcdE2e
 /Etid0+yFNE1vxS45ypUCHKUR3RE6O2ez2IU7CoM81t8aSWd65xkbXPLB1cmFVkKM68Q
 +f8EkB5AERg5eiPb9AOG2kv87uj+CR/uf4vk4+5bNpZs4nZcjx6L1VO4g34TIwOk+Fyc
 JkfJ65afk/H+/ixUdR3UwzCXOGi52eZjPGRi4eDUcVAffiKOgIOyhqLM+fFN+RKFGNdf
 VrqQ==
X-Gm-Message-State: AOAM531C2J8egl58TpIrTToX11dTKiLyQM/Y0ojlVJ13xDHIJx0G4NtI
 1UnWfq/BJqVd6GoheVKkvYkUVYWbt8TfprRxMUJarQ==
X-Google-Smtp-Source: ABdhPJxAk6RPrCBdPaaMPA62UZPMrWfHPhZoXeGdO2DkM8h5udE9wMIwPn6kmY5DWPJi4gExwIMqw7lKYwX8hXTslaQ=
X-Received: by 2002:aca:4a96:: with SMTP id
 x144mr10394690oia.163.1596792640542; 
 Fri, 07 Aug 2020 02:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <1596741379-12902-6-git-send-email-pbonzini@redhat.com>
 <CAFEAcA_mN3XrgxRbhq5U0B=OxBq6T3DXymb4_U-tzOya=W-AbQ@mail.gmail.com>
 <d676a107-c49d-ab3f-f6e3-f6b594af9c4f@redhat.com>
In-Reply-To: <d676a107-c49d-ab3f-f6e3-f6b594af9c4f@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Aug 2020 10:30:29 +0100
Message-ID: <CAFEAcA9JLqTHLLEy1WtGkvRYGSupX0PPUYAmnZ4Q_kGaJ3cSTg@mail.gmail.com>
Subject: Re: [PATCH 005/143] meson: rename .inc.c files to .inc
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
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

On Fri, 7 Aug 2020 at 10:23, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 07/08/20 10:59, Peter Maydell wrote:
> > On Thu, 6 Aug 2020 at 20:25, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >> ---
> > What's the rationale for this ? ".inc.c" is the project's
> > standard naming convention for files which aren't headers
> > but which are lumps of C code #included into a top level .c
> > file. The .inc.c deliberately ends '.c' because that way
> > editors will use the right syntax highlighting for the file.
>
> Good point.  It can be changed to .inc.h too, if that's preferrable for you.

Not really, though I guess it's slightly better than plain .inc.
They're not header files...

> > It would be much better if Meson could cope with our
> > standard naming convention rather than forcing us to change it.
>
> First of all I need to describe why this is needed; it is because of the
> way Meson handles dependencies on generated headers.
>
> With Makefiles that have automatically generated dependencies, you
> typically make generated includes depend on the Makefile so that they
> are built before everything else and they are available when first
> building the .c files.
>
> Meson is similar, however the way it works is that you list those
> generated includes in the sources.  The dependencies are still
> automatically generated, but the build rules will ensure that the
> includes are generated before attempting to build the toplevel C sources.

But we don't really want to build all these files before building
all C sources. We just want to say "this .c file depends on these
.inc.c files" and then let the build tool figure it out, surely?

> The problem is that Meson decides if something is a source vs. a
> generated include by looking at the extension: '.c', '.cc', '.m', '.C'
> are sources, while everything else is considered an include---including
> '.inc.c'.

Is this hardcoded in Meson? That seems pretty suboptimal.

> Going back to patch 124, I can now answer your question:
>
> >> It's not clear to me why all the decodetree lines ended up in a
> >> single "gen = []" block -- they're independent of each other.
>
> The files are added to the source list with "arm_ss.add(gen)".  All that
> line does is ensuring they are built before other target-specific files
> for ARM targets.

Do you mean that it just adds an extra implicit ordering constraint,
such that if we need to rebuild both files not in 'gen' and files
that are in 'gen' the 'gen' ones go first, or that Meson really
builds all the 'gen' files first? What happens when you edit a
.decode file? How much stuff gets rebuilt?

> The question then is if Meson could be changed to cope with our naming
> convention, and unfortunately the answer is no.  The root cause is that
> Makefiles list .o files (and uses implicit patterns to connect .o files
> to the corresponding sources), while Meson lists .c files.

Can Meson handle "this .c file needs to be built from something else?".
Presumably so, that's a common pattern for flex/yacc type tools.

thanks
-- PMM

