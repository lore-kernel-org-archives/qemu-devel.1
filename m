Return-Path: <SRS0=Jh9c=W4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336CDC3A5A4
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 14:45:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECDB521872
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 14:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/bUQEjM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECDB521872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4R6e-0003CG-1P
	for qemu-devel@archiver.kernel.org; Sun, 01 Sep 2019 10:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1i4R5Z-0002dJ-Mr
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 10:44:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1i4R5Y-0005e4-0X
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 10:44:21 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:43960)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1i4R5X-0005c7-Od
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 10:44:19 -0400
Received: by mail-oi1-x22e.google.com with SMTP id y8so8746112oih.10
 for <qemu-devel@nongnu.org>; Sun, 01 Sep 2019 07:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cKMltYeBi6dzYKA5CbWu6tyUS+T0ysZLFaTPqlj9B7k=;
 b=m/bUQEjM0WoSarXjH8xKx8iYGeLB9Psq7SBfKtRnXXQ9+Yo4g2tc5yvv1rAem1CP/I
 UuOoXdSzLQayVRGuHtOYc3SDiqxIzPu1/u0+d9BCe4pm51u44u1soJe+W0hFVAw1IxQw
 JeUDhmnxbgu2wF0MtZT2A5XDoYwwmqIafbP2mDHRBTJyQh0ZPcRWS1gKEWJGgygCwmB2
 mJCXY+nbSxSX/58FVodBuB14BxUP669a3q49I4jtFK57m/+YhqzCy9h1pnuhjNarKMzt
 ZDTRHBy6+ScPEYdxRqQdZgSm/YrPcfDkESj4Nn/SFyFwsABfSOz1hsLJIoqqYoCJCvKh
 9IKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cKMltYeBi6dzYKA5CbWu6tyUS+T0ysZLFaTPqlj9B7k=;
 b=t1x6YQE7U5FUkvo+a8DJHUoswrR1+W6JMqj/GE52qq0C/QqTETlF3vpEcoKFG8Rb1I
 syabbDZXyuJonvOPFpnnLldoI0VkgK+VDpkLCUZB+xl1UOruHgMDXxvr7CQj6dx6EaO7
 kRZeloyXPWNq4DuRpYK617+xQBaaqlWoRbG0dtIIH1HcllSF1hI0nHWbC/pqrgnvm3AQ
 HOHBFr6v8p2zKZE8zOcb9gq78pZQE7t7+ysWNgzNLrhNQ7a4YHWAePHSPV7Z1IuHM63K
 hlN3dBIo/5XWaileUz+sTc8PwuVSy+BgFSTC1KKgErchmlXY7BwgiNNWCz7b1SNzPup9
 JSMg==
X-Gm-Message-State: APjAAAUQnztgdF9rLEaR8hVf0KFQtcgNIRJ014CCCR4H7KZB8nCLsmoF
 Ob3KUN4k8DV8SvmMisOzNLntL1GUjwaBFczRg6o=
X-Google-Smtp-Source: APXvYqwHVJmqan3EWU/xxER7Lg1PbPJ2zQcWSQ/tCvRK3vt/4p9eNqVIk0wx7zwO0xX0FP4T8WIOt/kL4vzdVGMhfcI=
X-Received: by 2002:aca:1a08:: with SMTP id a8mr15957107oia.150.1567349058698; 
 Sun, 01 Sep 2019 07:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <7d22c299-29fe-8479-ee14-17d521bb9d6b@huawei.com>
 <CAKXe6SL+LC4RVRy+4oAKnuS=qMFDG4A0iyoL0hqg_f76gSrmBA@mail.gmail.com>
 <43E932EA88344C498D975E4FF00CF41E2EAB29A5@dggeml529-mbx.china.huawei.com>
In-Reply-To: <43E932EA88344C498D975E4FF00CF41E2EAB29A5@dggeml529-mbx.china.huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Sun, 1 Sep 2019 22:43:42 +0800
Message-ID: <CAKXe6SJB4fc_2a0gz8JJ_LD6Qh65DDXaFVhJSspTHQxxn4=UQg@mail.gmail.com>
To: fangying <fangying1@huawei.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] Discussion: vnc: memory leak in zrle_compress_data
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, zhouyibo <zhouyibo3@huawei.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

fangying <fangying1@huawei.com> =E4=BA=8E2019=E5=B9=B49=E6=9C=881=E6=97=A5=
=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=888:29=E5=86=99=E9=81=93=EF=BC=9A

> Nice work, your patch does fix this issue in my test.
>
> I think we should make VncState.zlib to be a pointer type as well.
>
> Since we are going to use pointers instead of copy, we must make sure tha=
t
> there=E2=80=99s no race condition of pointer members between the local vs=
 (vnc
> worker thread) and origin vs (main thread).
>
>

Yes, there is a race between the main thread and vnc thread. Maybe we
should add a lock just like the 'vs->output_mutex'.
Let's wait for Gerd's (or others) comments whether there is a better way
than using pointer before sending the revision.

Thanks,
Li Qiang


>
> Thanks.
> Ying Fang
> *=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A *Li Qiang<liq3ea@gmail.com>
> *=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A *fangying<fangying1@huawei.com>
> *=E6=8A=84=E9=80=81=EF=BC=9A *Gerd Hoffmann<kraxel@redhat.com>;qemu-devel=
<qemu-devel@nongnu.org>;Daniel
> P. Berrange<berrange@redhat.com>;zhouyibo<zhouyibo3@huawei.com>
> *=E4=B8=BB=E9=A2=98=EF=BC=9A *Re: [Qemu-devel] Discussion: vnc: memory le=
ak in zrle_compress_data
> *=E6=97=B6=E9=97=B4=EF=BC=9A *2019-08-31 23:48:10
>
>
>
> fangying <fangying1@huawei.com> =E4=BA=8E2019=E5=B9=B48=E6=9C=8831=E6=97=
=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=888:45=E5=86=99=E9=81=93=EF=BC=9A
>
>> Hi Gerd,
>>
>> Memory leak is observed in zrle_compress_data when we are doing some
>> AddressSanitizer tests. The leak stack is as bellow:
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> =3D=3D47887=3D=3DERROR: LeakSanitizer: detected memory leaks
>>
>> Direct leak of 29760 byte(s) in 5 object(s) allocated from:
>>      #0 0xffffa67ef3c3 in __interceptor_calloc
>> (/lib64/libasan.so.4+0xd33c3)
>>      #1 0xffffa65071cb in g_malloc0 (/lib64/libglib-2.0.so.0+0x571cb)
>>      #2 0xffffa5e968f7 in deflateInit2_ (/lib64/libz.so.1+0x78f7)
>>      #3 0xaaaacec58613 in zrle_compress_data ui/vnc-enc-zrle.c:87
>>      #4 0xaaaacec58613 in zrle_send_framebuffer_update
>> ui/vnc-enc-zrle.c:344
>>      #5 0xaaaacec34e77 in vnc_send_framebuffer_update ui/vnc.c:919
>>      #6 0xaaaacec5e023 in vnc_worker_thread_loop ui/vnc-jobs.c:271
>>      #7 0xaaaacec5e5e7 in vnc_worker_thread ui/vnc-jobs.c:340
>>      #8 0xaaaacee4d3c3 in qemu_thread_start util/qemu-thread-posix.c:502
>>      #9 0xffffa544e8bb in start_thread (/lib64/libpthread.so.0+0x78bb)
>>      #10 0xffffa53965cb in thread_start (/lib64/libc.so.6+0xd55cb)
>>
>> This leak stack can be easily reproduced in the case that a client
>> repeatedly
>> does vnc connect/disconnect .
>>
>> To get the leak stack, we can compile qemu with
>> --extra-ldflags=3D-Wl,--build-id -Wl,-z,relro -Wl,-z,now -lasan'
>> '--extra-cflags=3D-O0 -g -fno-omit-frame-pointer -fno-stack-protector
>> -fsanitize=3Daddress -fsanitize=3Dleak' using gcc that supports asan.
>>
>> It is obvious that there may be memory leak in the zlib/zrle compress
>> stuff.
>> IIUC, *deflateInit2* is called with the local VncState vs->zrle.stream
>> when a
>> client is connected the vnc server. And then *deflate* is called to do
>> the
>> encoding. Finally *deflateEnd* is called in vnc_zrle_clear when a
>> connection is
>> closed.
>>
>> I had not think it out why this memory leak could happen here.
>> It is noticed that deflateInit2 is called with the local vs,
>> however deflateEnd is called with the origin vs.
>> The local vs is copied to the origin vs in vnc_async_encoding_start and
>> vnc_async_encoding_end on the contrary.
>>
>> Have you got any idea on this issue ?
>>
>>
> Hello Ying,
>
> I have posted a patch for this issue:
> --> https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg06675.html
>
> Please check whether the patch can address this issue.
>
> Thanks,
> Li Qiang
>
>
>
>
>
>> Thanks.
>> Ying Fang
>>
>>
>>
