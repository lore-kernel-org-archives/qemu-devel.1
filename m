Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DB1C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 13:37:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B55420673
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 13:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B55420673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHpgC-00078e-FC
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 09:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43102)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iHpeW-00063R-CD
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:35:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iHpeV-00050k-5O
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:35:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32984)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iHpeU-0004zG-CA
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:35:46 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 679323C93A
 for <qemu-devel@nongnu.org>; Tue,  8 Oct 2019 13:35:45 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id w2so9200641wrn.4
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 06:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7CexR3r5XVClsNGjvKFrto1Ub1YeHHVjSKauiuUoiM0=;
 b=qRkIyJipG3aUrRi1dr3YclcM+b/Q8yew1xzSi0rgsddm8xPHgwdLfl1YMg7ZQN1dts
 mCELe+JV1RQ9ysztUnc8cQosnmHyURLgo+TZULHA0NWr4gsw8NdArEVkhvh39HiX8nN4
 ZBuU6fUHALXpBNx5QnVZEbpqHidcrzeQEHvP7bYzbSOqNoyyT1QUH8rWra/MQ89tOIlt
 okdW0gnf4m1Di4AH6nPIYWadGrYv7D0NvQScaI5m3ahVgQsM9iZywUwggPSgU0lSWKfB
 iE6grDYq2NoWbFeWFTF8cHvw3kC+xn4X2eVUjxCY7OiRMndGNjU5HlT+Wghtwhs6Lp+Y
 jH2g==
X-Gm-Message-State: APjAAAWtUqWf6e9dhbIwg7w6FGowoJVAjRRNogTRH8gSYH+xDj1+Msxp
 9vDqhSKYtYboMLQMH8zcz1Y9L3/9wM2wgff40nDQ0BWEFsX+Gg33HqGZsguMItFjW44NkmOFX+m
 zoPqkbARt9w4SZJE=
X-Received: by 2002:a05:6000:1046:: with SMTP id
 c6mr14267780wrx.189.1570541744244; 
 Tue, 08 Oct 2019 06:35:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwJrtIvZ9/2cGSp6sm34DTy+u4gRJoIyvRO+dtLx43tH4ETlcytP7aD5IQovQ9AOg4dkRm4kA==
X-Received: by 2002:a05:6000:1046:: with SMTP id
 c6mr14267767wrx.189.1570541744075; 
 Tue, 08 Oct 2019 06:35:44 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id f3sm21436881wrq.53.2019.10.08.06.35.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2019 06:35:43 -0700 (PDT)
Subject: Re: [PATCH 2/4] target/i386: remove useless
 enable_compat_apic_id_mode() prototype
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
References: <20191008105259.5378-1-lersek@redhat.com>
 <20191008105259.5378-3-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <dd4198fb-f29e-77b5-f6ce-8fbbfaa146a3@redhat.com>
Date: Tue, 8 Oct 2019 15:35:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191008105259.5378-3-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/19 12:52 PM, Laszlo Ersek wrote:
> The enable_compat_apic_id_mode() function definition was removed earlie=
r;

"in 457cfcccdd1"

> there are no callers left. Remove the function declaration too.
>=20
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Ref: https://bugzilla.tianocore.org/show_bug.cgi?id=3D1515
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>   target/i386/cpu.h | 2 --
>   1 file changed, 2 deletions(-)
>=20
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index eaa5395aa539..c9ab1a367939 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2126,8 +2126,6 @@ void x86_cpu_set_default_version(X86CPUVersion ve=
rsion);
>   /* Return name of 32-bit register, from a R_* constant */
>   const char *get_register_name_32(unsigned int reg);
>  =20
> -void enable_compat_apic_id_mode(void);
> -
>   #define APIC_DEFAULT_ADDRESS 0xfee00000
>   #define APIC_SPACE_SIZE      0x100000
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

