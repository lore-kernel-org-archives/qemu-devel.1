Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F71C4741F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 14:56:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F280A2076B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 14:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+aIZlGs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F280A2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNH2v-0005su-Ox
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 10:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kNH1A-0004HY-UQ; Tue, 29 Sep 2020 10:54:12 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:32802)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kNH18-0003gp-P4; Tue, 29 Sep 2020 10:54:12 -0400
Received: by mail-oi1-x232.google.com with SMTP id m7so5778841oie.0;
 Tue, 29 Sep 2020 07:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wDyOV+2IqsNaikDuoZQo4vsGpBCfgsOifh/LZ3kHFUo=;
 b=F+aIZlGsD4/8+sntiRQ4wEMi5JH13WJt7H06vCtv/MWWM00ed1jXiqXYRqoLKKXF3S
 2aoWV2q7OCiX6xfZTfR4rV2DyEEa2T9ThAn05RiO+cgts0E+fCToPQXwwPxUDzLJUDM+
 J/3GfZb8rkov0xn0BO+5oZZ8S7GaQKPmidWSSnnWp0lshq2S/ybhmYsfavcYmivLeG+m
 qRMFZ1sU/JyJ/MKvlXlaMof+7x8iuViEdP+rHBTwi7Afjnap9yFG7hwFGSEEyUYi3fIy
 6GObjDSIZwHOa99qo61VhNP2MptSNIZ3rCPyhvPZ886C/QoRZ5DDqCh0pwqUUxrdcxky
 iraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wDyOV+2IqsNaikDuoZQo4vsGpBCfgsOifh/LZ3kHFUo=;
 b=Ljszpl3UssP2JJXmqW8puNDJDKeZ4Atli2JJMl1ysF7If6bzv1AV1AVxLpQjHw+u+g
 c+1oHZf4FZbCO/x5KEnc4Ifg8DVVRgQVLhpdXRS9Yu0eL7/tHIZWayDN+XB/ob5ll4Ua
 HyOzx/Tm28VGR5CDGishvpHol3RG6uvyLz5PqPSlkk7AiuM+EhJb5PcTulVxpGcibThd
 O8LmYPPZft/OIihWVT9f5GXItj1WdD4NO2G1k+6BTJG9L2tziCES/jB23YFnVGBrMZyZ
 ZD94gMgcd8iTvwmQ3DiPHXsEh7Wb4fvYMbIf2yuh8T1/xJ10QPJ3x/JVpcC12Sd0yRRO
 QOSA==
X-Gm-Message-State: AOAM531HYHDryVcbqArq//r6C2L1bbp1jZWZ/VfpUIdU6cB2k8kEOkeq
 hhuL7yqv1j99DHHG1LZQ0nYYlbwYZfj9/1P5Rhs=
X-Google-Smtp-Source: ABdhPJwKeUqWoI6mhmTOU8XIIhn/GRhza266/2TbqeyWU3A7NIhFt+8KZbWIXFRqqD91oJDvbR3IMoExAdOJ9TnCpAw=
X-Received: by 2002:a54:4d88:: with SMTP id y8mr2885891oix.97.1601391248775;
 Tue, 29 Sep 2020 07:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200903183138.2161977-1-ppandit@redhat.com>
 <CAKXe6SLv1HX5_ty2SP5F_MkVKYO-tz5fNOKhpqZr0mH_ePypSA@mail.gmail.com>
 <nycvar.YSQ.7.78.906.2009181427350.10832@xnncv>
 <CAKXe6SL6BFErCqk+AJt2iQiQsCN_EvHJCur=Y8J1yz7F_c8t4A@mail.gmail.com>
 <nycvar.YSQ.7.78.906.2009291106100.10832@xnncv>
In-Reply-To: <nycvar.YSQ.7.78.906.2009291106100.10832@xnncv>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 29 Sep 2020 22:53:32 +0800
Message-ID: <CAKXe6SKBhVXfvAxQDUTjc7PeR5PPiOMHfZxLSmoQcgYYFcftfQ@mail.gmail.com>
Subject: Re: [PATCH v2] hw/ide: check null block before _cancel_dma_sync
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x232.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Ruhr-University <bugs-syssec@rub.de>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

P J P <ppandit@redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=8829=E6=97=A5=E5=
=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=882:22=E5=86=99=E9=81=93=EF=BC=9A
>
>   Hello Li,
>
> +-- On Fri, 18 Sep 2020, Li Qiang wrote --+
> | P J P <ppandit@redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=8818=E6=97=A5=
=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=886:26=E5=86=99=E9=81=93=EF=BC=9A
> | > +-- On Fri, 18 Sep 2020, Li Qiang wrote --+
> | > | Update v2: use an assert() call
> | > |   ->https://lists.nongnu.org/archive/html/qemu-devel/2020-08/msg083=
36.html
> |
> | In 'ide_ioport_write' the guest can set 'bus->unit' to 0 or 1 by issue
> | 'ATA_IOPORT_WR_DEVICE_HEAD'. So this case the guest can set the active =
ifs.
> | If the guest set this to 1.
> |
> | Then in 'idebus_active_if' will return 'IDEBus.ifs[1]' and thus the 's-=
>blk'
> | will be NULL.
>
> Right, guest does select the drive via
>
>   portio_write
>    ->ide_ioport_write
>       case ATA_IOPORT_WR_DEVICE_HEAD:
>       /* FIXME: HOB readback uses bit 7 */
>       bus->ifs[0].select =3D (val & ~0x10) | 0xa0;
>       bus->ifs[1].select =3D (val | 0x10) | 0xa0;
>       /* select drive */
>       bus->unit =3D (val >> 4) & 1;     <=3D=3D set bus->unit=3D0x1
>       break;
>
>
> | So from your (Peter's) saying, we need to check the value in
> | 'ATA_IOPORT_WR_DEVICE_HEAD' handler. To say if the guest
> | set a valid 'bus->unit'. This can also work I think.
>
> Yes, with the following fix, an assert(3) in ide_cancel_dma_sync fails.
>
> =3D=3D=3D
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index f76f7e5234..cb55cc8b0f 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -1300,7 +1300,11 @@ void ide_ioport_write(void *opaque, uint32_t addr,
> uint_)
>          bus->ifs[0].select =3D (val & ~0x10) | 0xa0;
>          bus->ifs[1].select =3D (val | 0x10) | 0xa0;
>          /* select drive */
> +        uint8_t bu =3D bus->unit;
>          bus->unit =3D (val >> 4) & 1;
> +        if (!bus->ifs[bus->unit].blk) {
> +            bus->unit =3D bu;
> +        }
>          break;
>      default:
>
> qemu-system-x86_64: ../hw/ide/core.c:724: ide_cancel_dma_sync: Assertion =
`s->bus->dma->aiocb =3D=3D NULL' failed.
> Aborted (core dumped)

This is what I am worried, in the 'ide_ioport_write' set the
'bus->unit'. It also change the 'buf->ifs[0].select'.
Also there maybe some other corner case that causes some inconsistent.
And if we choice this method we need to deep into the more ahci-spec to
know how things really going.


> =3D=3D=3D
>
> | As we the 'ide_exec_cmd' and other functions in 'hw/ide/core.c' check t=
he
> | 's->blk' directly. I think we just check it in 'ide_cancel_dma_sync' is
> | enough and also this is more consistent with the other functions.
> | 'ide_cancel_dma_sync' is also called by 'cmd_device_reset' which is one=
 of
> | the 'ide_cmd_table' handler.
>
>   Yes, I'm okay with either approach. Earlier patch v1 checks 's->blk' in
> ide_cancel_dma_sync().

I prefer the 'check the s->blk in the beginning of ide_cancel_dma_sync' met=
hod.
Some little different with your earlier patch.

Anyway, let the maintainer do the choices.

Thanks,
Li Qiang

>
> | BTW, where is the Peter's email saying this, just want to learn somethi=
ng,
> | :).
>
>   -> https://lists.nongnu.org/archive/html/qemu-devel/2020-09/msg05820.ht=
ml
>
> Thank you.
> --
> Prasad J Pandit / Red Hat Product Security Team
> 8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D

