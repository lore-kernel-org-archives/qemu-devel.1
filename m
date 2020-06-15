Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2378C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 14:22:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A102D206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 14:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e6mdrMpz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A102D206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkpzy-0005fM-U3
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 10:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkpyY-0003nU-OL
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 10:20:38 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38636)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkpyW-0004mN-UN
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 10:20:38 -0400
Received: by mail-oi1-x242.google.com with SMTP id c194so16033378oig.5
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 07:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=puwCcQ0mQDNezcQN17uDQ3Mi2C4oGaBJT/mMaYaKUUI=;
 b=e6mdrMpzmLJVrN/8YSfaiBZUUpDgGD1H8Y3JFjxML7TH08OVFVXG+ahUyd9yvKECF4
 pMV1gUaxuh4gupZcLwBYNXg26DShyjqKGXPkCfnltoZYNUYAe1TYSiSliyo85/wTmExD
 EPTN0WDPpL3yLMJamj13PiFP2URdkI82OIgy+c49OpMyn+xmQcmlro2qac9mhvbmjPJd
 0wyOokcT47AlYyNkVEOYsJ/r0IeaeX8lGfkfBkipK8ofl+8kV808f6cxA0za0Id+qGVS
 F3tHXxyqtZrGV4/LxXt15Au06PK0yTAJXkZsJinprKyhQth1cLaO7Q9f/KA8umdDUMkx
 7zfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=puwCcQ0mQDNezcQN17uDQ3Mi2C4oGaBJT/mMaYaKUUI=;
 b=UxA6kdzp4AvfKOscr42pIFfquHFqYfNC8PzQ5FSFvxv9zmJ4mDag1Fdf6QyudljuSL
 1GZ6IGo8AFjWwvJciEv6Blg0BhHROFmPRBbH/RsiUhJMal1r4bdw90QF7gLcqD8DTpTD
 KbsO/uMAy7GdBSwbHQ1VwQc5dz2wfPZxRJTpKSVfU4g1yad2iwhV2mLfwe95tnWm/rzm
 4jvln8o7rRQo0RE2rZQDwWuVs/kRpNMoJGVwDcDk6IGYkX6nCJMVLiQxiczOdwlC7Ycf
 GrtGNl1JkalBUfzKW8QZUgEH0KsmyLHNELBWX03LT55hvF1BFB7EcAbetV/X4cA6Ho1y
 LnSg==
X-Gm-Message-State: AOAM5326bKPgKVfwB0BIi6txGNu/GzZ50Xie+qO6WW0BlRDqKIHcvMHR
 Fl9XWtVcYOy8aGiOero/pOlYKGDHB062HowtUAhggw==
X-Google-Smtp-Source: ABdhPJxTPDyPGwiwfhHUBzTFRcWt93pLuRlQW/ANUGnKxIyh6ezth67+8T1PpHX3M6boJGeXNXG7/8mqiSUvkMoZRkE=
X-Received: by 2002:aca:5152:: with SMTP id f79mr8757780oib.146.1592230835604; 
 Mon, 15 Jun 2020 07:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200605102230.21493-1-philmd@redhat.com>
 <20200605102230.21493-10-philmd@redhat.com>
In-Reply-To: <20200605102230.21493-10-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jun 2020 15:20:24 +0100
Message-ID: <CAFEAcA9J6rHqi3TVVk15BkFFqm4+gXX0-860BkQy8BKLz3amLA@mail.gmail.com>
Subject: Re: [PATCH v3 09/11] hw/sd/sdcard: Correctly display the command name
 in trace events
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 5 Jun 2020 at 11:25, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> Some ACMD were incorrectly displayed. Fix by remembering if we
> are processing a ACMD (with current_cmd_is_acmd) and add the
> sd_current_cmd_name() helper, which display to correct name
> regardless it is a CMD or ACMD.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/sd/sd.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 952be36399..fad34ab184 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -114,6 +114,7 @@ struct SDState {
>      uint8_t pwd[16];
>      uint32_t pwd_len;
>      uint8_t function_group[6];
> +    bool current_cmd_is_acmd;

This is extra state, so strictly speaking it needs to be
migrated (though the only thing we would get wrong is a
possible wrong trace message after a migration load).

>      uint8_t current_cmd;
>      /* True if we will handle the next command as an ACMD. Note that thi=
s does
>       * *not* track the APP_CMD status bit!
> @@ -1687,6 +1688,8 @@ int sd_do_command(SDState *sd, SDRequest *req,
>                        req->cmd);
>          req->cmd &=3D 0x3f;
>      }
> +    sd->current_cmd =3D req->cmd;
> +    sd->current_cmd_is_acmd =3D sd->expecting_acmd;

I'm not 100% sure about moving the update of sd->current_cmd
down here -- if it's an illegal command that seems wrong.

>      if (sd->card_status & CARD_IS_LOCKED) {
>          if (!cmd_valid_while_locked(sd, req->cmd)) {
> @@ -1714,7 +1717,6 @@ int sd_do_command(SDState *sd, SDRequest *req,
>          /* Valid command, we can update the 'state before command' bits.
>           * (Do this now so they appear in r1 responses.)
>           */
> -        sd->current_cmd =3D req->cmd;
>          sd->card_status &=3D ~CURRENT_STATE;
>          sd->card_status |=3D (last_state << 9);
>      }
> @@ -1775,6 +1777,15 @@ send_response:
>      return rsplen;
>  }

thanks
-- PMM

