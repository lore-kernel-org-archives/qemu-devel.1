Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B149BC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 06:39:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7421220730
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 06:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SGnTxus7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7421220730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isLHd-0001wU-I3
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 01:39:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53430)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isLGY-0001GJ-Ah
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 01:37:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isLGW-00011z-Mf
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 01:37:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41112
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isLG4-0000hO-Hs
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 01:37:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579243047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=axgy/C/X8S+Unss4rvrGoCjua5WL21OATxGXSOxwsf0=;
 b=SGnTxus7DEhTfX0RviOHIJvuqrPn0LoUfm+z/yxbTB+TtEDrVWUVNsN/nz+PXRmOy8QqRz
 MZeg/lkkrrP8jiUD0PlASnN9LK8vsIyDoYZL7OJ3Vixk6VDZWjGssmmyhlbsU0/Rg7U50f
 d/bMHqpB/SKkILi/mUCtem7UHRUL078=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-pT3xZzlPNIKkZIQwMBWT0A-1; Fri, 17 Jan 2020 01:37:24 -0500
Received: by mail-wm1-f69.google.com with SMTP id b9so1877140wmj.6
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 22:37:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GlIcaRcVkjvqtX/E55/LVZ/lCyqpqFpKRwHrpYuNVV4=;
 b=tAiW6AbNXos8Qtzj6lADKcJR/nk3cR5HlHxFPsuiiw25FNlEoGoHQNIccq7zUi07ZP
 QIuHYu13XFHlVVMCocqvUkT0T5jBe1wwGcR6HmUtsNW27YJp9yRFv77uTzL8E2HnGjDZ
 8ZZOYW791E3nShSbSQt9GsC4buLD3eCEz1Ma/JWIVFDhkL9J2cta8xd0S1vFnTPeJDD9
 ctfwNVf6YRTjQ9vrprcipTEUus7/BNlPSaps1uEOIkcEyt1GydU5iZFZT0SZ76yzJaKY
 arwBr5xWO5P2y0d2Lmz4JyMAf9P5JJe2D7M7x+9vbL5qdbv0B27daJTnRDa76UDMqsy7
 tz8Q==
X-Gm-Message-State: APjAAAUdgiRa3Gtgx81nEB7jPCDO7C2+uYWzBLqKQIRvpp7gFsj8a2ME
 B5AvLVp/JT3h7ol5s+V+/VXBrc592HyZdi/51nClXo3UngnXUbyawqmIlKKCcTyaQfmxmgMXdQk
 C2Ml9azAx9QOQ+UU=
X-Received: by 2002:adf:f885:: with SMTP id u5mr1309022wrp.359.1579243043415; 
 Thu, 16 Jan 2020 22:37:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqyOqOKDwR+wN7p7cxxchUDXTtgUKGDDfGzMXPeV/WnlpZ+rIXEyvwszI20gfCnTweiycK2ASA==
X-Received: by 2002:adf:f885:: with SMTP id u5mr1308989wrp.359.1579243043059; 
 Thu, 16 Jan 2020 22:37:23 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id s15sm30323481wrp.4.2020.01.16.22.37.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2020 22:37:22 -0800 (PST)
Subject: Re: [PATCH v2 5/5] linux-user: Flush out implementation of
 gettimeofday
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200116194341.402-1-richard.henderson@linaro.org>
 <20200116194341.402-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <da0fef63-2a14-ce3e-7328-efa689ad19ea@redhat.com>
Date: Fri, 17 Jan 2020 07:37:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200116194341.402-6-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: pT3xZzlPNIKkZIQwMBWT0A-1
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
Cc: alex.bennee@linaro.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/16/20 8:43 PM, Richard Henderson wrote:
> The first argument, timeval, is allowed to be NULL.
>=20
> The second argument, timezone, was missing.  While its use is
> deprecated, it is still present in the syscall.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/syscall.c | 27 +++++++++++++++++++++++++--
>   1 file changed, 25 insertions(+), 2 deletions(-)
>=20
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index eb867a5296..628b4de9a1 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -1219,6 +1219,23 @@ static inline abi_long host_to_target_timespec64(a=
bi_ulong target_addr,
>       return 0;
>   }
>  =20
> +static inline abi_long copy_to_user_timezone(abi_ulong target_tz_addr,
> +                                             struct timezone *tz)
> +{
> +    struct target_timezone *target_tz;
> +
> +    if (!lock_user_struct(VERIFY_WRITE, target_tz, target_tz_addr, 1)) {
> +        return -TARGET_EFAULT;
> +    }
> +
> +    __put_user(tz->tz_minuteswest, &target_tz->tz_minuteswest);
> +    __put_user(tz->tz_dsttime, &target_tz->tz_dsttime);
> +
> +    unlock_user_struct(target_tz, target_tz_addr, 1);
> +
> +    return 0;
> +}
> +
>   static inline abi_long copy_from_user_timezone(struct timezone *tz,
>                                                  abi_ulong target_tz_addr=
)
>   {
> @@ -8567,10 +8584,16 @@ static abi_long do_syscall1(void *cpu_env, int nu=
m, abi_long arg1,
>       case TARGET_NR_gettimeofday:
>           {
>               struct timeval tv;
> -            ret =3D get_errno(gettimeofday(&tv, NULL));
> +            struct timezone tz;
> +
> +            ret =3D get_errno(gettimeofday(&tv, &tz));
>               if (!is_error(ret)) {
> -                if (copy_to_user_timeval(arg1, &tv))
> +                if (arg1 && copy_to_user_timeval(arg1, &tv)) {
>                       return -TARGET_EFAULT;
> +                }
> +                if (arg2 && copy_to_user_timezone(arg2, &tz)) {
> +                    return -TARGET_EFAULT;
> +                }
>               }
>           }
>           return ret;
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


