Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC3FC3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 07:54:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6A0A206BB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 07:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrvzFtj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A0A206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0hvt-00035A-RK
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 03:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1i0huo-0002dd-4E
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 03:53:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1i0hum-00045l-SC
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 03:53:49 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34999)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>)
 id 1i0hum-00044D-K9; Thu, 22 Aug 2019 03:53:48 -0400
Received: by mail-ot1-x341.google.com with SMTP id g17so4650714otl.2;
 Thu, 22 Aug 2019 00:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DhX60WgWKF1Oo3EyNc1LWbZrmr7k6OPfTDHvb3kiuJY=;
 b=VrvzFtj23F3s4s8bCmYLLACbh7CGkyKdB+jAQQj16HGjACZpkPeAo3D48ZaCjD+qBT
 9BgNWQsob/d5us8xw0LO0pl5wrd9kbgFu8X449KMgY4VkNrO94dN1U7dhoVixpquD3/+
 qZXAOChv5j36J2RL9H4N2+bRgJOrdrRG61MS6MYO5JbzkCdyJi72Wl5ZWz67AKmKPmJc
 XU9/hrp3NliSjmUqxcDRB9tK59a4Lf8yUoTLV+9e720m5iryOyxAXr80tkWr16FzKlcI
 04/flblDl1jiJpbbbX71xjJrDoxjQB3Y8ZM6sIqnbJjaC88qagG1jbVXYvYXQPyxK9wC
 iiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DhX60WgWKF1Oo3EyNc1LWbZrmr7k6OPfTDHvb3kiuJY=;
 b=X3UECUEsbKqYPvwekIgOHobZgrNmTukAxk8JSNIzqDvGjlrp2Kd0/isxIO8kVyRgj3
 E3DojL1ww173lIb65SjTo+njMW9S1yBpjF84mYjK/Jy3GJeMCp9blbype5IMOHLXnURE
 1XYSSrnNuotmQAFV3dXtSWegpJt9IT+TubUH+JxylAcuTZye/IQt+pwRw5K0Ebca1Ugv
 S0McCN7OUPA+sjl3gi93GBTrWSmkenAZ1W3ZEkhTafUvgJ8V5DNrYPFHAnmZRZ9H+ae0
 0YdbiBy4a7CK+5h/GrLKdNhtK7otBLBVnqj+AlaXpfYU9qsqi0VXFq7r6Xxh7b77iPF/
 Bo7Q==
X-Gm-Message-State: APjAAAXcehJ/u1jovJ5LdNQfVN+XmRNvM2XaDr+BvvvTuPAozqTmBd9S
 WmHZaqucB5Ps2OHkZGtIJb8fFtV2k9VkhpBMEQI=
X-Google-Smtp-Source: APXvYqwrgH1omanFT/XqP8EOHPjIHg8SbZ6HpR2WoL0BZCnLbSvjy0PXW+gNrM/PKhpcjiKWiciAQJA/f3ZTISZQtek=
X-Received: by 2002:a05:6830:4ac:: with SMTP id
 l12mr1871859otd.333.1566460427186; 
 Thu, 22 Aug 2019 00:53:47 -0700 (PDT)
MIME-Version: 1.0
References: <8E5A9C27-C76D-46CF-85B0-79121A00B05F@me.com>
In-Reply-To: <8E5A9C27-C76D-46CF-85B0-79121A00B05F@me.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 22 Aug 2019 15:53:10 +0800
Message-ID: <CAKXe6SKTPxPqRjabm6ytUYiZGO0oHoTQXD=1MvMbvYBe1D0jTQ@mail.gmail.com>
To: Chen Zhang <tgfbeta@me.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] vfio: fix a typo
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
Cc: qemu-trivial@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Chen Zhang via Qemu-devel <qemu-devel@nongnu.org> =E4=BA=8E2019=E5=B9=B48=
=E6=9C=8822=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=882:49=E5=86=99=E9=
=81=93=EF=BC=9A

> Signed-off-by: Chen Zhang <tgfbeta@me.com>
>


Reviewed-by: Li Qiang <liq3ea@gmail.com>



> ---
>  hw/vfio/pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index dc3479c..c5e6fe6 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -44,7 +44,7 @@
>  #define TYPE_VFIO_PCI "vfio-pci"
>  #define PCI_VFIO(obj)    OBJECT_CHECK(VFIOPCIDevice, obj, TYPE_VFIO_PCI)
>
> -#define TYPE_VIFO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
> +#define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
>
>  static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
>  static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
> @@ -3199,7 +3199,7 @@ static void
> vfio_pci_nohotplug_dev_class_init(ObjectClass *klass, void *data)
>  }
>
>  static const TypeInfo vfio_pci_nohotplug_dev_info =3D {
> -    .name =3D TYPE_VIFO_PCI_NOHOTPLUG,
> +    .name =3D TYPE_VFIO_PCI_NOHOTPLUG,
>      .parent =3D TYPE_VFIO_PCI,
>      .instance_size =3D sizeof(VFIOPCIDevice),
>      .class_init =3D vfio_pci_nohotplug_dev_class_init,
> --
> 2.7.4
>
>
>
>
