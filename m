Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF8EC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:38:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0EFA2080A
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OPp3Kji1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0EFA2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFiVr-0006T1-5a
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 14:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFiVE-0005vK-0R
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 14:38:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24024)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFiVC-000185-A9
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 14:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599590277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=F5LPtTvck+hhShia0cEhfXeezceDnfaVixrNxAVQRhg=;
 b=OPp3Kji1YxlhHbLGRo2iXVExWV7zO2DqEzq3JVyN94bpS3hbVvSZkLOJjuakFV169Id+pe
 /zg1f7UmE++78czzaxWTtzD4d2VI7tytVu845NvbunZCl45kN0Em1toO5sA4+bSjmRKY3U
 3fRmg4USLfZXAcVHX/p7a5DsGozbQnk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-GtliRqtNNGuOpWl8p4lVGw-1; Tue, 08 Sep 2020 14:37:53 -0400
X-MC-Unique: GtliRqtNNGuOpWl8p4lVGw-1
Received: by mail-wm1-f69.google.com with SMTP id 23so80772wmk.8
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 11:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=F5LPtTvck+hhShia0cEhfXeezceDnfaVixrNxAVQRhg=;
 b=r5AWokHq/THbed/RUAqg2NV+YZ3Yx7iRSiLbOGtiBKFc+EH5k4lvh/wcm6lYlUx3Gf
 +ONWLQPctksGp9XRdZrcFrPSicQPDYkBTKI6vVr48XbSYsnbQcv9UruNXPPThECl3jeH
 cuO4M+NGgumDGM/7iFnYOuoesjaMGqVo+a7qg3GFQXP0cbm8g0ig7Ff87AgWhlgSD0gX
 o1x0ld4JXmLrEeAy8EcJGsqjzaxPDT77uc5HGARizDG8tZU3RL9wur/RM6OoTJp/sXSC
 jf010xD7FJUFu10RJO3zCkQpVYECPhYvaxsMrQYEcej3pMYuiuZ8KO5ebRMzL2vUaxA0
 O2RA==
X-Gm-Message-State: AOAM530SNuBpWg3oMHwLFAxG3H+gLwNDohsojppaSZVAvlouFymyrdxN
 A2LTLR7qPwlRn9T1/Yc/0WcR4s/ApXCx6Hztj1VBBXfhNO+GWlkhlE6oTRmbSNmyjMjjh/eelOZ
 ehV1NK+iJ8ElmXOg=
X-Received: by 2002:adf:f890:: with SMTP id u16mr914860wrp.183.1599590272778; 
 Tue, 08 Sep 2020 11:37:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPW+oSuFyPsaD+GBXbTDSiZlan0tb0x+sfqrQE1xcturnpjMGuOm1Zu8TeHaOswOEVNgmUOg==
X-Received: by 2002:adf:f890:: with SMTP id u16mr914838wrp.183.1599590272502; 
 Tue, 08 Sep 2020 11:37:52 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id g8sm332349wmd.12.2020.09.08.11.37.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2020 11:37:51 -0700 (PDT)
Subject: Re: [PATCH 4/5] hw/smbios: use qapi for SMBIOS entry point type enum
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200908165438.1008942-1-berrange@redhat.com>
 <20200908165438.1008942-5-berrange@redhat.com>
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
Message-ID: <7807ab6f-d76d-7859-6b39-bcd068bfecd7@redhat.com>
Date: Tue, 8 Sep 2020 20:37:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200908165438.1008942-5-berrange@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 12:54:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.626, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/8/20 6:54 PM, Daniel P. Berrangé wrote:
> This refactoring prepares for exposing the SMBIOS entry point type as a
> machine property on x86.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  hw/arm/virt.c                |  2 +-
>  hw/i386/pc_piix.c            |  2 +-
>  hw/i386/pc_q35.c             |  2 +-
>  hw/smbios/smbios.c           |  9 +++++----
>  include/hw/firmware/smbios.h |  9 ++-------
>  qapi/machine.json            | 12 ++++++++++++
>  6 files changed, 22 insertions(+), 14 deletions(-)
> 
[...]

> diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
> index 02a0ced0a0..cb1299ad7a 100644
> --- a/include/hw/firmware/smbios.h
> +++ b/include/hw/firmware/smbios.h
> @@ -1,6 +1,8 @@
>  #ifndef QEMU_SMBIOS_H
>  #define QEMU_SMBIOS_H
>  
> +#include "qapi/qapi-types-machine.h"

Actually to reduce the churn pulled in ...

> +
>  /*
>   * SMBIOS Support
>   *
> @@ -23,13 +25,6 @@ struct smbios_phys_mem_area {
>      uint64_t length;
>  };
>  
> -/*
> - * SMBIOS spec defined tables
> - */
> -typedef enum SmbiosEntryPointType {
> -    SMBIOS_ENTRY_POINT_21,
> -    SMBIOS_ENTRY_POINT_30,
> -} SmbiosEntryPointType;
>  
>  /* SMBIOS Entry Point
>   * There are two types of entry points defined in the SMBIOS specification
> diff --git a/qapi/machine.json b/qapi/machine.json
> index abc6fd0477..a58cf2694f 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -937,3 +937,15 @@
>    'data': 'NumaOptions',
>    'allow-preconfig': true
>  }
> +
> +##
> +# @SmbiosEntryPointType:
> +#
> +# @2_1: SMBIOS version 2.1
> +#
> +# @3_0: SMBIOS version 3.0
> +#
> +# Since: 5.2
> +##
> +{ 'enum': 'SmbiosEntryPointType',
> +  'data': [ '2_1', '3_0' ] }
> 

... this could be a good opportunity to add a new
qapi/firmware-smbios.json (or firmware.json?) and eventually
update docs/interop/firmware.json.


