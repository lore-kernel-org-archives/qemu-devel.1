Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B20C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:08:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0AEE2080A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sny+GtOP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0AEE2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kF5de-0006P3-Rl
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 21:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kF5cU-0005KO-97; Sun, 06 Sep 2020 21:06:54 -0400
Received: from mail-oo1-xc42.google.com ([2607:f8b0:4864:20::c42]:36941)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kF5cS-000298-Ka; Sun, 06 Sep 2020 21:06:53 -0400
Received: by mail-oo1-xc42.google.com with SMTP id y25so2938569oog.4;
 Sun, 06 Sep 2020 18:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=mxiqoMKbpD68f498ShMYhEOnjLRX5EOYcBTxmM36PRI=;
 b=Sny+GtOPN25otssVqtLdDW9LapzM3KEAbZXdi7AViPjmMJSxx8C4hchSz6+sKKUTli
 ovO2G/nRkq9ImEZG2/BYQxpZF8xsyrR8B4OLoVTAbEX2ssDXcKOjOau+eOMbv1a/ztMq
 Sw1bs4RjZtXQ5dCF8x6xcOPUXfqT5XRDGrlxPBG8O/B75NxRGNl3fMLj2UznzejX8s6N
 4Q3ojOYGA2CEdCCF2ZU5PbZVQ2Im73XDSPp9HiOT0DudUgO5yj5BX9984HBoSlfMwZRa
 /ElxBVBhMRKiAaQusFmRa9VBtutki57DMvJlD/bdCCpasbSguu0R5S3jFNPVHdv3SpsH
 M3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mxiqoMKbpD68f498ShMYhEOnjLRX5EOYcBTxmM36PRI=;
 b=ZPYseU3oEHmDPH+k1KrYxRcqBJ5NJO6FUGttwZAHec/nj4R2HCnBpRncP2dayjnFT5
 7U2uuJM7LRapwd5tf9d47wCkbAuL3TQPCwPvU/2RQtbqZkH7Ime8SXiu8mnEdEQl5IyU
 w+cy6EEIx47dOG+Yg8h6vO+96PKtTX7+F8m54/tueGhQaVRWoko2c7Oty+XqHj7Z9blK
 4teaH3DE8NCuwdpYZ5l9/blZSCFNoUP0NCLV37Jti7c3LT/qkdBuLitSXKZNEQ64shPq
 6iSjq7Y9N000JCfLYgOsL78gFm955W7CW5Y217GQ+3aRZ3tPTFz2zMCSHGin6Zm5Ms9a
 PUOA==
X-Gm-Message-State: AOAM531kkW3VtgpSr8IkJEuG+rtXf1nxkuV+zcDb59sDH9uhLEt57RDF
 E1upEEUXsN/0Oh6xF2MO0P+6MMfs9GxF9gA04xw=
X-Google-Smtp-Source: ABdhPJyDijfu/ET3WbiYrelEIeFwYfevqogcXAcEAdl4knyki+NlOOWtdiawC6KlfpN+gSHEgjeW1oc/MgKYYrXdQfM=
X-Received: by 2002:a4a:ae4c:: with SMTP id a12mr5352468oon.60.1599440810499; 
 Sun, 06 Sep 2020 18:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200904154439.643272-1-philmd@redhat.com>
 <20200904154439.643272-6-philmd@redhat.com>
In-Reply-To: <20200904154439.643272-6-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 7 Sep 2020 09:06:14 +0800
Message-ID: <CAKXe6S+bbNFvN+u9vhRTxuQ2ZDqXaQEG7pKc=DtamjhJOUbRbA@mail.gmail.com>
Subject: Re: [PATCH 05/13] dma: Let dma_memory_rw() propagate MemTxResult
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c42;
 envelope-from=liq3ea@gmail.com; helo=mail-oo1-xc42.google.com
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
=9C=884=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=8811:46=E5=86=99=E9=81=
=93=EF=BC=9A
>
> address_space_rw() returns a MemTxResult type.
> Do not discard it, return it to the caller.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  include/sysemu/dma.h | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
> index ad8a3f82f47..661d7d0ca88 100644
> --- a/include/sysemu/dma.h
> +++ b/include/sysemu/dma.h
> @@ -80,12 +80,13 @@ static inline bool dma_memory_valid(AddressSpace *as,
>                                        MEMTXATTRS_UNSPECIFIED);
>  }
>
> -static inline int dma_memory_rw_relaxed(AddressSpace *as, dma_addr_t add=
r,
> -                                        void *buf, dma_addr_t len,
> -                                        DMADirection dir)
> +static inline MemTxResult dma_memory_rw_relaxed(AddressSpace *as,
> +                                                dma_addr_t addr,
> +                                                void *buf, dma_addr_t le=
n,
> +                                                DMADirection dir)
>  {
> -    return (bool)address_space_rw(as, addr, MEMTXATTRS_UNSPECIFIED,
> -                                  buf, len, dir =3D=3D DMA_DIRECTION_FRO=
M_DEVICE);
> +    return address_space_rw(as, addr, MEMTXATTRS_UNSPECIFIED,
> +                            buf, len, dir =3D=3D DMA_DIRECTION_FROM_DEVI=
CE);
>  }
>
>  static inline int dma_memory_read_relaxed(AddressSpace *as, dma_addr_t a=
ddr,
> @@ -101,9 +102,22 @@ static inline int dma_memory_write_relaxed(AddressSp=
ace *as, dma_addr_t addr,
>                                   DMA_DIRECTION_FROM_DEVICE);
>  }
>
> -static inline int dma_memory_rw(AddressSpace *as, dma_addr_t addr,
> -                                void *buf, dma_addr_t len,
> -                                DMADirection dir)
> +/**
> + * dma_memory_rw: Read from or write to an address space from DMA contro=
ller.
> + *
> + * Return a MemTxResult indicating whether the operation succeeded
> + * or failed (eg unassigned memory, device rejected the transaction,
> + * IOMMU fault).
> + *
> + * @as: #AddressSpace to be accessed
> + * @addr: address within that address space
> + * @buf: buffer with the data transferred
> + * @len: the number of bytes to read or write
> + * @dir: indicates the transfer direction
> + */
> +static inline MemTxResult dma_memory_rw(AddressSpace *as, dma_addr_t add=
r,
> +                                        void *buf, dma_addr_t len,
> +                                        DMADirection dir)
>  {
>      dma_barrier(as, dir);
>
> --
> 2.26.2
>
>

