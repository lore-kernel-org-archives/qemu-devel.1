Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13727C2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:26:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDA35206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LXdXW0fI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA35206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLWRd-0007dZ-1l
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38636)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jLVxr-00073M-E3
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:55:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jLVxp-0007Hk-RY
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:55:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41110
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jLVxp-0007Gr-Nw
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586195713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EKVS7UdLyniSmV+K3U+BCWDj2PPZvEFKSkD0b/gjUnQ=;
 b=LXdXW0fIE+z/mk+hjSGHAYKH46ZsEHVc2QsR3NNCogyHZdgd/oG6G2DLksqeDR/aWND4QO
 Bb3DAh9ksSV2Ynw1jJWkAY0WWpx+Xnq16J1DhfMY58B2JR69rFt6xnUtl9lI0Fz9dvxsGi
 UXDV8M75MdjG4mfz0CUSlgZlNYC1Yt0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-MvmKDEKqPmCtWYDAC5JoMQ-1; Mon, 06 Apr 2020 13:55:09 -0400
X-MC-Unique: MvmKDEKqPmCtWYDAC5JoMQ-1
Received: by mail-wm1-f72.google.com with SMTP id t62so69185wma.0
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 10:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=69/nF/b5wOeG2gDS+VtZJUjVBoUPQDai/vkgLqbNy+I=;
 b=N/suR75vvnFr1XfrJu3goK+yGE1BVS7vVCIyDWwxY05Azs4xyzWCRwGDNTlVpeDxrG
 3TO43/WSmJgtTIeORfLwCIlEJD6WB+Ul9U27M/ZYRVYqOrJ3feM8fqdRiaFMqPcligQC
 U1g4mW2qbqblp/foCYMy+2jRhGIgjxs9c/OVR7pAwjkhhSnqtDEEdKwQcNQ39X9rF0EK
 qbqVcQGQvFniJ53eb5YUsHDbpqgZFe6f5kj1dRvdDSB2zmKKIy2IlRRzStS3cWUttZfi
 udpldorMIoJNfRJXole5EQI/cmXn//pLEtRmfiRERnbmaO9PIJv+Ms89lTW+ZzQWTXTR
 Cqzw==
X-Gm-Message-State: AGi0PuZ8892ezxZdEvjBkrfZdPhcw25OwJL9i+Z7NlnXy8p9TKMKUI9D
 cOuGo80Lulddrs2rx+sJP3wAMWZkFV/TcvefMIszlxKGgTkxlu/WlBWaTBMAgyfrjUq44IuAJQ/
 kfDPxeZGqQU+IA1c=
X-Received: by 2002:a5d:6a47:: with SMTP id t7mr362870wrw.131.1586195708901;
 Mon, 06 Apr 2020 10:55:08 -0700 (PDT)
X-Google-Smtp-Source: APiQypLJBm4ZnjflU1EPcLIcp6ojKFyCtmK2nGtPR/0SEdcv8hFxFnGRGrc+Vt/p9htPyKHchBfyeQ==
X-Received: by 2002:a5d:6a47:: with SMTP id t7mr362852wrw.131.1586195708653;
 Mon, 06 Apr 2020 10:55:08 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a2sm27277020wrp.13.2020.04.06.10.55.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2020 10:55:08 -0700 (PDT)
Subject: Re: [PATCH-for-5.1 v2 38/54] hw/arm/bcm2835_peripherals: Add missing
 error-propagation code
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20200406174743.16956-1-f4bug@amsat.org>
 <20200406174743.16956-39-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <08382aa3-a75d-7c78-0007-db7c828b8314@redhat.com>
Date: Mon, 6 Apr 2020 19:55:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200406174743.16956-39-f4bug@amsat.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Raspberry Pi" <qemu-arm@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/6/20 7:47 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Patch created mechanically by running:
>=20
>    $ spatch \
>      --macro-file scripts/cocci-macro-file.h --include-headers \
>      --sp-file scripts/coccinelle/object_property_missing_error_propagate=
.cocci \

sigh I forgot to update this, the scrip has been renamed=20
add-missing-error_propagate.cocci :(

>      --keep-comments --smpl-spacing --in-place --dir hw
>=20
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   hw/arm/bcm2835_peripherals.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>=20
> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
> index edcaa4916d..a111e91069 100644
> --- a/hw/arm/bcm2835_peripherals.c
> +++ b/hw/arm/bcm2835_peripherals.c
> @@ -289,8 +289,16 @@ static void bcm2835_peripherals_realize(DeviceState =
*dev, Error **errp)
>        *   SD3.0_Host_AHB_eMMC4.4_Usersguide_ver5.9_jan11_10.pdf
>        */
>       object_property_set_uint(OBJECT(&s->sdhci), 3, "sd-spec-version", &=
err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>       object_property_set_uint(OBJECT(&s->sdhci), BCM2835_SDHC_CAPAREG, "=
capareg",
>                                &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>       object_property_set_bool(OBJECT(&s->sdhci), true, "pending-insert-q=
uirk",
>                                &err);
>       if (err) {
>=20


