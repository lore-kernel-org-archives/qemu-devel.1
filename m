Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C841C2D0D3
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 20:06:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A42520718
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 20:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+LVjlR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A42520718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1im1J3-0005z0-76
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 15:06:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1im1ID-0005Rz-NQ
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 15:05:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1im1IC-0004C2-11
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 15:05:33 -0500
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:37929)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1im1IB-00049i-P6; Mon, 30 Dec 2019 15:05:31 -0500
Received: by mail-il1-x143.google.com with SMTP id f5so28671443ilq.5;
 Mon, 30 Dec 2019 12:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=g9X2mXf5DKOk0UjALzlwCxcS5bofOS+FPHTLLKTZLb0=;
 b=U+LVjlR9VUfWJd8YR/HXe5XyBRM3BY0WeDDqFP/xXyqFIOaLMggKICSb4FJtrNmNb+
 XLJ1sLfJWIKBC7IFYDR9H2+gBs6OSnDIRESmYqlTXtEeuSCy5wBS6lU7U9+E1wfW1kRN
 uZMmAoWvIl17c8w3wcd70L+T7q2D9DprlV6wXOqSWO9JkavImyoZW1Fjtajj3UGFT1uc
 p60OVoYId8kXY8ufspNBto0VPjatO7lg6K862otGeWaMaIv+rZP3Ypd2Abt2Ek+7e88v
 4WeKeZJPyogrr6MGQcQ+ZVYYpujpTzC8nIL6FJfiXcZpoQbrfV/sWkSnvGKdw9vW22Td
 aB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=g9X2mXf5DKOk0UjALzlwCxcS5bofOS+FPHTLLKTZLb0=;
 b=smKj+FUoByU9bYFdTqAW0pBwwzfwZHfUPnIkrgCRAdEKWVA7wWr4AEOHOls5C5SHqV
 tXjnh0d+3al3p2ys3Xka7oWWuhRYSwZ8Xx5TVm4uYB3yOGLyyyItp5ryyl53j+1eeRpI
 pv8+tdIwcM0hx9YoJd3cxNS/AvWwGX0qQr7SUlcjl3W3NFd0rXoK2yVBKbh+aQpkPMA0
 0MUXRZsmCRdBeoDQG0jNXfgFYBVJbxfB+yAh7nkPC7KPOyAPkmeYa2H7X5+/ro6QH82s
 CiWjafBnJQQ/qrTUpyb82BVQNr314zZKsJ+nh0evGkEnTb/oBJh+rgC9Gqdz5MGoSSF2
 ZgZg==
X-Gm-Message-State: APjAAAVTMXy+bihx8Zf+k6vvoJIs5ip3V16zujnG6SRhvVmgx8zByBSw
 kh6dvxQ0jUpqDl5tZQr0Fyxw7gRKpbSO+/rukWo=
X-Google-Smtp-Source: APXvYqzXxSC2IBjbjyYZY8uFgCDT+5fcS0Xoe+yivePI9lnNAckDpedhw8/Xx0DzpnG8ArDj0EaNR9vXval00uoz+Xs=
X-Received: by 2002:a92:d5cf:: with SMTP id d15mr56490425ilq.306.1577736330877; 
 Mon, 30 Dec 2019 12:05:30 -0800 (PST)
MIME-Version: 1.0
References: <20191230110953.25496-1-f4bug@amsat.org>
 <20191230110953.25496-7-f4bug@amsat.org>
 <CAPan3WrBN77rcczzQ1knMEKCaCUSCb6RtdhSMiDWE9Ah7jvgjg@mail.gmail.com>
 <9cdbe625-fe29-cb91-2ed4-1231953b3148@redhat.com>
In-Reply-To: <9cdbe625-fe29-cb91-2ed4-1231953b3148@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Mon, 30 Dec 2019 21:05:19 +0100
Message-ID: <CAPan3Wre4wsx+-CUBrkkDK_nwCkA-52OT0W3wS8-eM3bs7DaDQ@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] hw/arm/cubieboard: Disable unsupported M-USB in
 device tree blob
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000008d2163059af15d66"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::143
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008d2163059af15d66
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Philippe,

I took a second look at this and, it seems my previous suggestion was only
partly valid.
The kernel error you reported came from the driver in
drivers/usb/musb/sunxi.c. Apparently, this
is an Allwinner specific driver for M-USB. And I don't see it documented in
the A10 user manual.

On the other hand, the USB host interfaces EHCI/OHCI do apply for the A10
SoC and this board.
Linux has them defined in the DTB in arch/arm/boot/dts/sun4i-a10.dtsi
(ehci0/1, ohci0/1).
But probably that is for another patch/commit.

Regards,
Niek

On Mon, Dec 30, 2019 at 2:56 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> On 12/30/19 12:33 PM, Niek Linnenbank wrote:
> > Hello Philippe,
> >
> > I have a suggestion: probably you can apply (almost) the same patch to
> > get USB
> > working for A10 as I did in the Allwinner H3, in patch #4 "add USB host
> > controller" [1]
> > That way you can avoid the DTB modifications and with low effort get US=
B
> > working as well for this board.
> > As far as I can see, in Section 21.1 in the A10 user manual [2] has the
> > same description
> > as for the H3. It basically has the standard EHCI and OHCI interfaces.
>
> Oh good news. I guess in the long term we want a AllwinnerSoc parent
> class where all common blocks are mapped, and A10/H3 children with the
> differences. But we'll worry about that after your H3 series get merged.
>
> > [1] https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg03266.html
> > [2] https://linux-sunxi.org/File:Allwinner_A10_User_manual_V1.5.pdf
> >
> > Regards,
> > Niek
>
>

--=20
Niek Linnenbank

--0000000000008d2163059af15d66
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hey Philippe,<br></div><div><br></div><di=
v>I took a second look at this and, it seems my previous suggestion was onl=
y partly valid.</div><div> The kernel error you reported came from the driv=
er in drivers/usb/musb/sunxi.c. Apparently, this</div><div>is an Allwinner =
specific driver for M-USB. And I don&#39;t see it documented in the A10 use=
r manual.</div><div><br></div><div>On the other hand, the USB host interfac=
es EHCI/OHCI do apply for the A10 SoC and this board.</div><div>Linux has t=
hem defined in the DTB in arch/arm/boot/dts/sun4i-a10.dtsi (ehci0/1, ohci0/=
1).</div><div>But probably that is for another patch/commit.</div><div><br>=
</div><div>Regards,</div><div>Niek<br></div><div><br></div><div class=3D"gm=
ail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 30, 2019 at 2:=
56 PM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">=
philmd@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">On 12/30/19 12:33 PM, Niek Linnenbank wrote:<br>
&gt; Hello Philippe,<br>
&gt; <br>
&gt; I have a suggestion: probably you can apply (almost) the same patch to=
 <br>
&gt; get USB<br>
&gt; working for A10 as I did in the Allwinner H3, in patch #4 &quot;add US=
B host <br>
&gt; controller&quot; [1]<br>
&gt; That way you can avoid the DTB modifications and with low effort get U=
SB <br>
&gt; working as well for this board.<br>
&gt; As far as I can see, in Section 21.1 in the A10 user manual [2] has th=
e <br>
&gt; same description<br>
&gt; as for the H3. It basically has the standard EHCI and OHCI interfaces.=
<br>
<br>
Oh good news. I guess in the long term we want a AllwinnerSoc parent <br>
class where all common blocks are mapped, and A10/H3 children with the <br>
differences. But we&#39;ll worry about that after your H3 series get merged=
.<br>
<br>
&gt; [1] <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2019-12/m=
sg03266.html" rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.org/ar=
chive/html/qemu-devel/2019-12/msg03266.html</a><br>
&gt; [2] <a href=3D"https://linux-sunxi.org/File:Allwinner_A10_User_manual_=
V1.5.pdf" rel=3D"noreferrer" target=3D"_blank">https://linux-sunxi.org/File=
:Allwinner_A10_User_manual_V1.5.pdf</a><br>
&gt; <br>
&gt; Regards,<br>
&gt; Niek<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--0000000000008d2163059af15d66--

