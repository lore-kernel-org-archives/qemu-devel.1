Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5844BC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 23:50:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2390D20733
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 23:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZnxeU3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2390D20733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZO7m-0002Oo-AR
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 18:50:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49585)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZO6x-0001sr-FD
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 18:49:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZO6w-0005rs-8L
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 18:49:43 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43721)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iZO6w-0005rQ-08
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 18:49:42 -0500
Received: by mail-oi1-x243.google.com with SMTP id l20so14887728oie.10
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 15:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=pzxB+2x1A1QYYIl9aZS755+JllTCGBNn1auAAxud3YU=;
 b=JZnxeU3PSmYcVYTInEg4XaQMKiqOev7KBhbao2U4EMpzBhmBnNHXd4rDtOZl29jVz9
 Ie5fYaAYYekepdyqwIuUD+1ViRj/+VtMvxHXvypX/G+hNDzSuz2AQ82HTlZL3Zxv8H9j
 7KgFT+sHWJCFHpI8Q5Awcw8jqFlVwLyNnqXq+pE0pK4gQiUqQAuDO7E8lZfpdUqi+sx1
 9uhSLQ7kSYxkTEE3/TaZDzC/dx2oZX/2eZmxqUvIizUVFrVhOL9pi/7Jth0cN8/NmeMJ
 oOeemnTm2s8JAr7qBdPaGVAjUYkFUEVpChLg7S5OoggHAY/Npm1Ro8VRB0nlcGbOhvQQ
 6TlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=pzxB+2x1A1QYYIl9aZS755+JllTCGBNn1auAAxud3YU=;
 b=lbn6xkzSbgKAI1HIIUID982Iy6cYGEtTZOmi8HiuGPWDO2+wnbnkjLOVA63L0TGFC+
 jGSxSYWeDqhTe4g068jKNIrczuIduga0deOUKmg4z7C2yUwqvmYWc7eQ9IYIDagA9nMM
 PA5ydSfue3HgZbaB8afcp9FYZdfW3hTRfAm4F3R/OAraTmwuUIsJc0bd0e5smMkEM3Lc
 JyVbE2GGJoZOKvw1ZpljbTl3DAJXX0wSW8BedNUSohDHOtaMWzHU9DBwGph+wK6Ndx1K
 oMxQNxmBM4B4qJvGVmh5oJ7wzHjXnkRbAr4lSUnNVHCAPjldlzaKnSvSCmsOwOsSHtaS
 mt4Q==
X-Gm-Message-State: APjAAAX+hmpR3xPpaBzrvu9tx+XX8tmUa3mHZPBqlEAoGiiPo+EweuBh
 ghr+SnooSrjtI7r9b31kyUXF1S75CXP82qWBoTg=
X-Google-Smtp-Source: APXvYqxCkxKzwRBw2Iyady7mHDLHm8VNBGSSDDIjbJf1QbGEMg1etr7uzQznOIW3NTZQebntNVpJjqPsjS/McVbfKvQ=
X-Received: by 2002:aca:6287:: with SMTP id w129mr1138929oib.106.1574725781114; 
 Mon, 25 Nov 2019 15:49:41 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Mon, 25 Nov 2019 15:49:40
 -0800 (PST)
In-Reply-To: <20191124050225.30351-18-mrolnik@gmail.com>
References: <20191124050225.30351-1-mrolnik@gmail.com>
 <20191124050225.30351-18-mrolnik@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 26 Nov 2019 00:49:40 +0100
Message-ID: <CAL1e-=i9=1PSD8coYae4AGeW_uiRHXVM8UvKnLdSW_tWRcMYgA@mail.gmail.com>
Subject: Re: [PATCH v36 17/17] target/avr: Update MAINTAINERS file
To: Michael Rolnik <mrolnik@gmail.com>, Cleber Rosa <crosa@redhat.com>, 
 Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000cd55920598346a4d"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000cd55920598346a4d
Content-Type: text/plain; charset="UTF-8"

On Sunday, November 24, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:

> Include AVR maintaners in MAINTAINERS file
>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5e5e3e52d6..ad2d9dd04a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -163,6 +163,15 @@ S: Maintained
>  F: hw/arm/smmu*
>  F: include/hw/arm/smmu*
>
> +AVR TCG CPUs
> +M: Michael Rolnik <mrolnik@gmail.com>
> +S: Maintained
> +F: target/avr/
> +F: hw/misc/avr_mask.c
> +F: hw/char/avr_usart.c
> +F: hw/timer/avr_timer16.c
> +F: hw/avr/
> +


If Cleber and Eduardo don't object, please add file:

tests/acceptance/machine_avr6.py

to the list. This means that the file would have a sort of "dual"
maintainrship: Cleber and Eduardo would take care of Python/Avocado/test
harness aspects, while you and Sarah would take care of AVR aspects.

Cleber and Eduardo, please note that AVR target will be significantly
different than others, since these CPUs are not meant to work with Linux
kernel, and there are other idiosyncracies where AVR folks would be really
needed. There is also a case of MIPS-specific Avocado test where, at least
from my point of view, dual maintainership worked well, so I think this one
would work well too.

With or without that file addition:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>



>  CRIS TCG CPUs
>  M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>  S: Maintained
> --
> 2.17.2 (Apple Git-113)
>
>

--000000000000cd55920598346a4d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Sunday, November 24, 2019, Michael Rolnik &lt;<a href=3D"mailto:=
mrolnik@gmail.com">mrolnik@gmail.com</a>&gt; wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">Include AVR maintaners in MAINTAINERS file<br>
<br>
Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com">mrol=
nik@gmail.com</a>&gt;<br>
---<br>
=C2=A0MAINTAINERS | 9 +++++++++<br>
=C2=A01 file changed, 9 insertions(+)<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 5e5e3e52d6..ad2d9dd04a 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -163,6 +163,15 @@ S: Maintained<br>
=C2=A0F: hw/arm/smmu*<br>
=C2=A0F: include/hw/arm/smmu*<br>
<br>
+AVR TCG CPUs<br>
+M: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com">mrolnik@gmail.c=
om</a>&gt;<br>
+S: Maintained<br>
+F: target/avr/<br>
+F: hw/misc/avr_mask.c<br>
+F: hw/char/avr_usart.c<br>
+F: hw/timer/avr_timer16.c<br>
+F: hw/avr/<br>
+</blockquote><div><br></div><div>If Cleber and Eduardo don&#39;t object, p=
lease add file:</div><div><br></div><div><span style=3D"color:rgb(34,34,34)=
;font-size:14px;line-height:22.1200008392334px">tests/acceptance/machine_av=
r6.</span><wbr style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.1=
200008392334px"><span style=3D"color:rgb(34,34,34);font-size:14px;line-heig=
ht:22.1200008392334px">py</span><br></div><div><span style=3D"color:rgb(34,=
34,34);font-size:14px;line-height:22.1200008392334px"><br></span></div><div=
>to the list. This means that the file would have a sort of &quot;dual&quot=
; maintainrship: Cleber and Eduardo would take care of Python/Avocado/test =
harness aspects, while you and Sarah would take care of AVR aspects.</div><=
div><br></div><div>Cleber and Eduardo, please note that AVR target will be =
significantly different than others, since these CPUs are not meant to work=
 with Linux kernel, and there are other idiosyncracies where AVR folks woul=
d be really needed. There is also a case of MIPS-specific Avocado test wher=
e, at least from my point of view, dual maintainership worked well, so I th=
ink this one would work well too.</div><div><br></div><div>With or without =
that file addition:</div><div><br></div><div>Reviewed-by: Aleksandar Markov=
ic &lt;<a href=3D"mailto:amarkovic@wavecomp.com">amarkovic@wavecomp.com</a>=
&gt;</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0CRIS TCG CPUs<br>
=C2=A0M: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.iglesias@gmail.com">=
edgar.iglesias@gmail.com</a>&gt;<br>
=C2=A0S: Maintained<br>
-- <br>
2.17.2 (Apple Git-113)<br>
<br>
</blockquote>

--000000000000cd55920598346a4d--

