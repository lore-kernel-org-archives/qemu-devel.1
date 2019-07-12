Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA20C742BD
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 13:50:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00A2520863
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 13:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A2520863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlvwR-0001lq-8e
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 09:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60330)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hlvwG-0001NA-1U
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:50:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hlvwD-00072e-R9
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:50:15 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:47145)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hlvwD-000715-Ga
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:50:13 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MLiXQ-1i3bGs2stc-00HbOo; Fri, 12 Jul 2019 15:47:30 +0200
To: Arnd Bergmann <arnd@arndb.de>
References: <20190711173131.6347-1-laurent@vivier.eu>
 <CAK8P3a3-UaZ+RzYNZ25zFHs=1iZNrnaP_eAuHE0WAztztA4EGA@mail.gmail.com>
 <74807892-5d59-0a9a-8385-48cce361d842@vivier.eu>
 <CAK8P3a3XR=C27eYWQ+AxjZ1EEDNBz0HBB_NHh0hbrSDF5ASyqQ@mail.gmail.com>
 <e1c736b2-6f68-208e-9993-57ae143195ad@vivier.eu>
 <CAK8P3a3fZgcSR7V=NAjDa37-5j8L+n-cF1CVPiWjteV6hfHSLg@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <db82d6a2-8ca7-5bbb-0cf9-feecc8b2adfb@vivier.eu>
Date: Fri, 12 Jul 2019 15:47:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3fZgcSR7V=NAjDa37-5j8L+n-cF1CVPiWjteV6hfHSLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wUmlQ2FgHWZxw2AgRgGE0DL3AQV/MLi9LgZojY+0INuL9Irv8D4
 Ajjp+RlPAY+KRXvyXMJo1V0Hh3m9LXOzlWSwCoGu1k4U/hhL+EkRtd71taJiIrM3HhrtZr2
 252J76RmhbBJYSCxZWrD//yAtbeGcVr7I+qhkq1mrp8RL5m3BScGEZz5+Pal4t7qp+nD5U/
 EvJ4b4kDD9j1fITErO/VQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ru0+Z7DdUX8=:DH8z6J7sFUUhzEBnVGq1er
 E0tFns+dcZmtKsq2YGbBM10Zjr8kbzgF2H0PbmjlfGGEfN3xLRlZsKZ3eDkl1ep6Kj0t4r72z
 kml6HwRC7WsP5svGlicc8Z5luuYQoNQkOJPHAPMdvjzaBYhi6MA/vFxjQ0ZCLCIPAiLL5Pl3C
 F1DR4Pu7IHXv5U6oT7vmUeCey2v4/H2jZPCBfg1352ffT1Mo4koi2m6xc4cyYL1Pdj3DRw0Eg
 exkPs7jhB/iBOHluLk41E3Kt8SsEqWNOYXH+s7dy6o+jPcRfmR7p5UrOKs7gZKtbycjJFCAtw
 m+EGd8MJ/lu6A47RDSEnj8Od8bnkwn+SjhOzB87OfnFWV1xWVeYl8NE2yVjKJreh4tpHBtV2M
 2Tbe5Yav1ue/gJj7VocvX5EDV3pzpDed+RQp0etjVP7L5+ryVdVt6PxS/5hLBlDLcuKtN1aja
 o6xEFYPtxmaIlm+8JLQYnGcy7L6AWPrE+lPGHBvKvAG5S7PDel7ziqm1CeDjhaB45xiqHv60f
 cHRAZQY1ze/oFCNwjVqZXJ5ZZyzTO0p4rmk8AQ1wIQUWFFhyxmnxg8vbZykMoypcPJkbhNE4A
 gaJK4rYTi1Tu3IH79acetIaWZKM/1L2jT+yliXGdsuQdgcPj3lWVFZuxYopiVFbI8KTwSnJY9
 rEPYv20t2/FN9RPpbqluB8XgqPl6NVQbjKK6UsJvpOjhSVaH+KUYmUAPEgvIYcQB++ssjnWvf
 Ahw0iLoGikpYhh1lDDiG997x0PqWlRerxY6BffWdSyUaUj+Hp6oSUJzM6zE=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
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

Le 12/07/2019 à 15:36, Arnd Bergmann a écrit :
> On Fri, Jul 12, 2019 at 3:23 PM Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> Le 12/07/2019 à 14:47, Arnd Bergmann a écrit :
...
>>> No, you don't need to swap. The difference is only in the padding.
>>> Since the kernel uses a 64/64 structure here, and user space
>>> may have use 'long tv_nsec', you need to add the padding on
>>> the correct side, like
>>>
>>> struct timeval64 {
>>>    long long tv_sec;
>>> #if 32bit && big-endian
>>>    long :32; /* anonymous padding */
>>> #endif
>>>    suseconds_t tv_usec;
>>> #if (32bit && little-endian) || sparc64
>>>    long :32;
>>> #endif
>>> };
>>
>> We don't do memcopy() but we set each field one by one, so the padding doesn't
>> seem needed if we define correctly the user structure:
>>
>> struct target_timeval64 {
>>     abi_llong tv_sec;
>>     abi_long tv_usec;
>> };
>>
>> and do something like:
>>
>>     struct target_timeval64 *target_tv;
>>     struct timeval *host_tv;
>> ...
>>     __put_user(host_tv->tv_sec, &target_tv->tv_sec);
>>     __put_user(host_tv->tv_usec, &target_tv->tv_usec);
>> ...
> 
> That still seems wrong. The user application has a definition
> of 'timeval' that contains the padding, so your definition has
> to match that.

I don't find this definition with the padding. Where it is defined?

We are at the syscall level, so structures are the ones provided by the
target to the syscall, and they can be converted by the libc if the one
from the user space differs.

Thanks,
Laurent

