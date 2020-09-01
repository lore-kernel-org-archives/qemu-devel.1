Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE6AC433E7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:59:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 075ED206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7fXOuvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 075ED206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD34W-0004dj-7X
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 05:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kD2xp-0000jI-PB
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:52:29 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:36984)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kD2xo-0003MD-4M
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:52:29 -0400
Received: by mail-oi1-x243.google.com with SMTP id e6so623260oii.4
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 02:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=y36gKxXjdFleZJ9I4tSMoU3tvP54P/Bs++5Hc7QLbQE=;
 b=C7fXOuvsQa4d4a5QZ9JJ0LQQFtttGYGFDArBZra/HftIZdaazbHisQSMf835hBZCht
 ynudQU71wYkdvv7WunMqFHUIMfnAkpv3t8a239JHi/uRlmKnaQJt6JaXztbeoIGormuJ
 GwYc2Jl5ceJE9neD6P34r9tQto2nrYzudYfTUPef9kl0plQB3jGtd0ubcZ+qElYqiLr3
 FUA0ZCpvq5DJr1wJrBzsVXSl+P7946jRpumsfDMhuUsURYOD9c5SR8pYTUTW259xvH55
 HgLrPpU4yX94+dWC35v/21rUFU1hZjaeFQl7ZSHoWIfY4+PRhreKH1YjktjOOfCcm6l4
 1uZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=y36gKxXjdFleZJ9I4tSMoU3tvP54P/Bs++5Hc7QLbQE=;
 b=r/+YaGZwWMLle2oWtG46hP+DZkH1AD0g42+/a5Flio2qLYYRmn9ZkjwCeW/yFe9KA+
 71LbyB9keKel/DrYA/MjfEW4ApefKS0N1WFwhNG+wOtaOTtZArhSXzwi7zrHqZf9B3Jt
 DGh1L61VTiTpe+h6ET7HtEvtk3hbdToEon7iks+RR2/1dHOOmjp+JzATnkS+F/OH4Gq5
 923GgQaX4Kz6QznwyAlRK7up+jv0rlg/VH60qj6QxcbgJ5oJxsUcLDyRisHehbuTvxmk
 JYXULMnSLBOYXwGH+JVPFNLvM+M8Ix8onB2j32g3ei6xSZbWEIHn8PRLbd7dTNbZkQzO
 mJYQ==
X-Gm-Message-State: AOAM533t6ofpr6UW6ZSZz2HO1Hg+i3/2WRyDomlP6jINkwaH6+hGDE3Z
 b3UQWwBWLh1ofhLbpirSkYW3BoURyalupc8T4qE=
X-Google-Smtp-Source: ABdhPJy+ZTiMeYbj32QgCBUHHloQIzylZPdWrMquDU595VLjQOAyhWVo8PEtpULOB45XA4dyrRoJaBo4nPoDKkHGhpc=
X-Received: by 2002:aca:c0c1:: with SMTP id q184mr631355oif.56.1598953946841; 
 Tue, 01 Sep 2020 02:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200901052723.15492-1-kraxel@redhat.com>
In-Reply-To: <20200901052723.15492-1-kraxel@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 1 Sep 2020 17:51:50 +0800
Message-ID: <CAKXe6S+Vs6=KchQ4gi3wg9e1J6iWfGWYJUx7k5udB41m589ZPA@mail.gmail.com>
Subject: Re: [PATCH] usb: call usb_packet_cleanup on usb_packet_map failure
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x243.google.com
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
Cc: Qemu Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Gerd Hoffmann <kraxel@redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=881=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=881:28=E5=86=99=E9=81=93=EF=BC=9A
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/usb/hcd-ehci.c | 2 ++
>  hw/usb/hcd-xhci.c | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> index 2b995443fbfd..67847a9cf5f1 100644
> --- a/hw/usb/hcd-ehci.c
> +++ b/hw/usb/hcd-ehci.c
> @@ -1373,6 +1373,7 @@ static int ehci_execute(EHCIPacket *p, const char *=
action)
>          usb_packet_setup(&p->packet, p->pid, ep, 0, p->qtdaddr, spd,
>                           (p->qtd.token & QTD_TOKEN_IOC) !=3D 0);

Hi Gerd,

=E2=80=99usb_packet_setup=E2=80=98 doesn't modify the 'iov' and other resou=
rces.

'usb_packet_cleanup' is paired with 'usb_packet_init' which I think should =
be
processed in the more up layer.

If 'usb_packet_map' fails, we need to clean the 'iov' in
'usb_packet_map' itself.


Thanks,
Li Qiang

>          if (usb_packet_map(&p->packet, &p->sgl)) {
> +            usb_packet_cleanup(&p->packet);
>              qemu_sglist_destroy(&p->sgl);
>              return -1;
>          }
> @@ -1456,6 +1457,7 @@ static int ehci_process_itd(EHCIState *ehci,
>                  usb_packet_setup(&ehci->ipacket, pid, ep, 0, addr, false=
,
>                                   (itd->transact[i] & ITD_XACT_IOC) !=3D =
0);
>                  if (usb_packet_map(&ehci->ipacket, &ehci->isgl)) {
> +                    usb_packet_cleanup(&ehci->ipacket);
>                      qemu_sglist_destroy(&ehci->isgl);
>                      return -1;
>                  }
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index 46a2186d912a..9b156048920d 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -1616,6 +1616,7 @@ static int xhci_setup_packet(XHCITransfer *xfer)
>      usb_packet_setup(&xfer->packet, dir, ep, xfer->streamid,
>                       xfer->trbs[0].addr, false, xfer->int_req);
>      if (usb_packet_map(&xfer->packet, &xfer->sgl)) {
> +        usb_packet_cleanup(&xfer->packet);
>          qemu_sglist_destroy(&xfer->sgl);
>          return -1;
>      }
> --
> 2.27.0
>
>

