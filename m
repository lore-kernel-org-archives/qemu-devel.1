Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E31C33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 09:27:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4240424684
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 09:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xkrgfh6n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4240424684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwN9W-0005cN-G9
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 04:27:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32878)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iwN8v-0004x6-13
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 04:26:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iwN8t-0004dv-MN
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 04:26:44 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36630)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iwN8t-0004cV-Fv
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 04:26:43 -0500
Received: by mail-ot1-x344.google.com with SMTP id g15so11371466otp.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 01:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5Spr0i7p9df6cetWmvq1eFR/35DVSFU8jnLP9lOVwKE=;
 b=Xkrgfh6n7LyBnsbxZgqS6D/vqdxCNvaf01OtsLRY+DJypn07P2vz0l9uOj6oXkVL6Q
 DNLVesaSscXepz0YrHcWEA3pznS1NgG6WTNuvWbHahdJ6lAw3Z6TJYWUnDaBoiGN+VgD
 zpp5q1lfI8+s5jDUCsZEE7/rT+SYOeS72CNzjGtJVl+Qnf2S24MHa8lkMYGOQu11kaPZ
 5O6oILrM/ubtirYTDH0n1mXuC2VqysIj/v6mGFz4diJZnaAwR15Q86pIWp2Fx4/OWaPR
 WNymAXsMLg0FSB/jxFSHBzXK7rHsxI/nN9H0LpXTFyBKn/o7ouWMdreNZUIF0tvMoEtP
 tAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5Spr0i7p9df6cetWmvq1eFR/35DVSFU8jnLP9lOVwKE=;
 b=qIYRKzaSZjHYMBJPDrs5InjD2H74u2lIWB7i5VoTuKC+SROaReWBIZtdRQLGqL+iSM
 IhRiSczL/4gVztIzRXOrcCrNf78R9Ylnzi+oT86yXQYhQcK4bblw5nDcKnO2ZQb986Zi
 ExEF/AOELXWHHXTREBur83wTRYJexP7KyzP2g0iAH0Fa2ovye6k8RregFxGyO46VduDG
 m6iyHygdkdgMdkDzJ4ITSTxQz+bbbN3Fvivj5YMnqZDA+vZub0OvIK0e5m21Y9VHerCl
 IrKZk7993of5Qah4oysThpT7YyJI3spGLhihLBA9Loc99pe9Jvg2/n61E5ZOfBOjA8Ds
 bDDQ==
X-Gm-Message-State: APjAAAVlYcbuJyHQboe37D2YAdGDwBCXJj8NDbwgjwUdUaZO4HJjkodV
 LL4Yx9OQvREjq0on+wgRlsY+Tk7MBhChfUhidViQeA==
X-Google-Smtp-Source: APXvYqwTctdN0gze9FbBebfBj6+ucx45GT7IRtcxPmlrq8r28b6KK6i7TLarXU8Ybo8EvdhQLPsPTxf1GMiEvQlkOkY=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr16029508ota.232.1580203602545; 
 Tue, 28 Jan 2020 01:26:42 -0800 (PST)
MIME-Version: 1.0
References: <20200116115700.127951-1-mkysel@tachyum.com>
In-Reply-To: <20200116115700.127951-1-mkysel@tachyum.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jan 2020 09:26:31 +0000
Message-ID: <CAFEAcA_pOAX=pCk0TfbwwUPHUX2YhLtxMonYVazMrGZBvPJkPw@mail.gmail.com>
Subject: Re: [PATCH] Handling SIGSETXID used by glibc NPTL setuid/setgid
To: Matus Kysel <mkysel@tachyum.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jan 2020 at 11:58, Matus Kysel <mkysel@tachyum.com> wrote:
>
> Used same style to handle another glibc reserved signal SIGSETXID (33),
> that is used by glibc NPTL setuid/setgid functions. This should fix problems
> with application using those functions and failing with error
> "qemu:handle_cpu_signal received signal outside vCPU context".
>
> Signed-off-by: Matus Kysel <mkysel@tachyum.com>
> ---
>  linux-user/signal.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index 0128bde4d2..c59221fd0a 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -66,11 +66,16 @@ static uint8_t host_to_target_signal_table[_NSIG] = {
>      [SIGPWR] = TARGET_SIGPWR,
>      [SIGSYS] = TARGET_SIGSYS,
>      /* next signals stay the same */
> -    /* Nasty hack: Reverse SIGRTMIN and SIGRTMAX to avoid overlap with
> -       host libpthread signals.  This assumes no one actually uses SIGRTMAX :-/
> -       To fix this properly we need to do manual signal delivery multiplexed
> -       over a single host signal.  */
> +    /*
> +     * Nasty hack: Swap SIGRTMIN and SIGRTMIN + 1 with SIGRTMAX and SIGRTMAX - 1
> +     * to avoid overlap with host libpthread (NPTL glibc) signals.
> +     * This assumes no one actually uses SIGRTMAX and SIGRTMAX - 1 :-/
> +     * To fix this properly we need to do manual signal delivery multiplexed
> +     * over a single host signal.
> +     */
>      [__SIGRTMIN] = __SIGRTMAX,
> +    [__SIGRTMIN + 1] = __SIGRTMAX - 1,
> +    [__SIGRTMAX - 1] = __SIGRTMIN + 1,
>      [__SIGRTMAX] = __SIGRTMIN,
>  };
>  static uint8_t target_to_host_signal_table[_NSIG];
> --
> 2.17.1

This is a long-standing known problem, but doing this is likely
to break currently-working guest binaries (notably things written
in Go). See for example the discussion on this thread:
https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg03804.html

thanks
-- PMM

