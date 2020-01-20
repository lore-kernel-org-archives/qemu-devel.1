Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5475AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 11:20:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D8282087E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 11:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X9YQAZtf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D8282087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itV6l-0007sx-W7
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 06:20:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itUye-00067F-2E
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 06:12:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itUyY-0007km-Il
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 06:12:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48500
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itUyY-0007kR-F2
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 06:12:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579518729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CCc9FOqBpgV9bil5kXjPF5fCVOKfxfoIqoN9OpybMg0=;
 b=X9YQAZtfE+YIXnrDHsoZVdxPD1uQn1+Ni7BF/mbN/qE22VcfYLACgxkNDIpI9G7RTyLfDi
 lQ9aZYasLNiisgyqmM7g3mVJPcC3pvtoHTlRZdwx4n6oWIIIu4Q0UcSDI1+s+eBO/OeKKA
 yW2k+b/PsQMvp9SfnUekfFNWF77j+0E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-qO0zcBiVOnGGxyMg6S88fA-1; Mon, 20 Jan 2020 06:12:06 -0500
Received: by mail-wr1-f69.google.com with SMTP id o6so13948205wrp.8
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 03:12:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=J3a5cwaiyzD9NpBASnFL5ShUCvK6h8t/Ve/HEsKNh04=;
 b=nRjwDxzIllpvIYwqLEsjQDl9p/vhMO0kTxdOFLTBmuKX9kcoPm/pEGPg41sA/BgvYX
 BVF0Jw39U1goC8+9ZdI3NSTKWnPKcMQE3n6649JsZBEBm5IijMRYt10K1ZycVyxxVWBR
 7S6LoVf8Th7UVDYtSxe8SEPwY96mLhl+PjYSZ8LbMUTsrX4jlOBGd5CRHxdBtmMiNA52
 O6kFtIg3R5yR2W1ZNpe1lh3bqdK4DFfp4t3EmPtOv4Rz4jWQYPwLoMfhnFZ/tSOyZAvp
 GWH3Xg8NLoJRtEugz8jth5FKgdEQ42Od3RTb0Exkpesh66rFpIywKxjANte8Uk5B4Fxx
 eW0w==
X-Gm-Message-State: APjAAAXJoJWBmCBZDYOpK7+kWIHI74Sw105JajEaNUf6UBHoQqXuIfpq
 iESEFdfWYibkVXQC2wBLLz+716Qerm7ss62nuy0rh1QS0aaMLs4QmJ4Kfcmil6AusCZlbwKhmB/
 iZpWiqKqa5fjQNPg=
X-Received: by 2002:a05:600c:24ca:: with SMTP id
 10mr18684265wmu.4.1579518724561; 
 Mon, 20 Jan 2020 03:12:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqyEphNQoGI+57Yowci/hDOq0N5+Lgs+MyPhKY2NRcFHqwaRTOqYt92K+w4nMQCeE3aBNZbqrg==
X-Received: by 2002:a05:600c:24ca:: with SMTP id
 10mr18684243wmu.4.1579518724265; 
 Mon, 20 Jan 2020 03:12:04 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id w20sm262408wmk.34.2020.01.20.03.12.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2020 03:12:03 -0800 (PST)
Subject: Re: [PATCH] audio/oss: fix buffer pos calculation
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200120101804.29578-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <37383db5-0a9a-4431-663e-3c20472abeb1@redhat.com>
Date: Mon, 20 Jan 2020 12:12:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200120101804.29578-1-kraxel@redhat.com>
Content-Language: en-US
X-MC-Unique: qO0zcBiVOnGGxyMg6S88fA-1
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
Cc: =?UTF-8?B?S8WRdsOhZ8OzIFpvbHTDoW4=?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/20/20 11:18 AM, Gerd Hoffmann wrote:
> Fixes: 3ba4066d085f ("ossaudio: port to the new audio backend api")
> Reported-by: ziming zhang <ezrakiez@gmail.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   audio/ossaudio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/audio/ossaudio.c b/audio/ossaudio.c
> index c43faeeea4aa..94564916fbf0 100644
> --- a/audio/ossaudio.c
> +++ b/audio/ossaudio.c
> @@ -420,7 +420,7 @@ static size_t oss_write(HWVoiceOut *hw, void *buf, si=
ze_t len)
>               size_t to_copy =3D MIN(len, hw->size_emul - hw->pos_emul);
>               memcpy(hw->buf_emul + hw->pos_emul, buf, to_copy);
>  =20
> -            hw->pos_emul =3D (hw->pos_emul + to_copy) % hw->pos_emul;
> +            hw->pos_emul =3D (hw->pos_emul + to_copy) % hw->size_emul;

Interestingly oss_put_buffer_out() is correct.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>               buf +=3D to_copy;
>               len -=3D to_copy;
>           }
>=20


