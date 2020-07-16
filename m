Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C3CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 13:26:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C836920760
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 13:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C836920760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw3uP-0005kD-1i
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 09:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jw3tN-0005Jh-IT
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 09:25:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42035)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jw3tL-0002u1-Hk
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 09:25:41 -0400
Received: from mail-ua1-f72.google.com ([209.85.222.72])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jw3tJ-0008Pp-Ti
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 13:25:38 +0000
Received: by mail-ua1-f72.google.com with SMTP id 64so1094572uaz.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 06:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bDlL7/E+i1PRFcjCXFt1hrrclb+gHYMItzaF1sI0nnw=;
 b=mice73RYv9otUrfVw0XQ1vGCP8z8Y4BBcUYX2nEWyt6eezEPZZNrVfHMS3fnygy7hZ
 GN1d9us2nyKvS8N0n0goClxLTRRv3IgR3hNGPhn0ToE5AyeXCCpVlptkQ837utRmY9W6
 hddZE/eXf7NF4dzI1d+YejUXidv8g7FFz1i8QCWyz3r5/gC4TQPi98dAnp69zupq+EFj
 VxwGPTAnXLW1a4vvMs7tN1LrVKaPhGeJuGMWrdgDWDyeakIU9n0S9/ypNgD8nSYnljbw
 hSEszIJCSte18AQ9c9/Pt10re3H7trAzBl8AIyq+EMutcepl+F+EoAsvyTdX9SoZzdxy
 GxYw==
X-Gm-Message-State: AOAM530N3FIHu/wO2p7Led6iYKASRMVkaVERfDJKYwcDPGr3CkG92aOi
 tmTYJZs4ShaETEAr4FoOUtQociE9HzfskiT5dBZxwet/L0aRBVYLnJCcDZ5VMhnauTRrUY3Hysc
 5OXNZoHrJN8kfy4uilYmQPLQSZkFTeBkb7YSxDL4iXOaB4TH3
X-Received: by 2002:ab0:7551:: with SMTP id k17mr3260011uaq.102.1594905936800; 
 Thu, 16 Jul 2020 06:25:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+0GQM0clH101VHEFg5IeJXCbWynQo8aFc+6b4XyBgquiFMq0pYxL6tcQmHN7pySuWQxQZjdRNuWnUbGMk2vw=
X-Received: by 2002:ab0:7551:: with SMTP id k17mr3259980uaq.102.1594905936520; 
 Thu, 16 Jul 2020 06:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAATJJ0JDs78irZYRA7-wBefZhmTFK7SpCecuq79Ub-8n1jfy3A@mail.gmail.com>
 <alpine.LMD.2.03.2007151755360.31652@eik.bme.hu>
In-Reply-To: <alpine.LMD.2.03.2007151755360.31652@eik.bme.hu>
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Thu, 16 Jul 2020 15:25:10 +0200
Message-ID: <CAATJJ0L2V5QgPHoJW25HrT1_4_YhZJOLS=jFdCU6+JkHFG_MbA@mail.gmail.com>
Subject: Re: TB Cache size grows out of control with qemu 5.0
To: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <rth@twiddle.net>
Content-Type: multipart/alternative; boundary="000000000000cc042d05aa8ef9fa"
Received-SPF: none client-ip=91.189.89.112;
 envelope-from=christian.ehrhardt@canonical.com; helo=youngberry.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 09:25:38
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000cc042d05aa8ef9fa
Content-Type: text/plain; charset="UTF-8"

On Wed, Jul 15, 2020 at 5:58 PM BALATON Zoltan <balaton@eik.bme.hu> wrote:

> See commit 47a2def4533a2807e48954abd50b32ecb1aaf29a and the next two
> following it.
>

Thank you Zoltan for pointing out this commit, I agree that this seems to be
the trigger for the issues I'm seeing. Unfortunately the common CI host size
is 1-2G. For example on Ubuntu Autopkgtests 1.5G.
Those of them running guests do so in 0.5-1G size in TCG mode
(as they often can't rely on having KVM available).

The 1G TB buffer + 0.5G actual guest size + lack of dynamic downsizing
on memory pressure (never existed) makes these systems go OOM-Killing
the qemu process.

The patches indicated that the TB flushes on a full guest boot are a
good indicator of the TB size efficiency. From my old checks I had:

- Qemu 4.2 512M guest with 32M default overwritten by ram-size/4
TB flush count      14, 14, 16
- Qemu 5.0 512M guest with 1G default
TB flush count      1, 1, 1

I agree that ram/4 seems odd, especially on huge guests that is a lot
potentially wasted. And most environments have a bit of breathing
room 1G is too big in small host systems and the common CI system falls
into this category. So I tuned it down to 256M for a test.

- Qemu 4.2 512M guest with tb-size 256M
TB flush count      5, 5, 5
- Qemu 5.0 512M guest with tb-size 256M
TB flush count      5, 5, 5
- Qemu 5.0 512M guest with 256M default in code
TB flush count      5, 5, 5

So performance wise the results are as much in-between as you'd think from a
TB size in between. And the memory consumption which (for me) is the actual
current issue to fix would be back in line again as expected.

So on one hand I'm suggesting something like:
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -944,7 +944,7 @@ static void page_lock_pair(PageDesc **re
  * Users running large scale system emulation may want to tweak their
  * runtime setup via the tb-size control on the command line.
  */
-#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (1 * GiB)
+#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (256 * MiB)
 #endif
 #endif

OTOH I understand someone else might want to get the more speedy 1G
especially for large guests. If someone used to run a 4G guest in TCG the
TB Size was 1G all along.
How about picking the smaller of (1G || ram-size/4) as default?

This might then look like:
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -956,7 +956,12 @@ static inline size_t size_code_gen_buffe
 {
     /* Size the buffer.  */
     if (tb_size == 0) {
-        tb_size = DEFAULT_CODE_GEN_BUFFER_SIZE;
+        unsigned long max_default = (unsigned long)(ram_size / 4);
+        if (max_default < DEFAULT_CODE_GEN_BUFFER_SIZE) {
+            tb_size = max_default;
+        } else {
+           tb_size = DEFAULT_CODE_GEN_BUFFER_SIZE;
+        }
     }
     if (tb_size < MIN_CODE_GEN_BUFFER_SIZE) {
         tb_size = MIN_CODE_GEN_BUFFER_SIZE;

This is a bit more tricky than it seems as ram_sizes is no more
present in that context but it is enough to discuss it.
That should serve all cases - small and large - better as a pure
static default of 1G or always ram/4?

P.S. I added Alex being the Author of the offending patch and Richard/Paolo
for being listed in the Maintainers file for TCG.

-- 
Christian Ehrhardt
Staff Engineer, Ubuntu Server
Canonical Ltd

--000000000000cc042d05aa8ef9fa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 15, 2020 at 5:58 PM BALAT=
ON Zoltan &lt;<a href=3D"mailto:balaton@eik.bme.hu">balaton@eik.bme.hu</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">See c=
ommit 47a2def4533a2807e48954abd50b32ecb1aaf29a and the next two <br>
following it.<br></blockquote><div>=C2=A0</div></div><div>Thank you Zoltan =
for pointing out this commit, I agree that this seems to be<br>the trigger =
for the issues I&#39;m seeing. Unfortunately the common CI host size<br>is =
1-2G. For example on Ubuntu Autopkgtests 1.5G.<br>Those of them running gue=
sts do so in 0.5-1G size in TCG mode<br>(as they often can&#39;t rely on ha=
ving KVM available).<br><br>The 1G TB buffer + 0.5G actual guest size + lac=
k of dynamic downsizing<br>on memory pressure (never existed) makes these s=
ystems go OOM-Killing<br>the qemu process.<br><br>The patches indicated tha=
t the TB flushes on a full guest boot are a<br>good indicator of the TB siz=
e efficiency. From my old checks I had:<br><br>- Qemu 4.2 512M guest with 3=
2M default overwritten by ram-size/4<br>TB flush count =C2=A0 =C2=A0 =C2=A0=
14, 14, 16<br>- Qemu 5.0 512M guest with 1G default<br>TB flush count =C2=
=A0 =C2=A0 =C2=A01, 1, 1<br><br>I agree that ram/4 seems odd, especially on=
 huge guests that is a lot<br>potentially wasted. And most environments hav=
e a bit of breathing<br>room 1G is too big in small host systems and the co=
mmon CI system falls<br>into this category. So I tuned it down to 256M for =
a test.<br><br>- Qemu 4.2 512M guest with tb-size 256M<br>TB flush count =
=C2=A0 =C2=A0 =C2=A05, 5, 5<br>- Qemu 5.0 512M guest with tb-size 256M<br>T=
B flush count =C2=A0 =C2=A0 =C2=A05, 5, 5<br>- Qemu 5.0 512M guest with 256=
M default in code<br>TB flush count =C2=A0 =C2=A0 =C2=A05, 5, 5<br><br>So p=
erformance wise the results are as much in-between as you&#39;d think from =
a<br>TB size in between. And the memory consumption which (for me) is the a=
ctual<br>current issue to fix would be back in line again as expected.<br><=
br>So on one hand I&#39;m suggesting something like:<br>--- a/accel/tcg/tra=
nslate-all.c<br>+++ b/accel/tcg/translate-all.c<br>@@ -944,7 +944,7 @@ stat=
ic void page_lock_pair(PageDesc **re<br>=C2=A0 * Users running large scale =
system emulation may want to tweak their<br>=C2=A0 * runtime setup via the =
tb-size control on the command line.<br>=C2=A0 */<br>-#define DEFAULT_CODE_=
GEN_BUFFER_SIZE_1 (1 * GiB)<br>+#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (256=
 * MiB)<br>=C2=A0#endif<br>=C2=A0#endif<br><br>OTOH I understand someone el=
se might want to get the more speedy 1G</div><div>especially for large gues=
ts. If someone used to run a 4G guest in TCG the</div><div>TB Size was 1G a=
ll along.</div><div>How about picking the smaller of (1G || ram-size/4) as =
default?<br><br>This might then look like:<br>--- a/accel/tcg/translate-all=
.c<br>+++ b/accel/tcg/translate-all.c<br>@@ -956,7 +956,12 @@ static inline=
 size_t size_code_gen_buffe<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0/* Size the b=
uffer. =C2=A0*/<br>=C2=A0 =C2=A0 =C2=A0if (tb_size =3D=3D 0) {<br>- =C2=A0 =
=C2=A0 =C2=A0 =C2=A0tb_size =3D DEFAULT_CODE_GEN_BUFFER_SIZE;<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0unsigned long max_default =3D (unsigned long)(ram_size =
/ 4);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (max_default &lt; DEFAULT_CODE_GEN=
_BUFFER_SIZE) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tb_size =3D m=
ax_default;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 tb_size =3D DEFAULT_CODE_GEN_BUFFER_SIZE;<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0if (tb_s=
ize &lt; MIN_CODE_GEN_BUFFER_SIZE) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0t=
b_size =3D MIN_CODE_GEN_BUFFER_SIZE;<br><br>This is a bit more tricky than =
it seems as ram_sizes is no more<br>present in that context but it is enoug=
h to discuss it.<br>That should serve all cases - small and large - better =
as a pure<br>static default of 1G or always ram/4?<br><br>P.S. I added Alex=
 being the Author of the offending patch and Richard/Paolo<br>for being lis=
ted in the Maintainers file for TCG.<br></div><div><br></div>-- <br><div di=
r=3D"ltr" class=3D"gmail_signature">Christian Ehrhardt<br>Staff Engineer, U=
buntu Server<br>Canonical Ltd</div></div>

--000000000000cc042d05aa8ef9fa--

