Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF275C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 10:54:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95EB720578
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 10:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jF5ufFVd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95EB720578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHmdN-0008Vm-Qk
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 06:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jHmch-0007bm-KL
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:54:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jHmcg-0002Ah-G5
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:53:59 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:49754)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jHmcg-0002A1-C5
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585306438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qo6jp2yA2U6ZiQWGnZHDdNXxJGw+5126vQlYbydviCI=;
 b=jF5ufFVd7a5bnAkJgIrK6UY0AY3BDpjzRW7llOePhER85sj7ubGwrXCpvglE6i6WmgbDT2
 WHTFdpuOXzA73hu36TZ6zNIYb/mif7sy4Nsik6HvVj4jaNDPaHl4cGDSm1WVpn+Xfu20pW
 ylmOm9WbdaY/d7gRqHm8AIfeYSWd158=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-KSqtQFe8MJKf7ZjJ26oMPA-1; Fri, 27 Mar 2020 06:53:56 -0400
X-MC-Unique: KSqtQFe8MJKf7ZjJ26oMPA-1
Received: by mail-ed1-f69.google.com with SMTP id f19so8010406edt.5
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 03:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=D5vP/Ql9g12/Vwkt39RNav5tblCv027r0DNSP60wTFU=;
 b=U6J2zOoTbFa1q+Cs/BeeAFNTIU+cqGJmEuOj9O2OhEs02GFhFY4ch40DJH4STyyorO
 7GXD+U7rR0oQA+234xJx20Vig14Z2MLE0SM71lHYohvlDBkrjStkjJC4pIdyC8oaJ19N
 BbLqP2yWCi8adYiyz72rlKADzCskMAZaBJEXHdS8fSRYx8tzqNWZf3pfp1t1wlsFJFtF
 EGOcPCYwikTYcdifKLLT6U7rJ0+4byzaYTS9s13sl1Vp23rJdPRrO2W9BuSAfKp0SrSg
 KhE0NKY9b8CcE0BlesDA2ropoIWONLLFQLpYxHkLxLH7FCCl4jgdIE+A4AK8GqyoPxPr
 aACw==
X-Gm-Message-State: ANhLgQ2mNesnEhdLsMGs76mQEJwbAVKO//Dfu8uuTxvgGR4VNqlp8kRX
 Pa6iRKW726SczcM3AZm6ji41EtdbyKhH84r7xNIRgNygWY25DqllVeK7ofrI2308zYrrGJhZUMP
 8elaRmT9TWCqUkTA=
X-Received: by 2002:a17:906:6b10:: with SMTP id
 q16mr11974821ejr.170.1585306434764; 
 Fri, 27 Mar 2020 03:53:54 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvmIF4QbNWcN6rDShlrZ/d9LKo2tiNi8z5Y5jcf1j3DTWPRprsQuh8XDgjDNpTLvJRNHtY9bg==
X-Received: by 2002:a17:906:6b10:: with SMTP id
 q16mr11974800ejr.170.1585306434432; 
 Fri, 27 Mar 2020 03:53:54 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id n62sm784042edc.74.2020.03.27.03.53.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2020 03:53:53 -0700 (PDT)
Subject: Re: [PATCH v1 1/7] elf-ops: bail out if we have no function symbols
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200327094945.23768-1-alex.bennee@linaro.org>
 <20200327094945.23768-2-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0aa311c7-ae89-6dc2-d1ef-514a75bd0c6e@redhat.com>
Date: Fri, 27 Mar 2020 11:53:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200327094945.23768-2-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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

On 3/27/20 10:49 AM, Alex Benn=C3=A9e wrote:
> It's perfectly possible to have no function symbols in your elf file
> and if we do the undefined behaviour sanitizer rightly complains about
> us passing NULL to qsort. Check nsyms before we go ahead.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   include/hw/elf_ops.h | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
> index a1411bfcab6..b5d4074d1e3 100644
> --- a/include/hw/elf_ops.h
> +++ b/include/hw/elf_ops.h
> @@ -170,8 +170,13 @@ static int glue(load_symbols, SZ)(struct elfhdr *ehd=
r, int fd, int must_swab,
>           }
>           i++;
>       }
> -    syms =3D g_realloc(syms, nsyms * sizeof(*syms));
>  =20
> +    /* check we have symbols left */
> +    if (nsyms =3D=3D 0) {
> +        goto fail;
> +    }
> +
> +    syms =3D g_realloc(syms, nsyms * sizeof(*syms));
>       qsort(syms, nsyms, sizeof(*syms), glue(symcmp, SZ));
>       for (i =3D 0; i < nsyms - 1; i++) {
>           if (syms[i].st_size =3D=3D 0) {
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


