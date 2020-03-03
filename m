Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16819C3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:19:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E603A21556
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E603A21556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j94eY-0001my-0W
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 05:19:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53611)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j94ZH-0007DM-12
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:14:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j94ZF-00086Q-O8
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:14:26 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:34387)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j94ZC-00084k-ST; Tue, 03 Mar 2020 05:14:23 -0500
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MxmBi-1jIdMZ1gPm-00zCId; Tue, 03 Mar 2020 11:14:05 +0100
To: pannengyuan@huawei.com, pbonzini@redhat.com, rth@twiddle.net,
 ehabkost@redhat.com
References: <20200224065139.19567-1-pannengyuan@huawei.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH] target/i386/hax-posix: fix two 'format-truncation'
 compile warnings
Message-ID: <e87fbecb-c6fe-e491-76e8-166e15ef977b@vivier.eu>
Date: Tue, 3 Mar 2020 11:14:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224065139.19567-1-pannengyuan@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:5utFFIHBMVS12Kl97i78VWq8aUKOSVd0LQiHwWbxuyMRUkhK1E4
 X+HsEputhpSoUUOtrIjM7W7yI2tualzn4EOiT9nXB67jfL8ErIf84bWItcqJGNNdKaEC/JF
 EansI4AziWXVoghA+/UWrtG5l4LMjSQ2DPNxr4FX1FCLQyz/uQDpUTDykZ69Ji65pbSwM7B
 y3Cham4w9kFbtptqoAohg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hf1Pri22ruo=:S+Ut91An+NgCQxw6hnFQPF
 VvsvGlLia/kVmbca3POu7WJKHyi+VgBLLKmn34icBGAaHo1DfEblF79OjQXD6C+M8a4HyvkM0
 6OSUM+yg8gHsWI6sV6p/o1uahjsleDYyPGVN2XsiVxUkmDjewhFeC4W1cFELydy3pUpT8qfUt
 34DduONMbEbYE/mAPF8DHGIHa1YNENDQ+v+YdRRJBIewTYc7eVdPFsqmGgSNl8neSUAW6yMEQ
 U/GeOoac4bqsjomYG4jaGAN7RKUE/ZdYsPxQjJqvioN38y6chHGBC4BlVOMguJ4XBttyQ+uKT
 q9UrPU2XdTAn2P6nU5vok1DdC5rPctAGqQMdnxGyCfk3UGkrGj2IQwDSN9sq/SZgnsTv7zVmL
 ADqOAZhZCG+EAtstMlFEN7fw4R5NSJdJCEvNUtVdyO/hEjY+QkNkjRedzIEiLpFSOK5DY+Umj
 s3fvyF1NYiQUfAVFMt85BMUblPNwQuk2E22i/h1hk18epuTv3BNcmBYlwz5EfZM5Ln1XIu73o
 ZyPEI8OXcRmCoxdTh9jXrFOFqqh6hwXO0dTaT0We4dIowAd2xnnYZKbIRqEmC075V9eq+bMXh
 76wL8lxfs51wg7XmGWk9JhKip1P5C6E1TS7z2JinGW2CPomFUlg6Auvrh/WqT1wgSOwofmN1z
 5OT3z8h7BohmIf3KyTmi9gz0YKDaU87e4AxOcaIntgphmGFKR6kO+AmEmJ5dzXcBR/6Ndn4Gq
 nDnifJjOFfI76LY85sjy/OGsGmFuYC//MCoOOBaLX7ndDfc88rT+7RtdqOKtIkcHQ3rmHm1vR
 FGhxwclZbccRPycn9GdhurW1caEseqbJmmIl7d6j3CWigT25ePHALosGteRa3Gpp2EbZzfq
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
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
 qemu-devel@nongnu.org, euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 24/02/2020 à 07:51, pannengyuan@huawei.com a écrit :
> From: Pan Nengyuan <pannengyuan@huawei.com>
> 
> Fix compile warnings:
> /mnt/sdb/qemu-new/qemu_test/qemu/target/i386/hax-posix.c:124:56: error: ‘%02d’ directive output may be truncated writing between 2 and 11 bytes into a region of size 3 [-Werror=format-truncation=]
>      snprintf(name, sizeof HAX_VM_DEVFS, "/dev/hax_vm/vm%02d", vm_id);
>                                                         ^~~~
> /mnt/sdb/qemu-new/qemu_test/qemu/target/i386/hax-posix.c:124:41: note: directive argument in the range [-2147483648, 64]
>      snprintf(name, sizeof HAX_VM_DEVFS, "/dev/hax_vm/vm%02d", vm_id);
>                                          ^~~~~~~~~~~~~~~~~~~~
> In file included from /usr/include/stdio.h:873,
>                  from /mnt/sdb/qemu-new/qemu_test/qemu/include/qemu/osdep.h:99,
>                  from /mnt/sdb/qemu-new/qemu_test/qemu/target/i386/hax-posix.c:14:
> /usr/include/bits/stdio2.h:67:10: note: ‘__builtin___snprintf_chk’ output between 17 and 26 bytes into a destination of size 17
>    return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         __bos (__s), __fmt, __va_arg_pack ());
>         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /mnt/sdb/qemu-new/qemu_test/qemu/target/i386/hax-posix.c: In function ‘hax_vcpu_devfs_string’:
> /mnt/sdb/qemu-new/qemu_test/qemu/target/i386/hax-posix.c:143:55: error: ‘%02d’ directive output may be truncated writing between 2 and 11 bytes into a region of size 10 [-Werror=format-truncation=]
>      snprintf(name, sizeof HAX_VCPU_DEVFS, "/dev/hax_vm%02d/vcpu%02d",
>                                                        ^~~~
> /mnt/sdb/qemu-new/qemu_test/qemu/target/i386/hax-posix.c:143:43: note: directive argument in the range [-2147483648, 64]
>      snprintf(name, sizeof HAX_VCPU_DEVFS, "/dev/hax_vm%02d/vcpu%02d",
>                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~
> /mnt/sdb/qemu-new/qemu_test/qemu/target/i386/hax-posix.c:143:43: note: directive argument in the range [-2147483648, 64]
> In file included from /usr/include/stdio.h:873,
>                  from /mnt/sdb/qemu-new/qemu_test/qemu/include/qemu/osdep.h:99,
>                  from /mnt/sdb/qemu-new/qemu_test/qemu/target/i386/hax-posix.c:14:
> /usr/include/bits/stdio2.h:67:10: note: ‘__builtin___snprintf_chk’ output between 21 and 39 bytes into a destination of size 21
>    return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         __bos (__s), __fmt, __va_arg_pack ());
> 
> We know that we have checked the vm_id and vcpu_id in the first(less than 0x40), it will never be truncated in snprintf().
> Thus, this patch add an assertion to clear this false-positive warning.
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
>  target/i386/hax-posix.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/hax-posix.c b/target/i386/hax-posix.c
> index a5426a6dac..197d5bc0f9 100644
> --- a/target/i386/hax-posix.c
> +++ b/target/i386/hax-posix.c
> @@ -121,7 +121,8 @@ static char *hax_vm_devfs_string(int vm_id)
>          return NULL;
>      }
>  
> -    snprintf(name, sizeof HAX_VM_DEVFS, "/dev/hax_vm/vm%02d", vm_id);
> +    int len = snprintf(name, sizeof HAX_VM_DEVFS, "/dev/hax_vm/vm%02d", vm_id);
> +    assert(len < sizeof HAX_VM_DEVFS);
>      return name;
>  }
>  
> @@ -140,8 +141,9 @@ static char *hax_vcpu_devfs_string(int vm_id, int vcpu_id)
>          return NULL;
>      }
>  
> -    snprintf(name, sizeof HAX_VCPU_DEVFS, "/dev/hax_vm%02d/vcpu%02d",
> -             vm_id, vcpu_id);
> +    int len = snprintf(name, sizeof HAX_VCPU_DEVFS, "/dev/hax_vm%02d/vcpu%02d",
> +                       vm_id, vcpu_id);
> +    assert(len < sizeof HAX_VCPU_DEVFS);
>      return name;
>  }
>  
> 

You should check instead that vm_id and vcpu_id are >= 0 where they are
checked to be <= MAX_VM_ID and MAX_VCPU_ID, this will avoid the overflow
of "%02d" and should remove the compile warning.

Thanks,
Laurent

