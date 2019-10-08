Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14345C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:08:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBA41217D7
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA41217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=freebsd.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHsyg-00042g-Ue
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 13:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vmaffione@freebsd.org>) id 1iHswV-0003Ve-L6
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:06:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vmaffione@freebsd.org>) id 1iHswU-0003Cr-5M
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:06:35 -0400
Received: from mx2.freebsd.org ([96.47.72.81]:33293)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vmaffione@freebsd.org>)
 id 1iHswU-0003Bz-09; Tue, 08 Oct 2019 13:06:34 -0400
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client CN "mx1.freebsd.org",
 Issuer "Let's Encrypt Authority X3" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id BC5E28ECE9;
 Tue,  8 Oct 2019 17:06:32 +0000 (UTC)
 (envelope-from vmaffione@freebsd.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org",
 Issuer "Let's Encrypt Authority X3" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 46nkK43psYz4GMm;
 Tue,  8 Oct 2019 17:06:32 +0000 (UTC)
 (envelope-from vmaffione@freebsd.org)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "GTS CA 1O1" (verified OK))
 (Authenticated sender: vmaffione)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 55B1BB8F0;
 Tue,  8 Oct 2019 17:06:32 +0000 (UTC)
 (envelope-from vmaffione@freebsd.org)
Received: by mail-qk1-f179.google.com with SMTP id y144so17433984qkb.7;
 Tue, 08 Oct 2019 10:06:32 -0700 (PDT)
X-Gm-Message-State: APjAAAVLDKueGq+TY4oOCklV5ZUxzz7DyR1n0K391Epm8b7eXudNMKRG
 w1jZxF1OTzFReigv26sBkS1MYLEbI+U7ps5AyPU=
X-Google-Smtp-Source: APXvYqzFztXI4tNVfpqNXnH1NjVIhd6FjYaWLJLIkSRVtc7cDcO+xxaDfJ1I0NaN/rUHup6gtxyN9v9QzVSsZL6ruYA=
X-Received: by 2002:ae9:e00e:: with SMTP id m14mr11163105qkk.96.1570554391718; 
 Tue, 08 Oct 2019 10:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <20191008084931.12753-1-thuth@redhat.com>
 <CAGxU2F61+TjSy_GJ_2673--VLstVyJjNoqqPdZw+ej22xbzk=Q@mail.gmail.com>
 <CAKBkRUwiNV7qUhcDYak9s65bbb5PzzZWp3x6-pKCn5H0cJFrFg@mail.gmail.com>
In-Reply-To: <CAKBkRUwiNV7qUhcDYak9s65bbb5PzzZWp3x6-pKCn5H0cJFrFg@mail.gmail.com>
From: Vincenzo Maffione <vmaffione@freebsd.org>
Date: Tue, 8 Oct 2019 19:07:54 +0200
X-Gmail-Original-Message-ID: <CA+_eA9ix_uGMUofKP48pARQ6DAKqNoVe8JTfbAFBv6Zi2HO3Ug@mail.gmail.com>
Message-ID: <CA+_eA9ix_uGMUofKP48pARQ6DAKqNoVe8JTfbAFBv6Zi2HO3Ug@mail.gmail.com>
Subject: Re: [PATCH] Test netmap on FreeBSD
To: Li-Wen Hsu <lwhsu@freebsd.org>
Content-Type: multipart/alternative; boundary="0000000000009e711a0594693004"
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 96.47.72.81
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
Cc: Thomas Huth <thuth@redhat.com>, Ed Maste <emaste@freebsd.org>,
 qemu-trivial@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu devel list <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Giuseppe Lettieri <giuseppe.lettieri@unipi.it>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009e711a0594693004
Content-Type: text/plain; charset="UTF-8"

Il giorno mar 8 ott 2019 alle ore 11:53 Li-Wen Hsu <lwhsu@freebsd.org> ha
scritto:

> On Tue, Oct 8, 2019 at 5:49 PM Stefano Garzarella <sgarzare@redhat.com>
> wrote:
> >
> > Hi Thomas,
> >
> > On Tue, Oct 8, 2019 at 10:49 AM Thomas Huth <thuth@redhat.com> wrote:
> > >
> > > FreeBSD offers a package for "netmap", thus let's install it in our
> > > FreeBSD tests to get some compile test coverage for net/netmap.c, too.
> > >
> > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > ---
> > >  .cirrus.yml      | 2 +-
> > >  tests/vm/freebsd | 3 +++
> > >  2 files changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/.cirrus.yml b/.cirrus.yml
> > > index 8326a3a4b1..44fea2c29e 100644
> > > --- a/.cirrus.yml
> > > +++ b/.cirrus.yml
> > > @@ -8,7 +8,7 @@ freebsd_12_task:
> > >      memory: 8G
> > >    install_script: pkg install -y
> > >      bash bison curl cyrus-sasl git glib gmake gnutls gsed
> > > -    nettle perl5 pixman pkgconf png usbredir
> > > +    netmap nettle perl5 pixman pkgconf png usbredir
> >
> > >    script:
> > >      - mkdir build
> > >      - cd build
> > > diff --git a/tests/vm/freebsd b/tests/vm/freebsd
> > > index 2a19461a90..45821702bd 100755
> > > --- a/tests/vm/freebsd
> > > +++ b/tests/vm/freebsd
> > > @@ -54,6 +54,9 @@ class FreeBSDVM(basevm.BaseVM):
> > >          # libs: opengl
> > >          "libepoxy",
> > >          "mesa-libs",
> > > +
> > > +        # libs: network
> > > +        "netmap",
> >
> > IIRC netmap is shipped with the FreeBSD kernel, so we shouldn't need to
> > install it.
> >
> > I tried to understand what is the 'netmap' pkg and I found the following
> > in my FreeBSD 12 VM:
> >
> >     # pkg search netmap
> >     netmap-0.1.3_1         Make a graphical representation of the
> surrounding network
> >
> > I don't think we are installing the right 'netmap' (I know, it is a bit
> > confusing :) )
> >
> > I'll tried "make vm-build-freebsd" without this patch and I noticed
> > "netmap support    yes" in the configure output. So I think we're
> > already compiling the netmap backend in the 'vm-buil-freebsd' target and
> > maybe also in cirrus.
> >
> > Maybe Ed and Li-Wen can confirm (or not).
>
> Yes netmap(4) is a built-in and default feature on FreeBSD. netmap
> package from ports is not related to it.
>
> BTW, I haven't tried qemu's netmap feature on FreeBSD.  Is there
> anything we can test this more?
>

This is an example command line for a qemu VM with a vtnet interface
connected to a port of a VALE switch called 'vale1':

qemu-system-x86_64 fbsd-head.qcow2 -smp 2 -m 2G -vga std -device
e1000,netdev=mgmt,mac=00:AA:BB:CC:0a:99 -netdev
user,id=mgmt,hostfwd=tcp::20010-:22 -device
virtio-net-pci,netdev=data10,mac=00:AA:BB:CC:0a:0a,ioeventfd=on,mrg_rxbuf=on
-netdev netmap,ifname=vale1:10,id=data10

Cheers,
  Vincenzo

>
> Best,
> Li-Wen
>

--0000000000009e711a0594693004
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Il giorno mar 8 ott 2019 alle ore 11:=
53 Li-Wen Hsu &lt;<a href=3D"mailto:lwhsu@freebsd.org">lwhsu@freebsd.org</a=
>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">On Tue, Oct 8, 2019 at 5:49 PM Stefano Garzarella &lt;<a href=3D"mailto:s=
garzare@redhat.com" target=3D"_blank">sgarzare@redhat.com</a>&gt; wrote:<br=
>
&gt;<br>
&gt; Hi Thomas,<br>
&gt;<br>
&gt; On Tue, Oct 8, 2019 at 10:49 AM Thomas Huth &lt;<a href=3D"mailto:thut=
h@redhat.com" target=3D"_blank">thuth@redhat.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; FreeBSD offers a package for &quot;netmap&quot;, thus let&#39;s i=
nstall it in our<br>
&gt; &gt; FreeBSD tests to get some compile test coverage for net/netmap.c,=
 too.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com=
" target=3D"_blank">thuth@redhat.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 .cirrus.yml=C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
&gt; &gt;=C2=A0 tests/vm/freebsd | 3 +++<br>
&gt; &gt;=C2=A0 2 files changed, 4 insertions(+), 1 deletion(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/.cirrus.yml b/.cirrus.yml<br>
&gt; &gt; index 8326a3a4b1..44fea2c29e 100644<br>
&gt; &gt; --- a/.cirrus.yml<br>
&gt; &gt; +++ b/.cirrus.yml<br>
&gt; &gt; @@ -8,7 +8,7 @@ freebsd_12_task:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 memory: 8G<br>
&gt; &gt;=C2=A0 =C2=A0 install_script: pkg install -y<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 bash bison curl cyrus-sasl git glib gmake gnu=
tls gsed<br>
&gt; &gt; -=C2=A0 =C2=A0 nettle perl5 pixman pkgconf png usbredir<br>
&gt; &gt; +=C2=A0 =C2=A0 netmap nettle perl5 pixman pkgconf png usbredir<br=
>
&gt;<br>
&gt; &gt;=C2=A0 =C2=A0 script:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 - mkdir build<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 - cd build<br>
&gt; &gt; diff --git a/tests/vm/freebsd b/tests/vm/freebsd<br>
&gt; &gt; index 2a19461a90..45821702bd 100755<br>
&gt; &gt; --- a/tests/vm/freebsd<br>
&gt; &gt; +++ b/tests/vm/freebsd<br>
&gt; &gt; @@ -54,6 +54,9 @@ class FreeBSDVM(basevm.BaseVM):<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # libs: opengl<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;libepoxy&quot;,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;mesa-libs&quot;,<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # libs: network<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;netmap&quot;,<br>
&gt;<br>
&gt; IIRC netmap is shipped with the FreeBSD kernel, so we shouldn&#39;t ne=
ed to<br>
&gt; install it.<br>
&gt;<br>
&gt; I tried to understand what is the &#39;netmap&#39; pkg and I found the=
 following<br>
&gt; in my FreeBSD 12 VM:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0# pkg search netmap<br>
&gt;=C2=A0 =C2=A0 =C2=A0netmap-0.1.3_1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mak=
e a graphical representation of the surrounding network<br>
&gt;<br>
&gt; I don&#39;t think we are installing the right &#39;netmap&#39; (I know=
, it is a bit<br>
&gt; confusing :) )<br>
&gt;<br>
&gt; I&#39;ll tried &quot;make vm-build-freebsd&quot; without this patch an=
d I noticed<br>
&gt; &quot;netmap support=C2=A0 =C2=A0 yes&quot; in the configure output. S=
o I think we&#39;re<br>
&gt; already compiling the netmap backend in the &#39;vm-buil-freebsd&#39; =
target and<br>
&gt; maybe also in cirrus.<br>
&gt;<br>
&gt; Maybe Ed and Li-Wen can confirm (or not).<br>
<br>
Yes netmap(4) is a built-in and default feature on FreeBSD. netmap<br>
package from ports is not related to it.<br>
<br>
BTW, I haven&#39;t tried qemu&#39;s netmap feature on FreeBSD.=C2=A0 Is the=
re<br>
anything we can test this more?<br></blockquote><div><br></div><div>This is=
 an example command line for a qemu VM with a vtnet interface connected to =
a port of a VALE switch called &#39;vale1&#39;:</div><div><br></div><div><s=
pan style=3D"font-family:monospace">qemu-system-x86_64 fbsd-head.qcow2 -smp=
 2 -m 2G -vga std -device e1000,netdev=3Dmgmt,mac=3D00:AA:BB:CC:0a:99 -netd=
ev user,id=3Dmgmt,hostfwd=3Dtcp::20010-:22 -device virtio-net-pci,netdev=3D=
data10,mac=3D00:AA:BB:CC:0a:0a,ioeventfd=3Don,mrg_rxbuf=3Don -netdev netmap=
,ifname=3Dvale1:10,id=3Ddata10</span></div><div><span style=3D"font-family:=
monospace"><br></span></div><div><span style=3D"font-family:monospace"><fon=
t face=3D"arial,sans-serif">Cheers,</font></span></div><div><span style=3D"=
font-family:monospace"><font face=3D"arial,sans-serif">=C2=A0 Vincenzo</fon=
t><br></span></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Best,<br>
Li-Wen<br>
</blockquote></div></div>

--0000000000009e711a0594693004--

