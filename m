Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2931DC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 14:12:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EE68247D8
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 14:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wusQF3fV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE68247D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSL29-0004XM-DB
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 10:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kSL04-0003kA-A1
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 10:10:00 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:34398)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kSL02-0006ge-CW
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 10:09:59 -0400
Received: by mail-ed1-x544.google.com with SMTP id x1so21081687eds.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 07:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VT9hjFD6BCImfBbOC8c8PWSkygW3IhAeW86kiGaNwYA=;
 b=wusQF3fVm2x4UQQaWD1vGgQLEah4hkRpycqlimdDhlV2HwAvioUG04fjmFSk3pifzV
 7BSvh4pnX/Q0fnweA3VDP48Zab29yqJtQHYqnv/D1V+mGGKfbZD1ODSdqE76e7xS3dQm
 FICeQ9vJh5JLNjEBv8fIcQapUFRU4yMNFk/zRY3Uide/OI5AmE2PRnoQqSpUPeYaI7Na
 FscyHWCZeABqSNTJDvBAlt/bYSdhG2SxLhQXgkOyfqqVLo1FBBSv23l506JL0XnxgIgj
 5ZymLzs0RkS/3V8bw6F2bvu8/kwoMkPsnMmlQtrzB8/YCzTpK/utUL32Q3+4W9kWZvQL
 Gftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VT9hjFD6BCImfBbOC8c8PWSkygW3IhAeW86kiGaNwYA=;
 b=pDSXED2aQfvFQw6zVSBUiStymYx1sXDLe3+icDgiepcvOcEjAH4hpJqKUvLndoHjEo
 jEwZJqjRbSnHB2YpkpTyleLAKTYa0f9T2ZfZfrPW0ZQUHBYLdGQMcFjBNl0sOpCyuAeI
 rF6iZ/KK+FRTH8CjVV8YgVHsXyTVpgARZ7QfX7DypZxs+c1rXHgZK4mYXOFJjKrf9WkK
 n96567PbZLCIwTM2m+OZ/ufuInf67/uRk2TMUo1UBCn8ArPgEvnzPmdZB4q4MskO1dA2
 +ZL/xO/vczqU3sQiN+m/sCdslJtoQHlz2wI7Qzy3WkNvxcTNe97svaGUUEKkTSYIt5OZ
 Jk/Q==
X-Gm-Message-State: AOAM531eHQkg6BxkhBmp5llhv9VuCKq4R1qY5hhKxBuaFgXfWW8xtSlV
 I2hxbrCFXNDlpSH2gIdVysft8FLBtg4rz/1sqg/MHA==
X-Google-Smtp-Source: ABdhPJzLy6bjnnE0Xo2uFk2qKQyKvjFF6XbXDBEQQfrkVrJqqXLs1bzSO4J6T784H47XjTL5I+UrqRhWlxYiQOUnY0E=
X-Received: by 2002:a50:9ea6:: with SMTP id a35mr21131451edf.52.1602598195958; 
 Tue, 13 Oct 2020 07:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201012232939.48481-1-j@getutm.app>
 <20201012232939.48481-10-j@getutm.app>
 <a132bc5b-9029-db47-1f38-0dec75029e10@redhat.com>
In-Reply-To: <a132bc5b-9029-db47-1f38-0dec75029e10@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Oct 2020 15:09:44 +0100
Message-ID: <CAFEAcA9D+1g_6gxPLHwgVHbMwW7e=Ana-fM-fJa+jDDSm0gA8g@mail.gmail.com>
Subject: Re: [PATCH 09/10] tcg: support JIT on Apple Silicon
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x544.google.com
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
Cc: Richard Henderson <rth@twiddle.net>, Joelle van Dyne <j@getutm.app>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 13 Oct 2020 at 14:58, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 13/10/20 01:29, Joelle van Dyne wrote:
> > From: osy <osy86@users.noreply.github.com>
> >
> > https://developer.apple.com/documentation/apple_silicon/porting_just-in-time_compilers_to_apple_silicon
> >
> > For < iOS 14, reverse engineered functions from libsystem_pthread.dylib is
> > implemented to handle APRR supported SoCs.
> >
> > The following rules apply for JIT write protect:
> >   * JIT write-protect is enabled before tcg_qemu_tb_exec()
> >   * JIT write-protect is disabled after tcg_qemu_tb_exec() returns
> >   * JIT write-protect is disabled inside do_tb_phys_invalidate() but if it
> >     is called inside of tcg_qemu_tb_exec() then write-protect will be
> >     enabled again before returning.
> >   * JIT write-protect is disabled by cpu_loop_exit() for interrupt handling.
> >   * JIT write-protect is disabled everywhere else.
> >
> > Signed-off-by: Joelle van Dyne <j@getutm.app>
>
> Can this be emulated somehow on other platforms (such as Linux) so that
> it does not bitrot?

Some of it is write^execute, which we could test via OpenBSD
I think if we updated our VM image not to mount the disk
with that protection disabled. Having "generically support
w^x" be separate from "iOS specifics" might be useful.

The apple.com webpage linked above suggests also that we could
test some at least of these APIs on our OSX builds if we
enable the "hardened runtime" on x86 (though that might also
enable other stuff we don't want to deal with? no idea)

thanks
-- PMM

