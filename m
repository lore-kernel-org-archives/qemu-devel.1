Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60028C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:50:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22FD0208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22FD0208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBdOz-0002kv-C8
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46259)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jBdMy-0000Cs-NG
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:48:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jBdMw-0007Ns-Lc
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:48:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48315)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jBdMw-0007Fv-Bc
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:48:18 -0400
Received: from mail-vs1-f69.google.com ([209.85.217.69])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jBdMu-0004lz-Pf
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:48:16 +0000
Received: by mail-vs1-f69.google.com with SMTP id s17so558080vss.13
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 04:48:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1Q2kHRdbl/K1sVLqMMLp9u0rpSNaEdkKPA+VQ2h4zFY=;
 b=fn95+Dl/3EK6LezII95ofocvWxlqG7C7T6nomHENIzwHS6dcuyiiXxAI0NFXhV8Trx
 b+3/P7wQRo+mj+kqhn4vrhm13qagoaZKEn1gsSYtr2mCDHvDeuiQVdb/ZXV26CjxQ2MH
 lx7QNNlXmkGt4AfJ6ysDzYZMMXOCVCWAJ8ErmByCeoKSjkTOp4823xrGF+e1l8GGN0bE
 xP2Jlxv3wPEXj2ETcCZrjxtTYhoTUKdNGXkdM6uN0xLhUubn/supcga59zrR1dnUqcGr
 E7epW+4e9O055uCjLhpsrD4kLgFSFxNOvzN8dA4Ghexq4XUqUAVErjhK+GhwZlnSVL4h
 l1dA==
X-Gm-Message-State: ANhLgQ10dP9WnEShxoRR2DDonEPRiZUzm/LCHyjBM4RsZ01p5dDQW3jJ
 q9zciccG0yHUinDZuLajko6a8NxgpzMrozoe3MoT3amky/OHIGpCdX59i4c4j/onU4cYKib7jaE
 p0l7qHrURVM6DdjWm9O69at1ay2xnRobTax60mbPNig9Wz+A5
X-Received: by 2002:a67:f648:: with SMTP id u8mr7770489vso.50.1583840895889;
 Tue, 10 Mar 2020 04:48:15 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuEVtslS3DZJpCo+a1tHZJxj5cDnSRkbPYPl2aCY6kBNBkSIzgh5R2lBZ0pEPWbo31J5YyXvmFTvGA9DZ2BayY=
X-Received: by 2002:a67:f648:: with SMTP id u8mr7770480vso.50.1583840895615;
 Tue, 10 Mar 2020 04:48:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200306132648.27577-1-christian.ehrhardt@canonical.com>
 <20200310093910.GB140737@stefanha-x1.localdomain>
In-Reply-To: <20200310093910.GB140737@stefanha-x1.localdomain>
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Tue, 10 Mar 2020 12:47:49 +0100
Message-ID: <CAATJJ0KvA65i4463wCX1m2e4L=r=O1oaFjojXDvOX3otmMX=dg@mail.gmail.com>
Subject: Re: [PATCH] modules: load modules from versioned /var/run dir
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000f6dd8505a07eb10e"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 91.189.89.112
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
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, pkg-qemu-devel@lists.alioth.debian.org,
 Cole Robinson <crobinso@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Miroslav Rezanina <mrezanin@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f6dd8505a07eb10e
Content-Type: text/plain; charset="UTF-8"

On Tue, Mar 10, 2020 at 10:39 AM Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Fri, Mar 06, 2020 at 02:26:48PM +0100, Christian Ehrhardt wrote:
> > On upgrades the old .so files usually are replaced. But on the other
> > hand since a qemu process represents a guest instance it is usually kept
> > around.
> >
> > That makes late addition of dynamic features e.g. 'hot-attach of a ceph
> > disk' fail by trying to load a new version of e.f. block-rbd.so into an
> > old still running qemu binary.
> >
> > This adds a fallback to also load modules from a versioned directory in
> the
> > temporary /var/run path. That way qemu is providing a way for packaging
> > to store modules of an upgraded qemu package as needed until the next
> reboot.
> >
> > An example how that can then be used in packaging can be seen in:
> >
> https://git.launchpad.net/~paelzer/ubuntu/+source/qemu/log/?h=bug-1847361-miss-old-so-on-upgrade-UBUNTU
> >
> > Fixes: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1847361
> > Signed-off-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
> > ---
> >  util/module.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
>
> CCing Debian, Fedora, and Red Hat package maintainers in case they have
> comments.
>

Yeah that seems worth, thanks Stefan.

The use of /var/run makes me a little uneasy.  I guess it's related to
> wanting to uninstall the old package so the .so in their original
> location cannot be used (even if they had a versioned path)?
>

Yes you'd want to uninstall the old bits from disk - even if there would be
a versioned path.
/var/run was considered a nice place as it is auto-cleaned on a reboot
avoiding a massive
and most likely broken logic trying to detect which qemu versions still
have running binaries.

And no distro will have so many qemu updates that N*~<100k for the .so
files will really grow too big.

Also if the path would end up to be the major concern and we can't agree
on a single one we can consider making this:
1. not checking an extra path if not configured
2. on configure packaging can set a path of their choice

I have not done so yet as I was hoping for a simpler patch and
everyone knowing what to expect across e.g. distros.
It also will make isolation easier for example I also have apparmor changes
for libvirt allowing that path which is more complex if it ends up
configurable.

And finally this has to be considered an "offer" by qemu to the packagers
to fix a real field issue.
The packaging does not "have to" exploit this, every Distro is free to just
ignore it.

I'm not a package maintainer though so I hope the others will make
> suggestions if there are other solutions :).
>
> >
> > diff --git a/util/module.c b/util/module.c
> > index 236a7bb52a..d2446104be 100644
> > --- a/util/module.c
> > +++ b/util/module.c
> > @@ -19,6 +19,7 @@
> >  #endif
> >  #include "qemu/queue.h"
> >  #include "qemu/module.h"
> > +#include "qemu-version.h"
> >
> >  typedef struct ModuleEntry
> >  {
> > @@ -170,6 +171,7 @@ bool module_load_one(const char *prefix, const char
> *lib_name)
> >  #ifdef CONFIG_MODULES
> >      char *fname = NULL;
> >      char *exec_dir;
> > +    char *version_dir;
> >      const char *search_dir;
> >      char *dirs[4];
> >      char *module_name;
> > @@ -201,6 +203,11 @@ bool module_load_one(const char *prefix, const char
> *lib_name)
> >      dirs[n_dirs++] = g_strdup_printf("%s", CONFIG_QEMU_MODDIR);
> >      dirs[n_dirs++] = g_strdup_printf("%s/..", exec_dir ? : "");
> >      dirs[n_dirs++] = g_strdup_printf("%s", exec_dir ? : "");
> > +    version_dir = g_strcanon(g_strdup(QEMU_PKGVERSION),
> > +                             G_CSET_A_2_Z G_CSET_a_2_z G_CSET_DIGITS
> "+-.~",
> > +                             '_');
> > +    dirs[n_dirs++] = g_strdup_printf("/var/run/qemu/%s", version_dir);
> > +
> >      assert(n_dirs <= ARRAY_SIZE(dirs));
> >
> >      g_free(exec_dir);
> > --
> > 2.25.1
> >
> >
>


-- 
Christian Ehrhardt
Staff Engineer, Ubuntu Server
Canonical Ltd

--000000000000f6dd8505a07eb10e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 10, 2020 at 10:39 AM Stef=
an Hajnoczi &lt;<a href=3D"mailto:stefanha@gmail.com">stefanha@gmail.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On =
Fri, Mar 06, 2020 at 02:26:48PM +0100, Christian Ehrhardt wrote:<br>
&gt; On upgrades the old .so files usually are replaced. But on the other<b=
r>
&gt; hand since a qemu process represents a guest instance it is usually ke=
pt<br>
&gt; around.<br>
&gt; <br>
&gt; That makes late addition of dynamic features e.g. &#39;hot-attach of a=
 ceph<br>
&gt; disk&#39; fail by trying to load a new version of e.f. block-rbd.so in=
to an<br>
&gt; old still running qemu binary.<br>
&gt; <br>
&gt; This adds a fallback to also load modules from a versioned directory i=
n the<br>
&gt; temporary /var/run path. That way qemu is providing a way for packagin=
g<br>
&gt; to store modules of an upgraded qemu package as needed until the next =
reboot.<br>
&gt; <br>
&gt; An example how that can then be used in packaging can be seen in:<br>
&gt; <a href=3D"https://git.launchpad.net/~paelzer/ubuntu/+source/qemu/log/=
?h=3Dbug-1847361-miss-old-so-on-upgrade-UBUNTU" rel=3D"noreferrer" target=
=3D"_blank">https://git.launchpad.net/~paelzer/ubuntu/+source/qemu/log/?h=
=3Dbug-1847361-miss-old-so-on-upgrade-UBUNTU</a><br>
&gt; <br>
&gt; Fixes: <a href=3D"https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/=
1847361" rel=3D"noreferrer" target=3D"_blank">https://bugs.launchpad.net/ub=
untu/+source/qemu/+bug/1847361</a><br>
&gt; Signed-off-by: Christian Ehrhardt &lt;<a href=3D"mailto:christian.ehrh=
ardt@canonical.com" target=3D"_blank">christian.ehrhardt@canonical.com</a>&=
gt;<br>
&gt; ---<br>
&gt;=C2=A0 util/module.c | 7 +++++++<br>
&gt;=C2=A0 1 file changed, 7 insertions(+)<br>
<br>
CCing Debian, Fedora, and Red Hat package maintainers in case they have<br>
comments.<br></blockquote><div>=C2=A0</div><div>Yeah that seems worth, than=
ks Stefan.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
The use of /var/run makes me a little uneasy.=C2=A0 I guess it&#39;s relate=
d to<br>
wanting to uninstall the old package so the .so in their original<br>
location cannot be used (even if they had a versioned path)?<br></blockquot=
e><div>=C2=A0</div><div>Yes you&#39;d want to uninstall the old bits from d=
isk - even if there would be a versioned path.</div><div>/var/run was consi=
dered a nice place as it is auto-cleaned on a reboot avoiding a massive</di=
v><div>and most likely broken logic trying to detect which qemu versions st=
ill have running binaries.</div><div><br></div><div>And no distro will have=
 so many qemu updates that N*~&lt;100k for the .so files will really grow t=
oo big.</div><div><br></div><div>Also if the path would end up to be the ma=
jor concern and we can&#39;t agree</div><div>on a single one we can conside=
r making this:</div><div>1. not checking an extra path if not configured</d=
iv><div>2. on configure packaging can set a path of their choice</div><div>=
<br></div><div>I have not done so yet as I was hoping for a simpler patch a=
nd everyone=C2=A0knowing what to expect across e.g. distros.</div><div>It a=
lso will make isolation easier for example I also have apparmor changes for=
 libvirt allowing that path which is more complex if it ends up configurabl=
e.</div><div><br></div><div>And finally this has to be considered an &quot;=
offer&quot; by qemu to the packagers to fix a real field issue.</div><div>T=
he=C2=A0packaging does not &quot;have to&quot; exploit this, every=C2=A0Dis=
tro is free to just ignore it.</div><div><br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
I&#39;m not a package maintainer though so I hope the others will make<br>
suggestions if there are other solutions :).<br>
<br>
&gt; <br>
&gt; diff --git a/util/module.c b/util/module.c<br>
&gt; index 236a7bb52a..d2446104be 100644<br>
&gt; --- a/util/module.c<br>
&gt; +++ b/util/module.c<br>
&gt; @@ -19,6 +19,7 @@<br>
&gt;=C2=A0 #endif<br>
&gt;=C2=A0 #include &quot;qemu/queue.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/module.h&quot;<br>
&gt; +#include &quot;qemu-version.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 typedef struct ModuleEntry<br>
&gt;=C2=A0 {<br>
&gt; @@ -170,6 +171,7 @@ bool module_load_one(const char *prefix, const cha=
r *lib_name)<br>
&gt;=C2=A0 #ifdef CONFIG_MODULES<br>
&gt;=C2=A0 =C2=A0 =C2=A0 char *fname =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 char *exec_dir;<br>
&gt; +=C2=A0 =C2=A0 char *version_dir;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 const char *search_dir;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 char *dirs[4];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 char *module_name;<br>
&gt; @@ -201,6 +203,11 @@ bool module_load_one(const char *prefix, const ch=
ar *lib_name)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 dirs[n_dirs++] =3D g_strdup_printf(&quot;%s&quot;,=
 CONFIG_QEMU_MODDIR);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 dirs[n_dirs++] =3D g_strdup_printf(&quot;%s/..&quo=
t;, exec_dir ? : &quot;&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 dirs[n_dirs++] =3D g_strdup_printf(&quot;%s&quot;,=
 exec_dir ? : &quot;&quot;);<br>
&gt; +=C2=A0 =C2=A0 version_dir =3D g_strcanon(g_strdup(QEMU_PKGVERSION),<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0G_CSET_A_2_Z G_CSET_a_2_z G_CSET_DIGITS =
&quot;+-.~&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;_&#39;);<br>
&gt; +=C2=A0 =C2=A0 dirs[n_dirs++] =3D g_strdup_printf(&quot;/var/run/qemu/=
%s&quot;, version_dir);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 assert(n_dirs &lt;=3D ARRAY_SIZE(dirs));<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_free(exec_dir);<br>
&gt; -- <br>
&gt; 2.25.1<br>
&gt; <br>
&gt; <br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Christian Ehrhardt<br>Staff Engineer, Ubuntu Ser=
ver<br>Canonical Ltd</div></div>

--000000000000f6dd8505a07eb10e--

