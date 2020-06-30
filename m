Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE15EC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:48:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99F0D206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNLW4EFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99F0D206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqGcZ-0008TY-QX
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 09:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqGZX-0003Cr-Ha
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 09:45:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51725
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqGZU-0007Sl-P9
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 09:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593524711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XBioRPnYuH3HcYzSU8AyBofSNLJtjmhUpWStZTTcbfo=;
 b=WNLW4EFH05WeLk+2dsa0PNTw2xGH1bFWeN3vH602FHSflk6Y35ZZk2Ivufhq9UTvJnvwqX
 d+S7OjB1atGRzfONKmKAnHshx9Dzgt8QdU+Jtz8e0yk5hKrWHBa9ZOBbwu5pOKShWoyP/d
 FNSkzERGqyzqASzXj12cyoNIW+JE/Zo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-gJWFhXWSMhC1cxSPQFL9nQ-1; Tue, 30 Jun 2020 09:45:07 -0400
X-MC-Unique: gJWFhXWSMhC1cxSPQFL9nQ-1
Received: by mail-ej1-f71.google.com with SMTP id l18so5130208ejn.17
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 06:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=XBioRPnYuH3HcYzSU8AyBofSNLJtjmhUpWStZTTcbfo=;
 b=s+UlpnYGaATlUM+NN7kjjvpu2GsB1YUyYT5ftgE/XhJVz5Y6vqIOebZL8P2mNjlLzb
 1L58CjAuBvWx2GYulOi1EAHtSv3q3GQxoHCiXS3DxWlu06ZhZhRvbdkVFgZsn711z4Bm
 Vj+CEjhDP9pJIaLI3lpURefJfn2WovNgpjtXefsHR0hsNdE403G1CPCTlNdv7tBrF0TI
 XnZHkIX/pZpnEaofGzGSltIYzcAzx/DIbTThi2vja79LrE5Ar26H7pSwi08GxYX2v/vy
 Uv0/Ekr6RQGJXBQlh/Dv1GTcf1crL5+9lcR2pTKO/6lu9Xc8gRMDgvAMtsLUVxEWNm7Q
 7EpA==
X-Gm-Message-State: AOAM530VUNlQ5H3jXDeOH1BzQMZNrx3vj0Ws7WccgQ9bPBP/Gs9U0qwK
 WM9rdOjElX/5kbNd39pQjzqRnrdV8xAlOUtfeI0IGEC6EKxlHIAG8VhCMj4pwCk//tzHOBhW5jE
 zjtUiVA4RbQL64Pc=
X-Received: by 2002:a17:906:d8db:: with SMTP id
 re27mr18023401ejb.554.1593524706197; 
 Tue, 30 Jun 2020 06:45:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUQT1X2R/UhlkoeUXofWj2rpSHjgnmmQNBWMJx/XWImvLmjAOgqKaTa40ybolFviJossenhA==
X-Received: by 2002:a17:906:d8db:: with SMTP id
 re27mr18023375ejb.554.1593524705935; 
 Tue, 30 Jun 2020 06:45:05 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id d13sm2903486edv.12.2020.06.30.06.45.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 06:45:05 -0700 (PDT)
Subject: Re: [PATCH 0/7] hw/mips/malta: Rework to allow more than 2GB of RAM
 on 64-bit
To: Thomas Huth <thuth@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <20200630081322.19146-1-f4bug@amsat.org>
 <CAHiYmc6coeBBOvCAs+=Ccw2aXfw0m3gTdSM1Pc8AQvJ4QNBhow@mail.gmail.com>
 <da6c2f55-b8b7-3492-37b3-d24a25106d72@amsat.org>
 <CAAdtpL7MObRjk77ZFsNF4Xoghdj33mwufZ9s3L8fAC3XxkJCqA@mail.gmail.com>
 <CAHiYmc59Ahpii2dvhVD8EPK4qzc8y2RNTwTbp4L1d2Mjun+Phg@mail.gmail.com>
 <3b75d15d-9195-bcd5-87aa-e243547552e5@amsat.org>
 <CAHiYmc4NOrG-ETX_rLGGR=Cac_Q_hNfjAsS3mF6PpAFFjLDHGw@mail.gmail.com>
 <7ef829b6-6492-de7b-d668-550d04228844@redhat.com>
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
Message-ID: <b48dc921-4686-0734-ede7-a6ae26e19bdf@redhat.com>
Date: Tue, 30 Jun 2020 15:45:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <7ef829b6-6492-de7b-d668-550d04228844@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 03:55:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yunqiang Su <ysu@wavecomp.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/30/20 3:36 PM, Thomas Huth wrote:
> On 30/06/2020 13.17, Aleksandar Markovic wrote:
>>
>>
>> уторак, 30. јун 2020., Philippe Mathieu-Daudé <f4bug@amsat.org
>> <mailto:f4bug@amsat.org>> је написао/ла:
>>
>>     On 6/30/20 1:01 PM, Aleksandar Markovic wrote:
>>      >
>>      >
>>      > уторак, 30. јун 2020., Philippe Mathieu-Daudé <f4bug@amsat.org
>>     <mailto:f4bug@amsat.org>
>>      > <mailto:f4bug@amsat.org <mailto:f4bug@amsat.org>>> је написао/ла:
>>      >
>>      >     On Tue, Jun 30, 2020 at 12:52 PM Philippe Mathieu-Daudé
>>      >     <f4bug@amsat.org <mailto:f4bug@amsat.org>
>>     <mailto:f4bug@amsat.org <mailto:f4bug@amsat.org>>> wrote:
>>      >     >
>>      >     > On 6/30/20 12:48 PM, Aleksandar Markovic wrote:
>>      >     > >
>>      >     > >
>>      >     > > уторак, 30. јун 2020., Philippe Mathieu-Daudé
>>     <f4bug@amsat.org <mailto:f4bug@amsat.org>
>>      >     <mailto:f4bug@amsat.org <mailto:f4bug@amsat.org>>
>>      >     > > <mailto:f4bug@amsat.org <mailto:f4bug@amsat.org>
>>     <mailto:f4bug@amsat.org <mailto:f4bug@amsat.org>>>> је написао/ла:
>>      >     > >
>>      >     > >     Hi,
>>      >     > >
>>      >     > >     Following Jiaxun Yang's patch and discussion:
>>      >     > > https://patchwork.kernel.org/patch/11416915/
>>     <https://patchwork.kernel.org/patch/11416915/>
>>      >     <https://patchwork.kernel.org/patch/11416915/
>>     <https://patchwork.kernel.org/patch/11416915/>>
>>      >     > >     <https://patchwork.kernel.org/patch/11416915/
>>     <https://patchwork.kernel.org/patch/11416915/>
>>      >     <https://patchwork.kernel.org/patch/11416915/
>>     <https://patchwork.kernel.org/patch/11416915/>>>
>>      >     > >
>>      >     > >     - Rename the current machine as 'malta-virt' (keeping
>>      >     'malta' aliased)
>>      >     > >       Suggestions for better names are welcome, maybe
>>      >     'malta-unreal' or
>>      >     > >       'malta-unleashed' instead?
>>      >     > >     - Add 'malta-phys' which respects hardware
>>     restrictions (on
>>      >     RAM so far)
>>      >     > >     - Unleash 'malta-virt' to allow more than 2GB on
>> 64-bit
>>      >     > >
>>      >     > >     Philippe Mathieu-Daudé (7):
>>      >     > >       hw/mips/malta: Trivial code movement
>>      >     > >       hw/mips/malta: Register the machine as a TypeInfo
>>      >     > >       hw/mips/malta: Rename 'malta' machine as
>> 'malta-virt'
>>      >     > >       hw/mips/malta: Introduce
>> MaltaMachineClass::max_ramsize
>>      >     > >       hw/mips/malta: Introduce the 'malta-phys' machine
>>      >     > >       hw/mips/malta: Verify malta-phys machine uses
>>     correct DIMM
>>      >     sizes
>>      >     > >       hw/mips/malta: Allow more than 2GB on 64-bit
>> malta-virt
>>      >     > >
>>      >     > >      hw/mips/malta.c | 121
>>      >     +++++++++++++++++++++++++++++++++++++++---------
>>      >     > >      1 file changed, 99 insertions(+), 22 deletions(-)
>>      >     > >
>>      >     > >     --
>>      >     > >
>>      >     > >
>>      >     > >
>>      >     > > Thank you, Philippe, for providing this series.
>>      >     > >
>>      >     > > However, in previous discussion on the patch you mention
>>     above, I
>>      >     > > already expressed serious reservations on the approach
>>     taken in that
>>      >     > > patch. These reservations stay today too.
>>      >     > >
>>      >     > > There is nothing qualitatively different between the
>> original
>>      >     patch and
>>      >     > > this series. Naming and related stuff are just cosmetic
>>     issues.
>>      >     >
>>      >     > OK, what about considering all patches except the last one?
>>      >     > So we can run firmware on a real Malta board, not the QEMU
>>      >     > imaginary one (in the discussion you said QEMU should
>> respect
>>      >     > real hardware, which I agree).
>>      >     >
>>      >     > >
>>      >     > > The good thing about this series is that one can apply it
>>      >     dowstream, if
>>      >     > > one finds it useful. However, it is not suitable for
>>     upstreaming
>>      >
>>      >     IOW, what is missing to have this series (except the last
>> patch)
>>      >     accepted upstream?
>>      >
>>      >
>>      > It is not what is missing, but was already is in the series that
>>     makes
>>      > it not suitable for upstreaming. The very concept of the series is
>>      > problematic.
>>
>>     What is the series is not suitable for upstream? Can you point to
>>     patch and code please? How would you conceptually resolve the
>>     problem?
>>
>>
>> The answer is already in the original thread on the original patch.
>>
>> The problem is artificialy imposed:
>>
>> One needs a feature not present in the physical system. The solution
>> is not in creating "virtual" upgrade - this violates the basic
>> foundation if QEMU.
>>
>> If the feature is missing, the optimal solution would be emulating the
>> physical solution that has that feature.
>>
>> In some rare cases (that should be avoided as mush as possible), and
>> for really good reasons, we can create an emulation of some imagined
>> hardware that was never designed let alone built - there are a couple
>> of examples in other targets.
>>
>> But extending the emulation of existing physical system with
>> non-existing features is not acceptable.
> 
> Interesting statement. I suggest to include the following patch in your
> next mips pull request to avoid that mips users spoil their machines
> with virtual-only features:
> 
> diff a/default-configs/mips-softmmu-common.mak
> b/default-configs/mips-softmmu-common.mak
> --- a/default-configs/mips-softmmu-common.mak
> +++ b/default-configs/mips-softmmu-common.mak
> @@ -6,10 +6,10 @@ CONFIG_SEMIHOSTING=y
>  CONFIG_ISA_BUS=y
>  CONFIG_PCI=y
>  CONFIG_PCI_DEVICES=y
> +CONFIG_VIRTIO_PCI=n
>  CONFIG_VGA_ISA=y
>  CONFIG_VGA_ISA_MM=y
>  CONFIG_VGA_CIRRUS=y
> -CONFIG_VMWARE_VGA=y
>  CONFIG_SERIAL=y
>  CONFIG_SERIAL_ISA=y
>  CONFIG_PARALLEL=y
> 
> ;-)
> 
> No, seriously, as far as I can tell, QEMU was never in that "we strictly
> only emulate real hardware" camp, even the homepage talks about
> "virtualizer".
> 
> But introducing a separate machine for this feature sounds a little bit
> excessive for me, too. What about introducing a machine property for the
> max-ram-size? With the default value, the machine could restrict the ram
> sizes to the values that are possible with the real hardware, and only
> if the (advanced) user tweaks the property, it would be possible to set
> bigger values. Just my 0.02 €.
> 
>  Thomas
> 
> 
> PS: Why does mips use CONFIG_VMWARE_VGA=y at all? Is VMWARE also
> available for mips?
> 
> PPS: Why is mips still not using proper Kconfig settings yet?

Related to "ACPI + ICH9 + PIIX4" interdependence with X86. Fixing MIPS
would break X86. We can not break X86 (and there is little interest from
enterprise X86 on solving MIPS emulation problems).

Then I consumed all the time my manager granted me to work on it, so
it is very low in my list. If someone else want to do it, help welcomed.


