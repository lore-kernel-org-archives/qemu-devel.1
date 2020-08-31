Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4511CC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:34:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D35E206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D35E206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCrS1-0000vM-Sf
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 17:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCrCp-0003B5-5K
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:19:11 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36130)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCrCn-0001UB-Dd
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:19:10 -0400
Received: by mail-qt1-f195.google.com with SMTP id n10so3275243qtv.3
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 14:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fcsRPnob1oX3NIGeA3G2AlKCyFbc0Ai8j8HxH8Fku6o=;
 b=X5AGyWRwLlWOhwB15S2zGMz89ptup9CmHuDDwftiEPyzyRfb5rAY8YtzuKvT7wTc1u
 lK2sPykrAGpHGyoLhaWSIN1uyZTIWoTkck/s6YlIBBt8VDlHXs0phtSdHEXXM8GTVI6C
 WIM+GuWvRQC71oWwdwpUMJR3vRQOZFFQS1e4qgUFdad3Dt15tJf7sTPieBFFLvfBUtkz
 zHCOTUt8bShSN4keOQ/BxVHiyoguJEyfMF+v5y/6cVVViJzLWzZUo6bVZw/cIFvhkoYP
 T+tV3DDUd9vWlSbuu7fJh1uP3VGIw7CAf873kDiPhYkjUpzSquOlxWHwrRSbrZpJby9w
 Yd2w==
X-Gm-Message-State: AOAM532gjCKH8Cvjbt7g2H/F1p06xdM7+XXd37kLGPbYP+f9GSth+PjO
 jQ7hc57zGowIy8izpiG8kA3SAbd2N7yxLgaErks=
X-Google-Smtp-Source: ABdhPJwl/ARMNqgD7oPtWmmFuydphtOUurND18blNkZitbhH5FgH6uAYy5oCQQM4Br4G0Z2QxRoGF9YAlXPaq3LV3s4=
X-Received: by 2002:ac8:f86:: with SMTP id b6mr3330613qtk.252.1598908748524;
 Mon, 31 Aug 2020 14:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200827210920.111611-1-sw@weilnetz.de>
In-Reply-To: <20200827210920.111611-1-sw@weilnetz.de>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 31 Aug 2020 21:52:19 +0200
Message-ID: <CAAdtpL5wdBnXO8NqArE0Fgad8EU7bXTKc83daQo4kfHW=8XvHQ@mail.gmail.com>
Subject: Re: [PATCH] libvhost-user: Add GCC_FMT_ATTR and fix format string
To: Stefan Weil <sw@weilnetz.de>
Content-Type: multipart/alternative; boundary="000000000000fbef3905ae32f3d7"
Received-SPF: pass client-ip=209.85.160.195;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-qt1-f195.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 17:15:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000fbef3905ae32f3d7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 27 ao=C3=BBt 2020 23:09, Stefan Weil <sw@weilnetz.de> a =C3=A9crit =
:

> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>  contrib/libvhost-user/libvhost-user.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c
> b/contrib/libvhost-user/libvhost-user.c
> index 53f16bdf08..ff7ac876f4 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -151,7 +151,7 @@ vu_request_to_string(unsigned int req)
>      }
>  }
>
> -static void
> +static void GCC_FMT_ATTR(2, 3)
>  vu_panic(VuDev *dev, const char *msg, ...)
>  {
>      char *buf =3D NULL;
> @@ -643,7 +643,7 @@ generate_faults(VuDev *dev) {
>
>          if (ioctl(dev->postcopy_ufd, UFFDIO_REGISTER, &reg_struct)) {
>              vu_panic(dev, "%s: Failed to userfault region %d "
> -                          "@%p + size:%zx offset: %zx: (ufd=3D%d)%s\n",
> +                          "@%016"PRIx64" + size:%zx offset: %zx:
> (ufd=3D%d)%s\n",
>

I thought I had fixed this last month, but I don't have my email backlog,
so:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

                      __func__, i,
>                       dev_region->mmap_addr,
>                       dev_region->size, dev_region->mmap_offset,
> --
> 2.28.0
>
>
>

--000000000000fbef3905ae32f3d7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">Le jeu. 27 ao=C3=BBt 2020 23:09, Stefan Weil &lt;<a href=
=3D"mailto:sw@weilnetz.de">sw@weilnetz.de</a>&gt; a =C3=A9crit=C2=A0:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">Signed-off-by: Stefan Weil &lt;<a href=
=3D"mailto:sw@weilnetz.de" target=3D"_blank" rel=3D"noreferrer">sw@weilnetz=
.de</a>&gt;<br>
---<br>
=C2=A0contrib/libvhost-user/libvhost-user.c | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/=
libvhost-user.c<br>
index 53f16bdf08..ff7ac876f4 100644<br>
--- a/contrib/libvhost-user/libvhost-user.c<br>
+++ b/contrib/libvhost-user/libvhost-user.c<br>
@@ -151,7 +151,7 @@ vu_request_to_string(unsigned int req)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-static void<br>
+static void GCC_FMT_ATTR(2, 3)<br>
=C2=A0vu_panic(VuDev *dev, const char *msg, ...)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0char *buf =3D NULL;<br>
@@ -643,7 +643,7 @@ generate_faults(VuDev *dev) {<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ioctl(dev-&gt;postcopy_ufd, UFFDIO_RE=
GISTER, &amp;reg_struct)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vu_panic(dev, &quot;%s: Fai=
led to userfault region %d &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;@%p + size:%zx offset: %zx: (ufd=3D%d)%s\n&quot;,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;@%016&quot;PRIx64&quot; + size:%zx offset: %zx: (uf=
d=3D%d)%s\n&quot;,<br></blockquote></div></div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">I thought I had fixed this last month, but I don&#39;t ha=
ve my email backlog, so:</div><div dir=3D"auto"><span style=3D"font-family:=
sans-serif;font-size:13.696px">Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt=
;</span><a href=3D"mailto:f4bug@amsat.org" style=3D"text-decoration:none;co=
lor:rgb(66,133,244);font-family:sans-serif;font-size:13.696px">f4bug@amsat.=
org</a><span style=3D"font-family:sans-serif;font-size:13.696px">&gt;</span=
><br></div><div dir=3D"auto"><span style=3D"font-family:sans-serif;font-siz=
e:13.696px"><br></span></div><div dir=3D"auto"><div class=3D"gmail_quote"><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 __func__, i,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 dev_region-&gt;mmap_addr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 dev_region-&gt;size, dev_region-&gt;mmap_offset,<br>
-- <br>
2.28.0<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000fbef3905ae32f3d7--

