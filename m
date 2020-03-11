Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98829C10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 07:36:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A90420873
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 07:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A90420873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBvuv-00018W-Kn
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 03:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49367)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBvuO-0000ip-Gn
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 03:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBvuN-0006H6-C3
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 03:36:04 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:58767)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jBvuN-0006GG-3X
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 03:36:03 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MekvV-1jmMeP3sFZ-00akge; Wed, 11 Mar 2020 08:35:49 +0100
Subject: Re: [PATCH] linux-user: syscall: ioctls: support DRM_IOCTL_VERSION
From: Laurent Vivier <laurent@vivier.eu>
To: chengang@emindsoft.com.cn, riku.voipio@iki.fi
References: <20200226113834.26404-1-chengang@emindsoft.com.cn>
 <6abe4989-6d63-6bc5-f566-96d7bda30df7@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b1d26a73-67d0-239f-0a71-16cbfddf8b96@vivier.eu>
Date: Wed, 11 Mar 2020 08:35:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <6abe4989-6d63-6bc5-f566-96d7bda30df7@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IxbKf9pMGW/tb90B8Kb5jzbJAS/Sojg14k8XEvJIcdhOB4swyH4
 /EYPA4kBNRZc61mpQk6uSaFDyTBReuCB0ROfnxinM4dCUTRSLL3D4c17uMhRjFJZuil23Y3
 YYede9XRjM2poAJaLYGEc1+e9xYUQ+3jDS7+asWu1E01RO6uShq28MroLZYz2IfMEoX0dcj
 gQU5K14QyrXGcqGkHkK3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/ddbODkvTWc=:331ILYAfpPq//xE4s3f47U
 +LWOFXbcVw6CYDUUZJggCn797e8li/MC0vTbuvrV9nCd+xp63I2mTcXQ5waBvRePHhvx+eCyD
 KsnYKPfrzPWV8zGsGU6BTShouip+NDnzV8r6+GY8cy5QrnPlQ9xJivxw8SI+v6p3PtWLPeqjs
 aYBBzYoK5l9BdUlggYQ72DvuD9ezTixbKl1PfL/xxS1tIkgQnU0J8znRGOmkMrH3BaUSVM583
 fQAk7oXhq3dUqMV/negmiSXZ68PZlfbaUcGjCbcJrSucjCt4yx0kYsvbJG+YSn3Q3mENl5bnQ
 9CePSJoOhycM09sO5giviiYuBt4qT0mQ9FKuq7yvY392UDVcQj0vNmkuNi++zow/wRFLxzKSU
 18ZdQ4P3cKAu1e4ixwSiQDFb6aHIN3L7/ln+mauT4MEYzcV5l9CP6HUIPSWcWwXLzEk2XuT+m
 tVl60PgKrwBKSRYc4P6w7GLRmzTved6oEgU1bsaeD+rzp6lHy991usst3/DrO14u84Q9XBWda
 YvpT4o0Qqv8e4k/Okz1oNCLGjmMp66kJrtJGyGKkDxYWx8wZQRryv7P04v9r6+/cJOd88FpvT
 4mNdv3vG2lqzFuBpVnjejvisOo0q8cZ2zeUyrTfEpXrPW1mCtOIubYhjTzt/hhy1EtdjFlckV
 DL+LqXoh+pkC6sSedFZy1MXFBpfjO+di2zLkhdeTTgMbxAK4RcxluR7XyaGVg78Gl5yyfSePy
 AYj9dlGo4QSD3FUdgnvvalf/VNEChHfXez4t+oHzFYieCHk3/unMFpg2gMRLWag7MNCgKt2me
 5Mn00AFGekql1GafCpAgN/SdR+68FTKDyLDFYMKuUf2/6qNOPddSqyoDUt5oWk+kUQrj8cz
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 10/03/2020 à 21:16, Laurent Vivier a écrit :
> Le 26/02/2020 à 12:38, chengang@emindsoft.com.cn a écrit :
>> From: Chen Gang <chengang@emindsoft.com.cn>
>>
>> The other DRM_IOCTL_* commands will be done later.
>>
>> Signed-off-by: Chen Gang <chengang@emindsoft.com.cn>
>> ---
>>  linux-user/ioctls.h        |   3 +
>>  linux-user/syscall.c       | 134 +++++++++++++++++++++++++++++++++++++
>>  linux-user/syscall_defs.h  |  16 +++++
>>  linux-user/syscall_types.h |  12 ++++
>>  4 files changed, 165 insertions(+)
>>
>> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
>> index 0defa1d8c1..c2294b48a0 100644
>> --- a/linux-user/ioctls.h
>> +++ b/linux-user/ioctls.h
>> @@ -574,6 +574,9 @@
>>    IOCTL_SPECIAL(SIOCDELRT, IOC_W, do_ioctl_rt,
>>                  MK_PTR(MK_STRUCT(STRUCT_rtentry)))
>>  
>> +  IOCTL_SPECIAL(DRM_IOCTL_VERSION, IOC_RW, do_ioctl_drm,
>> +                MK_PTR(MK_STRUCT(STRUCT_drm_version)))
>> +
> 
> Rather than adding a specific function to process the structure, perhaps
> we can add this in a generic way?
> 
> The problem with drm_version structure is the pointers to the strings.
> 
> Did you try to add a TYPE_STRING in
> thunk_type_size()/thunk_type_align()/think_convert()/do_ioctl() to do that?

In fact we can't do that because we need to know the size of the buffer
to allocate and it is provided by another field. It cannot be generic,
so I think what you do is the best we can do.

Thanks,
LAurent


