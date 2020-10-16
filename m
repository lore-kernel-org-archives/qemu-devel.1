Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D17C43457
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 12:31:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B15F2073A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 12:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOkX+n02"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B15F2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTOt2-00061h-AY
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 08:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1kTOrR-0005Y4-Fq
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 08:29:32 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:37999)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1kTOrO-0008Dq-K4
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 08:29:29 -0400
Received: by mail-ot1-x32f.google.com with SMTP id i12so2219033ota.5
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 05:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/GOT46A+c6YZRaX4DFxh286byDMKiMG5S1KjvDwgCX0=;
 b=JOkX+n02Mda+vY6ksc2dVKbNIPeuC8bIZabCfxnkuqJ/kigEb1a5XIfJuHqi609ZfW
 36bfPH9JNhcaJySH6cs1dzjLjqd+p2+1dCFgZmT6a2WsFwVcOESo1g+nN06ygPxVavrD
 I3JB5ZpplnRXasFJZ9/xRhTIg2yC5jpRq6a3EwJVP/Cb9ChqepPPcUOrrXFdC0Thwlv1
 +3RtRAN8Yp/5tGMZITygXJldcZpndjSTz+DL8isD9Oc9uAH6xnddORy5r4ujdhYiWGl+
 m38BEd8NnRKX+GGv8gzw0ODKdU4pLO3Pwb7RaOOZF77pi4kXv2VsWrZey5dRXzOvQGld
 d+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/GOT46A+c6YZRaX4DFxh286byDMKiMG5S1KjvDwgCX0=;
 b=oTYpphJ3MorZOmGoxBuna82TPkWXJULePR3/diGZqXdlUdPhsi/Pjurt012woZNFM8
 OXaw6KO8EMD6IBL8VNIatFhXXjAbmaOo4AeLaCXXguGjqJYT6A933ObywU+QMvBNHAfD
 XNy2QCZxgPwAGmUBdhUnAcseseE3BhMw50JDhmOeNZ5Z1PGO/yq8k0hcKsgsxSKNoyLC
 q5XI6hrsbqaNkBbZD9hbj4bQL1uuAq1rVWq5tnszZ8wocx74r0KT9aQpvr2GHuxS7RCM
 5qP0m8YTT6wWXT2QE4zNuk2ivI+u1BpDJoGjYY+PFvlr9xrZEmYHeehBV/IUp8D9srJ5
 rNbQ==
X-Gm-Message-State: AOAM531Zh4EHrLYPUVAUDYzyfZT59wjfLVirfFMP1dJ3Fn0uFLcr3Q4r
 jLHyNg+nvOTKN/MhlS75o1/3pE32BOd4i1sm3zl8S8X1owWGSQ==
X-Google-Smtp-Source: ABdhPJysb/CjxPl2VC6fYXYsdwMCehNDtWV9Z+sksF2Nf8ztrNgp4ha0aJbIuWVoL7P0RcbOC2FQ3neGb/jKYIPuJyw=
X-Received: by 2002:a9d:5d13:: with SMTP id b19mr2406784oti.75.1602851364944; 
 Fri, 16 Oct 2020 05:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <2baf958b-80bd-778e-e0e8-b03364a942a6@ilande.co.uk>
In-Reply-To: <2baf958b-80bd-778e-e0e8-b03364a942a6@ilande.co.uk>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Fri, 16 Oct 2020 14:29:13 +0200
Message-ID: <CABLmASE7PVhb7DStd2MU+3u=QDH-ynohVNGYhD7CkvrkfpX5Hg@mail.gmail.com>
Subject: Re: aio_poll() assertion fail on Windows
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: multipart/alternative; boundary="0000000000003c3ecb05b1c8ea74"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=hsp.cat7@gmail.com; helo=mail-ot1-x32f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003c3ecb05b1c8ea74
Content-Type: text/plain; charset="UTF-8"

On Fri, Oct 16, 2020 at 1:32 PM Mark Cave-Ayland <
mark.cave-ayland@ilande.co.uk> wrote:

> Whilst testing a Windows build of git master of qemu-system-ppc in
> MSYS2/MingW64 I
> noticed the following assertion message in the console after booting into
> OpenBIOS
> and then closing the GTK GUI window without booting a client OS:
>
> $ ./qemu-system-ppc
> **
> ERROR:../util/aio-win32.c:337:aio_poll: assertion failed:
> (in_aio_context_home_thread(ctx))
> Bail out! ERROR:../util/aio-win32.c:337:aio_poll: assertion failed:
> (in_aio_context_home_thread(ctx))
>
> Has anyone else seen this at all?
>
>
> ATB,
>
> Mark.
>
>
Same here with SDL and GTK.

C:\qemu-master-msys2>qemu-system-ppc.exe -L pc-bios -sdl -boot c -m 512 -M
mac99,via=pmu
**
ERROR:../util/aio-win32.c:337:aio_poll: assertion failed:
(in_aio_context_home_thread(ctx))
Bail out! ERROR:../util/aio-win32.c:337:aio_poll: assertion failed:
(in_aio_context_home_thread(ctx))

Best,
Howard

--0000000000003c3ecb05b1c8ea74
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 16, 2020 at 1:32 PM Mark =
Cave-Ayland &lt;<a href=3D"mailto:mark.cave-ayland@ilande.co.uk" target=3D"=
_blank">mark.cave-ayland@ilande.co.uk</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">Whilst testing a Windows build of git =
master of qemu-system-ppc in MSYS2/MingW64 I <br>
noticed the following assertion message in the console after booting into O=
penBIOS <br>
and then closing the GTK GUI window without booting a client OS:<br>
<br>
$ ./qemu-system-ppc<br>
**<br>
ERROR:../util/aio-win32.c:337:aio_poll: assertion failed: <br>
(in_aio_context_home_thread(ctx))<br>
Bail out! ERROR:../util/aio-win32.c:337:aio_poll: assertion failed: <br>
(in_aio_context_home_thread(ctx))<br>
<br>
Has anyone else seen this at all?<br>
<br>
<br>
ATB,<br>
<br>
Mark.<br>
<br></blockquote><div>=C2=A0</div><div>
<div>Same here with SDL and GTK.<br></div><div><br></div><div>C:\qemu-maste=
r-msys2&gt;qemu-system-ppc.exe -L pc-bios -sdl -boot c -m 512 -M mac99,via=
=3Dpmu<br>**<br>ERROR:../util/aio-win32.c:337:aio_poll: assertion failed: (=
in_aio_context_home_thread(ctx))<br>Bail out! ERROR:../util/aio-win32.c:337=
:aio_poll: assertion failed: (in_aio_context_home_thread(ctx))</div><div>=
=C2=A0</div>

</div><div>Best,</div><div>Howard<br></div></div></div>

--0000000000003c3ecb05b1c8ea74--

