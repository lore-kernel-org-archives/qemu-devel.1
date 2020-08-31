Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18BEC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 10:38:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8EC12083E
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 10:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tp5O6A81"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8EC12083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kChCQ-0001dg-NQ
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 06:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kChBt-0001DL-TL
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 06:37:33 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:46874)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kChBs-000542-AX
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 06:37:33 -0400
Received: by mail-ej1-x641.google.com with SMTP id d11so7738645ejt.13
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 03:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+1JBvc9O72wvn+zT2o7QhV2iaeu3pOujw+5wQB67d4c=;
 b=tp5O6A815chXK9TizIr0PrehSY27cOFpd5Yq5IWf6eahpuv6gjIacjfcZB+jAZjgYI
 de55eqXAy4dPwa3/aUEp2juhYa0YgSE9C2X1LfDR4mkT58wmJJ8RwwmgNNejW3wzUSQE
 6fZpzrfIwXqbP7hmH4Xvbv27myk8hMGCx3sIRBLB+tRZq3LZqyub4gkds8aT8Hgab1qT
 mT5w1k/kFa2dVIpg98S/WHaeMJciqL9qIA266sb7fEVDeIBGfhBtRQwtQ8VToVK4ip6a
 48vmdm1RCR0nsRu4xGAl3yUWprddMSh2xaFI6v3/TN038g9q2virysKKLnP+nlKJ52BF
 sTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+1JBvc9O72wvn+zT2o7QhV2iaeu3pOujw+5wQB67d4c=;
 b=BT8Vg8G5WquWwDB7ckLQU2wCdfBFYwYAVjZwsymNQupEVWN0AtJQwnOotppwM4/fER
 2T3DEaVH60lWvMFpKafNPqPty9tV5KK8C3U2/xg5blDkPbgdDCjseFTdB9WbqddswFMO
 QPB72bDaVNV0N5/VlPXUEk6untwCFEq7ogaflZ4Nk8rvz82rsZ+myOD+0RTr0IyCHyF8
 GovCUPNQRaLJobqYY+ugGYW6NUe3bmjgInbFslxovVhLCxMoEjXBCOu3G82pMlD4fDhl
 VKDe80XZehosAEuUl0eAXvMsC82PBQZuTJ5tuv5v+yM7ceIHPaidhE/JPKqL/iPCAhDv
 ZSjg==
X-Gm-Message-State: AOAM530TUriHIxrnAnwTeKLMybhH35d7aMg4FuT9/9k07dcTv1wNItq1
 A++RpxqRmekNVJQDwZrVTk7P8Sy4t3qGOkwi70o=
X-Google-Smtp-Source: ABdhPJzON3Mf/LsSL4qzRBzmTcIUBFJBJMuLYV+ET99i07Wh7Z/V0neZfX+YmYxnB4NtvLfLEb+lCecLoFsU+uD8g/M=
X-Received: by 2002:a17:906:52c2:: with SMTP id
 w2mr501769ejn.389.1598870250457; 
 Mon, 31 Aug 2020 03:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200831084937.8298-1-pbonzini@redhat.com>
In-Reply-To: <20200831084937.8298-1-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 31 Aug 2020 14:37:18 +0400
Message-ID: <CAJ+F1C+PEbQ7+9NcO4f_Dab50bOQGWHcpsRD+vGF15dM8GNsZw@mail.gmail.com>
Subject: Re: [PATCH] configure: do not include ${prefix} in firmwarepath
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000520cf905ae29fd17"
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000520cf905ae29fd17
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2020 at 12:50 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> Left out in commit 22a87800e6 ("configure: expand path variables for
> meson configure", 2020-08-21), do it now.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>

lgtm

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configure b/configure
> index 56ceca2f68..d15ecbee46 100755
> --- a/configure
> +++ b/configure
> @@ -473,7 +473,6 @@ LDFLAGS_SHARED=3D"-shared"
>  modules=3D"no"
>  module_upgrades=3D"no"
>  prefix=3D"/usr/local"
> -firmwarepath=3D"\${prefix}/share/qemu-firmware"
>  qemu_suffix=3D"qemu"
>  slirp=3D""
>  oss_lib=3D""
> @@ -1672,6 +1671,7 @@ for opt do
>    esac
>  done
>
> +firmwarepath=3D"${firmwarepath:-$prefix/share/qemu-firmware}"
>  libdir=3D"${libdir:-$prefix/lib}"
>  libexecdir=3D"${libexecdir:-$prefix/libexec}"
>  includedir=3D"${includedir:-$prefix/include}"
> --
> 2.26.2
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000520cf905ae29fd17
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 31, 2020 at 12:50 PM Paol=
o Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Lef=
t out in commit 22a87800e6 (&quot;configure: expand path variables for<br>
meson configure&quot;, 2020-08-21), do it now.<br>
<br>
Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" tar=
get=3D"_blank">pbonzini@redhat.com</a>&gt;<br></blockquote><div><br></div><=
div>lgtm</div><div><br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<=
a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</=
a>&gt;</div><div><br></div><div> <br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
---<br>
=C2=A0configure | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/configure b/configure<br>
index 56ceca2f68..d15ecbee46 100755<br>
--- a/configure<br>
+++ b/configure<br>
@@ -473,7 +473,6 @@ LDFLAGS_SHARED=3D&quot;-shared&quot;<br>
=C2=A0modules=3D&quot;no&quot;<br>
=C2=A0module_upgrades=3D&quot;no&quot;<br>
=C2=A0prefix=3D&quot;/usr/local&quot;<br>
-firmwarepath=3D&quot;\${prefix}/share/qemu-firmware&quot;<br>
=C2=A0qemu_suffix=3D&quot;qemu&quot;<br>
=C2=A0slirp=3D&quot;&quot;<br>
=C2=A0oss_lib=3D&quot;&quot;<br>
@@ -1672,6 +1671,7 @@ for opt do<br>
=C2=A0 =C2=A0esac<br>
=C2=A0done<br>
<br>
+firmwarepath=3D&quot;${firmwarepath:-$prefix/share/qemu-firmware}&quot;<br=
>
=C2=A0libdir=3D&quot;${libdir:-$prefix/lib}&quot;<br>
=C2=A0libexecdir=3D&quot;${libexecdir:-$prefix/libexec}&quot;<br>
=C2=A0includedir=3D&quot;${includedir:-$prefix/include}&quot;<br>
-- <br>
2.26.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000520cf905ae29fd17--

