Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,TRACKER_ID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D795DC11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:54:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A27B320836
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fks77/xp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A27B320836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Hvi-00082q-Tg
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 12:54:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53676)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j6Hv7-0007Za-Ez
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:53:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j6Hv6-0007JW-11
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:53:29 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40429)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j6Hv5-0007JA-RS
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:53:27 -0500
Received: by mail-ot1-x343.google.com with SMTP id i6so9499223otr.7
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 09:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=flotnRzJOlVLYEg5S9yy9Q6gPgqqFfdCX+/J+CDGch0=;
 b=fks77/xpo65gpqyMR3rWtpF7uippxlOXDEbS8yDzAMJjlp0AOpYA1B0PYpdoiS4fsc
 CAO/Wt7m0nLoarS76K34zCnyWsAbIYNl7JXjhBghL9TTcMLkDA0YkgtomjgkFdqe+W3C
 wwfqxhXCVpnpDWovZ6mGtRbCOEQBkMDrNnmDAktw2OYFQ8b6ut3p2wb7cImuni6/YdM0
 ng58WbU292IfLzaqwcYUFGV3G6Z+E+gdhPNlSVJdgCPF6r37oKN2oOrwZX5YfHCxw5ja
 BQNNaGysPDDMYSQd5o0WTSrTv33FYYCMHJ2Yv4V3ngqOExTOYpNWYbP9L1tPuuOuCRzx
 pPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=flotnRzJOlVLYEg5S9yy9Q6gPgqqFfdCX+/J+CDGch0=;
 b=jjjr2PXxfkO5ZmSm1IaX03UVZyTOAHqWln7YY+OAJe452AkSS1enDwW2K6gFevTonw
 6PpJT6bp7q2u4/jNDrsuqaFEvqCPOBLap/feJ4iPTuNmJdeLO6lhWPNKCFPDXVmtHipF
 MrxOxk28zZF24NQy/coVKAug28y5XcBt781OVZF0cK2OK61bXy5XHjrWjlH95gzKTYwu
 EgxIFB8cvVRlyMFm6RLdfeigEuoSSBDNbUMzifoA3HYrDZlPE2aUZSloMdez6WcVCtJS
 Z8NCoyooEj27FiQZRmVqbjEq/M2PeAgS0m9nHHH1lIWccPorStmzEBlZNft4esEQBfk/
 QDyA==
X-Gm-Message-State: APjAAAXJ1e0z2AaNkXOKdPxUVHzzj0CYLDeEhCFLjpxVGJm5U0oRnyXT
 iMsSxd11VNp7n4VzoAB3zdkUuMNToHKhrhaLYBg=
X-Google-Smtp-Source: APXvYqyctLgap/zZZqqRT+oI0Uw3DobARxEUeEk4UQvu3eIkkMM8L65PdDo8LShxwaQOSSn6xC9eaBzhFulK4qE0+co=
X-Received: by 2002:a05:6830:1042:: with SMTP id
 b2mr40663795otp.306.1582566806626; 
 Mon, 24 Feb 2020 09:53:26 -0800 (PST)
MIME-Version: 1.0
References: <20200223065102.61652-1-ysato@users.sourceforge.jp>
 <20200223065102.61652-21-ysato@users.sourceforge.jp>
 <da7b0c50-4466-a491-8487-2c3a11984077@redhat.com>
 <598cc17a-9686-e9c5-72b5-5153d29d5a52@redhat.com>
 <fa92ac6a-fff9-e2be-ba7e-2463eec01c6c@redhat.com>
In-Reply-To: <fa92ac6a-fff9-e2be-ba7e-2463eec01c6c@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 24 Feb 2020 18:53:15 +0100
Message-ID: <CAL1e-=hGQD2aJQhAXiYDnsTa71xm_yoDzVFjuAfB-=ydxkesDg@mail.gmail.com>
Subject: Re: [PATCH v31 20/22] Add rx-softmmu
To: Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000057a6c6059f560ce5"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000057a6c6059f560ce5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2020 at 4:31 PM Eric Blake <eblake@redhat.com> wrote:
>
> On 2/24/20 9:15 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 2/24/20 4:11 PM, Eric Blake wrote:
> >> On 2/23/20 12:51 AM, Yoshinori Sato wrote:
> >>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >>> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> >>> Message-Id: <20190607091116.49044-17-ysato@users.sourceforge.jp>
> >>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >>> pick ed65c02993 target/rx: Add RX to SysEmuTarget
> >>> pick 01372568ae tests: Add rx to machine-none-test.c
> >>> [PMD: Squashed patches from Richard Henderson modifying
> >>>        qapi/common.json and tests/machine-none-test.c]
> >>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >>> ---
> >>
> >>> +++ b/qapi/machine.json
> >>> @@ -26,7 +26,7 @@
> >>>     'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386',
> >>> 'lm32',
> >>>                'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64'=
,
> >>>                'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
> >>> -             'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
> >>> +             'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
> >>
> >> Missing mention of the new enum member with a 'since 5.0' designation
> >> in the documentation.
> >
> > Is this something we can automate? Maybe dumping all the qapi data when
> > we do a release, then check the differences before the next release?
>
> Probably. It's already easy to automate a dump of qmp introspection data
> from an arbitrary commit, and diffing the output between the previous
> commit release point and the current proposed release should be
> technically possible.  Our QAPI generator also generates the docs, which
> means it can be enhanced to denote which doc elements are tagged to
> which versions.  Might make a good GSOC project.
>

Hello, all (but mostly Peter and Eric).

Just want to bring to your attention a point that is not clear to me here.
(forgive me for being an outsider in this area)

Could you please take a look at commit:

bb5ccf225e81d2801c03e63d16c371f0617270e8
<https://github.com/qemu/qemu/commit/bb5ccf225e81d2801c03e63d16c371f0617270=
e8#diff-d7db5c644ce52a6080e77ef1e7a3811b>

I am not familiar with QAPI doc generator, but shouldn't "Since: 3.0"
cause the same problem as "ppcemb: dropped in 3.1"? If not, why?

Yours,
Aleksandar

> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>
>

--00000000000057a6c6059f560ce5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Mon, Feb 24, 2020 at 4:31 PM Eric Blake &lt;<a =
href=3D"mailto:eblake@redhat.com">eblake@redhat.com</a>&gt; wrote:<br>&gt;<=
br>&gt; On 2/24/20 9:15 AM, Philippe Mathieu-Daud=C3=A9 wrote:<br>&gt; &gt;=
 On 2/24/20 4:11 PM, Eric Blake wrote:<br>&gt; &gt;&gt; On 2/23/20 12:51 AM=
, Yoshinori Sato wrote:<br>&gt; &gt;&gt;&gt; Tested-by: Philippe Mathieu-Da=
ud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt;=
<br>&gt; &gt;&gt;&gt; Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=
=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt;<br>&gt; &gt;&gt;&gt=
; Signed-off-by: Yoshinori Sato &lt;<a href=3D"mailto:ysato@users.sourcefor=
ge.jp">ysato@users.sourceforge.jp</a>&gt;<br>&gt; &gt;&gt;&gt; Message-Id: =
&lt;<a href=3D"mailto:20190607091116.49044-17-ysato@users.sourceforge.jp">2=
0190607091116.49044-17-ysato@users.sourceforge.jp</a>&gt;<br>&gt; &gt;&gt;&=
gt; Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderso=
n@linaro.org">richard.henderson@linaro.org</a>&gt;<br>&gt; &gt;&gt;&gt; pic=
k ed65c02993 target/rx: Add RX to SysEmuTarget<br>&gt; &gt;&gt;&gt; pick 01=
372568ae tests: Add rx to machine-none-test.c<br>&gt; &gt;&gt;&gt; [PMD: Sq=
uashed patches from Richard Henderson modifying<br>&gt; &gt;&gt;&gt; =C2=A0=
 =C2=A0 =C2=A0 =C2=A0qapi/common.json and tests/machine-none-test.c]<br>&gt=
; &gt;&gt;&gt; Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"ma=
ilto:philmd@redhat.com">philmd@redhat.com</a>&gt;<br>&gt; &gt;&gt;&gt; ---<=
br>&gt; &gt;&gt;<br>&gt; &gt;&gt;&gt; +++ b/qapi/machine.json<br>&gt; &gt;&=
gt;&gt; @@ -26,7 +26,7 @@<br>&gt; &gt;&gt;&gt; =C2=A0 =C2=A0 &#39;data&#39;=
 : [ &#39;aarch64&#39;, &#39;alpha&#39;, &#39;arm&#39;, &#39;cris&#39;, &#3=
9;hppa&#39;, &#39;i386&#39;,<br>&gt; &gt;&gt;&gt; &#39;lm32&#39;,<br>&gt; &=
gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;m68=
k&#39;, &#39;microblaze&#39;, &#39;microblazeel&#39;, &#39;mips&#39;, &#39;=
mips64&#39;,<br>&gt; &gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0&#39;mips64el&#39;, &#39;mipsel&#39;, &#39;moxie&#39;, &#39;n=
ios2&#39;, &#39;or1k&#39;, &#39;ppc&#39;,<br>&gt; &gt;&gt;&gt; - =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;ppc64&#39;, &#39;riscv32&#39;, &#39;ri=
scv64&#39;, &#39;s390x&#39;, &#39;sh4&#39;,<br>&gt; &gt;&gt;&gt; + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;ppc64&#39;, &#39;riscv32&#39;, &#39=
;riscv64&#39;, &#39;rx&#39;, &#39;s390x&#39;, &#39;sh4&#39;,<br>&gt; &gt;&g=
t;<br>&gt; &gt;&gt; Missing mention of the new enum member with a &#39;sinc=
e 5.0&#39; designation<br>&gt; &gt;&gt; in the documentation.<br>&gt; &gt;<=
br>&gt; &gt; Is this something we can automate? Maybe dumping all the qapi =
data when<br>&gt; &gt; we do a release, then check the differences before t=
he next release?<br>&gt;<br>&gt; Probably. It&#39;s already easy to automat=
e a dump of qmp introspection data<br>&gt; from an arbitrary commit, and di=
ffing the output between the previous<br>&gt; commit release point and the =
current proposed release should be<br>&gt; technically possible.=C2=A0 Our =
QAPI generator also generates the docs, which<br>&gt; means it can be enhan=
ced to denote which doc elements are tagged to<br>&gt; which versions.=C2=
=A0 Might make a good GSOC project.<br>&gt;<br><br>Hello, all (but mostly P=
eter and Eric).<br><br>Just want to bring to your attention a point that is=
 not clear to me here.<div>(forgive me for being an outsider in this area)<=
br><br>Could you please take a look at commit:<br><div><br></div><div><a hr=
ef=3D"https://github.com/qemu/qemu/commit/bb5ccf225e81d2801c03e63d16c371f06=
17270e8#diff-d7db5c644ce52a6080e77ef1e7a3811b">bb5ccf225e81d2801c03e63d16c3=
71f0617270e8</a><br><br>I am not familiar with QAPI doc generator, but shou=
ldn&#39;t &quot;Since: 3.0&quot;</div><div>cause the same problem as &quot;=
<span style=3D"background-color:rgb(255,238,240);color:rgb(106,115,125);fon=
t-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,monospac=
e;font-size:12px;white-space:pre">ppcemb: dropped in 3.1</span>&quot;? If n=
ot, why?</div><div><br></div><div>Yours,</div><div>Aleksandar</div><div><br=
>&gt; --<br>&gt; Eric Blake, Principal Software Engineer<br>&gt; Red Hat, I=
nc. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +1-919-301-3226<br>&gt; Virtualizati=
on: =C2=A0<a href=3D"http://qemu.org">qemu.org</a> | <a href=3D"http://libv=
irt.org">libvirt.org</a><br>&gt;<br>&gt;</div></div></div>

--00000000000057a6c6059f560ce5--

