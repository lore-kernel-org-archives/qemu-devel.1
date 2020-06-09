Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A7EC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:54:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DC352078C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkovwpeR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC352078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jicpu-0003Rm-Nx
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 07:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jicpK-000318-Rx
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:53:58 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:42162)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jicpJ-0008Ts-Vz
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:53:58 -0400
Received: by mail-wr1-x42c.google.com with SMTP id p5so20945512wrw.9
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 04:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W9rtZMnFfHVqq4WWlnRO3AXWNNYYVG6o/bhND9jW2IA=;
 b=gkovwpeRirxa99WQLXLF+btnS8pQCyAxXWI5ysZ3Sft87zTtUVJetSab5Hl21Iom8A
 BE2xM0x7A3ixeIiv+WcW0AVvzazP3Fm7SK6jB/28/otIOki/S85q6yGyBlzJkzhSgPDz
 NS17o9CZh7U7aH0cqBcFeGfFnDq867feT/FD+gUt9FAUq8sFU6WUp2m4O5JVOtEOGeP2
 MOFTTohJz4oTJmTrAD4mRrgPULPVK996cIrnFN+h9EQuO02xJF9ThcumPlh6toAsqliY
 eeIRCO7emGkn9i96djtqNrlqiV/Y+vkkaHEsRhgln1hE6AVL1vgeAn3iMnjkG4dJDpQf
 R1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W9rtZMnFfHVqq4WWlnRO3AXWNNYYVG6o/bhND9jW2IA=;
 b=JV3+c9PeIS1D+RNy8KotctZ4CL5bLI7aubyXDxS0zzaaLNGqWzt6WneipsurTCNrNh
 Hh4u5fbdxBRDCHkabwY1TNla/YmpkbrisKvIHWow6984+aOBv4WhTSrE+Xn2t16jcR63
 s1ibdR1mmjKgKHXYTrLXjVZDXgzmQqtcw6e+PL1Go/4jUBNhN2cwlai6UxZNlhHbBcU3
 9v5t8di/RiajdBAzwzz/I1PN5NOjP1T+ZyvT7FVnkv4CHLO5/IJjG4kDC97ubpN7o7oz
 j08wnGEcwBJLxPjKsXdN7wCePp7dbexp27wpZihGV8hPPCFX34pqVUMKEv1+qkGXY3Y6
 CNIw==
X-Gm-Message-State: AOAM533Fwn99SC55TFwtzY37VvLrhlLl1WenbiywI0IEmCMAIfcK1ggU
 r4ef45g2k5cfmPRGxdpUvVRqX6MOUqpIPDJ/sEI=
X-Google-Smtp-Source: ABdhPJwDWHPFG63MGDgqc3cwil/wUcqHH55qWpcJbaRyiU41O92W6HAxQCOtG0nj8gv5ehbhFzcm0WRrLwOOjFdjxhs=
X-Received: by 2002:adf:fec8:: with SMTP id q8mr4194024wrs.2.1591703635855;
 Tue, 09 Jun 2020 04:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <ba26c2d65cda15b581c1a7cc7274d1b2@posteo.de>
In-Reply-To: <ba26c2d65cda15b581c1a7cc7274d1b2@posteo.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 9 Jun 2020 15:53:43 +0400
Message-ID: <CAJ+F1CKJbOJBOxpd2guyU_iuqoVYNGJWRAinGWXoPT_hqjBgSg@mail.gmail.com>
Subject: Re: Using QXL & Spice with Windows Host & QEMU
To: laurens.nikolaisen@posteo.de
Content-Type: multipart/alternative; boundary="000000000000cd8cd305a7a561a2"
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wr1-x42c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_EXCESS_BASE64=0.979, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU <qemu-devel@nongnu.org>, Frediano Ziglio <fziglio@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000cd8cd305a7a561a2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Jun 9, 2020 at 3:30 PM <laurens.nikolaisen@posteo.de> wrote:

> Hello everyone,
>
> when using Qemu 4.2.0 with a Windows host, qemu-system-x86_64 reports:
> "QXL VGA not available"
>
> I used the following Qemu args for testing:
> qemu-system-x86-x64.exe -accel hax -machine q35 -m 4GB -cdrom
> xubuntu-20.04-desktop-amd64.iso
>
> Using either "-vga stdt" or "-vga vmware" works. The performance is just
> not that good.
>
> Do I have a chance to get spice & QXL up and running with a Windows 10
> host and
> Qemu?
>

Frediano gave you an answer on spice-devel (
https://lists.freedesktop.org/archives/spice-devel/2020-June/051699.html).

You probably need a recent release of qemu too, and make sure to enable
spice & qxl. How did you build qemu?

Beware that Spice on Windows hasn't probably been tested much so far, you
are on the forefront!


--=20
Marc-Andr=C3=A9 Lureau

--000000000000cd8cd305a7a561a2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 9, 2020 at 3:30 PM &lt;=
<a href=3D"mailto:laurens.nikolaisen@posteo.de">laurens.nikolaisen@posteo.d=
e</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>Hello everyone,<br>
<br>
when using Qemu 4.2.0 with a Windows host, qemu-system-x86_64 reports:<br>
&quot;QXL VGA not available&quot;<br>
<br>
I used the following Qemu args for testing:<br>
qemu-system-x86-x64.exe -accel hax -machine q35 -m 4GB -cdrom<br>
xubuntu-20.04-desktop-amd64.iso<br>
<br>
Using either &quot;-vga stdt&quot; or &quot;-vga vmware&quot; works. The pe=
rformance is just<br>
not that good.<br>
<br>
Do I have a chance to get spice &amp; QXL up and running with a Windows 10 =
<br>
host and<br>
Qemu?<br></blockquote><div><br></div><div>Frediano gave you an answer on sp=
ice-devel (<a href=3D"https://lists.freedesktop.org/archives/spice-devel/20=
20-June/051699.html">https://lists.freedesktop.org/archives/spice-devel/202=
0-June/051699.html</a>).</div><div><br></div><div>You probably need a recen=
t release of qemu too, and make sure to enable spice &amp; qxl. How did you=
 build qemu?</div><div><br></div><div>Beware that Spice on Windows hasn&#39=
;t probably been tested much so far, you are on the forefront!</div><br cle=
ar=3D"all"></div><br>-- <br><div dir=3D"ltr" class=3D"gmail_signature">Marc=
-Andr=C3=A9 Lureau<br></div></div>

--000000000000cd8cd305a7a561a2--

