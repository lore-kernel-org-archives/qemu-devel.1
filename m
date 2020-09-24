Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E305C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 17:30:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EA12206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 17:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNL0OCYt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA12206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLV4h-0001oF-HG
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 13:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1kLV2v-00018J-7I
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 13:28:41 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:40696)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1kLV2t-0007wz-CK
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 13:28:40 -0400
Received: by mail-il1-x141.google.com with SMTP id x18so3951719ila.7
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 10:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/JNVzFbIczKq1615Ie9PDyolrTJKGZy+z75BSc6Xa2Y=;
 b=aNL0OCYtAijFPTCaqMxhxOAJ9/9foQBxJoRDbD9CQoCTOGxP4F2eD/Kx8AoeTSW/Qn
 0zvGsP5kFXY+q6UaQ/GS8SxfRiDGRLLb4vhq4iwPYMCcaSBulsWSZaWVCIEJ09fH34aj
 lhm8YhD5s7lqqC3S9Ej41lem4JCMZMeAkgEf9NvQso4uyUvc+7D2l+ifKbhVfoH/LAnU
 1lHO3ZlE21VVLun3xAXRb8UMfBqQne/E6N13OLeYXz9gbx/V9dhhrZ1tAKr3O7ut3TLA
 UkZEc7EZp/sN96W6vUyjeyPgkE717LcsW4V9bkJQ/ly+HeqOmIefccwRjEL5m15aZkNZ
 e3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/JNVzFbIczKq1615Ie9PDyolrTJKGZy+z75BSc6Xa2Y=;
 b=g/OaZQ7Vq87fYvk1XAoK33bZUdssGJHTujDVYa9Gzlqepoa2VJONYXRQ7SXYMyKQTY
 Msv1zXEB18tqkqGH3Tm5oqOYZkxbcVGHNc2slmvq84D1A3gUiCDamkoexkahQ6IbTHbG
 lICjr5R9MaAzZybGisR4nzrphgGjvliZJmY7ccIRjypkYW+Wm0ZpK5KGvR2/xeEAlrQe
 SlfQRSZtUp8Ma/cIeu89uc73mmzwrpowi3TK1lBHaGiCKTa1PVJOWTVl0/vS4uM8cy+u
 i82/xXLJU0+WYjs550qDSEAAgTy+WElAg5y9yE7BfRaEzFK4zd0KWj4tkMcSOji1WpIW
 mwEA==
X-Gm-Message-State: AOAM532g378s+aTOVZbSHMbbQ+q7cUbSaMT3nY4n2zVLh6XWdclFQw0n
 /cCvrdVhV6Dtd5FDhrvtsIHm/5k8ou7kfVXeb4U=
X-Google-Smtp-Source: ABdhPJzEilo3i4u/PHvUZXC0s7wY57o4LBZOydet+wfzeg9GIDkN9WMNtNLij+bcrEKFlLtI/Wg5v/dR37lgHGwEGYY=
X-Received: by 2002:a92:d68d:: with SMTP id p13mr365395iln.32.1600968515866;
 Thu, 24 Sep 2020 10:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200924151511.131471-1-sgarzare@redhat.com>
In-Reply-To: <20200924151511.131471-1-sgarzare@redhat.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Thu, 24 Sep 2020 19:28:25 +0200
Message-ID: <CAM9Jb+jOdy7zZ0Q1da-BXn665jxxOW6sBVF2CJXAz+JnxquwpQ@mail.gmail.com>
Subject: Re: [PATCH] docs: add 'io_uring' option to 'aio' param in
 qemu-options.hx
To: Stefano Garzarella <sgarzare@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000af54a305b0128717"
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=pankaj.gupta.linux@gmail.com; helo=mail-il1-x141.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Julia Suvorova <jusual@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000af54a305b0128717
Content-Type: text/plain; charset="UTF-8"

> When we added io_uring AIO engine, we forgot to update qemu-options.hx,
> so qemu(1) man page and qemu help were outdated.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  qemu-options.hx | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 47f64be0c0..5b098577fe 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1053,7 +1053,8 @@ SRST
>              The path to the image file in the local filesystem
>
>          ``aio``
> -            Specifies the AIO backend (threads/native, default: threads)
> +            Specifies the AIO backend (threads/native/io_uring,
> +            default: threads)
>
>          ``locking``
>              Specifies whether the image file is protected with Linux OFD
> @@ -1175,7 +1176,8 @@ DEF("drive", HAS_ARG, QEMU_OPTION_drive,
>      "-drive [file=file][,if=type][,bus=n][,unit=m][,media=d][,index=i]\n"
>      "
>  [,cache=writethrough|writeback|none|directsync|unsafe][,format=f]\n"
>      "       [,snapshot=on|off][,rerror=ignore|stop|report]\n"
> -    "
>  [,werror=ignore|stop|report|enospc][,id=name][,aio=threads|native]\n"
> +    "       [,werror=ignore|stop|report|enospc][,id=name]\n"
> +    "       [,aio=threads|native|io_uring]\n"
>      "       [,readonly=on|off][,copy-on-read=on|off]\n"
>      "       [,discard=ignore|unmap][,detect-zeroes=on|off|unmap]\n"
>      "       [[,bps=b]|[[,bps_rd=r][,bps_wr=w]]]\n"
> @@ -1247,8 +1249,8 @@ SRST
>          The default mode is ``cache=writeback``.
>
>      ``aio=aio``
> -        aio is "threads", or "native" and selects between pthread based
> -        disk I/O and native Linux AIO.
> +        aio is "threads", "native", or "io_uring" and selects between
> pthread
> +        based disk I/O, native Linux AIO, or Linux io_uring API.
>
>      ``format=format``
>          Specify which disk format will be used rather than detecting the
>

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

-- 
> 2.26.2
>
>
>

--000000000000af54a305b0128717
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr"><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">When we added io_urin=
g AIO engine, we forgot to update qemu-options.hx,<br>
so qemu(1) man page and qemu help were outdated.<br>
<br>
Signed-off-by: Stefano Garzarella &lt;<a href=3D"mailto:sgarzare@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">sgarzare@redhat.com</a>&gt;<br>
---<br>
=C2=A0qemu-options.hx | 10 ++++++----<br>
=C2=A01 file changed, 6 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/qemu-options.hx b/qemu-options.hx<br>
index 47f64be0c0..5b098577fe 100644<br>
--- a/qemu-options.hx<br>
+++ b/qemu-options.hx<br>
@@ -1053,7 +1053,8 @@ SRST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The path to the image file =
in the local filesystem<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0``aio``<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Specifies the AIO backend (threa=
ds/native, default: threads)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Specifies the AIO backend (threa=
ds/native/io_uring,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default: threads)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0``locking``<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Specifies whether the image=
 file is protected with Linux OFD<br>
@@ -1175,7 +1176,8 @@ DEF(&quot;drive&quot;, HAS_ARG, QEMU_OPTION_drive,<br=
>
=C2=A0 =C2=A0 =C2=A0&quot;-drive [file=3Dfile][,if=3Dtype][,bus=3Dn][,unit=
=3Dm][,media=3Dd][,index=3Di]\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0[,cache=3Dwritethrough=
|writeback|none|directsync|unsafe][,format=3Df]\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0[,snapshot=3Don|off][,=
rerror=3Dignore|stop|report]\n&quot;<br>
-=C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0[,werror=3Dignore|stop|repo=
rt|enospc][,id=3Dname][,aio=3Dthreads|native]\n&quot;<br>
+=C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0[,werror=3Dignore|stop|repo=
rt|enospc][,id=3Dname]\n&quot;<br>
+=C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0[,aio=3Dthreads|native|io_u=
ring]\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0[,readonly=3Don|off][,=
copy-on-read=3Don|off]\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0[,discard=3Dignore|unm=
ap][,detect-zeroes=3Don|off|unmap]\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0[[,bps=3Db]|[[,bps_rd=
=3Dr][,bps_wr=3Dw]]]\n&quot;<br>
@@ -1247,8 +1249,8 @@ SRST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The default mode is ``cache=3Dwriteback``=
.<br>
<br>
=C2=A0 =C2=A0 =C2=A0``aio=3Daio``<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 aio is &quot;threads&quot;, or &quot;native&qu=
ot; and selects between pthread based<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk I/O and native Linux AIO.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 aio is &quot;threads&quot;, &quot;native&quot;=
, or &quot;io_uring&quot; and selects between pthread<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 based disk I/O, native Linux AIO, or Linux io_=
uring API.<br>
<br>
=C2=A0 =C2=A0 =C2=A0``format=3Dformat``<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Specify which disk format will be used ra=
ther than detecting the<br></blockquote></div></div><div dir=3D"auto"><br><=
/div><div dir=3D"auto"><pre style=3D"font-family:&quot;courier new&quot;,co=
urier,monospace;font-size:16px;font-weight:600">Reviewed-by: Pankaj Gupta &=
lt;<a href=3D"mailto:pankaj.gupta.linux@gmail.com">pankaj.gupta.linux@gmail=
.com</a>&gt;</pre></div><div dir=3D"auto"><div class=3D"gmail_quote"><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">
-- <br>
2.26.2<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000af54a305b0128717--

