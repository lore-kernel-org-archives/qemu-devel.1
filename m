Return-Path: <SRS0=aRDT=W3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC42AC3A5A6
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 15:50:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A19F22D37
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 15:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKoKO/hx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A19F22D37
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i45eE-0005l3-Jt
	for qemu-devel@archiver.kernel.org; Sat, 31 Aug 2019 11:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51545)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1i45bj-0004hy-Fy
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 11:48:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1i45bh-0002QI-Vf
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 11:48:07 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:45370)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1i45be-0002Fw-2F
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 11:48:05 -0400
Received: by mail-oi1-x230.google.com with SMTP id v12so7592092oic.12
 for <qemu-devel@nongnu.org>; Sat, 31 Aug 2019 08:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ARv2VHQW/0W/uyIr+dLtYr09Qtbh1dea6S+ebOE/fJ0=;
 b=ZKoKO/hxaZy58OPbO98/iBR2A9DMk6Z5xXldlV98aZr2rDy2gvj0KT3aWPmlMDc7mJ
 tcKJHLcmivX2FOeGH8MUWS2jDLanMCuHWn7p3jchqkFNuCr0NGaEYBJMtAS2frV6bQLV
 z84PeRxEgM+VUHUPqA+hhhocVB4zox+OLDUG+cj6AMtQHImmii3RytMBJ+S7Pew+3b1z
 IeqwvSAlMMgegKqw1fghxfmvUwOjGMSelVcnXM46GKR/5Oic8k0DQwCJ/db7vBsH2MUp
 F+SGXTx5e76wo+CGLoOCVWGEEjrZqZ9Obli0C4x/587BHlsVA596OZ5it6cStNi4+GjS
 IBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ARv2VHQW/0W/uyIr+dLtYr09Qtbh1dea6S+ebOE/fJ0=;
 b=jQDSxYe4QvIj4WT1izVJpSMChDutmrjX3bxvO81Mm99E8er71EYL5hdrDF6WyDmDP+
 3jNhX7VJAp26Mi2h8KVSwV6EvOXY2rXvrvkdnP99SzAdn1s95CCjDWbuGLj9SrwygyJ9
 yKLYH17TheFrRsUwIYfkLhfBWWCL6ggt8X6/FApSI++XD76SXPkQH3dZYCJswyxgVERd
 NSO2bs+wpMaaksB07F5GF3EvpcgO6zs+JHjzFfVzokzUqI9qsaETfRjHatX2dsLCaGSF
 wRQ2QwIj+wm1H9qyW8puuVUgaaQNYvcuqWEvu/nOLoJeYlPwo0GwW4ArfvBLH8KJXyEf
 P82w==
X-Gm-Message-State: APjAAAXxbiM6xAe+jFo6b3GCTCqZkpfZNC3Gm3ADjE59xvHrsOcR0D5p
 2AFq5hVP1ZtduvwY1xG73l8byY2l8gVP3lq8wUU=
X-Google-Smtp-Source: APXvYqxrxXRApoIfxbbpINlBDqPAygWXE91l6+ufAqrmeP+/wjIzVrygLa9IchgcDL5hPt6Tr5CpcKvUmvhkJSN9BP8=
X-Received: by 2002:aca:4b88:: with SMTP id
 y130mr14502929oia.157.1567266476448; 
 Sat, 31 Aug 2019 08:47:56 -0700 (PDT)
MIME-Version: 1.0
References: <7d22c299-29fe-8479-ee14-17d521bb9d6b@huawei.com>
In-Reply-To: <7d22c299-29fe-8479-ee14-17d521bb9d6b@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Sat, 31 Aug 2019 23:47:20 +0800
Message-ID: <CAKXe6SL+LC4RVRy+4oAKnuS=qMFDG4A0iyoL0hqg_f76gSrmBA@mail.gmail.com>
To: fangying <fangying1@huawei.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::230
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

fangying <fangying1@huawei.com> =E4=BA=8E2019=E5=B9=B48=E6=9C=8831=E6=97=A5=
=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=888:45=E5=86=99=E9=81=93=EF=BC=9A

> Hi Gerd,
>
> Memory leak is observed in zrle_compress_data when we are doing some
> AddressSanitizer tests. The leak stack is as bellow:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D47887=3D=3DERROR: LeakSanitizer: detected memory leaks
>
> Direct leak of 29760 byte(s) in 5 object(s) allocated from:
>      #0 0xffffa67ef3c3 in __interceptor_calloc
> (/lib64/libasan.so.4+0xd33c3)
>      #1 0xffffa65071cb in g_malloc0 (/lib64/libglib-2.0.so.0+0x571cb)
>      #2 0xffffa5e968f7 in deflateInit2_ (/lib64/libz.so.1+0x78f7)
>      #3 0xaaaacec58613 in zrle_compress_data ui/vnc-enc-zrle.c:87
>      #4 0xaaaacec58613 in zrle_send_framebuffer_update
> ui/vnc-enc-zrle.c:344
>      #5 0xaaaacec34e77 in vnc_send_framebuffer_update ui/vnc.c:919
>      #6 0xaaaacec5e023 in vnc_worker_thread_loop ui/vnc-jobs.c:271
>      #7 0xaaaacec5e5e7 in vnc_worker_thread ui/vnc-jobs.c:340
>      #8 0xaaaacee4d3c3 in qemu_thread_start util/qemu-thread-posix.c:502
>      #9 0xffffa544e8bb in start_thread (/lib64/libpthread.so.0+0x78bb)
>      #10 0xffffa53965cb in thread_start (/lib64/libc.so.6+0xd55cb)
>
> This leak stack can be easily reproduced in the case that a client
> repeatedly
> does vnc connect/disconnect .
>
> To get the leak stack, we can compile qemu with
> --extra-ldflags=3D-Wl,--build-id -Wl,-z,relro -Wl,-z,now -lasan'
> '--extra-cflags=3D-O0 -g -fno-omit-frame-pointer -fno-stack-protector
> -fsanitize=3Daddress -fsanitize=3Dleak' using gcc that supports asan.
>
> It is obvious that there may be memory leak in the zlib/zrle compress
> stuff.
> IIUC, *deflateInit2* is called with the local VncState vs->zrle.stream
> when a
> client is connected the vnc server. And then *deflate* is called to do th=
e
> encoding. Finally *deflateEnd* is called in vnc_zrle_clear when a
> connection is
> closed.
>
> I had not think it out why this memory leak could happen here.
> It is noticed that deflateInit2 is called with the local vs,
> however deflateEnd is called with the origin vs.
> The local vs is copied to the origin vs in vnc_async_encoding_start and
> vnc_async_encoding_end on the contrary.
>
> Have you got any idea on this issue ?
>
>
Hello Ying,

I have posted a patch for this issue:
--> https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg06675.html

Please check whether the patch can address this issue.

Thanks,
Li Qiang





> Thanks.
> Ying Fang
>
>
>
