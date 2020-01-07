Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D84C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 18:24:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEB882072A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 18:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EIwI71ox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB882072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iotWu-0005rI-0R
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 13:24:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iotVv-0004j7-FQ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 13:23:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iotVu-0008WS-AM
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 13:23:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54405
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iotVu-0008Vz-6S
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 13:23:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578421413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zHjkuccKppqypydxuDPGzoEt0jcmMirUGApGLSr7JlI=;
 b=EIwI71oxHiLG9VpkXvWdrHv2OMrg2l4DVDc4fyF0KY2fsvhqSPUI5CthlaQIVXbRtUKvvt
 W0L8tYNqOS67pjpc3KkfW53jXtokJy/4KZP4q+/qyw6h3EATQeUKntM+TcX2KH4WWfBUXn
 yIMUBAh7eHcC6ydT5BU185J1HWPNKbs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-DLj5t1fwP0ixiQwM0REqIA-1; Tue, 07 Jan 2020 13:23:32 -0500
Received: by mail-wr1-f71.google.com with SMTP id c17so294154wrp.10
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 10:23:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2luVF8aW2NHEngoM8l2DOL8mqXuRO+v4E6hTAQKgKfg=;
 b=B4ToWTD4CUkEh2ILj5++KRNJJx8an7kG6fevNfoUaDSFKgtSMeitKeQW7fpudLgadd
 7YJRiRE5q7diBe03J9KPKrOQzJrAuFhF7i8EA24GwZD+Y1d+pEBVoaeqnTaDk+ijqh9E
 t6qo+SJuE4tmKUlHkbjYjBcQ2cw2AjrXOvlGVJNK03+zJ+XWD1uLN+B1NTquYFw/5uJn
 w0xy4O/5BPRiJCSMPS0quNYWZ2I+q8wxsrqkrffeE7/uXkQIl8yCMrnES1ZNmkhxvjER
 LOPz0/lQXYvbaeAEOvpYn5CglUVJykFx/pMw9OSRceatniZkDHwBF6C/RoIAjGn1T1Pe
 E/Mg==
X-Gm-Message-State: APjAAAX0ibtFtOvkzL7nrPcycHv6l6NbmzMzjyvnVZMgepOwQfNadDA9
 QbM3MeVkL1RXALeoS1PsNrRc8xoj6MAxHpiUi0UE3pYJ3RMdtdY7U6iFpVFwX4JRQ0C3Z59hO40
 uSAlCV6SLFhNMHYs=
X-Received: by 2002:a5d:4481:: with SMTP id j1mr421747wrq.348.1578421411280;
 Tue, 07 Jan 2020 10:23:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqypBPTFKvbPTuDy8QSRjb2T3nB/pkrd3p2/q3RuLyi2vHNe+qJhx9IDIHr0c2qrxAQUL1JOag==
X-Received: by 2002:a5d:4481:: with SMTP id j1mr421733wrq.348.1578421411089;
 Tue, 07 Jan 2020 10:23:31 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id x10sm753077wrv.60.2020.01.07.10.23.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 10:23:30 -0800 (PST)
Subject: Re: [PATCH 2/2] ppc/pnv: fix check on return value of blk_getlength()
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200107171809.15556-1-clg@kaod.org>
 <20200107171809.15556-3-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4ab18692-87f9-348f-4657-bd933d41ae59@redhat.com>
Date: Tue, 7 Jan 2020 19:23:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200107171809.15556-3-clg@kaod.org>
Content-Language: en-US
X-MC-Unique: DLj5t1fwP0ixiQwM0REqIA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/7/20 6:18 PM, C=C3=A9dric Le Goater wrote:
> blk_getlength() returns an int64_t but the result is stored in a
> uint32_t. Errors (negative values) won't be caught by the check in
> pnv_pnor_realize() and blk_blockalign() will allocate a very large
> buffer in such cases.
>=20
> Fixes Coverity issue CID 1412226.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>   include/hw/ppc/pnv_pnor.h | 2 +-
>   hw/ppc/pnv_pnor.c         | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv_pnor.h b/include/hw/ppc/pnv_pnor.h
> index c3dd28643cae..4f96abdfb402 100644
> --- a/include/hw/ppc/pnv_pnor.h
> +++ b/include/hw/ppc/pnv_pnor.h
> @@ -23,7 +23,7 @@ typedef struct PnvPnor {
>       BlockBackend   *blk;
>  =20
>       uint8_t        *storage;
> -    uint32_t       size;
> +    int64_t        size;
>       MemoryRegion   mmio;
>   } PnvPnor;
>  =20
> diff --git a/hw/ppc/pnv_pnor.c b/hw/ppc/pnv_pnor.c
> index 0e86ae2feae6..b061106d1c0c 100644
> --- a/hw/ppc/pnv_pnor.c
> +++ b/hw/ppc/pnv_pnor.c
> @@ -111,7 +111,7 @@ static void pnv_pnor_realize(DeviceState *dev, Error =
**errp)
>   }
>  =20
>   static Property pnv_pnor_properties[] =3D {
> -    DEFINE_PROP_UINT32("size", PnvPnor, size, 128 << 20),
> +    DEFINE_PROP_INT64("size", PnvPnor, size, 128 << 20),

If you respin the series please consider using '128 * MiB' here.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>       DEFINE_PROP_DRIVE("drive", PnvPnor, blk),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>=20


