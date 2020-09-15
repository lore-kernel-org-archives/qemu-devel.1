Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48927C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:53:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EC4420738
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxcobuwO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC4420738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIBOp-0006AN-PT
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 09:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kIBNv-0004ub-Ad
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 09:52:39 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43545)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kIBNs-0005HW-2r
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 09:52:38 -0400
Received: by mail-ot1-x342.google.com with SMTP id n61so3252062ota.10
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 06:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=S6LjKrcFym85h8ACEi+snDD16PzbpIn0I6u3BFhY9nI=;
 b=YxcobuwOitfXolIhL5yGMIutoqaUBBYqLl7qksQpQisJYSspecIxaS0Ar+Ba95z5jL
 U3KUzPptE7EkaqoSOe9ZGEu3TtHhwejU0xfFUz2+HC/F53N+a3GLtZvKh17c3vL/UYIH
 K+wjezMRXUThlJFzUiKuFAlXk2XzcoYIjojgYMZK6BNGWY38RvApBtocHq6RLBd2Kzwy
 pTX7VW0OVhVQP9BwyHyWSskZzlad5z7rBl9PtvgXvLRDdbbKP+QKhhmy9iM8r7an9UMG
 0nHsrLdDKRDi7rKAbQeshFnYFavxUCZSStDx2AIrhmZAlV5zJ/cZmb1v5kRj0quHuls6
 mKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=S6LjKrcFym85h8ACEi+snDD16PzbpIn0I6u3BFhY9nI=;
 b=a/s2fotWTM/Ar0YxMvCBsMug6CC97XHOrvvySU5ApVOu0I4hVnZQgePJgnjos5dYtM
 Ifgi+ldvunrY2hwm32c2wJcx4R01EKmJyMI87CH5CrDIyD7+LgsxRvs+FpZTfQDThiXI
 UEVfgyWdARd2BOGZI7JLDLlOwyFu7wOenZiPTZlCutb1LwwfyDxmGFaMsHZ5FkCG7d3j
 MHGSfXR5SWDOYZA+oNUzadecRJVgq5DwmGge3j9TLoEMLv8GBf9H7hP7zQhonEzffR1I
 qsWpHkfA17Wgo/ceJPb2L/eYjoVEtphyh6RG+YtWzlKvn5zFZ0mpnt7CWbvYgIrEoV6j
 guzQ==
X-Gm-Message-State: AOAM532RX2TJMvPWMV9I9YwB6J6nzBQf8O72kPzkv1egIFjpwpzWfuhu
 hLjojjjAi82Diu0cT2xBWGFW+8hHy0t5rL1tvOI=
X-Google-Smtp-Source: ABdhPJwcIRSH78jvzTtt8xt+gR0LfxCDdaQuzC0LyO12Wx6/2lYLMCZoQ71M+hwgARCOvPZOZr0iPrsifeICCBTNJic=
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr12545388oti.333.1600177954738; 
 Tue, 15 Sep 2020 06:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200827114917.1851111-1-ppandit@redhat.com>
In-Reply-To: <20200827114917.1851111-1-ppandit@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 15 Sep 2020 21:51:58 +0800
Message-ID: <CAKXe6SJNio2cy05ecr_DyB0Z6WjxHN_X8ZiOU5By0jwdRq12fg@mail.gmail.com>
Subject: Re: [PATCH] pci: check bus pointer before dereference
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x342.google.com
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
 Prasad J Pandit <pjp@fedoraproject.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Alexander Bulekov <alxndr@bu.edu>,
 Ruhr-University <bugs-syssec@rub.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

P J P <ppandit@redhat.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8827=E6=97=A5=E5=
=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=887:52=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> While mapping IRQ level in pci_change_irq_level() routine,
> it does not check if pci_get_bus() returned a valid pointer.
> It may lead to a NULL pointer dereference issue. Add check to
> avoid it.
>
>  -> https://ruhr-uni-bochum.sciebo.de/s/NNWP2GfwzYKeKwE?path=3D%2Flsi_nul=
lptr1
>     =3D=3D1183858=3D=3DHint: address points to the zero page.
>     #0 pci_change_irq_level hw/pci/pci.c:259
>     #1 pci_irq_handler hw/pci/pci.c:1445
>     #2 pci_set_irq hw/pci/pci.c:1463
>     #3 lsi_set_irq hw/scsi/lsi53c895a.c:488
>     #4 lsi_update_irq hw/scsi/lsi53c895a.c:523
>     #5 lsi_script_scsi_interrupt hw/scsi/lsi53c895a.c:554
>     #6 lsi_execute_script hw/scsi/lsi53c895a.c:1149
>     #7 lsi_reg_writeb hw/scsi/lsi53c895a.c:1984
>     #8 lsi_io_write hw/scsi/lsi53c895a.c:2146
>     ...
>
> Reported-by: Ruhr-University <bugs-syssec@rub.de>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/pci/pci.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index de0fae10ab..df5a2c3294 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -253,6 +253,9 @@ static void pci_change_irq_level(PCIDevice *pci_dev, =
int irq_num, int change)
>      PCIBus *bus;
>      for (;;) {
>          bus =3D pci_get_bus(pci_dev);
> +        if (!bus) {

Hi Prasad,

I think in normal this 'bus' will be not NULL.
I have look at the link in the commit msg.
I find it is another DMA to MMIO issue which we have discussed a lot
but didn't come up with an
satisfying solution.

Maybe we can try to the DMA to MMIO issue direction.
CC: Peter, Jason and Alex

Thanks,
Li Qiang


> +            return;
> +        }
>          irq_num =3D bus->map_irq(pci_dev, irq_num);
>          if (bus->set_irq)
>              break;
> --
> 2.26.2
>
>

