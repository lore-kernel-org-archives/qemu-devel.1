Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92556C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:25:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BCE5206E3
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsKOvgg9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BCE5206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyCsl-0003nk-Lk
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 07:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jyCrt-0002ph-Sz
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 07:25:01 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38835)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jyCrs-00084g-7H
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 07:25:01 -0400
Received: by mail-ot1-x344.google.com with SMTP id t18so1481678otq.5
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 04:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=t5KWV1R0LMaaX7K5sOGVepuyHhOZNziyCoYd/ECVp5Q=;
 b=WsKOvgg99Usfvs/e/HtQUtG1eJ1VbHZcmJDSw1ddlsBMthxxB89DelF7KxTpUvuLRb
 i1Pw7+4XNsSfbF2ZLeT/9HjipJEscUUde/mKqnGy8i+bnBkuMAhDNnakZdSLhSH/7pln
 k93InNsvExVliU37BjLxhg8p67hBIFgvWR4BNav9LkBgMBpB8NjOslO+uaSF3tbK6c+r
 2F9p1eATzPmCLv2yvM8GUm4RXEupeTipFbpLTDNtJlIMlYCyGUL2xl6TcypmBcMl5mL0
 dv6la2PtPzv5G9uHKb5GUgnyvSzqOrRcN8uiwJ6+U4/5drLjq9Jo3I+7mJGWOCHsB+tv
 nI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=t5KWV1R0LMaaX7K5sOGVepuyHhOZNziyCoYd/ECVp5Q=;
 b=V90utcvNIUyRtRNzIXs4fs/Va0GtW98+zWmcH+5pRbdfroy2qMpUcGdyTPFJmUpHWb
 8Ic9uQO7O2gHHkLVMXNou/KoVsIFHC5F1VgdiG4E0/JVEut9TMpW0TV4J6eO7ne9cIbn
 jAeGR/6iiONmtQeCIn6qGdSrLaylcrlZB0rnfw41yNNaEfDH7hQCzdxy66LZMW095nYZ
 4pyIo/lm0Rt3RpKctFGi9sj4ATX1DB4Fi2kYo929hLDpa5rPxhfMOPPMtd8j9paIC7Ve
 I0wtDcpqnmhFa8llc8yJrFHoUuRAZTbVKkctktcWD78DaL655Gi2SNUCCC7CETEC6Ud+
 KphA==
X-Gm-Message-State: AOAM533DiSUJ4Q6MSS9ULkEl6fVd1nJsxDEWLz63SPvRm+NPt+vmdh3S
 u5i1fmIYD9cKiw14Xgzqc2zND26p5uau+g4GQzU=
X-Google-Smtp-Source: ABdhPJydGCbrvE/jdzk4ebLO6gARMqb7IyvPfg2JywqUDP1xLL0TScYeGTbtMmTSTvpOWtuchtf9weDE7AYY3fT0KIs=
X-Received: by 2002:a05:6830:15c3:: with SMTP id
 j3mr25972626otr.353.1595417099027; 
 Wed, 22 Jul 2020 04:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200722085747.6514-1-jasowang@redhat.com>
 <20200722085747.6514-2-jasowang@redhat.com>
In-Reply-To: <20200722085747.6514-2-jasowang@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 22 Jul 2020 19:24:23 +0800
Message-ID: <CAKXe6SJ2=RFAyun+X44qVPooBT85NC1doa1svT6H4NFQgq2H8A@mail.gmail.com>
Subject: Re: [PATCH 2/2] e1000e: make TX reentrant
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x344.google.com
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?B?5p2O5by6?= <liq3ea@163.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Alexander Bulekov <alxndr@bu.edu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Jason Wang <jasowang@redhat.com> =E4=BA=8E2020=E5=B9=B47=E6=9C=8822=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=884:58=E5=86=99=E9=81=93=EF=BC=9A
>
> In loopback mode, e1000e RX can DMA into TX doorbell which requires
> TX to be reentrant. This patch make e1000e's TX routine reentrant by
> introducing a per device boolean for recording whether or not a TX
> rountine is being called and return early.
>

Could we introduce a per-queue 'sending' variable just like the RX.
So we can do this in net core layer.

Thanks,
Li Qiang

> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  hw/net/e1000e_core.c | 8 ++++++++
>  hw/net/e1000e_core.h | 1 +
>  2 files changed, 9 insertions(+)
>
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index bcd186cac5..8126a644a5 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -923,6 +923,12 @@ e1000e_start_xmit(E1000ECore *core, const E1000E_TxR=
ing *txr)
>          return;
>      }
>
> +    if (core->sending) {
> +        return;
> +    }
> +
> +    core->sending =3D true;
> +
>      while (!e1000e_ring_empty(core, txi)) {
>          base =3D e1000e_ring_head_descr(core, txi);
>
> @@ -940,6 +946,8 @@ e1000e_start_xmit(E1000ECore *core, const E1000E_TxRi=
ng *txr)
>      if (!ide || !e1000e_intrmgr_delay_tx_causes(core, &cause)) {
>          e1000e_set_interrupt_cause(core, cause);
>      }
> +
> +    core->sending =3D false;
>  }
>
>  static bool
> diff --git a/hw/net/e1000e_core.h b/hw/net/e1000e_core.h
> index aee32f7e48..4679c1761f 100644
> --- a/hw/net/e1000e_core.h
> +++ b/hw/net/e1000e_core.h
> @@ -114,6 +114,7 @@ struct E1000Core {
>      void (*owner_start_recv)(PCIDevice *d);
>
>      uint32_t msi_causes_pending;
> +    bool sending;
>  };
>
>  void
> --
> 2.20.1
>

