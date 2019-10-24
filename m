Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE554CA9EBC
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5E6B2084C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E6B2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNdNv-0001Qi-RP
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 09:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iNbqj-0002a4-Fp
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:04:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iNbqh-0008Di-AW
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:04:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33640)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iNbqh-0008DW-2g
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:04:15 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E0D9EC049D5F
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 12:04:13 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id i23so902261wmb.3
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 05:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2H0hJE2AWAcr3cxAOYtlyALKH2Ibc22ygGo+3pTrHGg=;
 b=AUtV6yCN2pnIJS/tuYmGC0ljfy7agUn4vc+4iVsBznvz1/Gn4rUhUN8fK0TKjYrf2S
 3qSMSBshKw46XYZqpNq9F8+eQReLXg4kytdF8Sn0s4q9u2ycy/uJ4zCO4bLxAwHYxbzg
 KuM3dG2LzU6pgL+U5KRZiyCeqWIEAZ9RlC+5dIFDf8gSoJ4zJMsw4t4cRIiAnuUtuqdW
 d1nJs8j9h1K2ibZxeAVavJEij2mMvpeDtrb+gCvteVG9fGTWcTyd0PyX4/PBcSi89vgd
 u9acNrVqsYrrQ4NL7crgD6WcDcdgn6ZRXXz0XVFsE1tkB/K9T7QgblDUfjDpsENrbInn
 5umQ==
X-Gm-Message-State: APjAAAX5XpMGPKT1E3u7sl1urFculRYQKjtPXnvXHtcA2O+n4fbygMcz
 Fy4+Ny7NiAwBaButCeMjU65nPGBTaDyO7e2RIJA3plA5bmRGc8iRhaMk3phpTzKqhvko64ZbAxl
 ZQMMvn8usxGpuklI=
X-Received: by 2002:a5d:4589:: with SMTP id p9mr1245121wrq.397.1571918652445; 
 Thu, 24 Oct 2019 05:04:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxEdfH7pM6CgVFXCDx/dYbtmimQaV4JOcagqth7WZ27/Uh8TapblvjX2s4xKFii7PoOIvin4g==
X-Received: by 2002:a5d:4589:: with SMTP id p9mr1245089wrq.397.1571918652121; 
 Thu, 24 Oct 2019 05:04:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:6887:47f9:72a7:24e6?
 ([2001:b07:6468:f312:6887:47f9:72a7:24e6])
 by smtp.gmail.com with ESMTPSA id c189sm3154627wme.24.2019.10.24.05.04.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2019 05:04:11 -0700 (PDT)
Subject: Re: [PATCH v2 1/7] cpu: use ROUND_UP() to define xxx_PAGE_ALIGN
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191023154505.30521-1-richard.henderson@linaro.org>
 <20191023154505.30521-2-richard.henderson@linaro.org>
 <55b477b7-877e-954f-2175-ed36fa787600@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e41a98e4-189a-1e0f-7b29-51a6e00e4d7e@redhat.com>
Date: Thu, 24 Oct 2019 14:04:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <55b477b7-877e-954f-2175-ed36fa787600@redhat.com>
Content-Type: text/plain; charset=utf-8
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
Cc: alex.bennee@linaro.org, Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/10/19 13:52, Philippe Mathieu-Daud=C3=A9 wrote:
>> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
>> index ad9ab85eb3..255bb186ac 100644
>> --- a/include/exec/cpu-all.h
>> +++ b/include/exec/cpu-all.h
>> @@ -220,7 +220,7 @@ extern int target_page_bits;
>> =C2=A0 =C2=A0 #define TARGET_PAGE_SIZE (1 << TARGET_PAGE_BITS)
>> =C2=A0 #define TARGET_PAGE_MASK ~(TARGET_PAGE_SIZE - 1)
>> -#define TARGET_PAGE_ALIGN(addr) (((addr) + TARGET_PAGE_SIZE - 1) &
>> TARGET_PAGE_MASK)
>> +#define TARGET_PAGE_ALIGN(addr) ROUND_UP((addr), TARGET_PAGE_SIZE)
>> =C2=A0 =C2=A0 /* Using intptr_t ensures that qemu_*_page_mask is sign-=
extended even
>> =C2=A0=C2=A0 * when intptr_t is 32-bit and we are aligning a long long=
.
>> @@ -228,9 +228,8 @@ extern int target_page_bits;
>> =C2=A0 extern uintptr_t qemu_host_page_size;
>> =C2=A0 extern intptr_t qemu_host_page_mask;
>> =C2=A0 -#define HOST_PAGE_ALIGN(addr) (((addr) + qemu_host_page_size -=
 1) &
>> qemu_host_page_mask)
>> -#define REAL_HOST_PAGE_ALIGN(addr) (((addr) +
>> qemu_real_host_page_size - 1) & \
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_r=
eal_host_page_mask)
>> +#define HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_host_page_size)
>> +#define REAL_HOST_PAGE_ALIGN(addr) ROUND_UP((addr),
>> qemu_real_host_page_size)
>> =C2=A0 =C2=A0 /* same as PROT_xxx */
>> =C2=A0 #define PAGE_READ=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0001
>>

Isn't this the patch where Richard pointed out that the compiler
generates worse code?

Paolo

