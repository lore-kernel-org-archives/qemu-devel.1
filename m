Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AC8C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 21:03:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C8AA2074D
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 21:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtZcODxS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C8AA2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqNPp-0004ET-FR
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 17:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jqNOF-000344-IL; Tue, 30 Jun 2020 17:02:03 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:35960)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jqNOD-0005iS-RT; Tue, 30 Jun 2020 17:02:03 -0400
Received: by mail-io1-xd41.google.com with SMTP id y2so22597030ioy.3;
 Tue, 30 Jun 2020 14:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=InGJbraVxG/kUlDkU/RtrndrD8/88qDbhcRi4HR1b4Y=;
 b=OtZcODxSD2LGi7MdJbSabkrG1Pk2x0zavcbuo8UvxYkP1AES3dXE5nK/OXkAmUavL9
 w27atzw5ItnBRPZWRtGVxGasonMdlTRG6VTx9o/x/Riv7QEPU9AIwyST8hA69gLmLfjp
 /mFAnxhNuDf4kzK340xS7Fq9StQQYsvS20TWFiXIpJL1DgYK6Iwaa92UL+kvg1KvkLDh
 MGY8pIl10+AaK0vL+57z7XiBb+wcqSxRBn/GdIWiCgBh0IxK7oLgfI1DXoRq8ANqqkOg
 4XC/VMhftd7c2dII2nM9Srtc/ojVvSMeJ+hgIdCQzxokXQ68ae/ho8XHFkpObTnESEmA
 aL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=InGJbraVxG/kUlDkU/RtrndrD8/88qDbhcRi4HR1b4Y=;
 b=R4/MS8j/Kp0BRKlkpRwpY06ngkyCrDpVlIQmx11NxerFegqLfDAHjcw+BMplSz4dVZ
 6tFGQo6pgUMUtw7RwLf9TJIj2GpVPImp0nbLbb4wnPF/Ge0e/5iTh0C4DZY7u445vLPj
 DEb40et0zG1Yczqev7I4vpG65eqpgg+gIsbplwxXgf5TTT1qh89OwOSzFxBzByBcgaBu
 pDVTiec91U1pCQRfRiYynkHIeF7QFF1LMuvVTcUDN++Mdm3DygH0XOwPF8DFeE3Xx+kg
 PMN+VEBec5Skt31GTmegyy7Gthwj9zsPiUIe39HHR0IlUM1bsqkdm3v2q1EzAx9HXdVl
 Onqg==
X-Gm-Message-State: AOAM532H/SG/Km87UFsyVWEp5LFsXeoHob8yjPjQPRYESrHsK3Kmowuv
 MHb6jN6JT88R4hnrH82j0Z3pqHud1uvFaA9SJlg=
X-Google-Smtp-Source: ABdhPJwmupILyY273LUU0B4L2qVT6nnqZhXBL1Hw/poEPlwzeBDW0PqqENkkvFdXkCeL9QLbLykq23QsNELg4WnOH7w=
X-Received: by 2002:a02:1a06:: with SMTP id 6mr25838650jai.8.1593550919596;
 Tue, 30 Jun 2020 14:01:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200628142429.17111-1-peter.maydell@linaro.org>
 <20200628142429.17111-8-peter.maydell@linaro.org>
In-Reply-To: <20200628142429.17111-8-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Jun 2020 13:52:14 -0700
Message-ID: <CAKmqyKObpLa774FLLvHoO8=kE+054oU_fX3C87Cwj+-mfzSA5g@mail.gmail.com>
Subject: Re: [PATCH 07/17] hw/misc/max111x: Don't use vmstate_register()
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jun 28, 2020 at 7:25 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The max111x is a proper qdev device; we can use dc->vmsd rather than
> directly calling vmstate_register().
>
> It's possible that this is a migration compat break, but the only
> boards that use this device are the spitz-family ('akita', 'borzoi',
> 'spitz', 'terrier').
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/misc/max111x.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/hw/misc/max111x.c b/hw/misc/max111x.c
> index d0e5534e4f5..abddfa3c660 100644
> --- a/hw/misc/max111x.c
> +++ b/hw/misc/max111x.c
> @@ -140,8 +140,6 @@ static int max111x_init(SSISlave *d, int inputs)
>
>      s->inputs = inputs;
>
> -    vmstate_register(VMSTATE_IF(dev), VMSTATE_INSTANCE_ID_ANY,
> -                     &vmstate_max111x, s);
>      return 0;
>  }
>
> @@ -206,6 +204,7 @@ static void max111x_class_init(ObjectClass *klass, void *data)
>
>      k->transfer = max111x_transfer;
>      dc->reset = max111x_reset;
> +    dc->vmsd = &vmstate_max111x;
>  }
>
>  static const TypeInfo max111x_info = {
> --
> 2.20.1
>
>

