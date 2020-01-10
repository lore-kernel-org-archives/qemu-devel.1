Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729EEC33CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 09:57:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4489B20721
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 09:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4489B20721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43335 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipr2g-0005Lj-GS
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 04:57:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1ipqzQ-0001Sj-4c
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 04:54:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ipqzO-0001uY-Vr
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 04:53:59 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:32903)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1ipqzL-0001ab-N9; Fri, 10 Jan 2020 04:53:55 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MXYEr-1jBYb20Dst-00YyFv; Fri, 10 Jan 2020 10:53:43 +0100
Subject: Re: [PATCH] vl: Don't mismatch g_strsplit()/g_free()
To: pannengyuan@huawei.com, pbonzini@redhat.com
References: <20200110031618.23332-1-pannengyuan@huawei.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <87099d30-f067-a954-083c-92fab9c44831@vivier.eu>
Date: Fri, 10 Jan 2020 10:53:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200110031618.23332-1-pannengyuan@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:a3dfz69LVj9CiAWgrxlaRPBLGmkg4NpM4Fwrt5o/dOJ63uFhycy
 vRT+vFYf2gzWciYMnq9UYVB2mOyACIVrIfGygeU79e56aVL3LLsb6pmu2Vp/z6e+IKcm6b+
 YNQbXJLxYO8sDuILRjY5DNctYtHMs/9kHp41eKOMH0/yEUe3FoDR2NJ9/0DSkfTMU+rYIU5
 jdXQ0rRZCuoyzz7T58eKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r5gLOHXYj+Y=:Fd+byl8deEZfE+cWvXH9sp
 p3hzF2sH6Gw8KqenxOu5K9g2nDoqYiSbyJkTj8oK4Dpsz1MuGGDGXhAO08/Ao7mkw04/c0YJy
 nspM0+hlyw5nzQs4ITfMbxyBUEc8zU/fjwo2TK/TPf8/hXI8MO+l5QA1lAE+f/8wv7knVVtGN
 f/PDF95HbzmCABe/CAwe6HARi3+8iJ6meO7HnWuLoGwF71yDuOJMK5kSifLrWF3sh5p8/YJ3s
 QmRdjNhZ/L63YvgNz1ScH8vZ/87+wNlno5SaMvkaoQ8/oup0i7IoXXg/OW9T/fbNDehmH35lN
 P0pOGdMDiFa1QRAc3S7RWgOVLM+mz7d8K2Zko1MjH5Z/hu++eBbZGaGS0FsChBS04c40Y4kCF
 mAl85yezoDqb2APfeJ7l7+tyP/cuxV9cC0Vtx2ruiMsJHeOaauyL8BuOeLzfZ1Bb2ng/Wxux2
 wUAQdofJkcIBCbXVm57nmRa9bczewUhpWEY9XjpCzsL4lJIBIe814koZ3nFvkFUhdNymR+tht
 Xbysz3hGQuahrpMPkeSt+CelFy0yUF2nxH1Psc30IwbyWKZaXjwhqOlrv0sDbi+wpffU1LlIw
 a+w8IbigcueItXjbHVj6RhekmsVgJpci/AJfJMPtv5JsWCKrqD6lFzUB0niwpVoxEBTYZwF2z
 97MnzKFS22ino+OSd6Joe4wKAy4MG84WW+yYqx+vUBsWfHIkZGB/r/GftWMXn0pZdvS02xVKi
 E93qP8r+XyRJ9+efA/P+4T+wORBrDutzdVq9iWCpmBhIQC0EJju6Puqk7d2ZqBI1OgCvqpOAn
 Y5Q0Oz0396Mw7VQkFi/f07d4225/PH21spoHhSUH0ujBoAWgEpyv2H590fmNBcs4RmX0XB6Z4
 53HpGYv4Tn0T6FBFp4Yb3i8tchjUNfDeRrJZwn+G8=
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

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

