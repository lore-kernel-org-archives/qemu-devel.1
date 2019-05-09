Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C875BC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:38:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E05D21479
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E05D21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50722 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOeZN-0000to-UY
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 04:38:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1hOeYa-0000XP-9a
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:37:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1hOeYZ-0004ZL-CY
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:37:36 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33743)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1hOeYZ-0004Xc-88
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:37:35 -0400
Received: by mail-ot1-f65.google.com with SMTP id 66so1575367otq.0
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 01:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=e/PyILm3rV4/mPYNBHUi46XeVj5tlfb4czietgdZ0hc=;
	b=kXBL6EgyJ34eBdZ+v2c76rIrb/jTAc5xFTlaeNwVbTBbXzMhZ4weOpHRnjfPADujZw
	qQ951W+QdMIPDRBizUsefv9iAnpHCDUi9/Fw/eSzL9XU38PE3mqyuwQKxbTnnkztflgU
	a7dcbSxxp0i2wAKbPpSltni61J4Y1tjZwRfhbyqMIW0CcORsbZoEZLBjRIRHp2MHOkd0
	xNKB5SFesSfpE9bfQTFqrIuHsS0kw8+JVxcoV4784sGiPVc+/7eXc1vtyNJbGEKu53Ng
	U3j52D7oI035srC4jCbuvYfQuMj/DqD/1OKnoq5+yGLVPIjLIREVacbnV7pWqpIamGB3
	r6IQ==
X-Gm-Message-State: APjAAAWrY3nhh9Neff87CV9CP4ImoFP1ZesnXcd2j5xrD/VDYjWFAhy8
	LucECowF2DlxUq93oCukn67HdfBsO8ZWYMGWFQxrDw==
X-Google-Smtp-Source: APXvYqzoB/RCqSw8mCKxY7o4Mj90w1/nK1Xx3y7JLVRi8bUi655GtvuCwNhiFzhtiDkxSn/ukUpuyVkG7vf0upep71M=
X-Received: by 2002:a9d:141:: with SMTP id 59mr1653195otu.158.1557391051756;
	Thu, 09 May 2019 01:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190503130034.24916-1-marcandre.lureau@redhat.com>
	<20190503130034.24916-5-marcandre.lureau@redhat.com>
	<20190509063220.cfahgzlujtcv5etr@sirius.home.kraxel.org>
In-Reply-To: <20190509063220.cfahgzlujtcv5etr@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 9 May 2019 10:37:20 +0200
Message-ID: <CAMxuvaw9kOt3yoRk4sWPeRyUmRLWboCCyrO00W0Se+W-OOrGRw@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.210.65
Subject: Re: [Qemu-devel] [PATCH v2 4/6] Add vhost-user-input-pci
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
Cc: qemu-devel <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Thu, May 9, 2019 at 8:32 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > +static const VirtioPCIDeviceTypeInfo vhost_user_input_pci_info = {
> > +    .base_name = TYPE_VHOST_USER_INPUT_PCI,
> > +    .generic_name = "vhost-user-input-pci",
> > +    .transitional_name = "vhost-user-input-pci-transitional",
> > +    .non_transitional_name = "vhost-user-input-pci-non-transitional",
>
> virtio-input is virtio 1.0 only, so we don't need these variants.
> Incremental fix below, if you ack that I can squash it for the pull req.
> Or you send a v3 (in case you have other changes pending).
>
> cheers,
>   Gerd

ack, thanks

>
> --- a/hw/virtio/vhost-user-input-pci.c
> +++ b/hw/virtio/vhost-user-input-pci.c
> @@ -13,7 +13,7 @@
>
>  typedef struct VHostUserInputPCI VHostUserInputPCI;
>
> -#define TYPE_VHOST_USER_INPUT_PCI "vhost-user-input-pci-base"
> +#define TYPE_VHOST_USER_INPUT_PCI "vhost-user-input-pci"
>
>  #define VHOST_USER_INPUT_PCI(obj) \
>      OBJECT_CHECK(VHostUserInputPCI, (obj), TYPE_VHOST_USER_INPUT_PCI)
> @@ -37,9 +37,7 @@ static void vhost_user_input_pci_instance_init(Object *obj)
>
>  static const VirtioPCIDeviceTypeInfo vhost_user_input_pci_info = {
>      .base_name = TYPE_VHOST_USER_INPUT_PCI,
> -    .generic_name = "vhost-user-input-pci",
> -    .transitional_name = "vhost-user-input-pci-transitional",
> -    .non_transitional_name = "vhost-user-input-pci-non-transitional",
> +    .generic_name = TYPE_VHOST_USER_INPUT_PCI,
>      .parent = TYPE_VIRTIO_INPUT_PCI,
>      .instance_size = sizeof(VHostUserInputPCI),
>      .instance_init = vhost_user_input_pci_instance_init,

