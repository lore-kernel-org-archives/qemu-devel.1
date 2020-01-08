Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43535C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 15:52:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EBAD20705
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 15:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RgRQKwYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EBAD20705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipDcl-00085r-7W
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 10:51:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ipDc4-0007eF-Ip
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:51:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ipDc1-0005Pt-EL
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:51:14 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48086
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ipDc0-0005OC-VT
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:51:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578498670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d/01iHgDpiK5SXc5rp9Hjr7GvsukVHHsjcL1W6vZPIo=;
 b=RgRQKwYGXC3yCD4Rms511r70nmjEdV50bir12OvFqf4b3yplBUsCNK+2Mf4wjxOPPoIkj9
 wRlHwNsyR/1VkWhiW46DZoafXc5+vn4+Lm9ZJULXYxDeqHBr4s8S/CzHf2O3Pt5GaKzvTo
 7Fi09EnP0xxB0D/LSBWANgeT3roidig=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-zjBHLNe_OGSYJ6SqdF7ZLA-1; Wed, 08 Jan 2020 10:51:09 -0500
Received: by mail-wr1-f72.google.com with SMTP id v17so1590559wrm.17
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 07:51:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=I3LHcgq7fB44RSkbKBoC9D2ijcNwvM5e/Uy/avza34U=;
 b=k/4m3kzSt/WhKiyx7NcSkV7axKSamNfZXRYC+su5T94v1aUTKc5rd1DXAWMZKu3E+2
 zWr7ABNuweeL+pv/sM0WKHUkuJVh3jcClf+qyFMMOEphubeYnT8qCKsM8zDv7skQT+L2
 GF/kSWlj3fzkv83TpjRXrIliklZipJtuq+rB2XlPTVWL8FZsdz0OvMoMQa4Ef6kHOdLo
 7dT32LZiJ660ZC9w+aiTms7yyShDHAESINg/Qo1lSt/ynZQX8eUGgxVRGQRn10dwOXeI
 Z3O4alIQTbFKjhhKhi1+JhnqH7FqX9StlTNuc0ZIBA2S1CewoD8yh+Lu6nJQnXCeLyUG
 CWjw==
X-Gm-Message-State: APjAAAWEKPBvF3x9yYrcMeo4XP8GYmP8ld5zE2jN4waI+dtzSJydEClz
 CPG/uqmD4YwcbGBJs+97aQ2XB/k7QvMRn6dUN9r4TvGy4eAbRDYaidiz1W9ImVYzZa/fkMKj3+i
 EGBoISGCouSt6fS8=
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr4576523wmj.117.1578498668088; 
 Wed, 08 Jan 2020 07:51:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqzptPE3oN5dzkZE3AUjtHznjceyMB69YORwHxeKwkKPrVwp2wFhufNQCFwMZkKnFDk16+TEVQ==
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr4576508wmj.117.1578498667876; 
 Wed, 08 Jan 2020 07:51:07 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id n14sm4272467wmi.26.2020.01.08.07.51.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2020 07:51:07 -0800 (PST)
Subject: Re: sysbus usb xhci
To: Sai Pavan Boddu <saipava@xilinx.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>
References: <MN2PR02MB5935CFE95528B85E06DA9583CA200@MN2PR02MB5935.namprd02.prod.outlook.com>
 <20200102094515.bbjaqlif7ucvzuou@sirius.home.kraxel.org>
 <b8ad0f98-a02d-bcb2-acd8-a6e9fb606167@redhat.com>
 <MN2PR02MB59356EE03FCE2AFEF22F437ACA230@MN2PR02MB5935.namprd02.prod.outlook.com>
 <MN2PR02MB59355EEA0C2807EA5EE52D94CA3E0@MN2PR02MB5935.namprd02.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1644b627-be90-dff8-9de6-dd92b879e593@redhat.com>
Date: Wed, 8 Jan 2020 16:51:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <MN2PR02MB59355EEA0C2807EA5EE52D94CA3E0@MN2PR02MB5935.namprd02.prod.outlook.com>
Content-Language: en-US
X-MC-Unique: zjBHLNe_OGSYJ6SqdF7ZLA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/8/20 4:32 PM, Sai Pavan Boddu wrote:
> Hi Gred/Philippe,
>=20
> In the process of making hcd-xhci.c free of pci wrapper, I came across a =
dma command " ldq_le_pci_dma" for which I don=E2=80=99t see any low level a=
lternative to replace.
> Even I cannot find the source of it, do you have any thoughts on this ?

Isn't it ldq_le_phys()?

I think you want to extract the address space first in a common method.=20
See in sdhci_pci_realize():

     s->dma_as =3D pci_get_address_space(dev);

And in sdhci_sysbus_realize():

     if (s->dma_mr) {
         s->dma_as =3D &s->sysbus_dma_as;
         address_space_init(s->dma_as, s->dma_mr, "sdhci-dma");
     } else {
         /* use system_memory() if property "dma" not set */
         s->dma_as =3D &address_space_memory;
     }

>> -----Original Message-----
>> From: Sai Pavan Boddu
>> Sent: Friday, January 3, 2020 10:44 AM
>> To: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>; kraxel@redhat.com
>> Cc: peter.maydell@linaro.org; qemu-devel@nongnu.org
>> Subject: RE: sysbus usb xhci
>>
>> Thanks Philippe & Gred. I would start with the below pointers.
>>
>> Regards,
>> Sai Pavan
>>
>>> -----Original Message-----
>>> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> Sent: Thursday, January 2, 2020 4:56 PM
>>> To: kraxel@redhat.com; Sai Pavan Boddu <saipava@xilinx.com>
>>> Cc: peter.maydell@linaro.org; qemu-devel@nongnu.org
>>> Subject: Re: sysbus usb xhci
>>>
>>> On 1/2/20 10:45 AM, kraxel@redhat.com wrote:
>>>> On Thu, Jan 02, 2020 at 07:13:25AM +0000, Sai Pavan Boddu wrote:
>>>>> Hi Gred,
>>>>>
>>>>> We are seeing of options to reuse the hcd-xhci model and use it
>>>>> over system bus interface rather than pci. (for Xilinx ZynqMP SOC,
>>>>> usb
>>> emulation) Are there any plans of implementing a sysbus device ? if
>>> none it would be good if provided few pointers to start.
>>>>
>>>> There have been some discussions about this for a (IIRC) sbsa
>>>> machine, but I'm not sure whenever that where just ideas or some code
>> exists.
>>>>
>>>>> Im looking at hcd-ehci/ochi as a reference, let me know if there
>>>>> are any
>>> know limitations for this usecase.
>>>>
>>>> Yep, the path for xhci would be quite simliar:  Create a new
>>>> XHCIPciState struct, move over all pci-specific bits from XHCIState,
>>>> leaving the generic stuff in XHCIState for sharing with sysbus.
>>>> Possibly move all pci-specific code bits into a new source file (for
>>>> cleanup, will also allow to build qemu with CONFIG_PCI=3Dn and still
>>>> have XHCI enabled).
>>>>
>>>> Once this separation is done you should be able to create a sysbus
>>>> device, reusing the generic xhci code and adding sysbus plumbing
>>>> (mmio, irq, ...)
>>>
>>> The SDHCI commits b635d98cf32..8b7455c75e seem similar to what you
>>> want to achieve (see also commit ce8646034).
>=20


