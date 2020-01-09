Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8BCC32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:50:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DCE5206ED
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPQjUrUn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DCE5206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipXGu-0005dr-B8
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 07:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ipXFf-0004Dp-2E
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:49:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ipXFd-0002nm-GJ
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:49:26 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42852)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ipXFd-0002kr-6k; Thu, 09 Jan 2020 07:49:25 -0500
Received: by mail-ot1-x344.google.com with SMTP id 66so7090632otd.9;
 Thu, 09 Jan 2020 04:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=AiMhUtgjKB/D6GYpuP4+LfS+QIpgbkVxzfO/EvO4uq0=;
 b=hPQjUrUnDEQ60OTjE7sLM4IkcnUANAMnQKSSWc9kHoUsfdwuJTNFvbUXKO8wy/dhan
 0yXKF/mt3ymL7zE3qFjIimkR79HoXzRr9HYytS5Z0qplwvNwX80Vm/dPKuBCeP2q9OFs
 UVU8gOR1CoVyJp0QeWLOZlKXt+JrrzhWEdiGrMSZzLlZr5opy1YwWGR2P6xlwd5zSJop
 P/08NNwa9nQWwuSc9aFZwxadkuRGRfKrBOigGBRxlBV1ICKPWeXmOOz61DPaorBMdlWw
 gPP6Wa6bD+F2MmzwY9O+5jfDhR6upEtbBGsH+meEoPglf1M6AkkCGY5sidAV+uoJdzYY
 9Ktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=AiMhUtgjKB/D6GYpuP4+LfS+QIpgbkVxzfO/EvO4uq0=;
 b=uSnG+4Fh97ILh181PgzM8PBNXg0FvEqRBno3CVs5d3RfSjgby18oGwITUYmTbekjI0
 QxQ2aCdXn0OywNgSkM2Y103vMyrJFGjEDxLgBe7/NkvV6wvhGaOp7YZx4BwJh/lg7RLm
 OfOP+w9gkHYEeKJA1M4QhBv6efQ9L9zbeIFqnK3bqjYIErzn5hyegwePQpr+dEJ4rn3/
 LLr8+x+D62IzbuCqbDQVJDvuLYPfWzYWltNgwSHVGxKyiqE43I2oaM5I9DeuNg9v/4Ff
 q+Olxq/5JhZQowUdep23uI0Rsv4XJmivfqKi7WhldgwG9u+9d9KNvDKfsLDvE7igNzSK
 lJuQ==
X-Gm-Message-State: APjAAAUhMH9V1BSty8WmfDboLZBauZ7PIF6tTfJx9UUTm8d+Yj9UfDPA
 uQF32usarOLzZ2jhCkfpFMS9HBLzeUXYASH3eRw=
X-Google-Smtp-Source: APXvYqw9LyToFHMwmhbpVobKL+RNAFIRLqAXXAfy7mOtMDgJ9vZPOGzdWAtFgGT6nN2JkdSl+Xl8OvsueGmZfJ0QNnU=
X-Received: by 2002:a9d:7305:: with SMTP id e5mr8060526otk.64.1578574163603;
 Thu, 09 Jan 2020 04:49:23 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Thu, 9 Jan 2020 04:49:23 -0800 (PST)
In-Reply-To: <20200109095116.18201-1-thuth@redhat.com>
References: <20200109095116.18201-1-thuth@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 9 Jan 2020 13:49:23 +0100
Message-ID: <CAL1e-=jnAMtpNNHO1rqG-63K_5uM-QfVYoMcj0NZeHwKCWG4uQ@mail.gmail.com>
Subject: Re: [PATCH] qemu-deprecated: Remove text about Python 2
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000045f45d059bb470fa"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000045f45d059bb470fa
Content-Type: text/plain; charset="UTF-8"

On Thursday, January 9, 2020, Thomas Huth <thuth@redhat.com> wrote:

> Python 2 support has been removed, so we should now also remove
> the announcement text for the deprecation.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  qemu-deprecated.texi | 8 --------
>  1 file changed, 8 deletions(-)
>
>
Reviewed by: Aleksandar Markovic <amarkovic@wavecomp.com>


> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 7033e531de..8b23e98474 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -341,14 +341,6 @@ they have no effect when used with @option{-n} to
> skip image creation.
>  Silently ignored options can be confusing, so this combination of
>  options will be made an error in future versions.
>
> -@section Build system
> -
> -@subsection Python 2 support (since 4.1.0)
> -
> -In the future, QEMU will require Python 3 to be available at
> -build time.  Support for Python 2 in scripts shipped with QEMU
> -is deprecated.
> -
>  @section Backwards compatibility
>
>  @subsection Runnability guarantee of CPU models (since 4.1.0)
> --
> 2.18.1
>
>
>

--00000000000045f45d059bb470fa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, January 9, 2020, Thomas Huth &lt;<a href=3D"mailto:thu=
th@redhat.com">thuth@redhat.com</a>&gt; wrote:<br><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">Python 2 support has been removed, so we should now also remove<br>
the announcement text for the deprecation.<br>
<br>
Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@re=
dhat.com</a>&gt;<br>
---<br>
=C2=A0qemu-deprecated.texi | 8 --------<br>
=C2=A01 file changed, 8 deletions(-)<br>
<br></blockquote><div><br></div><div><span style=3D"color:rgb(34,34,34);fon=
t-size:14px;line-height:22.1200008392334px">Reviewed by: Aleksandar Markovi=
c &lt;</span><a href=3D"mailto:amarkovic@wavecomp.com" target=3D"_blank" st=
yle=3D"font-size:14px;line-height:22.1200008392334px">amarkovic@wavecomp.co=
m</a><span style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.12000=
08392334px">&gt;</span><br></div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi<br>
index 7033e531de..8b23e98474 100644<br>
--- a/qemu-deprecated.texi<br>
+++ b/qemu-deprecated.texi<br>
@@ -341,14 +341,6 @@ they have no effect when used with @option{-n} to skip=
 image creation.<br>
=C2=A0Silently ignored options can be confusing, so this combination of<br>
=C2=A0options will be made an error in future versions.<br>
<br>
-@section Build system<br>
-<br>
-@subsection Python 2 support (since 4.1.0)<br>
-<br>
-In the future, QEMU will require Python 3 to be available at<br>
-build time.=C2=A0 Support for Python 2 in scripts shipped with QEMU<br>
-is deprecated.<br>
-<br>
=C2=A0@section Backwards compatibility<br>
<br>
=C2=A0@subsection Runnability guarantee of CPU models (since 4.1.0)<br>
-- <br>
2.18.1<br>
<br>
<br>
</blockquote>

--00000000000045f45d059bb470fa--

