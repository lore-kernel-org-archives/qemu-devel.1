Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59973C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 08:44:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23D06206DA
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 08:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VUe1nwBg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D06206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iokTQ-0000qd-CV
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 03:44:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60570)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iokCt-0004Bh-L7
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 03:27:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iokCs-0002UB-FW
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 03:27:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35239
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iokCs-0002Tz-CR
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 03:27:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578385637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0xOdtA5Hm527atS9liTD1cNM+kxAnPoAntCUfXsbRzY=;
 b=VUe1nwBgOpcVReLAZ0jP58efeuMVkPe+pZB2C1hBrr8D0m38CPzsXnoWOU1rbB2S/sfMi3
 x/tNI54IddQbjB2tkHqopbdN0l0Im0WdvdFXjq8W8kJrAuiMFTmJ6bTFrNtmP7qWJj6DQc
 Xl6LZgT5F23iTci/P16HKVsns6DwbS8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-4pUxIXGNPiym-hkmShPnYw-1; Tue, 07 Jan 2020 03:27:16 -0500
Received: by mail-wr1-f69.google.com with SMTP id b13so10668711wrx.22
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 00:27:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YljHyZQD8wWZ6y55a3h8yV8boCthINCc8qO8qOBsUWg=;
 b=V0FYA7DDAG5OzumzftbbsCUZbC293h+AyE7sV/ra/NHLv43qlFOvDOOYm5upsfYyCD
 YH/soRyBRBU5xRLSmE4TNQ3PFj6j8VXagfNoeBK3vO0nrInFOP7ON2LEXaWm1NlWVqhG
 MVEY3LBt9hyGevXuLOWhSbUySn6lx2kv8VBOxv/raySC+QzvcbzrGAQl4acSl5gcs5Jc
 Pboms6ipNeJlrh5pvGPDKJzOInxIZJ//E5uPanye+LzrgFivjbYkAd7Q8bRL23tsXQV6
 5gLUJEyJStkb/8/3YnuHYsNGdYwzSCZsHZxdofoZxv8/p57IXcAPyWTHL1KQg1pZuXbd
 Q35A==
X-Gm-Message-State: APjAAAUQDhM1K6elnmSgMIBZJ5EpAy2vRUQqAPJqE2LnAaq7/6vz3Pek
 UlfzLVzms+sZg/DcE4OAbLectbOFwieCCF0vz9OnfD6WtoTGbK0odRj6vviE01NkigG50NTxZhZ
 5IfrqCDmVf04ByzE=
X-Received: by 2002:adf:f052:: with SMTP id
 t18mr104839214wro.192.1578385635434; 
 Tue, 07 Jan 2020 00:27:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqwm94yci6MtRuCRdFbmdXbPfGTdMeIAgS+Wp1iDaGYZLD+Y/slHsW2thSdJFcXT4c4VHiow+Q==
X-Received: by 2002:adf:f052:: with SMTP id
 t18mr104839198wro.192.1578385635270; 
 Tue, 07 Jan 2020 00:27:15 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id f1sm74933741wro.85.2020.01.07.00.27.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 00:27:14 -0800 (PST)
Subject: Re: [PATCH 3/5] ftgmac100: check RX and TX buffer alignment
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200107073423.30043-1-clg@kaod.org>
 <20200107073423.30043-4-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1587acec-3d08-9dfa-0bcc-37140fd5e2ad@redhat.com>
Date: Tue, 7 Jan 2020 09:27:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200107073423.30043-4-clg@kaod.org>
Content-Language: en-US
X-MC-Unique: 4pUxIXGNPiym-hkmShPnYw-1
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/7/20 8:34 AM, C=C3=A9dric Le Goater wrote:
> These buffers should be aligned on 16 bytes.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>   hw/net/ftgmac100.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>=20
> diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
> index 86ac25894a89..051f7b7af2d6 100644
> --- a/hw/net/ftgmac100.c
> +++ b/hw/net/ftgmac100.c
> @@ -198,6 +198,8 @@ typedef struct {
>       uint32_t        des3;
>   } FTGMAC100Desc;
>  =20
> +#define FTGMAC100_DESC_ALIGNMENT 16
> +
>   /*
>    * Specific RTL8211E MII Registers
>    */
> @@ -722,6 +724,12 @@ static void ftgmac100_write(void *opaque, hwaddr add=
r,
>           s->itc =3D value;
>           break;
>       case FTGMAC100_RXR_BADR: /* Ring buffer address */
> +        if (!QEMU_IS_ALIGNED(value, FTGMAC100_DESC_ALIGNMENT)) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad RX buffer alignment =
0x%"
> +                          HWADDR_PRIx "\n", __func__, value);
> +            return;

What is the hardware behavior?

> +        }
> +
>           s->rx_ring =3D value;
>           s->rx_descriptor =3D s->rx_ring;
>           break;
> @@ -731,6 +739,11 @@ static void ftgmac100_write(void *opaque, hwaddr add=
r,
>           break;
>  =20
>       case FTGMAC100_NPTXR_BADR: /* Transmit buffer address */
> +        if (!QEMU_IS_ALIGNED(value, FTGMAC100_DESC_ALIGNMENT)) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad TX buffer alignment =
0x%"
> +                          HWADDR_PRIx "\n", __func__, value);
> +            return;
> +        }
>           s->tx_ring =3D value;
>           s->tx_descriptor =3D s->tx_ring;
>           break;
>=20


