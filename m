Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B72C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 09:39:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E73CE20B1F
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 09:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="TyyMXSBn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E73CE20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZ9pP-0008AH-39
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 04:39:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan@daynix.com>) id 1kZ9oW-0007jB-8h
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 04:38:17 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38273)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yan@daynix.com>) id 1kZ9oT-0004Hn-WF
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 04:38:16 -0500
Received: by mail-wr1-x441.google.com with SMTP id n18so11090949wrs.5
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2020 01:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=q38hB4UG3r1SfvZtVUvKRlqM2cXsx1TU19DRg1q5BVs=;
 b=TyyMXSBnV81nKlMBIO6OxUIqlwZusqtg/d7i0x8ymyCQ8/RivVm/7BgXrc1eGoXL63
 CmP7tYs+BcysN0ZraMQY0yAj63l3w9usO++BBvN9E+0hSG7tKbxU0zCEORXlnvzjZy7t
 /yJQtpeTFVaZJZrxwg+Esg62H3gY10Aes/w/pNJN9UEVkcCICBU/PI5/y/6XFvLZF1VI
 nXpDZ395c4b6+O2UujOLoVJcnwRafjDnpWzM9w6uNkHnHaaArq2dfPWuH0i7uyogkt21
 WTqsqMjhxDf/qsOAA9Myd7nNe201GCIgbYsTcBO00hhj9wohnEOmEkfdQuajGBkLybwp
 BHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=q38hB4UG3r1SfvZtVUvKRlqM2cXsx1TU19DRg1q5BVs=;
 b=YdMDuBnD7znChSmnUufaCalGeVnNX7rhX5m5pXDOfkfre6a5Y7EUOSLLGzjkOYFtM0
 dHAfkYzgcQ8ib6rNYTiJwuYXM6J2HZWTuuB+cELFU3PnfgA6spUAmzQDNw/7ydzc+B8U
 MGnj+BeZ+wxbe83GUec/yXtoFNerg5vC10Ew7FHbWtKtrsUxE02Y1TaFsb7uHPNMuyAz
 dGtSDs2SQkbl8PR3N4BK2TAGOITBXbI79iGHbc/nVSXquwhW/Pfnwc01zhkDZtCXilfq
 Q84YyI5kfMgf3RZvczZYh+//06aVigZVDKgFuZPpBj788REQkadIl1IC8fTKaVFKRXYj
 6p7w==
X-Gm-Message-State: AOAM5313uYPPyT7c81qG7n0CQfueTHjhsmOSHUyZsCn9CHhtLPGGlR1G
 NVnF/aJhAWMmuGX4GbmX+THDkQ==
X-Google-Smtp-Source: ABdhPJywuf/wvSQmVERX2wFFI2BL+zmYrwYidg866/wWkzYzJK6r2qxWuZO0vNZZgKiUTiktpZr+CQ==
X-Received: by 2002:adf:f1cd:: with SMTP id z13mr13661691wro.197.1604223490530; 
 Sun, 01 Nov 2020 01:38:10 -0800 (PST)
Received: from [10.100.102.20] (109-186-229-238.bb.netvision.net.il.
 [109.186.229.238])
 by smtp.gmail.com with ESMTPSA id u15sm17861287wrm.77.2020.11.01.01.38.09
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 01 Nov 2020 01:38:09 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: simple example of pci driver with dma
From: Yan Vugenfirer <yan@daynix.com>
In-Reply-To: <AM9PR09MB4643DE281C54F5A4FA09958382140@AM9PR09MB4643.eurprd09.prod.outlook.com>
Date: Sun, 1 Nov 2020 11:38:08 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <6AD059CC-67A4-4BA0-8E2E-9C11766B117C@daynix.com>
References: <AM9PR09MB4643ECD51E00A54B871DED7682140@AM9PR09MB4643.eurprd09.prod.outlook.com>
 <CAFEAcA8mcRhyYvfJyTZhdCmwkzP77Nhb=ehUBmYSiwZxMnSBdA@mail.gmail.com>
 <AM9PR09MB4643DE281C54F5A4FA09958382140@AM9PR09MB4643.eurprd09.prod.outlook.com>
To: Shaked Matzner <shaked.m@neuroblade.ai>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Received-SPF: none client-ip=2a00:1450:4864:20::441;
 envelope-from=yan@daynix.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Shaked,

In the prob function, before you are trying to do any DMA operations =
with your device, you should call pci_enable_device and then =
pci_set_master. Also you might need to map the resources of your device.
Check PCI driver documentation: =
https://lxr.missinglinkelectronics.com/linux/Documentation/PCI/pci.rst#L19=
9

Best regards,
Yan.

> On 29 Oct 2020, at 10:32 PM, Shaked Matzner <shaked.m@neuroblade.ai> =
wrote:
>=20
> Hey Peter,
> Currently I have this test in the driver which allocates data, assign =
it to default value config source as the BASE address of dma, dest as =
the physical address which I got from dma_alloc_coherent, set the count =
and assign the command to raise interrupt and read,the piece of code =
used is something like this(this a test performed from the probe =
function of the driver)
>                                                 vaddr_to =3D =
dma_alloc_coherent(&(dev->dev), 4, &dma_handle_to, GFP_ATOMIC =
|GFP_KERNEL);
>             *((volatile int*)vaddr_to) =3D 0xff;
>                                                 test->vaddr_to =3D =
vaddr_to;
>                                                 dev_info(&(dev->dev), =
"vaddr_to =3D %px\n", vaddr_to);
>                                                 dev_info(&(dev->dev), =
"dma_handle_to =3D %llx\n", (unsigned long long)dma_handle_to);
>                                                 iowrite32(DMA_BASE, =
mmio + IO_DMA_SRC);
>                                                 =
iowrite32((u32)dma_handle_to, mmio + IO_DMA_DST);
>                                                 iowrite32(SIZE, mmio + =
IO_DMA_CNT);
>                                                iowrite32(DMA_CMD | =
DMA_FROM_DEV | DMA_IRQ, mmio + IO_DMA_CMD);
> Where and when should the pci_set_master hould be called?
> Thanks,
>              Shaked Matzner
> =20
> From: Peter Maydell <peter.maydell@linaro.org>=20
> Sent: Thursday, October 29, 2020 5:46 PM
> To: Shaked Matzner <shaked.m@neuroblade.ai>
> Cc: qemu-devel@nongnu.org
> Subject: Re: simple example of pci driver with dma
> =20
>=20
> IRONSCALES couldn't recognize this email as this is the first time you =
received an email from this sender peter.maydell@linaro.org
> =20
> [EXTERNAL]
>=20
> On Thu, 29 Oct 2020 at 14:59, Shaked Matzner wrote:
> > however the value I get is still 255(0xff) and not 18(0x12) probably =
I've missed something but when the interrupt is called the transfer to =
the RAM address should be completed, however it seems like the =
dma_write_buffer function from the device does not perform any transfer. =
What Am I missing?
>=20
> The usual mistake is forgetting in the guest code to program the
> PCI device to enable bus mastering by setting the Bus Master bit
> in the Command register in the PCI config space registers for
> the device. Unless you do that then all DMA attempts will fail
> (same as on real h/w). In the Linux kernel the function for this
> is pci_set_master(), I think.
>=20
> thanks
> -- PMM=20
>=20
> The contents of this email message and any attachments are intended =
solely for the addressee(s) and may contain confidential and/or =
privileged information and may be legally protected from disclosure. If =
you are not the intended recipient of this message or their agent, or if =
this message has been addressed to you in error, please immediately =
alert the sender by reply email and then delete this message and any =
attachments. If you are not the intended recipient, you are hereby =
notified that any use, dissemination, copying, or storage of this =
message or its attachments is strictly prohibited.=20
>=20



--------------------------------------------------
Daynix Computing LTD
Yan Vugenfirer, CEO
Email: yan@daynix.com
Phone (Israel): +972-54-4758084
Phone (USA): +1-7204776716
Phone (UK): +44-2070482938
Web: www.daynix.com


