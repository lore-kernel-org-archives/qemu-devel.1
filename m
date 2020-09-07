Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6D2C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:08:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 460A52080A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5FOIo+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 460A52080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kF5eH-0007ov-8w
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 21:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kF5d7-0006F0-11; Sun, 06 Sep 2020 21:07:33 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34043)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kF5d5-0002AZ-7S; Sun, 06 Sep 2020 21:07:32 -0400
Received: by mail-oi1-x241.google.com with SMTP id n2so877733oij.1;
 Sun, 06 Sep 2020 18:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CWeUyalRZKyv47D+DQgcFYDymOJ29YGbRZ4btB1r6/w=;
 b=c5FOIo+mCSg5m1XO5ojP11Yjh5ygfe3IttyQeyS1wU2VFwAg5i2xYQwlqPNcGPrJ4I
 mzB2zX3tvHVBuY102sODUjQqQQvOkh9kfuvlwT94q4AjH4s36/e2hsd89g75knucR+YD
 RB3BsETxsh84A6ibSRrS9Kgyg95BSiVYquQYhYftuNjezu1gPf+KZ6Tll0GYJUgrhxLW
 8zV/5N/dTVNZJdIG+4ZOmqfh1TR1KNeO7OKPqZuu3MyJrxdzy/xFXnFsgfuT/pFU6M/+
 4b0bYA2cEAkZfa9wguPriUEr1skudMPe/rqqEr76P7ZPJLDHPyFxzrwMbQnqM7ehvEnZ
 64tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CWeUyalRZKyv47D+DQgcFYDymOJ29YGbRZ4btB1r6/w=;
 b=jtckayb9pK5W6RVctate4CtmUVpEHg6Aff8Jep9fiLZWtju4C8YziQ4ExvLCUWR4ft
 6xTWuQkC1lgbhfuxMcwpQ289QopVomTZyxt1io6ibBQBwg+rM/ekYd9PTqNS/WoNZnW3
 KFnaB+Zm3EMz6m0DlLobbdpuc+P5+0UjP6qlP1GyQa13tNingaUNR9pJhhznX9l4Qxoe
 F875nVX3MByLpV5NC8smLsvkCN1n9KjTfX1xMjeaHQ+OwhMhJhDa8GL6Xojxo2oHJ9Nn
 RbgEN9FiF6BySF0v6Jtx7aXVaYxZD8axpCv8tIPBPwYpe5shR7HJ64jExZ/wTC8Z9xyb
 PniA==
X-Gm-Message-State: AOAM530EgRjkTJlba4q2rGsAZBQmdFu40sw/gC9UwvEhRhCzgqMLdqI1
 IyrRS4rONpckCUNS6Yz3PufR7UoWbPp6KVHiMUo=
X-Google-Smtp-Source: ABdhPJzQy2xNWgC/shOFWqpBorTrl/pXRrgrsYvBc08yS/Dk3sIwqIo7kNWNeFFIgiSN/Cju4Ec2+dbtzuPQs8ebpME=
X-Received: by 2002:aca:b808:: with SMTP id i8mr995266oif.150.1599440849250;
 Sun, 06 Sep 2020 18:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200904154439.643272-1-philmd@redhat.com>
 <20200904154439.643272-7-philmd@redhat.com>
In-Reply-To: <20200904154439.643272-7-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 7 Sep 2020 09:06:53 +0800
Message-ID: <CAKXe6SLz-XNOCL023Y0VM0oak6mTkzeFdkVAk_OZVm-4VwoEFg@mail.gmail.com>
Subject: Re: [PATCH 06/13] dma: Let dma_memory_read() propagate MemTxResult
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x241.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Qemu Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>, Joel Stanley <joel@jms.id.au>,
 Richard Henderson <rth@twiddle.net>, Laszlo Ersek <lersek@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=
=9C=884=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=8811:50=E5=86=99=E9=81=
=93=EF=BC=9A
>
> dma_memory_rw_relaxed() returns a MemTxResult type.
> Do not discard it, return it to the caller.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  include/sysemu/dma.h | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
> index 661d7d0ca88..2961a96ad67 100644
> --- a/include/sysemu/dma.h
> +++ b/include/sysemu/dma.h
> @@ -89,8 +89,9 @@ static inline MemTxResult dma_memory_rw_relaxed(Address=
Space *as,
>                              buf, len, dir =3D=3D DMA_DIRECTION_FROM_DEVI=
CE);
>  }
>
> -static inline int dma_memory_read_relaxed(AddressSpace *as, dma_addr_t a=
ddr,
> -                                          void *buf, dma_addr_t len)
> +static inline MemTxResult dma_memory_read_relaxed(AddressSpace *as,
> +                                                  dma_addr_t addr,
> +                                                  void *buf, dma_addr_t =
len)
>  {
>      return dma_memory_rw_relaxed(as, addr, buf, len, DMA_DIRECTION_TO_DE=
VICE);
>  }
> @@ -124,8 +125,20 @@ static inline MemTxResult dma_memory_rw(AddressSpace=
 *as, dma_addr_t addr,
>      return dma_memory_rw_relaxed(as, addr, buf, len, dir);
>  }
>
> -static inline int dma_memory_read(AddressSpace *as, dma_addr_t addr,
> -                                  void *buf, dma_addr_t len)
> +/**
> + * dma_memory_read: Read from an address space from DMA controller.
> + *
> + * Return a MemTxResult indicating whether the operation succeeded
> + * or failed (eg unassigned memory, device rejected the transaction,
> + * IOMMU fault).  Called within RCU critical section.
> + *
> + * @as: #AddressSpace to be accessed
> + * @addr: address within that address space
> + * @buf: buffer with the data transferred
> + * @len: length of the data transferred
> + */
> +static inline MemTxResult dma_memory_read(AddressSpace *as, dma_addr_t a=
ddr,
> +                                          void *buf, dma_addr_t len)
>  {
>      return dma_memory_rw(as, addr, buf, len, DMA_DIRECTION_TO_DEVICE);
>  }
> --
> 2.26.2
>
>

