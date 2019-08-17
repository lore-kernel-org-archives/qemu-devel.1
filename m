Return-Path: <SRS0=glhp=WN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D162DC3A59B
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 16:24:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A67332184B
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 16:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A67332184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hz1Un-00050g-Mw
	for qemu-devel@archiver.kernel.org; Sat, 17 Aug 2019 12:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1hz1U9-0004ZV-C5
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 12:23:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hz1U8-0005Al-3r
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 12:23:21 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:39685)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1hz1U4-00057Y-Sz; Sat, 17 Aug 2019 12:23:17 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MMH2M-1hj9Hl3Ijm-00JFel; Sat, 17 Aug 2019 18:22:56 +0200
To: David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Cornelia Huck <cohuck@redhat.com>,
 qemu-s390x <qemu-s390x@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <8fb538f3-dfdd-b427-727a-2e7c2120da09@gmail.com>
 <20e800e8-846b-a9c3-f840-826238b0818f@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f94cb9f0-32cb-9fad-dff1-5e3261d3bfb6@vivier.eu>
Date: Sat, 17 Aug 2019 18:22:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20e800e8-846b-a9c3-f840-826238b0818f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0dalZ+hwMpq93PxUnKLXZG07ICYXttEFHIKGQHoskSYanOWqxxj
 p5m/8fPWZQW32lxmKWig/7Pznwpgp5JCkWiWdZ5naXZEvo70x9jOtfNpaofmlPjqcsYQzqw
 JbMGbgv8OzoCKppT76v+CmhPw74COI5NnFVnIorwuiUqPaK9DozD64yqN8z2DSVd8g/fS0D
 9GGEILjRjcwO6BXId+FCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:o3WFVcHHqaA=:BnUyj+EXFkL3BtueyLSm5r
 ahFzg2A08gtz1V4Bt9zv4heOcEGJ/bTbb/q2C28mqYw4pBHg1iMFFVTW+rRFDTN9N6IKJiKzV
 E59/5FicsSrR5guAvXIls/EVBo+f1bY50xeWXUFe8n2GaZ2nLR0KZGH3d+nPI0mN+4Cr+wFn7
 YVk/YSP0u4T7UdGchoyfbvHholF3xIh4otgg17sRqu8n/G02mV6p+VRcR2e5fA/I9aoIlb5aB
 PKbX1rkX6ktJqAlObCa3kER4hXGuu7xo6gpZML3xqCyt6hKHuvnX729+jVAYq/mOXxu5V893k
 f6YgjoIYXB0uf9nqYOtTLv7rxU4UhEJwpPumrcP5CEHbH0Yj0wLPQaXYb3mxdR/7kDbIPL++T
 RPEsD3UegapUcaKaW0eB7BvWYzvINDJo/0I4qE+IJe6SXnXjtUUd39iwGj3mpUncJzlbzO32e
 HjSlBrNMxQ01kufGgtAHMupJg6rK8z4FZjMYgJHoBOgeRKqZPhl204XN5W4iMjhbubehW5zrf
 V4GhkUS+YCxdVYH5ok5qrDKyHEOMhewGzObxv3oGfN1rrO96ZPKqcHYZ9Ux+WnCbhCTJ2ikH7
 BTNzqgEAP98toYEXvMg1biN1+pGPp5MkaxJp0tWjfkw+zIdsln5t/rfjTFPt2/PTYuMD8vllt
 9S/JtulrwI/uuXxaC9T+pgiz2K0SEqlOwelBcEvDyBcgaiOeDXnTn8gL+/iXv8IhXZ31o9492
 pndoE72GetHLrY7B5HK/clMrHdlVFvztSgxBPy8C7tNN5SHMIb7COo5V6AA=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
Subject: Re: [Qemu-devel] [qemu-s390x] linux-user: s390x issue on Fedora 30
 (dynamic library loader?)
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 17/08/2019 à 18:14, David Hildenbrand a écrit :
> On 17.08.19 17:59, David Hildenbrand wrote:
>> Hi everybody,
>>
>> I was just trying to run qemu-s390x (linux-user) with a very simple
>> binary (gzip + lib/ld64.so.1, compiled under Fedora 27). This used to
>> work just fine a while ago (especially when I was working on vector
>> instructions using QEMU v3.1). However, now I can't get past a SEGFAULT
>> in the dynamic library loader (I assume it is trying to locate glibc). I
>> tried a couple of other binaries that definitely used to work (from
>> Fedora 30).
>>
>> I checked QEMU v4.1, v4.0 and v3.1. All are broken for me. Which is
>> weird - because it used to work :/
>>
>> I remember that I was running Fedora 29 the last time I had it running,
>> so my gut feeling is that this is related to some other system library
>> (but which?). I am running on an up-to-date Fedora 30 x86-64 now.
>>
>> Any ideas? Has this been reported already? (not sure if this is a Fedora
>> 30 issue)
>>
>> LANG=C ~/git/qemu/s390x-linux-user/qemu-s390x -d in_asm -L . gzip --help
>>
>> ----------------
>> IN: _dl_load_cache_lookup
>> 0x00000040008854c2:  larl       %r1,0x4000895030
>> 0x00000040008854c8:  lg %r8,264(%r11)
>> 0x00000040008854ce:  mvghi      0(%r1),-1
>> 0x00000040008854d4:  la %r3,0(%r3,%r8)
>> 0x00000040008854d8:  l  %r7,12(%r8)
>> 0x00000040008854dc:  llgfr      %r2,%r7
>> 0x00000040008854e0:  sllg       %r1,%r2,1
>> 0x00000040008854e6:  agr        %r1,%r2
>> 0x00000040008854ea:  sllg       %r1,%r1,2
>> 0x00000040008854f0:  la %r6,16(%r1,%r8)
>> 0x00000040008854f4:  sgr        %r3,%r6
>> 0x00000040008854f8:  stg        %r3,256(%r11)
>> 0x00000040008854fe:  ahi        %r7,-1
>> 0x0000004000885502:  jl 0x40008850f0
>>
>> ----------------
>> IN: _dl_load_cache_lookup
>> 0x0000004000885506:  srak       %r10,%r7,1
>> 0x000000400088550c:  lgfr       %r2,%r10
>> 0x0000004000885510:  sllg       %r1,%r2,1
>> 0x0000004000885516:  agr        %r1,%r2
>> 0x000000400088551a:  sllg       %r1,%r1,2
>> 0x0000004000885520:  l  %r1,20(%r1,%r8)
>> 0x0000004000885524:  clrjhe     %r1,%r3,0x40008850f0
>>
>> Segmentation fault (Speicherabzug geschrieben)
>>
>>
>> Core was generated by
>> `/home/dhildenb/git/qemu/s390x-linux-user/qemu-s390x -d in_asm -L . gzip
>> --help'.
>> Program terminated with signal SIGSEGV, Segmentation fault.
>> #0  0x00007fdc5d7c3232 in sigsuspend () from /lib64/libc.so.6
>> [Current thread is 1 (Thread 0x7fdc5d7127c0 (LWP 31072))]
>> Missing separate debuginfos, use: dnf debuginfo-install
>> glib2-2.60.6-1.fc30.x86_64 glibc-2.29-15.fc30.x86_64
>> libgcc-9.1.1-1.fc30.x86_64 libstdc++-9.1.1-1.fc30.x86_64
>> pcre-8.43-2.fc30.x86_64 zlib-1.2.11-16.fc30.x86_64
>> (gdb) bt
>> #0  0x00007fdc5d7c3232 in sigsuspend () from /lib64/libc.so.6
>> #1  0x000055f826135a9c in dump_core_and_abort
>> (target_sig=target_sig@entry=11)
>>     at /home/dhildenb/git/qemu/linux-user/signal.c:613
>> #2  0x000055f826135e37 in handle_pending_signal
>> (cpu_env=cpu_env@entry=0x55f8292cec48, sig=sig@entry=11,
>>     k=k@entry=0x55f8292d7df0) at
>> /home/dhildenb/git/qemu/linux-user/signal.c:877
>> #3  0x000055f826136edd in process_pending_signals
>> (cpu_env=cpu_env@entry=0x55f8292cec48)
>>     at /home/dhildenb/git/qemu/linux-user/signal.c:953
>> #4  0x000055f82613a13a in cpu_loop (env=0x55f8292cec48) at
>> /home/dhildenb/git/qemu/linux-user/s390x/cpu_loop.c:150
>> #5  0x000055f8260ce2ba in main (argc=<optimized out>,
>> argv=0x7fff587a69d8, envp=<optimized out>)
>>     at /home/dhildenb/git/qemu/linux-user/main.c:819
>>
>> Thanks!
>>
> 
> CCing QEMU-devel + use my proper dev mail address (I need more coffee :))
> 

I generally test qemu-s390x before my PR. Last time, I have tested with
Fedora 30 x86_64 but my target are always debian.

So I guess the problem is with the target.

I will have a look on Monday.

Thanks,
Laurent

