Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1821BC35240
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 10:46:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEC00206D3
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 10:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LCvHaGl2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEC00206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyClO-0001yT-22
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 05:46:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49483)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iyCkP-00015u-C7
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 05:45:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iyCkN-0001ai-3S
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 05:45:00 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56524
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iyCkM-0001Yz-Pg
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 05:44:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580640297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SCrJjU9dkpXGA1LApb81y8BffGLMdr5QIwgMMYIwANM=;
 b=LCvHaGl2uoWA+NbXECjFjnTcb4y7HEt9JTB44eN7veFTJI7LO4W2l9lbNwNcnb+si49JZ1
 4ECwvpjvt51/WizgywwrjNPmM70z2Lwyu3/IE2Q9nCya5GuUYYsBsO5kbF+EVa3Ctgu2eh
 o6JwO7j6yhBXtjoNjzxNuImZ56trKvE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-NeWymr8EMmebk3M2xb75GQ-1; Sun, 02 Feb 2020 05:44:51 -0500
Received: by mail-ed1-f71.google.com with SMTP id l19so8079405edq.19
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2020 02:44:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eAaMCia7UKaZueSyd2fgPxedYdcxeGcElOz0CCIQfYg=;
 b=bkLckx7tYAvmqiEIQLpT1PUN54UgPKJRaNgOEsDwItOXUiQMtBNGRJFxE2HZZRVMu0
 HR8urevYPgvuG+GgTznUq9PtN9DPU55TkAw4U5+bKUIzRXq6xdribbaXLqQPPqZoX0J7
 8ge17nWOUYVXyAUrSiv1IBx9lNXHzZ+i2XpMmkQDtch2lSQ1/84AfUIhDM3cywhIbGbQ
 g343njvm96vOmxsr65lWij8DrD+SOKhAILWWkS/amweGLcP/3YUOAK6VXESEX9VS9sJR
 6320qipHpLgQXrf+XkQ8vuAMtb/zEBRPvm6gYSNrJ39TKOFJVCFuU7/D7gqkuD51zNf2
 hxJQ==
X-Gm-Message-State: APjAAAWuBB7bBLpiVLjv6v6NsyehyLro0o0x6j3rSZIPzmzXfK+IOQ5B
 6UBZOHsMAfp8P+krDaDOr7CnB+NHc1CDGzi++BoRioojFK8gL1P7qjst9nY3DCsRUgN/4k9f5wO
 +Wz9dzMzOeL/4rRUuHBJQpTyKBMYA0nA=
X-Received: by 2002:a17:906:70f:: with SMTP id
 y15mr16632012ejb.44.1580640290341; 
 Sun, 02 Feb 2020 02:44:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqzcdQ7NBsUhklA0A+cPZrTVx4C68AbZkQaeELh0yYHmH+ZJDw4hcdBw7LFZ/2tmTfvE+KX9In8wwHzRwjot96g=
X-Received: by 2002:a17:906:70f:: with SMTP id
 y15mr16631991ejb.44.1580640290070; 
 Sun, 02 Feb 2020 02:44:50 -0800 (PST)
MIME-Version: 1.0
References: <871rrp474i.fsf@dusky.pond.sub.org>
 <20200124102743.GB824327@redhat.com>
 <20200124143841.GG4732@dhcp-200-226.str.redhat.com>
 <87sgk3x2im.fsf@dusky.pond.sub.org>
 <20200127115606.GA5669@linux.fritz.box>
 <1c65b678-7bb4-a4cc-5fa6-03d6d27cf381@redhat.com>
 <20200128102855.GA6431@linux.fritz.box> <87mua7bvwf.fsf@dusky.pond.sub.org>
 <20200128125409.GF6431@linux.fritz.box>
 <4cf1864c-3527-b015-0691-1788a37f4f7e@redhat.com>
 <20200202092152.GA3456@localhost.localdomain>
In-Reply-To: <20200202092152.GA3456@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 2 Feb 2020 11:44:37 +0100
Message-ID: <CABgObfaLetjGmv=21gCQWruvXNkrMBUVCjQaKrTjppZrL=MW-A@mail.gmail.com>
Subject: Re: Making QEMU easier for management tools and applications
To: Kevin Wolf <kwolf@redhat.com>
X-MC-Unique: NeWymr8EMmebk3M2xb75GQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000001fd1b059d957f11"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000001fd1b059d957f11
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il dom 2 feb 2020, 10:22 Kevin Wolf <kwolf@redhat.com> ha scritto:

> Am 31.01.2020 um 13:27 hat Eric Blake geschrieben:
> > On 1/28/20 6:54 AM, Kevin Wolf wrote:
> >
> > > >
> > > > The arguments as dotted keys:
> > > >
> > > >      id=3Dbar,backend.type=3Dfile,backend.data.out=3D/tmp/bar.log
> > > >
> > > > Observe there's quite some of nesting.  While that's somewhat
> cumbersome
> > > > in JSON, it's a lot worse with dotted keys, because there nesting
> means
> > > > repeated key prefixes.  I could give much worse examples, actually.
> > >
> > > This is true, but even without the repeated keys (e.g. in a syntax th=
at
> > > would use brackets), it would still be unnecessarily verbose and
> > > probably hard to remember:
> > >
> > >      id=3Dbar,backend=3D{type=3Dfile,data=3D{out=3D/tmp/bar.log}}
>
> [...] I actually think that a syntax like this might make sense for
> something like qmp-shell. It might even be more convenient on the
> command line than dotted keys if you get a lot of repetition (despite
> the required quoting), but it's strictly speaking incompatible because
> you could use {} in strings today.
>

If you are willing to feed schema info to the parser, in principle you
could keep backwards compatibility. There would be limitations such as
putting the discriminator before the fields, so I am not sure it's a good
idea.

Better QOM introspection would be a requirement, too.

Paolo


> Kevin
>
>

--00000000000001fd1b059d957f11
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il dom 2 feb 2020, 10:22 Kevin Wolf &lt;<a href=3D"mai=
lto:kwolf@redhat.com">kwolf@redhat.com</a>&gt; ha scritto:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">Am 31.01.2020 um 13:27 hat Eric Blake geschrieben:<=
br>
&gt; On 1/28/20 6:54 AM, Kevin Wolf wrote:<br>
&gt; <br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; The arguments as dotted keys:<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 id=3Dbar,backend.type=3Dfile,backend.dat=
a.out=3D/tmp/bar.log<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Observe there&#39;s quite some of nesting.=C2=A0 While that&=
#39;s somewhat cumbersome<br>
&gt; &gt; &gt; in JSON, it&#39;s a lot worse with dotted keys, because ther=
e nesting means<br>
&gt; &gt; &gt; repeated key prefixes.=C2=A0 I could give much worse example=
s, actually.<br>
&gt; &gt; <br>
&gt; &gt; This is true, but even without the repeated keys (e.g. in a synta=
x that<br>
&gt; &gt; would use brackets), it would still be unnecessarily verbose and<=
br>
&gt; &gt; probably hard to remember:<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 id=3Dbar,backend=3D{type=3Dfile,data=3D{out=
=3D/tmp/bar.log}}<br>
<br>[...] I actually think that a syntax like this might make sense for<br>
something like qmp-shell. It might even be more convenient on the<br>
command line than dotted keys if you get a lot of repetition (despite<br>
the required quoting), but it&#39;s strictly speaking incompatible because<=
br>
you could use {} in strings today.<br></blockquote></div></div><div dir=3D"=
auto"><br></div><div dir=3D"auto">If you are willing to feed schema info to=
 the parser, in principle you could keep backwards compatibility. There wou=
ld be limitations such as putting the discriminator before the fields, so I=
 am not sure it&#39;s a good idea.</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Better QOM introspection would be a requirement, too.</div><div =
dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">
<br>
Kevin<br>
<br>
</blockquote></div></div></div>

--00000000000001fd1b059d957f11--


