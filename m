Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7790AC432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 16:44:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4768F20835
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 16:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXezjW9r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4768F20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZHTm-0005Sv-CD
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 11:44:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49207)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iZHSm-0004re-ED
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 11:43:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iZHSj-0008Jy-Qo
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 11:43:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54882
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iZHSj-0008JQ-Di
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 11:43:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574700224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MPhoo0VeyH5NGEv/9hK5NSgqBptH6y2zZVQor/nUXqU=;
 b=iXezjW9rfLVwzP4YG0yGo3rXSTRm+8c4YisA3tvwYIBcrvY9EUXjdyrmCy7Hpy2k59uc2e
 WYpFaCYrn/ndxfnzlMC2tzmrt3XKXteX+KMMlcRISR/Th9wPVLTY/KiMy6WprX1rTusPbw
 J+ELwHWAglGUL0mcCKDq9kSuitZU1ps=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-xoilJ6OzNuuHgyg0tCzmfg-1; Mon, 25 Nov 2019 11:43:43 -0500
Received: by mail-wm1-f70.google.com with SMTP id k7so1199213wmj.3
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 08:43:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OtsS3oCfpEcjGmHSDfZ97GZCX/3fMbZoD6U8VUcDJeY=;
 b=TxwxU8xt92HrUF8hnLFgUBqoaQZINJZuu68Dj1Oqom0ogr348puIrqQvcrTg7t9+eN
 KDBFNLCJNqigmK4mWMHylDWt26YTBPjHeEXuT2fFCArBXw2nkY48h7Ca7Cr3u63YcFqq
 DD+mgakc35EwVLatSkoRLQ4QT3FSNRu8ABhlF3r4fXFqukCMMyUQGbhAjq4pCctSlR4j
 KONwJWdbGvTHaDY0GOfIr0b8ysbM1QIBAYFHEPDI8PNg7DeIQS9N1avqr0wwtwURBkH1
 HkdcmPOjsm04GYgjx3qfIOH69qlRmzeEdx9P0Pn2XusGr3e7dX46BntKDee/mf8T+U1U
 CWow==
X-Gm-Message-State: APjAAAXe++N5a7VYds8pXAXHZpF9HyuJxqtF2wSW9O5AQzLdoWQGq1/h
 OGoV1B5mcSkS15hQvBOCj2+M5F7ltTHZwxz/GFr5QkpCQOeOeG/jli8LY46I02b0aJFSQf5C59/
 E2eVd/ACusPJTUGM=
X-Received: by 2002:a5d:570a:: with SMTP id a10mr31931303wrv.107.1574700221898; 
 Mon, 25 Nov 2019 08:43:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqyzsEqb2u4+Bun2TfDt9Fz8ExM//uH9sy5OQLnlzm2P/U9mw1H2OpnRtAKgM9PU/HOc0MAYQg==
X-Received: by 2002:a5d:570a:: with SMTP id a10mr31931285wrv.107.1574700221689; 
 Mon, 25 Nov 2019 08:43:41 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id m15sm11195850wrj.52.2019.11.25.08.43.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2019 08:43:41 -0800 (PST)
Subject: Re: [PATCH 2/4] ich9: fix getter type for sci_int property
To: Felipe Franciosi <felipe@nutanix.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20191125153619.39893-1-felipe@nutanix.com>
 <20191125153619.39893-3-felipe@nutanix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <deed1398-8b39-02b9-6da5-6d1fc4edff4b@redhat.com>
Date: Mon, 25 Nov 2019 17:43:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191125153619.39893-3-felipe@nutanix.com>
Content-Language: en-US
X-MC-Unique: xoilJ6OzNuuHgyg0tCzmfg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/25/19 4:36 PM, Felipe Franciosi wrote:
> When QOM APIs were added to ich9 in 6f1426ab, the getter for sci_int was
> written using uint32_t. However, the object property is uint8_t. This
> fixes the getter for correctness.
>=20
> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> ---
>   hw/isa/lpc_ich9.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index 5555ce3342..240979885d 100644
> --- a/hw/isa/lpc_ich9.c
> +++ b/hw/isa/lpc_ich9.c
> @@ -631,9 +631,9 @@ static void ich9_lpc_get_sci_int(Object *obj, Visitor=
 *v, const char *name,
>                                    void *opaque, Error **errp)
>   {
>       ICH9LPCState *lpc =3D ICH9_LPC_DEVICE(obj);
> -    uint32_t value =3D lpc->sci_gsi;
> +    uint8_t value =3D lpc->sci_gsi;
>  =20
> -    visit_type_uint32(v, name, &value, errp);
> +    visit_type_uint8(v, name, &value, errp);

Maybe directly as:

        visit_type_uint8(v, name, &lpc->sci_gsi, errp);

With/without stack variable:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>   }
>  =20
>   static void ich9_lpc_add_properties(ICH9LPCState *lpc)
> @@ -641,7 +641,7 @@ static void ich9_lpc_add_properties(ICH9LPCState *lpc=
)
>       static const uint8_t acpi_enable_cmd =3D ICH9_APM_ACPI_ENABLE;
>       static const uint8_t acpi_disable_cmd =3D ICH9_APM_ACPI_DISABLE;
>  =20
> -    object_property_add(OBJECT(lpc), ACPI_PM_PROP_SCI_INT, "uint32",
> +    object_property_add(OBJECT(lpc), ACPI_PM_PROP_SCI_INT, "uint8",
>                           ich9_lpc_get_sci_int,
>                           NULL, NULL, NULL, NULL);
>       object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_ENABLE=
_CMD,
>=20


