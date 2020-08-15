Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61466C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:51:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25FC323B18
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNu/VjoX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25FC323B18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6zOq-0005AK-FH
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 12:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1k6zOG-0004jY-Uf
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 12:50:44 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:44072)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1k6zOF-0007rx-3O
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 12:50:44 -0400
Received: by mail-oi1-x244.google.com with SMTP id h3so10983156oie.11
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2020 09:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=fJkvxgfiGyz33+Y8tWTTw9I5nhgSyYEXW6hXm6UBN2k=;
 b=oNu/VjoXQ5Vg85TwhL+IjbrRanVgN2s8YIETU82NcqLrOwpq1yDDU0yzNaC5nzNj4V
 IEYATBVXhDjIEhvCzw2OpyfNY56K+LIJ0ujRkMNwCZ1iTtbGpvKcIhfhhGk1VHi+sjp1
 cI4wT6PMNL9Iuke9RzXuUc6+EspJHpDgI8jMaFjg9Lq9LSJ/jj/jU0UbZ6rf+FWx7j/p
 mlpKShdCYyY2PewUNHlfx3Fha10VCWCjSw8/k6RyPHSS0sXbVQAF4m8M1LcGKL5Bk3hH
 46D3r8M70AnkGWfYvAWuZRvLaUy5mP8mHLaQ1+PcIzCLNCyoxeLSp5jBBTbm+KarRLBO
 T2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=fJkvxgfiGyz33+Y8tWTTw9I5nhgSyYEXW6hXm6UBN2k=;
 b=IxuYfGvOXC1/4o7iaGqmfFZERm24n+3RTUJxNy2D749eDJKvRSJbQpCLE2j2guHeLa
 y1efEUJIpTzDWe1pNcBL2Fjr3RdCG28Z7Xg8lIwSzHzcnzqfKKf2DE0ygLoURFadDLy3
 pOK33hXNfgi/SbpR2GMmxtsXG302WZK+m2/ZH9FsZzK3Mz+GuSezBIkrv8AAOLcmJHd2
 29y8rSllTtgIKrXypmUH/tjIdXYjVaM2zZiLdnGoH6r/vig5aY5C/lnezqkLEw5ubMY8
 MjxsMqdSVQQHP2Istjbo3zD/l8Juo5snXbKSzH2V0LMvDsegpyIFgSWC5rqRHCkY1i3K
 0xkg==
X-Gm-Message-State: AOAM531I4QU57cD1BSbselcLGEtVl6goGMWSaJtYmLak/6G5ku+h6mbd
 q5x+p2NGQgp1wPLG2FN24+xgUGlvdMEDPYXdXCMX+nRX
X-Google-Smtp-Source: ABdhPJywXFQpIPVVqG5NySOwE0KT5HtmAshlnk8qRcg30WbcmTLenXYhsejLY4fKtGYTVFbaObIyTBE2i1pg+wZ+VKA=
X-Received: by 2002:aca:4c0f:: with SMTP id z15mr3694784oia.131.1597482123875; 
 Sat, 15 Aug 2020 02:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200814091326.16173-1-pbonzini@redhat.com>
In-Reply-To: <20200814091326.16173-1-pbonzini@redhat.com>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Sat, 15 Aug 2020 11:01:52 +0200
Message-ID: <CABLmASEvuBOaJ9PeyXZmruyDQhiERnPxSXEsHg+VNe83XeD6=g@mail.gmail.com>
Subject: Re: [PATCH v2 000/150] Meson integration for 5.2
To: qemu-devel qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000008758e805ace6ca0d"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=hsp.cat7@gmail.com; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008758e805ace6ca0d
Content-Type: text/plain; charset="UTF-8"

On Fri, Aug 14, 2020 at 11:15 AM Paolo Bonzini <pbonzini@redhat.com> wrote:

>
> Hi Paolo,

I don't know how much of this is already meant to work, but I run into
several issues when compiling the latest code from the meson-poc-next
branch.

1. MSYS2-based Windows build: The guide to compile e.g., qemu-system-ppc on
Windows with Msys2 works OK to compile Qemu:
https://wiki.qemu.org/Hosts/W32#Native_builds_with_MSYS2
However, when I compile the meson-poc-next branch I run into the following
error:

hsp@HSP-W10-X64-I7 MINGW64 ~/src/qemu-meson-gitlab/build
$ ../configure --cross-prefix=x86_64-w64-mingw32- --target-list=ppc-softmmu
--enable-gtk --enable-sdl
...
Program python3 found: NO
../meson.build:32:0: ERROR: /mingw64/bin/python3 not found
A full log can be found at
C:/msys64/home/hsp/src/qemu-meson-gitlab/build/meson-logs/meson-log.txt
ERROR: meson setup failed

2. When cross compiling from Fedora 32 for Windows with
../configure --cross-prefix=x86_64-w64-mingw32- --enable-gtk --enable-sdl
--target-list=ppc-softmmu

I get the error below even though the v2 commit message says there is a fix
for the absolute path error included:

The Meson build system
Version: 0.55.0
Source dir: /home/hsp/src/qemu-meson-gitlab
Build dir: /home/hsp/src/qemu-meson-gitlab/build
Build type: cross build

../meson.build:1:0: ERROR: prefix value 'c:/Program Files/QEMU' must be an
absolute path

A full log can be found at
/home/hsp/src/qemu-meson-gitlab/build/meson-logs/meson-log.txt

ERROR: meson setup failed

3. As mentioned earlier here concerning a build on fedora 32 host:
https://lists.nongnu.org/archive/html/qemu-devel/2020-08/msg02307.html
Both SDL and GTK Guis do not seem to work, only the vnc server is started.

4. The v2 patch set seems to not apply cleanly to current qemu-master, I
get this error:
patching file docs/devel/build-system.rst (renamed from
docs/devel/build-system.txt)
Hunk #2 succeeded at 179 with fuzz 2 (offset 152 lines).
Hunk #3 succeeded at 187 (offset 152 lines).
Hunk #4 FAILED at 53.
Hunk #5 FAILED at 90.
Hunk #6 FAILED at 115.
Hunk #7 FAILED at 183.
Hunk #8 FAILED at 201.
Hunk #9 FAILED at 211.
Hunk #10 FAILED at 222.
Hunk #11 FAILED at 247.
Hunk #12 FAILED at 308.
Hunk #13 FAILED at 356.
Hunk #14 FAILED at 398.
Hunk #15 FAILED at 451.
12 out of 15 hunks FAILED -- saving rejects to file
docs/devel/build-system.rst.rej

5: And one question: Should the compiled binary etc be placed in the build
directory, or should they go into (in my case) the ppc-softmmu folder as
with a default build?

Best,
Howard

--0000000000008758e805ace6ca0d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 14, 2020 at 11:15 AM Paol=
o Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank">pbon=
zini@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex"><br></blockquote><div><div>Hi Paolo,</div><div><br></div><di=
v>I don&#39;t know how much of this is
 already meant to work, but I run into several issues when compiling the
 latest code from the meson-poc-next branch. <br></div><div><br></div><div>=
1. MSYS2-based Windows build: The guide to compile e.g., qemu-system-ppc on=
 Windows with Msys2 works OK to compile Qemu: <a href=3D"https://wiki.qemu.=
org/Hosts/W32#Native_builds_with_MSYS2" target=3D"_blank">https://wiki.qemu=
.org/Hosts/W32#Native_builds_with_MSYS2</a> <br></div><div>However, when I =
compile the meson-poc-next branch I run into the following error:</div><div=
><br></div><div>hsp@HSP-W10-X64-I7 MINGW64 ~/src/qemu-meson-gitlab/build<br=
>$ ../configure --cross-prefix=3Dx86_64-w64-mingw32- --target-list=3Dppc-so=
ftmmu --enable-gtk --enable-sdl <br></div><div>...<br>Program python3 found=
: NO<br>../meson.build:32:0: ERROR: /mingw64/bin/python3 not found<br>A ful=
l log can be found at C:/msys64/home/hsp/src/qemu-meson-gitlab/build/meson-=
logs/meson-log.txt<br>ERROR: meson setup failed</div><div><br></div><div>2.=
 When cross compiling from Fedora 32 for Windows with</div><div>../configur=
e --cross-prefix=3Dx86_64-w64-mingw32- --enable-gtk --enable-sdl --target-l=
ist=3Dppc-softmmu</div><div><br></div><div>I get the error below even thoug=
h the v2 commit message says there is a fix for the absolute path error inc=
luded:</div><div><br></div><div>The Meson build system<br>Version: 0.55.0<b=
r>Source dir: /home/hsp/src/qemu-meson-gitlab<br>Build dir: /home/hsp/src/q=
emu-meson-gitlab/build<br>Build type: cross build<br><br>../meson.build:1:0=
: ERROR: prefix value &#39;c:/Program Files/QEMU&#39; must be an absolute p=
ath<br><br>A full log can be found at /home/hsp/src/qemu-meson-gitlab/build=
/meson-logs/meson-log.txt<br><br>ERROR: meson setup failed</div><div><br></=
div><div>3. As mentioned earlier here concerning a build on fedora 32 host:=
<br></div><div><a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/=
2020-08/msg02307.html" target=3D"_blank">https://lists.nongnu.org/archive/h=
tml/qemu-devel/2020-08/msg02307.html</a></div><div>Both SDL and GTK Guis do=
 not seem to work, only the vnc server is started.<br></div><div><br></div>=
<div>4. The v2 patch set seems to not apply cleanly to current qemu-master,=
 I get this error: <br></div><div>patching file docs/devel/build-system.rst=
 (renamed from docs/devel/build-system.txt)<br>Hunk #2 succeeded at 179 wit=
h fuzz 2 (offset 152 lines).<br>Hunk #3 succeeded at 187 (offset 152 lines)=
.<br>Hunk #4 FAILED at 53.<br>Hunk #5 FAILED at 90.<br>Hunk #6 FAILED at 11=
5.<br>Hunk #7 FAILED at 183.<br>Hunk #8 FAILED at 201.<br>Hunk #9 FAILED at=
 211.<br>Hunk #10 FAILED at 222.<br>Hunk #11 FAILED at 247.<br>Hunk #12 FAI=
LED at 308.<br>Hunk #13 FAILED at 356.<br>Hunk #14 FAILED at 398.<br>Hunk #=
15 FAILED at 451.<br>12 out of 15 hunks FAILED -- saving rejects to file do=
cs/devel/build-system.rst.rej<br></div><div><br></div><div>5:
 And one question: Should the compiled binary etc be placed in the build
 directory, or should they go into (in my case) the ppc-softmmu folder=20
as with a default build? <br></div><div><br></div><div>Best,</div><div>Howa=
rd</div></div><div>=C2=A0</div></div></div>

--0000000000008758e805ace6ca0d--

