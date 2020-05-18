Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45CCC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:10:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ED56204EC
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJhXbjBo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED56204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jajHb-0003Kr-Px
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 13:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jajCM-0003M6-1z; Mon, 18 May 2020 13:05:06 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:41483)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jajCL-0004W4-0e; Mon, 18 May 2020 13:05:05 -0400
Received: by mail-io1-xd42.google.com with SMTP id o5so11361548iow.8;
 Mon, 18 May 2020 10:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9gaT2qzA0EcvTGr2l5yw/rsZT6fOlXWQUdgJOrhUF2I=;
 b=KJhXbjBorbaGGgmm7NzV/987bi5PCnxwO8OEnbuL2Rx8PeLU0LiEwpumLwxSuLNIXw
 apfMe+1Yc40v3kzHkJeCVWgdJ00MabCUceLD0wCikUHL6up3qfz4/8kli+dJBXpkZ2MU
 d1LUvT+5GIOPYaA9fgzOFPLB8PETj/BINbV7mjjXIxdRs157QiPgyAes00p7m7liEMZ+
 hsqmbfmXjcSr2xwwhzcIL82bzA1iCGYyf0Lj/v2McqQmhPr31E0c/K9IYXIit+FS4TSZ
 ahO7+J5yCHc8N34hh0xd09FHnXHZu8T5kOZGHobQ5PJ/NoEjR/kqUDK6j4aXaE6AuArj
 lUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9gaT2qzA0EcvTGr2l5yw/rsZT6fOlXWQUdgJOrhUF2I=;
 b=b4bG45HmdPUx4eTsll1fsi8O38zxRA5kQtPyUM+pfVRIt05wfyprLNK45CvGdB2Wbn
 ovT8cN4YozHQA6tSqlovCtWL1I2t5VFT1y18pam4D8wUdmZ+wfz/v6gSQqTgf99JAJum
 uuWPaAdELqX1bcZgpWqPHz21JnDf+fJ2KS+gzw9TUbbH0GQkWK1KwF03bG/yaGHBAAWF
 dXGhWOF2bshwgJhABwaeYUYQMQQypGUTYFgWIICd7NUQj9IFxCjG3rZktFBgS8gIRGIY
 utiWVmIHiczBpgaIjSwx+p7myz/nNX8uFW87G6ouSPCQiPZVyWKl0FSIYPeiRiHqs772
 Qs+w==
X-Gm-Message-State: AOAM532mTJLZEAOzFwCATeWxw4enG1z3uChw/Cy9FBdqSCDADo7cbgKT
 5L/TNbPVRu8znxvy7BCyxF6H4UjUokWLzh4fxd4=
X-Google-Smtp-Source: ABdhPJx8iMSLdqKjkLDnfxjRV+qkTK11L0xlD9KXVT0UdPrnh3RWrix65wPRHWkxlZDTnAKWCcheu1VEdB6yIHO5O6M=
X-Received: by 2002:a6b:bf83:: with SMTP id
 p125mr15402529iof.118.1589821503626; 
 Mon, 18 May 2020 10:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-3-armbru@redhat.com>
In-Reply-To: <20200518050408.4579-3-armbru@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 May 2020 09:56:11 -0700
Message-ID: <CAKmqyKPdGc_akCv00NLnVyaRPTeikcGg_JP-7+LWVRA4CbGqcg@mail.gmail.com>
Subject: Re: [PATCH 02/24] display/xlnx_dp: Fix to realize "i2c-ddc" and
 "aux-to-i2c-bridge"
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 KONRAD Frederic <fred.konrad@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, May 17, 2020 at 10:14 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> xlnx_dp_init() creates these two devices, but they're never realized.
> Affects machine xlnx-zcu102.
>
> I wonder how this ever worked.  If the "device becomes real only on
> realize" thing actually works, then we've always been missing these
> two devices, yet nobody noticed.
>
> Fix by realizing them in xlnx_dp_realize().
>
> Fixes: 58ac482a66de09a7590f705e53fc6a3fb8a055e8
> Cc: KONRAD Frederic <fred.konrad@greensocs.com>
> Cc: Alistair Francis <alistair@alistair23.me>
> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-arm@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/display/xlnx_dp.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
> index 3e5fb44e06..bdc229a51e 100644
> --- a/hw/display/xlnx_dp.c
> +++ b/hw/display/xlnx_dp.c
> @@ -1264,9 +1264,13 @@ static void xlnx_dp_realize(DeviceState *dev, Error **errp)
>      DisplaySurface *surface;
>      struct audsettings as;
>
> +    qdev_init_nofail(DEVICE(s->aux_bus->bridge));
> +
>      qdev_init_nofail(DEVICE(s->dpcd));
>      aux_map_slave(AUX_SLAVE(s->dpcd), 0x0000);
>
> +    qdev_init_nofail(DEVICE(s->edid));
> +
>      s->console = graphic_console_init(dev, 0, &xlnx_dp_gfx_ops, s);
>      surface = qemu_console_surface(s->console);
>      xlnx_dpdma_set_host_data_location(s->dpdma, DP_GRAPHIC_DMA_CHANNEL,
> --
> 2.21.1
>
>

