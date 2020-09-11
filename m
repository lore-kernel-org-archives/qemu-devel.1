Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98E0C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 11:04:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E300221D92
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 11:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OACcdCNE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E300221D92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGgqx-0002pY-OP
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 07:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kGgqE-0002PA-5m
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 07:03:42 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629]:34279)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kGgqB-0005ld-QU
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 07:03:41 -0400
Received: by mail-ej1-x629.google.com with SMTP id gr14so13274313ejb.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 04:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sQEMvPK5qpauEIGdA0iadnvQNNPhqlsJWjU3f8TcgEg=;
 b=OACcdCNEbhQuTvVWGDvgJPcw8Xxlk/oCK6mhd7yd9Blceis2Uwm2B43efsOrkMQyH6
 qsVxb3/146inT412KUgLDlOksLFzmPJ+Gt0JpiPmVREHOOQrbKmF773CzdYlcARJjfhl
 osjy4cEXdix6l+KmTRmhCujwKzdYgGBXaMvKNbf/8XbZoW93fYp+Qb1ODFZWd7WmtT0F
 gORVhCCFJWokL9pxpNsneAbr57P3JV6kh43ZtI5rkWY+rs4l+UPI8qUzwwpvEcXDQFjX
 XgNv6V6ypdIbfi48e/wfZHupOOkkG3T54IvwRV2jJTjkksylHF0kS6kregt5EJeFJWlz
 gX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sQEMvPK5qpauEIGdA0iadnvQNNPhqlsJWjU3f8TcgEg=;
 b=VVncJh3cBVXShTPJzasWk6QUPWmko2atdLgyvkd4eB8+gaK3fyfZn4aFAwzAq5VWdV
 FeVTipOUe9VXzBCXRCau3PdjSxSPRCNFaZL0jyL7KUAcdRdyVRFAAK0llb1NOB2IjgTC
 XHddvlsZe/t6eu7xI1a/sNh8qjLTV9d1vix/VU5JRAfIXOIegQKCLJBcqnzUht7XQfaa
 nr3NjQW9zl0FDg7SC73+9kD4Ni60bWjO9qUJRbphi5c/Fca1XZdnliLJDfKBn9kGTPC1
 EXTIhdrArX1Ek3DRd+EgSuB1FkKu4RDDZ+4W538euUYfAo9FiNNujDJNynKivhZclNd5
 NxRw==
X-Gm-Message-State: AOAM532GbWw/cOyal9i3mh4jzyXkpE+4MhONPbIWLuL4vARh6rrim/YL
 NhNoskR1opSrvkMAqZSerFy1X3MJ19ko0zkN0b8=
X-Google-Smtp-Source: ABdhPJxuAg30pbO3i8b4MRBc7dhe7806AoGQGGA4TQstLb9Owqtq+S1vOaxOcN7BUGc7roJiGn5h8qjny52GxXhxKh8=
X-Received: by 2002:a17:906:e0c7:: with SMTP id
 gl7mr1462863ejb.109.1599822218301; 
 Fri, 11 Sep 2020 04:03:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200910174850.716104-1-marcandre.lureau@redhat.com>
 <20200911104642.GE1203593@redhat.com>
In-Reply-To: <20200911104642.GE1203593@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 11 Sep 2020 15:03:26 +0400
Message-ID: <CAJ+F1CLqE5frh7_0d3epi8OGefLiG6pJZMeGsC0JVL5YR8bMpw@mail.gmail.com>
Subject: Re: [PATCH] PoC: Rust binding for QAPI (qemu-ga only, for now)
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000006957805af07a3f2"
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x629.google.com
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
Cc: Sergio Lopez <slp@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000006957805af07a3f2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Sep 11, 2020 at 2:47 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m>
wrote:

> On Thu, Sep 10, 2020 at 09:48:50PM +0400, marcandre.lureau@redhat.com
> wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Hi,
> >
> > Among the QEMU developers, there is a desire to use Rust. (see previous
> > thread from Stefan "Why QEMU should move from C to Rust", the rust-vmm
> > related projects and other experiments).
> >
> > Thanks to our QAPI type system and the associate code generator, it is
> > relatively straightforward to create Rust bindings for the generated C
> > types (also called sys/ffi binding) and functions. (rust-bindgen could
> > probably do a similar job, but it would probably bring other issues).
> > This provides an important internal API already.
> >
> > Slightly more complicated is to expose a Rust API for those, and provid=
e
> > convenient conversions C<->Rust. Taking inspiration from glib-rs
> > binding, I implemented a simplified version of the FromGlib/ToGlib
> > traits, with simpler ownership model, sufficient for QAPI needs.
> >
> > The usage is relatively simple:
> >
> > - from_qemu_none(ptr: *const sys::P) -> T
> >   Return a Rust type T for a const ffi pointer P.
> >
> > - from_qemu_full(ptr: *mut sys::P) -> T
> >   Return a Rust type T for a ffi pointer P, taking ownership.
> >
> > - T::to_qemu_none() -> Stash<P>
> >   Returns a borrowed ffi pointer P (using a Stash to destroy "glue"
> >   storage data, if any).
> >
> > - T::to_qemu_full() -> P
> >   Returns a ffi pointer P. (P resources are leaked/passed to C/ffi)
> >
> > With those traits, it's relatively easy to implement the QMP callbacks.
> > With enough interest, we could eventually start rewriting QGA in
> > Rust, as it is a simple service. See qga/qmp.rs for some examples.
> > We could also try to tackle qemu itself.
> >
> > Finally, given that the QAPI types are easy to serialize, it was simple
> > to use "serde" on them, and provide a D-Bus interface for QMP with zbus=
.
> > (a similar approach could probably be taken for other protocols, that
> > could be dynamically loaded... anyone like protobuf better?)
> >
> > This PoC modifies qemu-ga to provide the interface on the session bus:
> > $ qga/qemu-ga -m unix-listen -p /tmp/qga.sock -t /tmp -v
> > $ busctl --user introspect org.qemu.qga /org/qemu/qga org.qemu.QgaQapi
> > ...
> > $ busctl --user call org.qemu.qga /org/qemu/qga org.qemu.QgaQapi
> > GuestSetVcpus aa\{sv\} 1 2 logical-id x 0 online b 1
> > ...
> >
> > Note: the generated code doesn't work with the qemu schema, there is a
> > couple of fixme/todo left.
> >
> > Shameful pain point: meson & cargo don't play nicely together.
>
> Do we actually need/want it to be in the same monolithic repo
> as qemu, as opposed to a qemu-qapi-rust repo ?
>
> Trying to weld together different build systems is never that
> attractive. The language specific build systems generally are
> much simpler if they're self contained. From a distro POV it
> can be better if the language bindings are self contained, as
> you don't neccessarily want to build the language binding in
> the same environment as the main app. For example with modules
> in Fedora or RHEL, there can be multiple parallel versions of
> a language runtime, and thus language bindings would be built
> separately from QEMU.
>

> IIUC, you're generating stuff from the QEMU schemas. One way
> we can deal with this is to actually install the QEMU schemas
> into /usr/share. Distros would have an "qemu-devel" package
> that provided the schemas and the QAPI base tools which
> can then be used by separate bindings.
>
>
- the schema is configured at build time. The C QAPI types depend on build
conditions. (although I don't take that into account yet, but that
shouldn't be too hard to add)
- one of the goals is to start rewriting some part of QEMU in Rust. Here, I
started with qemu-ga because it's an "easy" target.

Generating binding for QMP schema (the protocol) is slightly easier, since
the JSON messages are loosely typed. Yet, we would probably recommend you
do it from qmp introspect output, at runtime. How close that is from the
original QAPI schema, I can't tell, I never really looked or used it (it's
not human friendly to start with, iirc)

Now, I am confident various people are trying to improve the situation wrt
meson+cargo integration, I'll do some more research.

thanks

--00000000000006957805af07a3f2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 11, 2020 at 2:47 PM Dan=
iel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@re=
dhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">On Thu, Sep 10, 2020 at 09:48:50PM +0400, <a href=3D"mailto:marcand=
re.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a> wro=
te:<br>
&gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
&gt; <br>
&gt; Hi,<br>
&gt; <br>
&gt; Among the QEMU developers, there is a desire to use Rust. (see previou=
s<br>
&gt; thread from Stefan &quot;Why QEMU should move from C to Rust&quot;, th=
e rust-vmm<br>
&gt; related projects and other experiments).<br>
&gt; <br>
&gt; Thanks to our QAPI type system and the associate code generator, it is=
<br>
&gt; relatively straightforward to create Rust bindings for the generated C=
<br>
&gt; types (also called sys/ffi binding) and functions. (rust-bindgen could=
<br>
&gt; probably do a similar job, but it would probably bring other issues).<=
br>
&gt; This provides an important internal API already.<br>
&gt; <br>
&gt; Slightly more complicated is to expose a Rust API for those, and provi=
de<br>
&gt; convenient conversions C&lt;-&gt;Rust. Taking inspiration from glib-rs=
<br>
&gt; binding, I implemented a simplified version of the FromGlib/ToGlib<br>
&gt; traits, with simpler ownership model, sufficient for QAPI needs.<br>
&gt; <br>
&gt; The usage is relatively simple:<br>
&gt; <br>
&gt; - from_qemu_none(ptr: *const sys::P) -&gt; T<br>
&gt;=C2=A0 =C2=A0Return a Rust type T for a const ffi pointer P.<br>
&gt; <br>
&gt; - from_qemu_full(ptr: *mut sys::P) -&gt; T<br>
&gt;=C2=A0 =C2=A0Return a Rust type T for a ffi pointer P, taking ownership=
.<br>
&gt; <br>
&gt; - T::to_qemu_none() -&gt; Stash&lt;P&gt;<br>
&gt;=C2=A0 =C2=A0Returns a borrowed ffi pointer P (using a Stash to destroy=
 &quot;glue&quot;<br>
&gt;=C2=A0 =C2=A0storage data, if any).<br>
&gt; <br>
&gt; - T::to_qemu_full() -&gt; P<br>
&gt;=C2=A0 =C2=A0Returns a ffi pointer P. (P resources are leaked/passed to=
 C/ffi)<br>
&gt; <br>
&gt; With those traits, it&#39;s relatively easy to implement the QMP callb=
acks.<br>
&gt; With enough interest, we could eventually start rewriting QGA in<br>
&gt; Rust, as it is a simple service. See qga/<a href=3D"http://qmp.rs" rel=
=3D"noreferrer" target=3D"_blank">qmp.rs</a> for some examples.<br>
&gt; We could also try to tackle qemu itself.<br>
&gt; <br>
&gt; Finally, given that the QAPI types are easy to serialize, it was simpl=
e<br>
&gt; to use &quot;serde&quot; on them, and provide a D-Bus interface for QM=
P with zbus.<br>
&gt; (a similar approach could probably be taken for other protocols, that<=
br>
&gt; could be dynamically loaded... anyone like protobuf better?)<br>
&gt; <br>
&gt; This PoC modifies qemu-ga to provide the interface on the session bus:=
<br>
&gt; $ qga/qemu-ga -m unix-listen -p /tmp/qga.sock -t /tmp -v<br>
&gt; $ busctl --user introspect org.qemu.qga /org/qemu/qga org.qemu.QgaQapi=
<br>
&gt; ...<br>
&gt; $ busctl --user call org.qemu.qga /org/qemu/qga org.qemu.QgaQapi<br>
&gt; GuestSetVcpus aa\{sv\} 1 2 logical-id x 0 online b 1<br>
&gt; ...<br>
&gt; <br>
&gt; Note: the generated code doesn&#39;t work with the qemu schema, there =
is a<br>
&gt; couple of fixme/todo left.<br>
&gt; <br>
&gt; Shameful pain point: meson &amp; cargo don&#39;t play nicely together.=
<br>
<br>
Do we actually need/want it to be in the same monolithic repo<br>
as qemu, as opposed to a qemu-qapi-rust repo ?<br>
<br>
Trying to weld together different build systems is never that<br>
attractive. The language specific build systems generally are<br>
much simpler if they&#39;re self contained. From a distro POV it<br>
can be better if the language bindings are self contained, as<br>
you don&#39;t neccessarily want to build the language binding in<br>
the same environment as the main app. For example with modules<br>
in Fedora or RHEL, there can be multiple parallel versions of<br>
a language runtime, and thus language bindings would be built<br>
separately from QEMU. <br></blockquote><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
<br>
IIUC, you&#39;re generating stuff from the QEMU schemas. One way<br>
we can deal with this is to actually install the QEMU schemas<br>
into /usr/share. Distros would have an &quot;qemu-devel&quot; package<br>
that provided the schemas and the QAPI base tools which<br>
can then be used by separate bindings.<br>
<br></blockquote><div><br></div>- the schema is configured at build time. T=
he C QAPI types depend on build conditions. (although I don&#39;t take that=
 into account yet, but that shouldn&#39;t be too hard to add)<br><div>- one=
 of the goals is to start rewriting some part of QEMU in Rust. Here, I star=
ted with qemu-ga because it&#39;s an &quot;easy&quot; target.<br></div><div=
><br></div>Generating binding for QMP schema (the protocol) is slightly eas=
ier, since the JSON messages are loosely typed. Yet, we would probably reco=
mmend you do it from qmp introspect output, at runtime. How close that is f=
rom the original QAPI schema, I can&#39;t tell, I never really looked or us=
ed it (it&#39;s not human friendly to start with, iirc)</div><div class=3D"=
gmail_quote"><br></div><div class=3D"gmail_quote">Now, I am confident vario=
us people are trying to improve the situation wrt meson+cargo integration, =
I&#39;ll do some more research.</div><div class=3D"gmail_quote"><br></div><=
div class=3D"gmail_quote">thanks<br></div></div>

--00000000000006957805af07a3f2--

