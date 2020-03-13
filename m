Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4991DC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 13:22:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15070206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 13:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KaTWKXnI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15070206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCkGP-0006XN-AM
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 09:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCkFq-00065Y-LP
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:21:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCkFp-0003V5-BM
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:21:34 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42967)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCkFp-0003TC-5U
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:21:33 -0400
Received: by mail-oi1-x242.google.com with SMTP id 13so359140oiy.9
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 06:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tlpzu2FnVCttuisHkaaEDWy4Rmkog/SML4NQKupN9mk=;
 b=KaTWKXnIoGhvN/mvr9OkyeyKPota2/n7fM39urKSiy6m4j44dKzTXT8AAt7Lxf8lh8
 Ufn5OzTmiuquto5LtVM1UvPM2UEWNUBsslKpI/kQdrPAzESz3m5Zx0iWbqEPSQqiWpv6
 ZL3qSZP88Fl4GWkLQqtwB8rJoKm/RHvN0SzrVmMlZrvqVuYtJCGu4sd4JCmY924TuP8u
 AQmFhmrws9x4IfsUiGFewxDg0GWScho+0yJsO2qq+owUaBglI7BX+SkudSP4xUg3xGAu
 jhZRurZZQDb62IgVqybSNb23rnFg7QJzsB+WhgdZ8NptLhUE3nJ/42od3CsXaidPMi0j
 eyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tlpzu2FnVCttuisHkaaEDWy4Rmkog/SML4NQKupN9mk=;
 b=EtB6YWfl8q+TbVahXXcfDevyQ89nW+utZ9I1yDJ4fOaWCI6vWG2HsXvIW58XjyYp19
 nqHrPuFyB5tpOPWHAseoFjmFUtLj/NG8Q/H+uQBpwrBzyMVz+p6lkvo/HO5KHaNkziGG
 duUsRdymWBgnnvnmMkXjemHoCsKI7B6oTvZZHvnNj88UQJGPwnQlAuZqj0FlqVeUUP3X
 Lf4EUFs1EH9ZucwxEte0jvpVLXQRW6HVH5Wkjjcq57JcQ2s8uuiWWnMQCi5Syunvf1gM
 nouEqxiAvMPpcWTfZw3zl+NmQx8ucNcDZNglkCBrRtR7whMGf9UHaWzH4PXlcNZS2INB
 EU0Q==
X-Gm-Message-State: ANhLgQ2f5vYUmtYBY1TYudLQtr2dx6/VKPGqav/xBDaQICdJ/I5ct0Zh
 1RsVOuaOuaikrg8+gWXgGuslUVOyhne8KIiQwz2ibQ==
X-Google-Smtp-Source: ADFU+vs/yZg+/zUhNXyBvDrXnEf/ZziUX73yTTuk1VWupGbbhMIvizWXzb2Ob8khiZnMjBgtQG/C/Z3SJqngyRfc+tw=
X-Received: by 2002:aca:5b07:: with SMTP id p7mr6620298oib.146.1584105692187; 
 Fri, 13 Mar 2020 06:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200313123014.206828-1-dgilbert@redhat.com>
In-Reply-To: <20200313123014.206828-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Mar 2020 13:21:21 +0000
Message-ID: <CAFEAcA8KPovUiycEr2hHb4LP0SL-hBCTNgkA9KFKMb6FQTceuQ@mail.gmail.com>
Subject: Re: [PATCH] exec/rom_reset: Free rom data during inmigrate skip
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 13 Mar 2020 at 12:31, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Commit 355477f8c73e9 skips rom reset when we're an incoming migration
> so as not to overwrite shared ram in the ignore-shared migration
> optimisation.
> However, it's got an unexpected side effect that because it skips
> freeing the ROM data, when rom_reset gets called later on, after
> migration (e.g. during a reboot), the ROM does get reset to the original
> file contents.  Because of seabios/x86's weird reboot process
> this confuses a reboot into hanging after a migration.
>
> Fixes: 355477f8c73e9 ("migration: do not rom_reset() during incoming migration")
> https://bugzilla.redhat.com/show_bug.cgi?id=1809380
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/core/loader.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>

>      QTAILQ_FOREACH(rom, &roms, next) {
>          if (rom->fw_file) {
>              continue;
>          }
> +        /*
> +         * We don't need to fill in the RAM with ROM data because we'll fill
> +         * the data in during the next incoming migration in all cases.  Note
> +         * that some of those RAMs can actually be modified by the guest on ARM
> +         * so this is probably the only right thing to do here.
> +         */
> +        if (runstate_check(RUN_STATE_INMIGRATE) && rom->data) {
> +            /*
> +             * Free it so that a rom_reset after migration doesn't overwrite a
> +             * potentially modified 'rom'.
> +             */
> +            rom_free_data(rom);

Shouldn't this condition match the condition in rom_reset()
for when we call rom_free_data()? You want the behaviour
on a subsequent reset to match the behaviour you'd get
if you did a reset on the source end without the migration.

> +        }
> +
>          if (rom->data == NULL) {
>              continue;
>          }

If you put this check above your new one you wouldn't
need to check rom->data in it. Also it would make the
loop structure better match rom_reset(), which checks
rom->fw_file first, then rom->data, then has the
condition for "do we need to call rom_free_data()".

thanks
-- PMM

