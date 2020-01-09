Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10240C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:24:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFB782075D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eCzjzzsG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB782075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipWrI-0001HZ-Rj
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 07:24:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58541)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ipWqU-0000Oe-O9
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:23:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ipWqT-0003l5-K4
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:23:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41982
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ipWqT-0003iY-Cz
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:23:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578572604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=en2CtkHwZjLvcLDAW2tX0QKYYhUKgqPO0BaTY9eMZCs=;
 b=eCzjzzsGY9gVCYblHA6FSUXDXQwH2aUowODWvo54/kg3ynaxP3blZd1Nc+EVW4EeAYVi5h
 +f0hsAYLsFCJb8Pbum5lSjVkbghuw7imGo86sC8WFQSpPRRfxZX5+AL0MllDq8LzbsD276
 6cTYjmrZAhxH1e4MzVbatJIrzdjtU0k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-_uHbvFjyP4CdNWd369ldYQ-1; Thu, 09 Jan 2020 07:23:21 -0500
Received: by mail-wr1-f69.google.com with SMTP id o6so2810809wrp.8
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 04:23:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=255EAR8KYoTOzC5NdJ6V5YeXqcb8MrjGKbH3DTq7zAE=;
 b=uGsLFcveF7Is+rPy/fJlollgg4Xt6BZ/RuJYo/n4DAHoYwUCwqhwkc/KOxi7nI01my
 xHbfLwjUDFVIACQ+UHK0TAfudmz5jOtvIJvzdkQsg6J2IkB+1fk+ZcLL8y2gk1X9+aYl
 uhS7hSrgjKP5Fj5gWxN4bQU2qreTAJVf7JO2Bo1++7EPBKR4a9CvHW+ubigYgX85rO82
 a3Re+RaQmAO1lc8gMW5RQYA3VJWpxFtp7+hKqnN3WHxQCSPhSANjkqtAMKX1C//ogkAw
 N5nyD8GnoF6hXdF/wW8dZmgCto0BQI2+ugfeRXfITxG+C9qskXLagIXF6YRQ6MmzaJYj
 zH3g==
X-Gm-Message-State: APjAAAXA1Dy1+xe6YgMmWBmzChjjgb9oBPn9aEIvzWmsjN3RG6hzvHnc
 fT+lwN/4lGKlPLvA7OIXsjMKX8jwAX+8nKGs/Utll0gdIl4daoubFJtW5zJFv0iTPM37wtPWQxL
 bYF6xwkhaBa17/WA=
X-Received: by 2002:a1c:960c:: with SMTP id y12mr4570039wmd.9.1578572600555;
 Thu, 09 Jan 2020 04:23:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqy+nQN9o9DWPMprdRaL9uss+xLsySwTFz6Rc/t+ICzZdqnDJ9BIEEWAoAcJSBer4CfUN4aIYQ==
X-Received: by 2002:a1c:960c:: with SMTP id y12mr4570006wmd.9.1578572600282;
 Thu, 09 Jan 2020 04:23:20 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id m7sm2661782wma.39.2020.01.09.04.23.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2020 04:23:19 -0800 (PST)
Subject: Re: [PATCH 1/4] vl: Remove unused variable in configure_accelerators
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200109021710.1219-1-richard.henderson@linaro.org>
 <20200109021710.1219-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f6bd666e-5389-0066-57ff-4f4290cce5bb@redhat.com>
Date: Thu, 9 Jan 2020 13:23:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200109021710.1219-2-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: _uHbvFjyP4CdNWd369ldYQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/9/20 3:17 AM, Richard Henderson wrote:
> The accel_initialised variable no longer has any setters.
>=20
> Fixes: 6f6e1698a68c
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   vl.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/vl.c b/vl.c
> index 86474a55c9..be79b03c1a 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2749,7 +2749,6 @@ static void configure_accelerators(const char *prog=
name)
>   {
>       const char *accel;
>       char **accel_list, **tmp;
> -    bool accel_initialised =3D false;
>       bool init_failed =3D false;
>  =20
>       qemu_opts_foreach(qemu_find_opts("icount"),
> @@ -2776,7 +2775,7 @@ static void configure_accelerators(const char *prog=
name)
>  =20
>           accel_list =3D g_strsplit(accel, ":", 0);
>  =20
> -        for (tmp =3D accel_list; !accel_initialised && tmp && *tmp; tmp+=
+) {
> +        for (tmp =3D accel_list; tmp && *tmp; tmp++) {
>               /*
>                * Filter invalid accelerators here, to prevent obscenities
>                * such as "-machine accel=3Dtcg,,thread=3Dsingle".
>=20


