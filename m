Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB84C33CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 08:01:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54E4C20678
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 08:01:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E4C20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ippEE-0004dy-9u
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 03:01:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1ippD1-0003yW-6x
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 02:59:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ippCz-0004Kb-Rj
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 02:59:55 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:49389)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1ippCx-0003xv-9w; Fri, 10 Jan 2020 02:59:51 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N5VPg-1jjY5G0gQ6-016uze; Fri, 10 Jan 2020 08:59:40 +0100
Subject: Re: [PATCH] vl: Don't mismatch g_strsplit()/g_free()
To: pannengyuan@huawei.com, pbonzini@redhat.com
References: <20200110031618.23332-1-pannengyuan@huawei.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <49907b09-2c11-1e95-9aa2-6b9cb0abf6cb@vivier.eu>
Date: Fri, 10 Jan 2020 08:59:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200110031618.23332-1-pannengyuan@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2YY6+bSeiAjnwfq8sezk9voxtH1p/H8lfBw63d5prL748fUPVrQ
 zGr+jkzFyv/9I+b3uocDk9yBycbI8zsDNiLHA/RPtOMG0/xzRxVYkcoRtTz/9+fwQbqspRB
 0zq5m3BtR6JJb9upUlK3DRadEp5jyJShhmHUVTgcanYx4hkNuqFROGVgSzpPnytJM6zcm2Z
 9F0nB/qsp9lS9aEeQgDzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vpKXHJg/K2k=:F24eHMAtyKww2LXE1RfdJa
 LZvWiE6B7HV/hwbQdV3rbWD3uvzfWAJ+fX27ikYgT2neU5wxmDO+kQJ55NH9TADSsa5qtuiys
 pxkncM4l6Aa4XdPwZfrIQSHYgA5zSiP7D6pgNdQInsnNZDcd8iXSiP1P9c7Di8JJS7eg1Fvrs
 vKs+8xmE3RoVXn14wqPawoZTrWY5rN0xOS9mFpM30CDmwX/Y8FGwBEB7SRW+i3RRpWUjTlqIf
 09EX+BPE0VMgfoGBXp0rg/3/5wMCvg9+ASahVfxsKZaqtd9Op9rR2bkWAYpWfm2Qd0dJABmBc
 VW9ikxPJWfhCgSFJ0BE8awxz23FblU2R1M4MtI/Pv06bXRsv5bI5fDze6IOWs8feL5hchtQ9a
 EwDmz+82J57jN42YmCxMdEk0isUNrG32cCnz6gV+b83nMKsyDoe6osuCWubiE9GCiW4XNnhys
 42nfI6t8ACxL/d/Nn8wLBRVmCTtlIhkpX4JttLlgPpJsBPNHY0oA8HTSu0/kWHbUVEExAqnGl
 9UedHRRnP9YHgBoTcNHwP6lMFhcH+pwTA1JDte/sAgcvDeQEukI71YbESNUlJ2nsASX8olOFF
 EZH0eigO3CvH/+KFNs2S7s4tTnM+Dex2lTXo7lpbKdZy0lz+mQH6AltVXlIiPOEjNMXzXX8S/
 8MLvhncQpKzQzipA9JLlXqmGDUziMvpyoPbq7+miNWIZmXdOT3TQ9DtHSeZJW/0fkVTc+QflN
 5ZZTt90kXy+Xxc87iU8p7g+7Pcx0yvDPY3xDilMRVMZNsuc9zvM6QCkrAo5VEXRCgIJjaof0y
 VhmRO2xv4Kov36K8hdiUWdHQNojKmcLZen/6sAgV2apndKCIX+mDmIRqhCTlbpE8ycK3j6IEV
 WFkmZ2qx6vAtYmkUHmaVWROc8URC0VqUWegsx+Is8=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.13
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
Cc: qemu-trivial@nongnu.org, zhang.zhanghailiang@huawei.com,
 qemu-devel@nongnu.org, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 10/01/2020 à 04:16, pannengyuan@huawei.com a écrit :
> From: Pan Nengyuan <pannengyuan@huawei.com>
> 
> It's a mismatch between g_strsplit and g_free, it will cause a memory leak as follow:
> 
> [root@localhost]# ./aarch64-softmmu/qemu-system-aarch64 -accel help
> Accelerators supported in QEMU binary:
> tcg
> kvm
> =================================================================
> ==1207900==ERROR: LeakSanitizer: detected memory leaks
> 
> Direct leak of 8 byte(s) in 2 object(s) allocated from:
>     #0 0xfffd700231cb in __interceptor_malloc (/lib64/libasan.so.4+0xd31cb)
>     #1 0xfffd6ec57163 in g_malloc (/lib64/libglib-2.0.so.0+0x57163)
>     #2 0xfffd6ec724d7 in g_strndup (/lib64/libglib-2.0.so.0+0x724d7)
>     #3 0xfffd6ec73d3f in g_strsplit (/lib64/libglib-2.0.so.0+0x73d3f)
>     #4 0xaaab66be5077 in main /mnt/sdc/qemu-master/qemu-4.2.0-rc0/vl.c:3517
>     #5 0xfffd6e140b9f in __libc_start_main (/lib64/libc.so.6+0x20b9f)
>     #6 0xaaab66bf0f53  (./build/aarch64-softmmu/qemu-system-aarch64+0x8a0f53)
> 
> Direct leak of 2 byte(s) in 2 object(s) allocated from:
>     #0 0xfffd700231cb in __interceptor_malloc (/lib64/libasan.so.4+0xd31cb)
>     #1 0xfffd6ec57163 in g_malloc (/lib64/libglib-2.0.so.0+0x57163)
>     #2 0xfffd6ec7243b in g_strdup (/lib64/libglib-2.0.so.0+0x7243b)
>     #3 0xfffd6ec73e6f in g_strsplit (/lib64/libglib-2.0.so.0+0x73e6f)
>     #4 0xaaab66be5077 in main /mnt/sdc/qemu-master/qemu-4.2.0-rc0/vl.c:3517
>     #5 0xfffd6e140b9f in __libc_start_main (/lib64/libc.so.6+0x20b9f)
>     #6 0xaaab66bf0f53  (./build/aarch64-softmmu/qemu-system-aarch64+0x8a0f53)
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
>  vl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/vl.c b/vl.c
> index 86474a55c9..2fa5cb3b9a 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3476,7 +3476,7 @@ int main(int argc, char **argv, char **envp)
>                              gchar **optname = g_strsplit(typename,
>                                                           ACCEL_CLASS_SUFFIX, 0);
>                              printf("%s\n", optname[0]);
> -                            g_free(optname);
> +                            g_strfreev(optname);
>                          }
>                          g_free(typename);
>                      }
> 

It is correct but could you try to cover all the cases?

For instance, there is another one in qga/main.c:split_list().

Thanks,
Laurent

