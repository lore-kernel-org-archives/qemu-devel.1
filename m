Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FB5C5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 20:55:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9699821852
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 20:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9699821852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1himHO-0007QZ-BM
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 16:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35183)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1himFL-0006yA-0g
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 16:52:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1himFJ-0002yK-3C
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 16:52:54 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:35015)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1himFH-0002wH-ES
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 16:52:52 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MirfI-1iCb0s2viO-00etGd; Wed, 03 Jul 2019 22:39:58 +0200
To: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
References: <BN6PR2201MB12513A40434D1750AAF40020C6FB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <c2660cf1-d23d-69ed-0f6b-2c450542cb18@vivier.eu>
 <BN6PR2201MB1251AE1CACDAD8DC61CDC39CC6FB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <CAFEAcA9n+NqrOvejcCe5aNAOEai+9gRQQtforjKDMMJnNBLxOw@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <2b61c311-65e0-a56e-7551-f7a437399a8a@vivier.eu>
Date: Wed, 3 Jul 2019 22:39:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9n+NqrOvejcCe5aNAOEai+9gRQQtforjKDMMJnNBLxOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ebF8q4itzFIGbWipNNGKKbyEKVnIeEx9cnhd2AKRu2HHc4w2gKf
 /q+0XXOqMxNxKFmk6drZqt0zWKbBSSW1nJvnq3jkkOYztdCw3wYX4pvRm0E1EL4qefYKGcx
 GKGwPSyOEpxzTG2W1tl/xQpVXz3vZpOpruSiIsk0Ks+yuHXxjy/M/6UVg4OVG222BNnMPfL
 Ih+uLxoD6frQBVJja9S4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cdbDasofDVY=:XSwU4kaj/wNsGhFhrjCqGN
 PyUbkFslFRiwuOZp0O+v8CjfZq8BnSg2QsRURErKIFBOa5uW/XNrFW77BFzloSdpCKgJQtzAo
 uGWSHlFEL8W2yMzSyeQxLkK6TcW994Rzatqyz0d1heeUkw6RIhR82lVfekzAVrR0rX822m01H
 FWesEUhG90I88adNxTjnx/R9A/Bwb0feLuqQxLVpoRJGI6yXZrOgMYu+nN8LWiyVUIq0RWw4R
 wipUUf+lMAhzcZt4nD4uVs7QdkYSy/DQ6EoYkLlWXFSJ1NPwCI43J7syzgq+wY5eDUREUKGeV
 w/72jJXBNrsrE6sxQwBn1r0jR5UF+YdWr6M0KX7AP4lFK1FgZvNDmr146yPo7P5rhr2RhGXv9
 OemFRXjtfuxL2dqYTnInimgJbwfLTXLLcXF9Db/t5kCGPajkAx+4teZR1hptiLCXUR4M3AW9L
 t4UcWG2aZBFeviOqQl2/Sbbs583T4eWHWUDH8cCrKSxwoLj9iOy02avIicrGMFGaEbfNfg4eX
 XUfyZQIamxbvb3v4EJu5v+rRw4MDkQfjlWUdcsTcNOg51b1mEqYFTL4HQRKxns5YkqDF/RhY8
 nc3KXdOorbMpDwxUlEWNuBRcgsWWYqu6dNNIyUQQQxp3wv9pJiCaAiWS+XpmBVz4HCrwCVVsu
 AEkgXVYoUA4BJUH+vIE2P8Fz8IfrIMMHHY6WVyASt0vtpPTgfhknrvw0tbUsnrbJpyBUPN68t
 i40g228fsRcnKr67UdZnzAmHJyrxUZdUlGrfWDaaI6kJ9PAnH0bvizEx6Gk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
Subject: Re: [Qemu-devel] [BUG] Inappropriate size of target_sigset_t
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 03/07/2019 à 22:28, Peter Maydell a écrit :
> On Wed, 3 Jul 2019 at 21:20, Aleksandar Markovic <amarkovic@wavecomp.com> wrote:
>>
>> From: Laurent Vivier <laurent@vivier.eu>
>>> If I compare with kernel, it looks good:
>>> ...
>>> I think there is no problem.
>>
>> Sure, thanks for such fast response - again, I am glad if you are right. However, for some reason, glibc (and musl too) define sigset_t differently than kernel. Please take a look. I am not sure if this is covered fine in our code.
> 
> Yeah, the libc definitions of sigset_t don't match the
> kernel ones (this is for obscure historical reasons IIRC).
> We're providing implementations of the target
> syscall interface, so our target_sigset_t should be the
> target kernel's version (and the target libc's version doesn't
> matter to us). On the other hand we will be using the
> host libc version, I think, so a little caution is required
> and it's possible we have some bugs in our code.

It's why we need host_to_target_sigset_internal() and
target_to_host_sigset_internal() that translates bits and bytes between
guest kernel interface and host libc interface.

void host_to_target_sigset_internal(target_sigset_t *d,
                                    const sigset_t *s)
{
    int i;
    target_sigemptyset(d);
    for (i = 1; i <= TARGET_NSIG; i++) {
        if (sigismember(s, i)) {
            target_sigaddset(d, host_to_target_signal(i));
        }
    }
}

void target_to_host_sigset_internal(sigset_t *d,
                                    const target_sigset_t *s)
{
    int i;
    sigemptyset(d);
    for (i = 1; i <= TARGET_NSIG; i++) {
        if (target_sigismember(s, i)) {
            sigaddset(d, target_to_host_signal(i));
        }
    }
}

Thanks,
Laurent

