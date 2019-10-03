Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D73C10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 10:19:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30EF4218DE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 10:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30EF4218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFyD1-0006HO-3D
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 06:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55035)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iFyBv-0005PY-58
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 06:18:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iFyBu-00071J-2p
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 06:18:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55922)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iFyBt-000713-Qx
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 06:18:34 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D5DAB83F3B
 for <qemu-devel@nongnu.org>; Thu,  3 Oct 2019 10:18:32 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id m16so496989wmg.8
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 03:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kJvG7AsVE1kOxpy6R0lC9bIz0B0NBEXKBgW46F4eplU=;
 b=N/m43MgQqu5s8ODUNqxjFu40Wt0p6Jpu6EJynN55uLeZfDqhohry7J2yrFG0SM4N9d
 6xRenWuLaLr/zsfcET0yDzR15mVmFmEVdWar5nYtIgSJfrXx9DcjDqeVsv7ckAR3Juzy
 ePnGS9N3lBxZHg7rTyZe0KtbzaeZQzVz7pBRcsP4k0/LH3YEgTnumw0rsRyfDapcp1Ie
 m8+u6SAvvvpSVIqEdWe0X/yG+BPK6JDvWY4Lm1pgr7JXxo7pG/dcdmHsxVwNQJ/il7jG
 3zQw/djtrhB5o38r5v2HCL+XfQvFChX/iiPBnsxyNQdhVv5pr5LU4cX1mHTYr5dhg88Q
 5Qnw==
X-Gm-Message-State: APjAAAWVX8KjyhjUwvqbcmd08bt65y1snuUKSs2aLLDyi2JEV2Bm0b7T
 zdaaLdd05WYzRJRB4cK+Q9zGEIo1pn9giYx5ATRSJ/steDKHLSVmSsivL9KqdOdQHYjXbM4Svak
 xXAlyDpTCLPKX9ps=
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr5375032wrr.135.1570097911580; 
 Thu, 03 Oct 2019 03:18:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxyOo9+WbTEPSnrxk0HoOCGPhnve3bI8R+NZJKF9mI6DFxEWj+2jdnElRKabbYCZ/v+7iwKyg==
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr5375020wrr.135.1570097911387; 
 Thu, 03 Oct 2019 03:18:31 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id h17sm3405934wme.6.2019.10.03.03.18.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2019 03:18:30 -0700 (PDT)
Subject: Re: [PATCH] accel/kvm: ensure ret always set
To: Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20191002102212.6100-1-alex.bennee@linaro.org>
 <05d59eb3-1693-d5f4-0f6d-9642fd46c32a@redhat.com>
 <20191003092213.etjzlwgd7nlnzqay@steredhat>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e85b2eaa-1190-c372-5875-6a024ae3a9cd@redhat.com>
Date: Thu, 3 Oct 2019 12:18:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191003092213.etjzlwgd7nlnzqay@steredhat>
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
Cc: qemu-devel@nongnu.org, "open list:Overall KVM CPUs" <kvm@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/3/19 11:22 AM, Stefano Garzarella wrote:
> On Wed, Oct 02, 2019 at 01:08:40PM +0200, Paolo Bonzini wrote:
>> On 02/10/19 12:22, Alex Benn=C3=A9e wrote:
>>> Some of the cross compilers rightly complain there are cases where re=
t
>>> may not be set. 0 seems to be the reasonable default unless particula=
r
>>> slot explicitly returns -1.
>>>
>=20
> Even Coverity reported it (CID 1405857).

And GCC ;)

/home/phil/source/qemu/accel/kvm/kvm-all.c: In function =E2=80=98kvm_log_=
clear=E2=80=99:
/home/phil/source/qemu/accel/kvm/kvm-all.c:1121:8: error: =E2=80=98ret=E2=
=80=99 may be=20
used uninitialized in this function [-Werror=3Dmaybe-uninitialized]
      if (r < 0) {
         ^
cc1: all warnings being treated as errors
make[1]: *** [/home/phil/source/qemu/rules.mak:69: accel/kvm/kvm-all.o]=20
Error 1

Fixes: 4222147dfb7

>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> ---
>>>   accel/kvm/kvm-all.c | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>>> index aabe097c41..d2d96d73e8 100644
>>> --- a/accel/kvm/kvm-all.c
>>> +++ b/accel/kvm/kvm-all.c
>>> @@ -712,11 +712,11 @@ static int kvm_physical_log_clear(KVMMemoryList=
ener *kml,
>>>       KVMState *s =3D kvm_state;
>>>       uint64_t start, size, offset, count;
>>>       KVMSlot *mem;
>>> -    int ret, i;
>>> +    int ret =3D 0, i;
>>>  =20
>>>       if (!s->manual_dirty_log_protect) {
>>>           /* No need to do explicit clear */
>>> -        return 0;
>>> +        return ret;
>>>       }
>>>  =20
>>>       start =3D section->offset_within_address_space;
>>> @@ -724,7 +724,7 @@ static int kvm_physical_log_clear(KVMMemoryListen=
er *kml,
>>>  =20
>>>       if (!size) {
>>>           /* Nothing more we can do... */
>>> -        return 0;
>>> +        return ret;
>>>       }
>>>  =20
>>>       kvm_slots_lock(kml);
>>>
>>
>> Queued, thanks.
>>
>> Paolo
>>
>=20

