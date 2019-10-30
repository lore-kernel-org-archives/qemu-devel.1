Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04D1CA9EC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 22:41:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93EBD2087E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 22:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93EBD2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPwev-00035o-Na
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 18:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39423)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hhan@redhat.com>) id 1iPwH8-0001SF-SQ
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 18:17:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hhan@redhat.com>) id 1iPwH4-0004Nz-Pc
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 18:17:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62061)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <hhan@redhat.com>) id 1iPwH4-0004E8-Gy
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 18:17:06 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7F57C83F3B
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2019 22:17:03 +0000 (UTC)
Received: by mail-oi1-f200.google.com with SMTP id x187so2063091oia.8
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2019 15:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ilXwfCATfeSrBWvuo/UqyqnVYVsPEqrHM7vXRlgWW6o=;
 b=iroJzw+n1xre9lKvEeYYKTGokdwnBMODX8KaniSDu5qBmDK60VKzPxVI6vvmHO4Ap0
 MJU9C/uKUzJ6TQprybvlLrNxEJr8ulAfuEWo+YmX+C5PmBO/hAf/lOuZ9KsRLoGApBuZ
 KzwkKJoEMaMN3Rqhs3mtMI6Eywzm8r4EoqPJdWes0pUjRrV9rTfPsuMtF+tPvNVk11nx
 90cx/ptZg1TKLF5KOG+cQwiaTG6D4Mm0zYfK3rWW8ntBvjyVVbicXVUDiD8UzxZjw45c
 N2cclwH8qlfyd/uZMCIkla7K0aSSixQ7pDenJcOpRatVFAWNPjSjEr1PqzTvTNdNU6M5
 iUGQ==
X-Gm-Message-State: APjAAAXJR3EbI0EctbkkeqlE2ve0tYWXTyIVeWl3fY4/oo+xk19pZ3GJ
 zfHKfoySqTLe9eZsFioFZVlTSllu/YmoWAeWWcZkarx2Vav3PP9Cjc9j9MeOXIrFQH397dSlmFE
 V5eoy3y9NPJclejfnrIpp9InV4tJIkXw=
X-Received: by 2002:a05:6830:9a:: with SMTP id
 a26mr1831023oto.14.1572473822745; 
 Wed, 30 Oct 2019 15:17:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxUmnju9KkEpEVJd0yTC43kU6ZFgw5wFw4FUoPBJajgFRAYEQdSQtQMvo/bqcuoU/6rpFkVk8VC016FNq37ycM=
X-Received: by 2002:a05:6830:9a:: with SMTP id
 a26mr1830996oto.14.1572473822429; 
 Wed, 30 Oct 2019 15:17:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191025165706.177653-1-dgilbert@redhat.com>
 <87a79o4jjb.fsf@dusky.pond.sub.org>
 <20191028134700.GB2961@work-vm> <87lft3sqhf.fsf@dusky.pond.sub.org>
 <20191029125641.GC16329@work-vm>
In-Reply-To: <20191029125641.GC16329@work-vm>
From: Han Han <hhan@redhat.com>
Date: Wed, 30 Oct 2019 23:17:16 +0100
Message-ID: <CAHjf+S_KfDQeC_k997_PKSgP6v8LQgNh1HYt9JPRM-Ds+POADg@mail.gmail.com>
Subject: Re: [PATCH] fw_cfg: Allow reboot-timeout=-1 again
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009ad6f2059628178d"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Karen Noel <knoel@redhat.com>, Jaroslav Suchanek <jsuchane@redhat.com>,
 philmd@redhat.com, liq3ea@gmail.com, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, kraxel@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009ad6f2059628178d
Content-Type: text/plain; charset="UTF-8"

However, another important question is: how can we avoid such undocumented
incompatibility appears again?
I can show another case caused by such incompatibile change:
https://bugzilla.redhat.com/show_bug.cgi?id=1745868#c0

For the qemu devices, attributes, values, qmp cmds, qmp cmds arguments used
by libvirt, could we get a way to inform libvirt
that an incompatibile qemu change is coming, please update libvirt code
ASAP to adjust to that change?
Or another way that is more gently:  popping up the warning of depreciation
instead of  dropping it, and then drop it in the version
after next version.


On Tue, Oct 29, 2019 at 1:59 PM Dr. David Alan Gilbert <dgilbert@redhat.com>
wrote:

> * Markus Armbruster (armbru@redhat.com) wrote:
> > "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
> >
> > > * Markus Armbruster (armbru@redhat.com) wrote:
> > >> "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> writes:
> > >>
> > >> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > >> >
> > >> > Commit ee5d0f89de3e53cdb0dc added range checking on reboot-timeout
> > >> > to only allow the range 0..65535; however both qemu and libvirt
> document
> > >> > the special value -1  to mean don't reboot.
> > >> > Allow it again.
> > >> >
> > >> > Fixes: ee5d0f89de3e53cdb0dc ("fw_cfg: Fix -boot reboot-timeout
> error checking")
> > >> > RH bz: https://bugzilla.redhat.com/show_bug.cgi?id=1765443
> > >> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > >> > ---
> > >> >  hw/nvram/fw_cfg.c | 5 +++--
> > >> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >> >
> > >> > diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> > >> > index 7dc3ac378e..1a9ec44232 100644
> > >> > --- a/hw/nvram/fw_cfg.c
> > >> > +++ b/hw/nvram/fw_cfg.c
> > >> > @@ -247,10 +247,11 @@ static void fw_cfg_reboot(FWCfgState *s)
> > >> >
> > >> >      if (reboot_timeout) {
> > >> >          rt_val = qemu_opt_get_number(opts, "reboot-timeout", -1);
> > >> > +
> > >> >          /* validate the input */
> > >> > -        if (rt_val < 0 || rt_val > 0xffff) {
> > >> > +        if (rt_val < -1 || rt_val > 0xffff) {
> > >> >              error_report("reboot timeout is invalid,"
> > >> > -                         "it should be a value between 0 and
> 65535");
> > >> > +                         "it should be a value between -1 and
> 65535");
> > >> >              exit(1);
> > >> >          }
> > >> >      }
> > >>
> > >> Semantic conflict with "PATCH] qemu-options.hx: Update for
> > >> reboot-timeout parameter", Message-Id:
> > >> <20191015151451.727323-1-hhan@redhat.com>.
> > >
> > > Thanks for spotting that.
> > > I think Han and also submitted patches to review it from libvirt
> > > and it wasn't obvious what to do.  (Cc'd Han in).
> > >
> > >> I'm too tired right now to risk an opinion on which one we want.
> > >
> > > As is everyone else !  The problem here is that its documented
> > > as a valid thing to do, and libvirt does it, and you might have
> > > a current XML file that did it.  Now I think you could change libvirt
> > > to omit the reboot-timeout parameter if it was called with -1.
> > >
> > > So given its a documented thing in both qemu and libvirt xml
> > > if we want to remove it then it sohuld be deprecated properly - but
> it's
> > > already broken.
> >
> > Since commit ee5d0f89d, v4.0.0.
> >
> > If that commit had not made it into a release, we'd certainly treat the
> > loss of "-1 means don't reboot" as regression.
> >
> > But it has.  We can treat it as a regression anyway.  We can also
> > declare "ship has sailed".
> >
> > I'm leaning towads the former.
> >
> > If we restore "-1 means don't reboot", then I don't see a need to
> > deprecate it.  Just keep it.
> >
> > What do you think?
>
> That's also my view; especially since the problem seems to be an easy
> fix.
>
> Dave
>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>


-- 
Best regards,
-----------------------------------
Han Han
Quality Engineer
Redhat.

Email: hhan@redhat.com
Phone: +861065339333

--0000000000009ad6f2059628178d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>However, another important question is: how can we av=
oid such undocumented incompatibility appears again?</div><div>I can show a=
nother case caused by such incompatibile change: <a href=3D"https://bugzill=
a.redhat.com/show_bug.cgi?id=3D1745868#c0">https://bugzilla.redhat.com/show=
_bug.cgi?id=3D1745868#c0</a></div><div><br></div><div>For the qemu devices,=
 attributes, values, qmp cmds, qmp cmds arguments used by libvirt, could we=
 get a way to inform libvirt</div><div>that an incompatibile qemu change is=
 coming, please update libvirt code ASAP to adjust to that change?</div><di=
v>Or another way that is more gently:=C2=A0 popping up the warning of depre=
ciation instead of=C2=A0 dropping it, and then drop it in the version</div>=
<div>after next version.<br></div><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 29, 2019 at 1:59 PM Dr. D=
avid Alan Gilbert &lt;<a href=3D"mailto:dgilbert@redhat.com">dgilbert@redha=
t.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">* Markus Armbruster (<a href=3D"mailto:armbru@redhat.com" target=3D"_b=
lank">armbru@redhat.com</a>) wrote:<br>
&gt; &quot;Dr. David Alan Gilbert&quot; &lt;<a href=3D"mailto:dgilbert@redh=
at.com" target=3D"_blank">dgilbert@redhat.com</a>&gt; writes:<br>
&gt; <br>
&gt; &gt; * Markus Armbruster (<a href=3D"mailto:armbru@redhat.com" target=
=3D"_blank">armbru@redhat.com</a>) wrote:<br>
&gt; &gt;&gt; &quot;Dr. David Alan Gilbert (git)&quot; &lt;<a href=3D"mailt=
o:dgilbert@redhat.com" target=3D"_blank">dgilbert@redhat.com</a>&gt; writes=
:<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &gt; From: &quot;Dr. David Alan Gilbert&quot; &lt;<a href=3D"=
mailto:dgilbert@redhat.com" target=3D"_blank">dgilbert@redhat.com</a>&gt;<b=
r>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; Commit ee5d0f89de3e53cdb0dc added range checking on rebo=
ot-timeout<br>
&gt; &gt;&gt; &gt; to only allow the range 0..65535; however both qemu and =
libvirt document<br>
&gt; &gt;&gt; &gt; the special value -1=C2=A0 to mean don&#39;t reboot.<br>
&gt; &gt;&gt; &gt; Allow it again.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; Fixes: ee5d0f89de3e53cdb0dc (&quot;fw_cfg: Fix -boot reb=
oot-timeout error checking&quot;)<br>
&gt; &gt;&gt; &gt; RH bz: <a href=3D"https://bugzilla.redhat.com/show_bug.c=
gi?id=3D1765443" rel=3D"noreferrer" target=3D"_blank">https://bugzilla.redh=
at.com/show_bug.cgi?id=3D1765443</a><br>
&gt; &gt;&gt; &gt; Signed-off-by: Dr. David Alan Gilbert &lt;<a href=3D"mai=
lto:dgilbert@redhat.com" target=3D"_blank">dgilbert@redhat.com</a>&gt;<br>
&gt; &gt;&gt; &gt; ---<br>
&gt; &gt;&gt; &gt;=C2=A0 hw/nvram/fw_cfg.c | 5 +++--<br>
&gt; &gt;&gt; &gt;=C2=A0 1 file changed, 3 insertions(+), 2 deletions(-)<br=
>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c<br>
&gt; &gt;&gt; &gt; index 7dc3ac378e..1a9ec44232 100644<br>
&gt; &gt;&gt; &gt; --- a/hw/nvram/fw_cfg.c<br>
&gt; &gt;&gt; &gt; +++ b/hw/nvram/fw_cfg.c<br>
&gt; &gt;&gt; &gt; @@ -247,10 +247,11 @@ static void fw_cfg_reboot(FWCfgSta=
te *s)<br>
&gt; &gt;&gt; &gt;=C2=A0 <br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (reboot_timeout) {<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rt_val =3D qemu_opt_ge=
t_number(opts, &quot;reboot-timeout&quot;, -1);<br>
&gt; &gt;&gt; &gt; +<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* validate the input =
*/<br>
&gt; &gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rt_val &lt; 0 || rt_val=
 &gt; 0xffff) {<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rt_val &lt; -1 || rt_va=
l &gt; 0xffff) {<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_re=
port(&quot;reboot timeout is invalid,&quot;<br>
&gt; &gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;it should be a value between 0 and=
 65535&quot;);<br>
&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;it should be a value between -1 an=
d 65535&quot;);<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);=
<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; Semantic conflict with &quot;PATCH] qemu-options.hx: Update f=
or<br>
&gt; &gt;&gt; reboot-timeout parameter&quot;, Message-Id:<br>
&gt; &gt;&gt; &lt;<a href=3D"mailto:20191015151451.727323-1-hhan@redhat.com=
" target=3D"_blank">20191015151451.727323-1-hhan@redhat.com</a>&gt;.<br>
&gt; &gt;<br>
&gt; &gt; Thanks for spotting that.<br>
&gt; &gt; I think Han and also submitted patches to review it from libvirt<=
br>
&gt; &gt; and it wasn&#39;t obvious what to do.=C2=A0 (Cc&#39;d Han in).<br=
>
&gt; &gt;<br>
&gt; &gt;&gt; I&#39;m too tired right now to risk an opinion on which one w=
e want.<br>
&gt; &gt;<br>
&gt; &gt; As is everyone else !=C2=A0 The problem here is that its document=
ed<br>
&gt; &gt; as a valid thing to do, and libvirt does it, and you might have <=
br>
&gt; &gt; a current XML file that did it.=C2=A0 Now I think you could chang=
e libvirt<br>
&gt; &gt; to omit the reboot-timeout parameter if it was called with -1.<br=
>
&gt; &gt;<br>
&gt; &gt; So given its a documented thing in both qemu and libvirt xml<br>
&gt; &gt; if we want to remove it then it sohuld be deprecated properly - b=
ut it&#39;s<br>
&gt; &gt; already broken.<br>
&gt; <br>
&gt; Since commit ee5d0f89d, v4.0.0.<br>
&gt; <br>
&gt; If that commit had not made it into a release, we&#39;d certainly trea=
t the<br>
&gt; loss of &quot;-1 means don&#39;t reboot&quot; as regression.<br>
&gt; <br>
&gt; But it has.=C2=A0 We can treat it as a regression anyway.=C2=A0 We can=
 also<br>
&gt; declare &quot;ship has sailed&quot;.<br>
&gt; <br>
&gt; I&#39;m leaning towads the former.<br>
&gt; <br>
&gt; If we restore &quot;-1 means don&#39;t reboot&quot;, then I don&#39;t =
see a need to<br>
&gt; deprecate it.=C2=A0 Just keep it.<br>
&gt; <br>
&gt; What do you think?<br>
<br>
That&#39;s also my view; especially since the problem seems to be an easy<b=
r>
fix.<br>
<br>
Dave<br>
<br>
--<br>
Dr. David Alan Gilbert / <a href=3D"mailto:dgilbert@redhat.com" target=3D"_=
blank">dgilbert@redhat.com</a> / Manchester, UK<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr=
">Best regards,</div><div dir=3D"ltr">-----------------------------------<b=
r></div><div dir=3D"ltr">Han Han<br>Quality Engineer<br>Redhat.<br><br>Emai=
l: <a href=3D"mailto:hhan@redhat.com" target=3D"_blank">hhan@redhat.com</a>=
<br>Phone: +861065339333<br></div></div></div></div></div></div>

--0000000000009ad6f2059628178d--

