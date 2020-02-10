Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8C6C2BA83
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 00:35:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9126B20870
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 00:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rkk27CIX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9126B20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0x2T-0003Mn-Qd
	for qemu-devel@archiver.kernel.org; Sun, 09 Feb 2020 19:35:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j0x1u-0002w1-BJ
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 19:34:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j0x1t-0000eQ-9r
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 19:34:26 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43921)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j0x1t-0000dO-2h
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 19:34:25 -0500
Received: by mail-oi1-x243.google.com with SMTP id p125so7615272oif.10
 for <qemu-devel@nongnu.org>; Sun, 09 Feb 2020 16:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=zIkQcP9BpIJyzgjaUlbE7kr2g9ZhmdNsQJmm2E9D+OI=;
 b=rkk27CIX4HotpKyIdedfP6NCwrbnxtEEhneMkbxadbWS40SnL81MKLutEaJ200ZxDS
 CFXxHeFV0TFoE1zn5dX+lYTLrrH9gLESeqGMm256kgtFtrboumn3A/U/hwl1uleVkc2t
 r8u3VB8goIcSUebab6cI5xSUcYOtO/zGSmCVlomjRUkXmRp1Nr69K5RrHeWCOkFGZClF
 IXRHLks4DnvSL7bF/7py1J+rjFOyKPMzQvv3b0kfKDWn9j4WWR+bEXDHYTkAZPHlBJf5
 P0INFFAMSP4usi5T7U/RYNqqfZEWhnlufWcw+4t2Mu8fZD7iTQnVkDXMF1XlZTvH3hkJ
 636Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=zIkQcP9BpIJyzgjaUlbE7kr2g9ZhmdNsQJmm2E9D+OI=;
 b=YctEfx6ovz2veeBuuuHaR0wqjcRfXeG65k/Zu+aVma8AYn4t5HHX74Jodyw7l2DPaw
 XWFyanV0XW945mtrSRDn0SgW6oq5Tr41PN5ckHlU5Hq60BinF008Mc9FQgDi518Eu6dj
 V6vCr4F6+AfV595XlonmMmh713sAGaqmkJqUou5RAK5mYQDgk568f2oTj7x3mTdV2Ia2
 4o4l5CzlG+LDQz37JIV9CauqpetBqp2qsRtg7L5OfFAdLJ3NbtTiDRHZyFuPwIo7jfe4
 MU1jIafoHxd5D+/KLOx+2R+NVy69lMRDKHJvoQd0YfIndI6PFgW+E0ptVXnLp14yw+EE
 M3qw==
X-Gm-Message-State: APjAAAUWnrtpMdAZe4KJNtMwtVStxGOXS3VYEkArPJoCwbwAu5yOk5Qd
 yIsUZskpfRuPHgT5RviIVcq3Qs0TbxkFDW75SXA=
X-Google-Smtp-Source: APXvYqxdMu2xEz1KJRw9ierzzo4H2rgiCx3pGAy8C0LDwEZUbTO6tpdpUrYsmEYd7IR9O7edsnKggRWC5O4yfSsohw8=
X-Received: by 2002:a05:6808:64e:: with SMTP id
 z14mr8706218oih.79.1581294864034; 
 Sun, 09 Feb 2020 16:34:24 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Sun, 9 Feb 2020 16:34:23 -0800 (PST)
In-Reply-To: <20200206173040.17337-1-peter.maydell@linaro.org>
References: <20200206173040.17337-1-peter.maydell@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 10 Feb 2020 01:34:23 +0100
Message-ID: <CAL1e-=hx4hKuj0r7v6zcpjS5EE2pKoP2JLnUFYEQfdADzfkt1g@mail.gmail.com>
Subject: Re: [PATCH 00/29] Convert QAPI doc comments to generate rST instead
 of texinfo
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000a7ee70059e2de667"
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a7ee70059e2de667
Content-Type: text/plain; charset="UTF-8"

On Thursday, February 6, 2020, Peter Maydell <peter.maydell@linaro.org>
wrote:

>
> > This series switches all our QAPI doc > > > comments over from
> > texinfo format to rST.
>
>
Regardeless of the outcome of the discussions over this series, I just want
to say that I support it as a potential user of the document (there is no
"Supported-by:" mark or similar, so this is all I can do). Also, as a
general participant in QEMU community,  I seems to me this is a significant
step in shaping up QEMU documentation.

Best regards,
Aleksandar



>
>

--000000000000a7ee70059e2de667
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, February 6, 2020, Peter Maydell &lt;<a href=3D"mailto:=
peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex"><br>&gt; This series switches all our QAPI doc &gt=
; &gt; &gt; comments over from<br>&gt; texinfo format to rST.<br>
<br></blockquote><div><br></div><div>Regardeless of the outcome of the disc=
ussions over this series, I just want to say that I support it as a potenti=
al user of the document (there is no &quot;Supported-by:&quot; mark or simi=
lar, so this is all I can do). Also, as a general=C2=A0participant in QEMU =
community, =C2=A0I seems to me this is a significant step in shaping up QEM=
U documentation.</div><div><br></div><div>Best regards,</div><div>Aleksanda=
r</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
</blockquote>

--000000000000a7ee70059e2de667--

