Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E72BC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 22:31:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC6012465D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 22:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K723MdNt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC6012465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8tb1-0006xG-6D
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 17:31:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55751)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j8taF-0006Gs-8s
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 17:30:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j8taE-0006Xq-1b
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 17:30:43 -0500
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:34753)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1j8taD-0006Xd-QX; Mon, 02 Mar 2020 17:30:41 -0500
Received: by mail-io1-xd43.google.com with SMTP id z190so1329235iof.1;
 Mon, 02 Mar 2020 14:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NgTZJCDP2zYC69UZQveIYx4xZDbGiYCQza/jbo3H32E=;
 b=K723MdNt6lfCWb/RkrJ8rnLoDFq+xXJEWCAlQNsDb3RQ+9HIEka1D0GxPJzoX3g3wA
 Z2OFfnn8euor7Vel06EcSEUg6KxtDwIYHZ8ozPKW3LhmWZ6AdLWZEsgJ8BcKUMRAlLfe
 UgCbfABp7lS9fRHlXcQF+wUFYl4sxIWZSNTid8y88HBYYeVKBPPqfJ6G3+40VdPVeVNH
 Zksst7C5TDRMduySWeTINZWBiq8oCMOM0Vky1NB+BYgaLhXs0NTNgujbVHqZyZp1SWKg
 iWgrtAKi+e8OUAUb9eukzeWMTDGhCnDEAQf5zKEtQP7Hf8sHe6d6GEiScnVgLIF1U5Yb
 zNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NgTZJCDP2zYC69UZQveIYx4xZDbGiYCQza/jbo3H32E=;
 b=uKucxEDn0as7J3bK0m1RjZTnlhFnogfVxrbKOV/XdU0Sgc0sX6ETLSqrCrwNK+H1bA
 Ovp0N8eAQlH0n8B32T55s4E9lu9GzuciR2IqqI6aichLD8WtGaZGpgrqD4wB6XIFBla1
 REhppP31Cxx5sNtlWwsIyO6WtSb0iDqeR0DZCQ7T3g/zyjV5hwtjjlX8S9ouOaZ7/nI5
 Vgquv9r1Y1ts38/wKAKOJrE5HTncX7WVQPwrBk8yFuBsymNt3iIh99FZDTo60sMgmQYV
 IquIoQuk0dMb3G+KP2OJ8mFXtYwJkmV3AUEecUEf6RKfPgsAmAnxrHVfWOz+PalQSIN4
 NQMw==
X-Gm-Message-State: ANhLgQ3+ZC1Lv+lmI9DD7hz9KcRkQPqcD4leZ1ZVHscPoGSF2N/hFvmn
 DaBUPaO88B/2XNM3OLrnfk9xzwsE4SvnlrAc8ps=
X-Google-Smtp-Source: ADFU+vt1KcQxUhEXlQIb4GtO4s6vptlQZRtoZp0jSdXG7pVp4iYn+2HujS8CvOJIB8ExxbpZErcgf/20TehCgjgJSmg=
X-Received: by 2002:a02:17c2:: with SMTP id 185mr1261385jah.120.1583188240974; 
 Mon, 02 Mar 2020 14:30:40 -0800 (PST)
MIME-Version: 1.0
References: <20200227220149.6845-1-nieklinnenbank@gmail.com>
 <20200227220149.6845-5-nieklinnenbank@gmail.com>
 <CAFEAcA94U=G7Bhiayt5YyJHFUMjyKwT1m5VNOH+1rV-NMysR7Q@mail.gmail.com>
 <52400d43-3890-68cb-0e63-35c3636be19a@redhat.com>
In-Reply-To: <52400d43-3890-68cb-0e63-35c3636be19a@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Mon, 2 Mar 2020 23:30:30 +0100
Message-ID: <CAPan3Wpcfrf9PcaPEbWQvagKJbaOnSnumk9yvX9-ZibXzgnEaA@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] hw/arm/cubieboard: report error when using
 unsupported -bios argument
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b7492c059fe6bc13"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
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
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b7492c059fe6bc13
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Mon, Mar 2, 2020 at 7:04 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om>
wrote:

> On 3/2/20 4:44 PM, Peter Maydell wrote:
> > On Thu, 27 Feb 2020 at 22:02, Niek Linnenbank <nieklinnenbank@gmail.com=
>
> wrote:
> >>
> >> The Cubieboard machine does not support the -bios argument.
> >> Report an error when -bios is used and exit immediately.
> >>
> >> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> >> ---
> >>   hw/arm/cubieboard.c | 7 +++++++
> >>   1 file changed, 7 insertions(+)
> >>
> >> diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
> >> index 6c55d9056f..871b1beef4 100644
> >> --- a/hw/arm/cubieboard.c
> >> +++ b/hw/arm/cubieboard.c
> >> @@ -19,6 +19,7 @@
> >>   #include "exec/address-spaces.h"
> >>   #include "qapi/error.h"
> >>   #include "cpu.h"
> >> +#include "sysemu/sysemu.h"
> >>   #include "hw/sysbus.h"
> >>   #include "hw/boards.h"
> >>   #include "hw/arm/allwinner-a10.h"
> >> @@ -33,6 +34,12 @@ static void cubieboard_init(MachineState *machine)
> >>       AwA10State *a10;
> >>       Error *err =3D NULL;
> >>
> >> +    /* BIOS is not supported by this board */
> >> +    if (bios_name) {
> >> +        error_report("BIOS not supported for this machine");
> >> +        exit(1);
> >> +    }
> >
> > We don't usually bother to check this, but I guess there's
> > no reason not to.
>
> I agree this is confusing to expect the machine boot from a flash when
> using -bios and having to debug until figuring out the reason.
>
> This -bios is a generic machine option, maybe we could move this check
> to the common machine code.
>

Agreed, that sounds logical indeed.

When we have a common machine code/class I presume that boards which do
support the -bios
option could simply set somekind of flag/field to enable the -bios
functionality. And for boards
which do not support it, the common machine code would then by default give
an error and exit.

Regards,
Niek


> >
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> >
> > thanks
> > -- PMM
> >
>
>

--=20
Niek Linnenbank

--000000000000b7492c059fe6bc13
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Philippe,<br></div><br><div class=3D"g=
mail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 2, 2020 at 7:=
04 PM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">=
philmd@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">On 3/2/20 4:44 PM, Peter Maydell wrote:<br>
&gt; On Thu, 27 Feb 2020 at 22:02, Niek Linnenbank &lt;<a href=3D"mailto:ni=
eklinnenbank@gmail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt; =
wrote:<br>
&gt;&gt;<br>
&gt;&gt; The Cubieboard machine does not support the -bios argument.<br>
&gt;&gt; Report an error when -bios is used and exit immediately.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenban=
k@gmail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 =C2=A0hw/arm/cubieboard.c | 7 +++++++<br>
&gt;&gt;=C2=A0 =C2=A01 file changed, 7 insertions(+)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c<br>
&gt;&gt; index 6c55d9056f..871b1beef4 100644<br>
&gt;&gt; --- a/hw/arm/cubieboard.c<br>
&gt;&gt; +++ b/hw/arm/cubieboard.c<br>
&gt;&gt; @@ -19,6 +19,7 @@<br>
&gt;&gt;=C2=A0 =C2=A0#include &quot;exec/address-spaces.h&quot;<br>
&gt;&gt;=C2=A0 =C2=A0#include &quot;qapi/error.h&quot;<br>
&gt;&gt;=C2=A0 =C2=A0#include &quot;cpu.h&quot;<br>
&gt;&gt; +#include &quot;sysemu/sysemu.h&quot;<br>
&gt;&gt;=C2=A0 =C2=A0#include &quot;hw/sysbus.h&quot;<br>
&gt;&gt;=C2=A0 =C2=A0#include &quot;hw/boards.h&quot;<br>
&gt;&gt;=C2=A0 =C2=A0#include &quot;hw/arm/allwinner-a10.h&quot;<br>
&gt;&gt; @@ -33,6 +34,12 @@ static void cubieboard_init(MachineState *machi=
ne)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AwA10State *a10;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Error *err =3D NULL;<br>
&gt;&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 /* BIOS is not supported by this board */<br>
&gt;&gt; +=C2=A0 =C2=A0 if (bios_name) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;BIOS not supported=
 for this machine&quot;);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt; <br>
&gt; We don&#39;t usually bother to check this, but I guess there&#39;s<br>
&gt; no reason not to.<br>
<br>
I agree this is confusing to expect the machine boot from a flash when <br>
using -bios and having to debug until figuring out the reason.<br>
<br>
This -bios is a generic machine option, maybe we could move this check <br>
to the common machine code.<br></blockquote><div><br></div><div>Agreed, tha=
t sounds logical indeed.=C2=A0</div><div><br></div><div>When we have a comm=
on machine code/class I presume that boards which do support the -bios</div=
><div>option could simply set somekind of flag/field to enable the -bios fu=
nctionality. And for boards</div><div>which do not support it, the common m=
achine code would then by default give an error and exit.</div><div><br></d=
iv><div>Regards,</div><div>Niek<br></div><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
&gt; <br>
&gt; Reviewed-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.=
org" target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
&gt; <br>
&gt; thanks<br>
&gt; -- PMM<br>
&gt; <br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000b7492c059fe6bc13--

