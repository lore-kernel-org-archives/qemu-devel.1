Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D726C74A4B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 10:47:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3641F2064B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 10:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3641F2064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlWcC-0003Tg-BL
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 06:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41579)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hlWbT-0002zB-Uf
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 06:47:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hlWbL-0000dx-CC
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 06:47:07 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:52857)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hlWbK-0000WX-3H
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 06:46:58 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MLA2e-1i2dm12Wig-00I9Zb; Thu, 11 Jul 2019 12:46:39 +0200
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>
References: <20190617131103.1413-1-berrange@redhat.com>
 <b6d3c3b0-da81-8b59-1660-83ef5423b097@vivier.eu>
 <CAATJJ0K4xZ4iPxBKz-iCv6sDTjWE5y+-wg7T9OOiRq4tTG__mA@mail.gmail.com>
 <20190711092430.GC11930@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <65c3aa05-4fe9-0bbd-a86b-60cc6719d854@vivier.eu>
Date: Thu, 11 Jul 2019 12:46:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190711092430.GC11930@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4y6COXMjzMTAgBg88rugPkaNdryHJfCjJeNfTW+5OUy1SG4DHHy
 GJaF+bw3NyVC+qKeeRQlcmP9FsJHLKnPge71uJXBIkeMi06rmOiytVsmI7YHiQpmyBPIVk9
 bReTdb11BbXoIU+pGQwztT7quvvYsA7jS5SvlICdkArIqI9T05gaR3Pm/fqN88OVoPbrSE4
 TRxhV7gxG9JGv8m2ANgCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3OWE2bJNi08=:TkMIjY4lKy2MoVzsflQhYV
 kuIXSO+Ic823a51lq09aR7T1IXRlB8L8keiSo3Yjuk29Anj6x6FmWbaeKNea2STTfpsh9FwnP
 pIhBts18sqJPZ2gahDOGclicGM1Vf9gg1rT40dGcUs+HH9H/ah4VuAExJ7cKtqE/i0qBEf/HR
 hzYJKlnenXMCBJwc4QStWRWUBFQLiO+OaD2Y5J7KoDsnFIgJTAXfmuYQWwpddS6xiorQs0a6Q
 8M0oYxd6Cf8NpgsN591mALgrOWfeKFl5tQQ0QWDLt/lKpv2bagnTSFD7U8uAuqtDJCZp8szZJ
 ORHsyWEx9MaI1h4/N68Ib7BT8tLMMHDc/NA1pWM//9j/t4XfJEJQgxQGiKCVa1eeNbiAWyAEf
 pQMCQi0N47faxrnElhbwWFL2r6YKD4rqUmUMnMLfor/1yyW5YL1waIZwD6h4yH945FChHl+F1
 Mhx/NJtSMWPU/VS8CO66ErScAVu/RaM+2MKtuWyOQy2ysWFN2fIQ41kQVxNGLekEXX8jD4wp6
 A3Y88ApSZIDYlwEuR0kGt6EiLYlQQLDLsweKCcLqTAVJArFo6zcdbNsUfWyDpId770RcDLn5G
 eZDVYxLXFdBvQ7RXX4iyAmE+si9c6itsXBJcP2w6og0vIcda/FNOcGfn1CFamd5XrR8w9ILS5
 vffj2aSxRJs5KMjpnzQ9gOZlpQW6Wate21I1uEAlpPxwjCueR9PRZJPqWQjTMZI9btKUIxh4p
 fI4mUggSeT4hM538ENztDyEst7xE4mIViXabwlH9ywEDb/PfiDswHjdsDGw=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: fix to handle variably
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
Cc: Gerhard Stenzel <gerhard.stenzel@de.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Riku Voipio <riku.voipio@iki.fi>, qemu-devel <qemu-devel@nongnu.org>,
 Arnd Bergmann <arnd@arndb.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 11/07/2019 à 11:24, Daniel P. Berrangé a écrit :
> On Thu, Jul 11, 2019 at 10:02:01AM +0200, Christian Ehrhardt wrote:
>> On Mon, Jun 17, 2019 at 5:35 PM Laurent Vivier <laurent@vivier.eu> wrote:
>>>
>>> Le 17/06/2019 à 15:11, Daniel P. Berrangé a écrit :
>>>> The SIOCGSTAMP symbol was previously defined in the
>>>> asm-generic/sockios.h header file. QEMU sees that header
>>>> indirectly via sys/socket.h
>>>>
>>>> In linux kernel commit 0768e17073dc527ccd18ed5f96ce85f9985e9115
>>>> the asm-generic/sockios.h header no longer defines SIOCGSTAMP.
>>>> Instead it provides only SIOCGSTAMP_OLD, which only uses a
>>>> 32-bit time_t on 32-bit architectures.
>>>>
>>>> The linux/sockios.h header then defines SIOCGSTAMP using
>>>> either SIOCGSTAMP_OLD or SIOCGSTAMP_NEW as appropriate. If
>>>> SIOCGSTAMP_NEW is used, then the tv_sec field is 64-bit even
>>>> on 32-bit architectures
>>>>
>>>> To cope with this we must now define two separate syscalls,
>>>> with corresponding old and new sizes, as well as including
>>>> the new linux/sockios.h header.
>>>>
>>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>>> ---
>>>>  linux-user/ioctls.h        | 15 +++++++++++++++
>>>>  linux-user/syscall.c       |  1 +
>>>>  linux-user/syscall_defs.h  |  5 +++++
>>>>  linux-user/syscall_types.h |  4 ++++
>>>>  4 files changed, 25 insertions(+)
>>>>
>>>> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
>>>> index 5e84dc7c3a..5a6d6def7e 100644
>>>> --- a/linux-user/ioctls.h
>>>> +++ b/linux-user/ioctls.h
>>>> @@ -222,8 +222,23 @@
>>>>    IOCTL(SIOCGIWNAME, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_char_ifreq)))
>>>>    IOCTL(SIOCSPGRP, IOC_W, MK_PTR(TYPE_INT)) /* pid_t */
>>>>    IOCTL(SIOCGPGRP, IOC_R, MK_PTR(TYPE_INT)) /* pid_t */
>>>> +
>>>> +#ifdef SIOCGSTAMP_OLD
>>>> +  IOCTL(SIOCGSTAMP_OLD, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timeval)))
>>>> +#else
>>>>    IOCTL(SIOCGSTAMP, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timeval)))
>>>> +#endif
>>>> +#ifdef SIOCGSTAMPNS_OLD
>>>> +  IOCTL(SIOCGSTAMPNS_OLD, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timespec)))
>>>> +#else
>>>>    IOCTL(SIOCGSTAMPNS, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timespec)))
>>>> +#endif
>>>> +#ifdef SIOCGSTAMP_NEW
>>>> +  IOCTL(SIOCGSTAMP_NEW, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timeval64)))
>>>> +#endif
>>>> +#ifdef SIOCGSTAMPNS_NEW
>>>> +  IOCTL(SIOCGSTAMPNS_NEW, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timespec64)))
>>>> +#endif
>>>>
>>>>    IOCTL(RNDGETENTCNT, IOC_R, MK_PTR(TYPE_INT))
>>>>    IOCTL(RNDADDTOENTCNT, IOC_W, MK_PTR(TYPE_INT))
>>>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>>>> index b187c1281d..f13e260b02 100644
>>>> --- a/linux-user/syscall.c
>>>> +++ b/linux-user/syscall.c
>>>> @@ -37,6 +37,7 @@
>>>>  #include <sched.h>
>>>>  #include <sys/timex.h>
>>>>  #include <sys/socket.h>
>>>> +#include <linux/sockios.h>
>>>>  #include <sys/un.h>
>>>>  #include <sys/uio.h>
>>>>  #include <poll.h>
>>>> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
>>>> index 7f141f699c..7830b600e7 100644
>>>> --- a/linux-user/syscall_defs.h
>>>> +++ b/linux-user/syscall_defs.h
>>>> @@ -750,6 +750,11 @@ struct target_pollfd {
>>>>
>>>>  #define TARGET_SIOCGSTAMP      0x8906          /* Get stamp (timeval) */
>>>>  #define TARGET_SIOCGSTAMPNS    0x8907          /* Get stamp (timespec) */
>>>> +#define TARGET_SIOCGSTAMP_OLD   0x8906          /* Get stamp (timeval) */
>>>> +#define TARGET_SIOCGSTAMPNS_OLD 0x8907          /* Get stamp (timespec) */
>>>> +#define TARGET_SIOCGSTAMP_NEW   TARGET_IOC(TARGET_IOC_READ, 's', 6, sizeof(long long) + sizeof(long)) /* Get stamp (timeval64) */
>>>> +#define TARGET_SIOCGSTAMPNS_NEW TARGET_IOC(TARGET_IOC_READ, 's', 7, sizeof(long long) + sizeof(long)) /* Get stamp (timespec64) */
>>> kernel defines:
>>>
>>> #define SIOCGSTAMP_NEW   _IOR(SOCK_IOC_TYPE, 0x06, long long[2])
>>> #define SIOCGSTAMPNS_NEW _IOR(SOCK_IOC_TYPE, 0x07, long long[2])
>>>
>>> So it should be TARGET_IOR(0x89, 0x6, abi_llong[2])
>>>
>>> Their codes are 0x80108906 and 80108907.
>>
>> Hi,
>> I found the discussion around this topic being almost a month old.
>> And related to this fedora bug [1] was closed by adding [2] which
>> matches [3] that was nacked in the discussion here.
>>
>> Since I found nothing later (neither qemu commits nor further
>> discussions) I wonder if it has fallen through the cracks OR if there
>> was a kernel fix/change to resolve it (if that is the case a pointer
>> to the related kernel change would be nice)?
> 
> I didn't have time to address the feedback to this v2, and since the
> immediate problem for Fedora has a workaround, its been lower priority
> especially since my understanding of linux-iser is limited.
> 
> IOW, If anyone wants to take over my patch proposal here feel free. It
> would obviously be nice to fix for this 4.1 release if practical.

I'm going to try to update your patch.

Thanks,
Laurent


