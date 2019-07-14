Return-Path: <SRS0=Qpa9=VL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE1AC73C66
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 13:31:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10FBF20644
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 13:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10FBF20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmebR-0000W4-9v
	for qemu-devel@archiver.kernel.org; Sun, 14 Jul 2019 09:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36857)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hmebE-00004x-Rf
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 09:31:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hmebD-0006jH-SP
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 09:31:32 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:41551)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hmebD-0006gu-Iz
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 09:31:31 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MFsdD-1hgIXR0ai7-00HMHS; Sun, 14 Jul 2019 15:31:10 +0200
To: Arnd Bergmann <arnd@arndb.de>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20190711173131.6347-1-laurent@vivier.eu>
 <CAK8P3a3-UaZ+RzYNZ25zFHs=1iZNrnaP_eAuHE0WAztztA4EGA@mail.gmail.com>
 <74807892-5d59-0a9a-8385-48cce361d842@vivier.eu>
 <CAK8P3a3XR=C27eYWQ+AxjZ1EEDNBz0HBB_NHh0hbrSDF5ASyqQ@mail.gmail.com>
 <e1c736b2-6f68-208e-9993-57ae143195ad@vivier.eu>
 <CAK8P3a3fZgcSR7V=NAjDa37-5j8L+n-cF1CVPiWjteV6hfHSLg@mail.gmail.com>
 <db82d6a2-8ca7-5bbb-0cf9-feecc8b2adfb@vivier.eu>
 <CAK8P3a3GwDr1wPU3hfnmN-N4kvBvSqxa2aRVLQABO70fv21YhQ@mail.gmail.com>
 <ac90d2b2-83e8-6ad3-5dca-81e179edec00@linaro.org>
 <CAK8P3a3L9e9X1-rODexx34EEs37zNK2qKXZRfZ+oi7eni_286Q@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <72f5a433-fbea-305a-fff8-7a2374298c53@vivier.eu>
Date: Sun, 14 Jul 2019 15:31:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3L9e9X1-rODexx34EEs37zNK2qKXZRfZ+oi7eni_286Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PtO4p1g2/Jjg4mduIYm7dN98zR9dcoUA0EJ89C8M7Gg28Iv90I4
 wt++bs2Z1Y14JQIfBIVreL6fVE9eVDkVp6kRpSj2pH3bItuULityU7akRxpWzdZkmOTjmM/
 ILRTQ58Ff+WD1VBEEfeoS9jyH16MzxLtzO+P2ccFBj//bO/h93Y4JeirukI1inqueXzH7Bv
 yCu+T4xgG/rIM/k2k8aAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EglYD8GXc8Q=:uYgdspf0ceh4dUrsGsdqCg
 JMauzG1UvDX1AU2BMh76ftbmJkkfNuLWLeEDuPgKDag1I4R4dOJUaUqpBlU2Qqp3xGk/ST7Vk
 eh2AZ7gbFXoeJu3fVH5fI6+YYetOC4y16duYtHmR1AsIQaaOhFBerPUmLpC26oIU6N6HevaYj
 ofYdQD5DdhxU6gZlmBfROrO9ghivYdKSkQAkwu4SjZZ/NwULA2m9Rq6nsZqYVSPyxybBVcE7k
 E7fuu5LvJIjXiRfGQY4RssxhikvN0FcWyN0sN40a39miZqkjkQIoR/L8I5ZTSj9K9F1GYfhIw
 eVPFPC6xZL5U4iYbT4CBYgG4WxwwgLZzTFLpa5L34Sls0h5lyZqK9rM8BrHZ7H3soyJJ7yqGO
 hWgxWK1mTLdjtdkbXOU495m/UWPnBjRcnJxBmEhdW1N8QUJ8G0Vums++ZxlX7s/WU+AKxBQZU
 fjcPGOYLuovQrAqWCtL1Oj4Khkf0M/MK0UTULh8rvfDLQgDNPFZk4IyutWt18Plxc1G5SIbLU
 EhAVsU83OpDQKRH+FnLm8vt2QtzGITGfUW+DeK724P+7auiePSUxvz/hcim3e/W9UyGbFelhF
 IBjVeG+ZTMxPJB2dfplIYCKvgSWoKcP0uKWeSE9vBXx0fhsSghbMf8pMIsU6cBWJhrmF/kHCR
 6SX7Rf5EIh8qWRzHcUo9H7d//l7K7pq36Kd+VTQk9z9Q0h6CvcAvNbOZ4sHKoUKv3oaoMOK9O
 sNdbvwwWUnfHzpdmx6O3KcqyXfAw3+547KjuL/MmCljoNYN0cEKzs1uPTAo=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
Subject: Re: [Qemu-devel] [PATCH v4] linux-user: fix to handle variably
 sized SIOCGSTAMP with new kernels
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
Cc: =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Gerhard Stenzel <gerhard.stenzel@de.ibm.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 14/07/2019 à 13:33, Arnd Bergmann a écrit :
> On Sun, Jul 14, 2019 at 12:41 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 7/12/19 3:55 PM, Arnd Bergmann wrote:
>>> glibc will have to create a definition that matches the kernel, which uses
>>>
>>> struct __kernel_timespec {
>>>     __s64 tv_sec;
>>>     __s64 tv_nsec;
>>> };
>>>
>>> As posix requires tv_nsec to be 'long', you need padding between
>>> tv_sec and tv_nsec to have a libc definition matching the kernel's
>>> binary layout.
>>
>> Yes, but that's glibc's lookout.  All qemu cares about emulating is the kernel
>> interface.  So I think Laurent is right here, in that two reads handle the
>> above structure just fine.
> 
> But that only works if the structure defined by qemu matches the kernel's.
> 
> The structure that Laurent proposed
> 
> struct target_timeval64 {
>     abi_llong tv_sec;
>     abi_long tv_usec;
> };
> 
> is not compatible with the kernel or the glibc structure.

Yes, you're right. The next patch revision will change this to the
kernel structure one.

Thanks,
Laurent

