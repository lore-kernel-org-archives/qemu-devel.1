Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A730C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:27:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 540A821D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqQ6WZXf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 540A821D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j47ae-0006ZP-B0
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 13:27:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54465)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j47ZJ-0005S4-DV
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:26:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j47ZH-0000hr-QU
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:26:01 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46593)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j47ZH-0000h6-L9; Tue, 18 Feb 2020 13:25:59 -0500
Received: by mail-ot1-x341.google.com with SMTP id g64so20454787otb.13;
 Tue, 18 Feb 2020 10:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=4K3xw1SaK5WoQae/EBe4NbCH2vezOiTA6MMxG1Hf1z0=;
 b=FqQ6WZXfE2dAJ/guWqf7RvTDd4YRiWiSzoDIb3IYH1RlP7XB0ZnNG9bpCO4rJu3x8U
 XcIvm0Y+hAXHXD1x64wUeN0RJDa3vw4yZjaLsuV+/+8d6lKwrJO3WWKFFRFdR7gVfPj/
 KlW+LMFQzcVfy2hkhvNxLV80Gl0wcIiRMMxyM9lOx3LutCboTW/s32O5IJGHJNHNYSO1
 /UVj/YoPeGEtod+97Jy9tYUBf4UPnlXpz6HEOqMWGLA54nfEr0PNzGVuYXNaXD92bPa1
 BiS9LmNUa7MlNkyIXCv/k0hwJe53OIM4YGxPxu+sWJfSnlQci37O3q++zs9QwD1CnHy4
 ttZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=4K3xw1SaK5WoQae/EBe4NbCH2vezOiTA6MMxG1Hf1z0=;
 b=nmYvRAbdhz+J34tolZo1mMo/o50iwfQGR2f3VFPFsuhElU17OP+e2ypz0bTEnvqpKn
 pcCiTpEFCONPxPMEecCYz0aP0qu7z2Gag7pjdq7siLVl7r70DXwEvb2BQR9PeF0dUr0e
 2tITBfMqR31742wySY4KSI0IFsFvxyOsGWzYddXKJM1FBQDhB8y6+Uz77lWmqx5zbd3R
 P9RPFqCpeFVaFB0m0aw8L/ZLBXyzCAAp/QvTd2fnY8M6cu+hEseviCQfDP6OrDdM87r5
 K5N0Vf6a+NroBJhUiQy6wGG/mi2K8lMa/osVUpDEVsr8B7GuZpeulE32PxVhgXIGyG9Z
 DBAA==
X-Gm-Message-State: APjAAAUuFsln+TK4PbkXomA/q8LWIRR3qp6m9f5nu4gWcYeiOcb9ys7D
 GU/VE8IbMSbdtP3uu9ZmkcbU+lHYSNgUQ0MChSF42Q==
X-Google-Smtp-Source: APXvYqzv7GHKaX+YRBQ6Mo3CBHYFlOZcX/D0m47bHraxFTneDDT8Ncr9p0S9wCDQ8g8dq6XZcT8rIml80suEOONsOHY=
X-Received: by 2002:a9d:7305:: with SMTP id e5mr15951566otk.64.1582050358731; 
 Tue, 18 Feb 2020 10:25:58 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Tue, 18 Feb 2020 10:25:58 -0800 (PST)
In-Reply-To: <cover.1580290069.git.fthain@telegraphics.com.au>
References: <cover.1580290069.git.fthain@telegraphics.com.au>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 18 Feb 2020 19:25:58 +0100
Message-ID: <CAL1e-=iOQ52y0vbXAYaYDKqoepD09xO2=3d55WM32=9TFwFzAg@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] Fixes for DP8393X SONIC device emulation
To: Finn Thain <fthain@telegraphics.com.au>
Content-Type: multipart/alternative; boundary="000000000000a62802059eddcd7f"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a62802059eddcd7f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday, January 29, 2020, Finn Thain <fthain@telegraphics.com.au>
wrote:

> Hi All,
>
> There are bugs in the emulated dp8393x device that can stop packet
> reception in a Linux/m68k guest (q800 machine).
>
> With a Linux/m68k v5.5 guest (q800), it's possible to remotely trigger
> an Oops by sending ping floods.
>
> With a Linux/mips guest (magnum machine), the driver fails to probe
> the dp8393x device.
>
> With a NetBSD/arc 5.1 guest (magnum), the bugs in the device can be
> fatal to the guest kernel.
>
> Whilst debugging the device, I found that the receiver algorithm
> differs from the one described in the National Semiconductor
> datasheet.
>
> This patch series resolves these bugs.
>
> AFAIK, all bugs in the Linux sonic driver were fixed in Linux v5.5.
> ---


Herve,

Do your Jazz tests pass with these changes?

Regards,
Aleksandar



> Changed since v1:
>  - Minor revisions as described beneath commit logs.
>  - Dropped patches 4/10 and 7/10.
>  - Added 5 new patches.
>
> Changed since v2:
>  - Minor revisions as described beneath commit logs.
>  - Dropped patch 13/13.
>  - Added 2 new patches.
>
> Changed since v3:
>  - Replaced patch 13/14 with patch suggested by Philippe Mathieu-Daud=C3=
=A9.
>
>
> Finn Thain (14):
>   dp8393x: Mask EOL bit from descriptor addresses
>   dp8393x: Always use 32-bit accesses
>   dp8393x: Clean up endianness hacks
>   dp8393x: Have dp8393x_receive() return the packet size
>   dp8393x: Update LLFA and CRDA registers from rx descriptor
>   dp8393x: Clear RRRA command register bit only when appropriate
>   dp8393x: Implement packet size limit and RBAE interrupt
>   dp8393x: Don't clobber packet checksum
>   dp8393x: Use long-word-aligned RRA pointers in 32-bit mode
>   dp8393x: Pad frames to word or long word boundary
>   dp8393x: Clear descriptor in_use field to release packet
>   dp8393x: Always update RRA pointers and sequence numbers
>   dp8393x: Don't reset Silicon Revision register
>   dp8393x: Don't stop reception upon RBE interrupt assertion
>
>  hw/net/dp8393x.c | 202 +++++++++++++++++++++++++++++++----------------
>  1 file changed, 134 insertions(+), 68 deletions(-)
>
> --
> 2.24.1
>
>
>

--000000000000a62802059eddcd7f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Wednesday, January 29, 2020, Finn Thain &lt;<a href=3D"mailto:ft=
hain@telegraphics.com.au">fthain@telegraphics.com.au</a>&gt; wrote:<br><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">Hi All,<br>
<br>
There are bugs in the emulated dp8393x device that can stop packet<br>
reception in a Linux/m68k guest (q800 machine).<br>
<br>
With a Linux/m68k v5.5 guest (q800), it&#39;s possible to remotely trigger<=
br>
an Oops by sending ping floods.<br>
<br>
With a Linux/mips guest (magnum machine), the driver fails to probe<br>
the dp8393x device.<br>
<br>
With a NetBSD/arc 5.1 guest (magnum), the bugs in the device can be<br>
fatal to the guest kernel.<br>
<br>
Whilst debugging the device, I found that the receiver algorithm<br>
differs from the one described in the National Semiconductor<br>
datasheet.<br>
<br>
This patch series resolves these bugs.<br>
<br>
AFAIK, all bugs in the Linux sonic driver were fixed in Linux v5.5.<br>
---</blockquote><div><br></div><div>Herve,</div><div><br></div><div>Do your=
 Jazz tests pass with these changes?</div><div><br></div><div>Regards,=C2=
=A0</div><div>Aleksandar</div><div><br></div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">
Changed since v1:<br>
=C2=A0- Minor revisions as described beneath commit logs.<br>
=C2=A0- Dropped patches 4/10 and 7/10.<br>
=C2=A0- Added 5 new patches.<br>
<br>
Changed since v2:<br>
=C2=A0- Minor revisions as described beneath commit logs.<br>
=C2=A0- Dropped patch 13/13.<br>
=C2=A0- Added 2 new patches.<br>
<br>
Changed since v3:<br>
=C2=A0- Replaced patch 13/14 with patch suggested by Philippe Mathieu-Daud=
=C3=A9.<br>
<br>
<br>
Finn Thain (14):<br>
=C2=A0 dp8393x: Mask EOL bit from descriptor addresses<br>
=C2=A0 dp8393x: Always use 32-bit accesses<br>
=C2=A0 dp8393x: Clean up endianness hacks<br>
=C2=A0 dp8393x: Have dp8393x_receive() return the packet size<br>
=C2=A0 dp8393x: Update LLFA and CRDA registers from rx descriptor<br>
=C2=A0 dp8393x: Clear RRRA command register bit only when appropriate<br>
=C2=A0 dp8393x: Implement packet size limit and RBAE interrupt<br>
=C2=A0 dp8393x: Don&#39;t clobber packet checksum<br>
=C2=A0 dp8393x: Use long-word-aligned RRA pointers in 32-bit mode<br>
=C2=A0 dp8393x: Pad frames to word or long word boundary<br>
=C2=A0 dp8393x: Clear descriptor in_use field to release packet<br>
=C2=A0 dp8393x: Always update RRA pointers and sequence numbers<br>
=C2=A0 dp8393x: Don&#39;t reset Silicon Revision register<br>
=C2=A0 dp8393x: Don&#39;t stop reception upon RBE interrupt assertion<br>
<br>
=C2=A0hw/net/dp8393x.c | 202 ++++++++++++++++++++++++++++++<wbr>+----------=
------<br>
=C2=A01 file changed, 134 insertions(+), 68 deletions(-)<br>
<br>
-- <br>
2.24.1<br>
<br>
<br>
</blockquote>

--000000000000a62802059eddcd7f--

