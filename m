Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A00C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 16:14:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 209B5221F1
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 16:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QCEVCmfm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 209B5221F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQYYz-0006Uj-0e
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 12:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQYXr-0005ra-J1
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 12:13:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22354)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQYXp-0006HJ-Ap
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 12:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602173607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=b3ZZavo/vuLkL4sZ0uS03XFXv/WyDWw/BLCmoV+Kxig=;
 b=QCEVCmfm6xIMOjNLluq5+MnlwrF1w9wQUer30UEOetbZsPaVg/p1K4dQG7Br+IX8wLdHi2
 cOa9pooOVKpWosOIpI2h14vWwxB1dRubFtd1buWLineexB1UKEx9aWe3gV+nR+Hj3wn82H
 Dyz1J447I8qn1laX6yXpLpjCvt3yniM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-xm-cUkneOzahiRpHhP0OIw-1; Thu, 08 Oct 2020 12:13:26 -0400
X-MC-Unique: xm-cUkneOzahiRpHhP0OIw-1
Received: by mail-wm1-f69.google.com with SMTP id g125so3334196wme.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 09:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=b3ZZavo/vuLkL4sZ0uS03XFXv/WyDWw/BLCmoV+Kxig=;
 b=FBwonINogrAnEx4nMFkBtn64gqT015xbD4wrzZ/FjYNPtt6LbIRB4CrSbp9OvtmnMx
 BcLhX7iN3yZbSICtMd3mcPDsmh+EjaMeOQOV2YR8YQ5Xk1CPcs4QSl5ThYOxVl/OPwq3
 gUVACkGjgiOVdpigyYaWFH6Mj4n7rC4rjGpepvYAFNwXArjitZApIFq02n7R4Bxj+/Cj
 uttKNe8PpBxuJc19Pr5sp6QKJ20STeKDTzja3gfp14Edx1QIrGAbel0QSbm+T12yNvFZ
 4BfdNUSUPb8Q4PGWSmbRLMc+fLSoHdDbmuLJtPRYGIoeDohlGADdxOV9fbNCKMDVVlRP
 enMA==
X-Gm-Message-State: AOAM531cFTx+9dw3Ss7QFLVJ/GoujSDp2kOM9SXb1tYM7KeHNDd3UPec
 TBKW2Eg7DWoYH+nPw6CS3aY10tOk3qBEisiNBweTQJhIfZKxQAkIRVr1jrpcLtEmLmyyzxW7lIg
 jJnEq8mdurUhPTK8=
X-Received: by 2002:adf:f7ca:: with SMTP id a10mr10075014wrq.321.1602173604673; 
 Thu, 08 Oct 2020 09:13:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMBWe39SHWC3xGT6rDoALj4nLpeMO3CYVQAVZe0elmTp1D50kx9nlyBFHIRqR6zhFt0lAveQ==
X-Received: by 2002:adf:f7ca:: with SMTP id a10mr10074989wrq.321.1602173604481; 
 Thu, 08 Oct 2020 09:13:24 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id z191sm7601842wme.40.2020.10.08.09.13.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 09:13:23 -0700 (PDT)
Subject: Re: [PATCH v2] hw/arm: Restrict APEI tables generation to the 'virt'
 machine
To: Peter Maydell <peter.maydell@linaro.org>
References: <20201001162207.1566127-1-philmd@redhat.com>
 <CAFEAcA-EH3=Bg4zdu5=Y2MKOYA4Rdpzj+QCU=48yKHQdB5FXcw@mail.gmail.com>
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
Message-ID: <05f7c812-b3cf-7b73-37b2-7164b5ceb527@redhat.com>
Date: Thu, 8 Oct 2020 18:13:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-EH3=Bg4zdu5=Y2MKOYA4Rdpzj+QCU=48yKHQdB5FXcw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 01:56:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Dongjiu Geng <gengdongjiu@huawei.com>,
 Xiang Zheng <zhengxiang9@huawei.com>, qemu-arm <qemu-arm@nongnu.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/20 12:50 PM, Peter Maydell wrote:
> On Thu, 1 Oct 2020 at 17:22, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> While APEI is a generic ACPI feature (usable by X86 and ARM64), only
>> the 'virt' machine uses it, by enabling the RAS Virtualization. See
>> commit 2afa8c8519: "hw/arm/virt: Introduce a RAS machine option").
>>
>> Restrict the APEI tables generation code to the single user: the virt
>> machine. If another machine wants to use it, it simply has to 'select
>> ACPI_APEI' in its Kconfig.
>>
>> Fixes: aa16508f1d ("ACPI: Build related register address fields via hardware error fw_cfg blob")
>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>> Reviewed-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>> v2: Reworded
>>
>> Cc: Laszlo Ersek <lersek@redhat.com>
>> Cc: Xiang Zheng <zhengxiang9@huawei.com>
>> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> ---
>>  default-configs/arm-softmmu.mak | 1 -
>>  hw/arm/Kconfig                  | 1 +
>>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> I assume this needs a respin now Paolo's reworking of
> default-configs/ has gone into master.

Ah indeed. The diff is simply:

-default-configs/arm-softmmu.mak
+default-configs/devices/arm-softmmu.mak

I'll send a v3, thanks for updating me.

> 
> thanks
> -- PMM
> 


