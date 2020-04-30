Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E6EC4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:53:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40F0D2074A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bkGh+6kF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F0D2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUAYw-0005qt-DB
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 10:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jUAY9-00054K-Dd
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:52:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jUAY8-00046Q-MA
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:52:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21635
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jUAY8-000462-62
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588258347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c1e1TIpTrXIfZ6A79RzyxLkTLFuqHbs7qs01DBnPYwk=;
 b=bkGh+6kFcJ8ZLBdaSM0lB5Bp+TRyZ8WVbthc9JVERYlTUfHP8eivePBiE38cw2qlyWky7a
 1WRNvhR6XzhmLRZCgCxBKW0UZO0N5Aqsb9FC762mjkXylO1Nz94H2vxYRIok69P8w34Zf5
 hsbbU4eD0qz3Id1dzYCVfydPWZyUpjQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-BRCW5TZNMjiBMyvtgjP6Ww-1; Thu, 30 Apr 2020 10:52:22 -0400
X-MC-Unique: BRCW5TZNMjiBMyvtgjP6Ww-1
Received: by mail-wm1-f69.google.com with SMTP id v185so707460wmg.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 07:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lguS3B+1Xp6z4TVRM+cX5S5HOKiD2Bynn0PAytVJqAM=;
 b=L4em1zeN53fvwmH85RF0D/I9lA3NmDTPn0j4nzV+/uZAj06a03BHCkyqIJxS9H/l5a
 ge8x2kNUAb/L7HBEkp/F1wSbejcW1mJO6dIzo9eqYFvcKZ1vArvBndvCDe57b0ZiwtGq
 fveK6/Z5DdDS88uBxOsjhI6CeW+dL94NknAq29CmKPnZXN8jNP8Qqc5YErpkNLNmZ1sL
 32fQJBkAuKvD5vvRGSFboSIaSh+91BxCQkNOmk9S8qO2LbOmPyRMgz5u9t8qWz8Y//Gw
 5is7rb0V06H80C+2Rv06/dxlm/TS7Bvsd5w+S9qF8C5Tl5026C2w02xj182EU45x/5Tc
 CCQw==
X-Gm-Message-State: AGi0PuZc2tBVYuvAhMa+/Uo9I6H/kNUnvBz9qJj9pF+Uf/ZVR6oavAuD
 fZrYewtNb4N1vOpW5c7DLZpw8e8upu6BdyhKAYoWoHkECnvFbCAkhKrB8Oo6GbRIAlKROxQbTVI
 pL1VF3I4cHNBdGKU=
X-Received: by 2002:a1c:9816:: with SMTP id a22mr3264181wme.125.1588258341226; 
 Thu, 30 Apr 2020 07:52:21 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ88o2aGHw/gjBZIIMi9fzuVdgEZIjWPqS0DTl+ujKSf8VbMovDEkwvcI/cvgtl7/j+3oGbvg==
X-Received: by 2002:a1c:9816:: with SMTP id a22mr3264162wme.125.1588258340959; 
 Thu, 30 Apr 2020 07:52:20 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id i17sm4334372wru.39.2020.04.30.07.52.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 07:52:20 -0700 (PDT)
Subject: Re: [PULL 27/31] target/arm/cpu: Update coding style to make
 checkpatch.pl happy
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200430115142.13430-1-peter.maydell@linaro.org>
 <20200430115142.13430-28-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <505734a4-8940-6f38-d2b0-7fe4e46aa34c@redhat.com>
Date: Thu, 30 Apr 2020 16:52:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200430115142.13430-28-peter.maydell@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:24:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 1:51 PM, Peter Maydell wrote:
> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> We will move this code in the next commit. Clean it up
> first to avoid checkpatch.pl errors.

Oops this isn't the next commit anymore :S

>=20
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Message-id: 20200423073358.27155-5-philmd@redhat.com
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/cpu.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 30e961f7754..a1e38b38ba1 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -582,7 +582,8 @@ static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, =
int interrupt_request)
>       CPUARMState *env =3D &cpu->env;
>       bool ret =3D false;
>  =20
> -    /* ARMv7-M interrupt masking works differently than -A or -R.
> +    /*
> +     * ARMv7-M interrupt masking works differently than -A or -R.
>        * There is no FIQ/IRQ distinction. Instead of I and F bits
>        * masking FIQ and IRQ interrupts, an exception is taken only
>        * if it is higher priority than the current execution priority
> @@ -1912,7 +1913,8 @@ static void arm1026_initfn(Object *obj)
>   static void arm1136_r2_initfn(Object *obj)
>   {
>       ARMCPU *cpu =3D ARM_CPU(obj);
> -    /* What qemu calls "arm1136_r2" is actually the 1136 r0p2, ie an
> +    /*
> +     * What qemu calls "arm1136_r2" is actually the 1136 r0p2, ie an
>        * older core than plain "arm1136". In particular this does not
>        * have the v6K features.
>        * These ID register values are correct for 1136 but may be wrong
> @@ -2698,7 +2700,8 @@ static const ARMCPUInfo arm_cpus[] =3D {
>       { .name =3D "arm926",      .initfn =3D arm926_initfn },
>       { .name =3D "arm946",      .initfn =3D arm946_initfn },
>       { .name =3D "arm1026",     .initfn =3D arm1026_initfn },
> -    /* What QEMU calls "arm1136-r2" is actually the 1136 r0p2, i.e. an
> +    /*
> +     * What QEMU calls "arm1136-r2" is actually the 1136 r0p2, i.e. an
>        * older core than plain "arm1136". In particular this does not
>        * have the v6K features.
>        */
>=20


