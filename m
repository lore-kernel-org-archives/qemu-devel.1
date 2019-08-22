Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06085C3A5A2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 08:46:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1FF921848
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 08:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1FF921848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0ijk-0006tE-1r
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 04:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i0iiR-0005NA-MI
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i0iiP-000706-NM
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:45:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48990)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i0iiP-0006zR-I4
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:45:05 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AA14EC08EC24
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 08:45:04 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id r1so2658336wmr.1
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 01:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/QHYBaltmIWKCAfGcizV8F+g02QqH2o4X+LH6iUwZb8=;
 b=OjeprnGZJicSOKNzJ34Cwu9zH9UjMIE4i7oP8rtM6cjIKN9h1o64Z5Y1+7pOYB1RPS
 v3PHhH+w+nlru0A523GCOrE5tv/T3OKguN/tb/G3ffSc1rM6OJzJJ1+L+ZIWeewbE7kA
 vn6OTc/cHe6vLjM037UOod3hwinyalQtJ0KWZhK39oTLgjmT8NdLpt16u3/+enAxAm3p
 WCipDCpjyZcS1qX3aTXkZ6AWBW/zOMje13Dt+kQy3FMZf49Csi7d2PoiQdjMOY/wfFs+
 qQJt+G+avab0A6xMNg+qDEvqTVDOMS+ni6/+O1iBKqJVesxxzEhtOTII087sfKKrMWi5
 JvhQ==
X-Gm-Message-State: APjAAAXFbvSb4P9uErsv+idtjdJPI11j7rfe0Mfrjf3PNMwFTZKkkHJ4
 uNfesXV7DL+kGqk+Pzf3byWVM6bK2fravCtdYrXdYdtPegE7jwX9wLHlDLiehh8kjb27orMOkHE
 LKwGRfIkEIAHuzU4=
X-Received: by 2002:a05:6000:12c3:: with SMTP id
 l3mr45197016wrx.100.1566463503111; 
 Thu, 22 Aug 2019 01:45:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy6AFL7HWRMC0La/t/10cUYp2wjU8WdhAKGEf2ocaNvwdBLnqL0gc3hefDpyg6A1yd4rFqnaw==
X-Received: by 2002:a05:6000:12c3:: with SMTP id
 l3mr45197002wrx.100.1566463502944; 
 Thu, 22 Aug 2019 01:45:02 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id s64sm9021976wmf.16.2019.08.22.01.45.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2019 01:45:02 -0700 (PDT)
To: Chen Zhang <tgfbeta@me.com>, qemu-devel@nongnu.org
References: <8E5A9C27-C76D-46CF-85B0-79121A00B05F@me.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a448f7da-c990-7dc5-e5ab-139994dfc814@redhat.com>
Date: Thu, 22 Aug 2019 10:45:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <8E5A9C27-C76D-46CF-85B0-79121A00B05F@me.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: qemu-trivial@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/22/19 8:49 AM, Chen Zhang via Qemu-devel wrote:
> Signed-off-by: Chen Zhang <tgfbeta@me.com>
> ---
>  hw/vfio/pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index dc3479c..c5e6fe6 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -44,7 +44,7 @@
>  #define TYPE_VFIO_PCI "vfio-pci"
>  #define PCI_VFIO(obj)    OBJECT_CHECK(VFIOPCIDevice, obj, TYPE_VFIO_PC=
I)
> =20
> -#define TYPE_VIFO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
> +#define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
> =20
>  static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
>  static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
> @@ -3199,7 +3199,7 @@ static void vfio_pci_nohotplug_dev_class_init(Obj=
ectClass *klass, void *data)
>  }
> =20
>  static const TypeInfo vfio_pci_nohotplug_dev_info =3D {=20
> -    .name =3D TYPE_VIFO_PCI_NOHOTPLUG,
> +    .name =3D TYPE_VFIO_PCI_NOHOTPLUG,
>      .parent =3D TYPE_VFIO_PCI,
>      .instance_size =3D sizeof(VFIOPCIDevice),
>      .class_init =3D vfio_pci_nohotplug_dev_class_init,
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

