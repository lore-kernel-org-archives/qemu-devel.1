Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD640C7619B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:18:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7963620718
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5uNz0t/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7963620718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3afw-0006Zb-Ew
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 02:18:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hsp.cat7@gmail.com>) id 1j3aer-0005sK-HX
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 02:17:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hsp.cat7@gmail.com>) id 1j3aeq-0001Aq-A5
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 02:17:33 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39875)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hsp.cat7@gmail.com>)
 id 1j3aeq-0001AI-1t; Mon, 17 Feb 2020 02:17:32 -0500
Received: by mail-ot1-x344.google.com with SMTP id 77so15126880oty.6;
 Sun, 16 Feb 2020 23:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wa7S8bLeyYCYyiVvgllMgoyoyQZdO1CI+FShBn7ymx8=;
 b=V5uNz0t/i/7uQLQMD/YGfF2qYclxpycCpCVSafrHBRm84t9CMijyJoBsnPfcN8MOOJ
 wQLZ7rgiRDRwH71ptmsgfIS9h9hXLhD9alxZF71mk2/4kOY4FiR4PHSW28oPXL8V7c9M
 d74jfjESTf+MMORD6eFabk2/Ejl97YyKPF2NNfCKw0RfKLseejhXuj1GrqkO7xbYWfRE
 zunTqpo90g8x24z/ybGfxcEk9Lq/SoKY/1yS0jMtGYrCHB+QdXIOrGhpSTP18wRPB+ea
 i8qealaIIY0hu48rz2Nl34cnmFtxTPZT35uKxxKMPT0utAZ1y+99NCO+h6tpsSU2z67r
 KO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wa7S8bLeyYCYyiVvgllMgoyoyQZdO1CI+FShBn7ymx8=;
 b=ihJhlRe+8DkajQn8hhFMP0ImkMaH9lJIQrewzKAyuo5o0+ROC8MdUQN3geeKrAc2wH
 UXu/1GO/YrvnFR4Pd3VPdHkG4NGXHiPxcGQLnSNMHr1UFGWtXW99Jy91Os9NkV7wPC18
 MtNCJzu8kXK9dXG06yic3U2l5+lhDyTdNVDCnpfmMnEwwOOimFyD04er4znkrpkFZN5R
 Y/9aFryJUcBibjzK75LUxJJgqbQuj8qL/zKkyr+fbAGXtv4ES5Rxe+r1QxV1+2rKAsuG
 KdS4dH6CQhK98O2ZcDNbv6cI9cXnGmQXEvQ04SltqN1PX2g0wlRvSla7wjMP92TOUmVN
 FQmw==
X-Gm-Message-State: APjAAAWk3Y4Hf/wEd3Xra82k72LC8AhcfY6XtWWpqCmMpXIYeTgDdfS/
 a9VDc2buwOPaoJXlmnRAWMLv7CZHq523fjuAgrc=
X-Google-Smtp-Source: APXvYqxJ3+x06gtkbZWdqkYdYXEhRuWL0JhYvNMbW65JlAmkIHOSRrhsy8bM7Pce70WMZlu7niVDqo1Jo6oDP/B73gs=
X-Received: by 2002:a05:6830:1e76:: with SMTP id
 m22mr5845343otr.295.1581923851157; 
 Sun, 16 Feb 2020 23:17:31 -0800 (PST)
MIME-Version: 1.0
References: <20200216163216.10745-1-programmingkidx@gmail.com>
 <CABLmASF=9Qj0_Hh2SWO6K=Sou3mVeyLL+XXTn9WGc670KRn2AA@mail.gmail.com>
 <2AF97D91-F58C-455D-9E05-F5766A6A4C9B@gmail.com>
In-Reply-To: <2AF97D91-F58C-455D-9E05-F5766A6A4C9B@gmail.com>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Mon, 17 Feb 2020 08:17:20 +0100
Message-ID: <CABLmASEM0zpSeKr97xvU_F1jVZjgu1D9hOaB3ZgN+2WPRAduSg@mail.gmail.com>
Subject: Re: [PATCH v3] Implement the Screamer sound chip for the mac99
 machine type
To: Programmingkid <programmingkidx@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000035c5a8059ec05961"
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
Cc: qemu-ppc <qemu-ppc@nongnu.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000035c5a8059ec05961
Content-Type: text/plain; charset="UTF-8"

Hi Howard, could you test out this patch for me on Fedora 31? It is to be
> applied over the v3 patch.
>
> Thank you.
>
> ---
>  hw/audio/screamer.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/hw/audio/screamer.c b/hw/audio/screamer.c
> index ad4aba12eb..7de17fe8a6 100644
> --- a/hw/audio/screamer.c
> +++ b/hw/audio/screamer.c
> @@ -14,7 +14,7 @@
>  #include "migration/vmstate.h"
>  #include "include/hw/audio/screamer.h"
>
> -#define DEBUG_SCREAMER 0
> +#define DEBUG_SCREAMER 1
>  #define DPRINTF(fmt, ...) \
>  do { if (DEBUG_SCREAMER) { printf(fmt , ## __VA_ARGS__); } } while (0)
>
> @@ -836,11 +836,12 @@ static uint64_t screamer_mmio_read(void *opaque,
> hwaddr addr, unsigned size)
>          return_value = get_frame_count_reg(state);
>          break;
>      default:
> -        DPRINTF("Unknown register read - addr:%llu\tsize:%d\n", addr,
> size);
> +        DPRINTF("Unknown register read - addr:%" HWADDR_PRIx
> "\tsize:%d\n",
> +                addr, size);
>          return_value = 12021981; /* Value used for debugging purposes */
>      }
> -    DPRINTF("screamer_mmio_read() called addr: %llu  size: %d", addr >> 4,
> -            size);
> +    DPRINTF("screamer_mmio_read() called addr: %" HWADDR_PRIx "  size:
> %d",
> +            addr >> 4, size);
>      DPRINTF("  returning 0x%x\n", return_value);
>      return return_value;
>  }
> @@ -875,7 +876,8 @@ static void screamer_mmio_write(void *opaque, hwaddr
> addr, uint64_t raw_value,
>          set_frame_count_reg(state, value);
>          break;
>      default:
> -        DPRINTF("Unknown register write - addr:%llu\tvalue:%d\n", addr,
> value);
> +        DPRINTF("Unknown register write - addr:%" HWADDR_PRIx
> "\tvalue:%d\n",
> +                addr, value);
>      }
>  }
>
>
>
Tested, compiles cleanly. Debug output seems OK.

Best,
Howard

--00000000000035c5a8059ec05961
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
Hi Howard, could you test out this patch for me on Fedora 31? It is to be a=
pplied over the v3 patch.<br>
<br>
Thank you.<br>
<br>
---<br>
=C2=A0hw/audio/screamer.c | 12 +++++++-----<br>
=C2=A01 file changed, 7 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/hw/audio/screamer.c b/hw/audio/screamer.c<br>
index ad4aba12eb..7de17fe8a6 100644<br>
--- a/hw/audio/screamer.c<br>
+++ b/hw/audio/screamer.c<br>
@@ -14,7 +14,7 @@<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
=C2=A0#include &quot;include/hw/audio/screamer.h&quot;<br>
<br>
-#define DEBUG_SCREAMER 0<br>
+#define DEBUG_SCREAMER 1<br>
=C2=A0#define DPRINTF(fmt, ...) \<br>
=C2=A0do { if (DEBUG_SCREAMER) { printf(fmt , ## __VA_ARGS__); } } while (0=
)<br>
<br>
@@ -836,11 +836,12 @@ static uint64_t screamer_mmio_read(void *opaque, hwad=
dr addr, unsigned size)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return_value =3D get_frame_count_reg(stat=
e);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;Unknown register read - addr:%ll=
u\tsize:%d\n&quot;, addr, size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;Unknown register read - addr:%&q=
uot; HWADDR_PRIx &quot;\tsize:%d\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 addr, size);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return_value =3D 12021981; /* Value used =
for debugging purposes */<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 DPRINTF(&quot;screamer_mmio_read() called addr: %llu=C2=A0 s=
ize: %d&quot;, addr &gt;&gt; 4,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size);<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;screamer_mmio_read() called addr: %&quot; HWAD=
DR_PRIx &quot;=C2=A0 size: %d&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 addr &gt;&gt; 4, size);<br>
=C2=A0 =C2=A0 =C2=A0DPRINTF(&quot;=C2=A0 returning 0x%x\n&quot;, return_val=
ue);<br>
=C2=A0 =C2=A0 =C2=A0return return_value;<br>
=C2=A0}<br>
@@ -875,7 +876,8 @@ static void screamer_mmio_write(void *opaque, hwaddr ad=
dr, uint64_t raw_value,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_frame_count_reg(state, value);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;Unknown register write - addr:%l=
lu\tvalue:%d\n&quot;, addr, value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;Unknown register write - addr:%&=
quot; HWADDR_PRIx &quot;\tvalue:%d\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 addr, value);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br><br></blockquote><div><br></div><div>Tested, compiles cleanly. Debug ou=
tput seems OK. <br></div><div><br></div><div>Best,</div><div>Howard<br></di=
v></div></div>

--00000000000035c5a8059ec05961--

