Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CECC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:56:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B55D320773
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FlfvNpwy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B55D320773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX3ul-0007Vn-L1
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 10:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX3kE-0004vo-Oe
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:45:10 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:45095)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX3kB-0001dB-I6
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:45:10 -0400
Received: by mail-ej1-x644.google.com with SMTP id dt13so13923166ejb.12
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 07:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=szdpdUzzaZ8jLqAZWjRW/SfAG1gnOzMA+My6CI7nSOE=;
 b=FlfvNpwyi9rvJ6JfEyU9JmhGIYEKR4RX2NPzH3WhTK6sIdSVS4atFh0Pjb2i2JGrf3
 AHnlEZAj/eK4idYm6uLeMo6il+H3lD1Pf+dTiwMZ2Kbg8Xog92LuQOgpBguPtmuV0Gh8
 MHnZitnjKlPlyad7ZSfsSaeLELvThEqjRxXsl31y+DzFZj8v7WJ9tZZjXV9HkT1QEhS0
 AYTDT08eLDn71bup1DWDwTGr2+Mkw5KFnn+chBHthXewqwLqHsktTlITQmU+2JDI7+Lw
 HyDw5ENG03fdr2bD0ylFxJ6GZO+sCAnmAxsusyYVYkZDIK0Aa+T6rUiYBW7txtdAWm+l
 CFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=szdpdUzzaZ8jLqAZWjRW/SfAG1gnOzMA+My6CI7nSOE=;
 b=AdaM3clk2bZOyjNRKDjRw1dA+HqZrb/aa9bAZuSWTzUINp95tdTP38INKGSnnxWzD1
 RCHufwUNSYLeqz5VMaDJlJpcFIQDJScwvB8r0jISQsgmBtgEt4/XbzFK40IgOg6XEr2H
 u+zce0jnXCjx2flk/Fbhvwmx9lcW8H3j9M45I3LNbE30CxTLeo+1k3T0Fo8mlhNLeV2S
 qdyRQybTLIVwdYIv8zy2dJt+C70XAasOrBWGp+P5Za/zF3/xfEHMKhwjZlUzLlXzYbSD
 X+APp62HBtU9Ch27rz40Y4XbQElgxK8eqg2psElxM1jOZU+aKPXvbPI+JtN+toWEl9ZN
 +glA==
X-Gm-Message-State: AOAM532XQQnWo5KxSdQ6GjjFlE42qER4cJaCJDr67tf0xa0O2ImCaMdP
 tow7Tjqd3jXugc/sXfS0ehBfRfaFzjUxCO3NGGOvFQ==
X-Google-Smtp-Source: ABdhPJwmgOQPJNArllW623MtnGtF+YvBSd2nDONIf/p+u4j0wVy0H5489dhTMmtHE8kkgDBNyWZWMssHpUBNPJhADSc=
X-Received: by 2002:a17:906:7254:: with SMTP id
 n20mr15382743ejk.382.1603723505151; 
 Mon, 26 Oct 2020 07:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <20201026143028.3034018-1-pbonzini@redhat.com>
 <20201026143028.3034018-3-pbonzini@redhat.com>
In-Reply-To: <20201026143028.3034018-3-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Oct 2020 14:44:54 +0000
Message-ID: <CAFEAcA_VYpdo+KBxTkBfDzoOh7eCUrhFTxeh0VXpMB4Yv89NFA@mail.gmail.com>
Subject: Re: [PATCH 02/15] digic: stash firmware into DigicState
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 26 Oct 2020 at 14:30, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Prepare for removing bios_name.
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/arm/digic_boards.c  | 5 +++--
>  include/hw/arm/digic.h | 1 +
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
> index d5524d3e72..d320b54c44 100644
> --- a/hw/arm/digic_boards.c
> +++ b/hw/arm/digic_boards.c
> @@ -55,6 +55,7 @@ static void digic4_board_init(MachineState *machine, DigicBoard *board)
>      DigicState *s = DIGIC(object_new(TYPE_DIGIC));
>      MachineClass *mc = MACHINE_GET_CLASS(machine);
>
> +    s->firmware = machine->firmware;
>      if (machine->ram_size != mc->default_ram_size) {
>          char *sz = size_to_str(mc->default_ram_size);
>          error_report("Invalid RAM size, should be %s", sz);
> @@ -91,8 +92,8 @@ static void digic_load_rom(DigicState *s, hwaddr addr,
>          return;
>      }
>
> -    if (bios_name) {
> -        filename = bios_name;
> +    if (s->firmware) {
> +        filename = s->firmware;
>      } else {
>          filename = def_filename;
>      }

The existing code is a little odd, because if the user passes -bios
then we use it in both the add_rom0 and add_rom1 callbacks;
however this ends up not mattering for the moment because the
only supported Digic board has just the rom1 and no rom0.

Anyway, rather than stashing the firmware filename in the
DigicState, you could lift the "decide whether to use
machine->firmware or the def_filename" choice up to
the callsites in digic4_board_init():

    if (board->add_rom0) {
        board->add_rom0(s, DIGIC4_ROM0_BASE,
                        machine->firmware ?: board->rom0_def_filename);
    }
(and similarly for rom1).

Then you can delete the
    if (bios_name) {
        filename = bios_name;
    } else {
        filename = def_filename;
    }
block from digic_load_rom() and rename the arguments of
digic_load_rom() and digic4_add_k8p3215uqb_rom() to just
"filename" rather than "def_filename".

Doing it that way avoids passing things around that we don't
need to, and makes it clear in the digic4_board_init() code
that we're doing something a bit suspect in possibly using
the machine->firmware file twice -- if we ever need to fix
that bug then it'll be a simple change to the logic in that
one function.

thanks
-- PMM

