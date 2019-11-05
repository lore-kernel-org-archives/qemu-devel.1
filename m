Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0C8C010A3
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 11:33:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8C23206BA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 11:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=holoplot-com.20150623.gappssmtp.com header.i=@holoplot-com.20150623.gappssmtp.com header.b="YJHJK3PT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C23206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holoplot.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRx57-0004lH-Pl
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 06:33:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <linus.ziegert@holoplot.com>) id 1iRx4F-0004D8-SZ
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 06:32:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <linus.ziegert@holoplot.com>) id 1iRx4A-0001R9-8k
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 06:32:08 -0500
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:36837)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <linus.ziegert@holoplot.com>)
 id 1iRx48-0000ix-1I
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 06:32:04 -0500
Received: by mail-il1-x143.google.com with SMTP id s75so17899610ilc.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 03:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=holoplot-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W7mjdv/Lb2qS2Sc8H5RNZYF+HROjMlbSou5W7A6L6Qg=;
 b=YJHJK3PTuSWhg4SgKNAU1lb65c4WwoTFIPCSg4NbJ96dQhP/z5hZeXcjDS5SUr9fGu
 SYpFvI2BMxPQbBkUOzHIyWQSqFACEuXfEg4Zi/uK6OOdOMbJ6LOMZM5kP31QLOokSVM/
 I7cNhBk0K4zjEgKJ+omkLyWs2FefJnfeIf9b7r/I9Y9uo48Vmy1gjcZ3k1yeVSe4jegv
 Gdd52BcEFrrYNyLF1Mu1QFrBgylROPkgTqxx68TjFbMylNB1hJSdbP3d0AWS6KlWjsaf
 7gasw2bjdkbmsYyzDnBYG8NZVArWbh7XT11kdXey89AFSNfzLUG9I5uNAEdGIhFmVZrc
 fbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W7mjdv/Lb2qS2Sc8H5RNZYF+HROjMlbSou5W7A6L6Qg=;
 b=jrdw9/Bxf9YsKbQpMTmLo6E/cas50KbaMpZPPz4GvUQ3Xj7xDBeIZS5SPrzzdQ4jJt
 LTWJCO/TRl5UA39sp4XLu1dPWE9x1Lnfqhq4icdZnE0Ja4BzHwaxWmzh3TSbdT6G6IRL
 GE0rtdUjTB3DZ3hZuRX4Y5a9SLS1IDGXEGG1wgOZwlf9EpGx+XIrK4+g1udeEU3ny/Mh
 qDqRjHQfoCDlRc8bcFm3De0WUUq5D/E/qcuzmPS2XrenbX1wWJ37aNQj4PU5v9y2lQ0O
 Buhliw2bRdPYE6PIeLihVtfY+uA2p+kb/alT1sONG6fzodaeiihdyFDGJwpRowxiqTrp
 VhSg==
X-Gm-Message-State: APjAAAW5amwTXnNNcqDw5zkzVy9GWndiYreFmcc5h1iJThev7dqYCU6o
 +mGKHyHAKxzWTDaVcAKfC06dbB5TsMBnKhp+pq4kcg==
X-Google-Smtp-Source: APXvYqyLWSbXQmtlhKwTYBPUxxk3hgQ6X+UVHvSIuclkd2NUTl9KBAAQD+ohj/I58pt1nn3ztWzVITmgBQv5hjuKYOA=
X-Received: by 2002:a92:c504:: with SMTP id r4mr30264541ilg.132.1572953518544; 
 Tue, 05 Nov 2019 03:31:58 -0800 (PST)
MIME-Version: 1.0
References: <20191104181604.21943-1-linus.ziegert+qemu@holoplot.com>
 <CAKmqyKMWS18ssBUhDgYSnGiFRwCkSJPBRui4Op50Tq_Z-OUakA@mail.gmail.com>
In-Reply-To: <CAKmqyKMWS18ssBUhDgYSnGiFRwCkSJPBRui4Op50Tq_Z-OUakA@mail.gmail.com>
From: Linus Ziegert <linus.ziegert@holoplot.com>
Date: Tue, 5 Nov 2019 12:31:22 +0100
Message-ID: <CAPm2bJ_mfVepKP9hj-PQBnESsCi6t+9zj-m_KWQYx6m-S5ddAg@mail.gmail.com>
Subject: Re: [PATCH] net/cadence_gem: Set PHY autonegotiation restart status
To: Alistair Francis <alistair23@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000b8b2ce059697c714"
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "open list:Xilinx Zynq" <qemu-arm@nongnu.org>,
 Linus Ziegert <linus.ziegert+qemu@holoplot.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b8b2ce059697c714
Content-Type: text/plain; charset="UTF-8"

Am Mo., 4. Nov. 2019 um 23:50 Uhr schrieb Alistair Francis <
alistair23@gmail.com>:
>
> On Mon, Nov 4, 2019 at 2:02 PM <linus.ziegert@holoplot.com> wrote:
> >
> > From: Linus Ziegert <linus.ziegert+qemu@holoplot.com>
> >
> > The Linux kernel PHY driver sets AN_RESTART in the BMCR of the
> > PHY when autonegotiation is started.
> > Recently the kernel started to read back the PHY's AN_RESTART
> > bit and now checks whether the autonegotiation is complete and
> > the bit was cleared [1]. Otherwise the link status is down.
> >
> > The emulated PHY needs to clear AN_RESTART immediately to inform
> > the kernel driver about the completion of autonegotiation phase.
> >
> > [1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c36757eb9dee
> >
> > Signed-off-by: Linus Ziegert <linus.ziegert+qemu@holoplot.com>
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

I consider this stable material. Applies cleanly to all versions starting
from v1.5.0.
Thanks

>
> Alistair
>
> > ---
> >  hw/net/cadence_gem.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> > index 7f9cb5ab95..b8be73dc55 100644
> > --- a/hw/net/cadence_gem.c
> > +++ b/hw/net/cadence_gem.c
> > @@ -271,9 +271,10 @@
> >  #define PHY_REG_EXT_PHYSPCFC_ST   27
> >  #define PHY_REG_CABLE_DIAG   28
> >
> > -#define PHY_REG_CONTROL_RST  0x8000
> > -#define PHY_REG_CONTROL_LOOP 0x4000
> > -#define PHY_REG_CONTROL_ANEG 0x1000
> > +#define PHY_REG_CONTROL_RST       0x8000
> > +#define PHY_REG_CONTROL_LOOP      0x4000
> > +#define PHY_REG_CONTROL_ANEG      0x1000
> > +#define PHY_REG_CONTROL_ANRESTART 0x0200
> >
> >  #define PHY_REG_STATUS_LINK     0x0004
> >  #define PHY_REG_STATUS_ANEGCMPL 0x0020
> > @@ -1345,7 +1346,7 @@ static void gem_phy_write(CadenceGEMState *s,
unsigned reg_num, uint16_t val)
> >          }
> >          if (val & PHY_REG_CONTROL_ANEG) {
> >              /* Complete autonegotiation immediately */
> > -            val &= ~PHY_REG_CONTROL_ANEG;
> > +            val &= ~(PHY_REG_CONTROL_ANEG | PHY_REG_CONTROL_ANRESTART);
> >              s->phy_regs[PHY_REG_STATUS] |= PHY_REG_STATUS_ANEGCMPL;
> >          }
> >          if (val & PHY_REG_CONTROL_LOOP) {
> > --
> > 2.21.0
> >
> >

--000000000000b8b2ce059697c714
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><br><br>Am Mo., 4. Nov. 2019 um 23:50 Uhr schrie=
b Alistair Francis &lt;<a href=3D"mailto:alistair23@gmail.com">alistair23@g=
mail.com</a>&gt;:<br>&gt;<br>&gt; On Mon, Nov 4, 2019 at 2:02 PM &lt;<a hre=
f=3D"mailto:linus.ziegert@holoplot.com">linus.ziegert@holoplot.com</a>&gt; =
wrote:<br>&gt; &gt;<br>&gt; &gt; From: Linus Ziegert &lt;<a href=3D"mailto:=
linus.ziegert%2Bqemu@holoplot.com">linus.ziegert+qemu@holoplot.com</a>&gt;<=
br>&gt; &gt;<br>&gt; &gt; The Linux kernel PHY driver sets AN_RESTART in th=
e BMCR of the<br>&gt; &gt; PHY when autonegotiation is started.<br>&gt; &gt=
; Recently the kernel started to read back the PHY&#39;s AN_RESTART<br>&gt;=
 &gt; bit and now checks whether the autonegotiation is complete and<br>&gt=
; &gt; the bit was cleared [1]. Otherwise the link status is down.<br>&gt; =
&gt;<br>&gt; &gt; The emulated PHY needs to clear AN_RESTART immediately to=
 inform<br>&gt; &gt; the kernel driver about the completion of autonegotiat=
ion phase.<br>&gt; &gt;<br>&gt; &gt; [1] <a href=3D"https://git.kernel.org/=
pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3Dc36757eb9dee">http=
s://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=
=3Dc36757eb9dee</a><br>&gt; &gt;<br>&gt; &gt; Signed-off-by: Linus Ziegert =
&lt;<a href=3D"mailto:linus.ziegert%2Bqemu@holoplot.com">linus.ziegert+qemu=
@holoplot.com</a>&gt;<br>&gt;<br>&gt; Reviewed-by: Alistair Francis &lt;<a =
href=3D"mailto:alistair.francis@wdc.com">alistair.francis@wdc.com</a>&gt;<b=
r><br></div>I consider this stable material. Applies cleanly to all version=
s starting from v1.5.0.<br></div>Thanks<br><div><div>=C2=A0<br>&gt;<br>&gt;=
 Alistair<br>&gt;<br>&gt; &gt; ---<br>&gt; &gt; =C2=A0hw/net/cadence_gem.c =
| 9 +++++----<br>&gt; &gt; =C2=A01 file changed, 5 insertions(+), 4 deletio=
ns(-)<br>&gt; &gt;<br>&gt; &gt; diff --git a/hw/net/cadence_gem.c b/hw/net/=
cadence_gem.c<br>&gt; &gt; index 7f9cb5ab95..b8be73dc55 100644<br>&gt; &gt;=
 --- a/hw/net/cadence_gem.c<br>&gt; &gt; +++ b/hw/net/cadence_gem.c<br>&gt;=
 &gt; @@ -271,9 +271,10 @@<br>&gt; &gt; =C2=A0#define PHY_REG_EXT_PHYSPCFC_=
ST =C2=A0 27<br>&gt; &gt; =C2=A0#define PHY_REG_CABLE_DIAG =C2=A0 28<br>&gt=
; &gt;<br>&gt; &gt; -#define PHY_REG_CONTROL_RST =C2=A00x8000<br>&gt; &gt; =
-#define PHY_REG_CONTROL_LOOP 0x4000<br>&gt; &gt; -#define PHY_REG_CONTROL_=
ANEG 0x1000<br>&gt; &gt; +#define PHY_REG_CONTROL_RST =C2=A0 =C2=A0 =C2=A0 =
0x8000<br>&gt; &gt; +#define PHY_REG_CONTROL_LOOP =C2=A0 =C2=A0 =C2=A00x400=
0<br>&gt; &gt; +#define PHY_REG_CONTROL_ANEG =C2=A0 =C2=A0 =C2=A00x1000<br>=
&gt; &gt; +#define PHY_REG_CONTROL_ANRESTART 0x0200<br>&gt; &gt;<br>&gt; &g=
t; =C2=A0#define PHY_REG_STATUS_LINK =C2=A0 =C2=A0 0x0004<br>&gt; &gt; =C2=
=A0#define PHY_REG_STATUS_ANEGCMPL 0x0020<br>&gt; &gt; @@ -1345,7 +1346,7 @=
@ static void gem_phy_write(CadenceGEMState *s, unsigned reg_num, uint16_t =
val)<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>&gt; &gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (val &amp; PHY_REG_CONTROL_ANEG) {<br>&gt; &g=
t; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Complete autonegotiat=
ion immediately */<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
val &amp;=3D ~PHY_REG_CONTROL_ANEG;<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0val &amp;=3D ~(PHY_REG_CONTROL_ANEG | PHY_REG_CONTROL_ANRE=
START);<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;=
phy_regs[PHY_REG_STATUS] |=3D PHY_REG_STATUS_ANEGCMPL;<br>&gt; &gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (val &amp; PHY_REG_CONTROL_LOOP) {<br>&gt; &gt; --<br>&gt; &gt; 2.21.=
0<br>&gt; &gt;<br>&gt; &gt;<br></div></div></div>

--000000000000b8b2ce059697c714--

