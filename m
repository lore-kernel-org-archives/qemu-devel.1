Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3195AC0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 22:06:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E18FD2051A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 22:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NFIAtC3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E18FD2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDEvN-0006JA-5b
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 18:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDEuM-0005p2-Ev
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 18:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDEuK-0000HA-RA
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 18:05:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26714
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDEuK-0000G5-Mz
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 18:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584223524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ywgVEh+Uv3Ll5wNGFdAHgd1uagMecsN/jShOB8xd2x8=;
 b=NFIAtC3w3cxEYjEh64lpi3P+OBGpcrkpVMhgcVmNksgvQnGcs7Q0gFDJnT3DXHDZRFhRYC
 hjNPujDoZuUfvi/Sth5xtDHFJIlX40sTVXtQx+5enQm82JdJbjmjTS1usvj5ppJu6QYrA/
 9331x4/Ifu6Q60Rovu0UcPgmIRBJ60w=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-Y-zXSpj1Ntm_NVKZHK23pQ-1; Sat, 14 Mar 2020 18:05:22 -0400
X-MC-Unique: Y-zXSpj1Ntm_NVKZHK23pQ-1
Received: by mail-ed1-f70.google.com with SMTP id b100so11394756edf.15
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 15:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6l/EBE5s3xNOwlAehBZTMi7Wo67tEPscLhfcCCQW0tI=;
 b=dUwz2ythX4iR+AVRppbi0cLGwC4yx4yIfbEYUo8bfu0t8qaJaakRzJaNed6Y3cxjOH
 mnURadeBkQDcxZtJFEXlLKwLn28N1H6L5V0CyzNn/z5neJWRDSAzpi4VAzYbP1j3uDEx
 AS8HfySLQnTa1Vr/KixfhmSredZ3wzPGT8XWJyeDrNPmhmLZxdxdLIVZsQ8nck3zN530
 UcZ/ZQMUF5f0y5QDugBu/y7+/78YGTvputRwLI3ZMT849HHdIz2wIWFc5RY1UcUYeEka
 MHyY0tQwQrp/GGpmdBQk0UJkFB+k99Pwb3Pe0n0koxzMRCYDuEUxCMJAhKXx0VG5+pgb
 XFEw==
X-Gm-Message-State: ANhLgQ2oLT5tbutaL3vApwCnPo+xYUwuyPnLRPdqXpG9YO2eN8uUDnqF
 HKhHDSbCd1/nYtX1Mk6S54qHQWZU/NuEy+vhJP97XSE9nKkiX23VdI0ZBbxBjpfa8sSwu29tNYt
 IZ+jYj6FNWG++3Ys=
X-Received: by 2002:aa7:dbd8:: with SMTP id v24mr3295241edt.366.1584223521522; 
 Sat, 14 Mar 2020 15:05:21 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtJwUrueWvTcPptXCNFmYIs0uUNqRfDAH6qPSDqkkW23QSyQu9qdX2BJLYG7afAkEaTo9Sm5Q==
X-Received: by 2002:aa7:dbd8:: with SMTP id v24mr3295207edt.366.1584223521198; 
 Sat, 14 Mar 2020 15:05:21 -0700 (PDT)
Received: from [192.168.1.40] (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id x62sm2176340ede.55.2020.03.14.15.05.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 15:05:20 -0700 (PDT)
Subject: Re: [PATCH 5/8] hw/ide/pci.c: Coding style update to fix checkpatch
 errors
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <cover.1584134074.git.balaton@eik.bme.hu>
 <34bdee6ddddd7943b9a68547f46c76f30b9a7e75.1584134074.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f0a5e41a-72c8-084f-8374-6bebebf216e2@redhat.com>
Date: Sat, 14 Mar 2020 23:05:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <34bdee6ddddd7943b9a68547f46c76f30b9a7e75.1584134074.git.balaton@eik.bme.hu>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, hpoussin@reactos.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/13/20 10:14 PM, BALATON Zoltan wrote:
> Spaces are required around a + operator and if statements should have
> braces even for single line. Also make it simpler by reversing the
> condition instead of breaking the loop.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> ---
>   hw/ide/pci.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ide/pci.c b/hw/ide/pci.c
> index 4fc76c5225..e0c84392e2 100644
> --- a/hw/ide/pci.c
> +++ b/hw/ide/pci.c
> @@ -485,9 +485,9 @@ void pci_ide_create_devs(PCIDevice *dev, DriveInfo **=
hd_table)
>       int i;
>  =20
>       for (i =3D 0; i < 4; i++) {
> -        if (hd_table[i] =3D=3D NULL)
> -            continue;
> -        ide_create_drive(d->bus+bus[i], unit[i], hd_table[i]);
> +        if (hd_table[i]) {
> +            ide_create_drive(d->bus + bus[i], unit[i], hd_table[i]);
> +        }
>       }
>   }
>  =20
>=20


