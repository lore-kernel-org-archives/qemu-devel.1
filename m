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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C17C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:57:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D589520738
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xt7Gv16o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D589520738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIBSR-00020p-1T
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 09:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kIBR9-00014X-3v
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 09:55:59 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:43117)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kIBR7-0005nS-2l
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 09:55:58 -0400
Received: by mail-ej1-x642.google.com with SMTP id o8so5168629ejb.10
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 06:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TYPzCdYMBCiwPVsfa1Qxs7dDOrKa0XcB2hSku3QeaYE=;
 b=Xt7Gv16op6yhdYlU+WfzlPWfgFrgarVT92/DL7x7D1H4DKwMUd3CA4zCOYQUEYkejW
 Tapfqxb/PDp/CTMMirPbmibsA7zDUrIGee9EyFGt3Ad6ivOGqatYy74zuUyXTyC9eUrk
 +dmvypOpQKhj+rT/DfBHLjYTMcBt71qnu8JsQur6ki+EN03IeoZ4lECMMpT/mRw7w01N
 rFSNdkrliVKjNI/nZvIJBB6GAw1i9nLYFX3hYAjrqZzOkdeiN7yt/Gv2rjqxnmkJ1FXb
 94OXSD12LUChfjG40dTOBsznQ9GwZVz1+zfeILLAzd8EfHQhfaW8t8UTsM9P8BX/p1Yx
 +Yfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TYPzCdYMBCiwPVsfa1Qxs7dDOrKa0XcB2hSku3QeaYE=;
 b=M13D4EnPGM+xCcQFLjTY6V/1SkHYfeAqy2g+NCnusVEvbudf0tV33b1WMQhr+Af8uW
 DQsUU4JbATtk11iBgcyLF4CYg19sat1iHrJRFxASXuZor+J3rZll6OBwSnBqRifZ8sD8
 UGgw5Vyj6/4gG0RF59to4W+AaMSJaKm9Zjbib538OH/DZHu5X1WBO3YDA8VLNIGLHOqy
 QNnPHGKujsFW7ZqmgWm0DwTeB2QSAnRIqLvTUqj0zObgaXAOAMtcR6r+y0y/IQnvN6TM
 w51ILscIuHqQy/YLgtV7fpX23w8S4YxwfHh9yLIvzhtN11727ggaZb/YuC6XsZgj02yN
 c1bA==
X-Gm-Message-State: AOAM533ZayvE57VzsKK56tDOpsqwhuMkmNeeet3Ig/cJ50K1Hqaqud4F
 VqwQ/u3GaCd7P6qd2Pn77qHrn5TyxLusGfQoDTk=
X-Google-Smtp-Source: ABdhPJzBd3Gm/vqBbFgi3Gg1zQVKGbnk8w89ZtGSKLS91KYzqCC5UirpxAfemKIRTfiCNLMOGs4jnMfR7zLoT65G+Rg=
X-Received: by 2002:a17:906:a88a:: with SMTP id
 ha10mr21414339ejb.532.1600178155003; 
 Tue, 15 Sep 2020 06:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200915114757.55635-1-thuth@redhat.com>
 <c173b806-918d-3899-a58d-c082353823e9@redhat.com>
In-Reply-To: <c173b806-918d-3899-a58d-c082353823e9@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 15 Sep 2020 17:55:40 +0400
Message-ID: <CAJ+F1CLzL-6rXtP0RyiN9t5--rptqtCyo63O7OmnrVPeYv0Jcg@mail.gmail.com>
Subject: Re: [PATCH] qga/commands-win32: Fix problem with redundant protype
 declaration
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000081a30505af5a8244"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x642.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000081a30505af5a8244
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Sep 15, 2020 at 4:57 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> Cc'ing Marc-Andr=C3=A9
>
> On 9/15/20 1:47 PM, Thomas Huth wrote:
> > When compiling QEMU with MSYS2 on Windows, there is currently the
> > following error:
> >
> > ../qga/commands-win32.c:62:24: error: redundant redeclaration of
> >  'CM_Get_DevNode_PropertyW' [-Werror=3Dredundant-decls]
> >    62 | CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(
> >       |                        ^~~~~~~~~~~~~~~~~~~~~~~~
> > In file included from ../qga/commands-win32.c:26:
> > C:/tools/msys64/mingw64/x86_64-w64-mingw32/include/cfgmgr32.h:840:26:
> note:
> >  previous declaration of 'CM_Get_DevNode_PropertyW' was here
> >   840 |   CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(DEVINST
> dnDevInst,
> >    const DEVPROPKEY *PropertyKey, DEVPROPTYPE *PropertyType, PBYTE
> PropertyBuffer,
> >    PULONG PropertyBufferSize, ULONG ulFlags);
> >
> > Seems like this protype is sometimes available in the cfgmgr32.h
> > header, and sometimes not.
>
> This prototype is declared Since Windows Vista, but per
> commit 4ac80866476 ("qga: drop < Vista compatibility")
> it should be always true... So I'm confused.
>
> Maybe we should build with:
>
>   QEMU_BUILD_BUG_ON(_WIN32_WINNT < 0x0600); /* Vista */
>
> Commit 56cdca1d7a6 ("build-sys: build with Vista API by default")
> defines it if missing... Maybe that's where this problem comes
> from? (On too old includes we force them as Vista).
>
>
It doesn't have much to do with _WIN32_WINNT version, I think

The prototype was quite recently added in mingw-headers by Tom=C3=A1=C5=A1:
commit 5ace9333fa948dd4ce73bd262aaf0df39a0cf6ef
Author: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
Date:   Fri Oct 18 11:22:22 2019 +0200

    include/cfgmgr32.h: add CM_Get_DevNode_PropertyW

It should be fine to silence the warning as proposed here.

> Let's silence the compiler warning here
> > to let the build pass with -Werror, too.
> >
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  I can take this through my "testing" tree together with some other
> >  MSYS2 patches if there are no objections.
> >
> >  qga/commands-win32.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> > index 48d8bbe649..0c3c05484f 100644
> > --- a/qga/commands-win32.c
> > +++ b/qga/commands-win32.c
> > @@ -57,8 +57,10 @@ DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_DriverDate,
> 0xa8b865dd, 0x2e3d,
> >  DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_DriverVersion, 0xa8b865dd, 0x2e3d=
,
> >      0x4094, 0xad, 0x97, 0xe5, 0x93, 0xa7, 0xc, 0x75, 0xd6, 3);
> >      /* DEVPROP_TYPE_STRING */
> > -/* The following shoud be in cfgmgr32.h, but it isn't */
> > +/* The CM_Get_DevNode_PropertyW prototype is only sometimes in
> cfgmgr32.h */
> >  #ifndef CM_Get_DevNode_Property
> > +#pragma GCC diagnostic push
> > +#pragma GCC diagnostic ignored "-Wredundant-decls"
> >  CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(
> >      DEVINST          dnDevInst,
> >      CONST DEVPROPKEY * PropertyKey,
> > @@ -68,6 +70,7 @@ CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(
> >      ULONG            ulFlags
> >  );
> >  #define CM_Get_DevNode_Property CM_Get_DevNode_PropertyW
> > +#pragma GCC diagnostic pop
> >  #endif
> >
> >  #ifndef SHTDN_REASON_FLAG_PLANNED
> >
>
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000081a30505af5a8244
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 15, 2020 at 4:57 PM Phi=
lippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@re=
dhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">Cc&#39;ing Marc-Andr=C3=A9<br>
<br>
On 9/15/20 1:47 PM, Thomas Huth wrote:<br>
&gt; When compiling QEMU with MSYS2 on Windows, there is currently the<br>
&gt; following error:<br>
&gt; <br>
&gt; ../qga/commands-win32.c:62:24: error: redundant redeclaration of<br>
&gt;=C2=A0 &#39;CM_Get_DevNode_PropertyW&#39; [-Werror=3Dredundant-decls]<b=
r>
&gt;=C2=A0 =C2=A0 62 | CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~<br>
&gt; In file included from ../qga/commands-win32.c:26:<br>
&gt; C:/tools/msys64/mingw64/x86_64-w64-mingw32/include/cfgmgr32.h:840:26: =
note:<br>
&gt;=C2=A0 previous declaration of &#39;CM_Get_DevNode_PropertyW&#39; was h=
ere<br>
&gt;=C2=A0 =C2=A0840 |=C2=A0 =C2=A0CMAPI CONFIGRET WINAPI CM_Get_DevNode_Pr=
opertyW(DEVINST dnDevInst,<br>
&gt;=C2=A0 =C2=A0 const DEVPROPKEY *PropertyKey, DEVPROPTYPE *PropertyType,=
 PBYTE PropertyBuffer,<br>
&gt;=C2=A0 =C2=A0 PULONG PropertyBufferSize, ULONG ulFlags);<br>
&gt; <br>
&gt; Seems like this protype is sometimes available in the cfgmgr32.h<br>
&gt; header, and sometimes not.<br>
<br>
This prototype is declared Since Windows Vista, but per<br>
commit 4ac80866476 (&quot;qga: drop &lt; Vista compatibility&quot;)<br>
it should be always true... So I&#39;m confused.<br>
<br>
Maybe we should build with:<br>
<br>
=C2=A0 QEMU_BUILD_BUG_ON(_WIN32_WINNT &lt; 0x0600); /* Vista */<br>
<br>
Commit 56cdca1d7a6 (&quot;build-sys: build with Vista API by default&quot;)=
<br>
defines it if missing... Maybe that&#39;s where this problem comes<br>
from? (On too old includes we force them as Vista).<br>
<br></blockquote><div><br></div><div><div>It doesn&#39;t have much to do wi=
th _WIN32_WINNT version, I think<br></div><div><br></div>The prototype was =
quite recently added in mingw-headers by Tom=C3=A1=C5=A1:</div><div>commit =
5ace9333fa948dd4ce73bd262aaf0df39a0cf6ef<br>Author: Tom=C3=A1=C5=A1 Golembi=
ovsk=C3=BD &lt;<a href=3D"mailto:tgolembi@redhat.com">tgolembi@redhat.com</=
a>&gt;<br>Date: =C2=A0 Fri Oct 18 11:22:22 2019 +0200<br><br>=C2=A0 =C2=A0 =
include/cfgmgr32.h: add CM_Get_DevNode_PropertyW</div><div><br></div><div>I=
t should be fine to silence the warning as proposed here.<br></div><div><br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; Let&#39;s silence the compiler warning here<br>
&gt; to let the build pass with -Werror, too.<br>
&gt; <br>
&gt; Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" tar=
get=3D"_blank">thuth@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 I can take this through my &quot;testing&quot; tree together wit=
h some other<br>
&gt;=C2=A0 MSYS2 patches if there are no objections.<br>
&gt; <br>
&gt;=C2=A0 qga/commands-win32.c | 5 ++++-<br>
&gt;=C2=A0 1 file changed, 4 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
&gt; index 48d8bbe649..0c3c05484f 100644<br>
&gt; --- a/qga/commands-win32.c<br>
&gt; +++ b/qga/commands-win32.c<br>
&gt; @@ -57,8 +57,10 @@ DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_DriverDate, 0x=
a8b865dd, 0x2e3d,<br>
&gt;=C2=A0 DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_DriverVersion, 0xa8b865dd, =
0x2e3d,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 0x4094, 0xad, 0x97, 0xe5, 0x93, 0xa7, 0xc, 0x75, 0=
xd6, 3);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* DEVPROP_TYPE_STRING */<br>
&gt; -/* The following shoud be in cfgmgr32.h, but it isn&#39;t */<br>
&gt; +/* The CM_Get_DevNode_PropertyW prototype is only sometimes in cfgmgr=
32.h */<br>
&gt;=C2=A0 #ifndef CM_Get_DevNode_Property<br>
&gt; +#pragma GCC diagnostic push<br>
&gt; +#pragma GCC diagnostic ignored &quot;-Wredundant-decls&quot;<br>
&gt;=C2=A0 CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEVINST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dnDevIns=
t,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 CONST DEVPROPKEY * PropertyKey,<br>
&gt; @@ -68,6 +70,7 @@ CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ULONG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ulF=
lags<br>
&gt;=C2=A0 );<br>
&gt;=C2=A0 #define CM_Get_DevNode_Property CM_Get_DevNode_PropertyW<br>
&gt; +#pragma GCC diagnostic pop<br>
&gt;=C2=A0 #endif<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #ifndef SHTDN_REASON_FLAG_PLANNED<br>
&gt; <br>
<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--00000000000081a30505af5a8244--

