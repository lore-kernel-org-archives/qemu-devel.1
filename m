Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93E6C2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 07:46:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24BDF2080A
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 07:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYKocx2a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24BDF2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kM4ul-0005OC-Vy
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 03:46:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kM4tf-0004oQ-1Z; Sat, 26 Sep 2020 03:45:32 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40810)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kM4tc-0006rr-Lg; Sat, 26 Sep 2020 03:45:30 -0400
Received: by mail-wm1-x343.google.com with SMTP id k18so1620692wmj.5;
 Sat, 26 Sep 2020 00:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vKwbA81sk6rX6ev5TNqVoLexMwgo/hsrVjOOk5dRqc0=;
 b=QYKocx2aqGoNHioctRznVkgoih1KYnYRryiqTd644dQbbR9W7DmgJJDFs8DYhuVsc7
 5SliTq/ZDE3uc02RozC4LWO5V4cVnBYBPAp1Ov9gNnxEzaCljnxqk99ndHqPSwnyGYqB
 3QUutJ0OCVEVwZmMjecHjYBvne3Kcuegfzku30UwOOgQnE6ebS0uex41QB0KpWcJ6SrW
 FFdlOD0Hi65wvWmDLEK/+5jiw0hL1dAsKsjrbZTX4TzcaC+IK59Vd/lHWdicl30ttEIK
 r5kPpdvaddIz/bXQT55Fwh4g0lMmoVt0tGHYRAkOlm37uaevPImviSonEZz5UeN17OIw
 cLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=vKwbA81sk6rX6ev5TNqVoLexMwgo/hsrVjOOk5dRqc0=;
 b=UPuHz1aPB7WUrd0YkOzSThMVG3pQyoiWM+gG5898yQQXLfwaaHClJn7NnFeUKIuNkE
 w1eKdEcpfvCOHQ93cxf8zKcwPRxtfAmFkLJbbNSx6kawJyI6Sj3K5ncTrcBJUw6A4E0/
 6nCxQMqZKRgyJemw0/ikB5FcDZ2ye6QpdVWiQboSnryBCQ0UXvtInpyIDFhD6JI8H9W0
 2a3b8zwsXljnY9N1fh55uH+AyEwMxxdgLeg5/OaRwxelPM5/tlrwHbf3ifcEI+FCPPTB
 dF7bBycRV99XqTy9gSFkJWKu1vlOLHeXrfTPQVRsb6e/J01MObtXGLwqvLbnIWuvWG7b
 ZmAw==
X-Gm-Message-State: AOAM532XJKEl0+AjHlaXNge+aRTM/mYxGJX3hPpOK6kyrLoxZAaS3+vK
 2dHjJ0AxngAYWtlXS3WLIZI=
X-Google-Smtp-Source: ABdhPJxBn/vU9wh0O4JWOrD5jN+nAlI4yNESOaFKIH3K9bX4spw5OsekAsEoA8jr3By33jJ4vTrxxw==
X-Received: by 2002:a7b:cc82:: with SMTP id p2mr1455412wma.46.1601106326339;
 Sat, 26 Sep 2020 00:45:26 -0700 (PDT)
Received: from [192.168.1.34] (234.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.234])
 by smtp.gmail.com with ESMTPSA id w7sm1649242wmc.43.2020.09.26.00.45.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Sep 2020 00:45:25 -0700 (PDT)
Subject: Re: [PATCH] hw/arm/sbsa-ref : Fix SMMUv3 Initialisation
To: Auger Eric <eric.auger@redhat.com>, Graeme Gregory <graeme@nuviainc.com>, 
 qemu-arm@nongnu.org
References: <20200925133902.28349-1-graeme@nuviainc.com>
 <f67b75fe-c5ce-8b95-e19b-fc4ce2217b31@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
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
Message-ID: <e548848c-75ac-e82e-f40d-7c1ae70a6e02@amsat.org>
Date: Sat, 26 Sep 2020 09:45:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <f67b75fe-c5ce-8b95-e19b-fc4ce2217b31@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248, NICE_REPLY_A=-0.238,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: leif@nuviainc.com, peter.maydell@linaro.org, jamie@nuviainc.com,
 rad@semihalf.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gregory,

On 9/25/20 4:00 PM, Auger Eric wrote:
> Hi Gregory,
> 
> On 9/25/20 3:39 PM, Graeme Gregory wrote:
>> SMMUv3 has an error in previous patch where a i was transposed to a 1
>> meaning interrupts would not have been correctly assigned to the SMMUv3
>> instance.

This is a first issue, fixing 48ba18e6d3f3.

>>
>> The code also contained an error in that the IRQs were never allocated
>> in the irqmap.

This is another issue, not well explained. IIUC IRQs *are* allocated as
IRQ #0, right?

This fixes commit e9fdf453240 ("hw/arm: Add arm SBSA reference machine,
devices part"). Can you split this in another patch please? Eventually
Cc'ing qemu-stable@nongnu.org as suggested by Peter.

>>
>> Fixes: 48ba18e6d3f3 ("hw/arm/sbsa-ref: Simplify by moving the gic in the machine state")
>> Signed-off-by: Graeme Gregory <graeme@nuviainc.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 
> Thanks
> 
> Eric
> 
>> ---
>>  hw/arm/sbsa-ref.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
>> index 257ada9425..9109fb58be 100644
>> --- a/hw/arm/sbsa-ref.c
>> +++ b/hw/arm/sbsa-ref.c
>> @@ -138,6 +138,7 @@ static const int sbsa_ref_irqmap[] = {
>>      [SBSA_SECURE_UART_MM] = 9,
>>      [SBSA_AHCI] = 10,
>>      [SBSA_EHCI] = 11,
>> +    [SBSA_SMMU] = 12, /* ... to 15 */
>>  };
>>  
>>  static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
>> @@ -530,7 +531,7 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
>>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
>>      for (i = 0; i < NUM_SMMU_IRQS; i++) {
>>          sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
>> -                           qdev_get_gpio_in(sms->gic, irq + 1));
>> +                           qdev_get_gpio_in(sms->gic, irq + i));

BTW this fix is already in Peter's queue:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg732819.html

Thanks,

Phil.

>>      }
>>  }
>>  
>>
> 


