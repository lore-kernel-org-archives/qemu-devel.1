Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4E0C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 20:21:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E7582173E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 20:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biYg6He5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E7582173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idK6j-00063j-MN
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 15:21:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1idK5q-0005Vz-8i
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 15:20:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1idK5o-0002gP-Vn
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 15:20:50 -0500
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:33990)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1idK5l-0002T4-4w; Fri, 06 Dec 2019 15:20:45 -0500
Received: by mail-io1-xd43.google.com with SMTP id z193so8632636iof.1;
 Fri, 06 Dec 2019 12:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VPrqLSDF6cbyZzlOcEit277juDu8n1Mg9FZXYf0DkF8=;
 b=biYg6He5J7jIk7sNgqpqyTA6deV7GDILYQE8zyKyRPVkR9r+Cq0+bIz2ji3lcUPATg
 wXmNwlEgPjVJY1sOU4Mu5g3gt/0nlAAqYQZbp63N0GWTnG3PkegYYPRlslUjW08etW43
 gZk736CpE1P2nmwp7H4tb43tU3ExA4ZYKK8xfgU1hrc8wNFrvXiuZtuEOsvswMR7Dv8Z
 PQABx4Q7r9Ro8JElzczbgvCU3x0OKwNePjG8UPjGGLp8LXGpqLFWcojGQ/raK2WXffAu
 0GMGxFW3dqJvKGRrjP/kQdGDDypcOsBewFIqZN5dedBREXKa2MqsekjmfAdh6adS896Z
 F30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VPrqLSDF6cbyZzlOcEit277juDu8n1Mg9FZXYf0DkF8=;
 b=uoIFLYLAFsQ1fUC6L2JGFO4bKTLR7r5B+Szmw9geq7EOJbbN5pZeRi3891vuS98sy8
 B0IFa/i3TkcCOuCOMNfDUg6bGUApGtZJpXv7Jwz3h94X3Oh217mOd+xExFLByTOIm8lr
 hAB8gIs+1S3i0Q7Zo6kiRIB86lrRWa4TK5sGRpxbqsXmKbQgf0kl/r39UvxRzo8CrCZR
 bY1iQgPnub2ldbVK+J9td3VChv4COjZMG+uxplllSGXzZWhtg4YG9/9PG86yn5+2lkoX
 YOMH/2E+HI1LaBxUjaJLKOQ4Zl8nPnuTxNyR313O1Mqm+Ld0MGZWAmNMEsPriGBwAfTm
 Erbg==
X-Gm-Message-State: APjAAAWRKZqY0C7x7J07kzSgfsUm7Bpwj6D664q0aMS+oTCNOol64QG4
 tD71Nokwqxa+8A6WY0GjGoYZmdcKXifQ8j1IKHg=
X-Google-Smtp-Source: APXvYqzy1wc5GhvRQa4kq+0rg0yFrpFJiSpnEgtxgHU7niY8F/hmb17DweDzkPhQKp234OIyx2IMHC6je4jahUQki6U=
X-Received: by 2002:a5d:8f17:: with SMTP id f23mr12298036iof.265.1575663644369; 
 Fri, 06 Dec 2019 12:20:44 -0800 (PST)
MIME-Version: 1.0
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <20191202210947.3603-9-nieklinnenbank@gmail.com>
 <CAFEAcA-1Re0noxPN04uXqRYX=-g97jtiweZA=WcFo1OwXBoN5w@mail.gmail.com>
 <41ab9f5a-3318-b412-44e8-f8571a64da64@redhat.com>
In-Reply-To: <41ab9f5a-3318-b412-44e8-f8571a64da64@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Fri, 6 Dec 2019 21:20:33 +0100
Message-ID: <CAPan3Wq_fFcHb1TR5bP0O4T8mRo73Fi5Fe-8VNw93Cv6jwLg=g@mail.gmail.com>
Subject: Re: [PATCH 08/10] arm: allwinner-h3: add Security Identifier device
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ceea9005990ec7cb"
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

--000000000000ceea9005990ec7cb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Peter, Philippe,

On Fri, Dec 6, 2019 at 5:35 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om>
wrote:

> On 12/6/19 3:27 PM, Peter Maydell wrote:
> > On Mon, 2 Dec 2019 at 21:10, Niek Linnenbank <nieklinnenbank@gmail.com>
> wrote:
> >>
> >> The Security Identifier device in Allwinner H3 System on Chip
> >> gives applications a per-board unique identifier. This commit
> >> adds support for the Allwinner H3 Security Identifier using
> >> randomized data as input.
> >
> > If this is a fixed value in hardware, I'm not sure that
> > having the QEMU model pick a random value is the best
> > choice. If we just set it to a fixed value in QEMU, is
> > that going to cause problems?
> >
> > (Generally it's nice for QEMU to be deterministic, so it
> > behaves the same way every time you run it. Also if it's
> > always the same we don't need to bother migrating the
> > ID value.)
>
> Agreed. Since the identifier is 128-bit, I'd use DEFINE_PROP_UUID() or,
> to be even safer, DEFINE_PROP_UUID_NODEFAULT().
> See how the ipmi-bmc-sim device checks its guid field and fails if unset.
>

Thank you both for clarifying this. OK, I'll update this patch such that
the identifier is fixed,
using the functions Philippe suggested.

The reason I originally chose to make it randomized is that U-Boot mainline
reads out the
SID data in order to create a MAC address for the ethernet device. So when
a user runs multiple
QEMU machines inside a virtualized network, they will get the same MACs if
the SID isnt unique.
However this problem can also be solved very easy with U-Boot itself by
just overriding the ethaddr environment variable.

For your interest, in the U-Boot source you can see this behaviour in the
file
arch/arm/mach-sunxi/cpu_info.c:139 in sunxi_get_sid(), sun8i_efuse_read()
where it reads the SID
and in board/sunxi/board.c:782 in setup_environment() where it uses the SID
to create the MAC address.

Regards,
Niek

--=20
Niek Linnenbank

--000000000000ceea9005990ec7cb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hey Peter, Philippe,<br></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Dec 6, 2019 at 5:35 P=
M Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">phil=
md@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">On 12/6/19 3:27 PM, Peter Maydell wrote:<br>
&gt; On Mon, 2 Dec 2019 at 21:10, Niek Linnenbank &lt;<a href=3D"mailto:nie=
klinnenbank@gmail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt; w=
rote:<br>
&gt;&gt;<br>
&gt;&gt; The Security Identifier device in Allwinner H3 System on Chip<br>
&gt;&gt; gives applications a per-board unique identifier. This commit<br>
&gt;&gt; adds support for the Allwinner H3 Security Identifier using<br>
&gt;&gt; randomized data as input.<br>
&gt; <br>
&gt; If this is a fixed value in hardware, I&#39;m not sure that<br>
&gt; having the QEMU model pick a random value is the best<br>
&gt; choice. If we just set it to a fixed value in QEMU, is<br>
&gt; that going to cause problems?<br>
&gt; <br>
&gt; (Generally it&#39;s nice for QEMU to be deterministic, so it<br>
&gt; behaves the same way every time you run it. Also if it&#39;s<br>
&gt; always the same we don&#39;t need to bother migrating the<br>
&gt; ID value.)<br>
<br>
Agreed. Since the identifier is 128-bit, I&#39;d use DEFINE_PROP_UUID() or,=
 <br>
to be even safer, DEFINE_PROP_UUID_NODEFAULT().<br>
See how the ipmi-bmc-sim device checks its guid field and fails if unset.<b=
r></blockquote><div><br></div><div>Thank you both for clarifying this. OK, =
I&#39;ll update this patch such that the identifier is fixed,</div><div>usi=
ng the functions Philippe suggested.</div><div><br></div><div>The reason I =
originally chose to make it randomized is that U-Boot mainline reads out th=
e</div><div>SID data in order to create a MAC address for the ethernet devi=
ce. So when a user runs multiple</div><div>QEMU machines inside a virtualiz=
ed network, they will get the same MACs if the SID isnt unique.</div><div>H=
owever this problem can also be solved very easy with U-Boot itself by just=
 overriding the ethaddr environment variable.<br></div><div><br></div><div>=
For your interest, in the U-Boot source you can see this behaviour in the f=
ile</div><div>arch/arm/mach-sunxi/cpu_info.c:139 in sunxi_get_sid(), sun8i_=
efuse_read() where it reads the SID</div><div>and in board/sunxi/board.c:78=
2 in setup_environment() where it uses the SID to create the MAC address.<b=
r></div></div><div><br></div><div>Regards,</div><div>Niek<br></div><br>-- <=
br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Niek Li=
nnenbank<br><br></div></div></div></div>

--000000000000ceea9005990ec7cb--

