Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066CDC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 10:28:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C27702053B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 10:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMT5blrn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C27702053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52037 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOgHs-0001wl-N9
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 06:28:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hOgH7-0001fd-B3
	for qemu-devel@nongnu.org; Thu, 09 May 2019 06:27:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hOgH6-0005Nj-7c
	for qemu-devel@nongnu.org; Thu, 09 May 2019 06:27:41 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hOgH6-0005NK-1e
	for qemu-devel@nongnu.org; Thu, 09 May 2019 06:27:40 -0400
Received: by mail-wr1-x443.google.com with SMTP id s15so2237750wra.12
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 03:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=tQ1THfkCqok69/oW5J2W8+rOmxaFagry7JDMm/ytzis=;
	b=BMT5blrnBscbh+mCouEkBcuxV5a65Wplsau1zotxj4G/WZS9CMupFCT1CAjEA2COH2
	3V6v7+JI74qOpgegH0Zn7HXc6rAtJSInPVWY02dArK16QjhkNXayUbKW+5rijlZ6l2fE
	2C/oSGWGx5pDooA72o/2sDf0EnLMvo3uW2Ir7saLkr07JmBs2DrVpPOCSrOFdzCBe65N
	8+JrCBjK6/Be/sui+Slyq1Tkdk61GSnHPw/reUU+SewHdIQ2viIzrfueoL/ZOaY7Stm+
	YApv9j5HxNXwpRK5spqxdbsXe8fqXDE3oZHBp13EFvK7k/nQCbo07KLV4OWIRYXQo95a
	/Nag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=tQ1THfkCqok69/oW5J2W8+rOmxaFagry7JDMm/ytzis=;
	b=fsqVWj55E8rZjHJpU07iBlnH9Geuzrlamzs8NirJTz2fvChjY2+ZY0K19msvwyNQ96
	HLVWtiKy6kF/TGnbs56d+Qq1Vdn5IgXG7Xxa1z3K5ZOADWPBpLCNYk5iOUyuYw9KABbI
	puZfSBw28r0j6goq3MK5rhmCj86qOGYBYFOARqbCTa0qpK6z+O4b/sS1Y17kM9cFiVf9
	w7ewxffkq7nc1seVZtuJhRHJHRVQaKaCXO4xMxJhG1t6dgv8teMdSG+ukZI/JYL1kiyf
	E83fyScL4y2bLgiMdrNSwlnHiGX2Mhx79FH6tPCuK3zHz1izw1uxyasH6XNqczcYxfWO
	OWaA==
X-Gm-Message-State: APjAAAVGNID9TcJrTw5PwAPTcHJhGFMRXHxXoUB+Gjzt4qEnewrdNDzT
	TxzWcyTr1h/rTiqdRRAMkk1dqT06l4GKfa4e290=
X-Google-Smtp-Source: APXvYqy57NlhyEncsWdyJSpMQDcUcMDm5VKSz4podb3cnrM6SOMCjqnqEkFdfH2yt9KYLg1e95YrPp/KptMWLmLEh74=
X-Received: by 2002:adf:b641:: with SMTP id i1mr2444834wre.288.1557397658696; 
	Thu, 09 May 2019 03:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190509093121.25974-1-kraxel@redhat.com>
In-Reply-To: <20190509093121.25974-1-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 9 May 2019 12:27:27 +0200
Message-ID: <CAJ+F1CK0O=oRC9xpbDpmT3dZO9_6L45XS2=H0FMVCn1E6Y9i9w@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 1/2] virtio-input-host-pci: cleanup types
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Thu, May 9, 2019 at 11:33 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> virtio input is virtio-1.0 only, so we don't need the -transitional and
> -non-transitional variants.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/virtio/virtio-input-host-pci.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/hw/virtio/virtio-input-host-pci.c b/hw/virtio/virtio-input-h=
ost-pci.c
> index 725a51ad30b4..f36d9b7102bc 100644
> --- a/hw/virtio/virtio-input-host-pci.c
> +++ b/hw/virtio/virtio-input-host-pci.c
> @@ -13,7 +13,7 @@
>
>  typedef struct VirtIOInputHostPCI VirtIOInputHostPCI;
>
> -#define TYPE_VIRTIO_INPUT_HOST_PCI "virtio-input-host-pci-base"
> +#define TYPE_VIRTIO_INPUT_HOST_PCI "virtio-input-host-pci"
>  #define VIRTIO_INPUT_HOST_PCI(obj) \
>          OBJECT_CHECK(VirtIOInputHostPCI, (obj), TYPE_VIRTIO_INPUT_HOST_P=
CI)
>
> @@ -31,11 +31,7 @@ static void virtio_host_initfn(Object *obj)
>  }
>
>  static const VirtioPCIDeviceTypeInfo virtio_input_host_pci_info =3D {
> -    .base_name             =3D TYPE_VIRTIO_INPUT_HOST_PCI,
> -    .generic_name          =3D "virtio-input-host-pci",
> -    .transitional_name     =3D "virtio-input-host-pci-transitional",
> -    .non_transitional_name =3D "virtio-input-host-pci-non-transitional",
> -    .parent        =3D TYPE_VIRTIO_INPUT_PCI,

nack, without the parent field it doesn't work

> +    .generic_name  =3D TYPE_VIRTIO_INPUT_HOST_PCI,
>      .instance_size =3D sizeof(VirtIOInputHostPCI),
>      .instance_init =3D virtio_host_initfn,
>  };
> --
> 2.18.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

