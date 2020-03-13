Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622E9C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 19:51:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2878C206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 19:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0x/P0il"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2878C206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCqLa-0007R1-Ct
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 15:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50173)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCqKQ-0006wB-CY
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 15:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCqKO-0005SJ-DM
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 15:50:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52443
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCqKO-0005J1-90
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 15:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584129038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8vfkBC40K/uFjPAa2nTIgnEiV71WybfkEiM5fNSl08Q=;
 b=U0x/P0ilfpSCUfF1v04WSrJWGKm+N7u1ntNZqJI3jfQ04O784ccMUPJx7KHjw1VAI0KlX1
 Q9VqAvnK+dU5aLrmOCKt1W21DDUsW7YrevBYvtvqImLAm0a5bjRVdczHtyzFcJV8u8tAyC
 d8fwWou1Zr5/koEIGSAizxwROfx0hno=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-LazQJzePMJWLcW71IMtahw-1; Fri, 13 Mar 2020 15:50:36 -0400
X-MC-Unique: LazQJzePMJWLcW71IMtahw-1
Received: by mail-wm1-f70.google.com with SMTP id f9so1772933wme.7
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 12:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=k5OKWAXBq18m1t2MThr7roZMZQohVMt7iYje1gzrpCc=;
 b=TRg6PP3uwOdn1R2+wRCSacFYYTF5PAxa0UMtOoVhLIOmz+8m79rQIg8sVmCkztTcyN
 C41iUhu2zuE0NiqHc1Hwerxkz42xephfMsp5KFRpG2FtU4pnnsFUT7XJjSblNpnqFfdB
 SRJXUtn309i8sYDeWsMiEDvEvjG0UeTnQAvmb+OPNY206gW/ZsTLhYSKRFBSIbGU7vdw
 p9ul4FNcql3f4hOiSKUa+tn+R3R5la21N7VaV4xVWP47DgqKEQcErkuLDziN1kYjY72q
 cKZkQEXIXDMlQtKWo+c6rDddylMsIMPp6KTLRB6oH/UANPqpk2B4ejK7Pu4d+EUEqRYs
 vLFw==
X-Gm-Message-State: ANhLgQ3wheaoMMyxsz+/A9ZB3WB6PBaLO0UHINlBR0QGZg0an2lJRnG3
 IKsFlh3A/TLmDAKF20+chbM7zEfV0ZrjySSlSmLxdTfq5C3HNHaxMe2vEkzAlocG7Cq6IOV0aLa
 U5vbkKjOvwSBIMmQ=
X-Received: by 2002:adf:ff83:: with SMTP id j3mr10661876wrr.131.1584129035556; 
 Fri, 13 Mar 2020 12:50:35 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuQ3wvlC9Zzk0wAYk66HKwZtq6aASv9K1Rwa30QM/YmQbPzdB67jqFD+VjWtYw66yFwVS76AA==
X-Received: by 2002:adf:ff83:: with SMTP id j3mr10661859wrr.131.1584129035345; 
 Fri, 13 Mar 2020 12:50:35 -0700 (PDT)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id r9sm11143511wma.47.2020.03.13.12.50.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2020 12:50:34 -0700 (PDT)
Subject: Re: [PATCH 1/7] via-ide: move registration of VMStateDescription to
 DeviceClass
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, jsnow@redhat.com,
 amarkovic@wavecomp.com, mst@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, balaton@eik.bme.hu
References: <20200313082444.2439-1-mark.cave-ayland@ilande.co.uk>
 <20200313082444.2439-2-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f762079d-8f3a-e15a-1271-35acd926b30d@redhat.com>
Date: Fri, 13 Mar 2020 20:50:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200313082444.2439-2-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

On 3/13/20 9:24 AM, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/ide/via.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/hw/ide/via.c b/hw/ide/via.c
> index 096de8dba0..84f0efff94 100644
> --- a/hw/ide/via.c
> +++ b/hw/ide/via.c
> @@ -190,8 +190,6 @@ static void via_ide_realize(PCIDevice *dev, Error **e=
rrp)
>       bmdma_setup_bar(d);
>       pci_register_bar(dev, 4, PCI_BASE_ADDRESS_SPACE_IO, &d->bmdma_bar);
>  =20
> -    vmstate_register(VMSTATE_IF(dev), 0, &vmstate_ide_pci, d);
> -
>       for (i =3D 0; i < 2; i++) {
>           ide_bus_new(&d->bus[i], sizeof(d->bus[i]), DEVICE(d), i, 2);
>           ide_init2(&d->bus[i], qemu_allocate_irq(via_ide_set_irq, d, i))=
;
> @@ -227,6 +225,7 @@ static void via_ide_class_init(ObjectClass *klass, vo=
id *data)
>       PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
>  =20
>       dc->reset =3D via_ide_reset;
> +    dc->vmsd =3D &vmstate_ide_pci;
>       k->realize =3D via_ide_realize;
>       k->exit =3D via_ide_exitfn;
>       k->vendor_id =3D PCI_VENDOR_ID_VIA;
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


