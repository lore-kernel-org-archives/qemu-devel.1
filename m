Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27973C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 01:34:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8E142074A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 01:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDyUPtI2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E142074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB6nx-0002bd-3L
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 21:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kB6nC-00016z-Pw; Wed, 26 Aug 2020 21:33:30 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42764)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kB6nB-0006rN-7s; Wed, 26 Aug 2020 21:33:30 -0400
Received: by mail-ot1-x344.google.com with SMTP id h17so1115447otl.9;
 Wed, 26 Aug 2020 18:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Ko0g7c5gsx7ItwbuVsDKYhtFoxiFL3TjE/iAFf76dM8=;
 b=NDyUPtI2vl9yZ+XXGzmB+f5o/8NhLEyUXTsrq3il2BcOSu2WhpQ6xii4i0UNEp0rj/
 2PEbqhOLaJLVec1m8Tag8TExCx8BgYo5fID5PrQuWAbnlzAM2vIoQrDpc/GiIk9KMPJY
 Jlo3OknqSJppK2F43tq4iV9TGNkIi1pEXbG3N0T6WjT5qRJmFWX+wqbMEVDbroXQQDq+
 mjYuHPE7V3sn6jIQ58xPjR9V+n4cmyQhsBdvGysk/l9wzB9x2BfbSvu+xnszfSm9uQL1
 PO9iE1DlWjKxfAIwlFFHH8Rgn/kGBLOU3I8ESIAYk/5A9bp2vgbV5CVBmeRXcfMXcKLR
 2dfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Ko0g7c5gsx7ItwbuVsDKYhtFoxiFL3TjE/iAFf76dM8=;
 b=eXLL4KgjIUvQ+qz9Sq/X9Hvh44DduNLzMmpZGVhZguxFCuJEiDSQX/IaNTaglz2KsT
 WyJKVSIUTOczikz6iJ09CMyaGetK/zkagQK0+A/XKhbWha9W1bGExS47IWDO3EI1N9Wn
 HV7SfyzeHx4TYgEDRSODo2FT0x/RqSqcvGpIueDDm2VYBV3lfs64/HPa8NyNCmnAkVnc
 HguPmXeDz1bXC7Hbft3hL44oxNVJjWc51we1/rEx21O8Zu6d/aTwupuWdkyXK41tNQHP
 WyiSs6zaVabBSwt4i1ygZc436KqfDym/XuKmRn/T9CsCgLRWlr+fUI6Bk8WxjhL2+sIf
 HnbA==
X-Gm-Message-State: AOAM5331ViUHibGGz0jmdNnpZ6yhFlExEN1dfNWU8satGKIAbo6QX2L6
 o7w75V50+PWUVDtzDfNMSiowUHSyUYZ5I8gvmY//WP8bxyGA/w==
X-Google-Smtp-Source: ABdhPJyfAgJipp057gOqPA524Auu1hNSFJIqFh9Tz4QUnP5l/MIy215keUjVSYVITKzN0VHZkYMPUJv5cPfI3M+AZFQ=
X-Received: by 2002:a9d:7c92:: with SMTP id q18mr8982466otn.333.1598492007343; 
 Wed, 26 Aug 2020 18:33:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200826184334.4120620-1-ehabkost@redhat.com>
 <20200826184334.4120620-8-ehabkost@redhat.com>
In-Reply-To: <20200826184334.4120620-8-ehabkost@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 27 Aug 2020 09:32:51 +0800
Message-ID: <CAKXe6S+YQUbomtZTL=qO4hJ0BXa4yrLkTA2o4RxhUvuMMrQ5Eg@mail.gmail.com>
Subject: Re: [PATCH 7/8] ppce500: Use TYPE_PPC_E500_PCI_BRIDGE constant
To: Eduardo Habkost <ehabkost@redhat.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, qemu-ppc@nongnu.org,
 Qemu Developers <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8827=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=882:51=E5=86=99=E9=81=93=EF=BC=9A
>
> This will make future conversion to use OBJECT_DECLARE* easier.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: qemu-ppc@nongnu.org
> Cc: qemu-devel@nongnu.org
> ---
>  hw/pci-host/ppce500.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
> index d71072731d..1a62b2f8cc 100644
> --- a/hw/pci-host/ppce500.c
> +++ b/hw/pci-host/ppce500.c
> @@ -509,7 +509,7 @@ static void e500_host_bridge_class_init(ObjectClass *=
klass, void *data)
>  }
>
>  static const TypeInfo e500_host_bridge_info =3D {
> -    .name          =3D "e500-host-bridge",
> +    .name          =3D TYPE_PPC_E500_PCI_BRIDGE,
>      .parent        =3D TYPE_PCI_DEVICE,
>      .instance_size =3D sizeof(PPCE500PCIBridgeState),
>      .class_init    =3D e500_host_bridge_class_init,
> --
> 2.26.2
>
>

