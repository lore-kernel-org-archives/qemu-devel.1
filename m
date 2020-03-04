Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D2EC3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 09:39:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FE0D2073D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 09:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE0D2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9QUu-0006He-G3
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 04:39:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1j9QUC-0005pf-46
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 04:38:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1j9QU9-00081l-T0
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 04:38:40 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35311)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1j9QU9-0007z7-Jb
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 04:38:37 -0500
Received: from mail-ot1-f69.google.com ([209.85.210.69])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1j9QU7-0007In-Dr
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 09:38:35 +0000
Received: by mail-ot1-f69.google.com with SMTP id x21so721043otp.6
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 01:38:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=k9G8OPFnChlEiNPznUCFrYXWPPkqrFzK/jYCnbaEJks=;
 b=i2DhJYVE89xPJDR4om/J4CfBE2hTvTMM4YhHSJN2ZAI08zkJCJS86YIvYmPIstHHoN
 pfSx3zHgCK4N4DWshENuxpaVj8n+OYZ2Ex0qYw98Rg/721T6GDayUNCsPq/mP5tJNGUx
 BiS2NuTm9pNyCZuF3LeSu2JW9veqqkb4QE9zepbxLBLqyuwGyMOwMxrJ+JLgtZz9O7C/
 15i8Rg7MQaOWR6v/w+QxwvLk5ifTqSFDSw2+hMLb9ZONAJzySf5mEmFSWz22f8+B/e6c
 ZTBJhCJ7XKQDNxB0FrPFhbZxDZ58COfuW7a3Nf9Q/vaBmHSREwWCkg7NqXdTF/j8/4Jq
 Sj2w==
X-Gm-Message-State: ANhLgQ3ZyxT1bhbqO10ijZX0/2waUQdgjNgmJbCVh8lHULNpFERUqy93
 RF9GoSPzqE1PYKyhmC8Y/hVdjuhkzPc8O4bwN7g1yszWCkWKt+NFVqqwnoVf/q7RGopFu7CDwSm
 co0JirVzR1WZp4S9DZXYceChu0Z7WRV4tjOcTIKI4Ty04rqMM
X-Received: by 2002:aca:dc56:: with SMTP id t83mr1155693oig.105.1583314714340; 
 Wed, 04 Mar 2020 01:38:34 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvu2rJ/OEvP43yoaAxWflHxU01/XAxhsp9hGWtPbMc4TjYZXDCTG5MOYEyT78L9xwx8q1FVMMext3Dmzf39+k8=
X-Received: by 2002:aca:dc56:: with SMTP id t83mr1155686oig.105.1583314714119; 
 Wed, 04 Mar 2020 01:38:34 -0800 (PST)
MIME-Version: 1.0
References: <CAATJJ0KDOsA=Y+zLBT=PhcU0Q+gqRPSWkK0VaksisVC9_i5M_g@mail.gmail.com>
 <20191101093403.GE11296@redhat.com>
In-Reply-To: <20191101093403.GE11296@redhat.com>
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Wed, 4 Mar 2020 10:37:44 +0100
Message-ID: <CAATJJ0L+jdk3ggWx61=AGoTd-FZ64tJ1tzPK8Frgg9Ez+dv6XQ@mail.gmail.com>
Subject: Re: Best practices to handle shared objects through qemu upgrades?
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000001a63ed05a0042fa0"
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001a63ed05a0042fa0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2019 at 10:34 AM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m>
wrote:

> On Fri, Nov 01, 2019 at 08:14:08AM +0100, Christian Ehrhardt wrote:
> > Hi everyone,
> > we've got a bug report recently - on handling qemu .so's through
> > upgrades - that got me wondering how to best handle it.
> > After checking with Paolo yesterday that there is no obvious solution
> > that I missed we agreed this should be brought up on the list for
> > wider discussion.
> > Maybe there already is a good best practise out there, or if it
> > doesn't exist we might want to agree upon one going forward.
> > Let me outline the case and the ideas brought up so far.
> >
> > Case
> > - You have qemu representing a Guest
> > - Due to other constraints e.g. PT you can't live migrate (which would
> > be preferred)
> > - You haven't used a specific shared object yet - lets say RBD storage
> > driver as example
> > - Qemu gets an update, packaging replaces the .so files on disk
> > - The Qemu process and the .so files on disk now have a mismatch in
> $buildid
> > - If you hotplug an RBD device it will fail to load the (now new) .so
>
> What happens when it fails to load ?  Does the user get a graceful
> error message or does QEMU abort ? I'd hope the former.
>
> >
> > On almost any other service than "qemu representing a VM" the answer
> > is "restart it", some even re-exec in place to keep things up and
> > running.
> >
> > Ideas so far:
> > a) Modules are checked by build-id, so keep them in a per build-id dir
> on disk
> >   - qemu could be made looking preferred in -$buildid dir first
> >   - do not remove the packages with .so's on upgrades
> >   - needs a not-too-complex way to detect which buildids running qemu
> processes
> >     have for packaging to be able to "autoclean later"
> >   - Needs some dependency juggling for Distro packaging but IMHO can be
> made
> >     to work if above simple "probing buildid of running qemu" would exi=
st
>
> So this needs a bunch of special QEMU hacks in package mgmt tools
> to prevent the package upgrade & cleanup later. This does not look
> like a viable strategy to me.
>
> >
> > b) Preload the modules before upgrade
> >   - One could load the .so files before upgrade
> >   - The open file reference will keep the content around even with the
> > on disk file gone
> >   - lacking a 'load-module' command that would require fake hotplugs
> > which seems wrong
> >   - Required additional upgrade pre-planning
> >   - kills most benefits of modular code without an actual need for it
> > being loaded
>
> Well there's two benefits to modular approach
>
>  - Allow a single build to be selectively installed on a host or containe=
r
>    image, such that the install disk footprint is reduced
>  - Allow a faster startup such that huge RBD libraries dont slow down
>    startup of VMs not using RBD disks.
>
> Preloading the modules before upgrade doesn't have to the second benefit.
> We just have to make sure the pre loading doesn't impact the VM startup
> performance.
>
> IOW, register a SIGUSR2 handler which preloads all modules it finds on
> disk. Have a pre-uninstall option on the .so package that sends SIGUSR2
> to all QEMU processes. The challenge of course is that signals are
> async. You might suggest a QMP command, but only 1 process can have the
> QMP monitor open at any time and that's libvirt. Adding a second QMP
> monitor instance is possible but kind of gross for this purpose.
>
> Another option would be to pre-load the modules during startup, but
> do it asynchronously, so that its not blocking overall VM startup.
> eg just before starting the mainloop, spawn a background thread to
> load all remaining modules.
>
> This will potentially degrade performance of the guest CPUs a bit,
> but avoids the latency spike from being synchronous in the startup
> path.
>
>
> > c) go back to non modular build
> >   - No :-)
> >
> > d) anything else out there?
>
> e) Don't do upgrades on a host with running VMs :-)
>
>    Upgrades can break the running VM even ignoring this particular
>    QEMU module scenario.
>
> f) Simply document that if you upgrade with running VMs that some
>    features like hotplug of RBD will become unavialable. Users can
>    then avoid upgrades if that matters to them.
>

Hi,
I've come back to this after a while and now think all the pre-load or
load-command Ideas we had were in vain.
They would be overly complex and need a lot of integration into different
places to trigger them.
All of that would not be well integrated in the trigger of the issue itself
which usually is a package upgrade.

But qemu already does try to load modules from different places and with a
slight extension there I think we could
provide something that packaging (the actual place knowing about upgrades)
can use to avoid this issue.

I'll reply to this thread with a patch for your consideration in a few
minutes.

There is already a Ubuntu 20.04 test build with the qemu and packaging
changes in [1].
The related Debian/Ubuntu packaging changes themselves can be seen in [2].
I hope that helps to illustrate how it would work overall

[1]: https://launchpad.net/~ci-train-ppa-service/+archive/ubuntu/3961
[2]:
https://git.launchpad.net/~paelzer/ubuntu/+source/qemu/log/?h=3Dbug-1847361=
-miss-old-so-on-upgrade-UBUNTU



> Regards,
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

--0000000000001a63ed05a0042fa0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Nov 1, 2019 at 10:34 AM Danie=
l P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redh=
at.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On Fri, Nov 01, 2019 at 08:14:08AM +0100, Christian Ehrhardt wrote:<b=
r>
&gt; Hi everyone,<br>
&gt; we&#39;ve got a bug report recently - on handling qemu .so&#39;s throu=
gh<br>
&gt; upgrades - that got me wondering how to best handle it.<br>
&gt; After checking with Paolo yesterday that there is no obvious solution<=
br>
&gt; that I missed we agreed this should be brought up on the list for<br>
&gt; wider discussion.<br>
&gt; Maybe there already is a good best practise out there, or if it<br>
&gt; doesn&#39;t exist we might want to agree upon one going forward.<br>
&gt; Let me outline the case and the ideas brought up so far.<br>
&gt; <br>
&gt; Case<br>
&gt; - You have qemu representing a Guest<br>
&gt; - Due to other constraints e.g. PT you can&#39;t live migrate (which w=
ould<br>
&gt; be preferred)<br>
&gt; - You haven&#39;t used a specific shared object yet - lets say RBD sto=
rage<br>
&gt; driver as example<br>
&gt; - Qemu gets an update, packaging replaces the .so files on disk<br>
&gt; - The Qemu process and the .so files on disk now have a mismatch in $b=
uildid<br>
&gt; - If you hotplug an RBD device it will fail to load the (now new) .so<=
br>
<br>
What happens when it fails to load ?=C2=A0 Does the user get a graceful<br>
error message or does QEMU abort ? I&#39;d hope the former.<br>
<br>
&gt; <br>
&gt; On almost any other service than &quot;qemu representing a VM&quot; th=
e answer<br>
&gt; is &quot;restart it&quot;, some even re-exec in place to keep things u=
p and<br>
&gt; running.<br>
&gt; <br>
&gt; Ideas so far:<br>
&gt; a) Modules are checked by build-id, so keep them in a per build-id dir=
 on disk<br>
&gt;=C2=A0 =C2=A0- qemu could be made looking preferred in -$buildid dir fi=
rst<br>
&gt;=C2=A0 =C2=A0- do not remove the packages with .so&#39;s on upgrades<br=
>
&gt;=C2=A0 =C2=A0- needs a not-too-complex way to detect which buildids run=
ning qemu processes<br>
&gt;=C2=A0 =C2=A0 =C2=A0have for packaging to be able to &quot;autoclean la=
ter&quot;<br>
&gt;=C2=A0 =C2=A0- Needs some dependency juggling for Distro packaging but =
IMHO can be made<br>
&gt;=C2=A0 =C2=A0 =C2=A0to work if above simple &quot;probing buildid of ru=
nning qemu&quot; would exist<br>
<br>
So this needs a bunch of special QEMU hacks in package mgmt tools<br>
to prevent the package upgrade &amp; cleanup later. This does not look<br>
like a viable strategy to me.<br>
<br>
&gt; <br>
&gt; b) Preload the modules before upgrade<br>
&gt;=C2=A0 =C2=A0- One could load the .so files before upgrade<br>
&gt;=C2=A0 =C2=A0- The open file reference will keep the content around eve=
n with the<br>
&gt; on disk file gone<br>
&gt;=C2=A0 =C2=A0- lacking a &#39;load-module&#39; command that would requi=
re fake hotplugs<br>
&gt; which seems wrong<br>
&gt;=C2=A0 =C2=A0- Required additional upgrade pre-planning<br>
&gt;=C2=A0 =C2=A0- kills most benefits of modular code without an actual ne=
ed for it<br>
&gt; being loaded<br>
<br>
Well there&#39;s two benefits to modular approach<br>
<br>
=C2=A0- Allow a single build to be selectively installed on a host or conta=
iner<br>
=C2=A0 =C2=A0image, such that the install disk footprint is reduced<br>
=C2=A0- Allow a faster startup such that huge RBD libraries dont slow down<=
br>
=C2=A0 =C2=A0startup of VMs not using RBD disks.<br>
<br>
Preloading the modules before upgrade doesn&#39;t have to the second benefi=
t.<br>
We just have to make sure the pre loading doesn&#39;t impact the VM startup=
<br>
performance.<br>
<br>
IOW, register a SIGUSR2 handler which preloads all modules it finds on<br>
disk. Have a pre-uninstall option on the .so package that sends SIGUSR2<br>
to all QEMU processes. The challenge of course is that signals are<br>
async. You might suggest a QMP command, but only 1 process can have the<br>
QMP monitor open at any time and that&#39;s libvirt. Adding a second QMP<br=
>
monitor instance is possible but kind of gross for this purpose.<br>
<br>
Another option would be to pre-load the modules during startup, but<br>
do it asynchronously, so that its not blocking overall VM startup.<br>
eg just before starting the mainloop, spawn a background thread to<br>
load all remaining modules.<br>
<br>
This will potentially degrade performance of the guest CPUs a bit,<br>
but avoids the latency spike from being synchronous in the startup<br>
path.<br>
<br>
<br>
&gt; c) go back to non modular build<br>
&gt;=C2=A0 =C2=A0- No :-)<br>
&gt; <br>
&gt; d) anything else out there?<br>
<br>
e) Don&#39;t do upgrades on a host with running VMs :-)<br>
<br>
=C2=A0 =C2=A0Upgrades can break the running VM even ignoring this particula=
r<br>
=C2=A0 =C2=A0QEMU module scenario. <br>
<br>
f) Simply document that if you upgrade with running VMs that some<br>
=C2=A0 =C2=A0features like hotplug of RBD will become unavialable. Users ca=
n<br>
=C2=A0 =C2=A0then avoid upgrades if that matters to them.<br></blockquote><=
div><br></div><div>Hi,</div><div>I&#39;ve come back to this after a while a=
nd now think all the pre-load or load-command Ideas we had were in vain.</d=
iv><div>They would be overly complex and need a lot of integration into dif=
ferent places to trigger them.</div><div>All of that would not be well inte=
grated in the trigger of the issue itself which usually=C2=A0is a package u=
pgrade.</div><div><br></div><div>But qemu already does try to load modules =
from different places and with a slight extension there I think we could</d=
iv><div>provide something that packaging (the actual place knowing about=C2=
=A0upgrades) can use to avoid this issue.</div><div><br></div><div>I&#39;ll=
 reply to this thread with a patch for your consideration in a few minutes.=
</div><div><br></div><div>There is already a Ubuntu 20.04 test build with t=
he qemu and packaging changes in [1].</div><div>The related Debian/Ubuntu p=
ackaging changes themselves can be seen in [2].</div><div>I hope that helps=
 to illustrate how it would work overall</div><div><br></div><div>[1]:=C2=
=A0<a href=3D"https://launchpad.net/~ci-train-ppa-service/+archive/ubuntu/3=
961">https://launchpad.net/~ci-train-ppa-service/+archive/ubuntu/3961</a></=
div><div>[2]:=C2=A0<a href=3D"https://git.launchpad.net/~paelzer/ubuntu/+so=
urce/qemu/log/?h=3Dbug-1847361-miss-old-so-on-upgrade-UBUNTU">https://git.l=
aunchpad.net/~paelzer/ubuntu/+source/qemu/log/?h=3Dbug-1847361-miss-old-so-=
on-upgrade-UBUNTU</a></div><div><br></div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
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

--0000000000001a63ed05a0042fa0--

