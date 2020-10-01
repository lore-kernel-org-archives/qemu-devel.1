Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5910DC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:56:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D56A621707
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HvLuVJGA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D56A621707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2on-0007Ks-Oy
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kO2dd-0002DT-I9
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:45:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38742)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kO2db-0006Rg-3B
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601574301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=r+CNUKqIZO7ilhvkpa8/nGmgT3DVBTDK+1XJsMnKk8I=;
 b=HvLuVJGAziyZPhY6NQsoUw3Hl6SGR4QnRrFSyRvBWm2sKkgjnf+dnwFExtgSYz7XD2z51m
 BTBL/qUZsFNGEow8k7cx2HG8DMMlia3m4o8yVFbHP3ppHTN1tr8Xb82WbA7iSdVlQwDxaV
 nZx6iG4hA10FAzTkjXjQVfRWUO+lelM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-eMHQ8MnAPrKgKp8D9NvU0A-1; Thu, 01 Oct 2020 13:45:00 -0400
X-MC-Unique: eMHQ8MnAPrKgKp8D9NvU0A-1
Received: by mail-wm1-f71.google.com with SMTP id u5so1436815wme.3
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 10:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=r+CNUKqIZO7ilhvkpa8/nGmgT3DVBTDK+1XJsMnKk8I=;
 b=eg6v1EqzId+oBGuTsB8iYQUk+O+Lrw+3SzuHYi5q8qUNr/7/F3EYN68I5iV9lJrd+4
 F5qjm1aj8/8JH9IEw3dX8LZWI9/JvKDU3R2YXbWb9koE6BeScuu0712CrbM3PGrvJCyh
 Kfl5LNsQ6qMRkgQzkXm+Q9tT7Y04GpNp2qdw81iZQAJYA0A7xuxoldcCwkuAp3HOblrU
 b4Hk/khCJTBZdkcrL6eEpL3hvOmNASIuGbMT0BOmBxFEKdWG3ToznH1Js2jvue9ktIHt
 4xcOmZ8RCs1njjLhffEwESP6kzE/k8eIwqC0PD+c3otQVxeBgc/m2KMWpm7RqvSMd1X6
 AHXA==
X-Gm-Message-State: AOAM531AB9OilatsPVECF5Lcji6Ab9CiZvlhQ1L3I8LX1sTkQA/+DrOY
 LjDelYwF/AlRB48rAPRxaFMlcAdLpry9+wVPbEr1HDttz28xcqRX/S1PJ5rGdR/KRFeNT29p4rE
 tlohVk8fzmCiNxzk=
X-Received: by 2002:a1c:480a:: with SMTP id v10mr1081535wma.141.1601574298980; 
 Thu, 01 Oct 2020 10:44:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBoMKa+9sqLPPAbzQIDtzYTZsoPpbKEStIkX7GHfHAGPyOTjGlVYhc/86fa429gy5cfOYTnA==
X-Received: by 2002:a1c:480a:: with SMTP id v10mr1081521wma.141.1601574298783; 
 Thu, 01 Oct 2020 10:44:58 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id d18sm9962604wrm.10.2020.10.01.10.44.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 10:44:58 -0700 (PDT)
Subject: Re: [PATCH] hw/core/cpu: Add missing 'exec/cpu-common.h' include
To: qemu-devel@nongnu.org
References: <20200908123433.105706-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <ff99f676-2e6d-2f23-5a09-96cc77fb8469@redhat.com>
Date: Thu, 1 Oct 2020 19:44:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200908123433.105706-1-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 04:25:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.26, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping?

On 9/8/20 2:34 PM, Philippe Mathieu-Daudé wrote:
> cpu_common_reset() uses tcg_flush_softmmu_tlb() which is
> declared in "exec/cpu-common.h". Add the missing header
> to avoid when refactoring other headers:
> 
>   hw/core/cpu.c: In function ‘cpu_common_reset’:
>   hw/core/cpu.c:273:9: error: implicit declaration of function ‘tcg_flush_softmmu_tlb’ [-Werror=implicit-function-declaration]
>     273 |         tcg_flush_softmmu_tlb(cpu);
>         |         ^~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/core/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/core/cpu.c b/hw/core/cpu.c
> index 22bc3f974a2..63ece3662d6 100644
> --- a/hw/core/cpu.c
> +++ b/hw/core/cpu.c
> @@ -26,6 +26,7 @@
>  #include "qemu/log.h"
>  #include "qemu/main-loop.h"
>  #include "exec/log.h"
> +#include "exec/cpu-common.h"
>  #include "qemu/error-report.h"
>  #include "qemu/qemu-print.h"
>  #include "sysemu/tcg.h"
> 


