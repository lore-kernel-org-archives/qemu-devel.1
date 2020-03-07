Return-Path: <SRS0=oVW3=4Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79E3C10F00
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 17:28:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B750820674
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 17:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I52ZvAFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B750820674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAdFo-0004Bk-S9
	for qemu-devel@archiver.kernel.org; Sat, 07 Mar 2020 12:28:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52825)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jAdEd-00039Q-3X
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:27:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jAdEc-0007p3-03
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:27:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44390
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jAdEb-0007mh-Sc
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583602053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6xRoFM82B1zdObelW83B8IC7GqOx7Ws9hymoTmcIb9c=;
 b=I52ZvAFrhuyXySjXQ7JjMq+uhQS717zY90nX8MMLJYaZJVwhpDQCPJY2wzi4+BCYrN6cVF
 E57EEviRTk3RdhP+7RQASY5byi1tmDE16GaDjd0o4IBngHnmSwH/JUVIAexjw6uHJqv1CP
 1PwxlCZTXil5UaY+V72Vde9shYo+vAQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-H-TLfNtZOFakEnORW2srCg-1; Sat, 07 Mar 2020 12:27:32 -0500
X-MC-Unique: H-TLfNtZOFakEnORW2srCg-1
Received: by mail-wr1-f70.google.com with SMTP id c16so1739722wrt.2
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2020 09:27:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5QpbYshZz4sSte2NsyUxzq01lGvFpL0chBwxBYBEXwQ=;
 b=UJU8L1ifZ1mY1MLBXmwr1IGsJZAE1W7/3Ae3JWJ+Mz1Ywp7kL36382fwpXydEYmSdt
 2W1lrHYQ7GwybBG5YohdXi4BPT1OmTkaOxWjP4TZwXP1AlenrRENzPnGW4qAHhCKCgDT
 uJ0lu1SXDhC/B5vmUUVI9TeKcZ36B2AOyRtJhjX3MKIZwZQgLHK6fgNOYaTKhvkAowER
 +DS9qSm5Nb0fYuFeGmwL/ASs3cY8KGR6m6YPe75HLOxzQp2zmn1zQbWBxewXyjr6iiZY
 DxzceiFiqMQHlaSsSKjpVzkSVnYYxwSXXP0b7NkAY8AlLPcRNKr4AbKV4MNm4F0IB8VL
 lu5g==
X-Gm-Message-State: ANhLgQ3BuRagxbFp6y+BhF37Aymst+ehdwCCXACSrTFwDgaCejEVoD6e
 Yo+3ye1uCTQadl1B6kyBFUfEphXlkV5Zt/3BSn/Fr1xcoCwvKXS0gD3EAA/Sa1sZFL6D//nRXwi
 IWv+R9bI9cxyzW4Q=
X-Received: by 2002:a1c:4604:: with SMTP id t4mr10229112wma.164.1583602050792; 
 Sat, 07 Mar 2020 09:27:30 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsYwu8/20bzZmx/3oNbAFDU62+uLbt7zlclg61r28NGJaUiZ6i+dfSXT5/jw8E9Q/Kr0RIQjA==
X-Received: by 2002:a1c:4604:: with SMTP id t4mr10229100wma.164.1583602050631; 
 Sat, 07 Mar 2020 09:27:30 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id j14sm54080103wrn.32.2020.03.07.09.27.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Mar 2020 09:27:29 -0800 (PST)
Subject: Re: [PATCH v3 2/2] cmd646: remove unused pci_cmd646_ide_init()
 function
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 rth@twiddle.net, jsnow@redhat.com
References: <20200307091313.24190-1-mark.cave-ayland@ilande.co.uk>
 <20200307091313.24190-3-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a7cd4cb9-1d47-460c-f642-b43ce45dafcc@redhat.com>
Date: Sat, 7 Mar 2020 18:27:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200307091313.24190-3-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/7/20 10:13 AM, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/ide/cmd646.c  | 12 ------------
>   include/hw/ide.h |  2 --
>   2 files changed, 14 deletions(-)
>=20
> diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
> index 335c060673..d953932104 100644
> --- a/hw/ide/cmd646.c
> +++ b/hw/ide/cmd646.c
> @@ -317,18 +317,6 @@ static void pci_cmd646_ide_exitfn(PCIDevice *dev)
>       }
>   }
>  =20
> -void pci_cmd646_ide_init(PCIBus *bus, DriveInfo **hd_table,
> -                         int secondary_ide_enabled)
> -{
> -    PCIDevice *dev;
> -
> -    dev =3D pci_create(bus, -1, "cmd646-ide");
> -    qdev_prop_set_uint32(&dev->qdev, "secondary", secondary_ide_enabled)=
;
> -    qdev_init_nofail(&dev->qdev);
> -
> -    pci_ide_create_devs(dev, hd_table);
> -}
> -
>   static Property cmd646_ide_properties[] =3D {
>       DEFINE_PROP_UINT32("secondary", PCIIDEState, secondary, 0),
>       DEFINE_PROP_END_OF_LIST(),
> diff --git a/include/hw/ide.h b/include/hw/ide.h
> index 28d8a06439..0c7080ed92 100644
> --- a/include/hw/ide.h
> +++ b/include/hw/ide.h
> @@ -12,8 +12,6 @@ ISADevice *isa_ide_init(ISABus *bus, int iobase, int io=
base2, int isairq,
>                           DriveInfo *hd0, DriveInfo *hd1);
>  =20
>   /* ide-pci.c */
> -void pci_cmd646_ide_init(PCIBus *bus, DriveInfo **hd_table,
> -                         int secondary_ide_enabled);
>   PCIDevice *pci_piix3_xen_ide_init(PCIBus *bus, DriveInfo **hd_table, in=
t devfn);
>   PCIDevice *pci_piix3_ide_init(PCIBus *bus, DriveInfo **hd_table, int de=
vfn);
>   PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo **hd_table, int de=
vfn);
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


