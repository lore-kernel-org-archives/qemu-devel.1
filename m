Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9043C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 10:26:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B49002068F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 10:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+B48RQ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B49002068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAW9k-00048M-Uj
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 06:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kAW91-0003g2-Cw
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 06:25:35 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:35412)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kAW8z-0005SM-Js
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 06:25:35 -0400
Received: by mail-ej1-x641.google.com with SMTP id a26so15858520ejc.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 03:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AbHzArxDYj8dmWYvIPHWadFaX+Hib+j3tm2ztHJMIrA=;
 b=l+B48RQ9TRZ1id9TdXphNZpezj3U6N5wp3wAAXRWre7FTiKY3ozuijgmLkYH/ZzNZR
 +2g+ZTZSIt15H1MKOSOeylYht1LA+6OWLSd32FVOeOxYqZH/ECwGkSkvLLAu8Lihj8Qn
 W4uQKdXwRqvZrzV3/oqQwyFvmgXom2dGc6i0qE+EBCFMoZ4vEoVggFisRJMXepTIg4Bg
 O+e5I2lxeraXgBfx0ba4IuiWVHiLNmT6glWtxDx4sh8S+QXMOL95JAZEPgJA2VNSspQR
 RlC9+EIb6AoI3dX/zhRbgpo7KvxJBrs0anA471OHaqs9t0n5S+jTxwN3p6OZlP2bdF3I
 uuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AbHzArxDYj8dmWYvIPHWadFaX+Hib+j3tm2ztHJMIrA=;
 b=YEhOZJfJu/lQp7fPQe+emNHJJPCCu8nBIFfG/b+miHXwZjRCW884odm08VJEVfxRoc
 n2kUggjBm2zNtISYBqHYFyr4sAtepO1r9/YYfbCdqaASCh3Bg7Zr117PJw18YjaRBYoU
 QJKa73Mhkpp9CiXzK4yMO6kL2hxpGHtCRA+CVC1lWGkv9D6nN+uUn+ZDgLzp7EejKXy0
 ZDhaorxcv6syZSOPTAI1CQSM9CEPqMInEYPFI8yhMFdqT5o4VEMe96qzrSmRxOGOd0Nu
 wxL18H0ZNi4vCpUcrX7Iu8qcpaw7s8awLGwWMdIopv2+F2cACWI9WmDY38jpcgcyV90i
 nUkA==
X-Gm-Message-State: AOAM532y0qvM+MosE1BMtAgYFk9RQk4AVUZBI78GkyAqOtv9woo85my0
 XeSFgy8g2WCZSsuveB7PKXGFPxo5uo38WEwx0Gw=
X-Google-Smtp-Source: ABdhPJzclQ56AZicBtyu9QvHHajc0yaxIPCEe6e5YQeuXUd5leB2OBPRDWPjds2cyMtp6aaWC2i/OwUG9DUnC7RVu8k=
X-Received: by 2002:a17:906:c10c:: with SMTP id
 do12mr6290840ejc.92.1598351132071; 
 Tue, 25 Aug 2020 03:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200825001649.1811-1-luoyonggang@gmail.com>
In-Reply-To: <20200825001649.1811-1-luoyonggang@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 25 Aug 2020 14:25:20 +0400
Message-ID: <CAJ+F1CJYsR8Bf2EgaV+pMM_1DGnG-2tvCV-5LsjE6w3hk1-P_g@mail.gmail.com>
Subject: Re: [PATCH] meson: Mingw64 gcc doesn't recognize system include_type
 for sdl2
To: luoyonggang@gmail.com
Content-Type: multipart/alternative; boundary="000000000000741b3b05adb11fb5"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x641.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000741b3b05adb11fb5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Aug 25, 2020 at 4:17 AM <luoyonggang@gmail.com> wrote:

> From: Yonggang Luo <luoyonggang@gmail.com>
>
> ---
>  meson.build | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index df5bf728b5..a3585881e1 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -224,8 +224,7 @@ if 'CONFIG_BRLAPI' in config_host
>    brlapi =3D declare_dependency(link_args:
> config_host['BRLAPI_LIBS'].split())
>  endif
>
> -sdl =3D dependency('sdl2', required: get_option('sdl'), static:
> enable_static,
> -                 include_type: 'system')
> +sdl =3D dependency('sdl2', required: get_option('sdl'), static:
> enable_static)
>  sdl_image =3D not_found
>  if sdl.found()
>    # work around 2.0.8 bug
> --
> 2.27.0.windows.1
>
>
>
Which version of gcc are you using?

Paolo, why did you you -isystem includes here? (if it's on purpose, it's
worth to document it in build-system.rst since it takes sdl as an example
and doesn't mention this)


--=20
Marc-Andr=C3=A9 Lureau

--000000000000741b3b05adb11fb5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 25, 2020 at 4:17 AM &lt=
;<a href=3D"mailto:luoyonggang@gmail.com">luoyonggang@gmail.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Yongga=
ng Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com" target=3D"_blank">luoyo=
nggang@gmail.com</a>&gt;<br>
<br>
---<br>
=C2=A0meson.build | 3 +--<br>
=C2=A01 file changed, 1 insertion(+), 2 deletions(-)<br>
<br>
diff --git a/meson.build b/meson.build<br>
index df5bf728b5..a3585881e1 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -224,8 +224,7 @@ if &#39;CONFIG_BRLAPI&#39; in config_host<br>
=C2=A0 =C2=A0brlapi =3D declare_dependency(link_args: config_host[&#39;BRLA=
PI_LIBS&#39;].split())<br>
=C2=A0endif<br>
<br>
-sdl =3D dependency(&#39;sdl2&#39;, required: get_option(&#39;sdl&#39;), st=
atic: enable_static,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0include_type=
: &#39;system&#39;)<br>
+sdl =3D dependency(&#39;sdl2&#39;, required: get_option(&#39;sdl&#39;), st=
atic: enable_static)<br>
=C2=A0sdl_image =3D not_found<br>
=C2=A0if sdl.found()<br>
=C2=A0 =C2=A0# work around 2.0.8 bug<br>
-- <br>
2.27.0.windows.1<br>
<br>
<br></blockquote><div><br></div><div>Which version of gcc are you using?</d=
iv><div><br></div><div>Paolo, why did you you -isystem includes here? (if i=
t&#39;s on purpose, it&#39;s worth to document it in build-system.rst since=
 it takes sdl as an example and doesn&#39;t mention this)<br></div></div><b=
r clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"gmail_signature">Marc-=
Andr=C3=A9 Lureau<br></div></div>

--000000000000741b3b05adb11fb5--

