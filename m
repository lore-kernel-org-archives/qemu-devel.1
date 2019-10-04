Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5912C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 09:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8D0720867
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 09:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D0720867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGJl0-0006wh-Ud
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 05:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49341)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iGJjj-00067p-CB
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:18:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iGJjf-0001J3-Ce
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:18:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36408)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iGJjd-0001Hd-K3
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:18:51 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E9EB759451
 for <qemu-devel@nongnu.org>; Fri,  4 Oct 2019 09:18:46 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id n18so2421461wro.11
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 02:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YE1Cxv13VJE87LgilgCuOwNBITCUggYFwQBAkqeTvEQ=;
 b=GSnhl/RpnjqOGpuRSRmxgu6NtDyZhzOVdH0Bq1kZYc6r8SQA8tkUMsfYSfkTwAiSCO
 8sydpWpqJlf3013PdA7x04f/LiP4EHpRCX1jNkE1NRnsfCWTpeVvVeaM0EeRSScxUsoY
 RYHgY1110fbt20t+FKsfiuHBPL02tv8qx7loavSocqYioN6CEBLEjLl+Fd7yACGfdZdq
 IX+XDvHq2x20og8g0XU4Ak28xUlQ9pVuJ8BEBxH3VZyiJSaEsdTBj1+Bi/nCqoFqkP7R
 P/VfX5Xa2h9GYrwVh5iYEfy2rWfEVuWCpE30dctwRnYfET/ytvnEKtwz7puWHgHjIbW+
 CCdA==
X-Gm-Message-State: APjAAAWJTQU3Uk0llbgYjefcdMbP2XyMLp0HQAgkSF1Z1VZURis1YOSv
 oArq5VV9oh0/zkKcWXm5GUDLZMtB+jQjrxHGzA6qpo+wVXAOBRD2bdNyrrOeq6AKpeZPl+3/2LU
 qeI84XlddLr6VFJ8=
X-Received: by 2002:adf:8163:: with SMTP id 90mr6695558wrm.129.1570180725620; 
 Fri, 04 Oct 2019 02:18:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx92kmpmvaxbBruUDOcXxdBO4yi+lgWJzwNL7XuR33NpDM9YgGy/9cRMw5DniKCbOSgM+sPRQ==
X-Received: by 2002:adf:8163:: with SMTP id 90mr6695547wrm.129.1570180725397; 
 Fri, 04 Oct 2019 02:18:45 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id b22sm5024855wmj.36.2019.10.04.02.18.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2019 02:18:44 -0700 (PDT)
Subject: Re: [PATCH 7/7] tests/fw_cfg: Run the tests on big-endian targets
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20191003225437.16651-1-philmd@redhat.com>
 <20191003225437.16651-8-philmd@redhat.com>
 <1932cc2e-830c-e542-817d-a6e5ef750c6c@redhat.com>
 <3e5e4211-2872-3908-6654-83a5e7f16d72@redhat.com>
 <47c718d9-5412-5da6-3c87-0da450046344@redhat.com>
 <b8bf0447-409b-3ea5-0e07-2c37f2e007f9@redhat.com>
 <aee2b90e-3199-2395-96d1-764d3bc20a71@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6ab54dd5-a781-9f6d-bdae-34c50e91a112@redhat.com>
Date: Fri, 4 Oct 2019 11:18:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <aee2b90e-3199-2395-96d1-764d3bc20a71@redhat.com>
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
Cc: Thomas Huth <thuth@redhat.com>, Li Qiang <liq3ea@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/4/19 11:14 AM, Laurent Vivier wrote:
> On 04/10/2019 11:03, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 10/4/19 10:59 AM, Laurent Vivier wrote:
>>> On 04/10/2019 10:53, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> On 10/4/19 10:05 AM, Laurent Vivier wrote:
>>>>> On 04/10/2019 00:54, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>>> We have been restricting our fw_cfg tests to the PC machine,
>>>>>> which is a little-endian architecture.
>>>>>> The fw_cfg device is also used on the SPARC and PowerPC
>>>>>> architectures, which can run in big-endian configuration.
>>>>>>
>>>>>> Since we want to be sure our device does not regress
>>>>>> regardless the endianess used, enable this test one
>>>>>> these targets.
>>>>>>
>>>>>> The NUMA selector is X86 specific, restrict it to this arch.
>>>>>>
>>>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>>>> ---
>>>>>>  =C2=A0=C2=A0 tests/Makefile.include |=C2=A0 2 ++
>>>>>>  =C2=A0=C2=A0 tests/fw_cfg-test.c=C2=A0=C2=A0=C2=A0 | 18 +++++++++=
++++++---
>>>>>>  =C2=A0=C2=A0 2 files changed, 17 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>>>>>> index 3543451ed3..322bdb36ff 100644
>>>>>> --- a/tests/Makefile.include
>>>>>> +++ b/tests/Makefile.include
>>>>>> @@ -242,6 +242,7 @@ check-qtest-ppc64-$(CONFIG_VGA) +=3D
>>>>>> tests/display-vga-test$(EXESUF)
>>>>>>  =C2=A0=C2=A0 check-qtest-ppc64-y +=3D tests/numa-test$(EXESUF)
>>>>>>  =C2=A0=C2=A0 check-qtest-ppc64-$(CONFIG_IVSHMEM_DEVICE) +=3D
>>>>>> tests/ivshmem-test$(EXESUF)
>>>>>>  =C2=A0=C2=A0 check-qtest-ppc64-y +=3D tests/cpu-plug-test$(EXESUF=
)
>>>>>> +check-qtest-ppc64-y +=3D tests/fw_cfg-test$(EXESUF)
>>>>>
>>>>> Perhaps only a detail, but ppc64 (pseries) doesn't use fw_cfg, but =
ppc
>>>>> (mac99, g3beige and prep) does, so perhaps you should rather add th=
e
>>>>> test to check-qtest-ppc-y (and it will be inherited by ppc64)?
>>>>
>>>> The test only runs the mac99 machine.
>>>>
>>>> What happens when running "qemu-system-ppc64 -M mac99"? Does it runs=
 in
>>>> 64-bit?
>>>
>>> Yes, it's way used to emulate a ppc64 powermac (G5)
>>
>> Oh.
>>
>>> $ qemu-system-ppc64 -M mac99 -serial tdio
>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>> OpenBIOS 1.1 [Feb 2 2019 05:05]
>>>>> Configuration device id QEMU version 1 machine id 3
>>>>> CPUs: 1
>>>>> Memory: 128M
>>>>> UUID: 00000000-0000-0000-0000-000000000000
>>>>> CPU type PowerPC,970FX
>>
>> So this would test the 64-bit/big-endian,
>>
>>> $ qemu-system-ppc -M mac99 -serial stdio
>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>> OpenBIOS 1.1 [Feb 2 2019 05:05]
>>>>> Configuration device id QEMU version 1 machine id 1
>>>>> CPUs: 1
>>>>> Memory: 128M
>>>>> UUID: 00000000-0000-0000-0000-000000000000
>>>>> CPU type PowerPC,G4
>>
>> and this the 32-bit/big-endian device, is that correct?
>=20
> Yes.
>=20
> Note: G4 (ppc) can be either little or big endian, but 970FX, aka G5,
> (ppc64) is only big-endian.

OK thanks! I'll update the tests and add few comments.

Regards,

Phil.

