Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59634C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:10:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22B71205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMAhxGsG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B71205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGkG4-0002lL-BL
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 10:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55287)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jGkFJ-00025X-62
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:09:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jGkFI-0007wT-5n
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:09:33 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:33501)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jGkFF-0007oy-Sz; Tue, 24 Mar 2020 10:09:30 -0400
Received: by mail-lf1-x142.google.com with SMTP id c20so13356651lfb.0;
 Tue, 24 Mar 2020 07:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DHFErVccaVagAISXs0hS/UGpos4OgSey3xf3EzZnx1k=;
 b=NMAhxGsGVn5FC1Vrj2u5ltFb4dmdfxj/5Xb5pm2Wnc6KwRqemLRSIhObutcchgNKup
 F3ZE9LpBiP9b2iDRi6/Sktl5pqmzSDu5a9aKmffFTg5DixrOLJ2+MSRgDCtnCk8aQQxC
 rRNLJGtmxeLLwZQ+Qg4vNxAEpVdN4rJOtm2XrecX6+MT/w05xJ+QZ2aJnRzsqpIinAgc
 o/jceiQshCXQkaHC+fDYCjWbvU7usPRft4J5QE3fi4Kym2eo7ZnZyT6rYtGZnbHsEmjS
 Uz18eunPWox7Aljjh2NQl9XjLraiheiQ/1kHAsARSrD8ms2zHVOl+gnm1oJs6Bvs+RQ0
 p1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DHFErVccaVagAISXs0hS/UGpos4OgSey3xf3EzZnx1k=;
 b=KIW2Mf/2OP3fVlqBc76tZcnStLHgfeu0dXK0gy75lPoyTAtJb2jTNw8Al/zLgNXNKZ
 TOlw2u5DKz8annQs1k/zVMeqkH/aYwMoYABytdAUXd86fVm9U702cJws8F9/wMc/E3Fu
 tyHr5Ps8ejkvNyGOvQU1cX9jGl9VWgLKp76GAQ7KiFyf9VJaSEqXFUxN2z2D/JkOv1yB
 frCGYrd6T6FLH8dJBoweQ9mdP773hWd/SEf8D4fOOQfkJU942qInJ7K53ipQuW2eZOCX
 cjqfElhBvutFBVO4EIBDzpK3bSgU2GLR5Mow3X+BlJz5bLq1xoUcXuPJkEElY/zY1Aph
 lRNg==
X-Gm-Message-State: ANhLgQ30U38uxU1FPWX2Dv24LnBSPhfmG9d87MMsqyVDAFPVrwktqOWf
 Z+cCRVUgSZ7nv687yWkG9MBUAcmuHSrjgjyOUBY=
X-Google-Smtp-Source: ADFU+vvZQoqv+rOc4vT+XwiPHF3AuU0smVlO56GDEcLh7gMCCbz1oQ4/y2wgkQ8FM5ci2fGT6CoEYkBb4TsKGUow8rs=
X-Received: by 2002:ac2:42c5:: with SMTP id n5mr5739242lfl.20.1585058966934;
 Tue, 24 Mar 2020 07:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200324134947.15384-1-peter.maydell@linaro.org>
In-Reply-To: <20200324134947.15384-1-peter.maydell@linaro.org>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 24 Mar 2020 15:10:24 +0100
Message-ID: <CAJy5ezqmUqProhrbqD1gmJ61jMU740CwjPiAyOLjDjSk75iDgA@mail.gmail.com>
Subject: Re: [PATCH 0/2] hw/arm/xlnx-zynqmp.c: fix some error-handling code
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000ac201705a19a4cf1"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
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
Cc: qemu-arm <qemu-arm@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ac201705a19a4cf1
Content-Type: text/plain; charset="UTF-8"

On Tue, Mar 24, 2020 at 2:49 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

> This series fixes some minor bugs in error-handling paths
> in the xlnx-zynqmp device. The first is a memory leak spotted
> by Coverity; the second is some missing error-propagation code
> that I noticed while writing the first patch.
>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


>
> thanks
> -- PMM
>
> Peter Maydell (2):
>   hw/arm/xlnx-zynqmp.c: Avoid memory leak in error-return path
>   hw/arm/xlnx-zynqmp.c: Add missing error-propagation code
>
>  hw/arm/xlnx-zynqmp.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>
> --
> 2.20.1
>
>

--000000000000ac201705a19a4cf1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 24, 2020 at 2:49 PM Peter=
 Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@lina=
ro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">This series fixes some minor bugs in error-handling paths<br>
in the xlnx-zynqmp device. The first is a memory leak spotted<br>
by Coverity; the second is some missing error-propagation code<br>
that I noticed while writing the first patch.<br></blockquote><div><br></di=
v><div>Reviewed-by: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.iglesias@=
xilinx.com">edgar.iglesias@xilinx.com</a>&gt;<br></div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
<br>
thanks<br>
-- PMM<br>
<br>
Peter Maydell (2):<br>
=C2=A0 hw/arm/xlnx-zynqmp.c: Avoid memory leak in error-return path<br>
=C2=A0 hw/arm/xlnx-zynqmp.c: Add missing error-propagation code<br>
<br>
=C2=A0hw/arm/xlnx-zynqmp.c | 27 ++++++++++++++++++++++++++-<br>
=C2=A01 file changed, 26 insertions(+), 1 deletion(-)<br>
<br>
-- <br>
2.20.1<br>
<br>
</blockquote></div></div>

--000000000000ac201705a19a4cf1--

