Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2A1C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 08:53:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ACF620A8B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 08:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ioOpzayX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ACF620A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQSBX-0003Ou-JD
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 04:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60180 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQSAs-0002lW-GA
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:53:06 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQSAr-0002jW-8e
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:53:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44587
 helo=us-smtp-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jQSAq-0002fq-Qv
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587372783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WRYMxskgrGy9xF46PIL9RmnEf6OdNe/ln27iyBtZtmM=;
 b=ioOpzayXsr2atcfo9ViMak5dx/qFrGUn4Eob1i2foCrq98q7XtkVCWtbuLJKcU+nIkcTs8
 qEeYS8/VPiVi8F6k6HnXMDNdcYA+izBYOSDzlOTBP//T3dS9JVydqHbFDmiUQoDkgecU99
 kWIzr9tL2WmUg/boLau96s5aO/IKQWU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-89J-WYSnOwyVcaB_8Dc8QQ-1; Mon, 20 Apr 2020 04:53:01 -0400
X-MC-Unique: 89J-WYSnOwyVcaB_8Dc8QQ-1
Received: by mail-ej1-f71.google.com with SMTP id j19so6008701ejs.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 01:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i0WKln2lNc8dlLBktTLskhKb+KYHB2XbrOEzH1I2Fus=;
 b=oDJDeHu/9AbCG8yUFddHyLcX/DVgIT7u6p1Waz3TfvyocRsW/CoIsbuBGA07kO77z0
 +JMDbHgip8QtF/8aJQwlGIM7wIxSOg/44/FBtS86iwEiNvRi4H6n+MH0B7MiG0tTEtpY
 uM8Zaidhqnt6lOXFkRPByRfjJGr60fyVF2mmrj6rmnm8Egv4/QeQp5s+hsobVLxIZIO2
 nZ6+VRhvgWRsKIpvB5cJr9FbENFOM0LfjlCmdzrL7FiCiZPJg3k1EPToDlD++gKP1h6W
 7DTynxZpEQW+vOUl08NLrPI6OGKtBzSOrGjdFgBw3D6mh058J3xXWnZqkUsLV+LtVmME
 JEuw==
X-Gm-Message-State: AGi0PuY0ba9/eeuclqglxa3vIfu27qqmtGOA6n/gdpuSZOcDSBaZL4aM
 FrUrOaeunyUCBZebE3RK4T9VWXXtb9u1YUOEjyJ8RURUE8bwgLrenkT2oDzfAoqTF4WISAFspmz
 /rnW31QrTTRc57Fo=
X-Received: by 2002:a17:906:4ecb:: with SMTP id
 i11mr14426336ejv.79.1587372780636; 
 Mon, 20 Apr 2020 01:53:00 -0700 (PDT)
X-Google-Smtp-Source: APiQypIReArNjov2E8IEXXQdDMLCar7HsAnATJ+t7s85XYLByXtIoPamB17lSYt9Urr1WxYNbqysTQ==
X-Received: by 2002:a17:906:4ecb:: with SMTP id
 i11mr14426325ejv.79.1587372780411; 
 Mon, 20 Apr 2020 01:53:00 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id r10sm20791edm.55.2020.04.20.01.52.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2020 01:52:59 -0700 (PDT)
Subject: Re: [PATCH 05/11] arm/virt: Fix virt_machine_device_plug_cb() error
 API violation
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200420083236.19309-1-armbru@redhat.com>
 <20200420083236.19309-6-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <094f72aa-c811-3840-cfd0-bef7eeaeffda@redhat.com>
Date: Mon, 20 Apr 2020 10:52:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200420083236.19309-6-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 03:29:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/20/20 10:32 AM, Markus Armbruster wrote:
> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
> pointer to a variable containing NULL.  Passing an argument of the
> latter kind twice without clearing it in between is wrong: if the
> first call sets an error, it no longer points to NULL for the second
> call.
>=20
> virt_machine_device_plug_cb() passes @errp to
> cryptodev_builtin_sym_close_session() in a loop.  Harmless, because
> cryptodev_builtin_sym_close_session() can't actually fail.  Fix by
> dropping its Error ** parameter.
>=20
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-arm@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   hw/arm/virt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 7dc96abf72..cca5316256 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1186,7 +1186,7 @@ static void create_smmu(const VirtMachineState *vms=
,
>       g_free(node);
>   }
>  =20
> -static void create_virtio_iommu_dt_bindings(VirtMachineState *vms, Error=
 **errp)
> +static void create_virtio_iommu_dt_bindings(VirtMachineState *vms)
>   {
>       const char compat[] =3D "virtio,pci-iommu";
>       uint16_t bdf =3D vms->virtio_iommu_bdf;
> @@ -2118,7 +2118,7 @@ static void virt_machine_device_plug_cb(HotplugHand=
ler *hotplug_dev,
>  =20
>           vms->iommu =3D VIRT_IOMMU_VIRTIO;
>           vms->virtio_iommu_bdf =3D pci_get_bdf(pdev);
> -        create_virtio_iommu_dt_bindings(vms, errp);
> +        create_virtio_iommu_dt_bindings(vms);
>       }
>   }
>  =20
>=20


