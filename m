Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A70C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 13:18:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 775DC20873
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 13:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775DC20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBemU-000639-I5
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 09:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jBelC-0005FT-OO
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:17:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jBelA-0008N1-2M
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:17:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52163)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jBel9-0008FY-Ny
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:17:23 -0400
Received: from mail-ua1-f69.google.com ([209.85.222.69])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jBel7-00046X-KA
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 13:17:21 +0000
Received: by mail-ua1-f69.google.com with SMTP id l10so2066410uao.9
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 06:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LSz40UBY6A1D2RqKKB9d7NCSEmOiZ/oy1Nltm3um4M8=;
 b=e8QbdhXDDNJT/HZYDRV4ENtp4C9vD6IjhrdtdgsRtNemZA625s1z8lXlYKfcf1pLWR
 e/BQNNmboSYOBjhYFGmpV/god6SWZg5tWN2fkIlq8sn0ewiFTIAaa5sTZRm8g5QWyHUP
 9cVHAJEBj24bnsh1IzrhVPQUHnAWFL3bmD2tGnkhw1JKVz3ieeYzwk7DuZkYkByj0l16
 v91SXVsVYnhK3ERtfsKlEKW8TVs45763M3aZCuvu2bqGEwgRDwd6y+44NpjkxCxHz6+H
 myOL0VSzidUexasvyntlx+bBFsbAuhG4zV9q3JIVdW9Gh5t7v27VKRcJWsc6nvxENC6I
 4JZA==
X-Gm-Message-State: ANhLgQ2eKyx7bdv8Hih3SOySKYdq8MT/Yiaav5akmnxEQgoRuZoizgf5
 f9tnuLUN+txplF5J2L2XTDOOUaOpmQry9qUUmlrKMT3+6wJ2Kq+glpr5FloqsTlrDw8KDVhWilk
 NT5wIrnQr6tqiBeqxGjEmlKBee8N8rJ7ZjM66j/7bRfg9VvBC
X-Received: by 2002:a67:7dd0:: with SMTP id y199mr5656692vsc.158.1583846240595; 
 Tue, 10 Mar 2020 06:17:20 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvdsnVeYoOFJzTesn0FYjTWyOfEHlbjMjZwOb6ehOQtHCyBJerHF+tvHgfxvFAR9gpK2CjJM7RfTAwDXYhJRRg=
X-Received: by 2002:a67:7dd0:: with SMTP id y199mr5656672vsc.158.1583846240233; 
 Tue, 10 Mar 2020 06:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200306132648.27577-1-christian.ehrhardt@canonical.com>
 <20200310093910.GB140737@stefanha-x1.localdomain>
 <20200310120951.GF3234052@redhat.com>
In-Reply-To: <20200310120951.GF3234052@redhat.com>
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Tue, 10 Mar 2020 14:16:54 +0100
Message-ID: <CAATJJ0KYwqGvQSg=JB0Lu4GkNLEkCm2grbVNomNudApHy5CuuQ@mail.gmail.com>
Subject: Re: [PATCH] modules: load modules from versioned /var/run dir
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000087426205a07ff0ce"
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 pkg-qemu-devel@lists.alioth.debian.org, Cole Robinson <crobinso@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Miroslav Rezanina <mrezanin@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000087426205a07ff0ce
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2020 at 1:10 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m>
wrote:

> On Tue, Mar 10, 2020 at 09:39:10AM +0000, Stefan Hajnoczi wrote:
> > On Fri, Mar 06, 2020 at 02:26:48PM +0100, Christian Ehrhardt wrote:
> > > On upgrades the old .so files usually are replaced. But on the other
> > > hand since a qemu process represents a guest instance it is usually
> kept
> > > around.
> > >
> > > That makes late addition of dynamic features e.g. 'hot-attach of a ce=
ph
> > > disk' fail by trying to load a new version of e.f. block-rbd.so into =
an
> > > old still running qemu binary.
> > >
> > > This adds a fallback to also load modules from a versioned directory
> in the
> > > temporary /var/run path. That way qemu is providing a way for packagi=
ng
> > > to store modules of an upgraded qemu package as needed until the next
> reboot.
> > >
> > > An example how that can then be used in packaging can be seen in:
> > >
> https://git.launchpad.net/~paelzer/ubuntu/+source/qemu/log/?h=3Dbug-18473=
61-miss-old-so-on-upgrade-UBUNTU
> > >
> > > Fixes: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1847361
> > > Signed-off-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
> > > ---
> > >  util/module.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> >
> > CCing Debian, Fedora, and Red Hat package maintainers in case they have
> > comments.
> >
> > The use of /var/run makes me a little uneasy.  I guess it's related to
> > wanting to uninstall the old package so the .so in their original
> > location cannot be used (even if they had a versioned path)?
> >
> > I'm not a package maintainer though so I hope the others will make
> > suggestions if there are other solutions :).
>
> My first concern is that this only partially solves the quoted problem.
>
> Consider the QEMU RBD module which is
>
>    /usr/lib64/qemu/block-rbd.so
>
> This links to
>
>    /usr/lib64/librbd.so.1
>
> On host OS upgrade, just before uninstalling old QEMU we copy RBD
> module into:
>
>    /var/run/qemu-$VER/block-rbd.so
>
> ....but the host OS upgrade also upgrades RBD itself to a new
> major version which ships
>
>    /usr/lib64/librbd.so.2



We've got /var/run/qemu-$VER/block-rbd.so saved, but we didn't
> transitively save all the things that this linked to, so there's
> no guarantee it will still be possible to load it.
>
> IOW, this approach of saving QEMU block modules to a scratch dir
> works, *provided* everything else that this QEMU block module needs
> still exists in a compatible form.
>
> Some distros may have a policy that no incompatible soname bumps
> are permitted in updates, but that's not universal.
>

Hi Daniel,
Yeah for "us" being Ubuntu that would certainly be true.
An upgrade of librbd.so.1 to librbd.so.2 would only happen at a major
upgrade.
For example in Ubuntu terms e.g. 18.04 to 20.04. Those upgrades usually
come with a requirement to reboot anyway - I'm not trying to solve these.

The much more common and frequent small updates to qemu with individual
fixes are what triggers this bug and what my proposal would solve.

On the other hand this is not a big amount of new code, so is not
> a huge maint problem even if only a few people ever use it. I would
> be a bit more comfortable if this search path addition was perhaps
> enabled by an opt-in configure argument, rather than being always
> present.
>

I already suggested opt-in configure before.
I'd keep this just enable/disable unless we really can't agree on a path.
That should be no big issue to add this in v2.

I'm also uneasy about the idea of using a search path ordering for
> doing this.  This means that an old running QEMU is always going
> to first try to load the block-rbd.so from the new QEMU, expect
> to see that fail, and only then fallback to load the block-rbd.so
> that actually matches its build.
>
> IIRC, we have an embedded build-id in the modules that should
> guarantee that the first load attempt always fails, but I'm still

uneasy about that at a conceptual level.
>

Yes that build-id is what prevents it loading the modules of the new
package.

The intention was to keep this change small and not a burden for anyone.
I'm not yet having an idea for a conceptual change that would avoid to rely
on the build-id AND at the same time not make this a huge patch with
probably many new issues we'll find out only much later.

Regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--=20
Christian Ehrhardt
Staff Engineer, Ubuntu Server
Canonical Ltd

--00000000000087426205a07ff0ce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 10, 2020 at 1:10 PM Danie=
l P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redh=
at.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On Tue, Mar 10, 2020 at 09:39:10AM +0000, Stefan Hajnoczi wrote:<br>
&gt; On Fri, Mar 06, 2020 at 02:26:48PM +0100, Christian Ehrhardt wrote:<br=
>
&gt; &gt; On upgrades the old .so files usually are replaced. But on the ot=
her<br>
&gt; &gt; hand since a qemu process represents a guest instance it is usual=
ly kept<br>
&gt; &gt; around.<br>
&gt; &gt; <br>
&gt; &gt; That makes late addition of dynamic features e.g. &#39;hot-attach=
 of a ceph<br>
&gt; &gt; disk&#39; fail by trying to load a new version of e.f. block-rbd.=
so into an<br>
&gt; &gt; old still running qemu binary.<br>
&gt; &gt; <br>
&gt; &gt; This adds a fallback to also load modules from a versioned direct=
ory in the<br>
&gt; &gt; temporary /var/run path. That way qemu is providing a way for pac=
kaging<br>
&gt; &gt; to store modules of an upgraded qemu package as needed until the =
next reboot.<br>
&gt; &gt; <br>
&gt; &gt; An example how that can then be used in packaging can be seen in:=
<br>
&gt; &gt; <a href=3D"https://git.launchpad.net/~paelzer/ubuntu/+source/qemu=
/log/?h=3Dbug-1847361-miss-old-so-on-upgrade-UBUNTU" rel=3D"noreferrer" tar=
get=3D"_blank">https://git.launchpad.net/~paelzer/ubuntu/+source/qemu/log/?=
h=3Dbug-1847361-miss-old-so-on-upgrade-UBUNTU</a><br>
&gt; &gt; <br>
&gt; &gt; Fixes: <a href=3D"https://bugs.launchpad.net/ubuntu/+source/qemu/=
+bug/1847361" rel=3D"noreferrer" target=3D"_blank">https://bugs.launchpad.n=
et/ubuntu/+source/qemu/+bug/1847361</a><br>
&gt; &gt; Signed-off-by: Christian Ehrhardt &lt;<a href=3D"mailto:christian=
.ehrhardt@canonical.com" target=3D"_blank">christian.ehrhardt@canonical.com=
</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 util/module.c | 7 +++++++<br>
&gt; &gt;=C2=A0 1 file changed, 7 insertions(+)<br>
&gt; <br>
&gt; CCing Debian, Fedora, and Red Hat package maintainers in case they hav=
e<br>
&gt; comments.<br>
&gt; <br>
&gt; The use of /var/run makes me a little uneasy.=C2=A0 I guess it&#39;s r=
elated to<br>
&gt; wanting to uninstall the old package so the .so in their original<br>
&gt; location cannot be used (even if they had a versioned path)?<br>
&gt; <br>
&gt; I&#39;m not a package maintainer though so I hope the others will make=
<br>
&gt; suggestions if there are other solutions :).<br>
<br>
My first concern is that this only partially solves the quoted problem.<br>
<br>
Consider the QEMU RBD module which is<br>
<br>
=C2=A0 =C2=A0/usr/lib64/qemu/block-rbd.so<br>
<br>
This links to<br>
<br>
=C2=A0 =C2=A0/usr/lib64/librbd.so.1<br>
<br>
On host OS upgrade, just before uninstalling old QEMU we copy RBD<br>
module into:<br>
<br>
=C2=A0 =C2=A0/var/run/qemu-$VER/block-rbd.so<br>
<br>
....but the host OS upgrade also upgrades RBD itself to a new<br>
major version which ships<br>
<br>
=C2=A0 =C2=A0/usr/lib64/librbd.so.2=C2=A0</blockquote><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">=C2=A0</blockquote><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
We&#39;ve got /var/run/qemu-$VER/block-rbd.so saved, but we didn&#39;t<br>
transitively save all the things that this linked to, so there&#39;s<br>
no guarantee it will still be possible to load it.<br>
<br>
IOW, this approach of saving QEMU block modules to a scratch dir<br>
works, *provided* everything else that this QEMU block module needs<br>
still exists in a compatible form.<br>
<br>
Some distros may have a policy that no incompatible soname bumps<br>
are permitted in updates, but that&#39;s not universal.<br></blockquote><di=
v><br></div><div>Hi Daniel,<br></div><div>Yeah for &quot;us&quot; being Ubu=
ntu that would certainly be true.</div><div></div><div>An upgrade of=C2=A0l=
ibrbd.so.1 to=C2=A0librbd.so.2 would only happen at a major upgrade.<br></d=
iv><div>For example in Ubuntu terms e.g. 18.04 to 20.04. Those upgrades=C2=
=A0usually</div><div>come with a requirement=C2=A0to reboot anyway - I&#39;=
m not trying to solve these.</div><div><br></div><div>The much more common =
and frequent small updates to qemu with individual</div><div>fixes are what=
 triggers this bug and what my proposal would solve.=C2=A0</div><div><br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
On the other hand this is not a big amount of new code, so is not<br>
a huge maint problem even if only a few people ever use it. I would<br>
be a bit more comfortable if this search path addition was perhaps<br>
enabled by an opt-in configure argument, rather than being always<br>
present.<br></blockquote><div><br></div><div>I already suggested opt-in con=
figure before. </div><div>I&#39;d keep this just enable/disable unless we r=
eally=C2=A0can&#39;t agree on a path.</div><div>That should be no big issue=
 to add this in v2.</div><div><br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
I&#39;m also uneasy about the idea of using a search path ordering for<br>
doing this.=C2=A0 This means that an old running QEMU is always going<br>
to first try to load the block-rbd.so from the new QEMU, expect<br>
to see that fail, and only then fallback to load the block-rbd.so<br>
that actually matches its build.<br>
<br>
IIRC, we have an embedded build-id in the modules that should<br>
guarantee that the first load attempt always fails, but I&#39;m still=C2=A0=
</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">uneasy about=
 that at a conceptual level.<br></blockquote><div>=C2=A0</div><div>Yes that=
 build-id is what prevents it loading the modules of the new package.</div>=
<div><br></div><div>The intention was to keep this change small and not a b=
urden for anyone.</div><div>I&#39;m not yet having an idea for a conceptual=
 change that would avoid to=C2=A0rely</div><div>on the build-id AND at the =
same time not make this a huge patch with</div><div>probably many new issue=
s we&#39;ll find out only much later.</div><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
Regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Christian Ehrhardt<br>Staff Engineer, Ubuntu Ser=
ver<br>Canonical Ltd</div></div>

--00000000000087426205a07ff0ce--

