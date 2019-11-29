Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A03C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 13:36:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A55B2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 13:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sexrn0sj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A55B2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iagRR-0000uP-7b
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 08:36:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bilalwasim676@gmail.com>) id 1iacdu-0008Dt-UA
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:32:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bilalwasim676@gmail.com>) id 1iacdr-0003CX-5T
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:32:48 -0500
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:39632)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bilalwasim676@gmail.com>)
 id 1iacdq-0002xV-SM; Fri, 29 Nov 2019 04:32:47 -0500
Received: by mail-qt1-x842.google.com with SMTP id g1so22487076qtj.6;
 Fri, 29 Nov 2019 01:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=i+V3bmI3RGZiiEW/iBuj2ZOy2cU5Xb+ACSZh5GQvPAE=;
 b=sexrn0sj+kc2RC9yWpmo9LgTJhxID9DDhsP8AfK30cUAJ3D4pfmBCK2VnqtzE5DFrN
 gcbiYusIs+vDA4+NKRxxwM+j0IfwV70cu5zMzJv5mLxBfIINOQ/eVEVtwD7lVM+/UxvR
 4omaNZ1Bfxt63KaBvA/Ur+JraWClh/7KeS5QhI+egN7dGYn/TeetQe71BRoMzRvhi1RY
 N7ugsrJA/EYcrqNOkw7w28tUwqzFb9fWWt5sPnoVIstQwmXAdfrqWHy5HeU+C17igcyP
 SG+qsVCQj0FPVEwAf7I5ANGQ99wmZh7TAJ2rV1RNJdFtsCatFnFY72d52r1IYGfVg8J7
 htNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=i+V3bmI3RGZiiEW/iBuj2ZOy2cU5Xb+ACSZh5GQvPAE=;
 b=C/ZFKNoc6bvRm/2z3G2rl1AL4XtLKlPN2daehhROkXktP7GomRN8eWeoEApusYuwpn
 E3uwaTr2VnAJdF5oGoFO5+N6U+Hx8QtQF4SUxvsxePU6r2QJBjKMg0mnFoWOF2lHya1n
 V68bPPCANOq5Ge6XLrIkmmazsDORegEZHj541T+IuHycIRPYUmGg+2ZX98DfPTFPVxzJ
 VVvSLvuhO3Tf87goPxqfuX88+FYDJRuQfA1t/ocL7sBvRjDbVIZrU803hb3NCV4Ra/fF
 thFnVJn2AC/eI1UEYhHytX3w4yp0+L5XaECDvUBbbEeJSVLE/rdy62s85Rd/T//Vk9jF
 k7Pg==
X-Gm-Message-State: APjAAAUBuDldEzuJIlSmw3UVsTZI6Y0Dv6b6NgS/lSAjKdsjppLfBxDW
 q4UyUN16f5xsO90d50IA88II3WEDKSOsV8BSNr0=
X-Google-Smtp-Source: APXvYqx+rwkxxlRVz8VFJvgrNBfgOCdS1eOKXfOnYfDrERIy40MJU/PVsdsQRoBNIRlhPMHjfnCUa9sksSx7zXdF6Eg=
X-Received: by 2002:aed:2a39:: with SMTP id c54mr45850811qtd.339.1575019960806; 
 Fri, 29 Nov 2019 01:32:40 -0800 (PST)
MIME-Version: 1.0
References: <20191129085216.5108-1-bilalwasim676@gmail.com>
 <20191129091332.GA25295@toto>
In-Reply-To: <20191129091332.GA25295@toto>
From: Bilal Wasim <bilalwasim676@gmail.com>
Date: Fri, 29 Nov 2019 14:32:29 +0500
Message-ID: <CAHKB+OCuPFKs4Fb=e_FNcH1SLc3if9nGpZ79PTLWhsCUTUTtMQ@mail.gmail.com>
Subject: Re: [PATCH v2] net/cadence_gem: Updating the GEM MAC IP to properly
 filter out multicast addresses.
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000473010059878e9a0"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
X-Mailman-Approved-At: Fri, 29 Nov 2019 08:30:37 -0500
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, bilal_wasim@mentor.com,
 qemu-devel@nongnu.org, alistair@alistair23.me
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000473010059878e9a0
Content-Type: text/plain; charset="UTF-8"

Thanks, Will do..

On Fri, 29 Nov 2019, 14:13 Edgar E. Iglesias, <edgar.iglesias@gmail.com>
wrote:

> On Fri, Nov 29, 2019 at 01:52:16PM +0500, bilalwasim676@gmail.com wrote:
> > From: bwasim <bilal_wasim@mentor.com>
> >
> > The current code makes a bad assumption that the most-significant byte
> > of the MAC address is used to determine if the address is multicast or
> > unicast, but in reality only a single bit is used to determine this.
> > This caused IPv6 to not work.. Fix is now in place and has been tested
> > with ZCU102-A53 / IPv6 on a TAP interface. Works well..
>
> Thanks Bilal,
>
> Sorry, just one more thing I had missed, we need to update
> gem_transmit_updatestats() aswell, in a similar way as we did with
> gem_receive_updatestats().
>
> Cheers,
> Edgar
>
>
> >
> > Signed-off-by: Bilal Wasim <bilal_wasim@mentor.com>
> > ---
> >  hw/net/cadence_gem.c | 19 ++++++++++++-------
> >  1 file changed, 12 insertions(+), 7 deletions(-)
> >
> > diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> > index b8be73dc55..042188c1ba 100644
> > --- a/hw/net/cadence_gem.c
> > +++ b/hw/net/cadence_gem.c
> > @@ -34,6 +34,7 @@
> >  #include "qemu/module.h"
> >  #include "sysemu/dma.h"
> >  #include "net/checksum.h"
> > +#include "net/eth.h"
> >
> >  #ifdef CADENCE_GEM_ERR_DEBUG
> >  #define DB_PRINT(...) do { \
> > @@ -601,7 +602,7 @@ static void gem_receive_updatestats(CadenceGEMState
> *s, const uint8_t *packet,
> >      }
> >
> >      /* Error-free Multicast Frames counter */
> > -    if (packet[0] == 0x01) {
> > +    if (is_multicast_ether_addr(packet)) {
> >          s->regs[GEM_RXMULTICNT]++;
> >      }
> >
> > @@ -690,21 +691,25 @@ static int gem_mac_address_filter(CadenceGEMState
> *s, const uint8_t *packet)
> >      }
> >
> >      /* Accept packets -w- hash match? */
> > -    if ((packet[0] == 0x01 && (s->regs[GEM_NWCFG] &
> GEM_NWCFG_MCAST_HASH)) ||
> > -        (packet[0] != 0x01 && (s->regs[GEM_NWCFG] &
> GEM_NWCFG_UCAST_HASH))) {
> > +    if ((is_multicast_ether_addr(packet)
> > +        && (s->regs[GEM_NWCFG] & GEM_NWCFG_MCAST_HASH)) ||
> > +        (is_unicast_ether_addr(packet)
> > +        && (s->regs[GEM_NWCFG] & GEM_NWCFG_UCAST_HASH))) {
> >          unsigned hash_index;
> >
> >          hash_index = calc_mac_hash(packet);
> >          if (hash_index < 32) {
> >              if (s->regs[GEM_HASHLO] & (1<<hash_index)) {
> > -                return packet[0] == 0x01 ? GEM_RX_MULTICAST_HASH_ACCEPT
> :
> > -                                           GEM_RX_UNICAST_HASH_ACCEPT;
> > +                return is_multicast_ether_addr(packet) ?
> > +                       GEM_RX_MULTICAST_HASH_ACCEPT :
> > +                       GEM_RX_UNICAST_HASH_ACCEPT;
> >              }
> >          } else {
> >              hash_index -= 32;
> >              if (s->regs[GEM_HASHHI] & (1<<hash_index)) {
> > -                return packet[0] == 0x01 ? GEM_RX_MULTICAST_HASH_ACCEPT
> :
> > -                                           GEM_RX_UNICAST_HASH_ACCEPT;
> > +                return is_multicast_ether_addr(packet) ?
> > +                       GEM_RX_MULTICAST_HASH_ACCEPT :
> > +                       GEM_RX_UNICAST_HASH_ACCEPT;
> >              }
> >          }
> >      }
> > --
> > 2.19.1.windows.1
> >
>

--000000000000473010059878e9a0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thanks, Will do..=C2=A0</div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 29 Nov 2019, 14:13 Edgar E=
. Iglesias, &lt;<a href=3D"mailto:edgar.iglesias@gmail.com">edgar.iglesias@=
gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Fri, =
Nov 29, 2019 at 01:52:16PM +0500, <a href=3D"mailto:bilalwasim676@gmail.com=
" target=3D"_blank" rel=3D"noreferrer">bilalwasim676@gmail.com</a> wrote:<b=
r>
&gt; From: bwasim &lt;<a href=3D"mailto:bilal_wasim@mentor.com" target=3D"_=
blank" rel=3D"noreferrer">bilal_wasim@mentor.com</a>&gt;<br>
&gt; <br>
&gt; The current code makes a bad assumption that the most-significant byte=
<br>
&gt; of the MAC address is used to determine if the address is multicast or=
<br>
&gt; unicast, but in reality only a single bit is used to determine this.<b=
r>
&gt; This caused IPv6 to not work.. Fix is now in place and has been tested=
<br>
&gt; with ZCU102-A53 / IPv6 on a TAP interface. Works well..<br>
<br>
Thanks Bilal,<br>
<br>
Sorry, just one more thing I had missed, we need to update<br>
gem_transmit_updatestats() aswell, in a similar way as we did with<br>
gem_receive_updatestats().<br>
<br>
Cheers,<br>
Edgar<br>
<br>
<br>
&gt; <br>
&gt; Signed-off-by: Bilal Wasim &lt;<a href=3D"mailto:bilal_wasim@mentor.co=
m" target=3D"_blank" rel=3D"noreferrer">bilal_wasim@mentor.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/net/cadence_gem.c | 19 ++++++++++++-------<br>
&gt;=C2=A0 1 file changed, 12 insertions(+), 7 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c<br>
&gt; index b8be73dc55..042188c1ba 100644<br>
&gt; --- a/hw/net/cadence_gem.c<br>
&gt; +++ b/hw/net/cadence_gem.c<br>
&gt; @@ -34,6 +34,7 @@<br>
&gt;=C2=A0 #include &quot;qemu/module.h&quot;<br>
&gt;=C2=A0 #include &quot;sysemu/dma.h&quot;<br>
&gt;=C2=A0 #include &quot;net/checksum.h&quot;<br>
&gt; +#include &quot;net/eth.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #ifdef CADENCE_GEM_ERR_DEBUG<br>
&gt;=C2=A0 #define DB_PRINT(...) do { \<br>
&gt; @@ -601,7 +602,7 @@ static void gem_receive_updatestats(CadenceGEMStat=
e *s, const uint8_t *packet,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* Error-free Multicast Frames counter */<br>
&gt; -=C2=A0 =C2=A0 if (packet[0] =3D=3D 0x01) {<br>
&gt; +=C2=A0 =C2=A0 if (is_multicast_ether_addr(packet)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[GEM_RXMULTICNT]++;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; @@ -690,21 +691,25 @@ static int gem_mac_address_filter(CadenceGEMStat=
e *s, const uint8_t *packet)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* Accept packets -w- hash match? */<br>
&gt; -=C2=A0 =C2=A0 if ((packet[0] =3D=3D 0x01 &amp;&amp; (s-&gt;regs[GEM_N=
WCFG] &amp; GEM_NWCFG_MCAST_HASH)) ||<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 (packet[0] !=3D 0x01 &amp;&amp; (s-&gt;re=
gs[GEM_NWCFG] &amp; GEM_NWCFG_UCAST_HASH))) {<br>
&gt; +=C2=A0 =C2=A0 if ((is_multicast_ether_addr(packet)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; (s-&gt;regs[GEM_NWCFG] &amp; G=
EM_NWCFG_MCAST_HASH)) ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (is_unicast_ether_addr(packet)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; (s-&gt;regs[GEM_NWCFG] &amp; G=
EM_NWCFG_UCAST_HASH))) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned hash_index;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hash_index =3D calc_mac_hash(packet)=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (hash_index &lt; 32) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;regs[GEM_HAS=
HLO] &amp; (1&lt;&lt;hash_index)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return packet=
[0] =3D=3D 0x01 ? GEM_RX_MULTICAST_HASH_ACCEPT :<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0GEM_RX_UNICAST_HASH_ACCEPT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return is_mul=
ticast_ether_addr(packet) ?<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0GEM_RX_MULTICAST_HASH_ACCEPT :<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0GEM_RX_UNICAST_HASH_ACCEPT;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hash_index -=3D 32;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;regs[GEM_HAS=
HHI] &amp; (1&lt;&lt;hash_index)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return packet=
[0] =3D=3D 0x01 ? GEM_RX_MULTICAST_HASH_ACCEPT :<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0GEM_RX_UNICAST_HASH_ACCEPT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return is_mul=
ticast_ether_addr(packet) ?<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0GEM_RX_MULTICAST_HASH_ACCEPT :<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0GEM_RX_UNICAST_HASH_ACCEPT;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -- <br>
&gt; 2.19.1.windows.1<br>
&gt; <br>
</blockquote></div>

--000000000000473010059878e9a0--

