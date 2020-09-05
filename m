Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0235DC43461
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 02:43:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70D3520791
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 02:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sCqqPnUW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D3520791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEOB1-0006OC-FD
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 22:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kEOAJ-0005Xw-ML
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 22:42:55 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:41973)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kEOAI-0001ic-2i
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 22:42:55 -0400
Received: by mail-oi1-x244.google.com with SMTP id x69so5398551oia.8
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 19:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=iSdodwwrRze00Mb6h6hlzJNUx9KQavRAmgXxBnJ8dbA=;
 b=sCqqPnUWqhx08jmV2TtZsHlvTw+ViAWeSfSqjQDRys0ZGA5COSoZyi+Vh3wMQUPMhA
 S5oYe69aqaNSOVsqtgyGtQMnZmuBTPhVUKPHoyvtIfl0AgP3pkaR4iq2oUAVPpou2yDy
 f/RQqi/QGY6axYOvxWJCr89Q5Dz9wNkeiZsiT3nrkbpHeJsF1Eiy5IN8CbXG7yME7XBh
 taEwOTnplZZBGJlTQDBSxVNgChxKgHXeDU9k+xhoJPzAeWYKA0n0Ck9Qsz8jNUSKpcfZ
 mSWWN70eDA5zvf8zyiBMVz0lbAwhamTIWegOVW9wHBcLx7I/BqUEDNMHT84YZPR6TKPq
 o69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=iSdodwwrRze00Mb6h6hlzJNUx9KQavRAmgXxBnJ8dbA=;
 b=rYVwgmGVIEs0khRXHQXL0hImVSQda9/UI5k54f4A/atpwgUkdYqA6J0cPhNFN0fnYX
 RFUDylfv8zgB8oXgkXT8yLrJdsqUMN76XChWS1r3VTRLwk1ijLoO8hA0lcJPH3B40xaJ
 c4ZQdhrFUMm7IeHQtjT/0aW/0Aj0U4lXHtfpcQOHgUj615l0sakSSGPokfQBOksd/Ph1
 njtV4I/lQk0oVdAKJcGQWVARU8T+li+FCuQ9X/flWSnCzEpFYEaGzncEdPZszS5IQNFg
 8vjAF8uzYjcKVVbx2AfhAcAgPuNnBlY50nG6GbWHsEsh37IZo8tRDEtNjHsHhOnSl9qY
 RPSQ==
X-Gm-Message-State: AOAM531YYDrpVhhcVmpuW+IrHyxcoHLkDpAEpf9FGvt4REDVhfzL/kpb
 f0PkdcUiZY3PQrW6rxLC3KjYSSYAYD4a6/z3zUk=
X-Google-Smtp-Source: ABdhPJwxeOhcCSiugxXJTkrtjoR8RaopT51NkvFA+ZedNMLl3bsfgezM074lXQZc9sEXZFUaetWrZiAd9NyZK8cD/r8=
X-Received: by 2002:aca:1117:: with SMTP id 23mr7143800oir.97.1599273772948;
 Fri, 04 Sep 2020 19:42:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200904162620.657726-1-philmd@redhat.com>
 <20200904162620.657726-3-philmd@redhat.com>
In-Reply-To: <20200904162620.657726-3-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Sat, 5 Sep 2020 10:42:16 +0800
Message-ID: <CAKXe6S+me9C82a159y2iZfaP6HTKjSjizEMUN0aDLVRmx0g-FA@mail.gmail.com>
Subject: Re: [PATCH 2/3] pci: Let pci_dma_read() propagate MemTxResult
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x244.google.com
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
Cc: Qemu Developers <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=
=9C=885=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=8812:27=E5=86=99=E9=81=
=93=EF=BC=9A
>
> pci_dma_rw() returns a MemTxResult type.
> Do not discard it, return it to the caller.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  include/hw/pci/pci.h | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index a85b0bc3c44..bb57525dffd 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -806,8 +806,20 @@ static inline MemTxResult pci_dma_rw(PCIDevice *dev,=
 dma_addr_t addr,
>                           dir, MEMTXATTRS_UNSPECIFIED);
>  }
>
> -static inline int pci_dma_read(PCIDevice *dev, dma_addr_t addr,
> -                               void *buf, dma_addr_t len)
> +/**
> + * pci_dma_read: Read from an address space from PCI device.
> + *
> + * Return a MemTxResult indicating whether the operation succeeded
> + * or failed (eg unassigned memory, device rejected the transaction,
> + * IOMMU fault).  Called within RCU critical section.
> + *
> + * @dev: #PCIDevice doing the memory access
> + * @addr: address within the #PCIDevice address space
> + * @buf: buffer with the data transferred
> + * @len: length of the data transferred
> + */
> +static inline MemTxResult pci_dma_read(PCIDevice *dev, dma_addr_t addr,
> +                                       void *buf, dma_addr_t len)
>  {
>      return pci_dma_rw(dev, addr, buf, len, DMA_DIRECTION_TO_DEVICE);
>  }
> --
> 2.26.2
>
>

