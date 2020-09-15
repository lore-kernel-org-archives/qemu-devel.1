Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696E3C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 14:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2644206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 14:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFd7ZZ/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2644206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIBb4-0006zI-TS
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 10:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kIBRb-0001Se-O3
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 09:56:28 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:45337)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kIBRZ-0005ph-W1
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 09:56:27 -0400
Received: by mail-ej1-x643.google.com with SMTP id i26so5151298ejb.12
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 06:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oVMl4YHDbb2Q6RVR1bETZ1dfmb5fPIQISdobiw1cff4=;
 b=ZFd7ZZ/w/aGpLHMBuYKTnrePzqU3IyciszstoDcr1UBkar2WhvbDEgDnr/atdtxWFb
 eLsDTKwxDkrVRgseMvNfInypsD99taANnhZkldSfmbK2KaKkbay47/zRkwjuUGtEXsG2
 mNGQlHjGpncp07WvTShQa91sT3395hF2VqrDbzyEsEcZBCmZKkTGYWqvw34hzmKVckw2
 4LoUuz8/tykxmvv0HiZfYeb3CmEZUH/kD3Rasu7GfnKggIwCo1vjmKutJ5Gs/ODUOVBB
 m7usd94x73RRDExJbwJhDUY1ppt3ELKA27RZVIBAZNG/KWvM3uf+jKkknz+gRhhgOYJD
 jAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oVMl4YHDbb2Q6RVR1bETZ1dfmb5fPIQISdobiw1cff4=;
 b=k7QiBmLIauhESWBm8hNStBHrSWNdi0H3ees/Eb7DLLnppiKRJ10NVfAZGjm957Hydo
 RX7K8WKmTypgz8NcNwblrvFMoY9Wz7cqemVD1D0bFmjXNp8yRflE2RyYnNtr0XDuEVvR
 np1jBRLStuf9otBdNjmIQrHX7RQHjd3+mKp0caJGKgtIF7qq/5vEzyq1msHQGXUOt5EX
 ZzOLRwI4YZpV/afEL9DlQSaPIfDpb4R2yrp5bZyvwgQNXkBUDsJ71K6RSeFtMT8GUI1Z
 cQvQSf9jl2La5WgG1Q7TUKfKxHuiFnujMKb4hthj3MYkVVKryBy5UaZ19GYWdoSrmNAJ
 LJng==
X-Gm-Message-State: AOAM5308X61QaoOE2wTPdaMU5yIwFr+lXrqZCTkQNTlNKVtrf8yVDsvi
 sb/f3TcYoAMejBcghg6ZnYWw6aKfMb/BFNzHuS8=
X-Google-Smtp-Source: ABdhPJykqNBHscYBWokUDMTSJgH+cM618/TRUkc4QFtNfBFNZQDnaHVej4xDAeqjynd4SFjAOkC3k43X1Z7wTyQlw8Y=
X-Received: by 2002:a17:906:faec:: with SMTP id
 lu44mr19901851ejb.527.1600178184018; 
 Tue, 15 Sep 2020 06:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200915114757.55635-1-thuth@redhat.com>
In-Reply-To: <20200915114757.55635-1-thuth@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 15 Sep 2020 17:56:12 +0400
Message-ID: <CAJ+F1CLex1WJaHtMPU1Vo4UAUR9aO3ga3QJPNcZ5RWoVq6+dWA@mail.gmail.com>
Subject: Re: [PATCH] qga/commands-win32: Fix problem with redundant protype
 declaration
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000003c6c4605af5a84e8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x643.google.com
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
Cc: Stefan Weil <sw@weilnetz.de>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003c6c4605af5a84e8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Sep 15, 2020 at 3:49 PM Thomas Huth <thuth@redhat.com> wrote:

> When compiling QEMU with MSYS2 on Windows, there is currently the
> following error:
>
> ../qga/commands-win32.c:62:24: error: redundant redeclaration of
>  'CM_Get_DevNode_PropertyW' [-Werror=3Dredundant-decls]
>    62 | CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(
>       |                        ^~~~~~~~~~~~~~~~~~~~~~~~
> In file included from ../qga/commands-win32.c:26:
> C:/tools/msys64/mingw64/x86_64-w64-mingw32/include/cfgmgr32.h:840:26: not=
e:
>  previous declaration of 'CM_Get_DevNode_PropertyW' was here
>   840 |   CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(DEVINST
> dnDevInst,
>    const DEVPROPKEY *PropertyKey, DEVPROPTYPE *PropertyType, PBYTE
> PropertyBuffer,
>    PULONG PropertyBufferSize, ULONG ulFlags);
>
> Seems like this protype is sometimes available in the cfgmgr32.h
> header, and sometimes not. Let's silence the compiler warning here
> to let the build pass with -Werror, too.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
>  I can take this through my "testing" tree together with some other
>  MSYS2 patches if there are no objections.
>
>  qga/commands-win32.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 48d8bbe649..0c3c05484f 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -57,8 +57,10 @@ DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_DriverDate,
> 0xa8b865dd, 0x2e3d,
>  DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_DriverVersion, 0xa8b865dd, 0x2e3d,
>      0x4094, 0xad, 0x97, 0xe5, 0x93, 0xa7, 0xc, 0x75, 0xd6, 3);
>      /* DEVPROP_TYPE_STRING */
> -/* The following shoud be in cfgmgr32.h, but it isn't */
> +/* The CM_Get_DevNode_PropertyW prototype is only sometimes in cfgmgr32.=
h
> */
>  #ifndef CM_Get_DevNode_Property
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wredundant-decls"
>  CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(
>      DEVINST          dnDevInst,
>      CONST DEVPROPKEY * PropertyKey,
> @@ -68,6 +70,7 @@ CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(
>      ULONG            ulFlags
>  );
>  #define CM_Get_DevNode_Property CM_Get_DevNode_PropertyW
> +#pragma GCC diagnostic pop
>  #endif
>
>  #ifndef SHTDN_REASON_FLAG_PLANNED
> --
> 2.18.2
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000003c6c4605af5a84e8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, Sep 15, 2020 at 3:49 PM Thomas Huth &=
lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">When compiling QEMU =
with MSYS2 on Windows, there is currently the<br>
following error:<br>
<br>
../qga/commands-win32.c:62:24: error: redundant redeclaration of<br>
=C2=A0&#39;CM_Get_DevNode_PropertyW&#39; [-Werror=3Dredundant-decls]<br>
=C2=A0 =C2=A062 | CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(<br>
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~<br>
In file included from ../qga/commands-win32.c:26:<br>
C:/tools/msys64/mingw64/x86_64-w64-mingw32/include/cfgmgr32.h:840:26: note:=
<br>
=C2=A0previous declaration of &#39;CM_Get_DevNode_PropertyW&#39; was here<b=
r>
=C2=A0 840 |=C2=A0 =C2=A0CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(DE=
VINST dnDevInst,<br>
=C2=A0 =C2=A0const DEVPROPKEY *PropertyKey, DEVPROPTYPE *PropertyType, PBYT=
E PropertyBuffer,<br>
=C2=A0 =C2=A0PULONG PropertyBufferSize, ULONG ulFlags);<br>
<br>
Seems like this protype is sometimes available in the cfgmgr32.h<br>
header, and sometimes not. Let&#39;s silence the compiler warning here<br>
to let the build pass with -Werror, too.<br>
<br>
Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=
=3D"_blank">thuth@redhat.com</a>&gt;<br></blockquote><div><br></div><div>Re=
viewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com">marcandre.lureau@redhat.com</a>&gt;=C2=A0 <br></div><div><br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0I can take this through my &quot;testing&quot; tree together with som=
e other<br>
=C2=A0MSYS2 patches if there are no objections.<br>
<br>
=C2=A0qga/commands-win32.c | 5 ++++-<br>
=C2=A01 file changed, 4 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
index 48d8bbe649..0c3c05484f 100644<br>
--- a/qga/commands-win32.c<br>
+++ b/qga/commands-win32.c<br>
@@ -57,8 +57,10 @@ DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_DriverDate, 0xa8b86=
5dd, 0x2e3d,<br>
=C2=A0DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_DriverVersion, 0xa8b865dd, 0x2e3=
d,<br>
=C2=A0 =C2=A0 =C2=A00x4094, 0xad, 0x97, 0xe5, 0x93, 0xa7, 0xc, 0x75, 0xd6, =
3);<br>
=C2=A0 =C2=A0 =C2=A0/* DEVPROP_TYPE_STRING */<br>
-/* The following shoud be in cfgmgr32.h, but it isn&#39;t */<br>
+/* The CM_Get_DevNode_PropertyW prototype is only sometimes in cfgmgr32.h =
*/<br>
=C2=A0#ifndef CM_Get_DevNode_Property<br>
+#pragma GCC diagnostic push<br>
+#pragma GCC diagnostic ignored &quot;-Wredundant-decls&quot;<br>
=C2=A0CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(<br>
=C2=A0 =C2=A0 =C2=A0DEVINST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dnDevInst,<br=
>
=C2=A0 =C2=A0 =C2=A0CONST DEVPROPKEY * PropertyKey,<br>
@@ -68,6 +70,7 @@ CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(<br>
=C2=A0 =C2=A0 =C2=A0ULONG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ulFlags<=
br>
=C2=A0);<br>
=C2=A0#define CM_Get_DevNode_Property CM_Get_DevNode_PropertyW<br>
+#pragma GCC diagnostic pop<br>
=C2=A0#endif<br>
<br>
=C2=A0#ifndef SHTDN_REASON_FLAG_PLANNED<br>
-- <br>
2.18.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--0000000000003c6c4605af5a84e8--

