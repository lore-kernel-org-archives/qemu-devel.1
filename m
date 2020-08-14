Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C4DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 08:46:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3501207DA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 08:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TBqxAnxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3501207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6VLw-0005k1-5m
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 04:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chihmin.chao@sifive.com>)
 id 1k6VKx-0004n7-Gb
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 04:45:19 -0400
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33]:33143)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chihmin.chao@sifive.com>)
 id 1k6VKu-0006KS-6R
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 04:45:19 -0400
Received: by mail-io1-xd33.google.com with SMTP id g14so10145429iom.0
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 01:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cxxSgsTerg0imbyz9ODFb7gqkKVcxRU0DJQLcG9HQEQ=;
 b=TBqxAnxhw3jD1Ve4Qc2VOxnxrUwJpXVkast1vceFWNF1Zxt/EjnXn47gzJCc7go/hY
 T/B3kxPbq2/cQm7VQK0AJMMw3Rn0Ol1Vy5xSHEHJRtUBj7L9ay88RQAINz6RCh0eFw7I
 4pv+ukmjbkpzs1kNtbeqI5TnUAidK6smsP/e7uTkiTuJjPQ4mh441VN+qRkzEyhqiAno
 TvFYCcTjcnP3JQgXdA6NCHoOcZry3PLoeInozSagZhwtZpSsaj8yrSC7AZ1CElIZqSQK
 2Jiu23X5A6EIspHesF0J1mTKLnvi3gfGWt8L2zepXw8j1iQHtwfBxnUAXc7kBgSrsOVw
 Ze4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cxxSgsTerg0imbyz9ODFb7gqkKVcxRU0DJQLcG9HQEQ=;
 b=CyTl67WdWkOvsV75XtF2J5/7fqI64RixGu6RnIweCL/58ss6IcYaMUlcUGt/8eWIZG
 K0u4oFJRAJBxaiDhfZ8heUpelL0MLIzkZari1go0Fvc3vEaMgLT39guwHhQvgovaFaAD
 VEFLuTB8y58rXxzQUaSKm5O4KNCDuEU0cmFeWe6kx2u3+qglVwWjjAwWlBBHaXKeRmNx
 w55eTqkLGh3LpDxxoMNuLHlmZBwyTYZ21ghFLhW/u1QNg3gopSaD0Z8L4Yu626tmTvV3
 KRWiF8rqQU/R6eeBReleXGnUh2kMfDyh4f224C9bLt7OXjNEi52SqycNvd1QU2DmAsm6
 /weQ==
X-Gm-Message-State: AOAM53055M1vDsw1vsJ6W592RZv/GTOC5wdnfz5UiPp0+GaYrSDzOxwe
 gZiHH/wUFJzREuo+nkwyqSgLlsz9KYEq7leneNFGyA==
X-Google-Smtp-Source: ABdhPJwa0fJzWpVB0K97dHZ8x+JzYBoYKu+LyIsfnnDkM2A6blp/Yj+SlgYbPgNO2TJCSFC2ISW7c2ToE/AnRn39BY4=
X-Received: by 2002:a6b:3f85:: with SMTP id m127mr1384572ioa.108.1597394713643; 
 Fri, 14 Aug 2020 01:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAK29XkHKxt94TPFwwuTy78Ye1Z9=-zxMe77bx7R+xxtP-nmipw@mail.gmail.com>
 <f4dbe759-a360-efde-17f7-b67c8350c899@amsat.org>
In-Reply-To: <f4dbe759-a360-efde-17f7-b67c8350c899@amsat.org>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Fri, 14 Aug 2020 16:45:02 +0800
Message-ID: <CAEiOBXWOS-PxnFZRJiRhg8pvB0WKOaiLS8o5VsJuA85GMamayQ@mail.gmail.com>
Subject: Re: QEMU latest release riscv32-softmmu not working
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000792ea405acd27040"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d33;
 envelope-from=chihmin.chao@sifive.com; helo=mail-io1-xd33.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: arman avetisyan <arman.avetisyan2000@gmail.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-discuss@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000792ea405acd27040
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2020 at 3:31 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> Hi Arman,
>
> On 8/13/20 10:20 PM, arman avetisyan wrote:
> > Hi QEMU Team, having issue running riscv32-softmmu
>
> Cc'ing this to the QEMU RISCV mailing list.
>
> >
> > After running riscv32-softmmu supplying custom linux build it crashes
> > and complains about rom segments overlaping
> >
> > $ qemu-system-riscv32 -nographic -machine virt -kernel bbl   -append
> > "root=3D/dev/vda ro console=3DttyS0"   -drive
> > file=3Dbusybear.bin,format=3Draw,id=3Dhd0   -device virtio-blk-device,d=
rive=3Dhd0
> >



> Log:
> > rom: requested regions overlap (rom phdr #0: bbl.
> > free=3D0x000000008000c160, addr=3D0x0000000080000000)
> > qemu-system-riscv32: rom check and register reset failed
> >

Try to add "-bios none"

Chih-Min Chao

>

> qemu version =3D 5.1.0
> > Pulled from github.com <http://github.com> (latest commit in master =3D
> > also tagged v5.1.0)
> >
> > Same files are used in 4.2.0 and are working fine.
> > Tried different kernel files, all had same issue.
> >
> > How can I help to debug it? I really want to modify QEMU to support new
> > board/machine but having hard time building latest version from github
> > (which happens to be release v5.1.0)
> >
> > Thanks, Arman
>
>
>

--000000000000792ea405acd27040
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br clear=3D"all"><div><div dir=3D"ltr" c=
lass=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr=
"><br></div></div></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Aug 14, 2020 at 3:31 PM Philippe Mathieu-Da=
ud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Arman,<br=
>
<br>
On 8/13/20 10:20 PM, arman avetisyan wrote:<br>
&gt; Hi QEMU Team, having issue running riscv32-softmmu<br>
<br>
Cc&#39;ing this to the QEMU RISCV mailing list.<br>
<br>
&gt; <br>
&gt; After running riscv32-softmmu supplying custom linux build it crashes<=
br>
&gt; and complains about rom segments overlaping<br>
&gt; <br>
&gt; $ qemu-system-riscv32 -nographic -machine virt -kernel bbl =C2=A0 -app=
end<br>
&gt; &quot;root=3D/dev/vda ro console=3DttyS0&quot; =C2=A0 -drive<br>
&gt; file=3Dbusybear.bin,format=3Draw,id=3Dhd0 =C2=A0 -device virtio-blk-de=
vice,drive=3Dhd0<br>
&gt;=C2=A0=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; Log:<br>
&gt; rom: requested regions overlap (rom phdr #0: bbl.<br>
&gt; free=3D0x000000008000c160, addr=3D0x0000000080000000)<br>
&gt; qemu-system-riscv32: rom check and register reset failed<br>
&gt;=C2=A0</blockquote><div>Try to add &quot;-bios none&quot;</div><div><br=
></div><div>Chih-Min Chao=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
&gt; qemu version =3D 5.1.0<br>
&gt; Pulled from <a href=3D"http://github.com" rel=3D"noreferrer" target=3D=
"_blank">github.com</a> &lt;<a href=3D"http://github.com" rel=3D"noreferrer=
" target=3D"_blank">http://github.com</a>&gt; (latest commit in master =3D<=
br>
&gt; also tagged v5.1.0)<br>
&gt; <br>
&gt; Same files are used in 4.2.0 and are working fine.<br>
&gt; Tried different kernel files, all had same issue.<br>
&gt; <br>
&gt; How can I help to debug it? I really want to modify QEMU to support ne=
w<br>
&gt; board/machine but having hard time building latest version from github=
<br>
&gt; (which happens to be release v5.1.0)<br>
&gt; <br>
&gt; Thanks, Arman<br>
<br>
<br>
</blockquote></div></div>

--000000000000792ea405acd27040--

