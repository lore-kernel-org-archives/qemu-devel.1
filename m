Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F398AC33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:08:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C354E21741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J8qiGFrH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C354E21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izjhj-0004mg-0R
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 11:08:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izjh5-0004F3-FJ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:07:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izjh4-0001YA-72
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:07:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34377
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izjh4-0001RJ-2E
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:07:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581005273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IJp/IHqfiSLSEH3R+jwt5BQ3ZU/6QSz6uLPettbNUEU=;
 b=J8qiGFrHX+p3ErYCIeyCY7ktDGwgEzmJyuy1iavSBOuBlLu4saMlkqjkdGJum63B4eDMXL
 uyGEbitr4BlaxXXZQmrKRF1LozZg0fEknHIQ9b+R0cNPSCo8ot36dKcoEjm48FhZh9jIVN
 IGfc7uYevkHdcxOVbU+guAYwdp578SE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-8LCIMEYeOtSG-y3DTAmRag-1; Thu, 06 Feb 2020 11:07:24 -0500
Received: by mail-wm1-f70.google.com with SMTP id 205so235114wmc.6
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 08:07:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=czZ7+h/n/O9iwLqfeysG+xdfIxNcbyfFHujNXV5pC8Q=;
 b=ReuaMkW80fKmimvkF48BSQ2t+WjV2JM6fHFjmUNyEUGDIUkYRFTuOpI7rxMhTj5/dJ
 9mxuY0pD0btzQOtKB8oIjXVo1OadhKIWkcNCddCy4sKhrTjbWOoigzx9gSjlyro0nkcn
 Nz0ss0OGvIqJa9dhqSWFt0/aB66yntkrhqvYeAdmYdwfRwxaz8NqpRyZ4q6MNXWwplQe
 kyPT6L7FrZWf31xnJL+eY+aB0LzSUjEMf8rPoSHnhOCit6Y1DM2oc3oMgVNCj68izzUG
 D0YA7p2DpdTFxJLXEJx3JEj2dv215joRui1NLOSCIW3JmqGRlukPKAnIrZFONq6fWbXb
 j3XA==
X-Gm-Message-State: APjAAAVyBQT5U3mBpseHO3yo198mzrq2Jl9HCFz/k9CQWtSL/XXxRRVX
 /29s6XX2EKkqYSkLRAQGiqOihxVPIop7H0sFqt2SC6J3C/OMvzabvMmbrDEeAixAVydOADP9umy
 tTCO1AeW/NZiG2r0=
X-Received: by 2002:a1c:7205:: with SMTP id n5mr5576252wmc.9.1581005243318;
 Thu, 06 Feb 2020 08:07:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqy0/+xn5N+LTV3BSLKF656ws14+OlsX6UyoIsRqW7/A7DvQV8VbIWFHFYGxr3vVa8QnIXEuRQ==
X-Received: by 2002:a1c:7205:: with SMTP id n5mr5576224wmc.9.1581005243023;
 Thu, 06 Feb 2020 08:07:23 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id r14sm4526913wrj.26.2020.02.06.08.07.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 08:07:22 -0800 (PST)
Subject: Re: [PATCH v2 4/4] Add the NVMM acceleration enlightenments
To: Kamil Rytarowski <n54@gmx.com>
References: <20200107124903.16505-1-n54@gmx.com>
 <20200128140945.929-1-n54@gmx.com> <20200128140945.929-5-n54@gmx.com>
 <0ed12efa-eee4-b3ff-8f02-f9c3b80d0e21@redhat.com>
 <2ae4caf9-05fd-b740-2612-e1c1ecafe277@gmx.com>
 <87o8ubuapr.fsf@dusky.pond.sub.org>
 <CAP+75-VnwDz0My7p5Zy3SN2gPeACW0z02MUgrdFnSGiZm6xGXg@mail.gmail.com>
 <e87ac5e1-749e-84a2-2c9e-89ac1c69fcdc@gmx.com>
 <87v9ojst1h.fsf@dusky.pond.sub.org>
 <f05b132a-00e6-9fe6-fc77-81e01cda9db2@gmx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2e1a0fbb-6cf7-899a-856b-bc88a436cbd3@redhat.com>
Date: Thu, 6 Feb 2020 17:07:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <f05b132a-00e6-9fe6-fc77-81e01cda9db2@gmx.com>
Content-Language: en-US
X-MC-Unique: 8LCIMEYeOtSG-y3DTAmRag-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, max@m00nbsd.net,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/6/20 4:38 PM, Kamil Rytarowski wrote:
> On 06.02.2020 15:13, Markus Armbruster wrote:
>> Kamil Rytarowski <n54@gmx.com> writes:
>>
>>> On 06.02.2020 14:09, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> On Thu, Feb 6, 2020 at 2:06 PM Markus Armbruster <armbru@redhat.com> w=
rote:
>>>>> Kamil Rytarowski <n54@gmx.com> writes:
>>>>>
>>>>>> On 03.02.2020 12:54, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>>>>> @@ -2029,6 +2072,19 @@ static void qemu_whpx_start_vcpu(CPUState *=
cpu)
>>>>>>>>    #endif
>>>>>>>>    }
>>>>>>>>
>>>>>>>> +static void qemu_nvmm_start_vcpu(CPUState *cpu)
>>>>>>>> +{
>>>>>>>> +    char thread_name[VCPU_THREAD_NAME_SIZE];
>>>>>>>> +
>>>>>>>> +    cpu->thread =3D g_malloc0(sizeof(QemuThread));
>>>>>>>> +    cpu->halt_cond =3D g_malloc0(sizeof(QemuCond));
>>>>>>>
>>>>>>> Nitpick, we prefer g_new0().
>>>>>>
>>>>>> In this file other qemu_*_start_vcpu() use  g_malloc0().
>>>>>>
>>>>>> I will leave this part unchanged and defer tor future style fixups i=
f
>>>>>> someone is interested.
>>>>>
>>>>> Time to re-run Coccinelle with the semantic patch from commit
>>>>> b45c03f585e.
>>>>
>>>> I thought about it, but then noticed it would be clever to modify
>>>> checkpatch to refuse 'g_malloc0?(.*sizeof.*);'
>>>>
>>>>
>>>
>>> As the patchset was reviewed, could we please merge it in the current
>>> (v3) form (*) please?
>>
>> No objection.  If I wanted you to clean this up before we accept your
>> work, I would've told you :)
>>
>> [...]
>>
>>
>=20
> I see. I don't own myself a merge queue so I depend on yours.

As you said [*] you'd love to have this feature in NetBSD 9.0, no=20
objection neither. You still need some X86 specialist to review patch 3.=20
The usual reviewers Paolo/Eduardo/Richard are currently very busy.

Also while I'd love to use this feature to be able to regularly run QEMU=20
CI on NetBSD, I don't have time to test it on a bare metal hardware :|
Maybe do you know someone from the NetBSD community who already did?

[*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg676199.html


