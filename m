Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BBCC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:14:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81F472078E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uHOr3WmI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F472078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQSVW-0008QV-Ig
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 05:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36056 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <igotti@gmail.com>) id 1jQSUh-0007Zu-6s
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:13:35 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <igotti@gmail.com>) id 1jQSUg-0000hg-FC
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:13:34 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:40397)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <igotti@gmail.com>) id 1jQSUg-0000gY-2N
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:13:34 -0400
Received: by mail-lf1-x144.google.com with SMTP id 198so7295462lfo.7
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 02:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=830PHLSjNWDFjxJWUW6hJD3TczdeIX6TKf/phEq9saU=;
 b=uHOr3WmITo+rcsZeSBEFto9FVp5XTPxjZU6pMAFLoPTsIELxl73pHRtm3cALVJawdz
 dCtJuT8n49PNLyhOzM+VhnHv7Qeqs7fnWO0nsu95jcpHsMRIQFfM1raJl1yfIWa1VwaD
 lJQj/UBS295fWAfn+SnUIWzEFkf7H1xcy9EJLl+eYC7XUkijqB4PIvEXf3/JZkQU8AgS
 QcB+agLmVTgXVrbWc4Kveu9a5JgwzDKR/hoUajHTX2hP+zNoPjrl2EMHqYB9rzuFEbjN
 0o8gNj2XlMCtcBOEmMBtocxIwVXVuUrxYFyM2QiNLOyYAXNhv3nrUpx0g3h8ZemhMjyu
 U5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=830PHLSjNWDFjxJWUW6hJD3TczdeIX6TKf/phEq9saU=;
 b=CHLZxw5flhSPs5feJIXG2t0THlwrS4d/P8/CsLCSmdGwvG9yLDjKTUdTv00SaOHYwt
 oM6LED/smkLdoX7+6Fywjr1NLyn25kYEiiEV5t/NI+cU3ORWwGF6YNZqJEPEAy0lRFEn
 yyWf53pxWbK2cU+GlpzbJPxyCBSvSGvnqT1IwDDwTyKKhYukRUDQQmkaiNtNcNo7EP5I
 /kF304YTcNtUTI09cFWE8TAX3g/+GM97trZkGpHbUocbs3YoVuFJPbsiQNFKDm7rmB1n
 FJIOe6yhYvd1mzyYFugd1mZ9/J2VTALBIBM/HK+HxTD5WoKCmV7H5xUYzqtHamY4Ya6H
 /iHg==
X-Gm-Message-State: AGi0PuZMD6bjskHqmlWjhPI+/77CN25DM/cd3CRS3vrntBafDFXlPM11
 liF60GK7UdHPOaOiOIpZDgo1wYNyvp2japXPGvY=
X-Google-Smtp-Source: APiQypLta/Ng5uNe6QzbuRYodFVfu7kWCZ6b3eYTIa9s9Zi6HcTSyGfZrYwj+adI+36RAFPh+tSbanivSOPFRF97flY=
X-Received: by 2002:a19:f611:: with SMTP id x17mr10227049lfe.51.1587374012040; 
 Mon, 20 Apr 2020 02:13:32 -0700 (PDT)
MIME-Version: 1.0
From: Nikolay Igotti <igotti@gmail.com>
Date: Mon, 20 Apr 2020 12:13:20 +0300
Message-ID: <CAEme+7HMBV=N21QNFLYOrL5QiHfxxA3qGny61h6taT78a2Vn_g@mail.gmail.com>
Subject: [PATCH 1/3] linux-user: fix page table trashing when mmap/munmap
 called frequently on large regions
To: laurent@vivier.eu, riku.voipio@iki.fi
Content-Type: multipart/alternative; boundary="0000000000001d0cd505a3b55075"
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=igotti@gmail.com; helo=mail-lf1-x144.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::144
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001d0cd505a3b55075
Content-Type: text/plain; charset="UTF-8"

Some applications, for example Wasmer WebAssembly VM, perform frequent
map/unmap of

huge (6G) regions, so when executed under linux-user it leads to creation
of many PTE/PDE

for the region, and they never get reclaimed. As result, emulator process
consumes a lot

of RAM. To fix this problem we try to reuse VMA, when possible.


Signed-off-by: Nikolay Igotti <igotti@gmail.com>

---

 linux-user/mmap.c | 2 ++

 1 file changed, 2 insertions(+)


diff --git a/linux-user/mmap.c b/linux-user/mmap.c

index e378033797..c1d6163d7a 100644

--- a/linux-user/mmap.c

+++ b/linux-user/mmap.c

@@ -650,6 +650,8 @@ int target_munmap(abi_ulong start, abi_ulong len)

     if (ret == 0) {

         page_set_flags(start, start + len, 0);

         tb_invalidate_phys_range(start, start + len);

+        if (start < mmap_next_start)

+            mmap_next_start = start;

     }

     mmap_unlock();

     return ret;

-- 

2.24.2 (Apple Git-127)

--0000000000001d0cd505a3b55075
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">





<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures">Some applications, for example =
Wasmer WebAssembly VM, perform frequent map/unmap of</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures">huge (6G) regions, so when exec=
uted under linux-user it leads to creation of many PTE/PDE</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures">for the region, and they never =
get reclaimed. As result, emulator process consumes a lot</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures">of RAM. To fix this problem we =
try to reuse VMA, when possible.</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0);min-height:13px"><span class=3D"gma=
il-s1" style=3D"font-variant-ligatures:no-common-ligatures"></span><br></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures">Signed-off-by: Nikolay Igotti &=
lt;<a href=3D"mailto:igotti@gmail.com">igotti@gmail.com</a>&gt;</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures">---</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures"><span class=3D"gmail-Apple-conv=
erted-space">=C2=A0</span>linux-user/mmap.c | 2 ++</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures"><span class=3D"gmail-Apple-conv=
erted-space">=C2=A0</span>1 file changed, 2 insertions(+)</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0);min-height:13px"><span class=3D"gma=
il-s1" style=3D"font-variant-ligatures:no-common-ligatures"></span><br></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures">diff --git a/linux-user/mmap.c =
b/linux-user/mmap.c</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures">index e378033797..c1d6163d7a 10=
0644</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures">--- a/linux-user/mmap.c</span><=
/p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures">+++ b/linux-user/mmap.c</span><=
/p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures">@@ -650,6 +650,8 @@ int target_=
munmap(abi_ulong start, abi_ulong len)</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures"><span class=3D"gmail-Apple-conv=
erted-space">=C2=A0=C2=A0 =C2=A0 </span>if (ret =3D=3D 0) {</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures"><span class=3D"gmail-Apple-conv=
erted-space">=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>page_set_flags(start,=
 start + len, 0);</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures"><span class=3D"gmail-Apple-conv=
erted-space">=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>tb_invalidate_phys_ra=
nge(start, start + len);</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures">+<span class=3D"gmail-Apple-con=
verted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>if (start &lt; mmap_next_s=
tart)</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures">+<span class=3D"gmail-Apple-con=
verted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>mmap_next_st=
art =3D start;</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures"><span class=3D"gmail-Apple-conv=
erted-space">=C2=A0=C2=A0 =C2=A0 </span>}</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures"><span class=3D"gmail-Apple-conv=
erted-space">=C2=A0=C2=A0 =C2=A0 </span>mmap_unlock();</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures"><span class=3D"gmail-Apple-conv=
erted-space">=C2=A0=C2=A0 =C2=A0 </span>return ret;</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures">--<span class=3D"gmail-Apple-co=
nverted-space">=C2=A0</span></span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures">2.24.2 (Apple Git-127)</span></=
p></div>

--0000000000001d0cd505a3b55075--

