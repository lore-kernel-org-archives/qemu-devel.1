Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C284AC742BE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 13:23:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F44120665
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 13:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F44120665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlvWU-0002kn-MO
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 09:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52677)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hlvWI-0002Lq-JI
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:23:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hlvWH-0003jN-DN
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:23:26 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:36201)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hlvWH-0003i4-1t
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:23:25 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MRTAj-1i9OD62kRZ-00NRP1; Fri, 12 Jul 2019 15:22:57 +0200
To: Arnd Bergmann <arnd@arndb.de>
References: <20190711173131.6347-1-laurent@vivier.eu>
 <CAK8P3a3-UaZ+RzYNZ25zFHs=1iZNrnaP_eAuHE0WAztztA4EGA@mail.gmail.com>
 <74807892-5d59-0a9a-8385-48cce361d842@vivier.eu>
 <CAK8P3a3XR=C27eYWQ+AxjZ1EEDNBz0HBB_NHh0hbrSDF5ASyqQ@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e1c736b2-6f68-208e-9993-57ae143195ad@vivier.eu>
Date: Fri, 12 Jul 2019 15:22:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3XR=C27eYWQ+AxjZ1EEDNBz0HBB_NHh0hbrSDF5ASyqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HY8xKoDRMSTlFrx/iXSBNqMFLg569yrQb+JDEI91rNoB2xbOziV
 ImeGnNcIXP9IrIbcfd4D96fZJdBSIwJQpHzIj5Aaf+qEZwcLXLM0fH0xtdU27YE+kx8MSYE
 anhJwN6nJnlTyRXOBifk+0mvmHL5RcOXIxcothkA3OL/VHP20rOSbXLRZSr1JsPzbbOiiOl
 G6nt9Y6MidRVxHj0JRvCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4V6fsUG1qvU=:cS3N3mTqYSlW3bJ1ovKqdk
 q3r+0UkHHgQ+wJWCoaLuqlI+7MxazCvsMKg9NdBRYvaVfhl5kbkl+5mV38jrPNfARn8QET27S
 taBo0Wav0HuRi3U8Ce4NxuZ6r57/uToHaGsbfajw24WGBJtiH7Euu5BLt/uqHuhj/JU44WeHF
 S6orqh+CW87zO/Mms7k1Jrocdaa4/dE2tMdCrzEVHNVRRv96cYmvUKcLigNn+7Zgo5bZWNH1h
 tsJuKAHXe3AJXUrsseWMjsMzaCEWJGY1zpR2JwG6hDfxsX+jWZL/rYA5wGGWBX7L1b1397/6+
 mVw4YVT3Q7oYovWoK9+NoPC7/b4e/r478y23mMn0T1Sgnlu8aIZaG0TIdqYJXxcGCVXEHo6pL
 PwXExv1pcFGcClTSKT69tC7h+bw1CPi5P5Hzm2aPh85if+8rjL5dNMpvwc5EIczCt1QOzx098
 ZU996U8c4I7k9WW1kRvcZqDTZ2ts3uD0+M2QG3mYWhCNslC45I13CpZGq8ypbGkoZ5+oFINq6
 jtRkfxX1x8s8tRD18XFqihLvseJiJqAYJskbp7dq87eiZ0t6g8T1Fu8kvFlwfPOXZVPf1hkSn
 LyaKarSQ/u69veltQddl+fo4KPzT77jSXU1jMYo2BANHJ/PRB4+/9ZKO+Qk0ka1Ui76YfEsZm
 0XRowEfdfgBS19zvDDeHCVZAtJhFn5mArVm+/9fNZB2+qkQURWuUBWPHFWyR0eB0hSqdSBUUx
 j31HEWFrp/CMoJd5FQvDLK5dGXM2xJMOYVXRe7SsKv2IF39nf4QmTsKaW/E=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
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

Le 12/07/2019 à 14:47, Arnd Bergmann a écrit :
> On Fri, Jul 12, 2019 at 2:17 PM Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> Le 11/07/2019 à 23:05, Arnd Bergmann a écrit :
>>> On Thu, Jul 11, 2019 at 7:32 PM Laurent Vivier <laurent@vivier.eu> wrote:
>>>
>>>>
>>>> Notes:
>>>>     v4: [lv] timeval64 and timespec64 are { long long , long }
>>>
>>>>
>>>> +STRUCT(timeval64, TYPE_LONGLONG, TYPE_LONG)
>>>> +
>>>> +STRUCT(timespec64, TYPE_LONGLONG, TYPE_LONG)
>>>> +
>>>
>>> This still doesn't look right, see my earlier comment about padding
>>> on big-endian architectures.
>>>
>>> Note that the in-kernel 'timespec64' is different from the uapi
>>> '__kernel_timespec' exported by the kernel. I also still think you may
>>> need to convert between SIOCGSTAMP_NEW and SIOCGSTAMP_OLD,
>>> e.g. when emulating a 32-bit riscv process (which only use
>>> SIOCGSTAMP_NEW) on a kernel that only understands
>>> SIOCGSTAMP_OLD.
>>
>> I agree.
>> I'm preparing a patch always using SIOCGSTAMP and SIOCGSTAMPNS on the
>> host (converting the structure when needed).
> 
> That in turn would have the problem of breaking in 2038 when the
> timestamp overflows.

No, because SIOCGSTAMP and SIOCGSTAMPNS are aliased to the _NEW versions 
on system supporting them (yes, we need to rebuild the binary, but we have 19 
years to do that).

#define SIOCGSTAMP      ((sizeof(struct timeval))  == 8 ? \
                         SIOCGSTAMP_OLD   : SIOCGSTAMP_NEW)
#define SIOCGSTAMPNS    ((sizeof(struct timespec)) == 8 ? \
                         SIOCGSTAMPNS_OLD : SIOCGSTAMPNS_NEW)

> 
>> I've added the SH4 variant.> What is special about SH4?

The definition of _OLD is different:

#define SIOCGSTAMP_OLD  _IOR('s', 100, struct timeval) /* Get stamp (timeval) */
#define SIOCGSTAMPNS_OLD _IOR('s', 101, struct timespec) /* Get stamp (timespec) */


> 
>> I've added the sparc64 variant too: does it means sparc64 use the same
>> structure internally for the OLD and NEW version?
> 
> I had to look it up in the code. Yes, it does, timeval is 64/32/pad32,
> timespec is 64/64 in both OLD and NEW for sparc.
> 
>> What about sparc 32bit?
> 
> sparc32 is like all other 32-bit targets: OLD uses 32/32, and
> new uses 64/64.
> 
>> For big-endian, I didn't find in the kernel where the difference is
>> managed: a byte swapping of the 64bit value is not enough?
> 
> No, you don't need to swap. The difference is only in the padding.
> Since the kernel uses a 64/64 structure here, and user space
> may have use 'long tv_nsec', you need to add the padding on
> the correct side, like
> 
> struct timeval64 {
>    long long tv_sec;
> #if 32bit && big-endian
>    long :32; /* anonymous padding */
> #endif
>    suseconds_t tv_usec;
> #if (32bit && little-endian) || sparc64
>    long :32;
> #endif
> };

We don't do memcopy() but we set each field one by one, so the padding doesn't 
seem needed if we define correctly the user structure:

struct target_timeval64 {
    abi_llong tv_sec;
    abi_long tv_usec;
};

and do something like:

    struct target_timeval64 *target_tv;
    struct timeval *host_tv;
...
    __put_user(host_tv->tv_sec, &target_tv->tv_sec);
    __put_user(host_tv->tv_usec, &target_tv->tv_usec);
...

Thanks,
Laurent
    


