Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33E8C2BA18
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 08:21:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94AB320672
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 08:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlbND6K+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94AB320672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLN0v-0003Eb-OJ
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 04:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arilou@gmail.com>) id 1jLN01-0002nE-Q5
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 04:20:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arilou@gmail.com>) id 1jLN00-00035R-7R
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 04:20:53 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531]:46494)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <arilou@gmail.com>) id 1jLMzz-00033v-Vw
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 04:20:52 -0400
Received: by mail-ed1-x531.google.com with SMTP id cf14so18092099edb.13
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 01:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=FJoYJi11ItSx6AU+OKnIo36J4RUer+KgF7Wa4L5V2Zk=;
 b=LlbND6K+9rgIMU8MKg8KUlCt+xOJAFII3eBALPp3uEX0YBM39Sq/CmjilDIEKfI6uG
 sd3BrqvUPWlIeMa/eZAQHVrBSoXpuumSiLXiwrmMq8Ro4uvVpTWf/M5IthuOduY13xtd
 7DigU9LzEH4wip78qnMd4sCBqVRbJszWkRRKuoMHVrn4OVvPIkJ9W6VQht7xCcppX9Rs
 u0elETMl9UG/N1hXG48iav4wL3euBHzTCWeHqFEWsMiKK1vyBdM3N/Amw3bNMcQc6ipX
 ReUkbGgAPQ5ZPSx9QeYa6iPomF0IKWK/oXtz2O7re0ROcyDqr8hsxs0kxi535vxiCpRo
 eNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=FJoYJi11ItSx6AU+OKnIo36J4RUer+KgF7Wa4L5V2Zk=;
 b=TcsdtgoPZDeVjBCears5NVOl8nCFMPiCSILu0vJN+ebgGmeS1Ij3KhUrLcZQNaMAHU
 76MAEukcz/R6o033Yxolr51eysAfQypyXc/kn09MbOknc/M1y2ZClBFiwtC0KcdvVFmI
 9/iyQmToffxEo8VVmsHiYM2AMlQuQyrsYG3KFXw9sDxYHNHJfm6bt/AU+E0PM7PBkgsF
 3DJeLULyAwupTwdlAHYjj4yyB5c3na8Zu/SWNCEkUkw1q7Giw/fIv64+1DPTp/ZLOnDT
 8hVhmkU8yYTnUBVEyF/UnAmkHVw//pOOvGU3RzhcT1CW/aQ6jirlksGHvuaYvlqiv7qF
 ay6Q==
X-Gm-Message-State: AGi0PuaOKCt1UJsHDZ7NdAXlIVcBpHnN7GJS75h0hajSxMZN9IaBovnd
 1NeWjn/ihwMmzwOnRXtwXhVcl80Ann3pZm1GaWU=
X-Google-Smtp-Source: APiQypJREHxSKAYpGT2AlIBbfKVQ+u5DB6wZcyqBAhit79epKuJXv5ps7WjvIk22JqG750K5wJ4cm3SEeUzNkgspDsk=
X-Received: by 2002:a17:906:5e4b:: with SMTP id
 b11mr19775128eju.226.1586161250371; 
 Mon, 06 Apr 2020 01:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200403142308.82990-1-arilou@gmail.com>
 <20200403142308.82990-6-arilou@gmail.com>
 <76017793-735b-4bb5-0e69-ecded78af54d@maciej.szmigiero.name>
 <CAP7QCog_EmLJ=O8Xi9Tc4Jst1=z62DXim9ScCyoPv7WugrSyOw@mail.gmail.com>
 <CAP7QCogMdUis-=KsC--0ar2Zt2Vwcpn4HS+qCxPn5khtDTu+mA@mail.gmail.com>
 <9b9c42d3-af9e-25e9-210e-c58ee5975941@maciej.szmigiero.name>
 <472544e7-498a-4e28-06e9-83c102d6436b@maciej.szmigiero.name>
 <20200406073246.GA7707@rvkaganb>
In-Reply-To: <20200406073246.GA7707@rvkaganb>
From: Jon Doron <arilou@gmail.com>
Date: Mon, 6 Apr 2020 11:20:39 +0300
Message-ID: <CAP7QCojPsOYjw94k3rkH0A3rLFADLeVhgy502N=8X5wrUnoC6Q@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] i386: Hyper-V VMBus ACPI DSDT entry
To: Roman Kagan <rvkagan@yandex-team.ru>, 
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Jon Doron <arilou@gmail.com>, 
 QEMU <qemu-devel@nongnu.org>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>,
 ehabkost@redhat.com, 
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
 Liran Alon <liran.alon@oracle.com>, Roman Kagan <rkagan@virtuozzo.com>
Content-Type: multipart/alternative; boundary="000000000000e28e2605a29af1ea"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::531
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e28e2605a29af1ea
Content-Type: text/plain; charset="UTF-8"

Well I want it to be merged in :-)

On Mon, Apr 6, 2020, 10:32 Roman Kagan <rvkagan@yandex-team.ru> wrote:

> On Fri, Apr 03, 2020 at 11:00:27PM +0200, Maciej S. Szmigiero wrote:
> > It seems to me that Roman might not be getting our e-mails since his
> > new e-mail address seems to be "rvkagan@yandex-team.ru".
>
> Indeed.  I'm subscribed with my new address to qemu-devel ML but must
> have missed this series.
>
> > @Roman, are you with us?
>
> Yes ;)
>
> So what are your plans regarding this patchset?
>
> Thanks,
> Roman.
>
> > On 03.04.2020 19:18, Maciej S. Szmigiero wrote:
> > > Hi Jon,
> > >
> > > The patches are available here:
> > > https://github.com/maciejsszmigiero/qemu.git in "vmbus-patches"
> branch.
> > >
> > > Please note that these patches don't have Roman's "Signed-off-by:"
> tags,
> > > so I haven't applied mine, either.
> > >
> > > If you are able to establish a proper SoB chain then please also add:
> > > "Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>".
> > >
> > > Thanks for the effort,
> > > Maciej
> > >
> > > On 03.04.2020 17:30, Jon Doron wrote:
> > >>  Thank you Maciej it seems like your version is really ahead I'll do
> > >> the required work and merge it so i can submit a v2 with the latest
> > >> patchset from Roman
> > >>
> > >> On Fri, Apr 3, 2020 at 6:06 PM Jon Doron <arilou@gmail.com> wrote:
> > >>>
> > >>> Thank you Maciej, I based it on top of what Denis (den@openvz.org)
> gave me
> > >>> which was this:
> > >>>
> https://ftp.openvz.org/virtuozzo/releases/openvz-7.0.12-288/source/SRPMS/q/qemu-kvm-vz-2.12.0-33.vz7.14.4.src.rpm
> > >>>
> > >>> Do you think you have a more recent version I dont mind diffing and
> > >>> resubmitting a new version of the patchset?
> > >>>
> > >>> Thanks,
> > >>> -- Jon.
> > >>>
> > >>> On Fri, Apr 3, 2020 at 5:56 PM Maciej S. Szmigiero
> > >>> <mail@maciej.szmigiero.name> wrote:
> > >>>>
> > >>>> Hi Jon,
> > >>>>
> > >>>> On 03.04.2020 16:23, Jon Doron wrote:
> > >>>>> Guest OS uses ACPI to discover vmbus presence.  Add a corresponding
> > >>>>> entry to DSDT in case vmbus has been enabled.
> > >>>>>
> > >>>>> Experimentally Windows guests were found to require this entry to
> > >>>>> include two IRQ resources, so this patch adds two semi-arbitrarily
> > >>>>> chosen ones (7 and 13).  This results, in particular, in parallel
> port
> > >>>>> conflicting with vmbus.
> > >>>>>
> > >>>>> TODO: discover and use spare IRQs to avoid conflicts.
> > >>>>>
> > >>>>> Signed-off-by: Evgeny Yakovlev <eyakovlev@virtuozzo.com>
> > >>>>> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> > >>>>> Signed-off-by: Jon Doron <arilou@gmail.com>
> > >>>>
> > >>>> Nice work, thanks!
> > >>>>
> > >>>> However, it seems to be based on the code version that was posted in
> > >>>> February 2018, and not the latest version in OpenVZ qemu repository
> > >>>> dated October 2019:
> > >>>>
> https://src.openvz.org/projects/UP/repos/qemu/commits?until=refs%2Fheads%2Fvmbus
> > >>>>
> > >>>> This newer version has slightly different API here and there.
> > >>>> Any particular reason for selecting that older version for porting?
> > >>>>
> > >>>> I have actually rebased this latest version on the top of the
> current
> > >>>> QEMU master, and it basically seems to work fine.
> > >>>> However, I haven't done extensive tests whether there isn't a
> memory leak
> > >>>> somewhere or so on.
> > >>>>
> > >>>> Maciej
> > >
> >
>

--000000000000e28e2605a29af1ea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Well I want it to be merged in :-)</div><br><div class=3D=
"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Apr 6, 2020, 10=
:32 Roman Kagan &lt;<a href=3D"mailto:rvkagan@yandex-team.ru">rvkagan@yande=
x-team.ru</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Fri, =
Apr 03, 2020 at 11:00:27PM +0200, Maciej S. Szmigiero wrote:<br>
&gt; It seems to me that Roman might not be getting our e-mails since his<b=
r>
&gt; new e-mail address seems to be &quot;<a href=3D"mailto:rvkagan@yandex-=
team.ru" target=3D"_blank" rel=3D"noreferrer">rvkagan@yandex-team.ru</a>&qu=
ot;.<br>
<br>
Indeed.=C2=A0 I&#39;m subscribed with my new address to qemu-devel ML but m=
ust<br>
have missed this series.<br>
<br>
&gt; @Roman, are you with us?<br>
<br>
Yes ;)<br>
<br>
So what are your plans regarding this patchset?<br>
<br>
Thanks,<br>
Roman.<br>
<br>
&gt; On 03.04.2020 19:18, Maciej S. Szmigiero wrote:<br>
&gt; &gt; Hi Jon,<br>
&gt; &gt; <br>
&gt; &gt; The patches are available here:<br>
&gt; &gt; <a href=3D"https://github.com/maciejsszmigiero/qemu.git" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">https://github.com/maciejsszmigiero=
/qemu.git</a> in &quot;vmbus-patches&quot; branch.<br>
&gt; &gt; <br>
&gt; &gt; Please note that these patches don&#39;t have Roman&#39;s &quot;S=
igned-off-by:&quot; tags,<br>
&gt; &gt; so I haven&#39;t applied mine, either.<br>
&gt; &gt; <br>
&gt; &gt; If you are able to establish a proper SoB chain then please also =
add:<br>
&gt; &gt; &quot;Signed-off-by: Maciej S. Szmigiero &lt;<a href=3D"mailto:ma=
ciej.szmigiero@oracle.com" target=3D"_blank" rel=3D"noreferrer">maciej.szmi=
giero@oracle.com</a>&gt;&quot;.<br>
&gt; &gt; <br>
&gt; &gt; Thanks for the effort,<br>
&gt; &gt; Maciej<br>
&gt; &gt; <br>
&gt; &gt; On 03.04.2020 17:30, Jon Doron wrote:<br>
&gt; &gt;&gt;=C2=A0 Thank you Maciej it seems like your version is really a=
head I&#39;ll do<br>
&gt; &gt;&gt; the required work and merge it so i can submit a v2 with the =
latest<br>
&gt; &gt;&gt; patchset from Roman<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On Fri, Apr 3, 2020 at 6:06 PM Jon Doron &lt;<a href=3D"mailt=
o:arilou@gmail.com" target=3D"_blank" rel=3D"noreferrer">arilou@gmail.com</=
a>&gt; wrote:<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Thank you Maciej, I based it on top of what Denis (<a hre=
f=3D"mailto:den@openvz.org" target=3D"_blank" rel=3D"noreferrer">den@openvz=
.org</a>) gave me<br>
&gt; &gt;&gt;&gt; which was this:<br>
&gt; &gt;&gt;&gt; <a href=3D"https://ftp.openvz.org/virtuozzo/releases/open=
vz-7.0.12-288/source/SRPMS/q/qemu-kvm-vz-2.12.0-33.vz7.14.4.src.rpm" rel=3D=
"noreferrer noreferrer" target=3D"_blank">https://ftp.openvz.org/virtuozzo/=
releases/openvz-7.0.12-288/source/SRPMS/q/qemu-kvm-vz-2.12.0-33.vz7.14.4.sr=
c.rpm</a><br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Do you think you have a more recent version I dont mind d=
iffing and<br>
&gt; &gt;&gt;&gt; resubmitting a new version of the patchset?<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Thanks,<br>
&gt; &gt;&gt;&gt; -- Jon.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; On Fri, Apr 3, 2020 at 5:56 PM Maciej S. Szmigiero<br>
&gt; &gt;&gt;&gt; &lt;<a href=3D"mailto:mail@maciej.szmigiero.name" target=
=3D"_blank" rel=3D"noreferrer">mail@maciej.szmigiero.name</a>&gt; wrote:<br=
>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Hi Jon,<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; On 03.04.2020 16:23, Jon Doron wrote:<br>
&gt; &gt;&gt;&gt;&gt;&gt; Guest OS uses ACPI to discover vmbus presence.=C2=
=A0 Add a corresponding<br>
&gt; &gt;&gt;&gt;&gt;&gt; entry to DSDT in case vmbus has been enabled.<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; Experimentally Windows guests were found to requi=
re this entry to<br>
&gt; &gt;&gt;&gt;&gt;&gt; include two IRQ resources, so this patch adds two=
 semi-arbitrarily<br>
&gt; &gt;&gt;&gt;&gt;&gt; chosen ones (7 and 13).=C2=A0 This results, in pa=
rticular, in parallel port<br>
&gt; &gt;&gt;&gt;&gt;&gt; conflicting with vmbus.<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; TODO: discover and use spare IRQs to avoid confli=
cts.<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; Signed-off-by: Evgeny Yakovlev &lt;<a href=3D"mai=
lto:eyakovlev@virtuozzo.com" target=3D"_blank" rel=3D"noreferrer">eyakovlev=
@virtuozzo.com</a>&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; Signed-off-by: Roman Kagan &lt;<a href=3D"mailto:=
rkagan@virtuozzo.com" target=3D"_blank" rel=3D"noreferrer">rkagan@virtuozzo=
.com</a>&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; Signed-off-by: Jon Doron &lt;<a href=3D"mailto:ar=
ilou@gmail.com" target=3D"_blank" rel=3D"noreferrer">arilou@gmail.com</a>&g=
t;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Nice work, thanks!<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; However, it seems to be based on the code version tha=
t was posted in<br>
&gt; &gt;&gt;&gt;&gt; February 2018, and not the latest version in OpenVZ q=
emu repository<br>
&gt; &gt;&gt;&gt;&gt; dated October 2019:<br>
&gt; &gt;&gt;&gt;&gt; <a href=3D"https://src.openvz.org/projects/UP/repos/q=
emu/commits?until=3Drefs%2Fheads%2Fvmbus" rel=3D"noreferrer noreferrer" tar=
get=3D"_blank">https://src.openvz.org/projects/UP/repos/qemu/commits?until=
=3Drefs%2Fheads%2Fvmbus</a><br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; This newer version has slightly different API here an=
d there.<br>
&gt; &gt;&gt;&gt;&gt; Any particular reason for selecting that older versio=
n for porting?<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; I have actually rebased this latest version on the to=
p of the current<br>
&gt; &gt;&gt;&gt;&gt; QEMU master, and it basically seems to work fine.<br>
&gt; &gt;&gt;&gt;&gt; However, I haven&#39;t done extensive tests whether t=
here isn&#39;t a memory leak<br>
&gt; &gt;&gt;&gt;&gt; somewhere or so on.<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Maciej<br>
&gt; &gt; <br>
&gt; <br>
</blockquote></div>

--000000000000e28e2605a29af1ea--

