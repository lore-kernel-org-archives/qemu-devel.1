Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAA1C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 09:04:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E843A206C0
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 09:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E843A206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGJVy-00083B-3J
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 05:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47446)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iGJUj-0007Ce-S1
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iGJUi-0006UX-5a
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:03:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:27608)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iGJUh-0006Sp-U6
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:03:24 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 62F7E2DD43
 for <qemu-devel@nongnu.org>; Fri,  4 Oct 2019 09:03:22 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id q9so2349806wmj.9
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 02:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EgngIwUdlF/5z4jda19LlxMofYsnbCFBZzY90ABk4Dc=;
 b=CKIzA9jOEYtJT1Fc3ocP3Fdv/+qiTJz4h82yy5Lj3LmYVgRrNow1yH2sJqtA187GeB
 NgE2HiMWJ+LORuAOufgTfKI+9nkzXcJyTHn8vbAnreMjRkixNixN+XZX7tjpkmLGc5ix
 ZCBbQwbzkEiCmcfVhRwzA28iTpwgkze702dAEIOcpfgfExo8g4uvXj8a/+YnjT1eUbza
 ks1IQRQY7HzwGL6+4+jidIVsW7FJlHqA8Tj4FSjj4Kwqnc3XiyQNL70jErJMUFQS+oW7
 yWpMPREYlLNvdVLDl96DXsd1+3E5T5/gqvlVP4Q5GN3CpTt9H+JK0dHupuwmLYyWjgEU
 j9Ig==
X-Gm-Message-State: APjAAAXzS1bN4bl/4qYZF3tp+6StdYqQwAF1UPUU4+OgCnFA9DZBG08m
 IDkOEtu/W02MaAbgKFHUw2hIFRNGkbIiTAahTraO5RT0SCIL5hkSBH+n/bjZkg9uuzRix27TZWB
 xXf6+MTT8TNXYdnk=
X-Received: by 2002:adf:9cc9:: with SMTP id h9mr5980113wre.236.1570179801156; 
 Fri, 04 Oct 2019 02:03:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxUJDcjdwgyVmlF1jzYuIfJGs1FUsIeQt0E/z3hvKBkEEUGjK70VtLzQ/kpiAuZ1ccxZ6JW6g==
X-Received: by 2002:adf:9cc9:: with SMTP id h9mr5980068wre.236.1570179800466; 
 Fri, 04 Oct 2019 02:03:20 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id r65sm3856896wmr.9.2019.10.04.02.03.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2019 02:03:19 -0700 (PDT)
Subject: Re: [PATCH 7/7] tests/fw_cfg: Run the tests on big-endian targets
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20191003225437.16651-1-philmd@redhat.com>
 <20191003225437.16651-8-philmd@redhat.com>
 <1932cc2e-830c-e542-817d-a6e5ef750c6c@redhat.com>
 <3e5e4211-2872-3908-6654-83a5e7f16d72@redhat.com>
 <47c718d9-5412-5da6-3c87-0da450046344@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b8bf0447-409b-3ea5-0e07-2c37f2e007f9@redhat.com>
Date: Fri, 4 Oct 2019 11:03:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <47c718d9-5412-5da6-3c87-0da450046344@redhat.com>
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

On 10/4/19 10:59 AM, Laurent Vivier wrote:
> On 04/10/2019 10:53, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 10/4/19 10:05 AM, Laurent Vivier wrote:
>>> On 04/10/2019 00:54, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> We have been restricting our fw_cfg tests to the PC machine,
>>>> which is a little-endian architecture.
>>>> The fw_cfg device is also used on the SPARC and PowerPC
>>>> architectures, which can run in big-endian configuration.
>>>>
>>>> Since we want to be sure our device does not regress
>>>> regardless the endianess used, enable this test one
>>>> these targets.
>>>>
>>>> The NUMA selector is X86 specific, restrict it to this arch.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>> ---
>>>>  =C2=A0 tests/Makefile.include |=C2=A0 2 ++
>>>>  =C2=A0 tests/fw_cfg-test.c=C2=A0=C2=A0=C2=A0 | 18 +++++++++++++++--=
-
>>>>  =C2=A0 2 files changed, 17 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>>>> index 3543451ed3..322bdb36ff 100644
>>>> --- a/tests/Makefile.include
>>>> +++ b/tests/Makefile.include
>>>> @@ -242,6 +242,7 @@ check-qtest-ppc64-$(CONFIG_VGA) +=3D
>>>> tests/display-vga-test$(EXESUF)
>>>>  =C2=A0 check-qtest-ppc64-y +=3D tests/numa-test$(EXESUF)
>>>>  =C2=A0 check-qtest-ppc64-$(CONFIG_IVSHMEM_DEVICE) +=3D
>>>> tests/ivshmem-test$(EXESUF)
>>>>  =C2=A0 check-qtest-ppc64-y +=3D tests/cpu-plug-test$(EXESUF)
>>>> +check-qtest-ppc64-y +=3D tests/fw_cfg-test$(EXESUF)
>>>
>>> Perhaps only a detail, but ppc64 (pseries) doesn't use fw_cfg, but pp=
c
>>> (mac99, g3beige and prep) does, so perhaps you should rather add the
>>> test to check-qtest-ppc-y (and it will be inherited by ppc64)?
>>
>> The test only runs the mac99 machine.
>>
>> What happens when running "qemu-system-ppc64 -M mac99"? Does it runs i=
n
>> 64-bit?
>=20
> Yes, it's way used to emulate a ppc64 powermac (G5)

Oh.

> $ qemu-system-ppc64 -M mac99 -serial tdio
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> OpenBIOS 1.1 [Feb 2 2019 05:05]
>>> Configuration device id QEMU version 1 machine id 3
>>> CPUs: 1
>>> Memory: 128M
>>> UUID: 00000000-0000-0000-0000-000000000000
>>> CPU type PowerPC,970FX

So this would test the 64-bit/big-endian,

> $ qemu-system-ppc -M mac99 -serial stdio
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> OpenBIOS 1.1 [Feb 2 2019 05:05]
>>> Configuration device id QEMU version 1 machine id 1
>>> CPUs: 1
>>> Memory: 128M
>>> UUID: 00000000-0000-0000-0000-000000000000
>>> CPU type PowerPC,G4

and this the 32-bit/big-endian device, is that correct?

