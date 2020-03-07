Return-Path: <SRS0=oVW3=4Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FF5C10F00
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 17:27:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABA7820674
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 17:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EL3KmAys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA7820674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAdEU-0002dq-UG
	for qemu-devel@archiver.kernel.org; Sat, 07 Mar 2020 12:27:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jAdDL-0001nE-UV
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:26:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jAdDK-0004kk-UH
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:26:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32765
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jAdDK-0004jX-R4
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:26:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583601974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=irGQdlOwQVL3O7xGR+93Qt7KZwdVfCzEiK7Bqz4U7e0=;
 b=EL3KmAysbz18CVgDSc13CXNNp4pr06i5lQ5V9bL4kfPNRB5m0BWHYkThc0WT0s7DjH/uSO
 oBCy9LCg0jmbzqXBXQk+nrCyM9HKdoP5uUGZi5WLP0efvzpJhgeLAgcRpaZ+rkQs07SPQ5
 PAPN31zVPkIe1ZKKkHkBAjJmZYX24F0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-0kdWz70NPXqXrcAed8n2zQ-1; Sat, 07 Mar 2020 12:26:12 -0500
X-MC-Unique: 0kdWz70NPXqXrcAed8n2zQ-1
Received: by mail-wr1-f70.google.com with SMTP id o9so2620355wrw.14
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2020 09:26:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=x+McOIRJd6zZ+RzgmOWhNpp/SA4u2NrFAJsBM8xiFOo=;
 b=qZl9v/myCKuEuD9zkZVfhZEip97DMznpHvJDS1CeJHmjRDDErxhzVFKQOj56A1HOhB
 ZldkGTy5eslFrI53QlH2dJqkKnd3tiEf+4x9FsSw2AgJpQI2CGLUnGP7VBfUDfYOF8T4
 BjmyDxf3NKgvgVRmpCStJn6Tspg19wkBEUEqBzjbKTVYMEmHj9AuR7XXgPq1ofbknGTK
 ULm4IcjVawXWWyl80XbxDykU0EfaNVLasyhC9K0VoiMLwa+TlL42ch4+mv2B2fFcVSAS
 BYSTbwAn8KdcB/NqlKIcq57lrFh7KG1hitQV1591hAcPE29CVrVZT8xAB135UNmx2f1z
 sYkg==
X-Gm-Message-State: ANhLgQ1SjuysGrkPidQj9kVE1DfwxFR9of7ONDmpi4pzdidYGklCYWvd
 UHGkKZ9f9GxZxmTCtTHZcrG/BhlgPiuk68JRxZx7Re3BECY1tKKURljvcWDMjWYwMa1MM9TfmrN
 pXJuYbecn/6sugdE=
X-Received: by 2002:a5d:4b03:: with SMTP id v3mr11087519wrq.81.1583601971561; 
 Sat, 07 Mar 2020 09:26:11 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvyj4xPdu6d+A/cNhyNBDaavsbZJVmW4Zoo5CZABnQ+37EpfwTXcZbLdp4ADQBHWbrKi2hVFA==
X-Received: by 2002:a5d:4b03:: with SMTP id v3mr11087503wrq.81.1583601971321; 
 Sat, 07 Mar 2020 09:26:11 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id x9sm12886903wrx.0.2020.03.07.09.26.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Mar 2020 09:26:10 -0800 (PST)
Subject: Re: [PATCH 2/2] cmd646: register vmstate_ide_pci VMStateDescription
 in DeviceClass
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, jsnow@redhat.com
References: <20200307151536.32709-1-mark.cave-ayland@ilande.co.uk>
 <20200307151536.32709-3-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c60bb796-51bb-d1f3-4ac7-c807a86c45ef@redhat.com>
Date: Sat, 7 Mar 2020 18:26:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200307151536.32709-3-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
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

On 3/7/20 4:15 PM, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/ide/cmd646.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
> index 2f11d8de24..3c4f765bd6 100644
> --- a/hw/ide/cmd646.c
> +++ b/hw/ide/cmd646.c
> @@ -301,8 +301,6 @@ static void pci_cmd646_ide_realize(PCIDevice *dev, Er=
ror **errp)
>           ide_register_restart_cb(&d->bus[i]);
>       }
>       g_free(irq);
> -
> -    vmstate_register(VMSTATE_IF(dev), 0, &vmstate_ide_pci, d);
>   }
>  =20
>   static void pci_cmd646_ide_exitfn(PCIDevice *dev)
> @@ -339,6 +337,7 @@ static void cmd646_ide_class_init(ObjectClass *klass,=
 void *data)
>       PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
>  =20
>       dc->reset =3D cmd646_reset;
> +    dc->vmsd =3D &vmstate_ide_pci;
>       k->realize =3D pci_cmd646_ide_realize;
>       k->exit =3D pci_cmd646_ide_exitfn;
>       k->vendor_id =3D PCI_VENDOR_ID_CMD;
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


