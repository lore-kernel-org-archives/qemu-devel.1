Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F81EC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:08:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 717EC206CD
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 717EC206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIwWm-0000Iw-Hd
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 11:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iIwW3-0007yO-1Q
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:07:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iIwW0-0006wF-3M
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:07:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35930)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iIwVz-0006sB-Rd
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:07:36 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3B85485537
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 15:07:32 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id z205so4236603wmb.7
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 08:07:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/F/7kaqmjovLzG9tMcoTes2VgNgU/HhtyJaXhcqWbWU=;
 b=HT6LsotjTmM1RxBzpVP7Z3zSY7EHs324AU+t2qh3f3QlgYGqZSUZb2Y3AO/V7gKgyY
 svoiYlFs4I7d+NXL/x6BAko8cVjNYKvrLrfg9d7jHlLvh3IHySah2f056GDMtZJNBrkC
 KjBeUKbt0I2wuJADVFsplgltMl3rdlfA35lavThyEIVJr1KAr+DkRKUVjNKSJ1PcxUZG
 /RHdPy9K4riiqvipa28Dhm4fqifM8XCzVzdbqsqmibLPlnLmbNosRIPaZhu8N3CRDzbI
 oR8ABEKUW1D8/mCi5lw1ONWmSpZKgUIVYA+zioziprC9lVbGwMZShmvKVhllgpmanVX3
 ZC0Q==
X-Gm-Message-State: APjAAAXT5q95/lctMmsiLaO3vT/B0cZchCAPuFuEe0TJ/kfXCKey9chP
 3dlmPUsDG34ROngdS74R7nZMKbH77EuLUo/AeE2LK8h3tL1VmYWDSWUC4WUP7cSIhmvRgmX47u/
 t5vWLegF/2nv7jEs=
X-Received: by 2002:adf:e40a:: with SMTP id g10mr4598307wrm.395.1570806450996; 
 Fri, 11 Oct 2019 08:07:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwfTNJJiLAtm7StOapi57x22oe44EPjlLtNyCm+KJyc5X1FoxYhkF8bBsFxm65ou0cz9hZRJw==
X-Received: by 2002:adf:e40a:: with SMTP id g10mr4598281wrm.395.1570806450759; 
 Fri, 11 Oct 2019 08:07:30 -0700 (PDT)
Received: from [192.168.50.31] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id 3sm11321534wmo.22.2019.10.11.08.07.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2019 08:07:30 -0700 (PDT)
Subject: Re: [PATCH v8 04/15] hw/i386/pc: replace use of strtol with
 qemu_strtol in x86_load_linux()
To: Sergio Lopez <slp@redhat.com>
References: <20191010143125.67246-1-slp@redhat.com>
 <20191010143125.67246-5-slp@redhat.com>
 <f147fefc-1bec-2ac1-b5d6-35bcfdddf2fc@redhat.com> <871rvj4uam.fsf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e9033f53-df3a-ac77-ffd2-e50bcf034ca7@redhat.com>
Date: Fri, 11 Oct 2019 17:07:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <871rvj4uam.fsf@redhat.com>
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 kraxel@redhat.com, pbonzini@redhat.com, imammedo@redhat.com,
 sgarzare@redhat.com, lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/11/19 9:26 AM, Sergio Lopez wrote:
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>=20
>> Hi Sergio,
>>
>> On 10/10/19 4:31 PM, Sergio Lopez wrote:
>>> Follow checkpatch.pl recommendation and replace the use of strtol wit=
h
>>> qemu_strtol in x86_load_linux().
>>>
>>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>>> ---
>>>    hw/i386/pc.c | 11 +++++++++--
>>>    1 file changed, 9 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>>> index 77e86bfc3d..e6bcc3ff42 100644
>>> --- a/hw/i386/pc.c
>>> +++ b/hw/i386/pc.c
>>> @@ -68,6 +68,7 @@
>>>    #include "qemu/config-file.h"
>>>    #include "qemu/error-report.h"
>>>    #include "qemu/option.h"
>>> +#include "qemu/cutils.h"
>>>    #include "hw/acpi/acpi.h"
>>>    #include "hw/acpi/cpu_hotplug.h"
>>>    #include "hw/boards.h"
>>> @@ -1201,7 +1202,8 @@ static void x86_load_linux(PCMachineState *pcms=
,
>>>        /* handle vga=3D parameter */
>>>        vmode =3D strstr(kernel_cmdline, "vga=3D");
>>>        if (vmode) {
>>> -        unsigned int video_mode;
>>> +        long video_mode;
>>
>> Why do you change 'video_mode' to a signed type?
>=20
> qemu_strtol fourth argument is a pointer to long int. According to
> "linux/Documentation/admin-guide/svga.rst", valid video modes are in th=
e
> in the range of 0x0 to 0xffff (matching the stw_p below), so this chang=
e
> shouldn't be a problem.

Why not simply use qemu_strtoui() then? Later stw_p() implicitly cast=20
this to uint16_t anyway.

Any thought from other reviewers? Do we care? I'm feeling being a pain=20
with Sergio :/

>>> +        int ret;
>>>            /* skip "vga=3D" */
>>>            vmode +=3D 4;
>>>            if (!strncmp(vmode, "normal", 6)) {
>>> @@ -1211,7 +1213,12 @@ static void x86_load_linux(PCMachineState *pcm=
s,
>>>            } else if (!strncmp(vmode, "ask", 3)) {
>>>                video_mode =3D 0xfffd;
>>>            } else {
>>> -            video_mode =3D strtol(vmode, NULL, 0);
>>> +            ret =3D qemu_strtol(vmode, NULL, 0, &video_mode);
>>> +            if (ret !=3D 0) {
>>> +                fprintf(stderr, "qemu: can't parse 'vga' parameter: =
%s\n",
>>> +                        strerror(-ret));
>>> +                exit(1);
>>> +            }
>>>            }
>>>            stw_p(header + 0x1fa, video_mode);
>>>        }
>>>

