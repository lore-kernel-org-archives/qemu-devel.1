Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCCAC32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:25:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7DEC2051A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="apH2WzgP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7DEC2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipWss-0003Bx-SF
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 07:25:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ipWrp-0002Dm-SZ
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:24:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ipWro-0000l7-R0
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:24:49 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46890
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ipWro-0000ic-Jo
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:24:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578572688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OB1xzPD4rgYQ8vX4TJ3tTwE4NmCDFFTjcPOSPU+R8C0=;
 b=apH2WzgPGlWYaFzNZeWeioN5rM9t+G8NIXVm3QhdNv/zdWVbhkjPULSAx9nZJksqs28/g/
 CitXy1yjMyc3C8zDBOVHOleoxIyRUo6kBWo5CcOLEiBRxiDz94tKSWrTyiY/u318SYZJsu
 JHDWCqAORHjGQzYMWchZsskz2XdQUo0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-RwqbfooiNmiy8jE1lzlf9w-1; Thu, 09 Jan 2020 07:24:46 -0500
Received: by mail-wm1-f72.google.com with SMTP id t4so859162wmf.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 04:24:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VGb2MVMwFsPS0hXL7soXg/9gSazYXBkfZQYSRJYt+h4=;
 b=gRgfSnW/HbtMGaFWF7EZ4o+dWjOaYE7BXQy7p/HUbi6oqk+Xu9XJKgOSeDeMWd8kgg
 EjKtLyi3XaRNSB8vbZ8X4mEtxR5d9B25+VBP1L2GAfBitBkCUC/fs/1+vGMsQew8/qxZ
 OMcykqUYzn8BPqdsjN9GY7V7DXo6twN3n+T+Ak10Z5ARgN7Ovs//KfOQiy146u3LR22L
 s+2q/LZ70Oqz70/dawHm1/qcK/38abfp7Od4SAcxIiosOzz+Xxzt7Hb0WLG7n26asToW
 vEgZQI4xNoWBqUKU2xB4RiWjiUkrlHpDHRSLBTwPkSjgXYGsEkT208krP6A5V3LcUqkL
 weXA==
X-Gm-Message-State: APjAAAVLmTrqF3fuGUYVkt6IpW3KM0szSetLRxCGZksgi0eGj76VByQV
 ySxaap9YqIB2R3myvE6xlYj7hw05b/0+utrhjJQQxuwaJME79eDLcnz5/wetMEn9iPpBwLIckHI
 6m4tgqzSRiNSe4I0=
X-Received: by 2002:a7b:cb97:: with SMTP id m23mr4511848wmi.37.1578572685641; 
 Thu, 09 Jan 2020 04:24:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqyz9eFIsFTp/omFV42cnn9o2/0UB6OEyFk5whpGVz+H3PYurkrvCPBWV9bc/dcfQ+COa0HJWg==
X-Received: by 2002:a7b:cb97:: with SMTP id m23mr4511831wmi.37.1578572685502; 
 Thu, 09 Jan 2020 04:24:45 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id j2sm2736456wmk.23.2020.01.09.04.24.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2020 04:24:45 -0800 (PST)
Subject: Re: [PATCH 3/4] vl: Remove useless test in configure_accelerators
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200109021710.1219-1-richard.henderson@linaro.org>
 <20200109021710.1219-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4e746640-4e9e-d41d-2a5e-52060b8cf4db@redhat.com>
Date: Thu, 9 Jan 2020 13:24:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200109021710.1219-4-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: RwqbfooiNmiy8jE1lzlf9w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
> The result of g_strsplit is never NULL.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   vl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/vl.c b/vl.c
> index c9329fe699..887dbfbb5d 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2776,7 +2776,7 @@ static void configure_accelerators(const char *prog=
name)
>  =20
>           accel_list =3D g_strsplit(accel, ":", 0);
>  =20
> -        for (tmp =3D accel_list; tmp && *tmp; tmp++) {
> +        for (tmp =3D accel_list; *tmp; tmp++) {
>               /*
>                * Filter invalid accelerators here, to prevent obscenities
>                * such as "-machine accel=3Dtcg,,thread=3Dsingle".
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


