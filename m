Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58190C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 16:32:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C77302086A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 16:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsdknTrR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C77302086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKlDU-00087U-K3
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 12:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kKl6Z-0001K0-Eh
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 12:25:23 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:42441)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kKl6X-0000eF-7C
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 12:25:23 -0400
Received: by mail-ed1-x542.google.com with SMTP id j2so16737467eds.9
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 09:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6ijkL59+d2hwdznivspszrWfKszLPywNJbOycnAFx44=;
 b=gsdknTrRXOo4CdLLaZkDUi2Jv8uG/hvK1SZmvwFZ1gk83PTvwTQP4BWI4Cs6NlJ8Fi
 s76oWbLNnrQoeuLGduSK8osY81Qv5f9ejOvq4mu2Qtt/C0lTee6KbfkQfpaAFeOERTyn
 X17KRiTTOzr4x4P5wBvSVrkCy2PtFQbN4jlcUm/Hev3t7x2ToYDLmH7wbSE2qbWMNZFx
 Let7z4zs3/eHSwpC0rCHwTjAJwRhM79xjcto78WQ98+Ot0tGfBpSASX5JEGEeGJHwrUC
 UWxw7AVgU6ecA5UayrNZPCWM1A84RxDeLnYbHfAXhb7+H0QUtz65CSs8iwWinMOKvIo1
 oUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6ijkL59+d2hwdznivspszrWfKszLPywNJbOycnAFx44=;
 b=s7clZhPcnS3QWVy8lMDVecLOo421QYtrVMOAzFtazv2bGMmmt8U7FWtRoFcO1CA1BY
 E+B4ROXnAhXnmJ3FsEEP1LbH9KrtfjnCI/GEPcyq8XjS0MVnPXynv/KafuYVRxMGq29P
 FJfS5QJTiO3wYeR4urcUl9pcNJkq7Q9PwCaXAAyiMYwPkY3SwD/O2MLb5FPXWN1ggSpP
 wn0vofU9bwyX+QBFHOBp3XjlyYc79eDlFY/iWGXwMJEivmx9W/czafZR539yyWOSLD7g
 sYlAwCnSUAZ7ptHSuSbea0djJtJw5gI9Yz/LiHToiQ7FNG/UEX7+A4ArxM5Qko3JVnZW
 HUvA==
X-Gm-Message-State: AOAM533K+6F2PAowkRLhqhROwMkhz2zW/AJJQiCKSHRtsxcwdbN9AIrG
 08sQXpsyXPkB8klSOVOAhnhhnRCVLyKKcwp2D+w=
X-Google-Smtp-Source: ABdhPJyqRy2L/ZcupdWlj04QuG6PcULuhy/qt6PKrfXNiVyrWizx4DbKJih0rxxQN1AMZ/61TqP7uQEfuqIor0jaG5A=
X-Received: by 2002:a50:bb65:: with SMTP id y92mr4742994ede.53.1600791919100; 
 Tue, 22 Sep 2020 09:25:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200910174850.716104-1-marcandre.lureau@redhat.com>
 <87mu1j8p7p.fsf@dusky.pond.sub.org>
 <CAMxuvay_mQjukGvinb6ur+8z-YyKxu=BdquuF=+yf+UrNmmd2A@mail.gmail.com>
 <87y2l1kel8.fsf@dusky.pond.sub.org>
In-Reply-To: <87y2l1kel8.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 22 Sep 2020 20:25:06 +0400
Message-ID: <CAJ+F1CLjZ5EA+R+Bo9WGTwJ1ju3tCXWbquP5gkQwRA4fL6V9Kw@mail.gmail.com>
Subject: Re: [PATCH] PoC: Rust binding for QAPI (qemu-ga only, for now)
To: Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b2865a05afe9695b"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "P. Berrange, Daniel" <berrange@redhat.com>,
 Sergio Lopez Pascual <slp@redhat.com>, "Hajnoczi, Stefan" <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, "Bonzini, Paolo" <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b2865a05afe9695b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Sep 22, 2020 at 7:39 PM Markus Armbruster <armbru@redhat.com> wrote=
:

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Hi
> >
> > On Mon, Sep 21, 2020 at 1:16 PM Markus Armbruster <armbru@redhat.com>
> wrote:
> >>
> >> marcandre.lureau@redhat.com writes:
> [...]
> >> > Finally, given that the QAPI types are easy to serialize, it was
> simple
> >> > to use "serde" on them, and provide a D-Bus interface for QMP with
> zbus.
> >> > (a similar approach could probably be taken for other protocols, tha=
t
> >> > could be dynamically loaded... anyone like protobuf better?)
> >>
> >> QMP is an *external* interface.
> >>
> >> It supports compatible evolution: we can make certain kinds of changes
> >> without affecting clients.  These include:
> >>
> >> * Adding optional arguments
> >>
> >> * Adding results
> >>
> >> * Adding values to an enumeration type, branches to a union or
> >>   alternate
> >>
> >> * Reordering members of enumerations, structs, unions
> >>
> >> * Turning an argument type into an alternate with the old type as bran=
ch
> >>
> >> We've made use of this extensively.  See also
> >> docs/devel/qapi-code-gen.txt section "Compatibility considerations."
> >>
> >> How do such changes affect clients of the proposed D-Bus interface?
> >>
> >
> > It's not just about the D-Bus interface though.
> >
> > QMP being JSON, being lazily typed: everytime we make such changes, we
> > inflict some pain to all the QMP bindings that want to have a
> > statically checked & native version of the interface. Iow, we should
> > think twice before doing any of this.
>
> Having to think twice before doing something we need to do all the time
> would slow us down.  I don't think this is going to fly.
>
> QMP is designed to avoid tight coupling of server (i.e. QEMU) and
> client.  In particular, we don't want "you have to upgrade both in
> lockstep".
>
> A well-behaved client works fine even when it's written for a somewhat
> older or newer QMP than the server provides.  "Somewhat" because we
> deprecate and eventually remove stuff.  Graceful degradation when the
> gap gets too large.
>
> There's a gap between the "lose" wire format, and a "tight" statically
> typed internal interface.  The gap exists in QEMU, and we bridge it.
> Clients can do the same.  Libvirt does: it provides a statically typed
> version of the interface without undue coupling.
>
> Replacing the "lose" wire format by something "tighter" like D-Bus
> shrinks the gap.  Good.  It also tightens the coupling.  Bad.
>
> [...]
>
>
>

At least, this little D-Bus experiment puts some light on one of the
current QMP weakness: it's hard to bind QMP.

There are good reasons to prefer strongly typed languages. Whenever QMP is
statically bound there, and such changes are made, it is pushing the
versionning issues to others. It's probably one of the reasons why people
are stuck binding QMP manually: doing it automatically would not be
practical, as it would regularly break the interface & build. You have to
version the schema & interface yourself.

So we end up with multiple bindings, manually bound with mistakes etc.

What does this freedom really gives us in exchange? We don't want to commit
to a stable API? It's not rocket science, everybody else does it with
interface version numbers. What makes QEMU/QMP so different?

As for this D-Bus binding, if we don't commit to some better QMP stability
guarantees, we could simply bump the version of the D-Bus interfaces for
each Qemu release (without compatibility with older versions). It's not a
great idea, but it's the best to do then.


--=20
Marc-Andr=C3=A9 Lureau

--000000000000b2865a05afe9695b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 22, 2020 at 7:39 PM Mar=
kus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Ma=
rc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com" tar=
get=3D"_blank">marcandre.lureau@redhat.com</a>&gt; writes:<br>
<br>
&gt; Hi<br>
&gt;<br>
&gt; On Mon, Sep 21, 2020 at 1:16 PM Markus Armbruster &lt;<a href=3D"mailt=
o:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; <a href=3D"mailto:marcandre.lureau@redhat.com" target=3D"_blank">m=
arcandre.lureau@redhat.com</a> writes:<br>
[...]<br>
&gt;&gt; &gt; Finally, given that the QAPI types are easy to serialize, it =
was simple<br>
&gt;&gt; &gt; to use &quot;serde&quot; on them, and provide a D-Bus interfa=
ce for QMP with zbus.<br>
&gt;&gt; &gt; (a similar approach could probably be taken for other protoco=
ls, that<br>
&gt;&gt; &gt; could be dynamically loaded... anyone like protobuf better?)<=
br>
&gt;&gt;<br>
&gt;&gt; QMP is an *external* interface.<br>
&gt;&gt;<br>
&gt;&gt; It supports compatible evolution: we can make certain kinds of cha=
nges<br>
&gt;&gt; without affecting clients.=C2=A0 These include:<br>
&gt;&gt;<br>
&gt;&gt; * Adding optional arguments<br>
&gt;&gt;<br>
&gt;&gt; * Adding results<br>
&gt;&gt;<br>
&gt;&gt; * Adding values to an enumeration type, branches to a union or<br>
&gt;&gt;=C2=A0 =C2=A0alternate<br>
&gt;&gt;<br>
&gt;&gt; * Reordering members of enumerations, structs, unions<br>
&gt;&gt;<br>
&gt;&gt; * Turning an argument type into an alternate with the old type as =
branch<br>
&gt;&gt;<br>
&gt;&gt; We&#39;ve made use of this extensively.=C2=A0 See also<br>
&gt;&gt; docs/devel/qapi-code-gen.txt section &quot;Compatibility considera=
tions.&quot;<br>
&gt;&gt;<br>
&gt;&gt; How do such changes affect clients of the proposed D-Bus interface=
?<br>
&gt;&gt;<br>
&gt;<br>
&gt; It&#39;s not just about the D-Bus interface though.<br>
&gt;<br>
&gt; QMP being JSON, being lazily typed: everytime we make such changes, we=
<br>
&gt; inflict some pain to all the QMP bindings that want to have a<br>
&gt; statically checked &amp; native version of the interface. Iow, we shou=
ld<br>
&gt; think twice before doing any of this.<br>
<br>
Having to think twice before doing something we need to do all the time<br>
would slow us down.=C2=A0 I don&#39;t think this is going to fly.<br>
<br>
QMP is designed to avoid tight coupling of server (i.e. QEMU) and<br>
client.=C2=A0 In particular, we don&#39;t want &quot;you have to upgrade bo=
th in<br>
lockstep&quot;.<br>
<br>
A well-behaved client works fine even when it&#39;s written for a somewhat<=
br>
older or newer QMP than the server provides.=C2=A0 &quot;Somewhat&quot; bec=
ause we<br>
deprecate and eventually remove stuff.=C2=A0 Graceful degradation when the<=
br>
gap gets too large.<br>
<br>
There&#39;s a gap between the &quot;lose&quot; wire format, and a &quot;tig=
ht&quot; statically<br>
typed internal interface.=C2=A0 The gap exists in QEMU, and we bridge it.<b=
r>
Clients can do the same.=C2=A0 Libvirt does: it provides a statically typed=
<br>
version of the interface without undue coupling.<br>
<br>
Replacing the &quot;lose&quot; wire format by something &quot;tighter&quot;=
 like D-Bus<br>
shrinks the gap.=C2=A0 Good.=C2=A0 It also tightens the coupling.=C2=A0 Bad=
.<br>
<br>
[...]<br>
<br>
<br>
</blockquote></div><div><br></div><div><br></div><div>At least, this little=
 D-Bus experiment puts some light on one of the current QMP weakness: it&#3=
9;s hard to bind QMP.<br><br>There are good reasons to prefer strongly type=
d languages. Whenever QMP is statically bound there, and such changes are m=
ade, it is pushing the versionning issues to others. It&#39;s probably one =
of the reasons why people are stuck binding QMP manually: doing it automati=
cally would not be practical, as it would regularly break the interface &am=
p; build. You have to version the schema &amp; interface yourself. <br><br>=
So we end up with multiple bindings, manually bound with mistakes etc.<br><=
br>What does this freedom really gives us in exchange? We don&#39;t want to=
 commit to a stable API? It&#39;s not rocket science, everybody else does i=
t with interface version numbers. What makes QEMU/QMP so different?<br><br>=
As for this D-Bus binding, if we don&#39;t commit to some better QMP stabil=
ity guarantees, we could simply bump the version of the D-Bus interfaces fo=
r each Qemu release (without compatibility with older versions). It&#39;s n=
ot a great idea, but it&#39;s the best to do then.</div><div><br></div><br>=
-- <br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=A9 Lureau<br=
></div></div>

--000000000000b2865a05afe9695b--

