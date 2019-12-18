Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70086C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 07:55:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A5A62072B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 07:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFGyUKke"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A5A62072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihUAm-0003ow-Bt
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 02:55:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ihUA6-00034H-0q
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 02:54:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ihUA4-0003zt-Ka
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 02:54:25 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33736)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ihUA4-0003yW-EX; Wed, 18 Dec 2019 02:54:24 -0500
Received: by mail-ot1-x344.google.com with SMTP id b18so1388397otp.0;
 Tue, 17 Dec 2019 23:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=c9Ott8n8VeSD/aim4reyK20MiBP+jR7McIfV4rDYYn0=;
 b=ZFGyUKkeW6dKdapbz52w8fOFnMCGnovDcEDSohXpO0MBHJy57CpJuwfx960np7anbv
 F0FBXprM2hABKw77oGIln8nFkkmUoOb7WfOzyHPw1W7HVIovHW6mz1N2bWmB99aRnpPY
 pWGPG14/byN7BZt71xy80rzbAWin833vP/W4akvGQvuhcUQvpfAooFTmhnK0s9f/BACk
 GROV/QH40CJWuc4UYbbb7yfnxJy3K02kYcZ1KWAywfRhvmLvYHNFKNKZ73NghViH/Xxc
 Vsc7/VIKI0HjE63i4OoGMl4ehwNJRNWfilAoiswkdeOuy6eUG7dz0I8R49B/j83VeM8E
 hHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=c9Ott8n8VeSD/aim4reyK20MiBP+jR7McIfV4rDYYn0=;
 b=uFqak62xfo4ShDR7p7YWVOZS4VISQ6WhGemxET95f5FTcAVNQnzSIouZ9vRoxelH/d
 4zql7y+OPfqVUZQgejHKv6JYgBe+nKD5z57Egdr5L2WpQtN/q4pcn95MPkzpEdbvf21g
 lbnLJwcJ9PBWXjt+E9V4y89bemACjWR2UUJFMz5BrRaSJbqn+3PEbgGL+HK7ms26AojA
 qHRbni8g/+2Kk9G3YQoF1KVXarWRECQcBZkIanC7CLFAtdx0xkChGbr13y4VH29kkeJF
 cK6KkvvNhd36z0KCiohjgXlVgQgc7et7+BM1hC61ysZfmksGQJsaPCD+UCjG6np46xfA
 Ae7g==
X-Gm-Message-State: APjAAAWx6c/+r8defPMhJBxmgeFZS5aIAH1sLZjLS4MGTdLN4x+bMMGl
 CZkVVqAzt1+Ts0zKHaCgDi/iMn57H+odi5T65g4=
X-Google-Smtp-Source: APXvYqzOOgAiyiKw/9QmgW0UGh3/T2k4zdWBwRUtwSMRyVWzXi4As4Y78Zhp0nnhjss9xkXvfO/F8bfzBNYyJ59ixG4=
X-Received: by 2002:a05:6830:3054:: with SMTP id
 p20mr1189344otr.121.1576655663603; 
 Tue, 17 Dec 2019 23:54:23 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Tue, 17 Dec 2019 23:54:23 -0800 (PST)
In-Reply-To: <20191217173425.5082-3-philmd@redhat.com>
References: <20191217173425.5082-1-philmd@redhat.com>
 <20191217173425.5082-3-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 18 Dec 2019 08:54:23 +0100
Message-ID: <CAL1e-=gPi2C41Lc7cOQnTP+gL3aW=yWpQvamzTSfdDCJOK5BEA@mail.gmail.com>
Subject: Re: [PATCH 2/6] hw/display/tcx: Add missing fall through comments
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c324830599f5c009"
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Olivier Danet <odanet@caramail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c324830599f5c009
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday, December 17, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om>
wrote:

> GCC9 is confused by this comment when building with
> CFLAG -Wimplicit-fallthrough=3D2:
>
>   hw/display/tcx.c: In function =E2=80=98tcx_dac_writel=E2=80=99:
>   hw/display/tcx.c:453:26: error: this statement may fall through
> [-Werror=3Dimplicit-fallthrough=3D]
>     453 |             s->dac_index =3D (s->dac_index + 1) & 0xff; /* Inde=
x
> autoincrement */
>         |             ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
>   hw/display/tcx.c:454:9: note: here
>     454 |         default:
>         |         ^~~~~~~
>   hw/display/tcx.c: In function =E2=80=98tcx_dac_readl=E2=80=99:
>   hw/display/tcx.c:412:22: error: this statement may fall through
> [-Werror=3Dimplicit-fallthrough=3D]
>     412 |         s->dac_index =3D (s->dac_index + 1) & 0xff; /* Index
> autoincrement */
>         |         ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
>   hw/display/tcx.c:413:5: note: here
>     413 |     default:
>         |     ^~~~~~~
>   cc1: all warnings being treated as errors
>
> Add the missing fall through comments.
>
> Fixes: 55d7bfe22
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Cc: Olivier Danet <odanet@caramail.com>
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/display/tcx.c | 2 ++
>  1 file changed, 2 insertions(+)
>
>
The content of the patch is fine, but the commit message is, I think,
inacurate: gcc is not confused at all, it does what it was told to.

The title is fine.


> diff --git a/hw/display/tcx.c b/hw/display/tcx.c
> index 14e829d3fa..abbeb30284 100644
> --- a/hw/display/tcx.c
> +++ b/hw/display/tcx.c
> @@ -410,6 +410,7 @@ static uint64_t tcx_dac_readl(void *opaque, hwaddr
> addr,
>      case 2:
>          val =3D s->b[s->dac_index] << 24;
>          s->dac_index =3D (s->dac_index + 1) & 0xff; /* Index autoincreme=
nt
> */
> +        /* fall through */
>      default:
>          s->dac_state =3D 0;
>          break;
> @@ -451,6 +452,7 @@ static void tcx_dac_writel(void *opaque, hwaddr addr,
> uint64_t val,
>              s->b[index] =3D val >> 24;
>              update_palette_entries(s, index, index + 1);
>              s->dac_index =3D (s->dac_index + 1) & 0xff; /* Index
> autoincrement */
> +            /* fall through */
>          default:
>              s->dac_state =3D 0;
>              break;
> --
> 2.21.0
>
>
>

--000000000000c324830599f5c009
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, December 17, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a h=
ref=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">GCC9 is confused by this comment when building wit=
h<br>
CFLAG -Wimplicit-fallthrough=3D2:<br>
<br>
=C2=A0 hw/display/tcx.c: In function =E2=80=98tcx_dac_writel=E2=80=99:<br>
=C2=A0 hw/display/tcx.c:453:26: error: this statement may fall through [-We=
rror=3Dimplicit-fallthrough=3D<wbr>]<br>
=C2=A0 =C2=A0 453 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;da=
c_index =3D (s-&gt;dac_index + 1) &amp; 0xff; /* Index autoincrement */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~<wbr>~~~~~~~~~~<br>
=C2=A0 hw/display/tcx.c:454:9: note: here<br>
=C2=A0 =C2=A0 454 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~<br>
=C2=A0 hw/display/tcx.c: In function =E2=80=98tcx_dac_readl=E2=80=99:<br>
=C2=A0 hw/display/tcx.c:412:22: error: this statement may fall through [-We=
rror=3Dimplicit-fallthrough=3D<wbr>]<br>
=C2=A0 =C2=A0 412 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;dac_index =3D (s=
-&gt;dac_index + 1) &amp; 0xff; /* Index autoincrement */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~~~~~~~~~~~~=
~^~~~~~~~~~~~~~~~~<wbr>~~~~~~~~~~<br>
=C2=A0 hw/display/tcx.c:413:5: note: here<br>
=C2=A0 =C2=A0 413 |=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0^~~~~~~<br>
=C2=A0 cc1: all warnings being treated as errors<br>
<br>
Add the missing fall through comments.<br>
<br>
Fixes: 55d7bfe22<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com">philmd@redhat.com</a>&gt;<br>
---<br>
Cc: Olivier Danet &lt;<a href=3D"mailto:odanet@caramail.com">odanet@caramai=
l.com</a>&gt;<br>
Cc: Mark Cave-Ayland &lt;<a href=3D"mailto:mark.cave-ayland@ilande.co.uk">m=
ark.cave-ayland@ilande.co.uk</a>&gt;<br>
---<br>
=C2=A0hw/display/tcx.c | 2 ++<br>
=C2=A01 file changed, 2 insertions(+)<br>
<br></blockquote><div><br></div><div>The content of the patch is fine, but =
the commit message is, I think, inacurate: gcc is not confused at all, it d=
oes what it was told to.</div><div><br></div><div>The title is fine.</div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">
diff --git a/hw/display/tcx.c b/hw/display/tcx.c<br>
index 14e829d3fa..abbeb30284 100644<br>
--- a/hw/display/tcx.c<br>
+++ b/hw/display/tcx.c<br>
@@ -410,6 +410,7 @@ static uint64_t tcx_dac_readl(void *opaque, hwaddr addr=
,<br>
=C2=A0 =C2=A0 =C2=A0case 2:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D s-&gt;b[s-&gt;dac_index] &lt;&lt;=
 24;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;dac_index =3D (s-&gt;dac_index + 1)=
 &amp; 0xff; /* Index autoincrement */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* fall through */<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;dac_state =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
@@ -451,6 +452,7 @@ static void tcx_dac_writel(void *opaque, hwaddr addr, u=
int64_t val,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;b[index] =3D val &gt;=
&gt; 24;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0update_palette_entries(s, i=
ndex, index + 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;dac_index =3D (s-&gt;=
dac_index + 1) &amp; 0xff; /* Index autoincrement */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* fall through */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;dac_state =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote>

--000000000000c324830599f5c009--

