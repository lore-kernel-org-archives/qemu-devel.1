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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3566C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 01:33:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D1EB2074A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 01:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0sqJi+a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D1EB2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB6nM-00015v-M7
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 21:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kB6jX-0004Zs-Gk
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 21:29:43 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42505)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kB6jU-0006FW-EV
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 21:29:43 -0400
Received: by mail-oi1-x243.google.com with SMTP id j7so3276086oij.9
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 18:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=JmjKeYGLPW5C5CoFnmy4cHlpYVARDSgeDgC3BwYISss=;
 b=J0sqJi+a2CvVH3jRjPL+AdQmTu6O3wRCymFgNER1K3ngMI/bgNpQFUT5cCdhVu4yXv
 VtCYQTjHziOsKCdhuEj5uh5WppQZYeNlS0PfRxIJszGgW0tzm/2vZVHsCTLj6tdO58nU
 5InCPqf8Uv6Dk5GTOUiru7CX8o/Ga7acKQwYro4h6b948/uguG9uEhOF6Fa8F4mD0o8H
 BHNn4yngeS6RokkzkXbrAA25rASaXkU2FykicqjyCDAspaIrws8Sat1b483Tltq+JJ1x
 /VQ3fkGM8AxZlc5dTGSn1utRmsmoH9RX/FZYhYPREgkgzltlon4F4gUv/vp9JiBaj47L
 gGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=JmjKeYGLPW5C5CoFnmy4cHlpYVARDSgeDgC3BwYISss=;
 b=O8+EkPymvgGKPbWk/0hr/9CwkU1gW+7qBWVfhNzKbiWMQJ74p6WT1Wq6Su/luFN2Sp
 njHKyOm6iWvfswJZXaKK7mFsRi4qZEVu0yZ65eGm7DhZ0T1g3hXfS6i2rIVvlYYzqeuW
 ZBZfGjGb9bNa898lyfwzFyCoJVxrIM+6lHq8nEZ06KBDlfntJPavDYYhJ+/7mdURxN1d
 d7QtznnzPUaWDQZ3AMYGzcZPYdj3XXEUoPcG+2RYNquU67C1DTO76IMz5tHcn+G4IPm/
 Kt2DgvBqmkTeZP5eF4UAbhm47ofXsv+mK0zJCrzidg9jdc77sl50UPnO8ciGhTambuKQ
 tsUw==
X-Gm-Message-State: AOAM53155zo7AmWfYKVvsC9jfT1dPL958As83p0I1YjemEVzCtDBg9aZ
 VQ83tTz6MZbzx+S6OEOEf08kBRDc/RItVjaftzw=
X-Google-Smtp-Source: ABdhPJxcMAf7flbgkeatvbMipdyMCFr1NOx3XdBZYbhuEqZHFC5VBp8/pocLtaoQeF8Qibt5IB7gwdNUrNDfUVpVHxo=
X-Received: by 2002:aca:1117:: with SMTP id 23mr5620209oir.97.1598491778891;
 Wed, 26 Aug 2020 18:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200826184334.4120620-1-ehabkost@redhat.com>
 <20200826184334.4120620-4-ehabkost@redhat.com>
In-Reply-To: <20200826184334.4120620-4-ehabkost@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 27 Aug 2020 09:29:03 +0800
Message-ID: <CAKXe6SLU-UM5aGMG=cqE0b1X_NVRJC4pAta_jfGOtnG4cVCptA@mail.gmail.com>
Subject: Re: [PATCH 3/8] amd_iommu: Use TYPE_AMD_IOMMU_PCI constant
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x243.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8827=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=882:48=E5=86=99=E9=81=93=EF=BC=9A
>
> This will make future conversion to use OBJECT_DECLARE* easier.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  hw/i386/amd_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 087f601666..18411f1dec 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1622,7 +1622,7 @@ static const TypeInfo amdvi =3D {
>  };
>
>  static const TypeInfo amdviPCI =3D {
> -    .name =3D "AMDVI-PCI",
> +    .name =3D TYPE_AMD_IOMMU_PCI,
>      .parent =3D TYPE_PCI_DEVICE,
>      .instance_size =3D sizeof(AMDVIPCIState),
>      .interfaces =3D (InterfaceInfo[]) {
> --
> 2.26.2
>
>

