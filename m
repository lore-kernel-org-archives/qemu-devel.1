Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44826C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 20:49:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D4692078B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 20:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZjmTm41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D4692078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDDDT-00089o-6p
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 16:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDDCB-0007Cm-65
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 16:47:59 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c]:33999)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDDC8-0007Do-Th
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 16:47:58 -0400
Received: by mail-lj1-x22c.google.com with SMTP id v23so3230896ljd.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 13:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:reply-to:from:date:message-id:subject:to;
 bh=v3+jqCs/Aq1vw6JbdI2A6pBjc/iKFUT7xhd8vqv3j04=;
 b=bZjmTm41va1P9c0Y1d8AM+v18NQlyuxHWRwIOlQhXsAvqbrLzF5EOnHV6vDwlxAB5e
 VG5CzyBiFDKduYTDFE3PN6q+sAeDMUacPxSlw5T+zKoLl0U+1jVKvSPa3j9EmxuDUD0B
 jut8uJnahnErTqUiL7AwWL9TmaAZFH7/Li1mfYiwK1KJv2YYvMDan3vqJwndXg487JMd
 YLn0kqB3URItazS7KT4yIlIYNlni+AjOJhG57GipQNA7c1DCy+npPwxld3CdSVC5ZjSq
 b+ZoxWTKap4QIVNKQh8ezHb8XbIVv2z9seR2+cTn3ojuXJaos6S9XoOFieXv2xem+aqX
 AuYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:reply-to:from:date:message-id
 :subject:to;
 bh=v3+jqCs/Aq1vw6JbdI2A6pBjc/iKFUT7xhd8vqv3j04=;
 b=IZFEbOzok0Z6RqR+OZ3g6S/MRVxvGwbWc4r2PJM7W/bhtP5s5buyXxpz1CrGDdmFgT
 ZuENloaBIon09FT6Vkh5zTUoL30Nx5zOXinEE63LcoQ5BKdYIY0PPj1iaHBo2ZKvlLaV
 scjETRudAJm15+Vc6fQagb2gLNnhLflVVVEb4+cZAnKZSDyAzYt9dPoct910o1W5ca5U
 dOyBrZfdYIT15vyPlnv2gKjdgZvojs4FYpXCgrTPQ/5oRar8XcWzDPU/rEMrRJcSmjNa
 vb2QSaqWUb/9GTi4nuozUEv/7dxXtrG4Q8dPyiC7BwwUkIk7lLEXT0BWXqVVOSndc7W1
 6PhQ==
X-Gm-Message-State: AOAM530OFhpYvgcGBJh8wlR2hHk1Bf0vx6zURcfqx6XlMWK7MZwm2/1e
 Yn79lZveCGc3NGkDkWhGNXK3ZvdIfs3jSyV74dqdAuQMccmcZg==
X-Google-Smtp-Source: ABdhPJzdfXuej9omPOROCfSYdSKS6O9L3DGceuvi3R0dYSq9WMF6phswuk/BIZmpw9ERFDTiSaiHeYO5NhveUoo3Z58=
X-Received: by 2002:a05:651c:151:: with SMTP id
 c17mr1633100ljd.467.1598993274228; 
 Tue, 01 Sep 2020 13:47:54 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 2 Sep 2020 04:47:41 +0800
Message-ID: <CAE2XoE_SkH-2dNULFAZNiRNRNP=OncwCy=xrDk0J3bzS1Th=tg@mail.gmail.com>
Subject: Cirrus CI for msys2 are working now, but still buiding failed
To: qemu-level <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000001bd6de05ae46a2c7"
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x22c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001bd6de05ae46a2c7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

https://cirrus-ci.com/task/6375504892657664


failed with:
```

Compiling C object
libqemu-s390x-softmmu.fa.p/meson-generated_.._trace_generated-helpers.c.obj
Compiling C object
libqemu-s390x-softmmu.fa.p/meson-generated_.._qapi_qapi-events.c.obj
Compiling C object
libqemu-s390x-softmmu.fa.p/meson-generated_.._qapi_qapi-emit-events.c.obj
Linking static target libblock.fa
Linking target qemu-system-aarch64.exe
Linking target qemu-system-aarch64w.exe
Linking target qemu-system-alpha.exe
Linking target qemu-system-alphaw.exe
Linking target qemu-system-arm.exe
Linking target qemu-system-armw.exe
Linking target qemu-system-avr.exe
Linking target qemu-system-avrw.exe
C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../.=
./x86_64-w64-mingw32/bin/ld.exe:
cannot find -lfdt
C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../.=
./x86_64-w64-mingw32/bin/ld.exe:
cannot find -lfdt
C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../.=
./x86_64-w64-mingw32/bin/ld.exe:
cannot find -lfdt
C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../.=
./x86_64-w64-mingw32/bin/ld.exe:
cannot find -lfdt
collect2.exe: error: ld returned 1 exit status
collect2.exe: error: ld returned 1 exit status
collect2.exe: error: ld returned 1 exit status
collect2.exe: error: ld returned 1 exit status
make: *** [Makefile.ninja:2258: qemu-system-avr.exe] Error 1
make: *** Waiting for unfinished jobs....
make: *** [Makefile.ninja:1970: qemu-system-alpha.exe] Error 1
make: *** [Makefile.ninja:2260: qemu-system-avrw.exe] Error 1
make: *** [Makefile.ninja:1972: qemu-system-alphaw.exe] Error 1
C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../.=
./x86_64-w64-mingw32/bin/ld.exe:
cannot find -lfdt
C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../.=
./x86_64-w64-mingw32/bin/ld.exe:
cannot find -lfdt
C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../.=
./x86_64-w64-mingw32/bin/ld.exe:
cannot find -lfdt
C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../.=
./x86_64-w64-mingw32/bin/ld.exe:
cannot find -lfdt
collect2.exe: error: ld returned 1 exit status
collect2.exe: error: ld returned 1 exit status
make: *** [Makefile.ninja:2184: qemu-system-armw.exe] Error 1
make: *** [Makefile.ninja:2182: qemu-system-arm.exe] Error 1
collect2.exe: error: ld returned 1 exit status
make: *** [Makefile.ninja:1875: qemu-system-aarch64.exe] Error 1
collect2.exe: error: ld returned 1 exit status
make: *** [Makefile.ninja:1877: qemu-system-aarch64w.exe] Error 1

C:\Users\ContainerAdministrator\AppData\Local\Temp\cirrus-ci-build>if
2 NEQ 0 exit /b 2

Exit status: 2

```



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000001bd6de05ae46a2c7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><a href=3D"https://cirrus-ci.com/task/6375504892657664">ht=
tps://cirrus-ci.com/task/6375504892657664</a><br clear=3D"all"><div><br></d=
iv><div><br></div><div>failed with:</div><div>```</div><div><pre style=3D"c=
olor:rgb(0,0,0);white-space:pre-wrap">Compiling C object libqemu-s390x-soft=
mmu.fa.p/meson-generated_.._trace_generated-helpers.c.obj
Compiling C object libqemu-s390x-softmmu.fa.p/meson-generated_.._qapi_qapi-=
events.c.obj
Compiling C object libqemu-s390x-softmmu.fa.p/meson-generated_.._qapi_qapi-=
emit-events.c.obj
Linking static target libblock.fa
Linking target qemu-system-aarch64.exe
Linking target qemu-system-aarch64w.exe
Linking target qemu-system-alpha.exe
Linking target qemu-system-alphaw.exe
Linking target qemu-system-arm.exe
Linking target qemu-system-armw.exe
Linking target qemu-system-avr.exe
Linking target qemu-system-avrw.exe
C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../.=
./x86_64-w64-mingw32/bin/ld.exe: cannot find -lfdt
C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../.=
./x86_64-w64-mingw32/bin/ld.exe: cannot find -lfdt
C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../.=
./x86_64-w64-mingw32/bin/ld.exe: cannot find -lfdt
C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../.=
./x86_64-w64-mingw32/bin/ld.exe: cannot find -lfdt
collect2.exe: error: ld returned 1 exit status
collect2.exe: error: ld returned 1 exit status
collect2.exe: error: ld returned 1 exit status
collect2.exe: error: ld returned 1 exit status
make: *** [Makefile.ninja:2258: qemu-system-avr.exe] Error 1
make: *** Waiting for unfinished jobs....
make: *** [Makefile.ninja:1970: qemu-system-alpha.exe] Error 1
make: *** [Makefile.ninja:2260: qemu-system-avrw.exe] Error 1
make: *** [Makefile.ninja:1972: qemu-system-alphaw.exe] Error 1
C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../.=
./x86_64-w64-mingw32/bin/ld.exe: cannot find -lfdt
C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../.=
./x86_64-w64-mingw32/bin/ld.exe: cannot find -lfdt
C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../.=
./x86_64-w64-mingw32/bin/ld.exe: cannot find -lfdt
C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../.=
./x86_64-w64-mingw32/bin/ld.exe: cannot find -lfdt
collect2.exe: error: ld returned 1 exit status
collect2.exe: error: ld returned 1 exit status
make: *** [Makefile.ninja:2184: qemu-system-armw.exe] Error 1
make: *** [Makefile.ninja:2182: qemu-system-arm.exe] Error 1
collect2.exe: error: ld returned 1 exit status
make: *** [Makefile.ninja:1875: qemu-system-aarch64.exe] Error 1
collect2.exe: error: ld returned 1 exit status
make: *** [Makefile.ninja:1877: qemu-system-aarch64w.exe] Error 1

C:\Users\ContainerAdministrator\AppData\Local\Temp\cirrus-ci-build&gt;if 2 =
NEQ 0 exit /b 2=20

Exit status: 2</pre></div><div>```</div><div><br></div><div><br></div><div>=
<br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=
=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=87=B4<b=
r>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincer=
ely,<br>Yonggang Luo<br></div></div>

--0000000000001bd6de05ae46a2c7--

