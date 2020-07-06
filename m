Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F2AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:41:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 149DA206CD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lz5ECbOy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 149DA206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUBV-0001re-CX
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 12:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsU9u-0008OF-KH; Mon, 06 Jul 2020 12:39:58 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:37224)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsU9s-0002Wc-Vf; Mon, 06 Jul 2020 12:39:58 -0400
Received: by mail-io1-xd41.google.com with SMTP id v6so26369100iob.4;
 Mon, 06 Jul 2020 09:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Ue0OHpnGngrrU7juIEoksqqRSjRBw9oYPpTZgYSRfCA=;
 b=lz5ECbOyI3/k4uNN+2GM++lN9clZU0TDN/N0w+9zG9b5FlNP/mP6WzfiBKQkHbzLAi
 tk4cJnI4sgPee+v74fa+I2am8InKFTVrxz4d/I4LO/vIjYXd1Ca67efZ7v27qKNJrO8T
 tjAA8dZ5r3cDdyl4XGBhTO6/NRSfuIjPwjvLKbLPD0+xW+CN7h5hLrVXJPvr+an9SZe+
 P+hSyk+iAr8sfhZ24i9XQaevdPMgHUdf5P+nDhaEgU+JstvQtZLDfZx+7jkuAcmR10Su
 H6PozprwkhVN3ibAhqJPllbO4LKrth//+cw0axIDlb+PhZPAMZZlp9ZhcQHbFHOmUlg/
 FoIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Ue0OHpnGngrrU7juIEoksqqRSjRBw9oYPpTZgYSRfCA=;
 b=b3FiBdBjoosEK4/y4RaO9kQaDm/Qpn4LyVYgIdpL1GSwdmQzS6uh0jKEUEIoIabUGn
 nuu0zF/DjA41dRL8rma2xSNcOUyGZUp4IB/E8i1RrkpRMxouQ93ikKEasecoBfNYGPr0
 DarX14VXSeMlBSs8CPKtRBmH6gXhiAKLhk3Vlj1HmGaCxKqAZ2qGl2aML+mU1FMht2Tl
 iSVk8nziZUn8PLIWPhVj5Trg8yv0eY2Y+Y4b6/MkjvZcfdw1tvgjWfKuWfVfr2s51B4i
 ziaDuYWoT7mm66DEbDgA3dnXct9qUOsNAr2Jw6AWosMoTgTqzPIiJnyXPGz53VfLZ3Xp
 5eBA==
X-Gm-Message-State: AOAM531ogt7Z8LbMveK/AVokWWGQLOu0KqVSXPLtGOlp4ZOQ27nDxTOw
 /iVfCK06UR1bZ+WONUYSpfntUJ5m19OpS5SnyCA=
X-Google-Smtp-Source: ABdhPJwUxoZmEp0WsS4WmgK0IJ6FcjqkWUyTu7BqsEBSyxIsMZrLpxtE8Slr22ycYzVOw1ExOwcOo450rtCdAn7WjvM=
X-Received: by 2002:a5d:9ed0:: with SMTP id a16mr26149131ioe.176.1594053595584; 
 Mon, 06 Jul 2020 09:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200630133912.9428-1-f4bug@amsat.org>
 <20200630133912.9428-13-f4bug@amsat.org>
In-Reply-To: <20200630133912.9428-13-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2020 09:30:06 -0700
Message-ID: <CAKmqyKOxHOy0tfXvo5Q1n1v=h8MrTD=8=9vW0eozofHeTjG6nA@mail.gmail.com>
Subject: Re: [PATCH v7 12/17] hw/sd/sdcard: Simplify cmd_valid_while_locked()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 30, 2020 at 6:44 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> cmd_valid_while_locked() only needs to read SDRequest->cmd,
> pass it directly and make it const.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/sd/sd.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 723e66bbf2..2946fe3040 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1678,7 +1678,7 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
>      return sd_illegal;
>  }
>
> -static int cmd_valid_while_locked(SDState *sd, SDRequest *req)
> +static int cmd_valid_while_locked(SDState *sd, const uint8_t cmd)
>  {
>      /* Valid commands in locked state:
>       * basic class (0)
> @@ -1689,13 +1689,12 @@ static int cmd_valid_while_locked(SDState *sd, SD=
Request *req)
>       * Anything else provokes an "illegal command" response.
>       */
>      if (sd->expecting_acmd) {
> -        return req->cmd =3D=3D 41 || req->cmd =3D=3D 42;
> +        return cmd =3D=3D 41 || cmd =3D=3D 42;
>      }
> -    if (req->cmd =3D=3D 16 || req->cmd =3D=3D 55) {
> +    if (cmd =3D=3D 16 || cmd =3D=3D 55) {
>          return 1;
>      }
> -    return sd_cmd_class[req->cmd] =3D=3D 0
> -            || sd_cmd_class[req->cmd] =3D=3D 7;
> +    return sd_cmd_class[cmd] =3D=3D 0 || sd_cmd_class[cmd] =3D=3D 7;
>  }
>
>  int sd_do_command(SDState *sd, SDRequest *req,
> @@ -1721,7 +1720,7 @@ int sd_do_command(SDState *sd, SDRequest *req,
>      }
>
>      if (sd->card_status & CARD_IS_LOCKED) {
> -        if (!cmd_valid_while_locked(sd, req)) {
> +        if (!cmd_valid_while_locked(sd, req->cmd)) {
>              sd->card_status |=3D ILLEGAL_COMMAND;
>              sd->expecting_acmd =3D false;
>              qemu_log_mask(LOG_GUEST_ERROR, "SD: Card is locked\n");
> --
> 2.21.3
>
>

