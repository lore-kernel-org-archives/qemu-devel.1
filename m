Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC63C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 20:45:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 060A5217F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 20:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+ZdSTW5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 060A5217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu0Od-0006Fv-5b
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 15:45:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42817)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iu0Nx-0005nW-Om
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 15:44:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iu0Ns-0000yP-33
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 15:44:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42408
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iu0Nr-0000w2-NX
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 15:44:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579639460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KruHF81JCzviTY6bg58h2BoAuPS3DySX7P/DOAhhmkA=;
 b=a+ZdSTW5R23Ndkea8fQddldIJDSaXzYPhENoeUUTtP8rkdrUhLBG0sVH2x/MUMtoY6YqsX
 rHUQ3mnq16xwEBSjaFJsM0s9RPpCocrwOY5Fz1yVsdXWKigbq9L1xHa5yuPiO+750z3lRB
 AFS5lAM9EqQQxzyFIaNCUA+D81yi1cI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-bQnq6H1lN2WpxFGU0yhltw-1; Tue, 21 Jan 2020 15:44:16 -0500
Received: by mail-ed1-f72.google.com with SMTP id m21so2855638edp.14
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 12:44:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bf791nhdXQUemKDLwsNYSRwNB3DOZ5BRMffAezG78K0=;
 b=mL1qu6vNsrmBb04yS9owJOB/HtWOh4hTmuFS09++qVE0O5qPESQCu45cXhDC3aGMv7
 Q0BiUxNUc4Xl4PlASpy/Kiz4fceDDJYYrnw+bL2C+0ddylKN2I7x566fa/L93oQOPsWp
 FJ+dbf3Rr21+5keh0LSuxUcALg7+WnDPxDwXshhJXwkjBN2Fb1Xz/JDTF+z9h/XZBWJJ
 mtZSGFds6jZb4V1zgnqEM175Ny979Jeg8rp16L9WZxloPEvHRmYr5S8V1sXSXl0vLN2M
 FdIGSAJ9H90fS7YU9hE62jxzNBB4iXy9nw8/0qzMjBK+zp5pbTw7zusQM4Irl69G/HS5
 maSQ==
X-Gm-Message-State: APjAAAWpcol/mYoIbwSTor9TZcQmQWdmmvnfdaob19I7QFB9pKoH1N8x
 kR5McYdG6ryU5ANv0QrFPn3dkmjthk1Yc3nc6tN6toi+9/IDPpz5iR/EuyjTSdqEEoJnlhr8W4P
 sYsk9fUwmefIA4r3ve64AO4qpph/am18=
X-Received: by 2002:a17:906:5358:: with SMTP id
 j24mr6371958ejo.44.1579639455128; 
 Tue, 21 Jan 2020 12:44:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqx3HOAav8yr7tvnf/QGe29XTHVFIF/zGmWvH7WHM5f/WaHWRUIPvZUsa+IgZ6ReygMd3wg/QiTWgArk756unKk=
X-Received: by 2002:a17:906:5358:: with SMTP id
 j24mr6371948ejo.44.1579639454920; 
 Tue, 21 Jan 2020 12:44:14 -0800 (PST)
MIME-Version: 1.0
References: <20191231184916.10235-1-philmd@redhat.com>
 <875zhfzc9l.fsf@dusky.pond.sub.org>
 <a06fd97c-b149-2f24-1180-4e4efa8ff79d@redhat.com>
 <87wo9ll5on.fsf@dusky.pond.sub.org>
 <b0559940-7b97-901b-5729-587d8649eede@redhat.com>
 <87lfq0c2jq.fsf@dusky.pond.sub.org>
In-Reply-To: <87lfq0c2jq.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Jan 2020 21:44:01 +0100
Message-ID: <CABgObfaPrbbx6Bw0Cj14evAvA_TSUo-+iOCkBzEBfPVn6qDLBg@mail.gmail.com>
Subject: Re: [RFC PATCH] qapi: Incorrect attempt to fix building with
 MC146818RTC=n
To: Markus Armbruster <armbru@redhat.com>
X-MC-Unique: bQnq6H1lN2WpxFGU0yhltw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000958e78059cac78f9"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000958e78059cac78f9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mar 21 gen 2020, 15:22 Markus Armbruster <armbru@redhat.com> ha scritto:

> > To see it a different way, these are the "C bindings" to QMP, just that
> > the implementation is an in-process call rather than RPC.  If the QAPI
> > code generator was also able to generate Python bindings and the like,
> > they would have to be the same for all QEMU binaries, wouldn't they?
>
> Ommitting the kind of #if we've been discussing is relatively harmless
> but what about this one, in qapi-types-block-core.h:
>
>     typedef enum BlockdevDriver {
>         BLOCKDEV_DRIVER_BLKDEBUG,
>         [...]
>     #if defined(CONFIG_REPLICATION)
>         BLOCKDEV_DRIVER_REPLICATION,
>     #endif /* defined(CONFIG_REPLICATION) */
>         [...]
>         BLOCKDEV_DRIVER__MAX,
>     } BlockdevDriver;
>

Well, I don't think this should be conditional at all. Introspection is a
tool to detect unsupported features, not working features. KVM will be
present in introspection data even if /dev/kvm doesn't exist on your
machine or you don't have permission to access it. I would restrict very
much #if usage in QAPI to the very minimum necessary.

Paolo



> If I omit it in the header, I then have to omit it in
> qapi-types-block-core.c's
>
>     const QEnumLookup BlockdevDriver_lookup =3D {
>         .array =3D (const char *const[]) {
>             [BLOCKDEV_DRIVER_BLKDEBUG] =3D "blkdebug",
>             [...]
>     #if defined(CONFIG_REPLICATION)
>             [BLOCKDEV_DRIVER_REPLICATION] =3D "replication",
>     #endif /* defined(CONFIG_REPLICATION) */
>             [...]
>         },
>         .size =3D BLOCKDEV_DRIVER__MAX
>     };
>
> and God knows what else.  But I must not omit it in qapi-introspect.c's
>
>         QLIT_QDICT(((QLitDictEntry[]) {
>             { "meta-type", QLIT_QSTR("enum"), },
>             { "name", QLIT_QSTR("245"), },
>             { "values", QLIT_QLIST(((QLitObject[]) {
>                 QLIT_QSTR("blkdebug"),
>                 [...]
>     #if defined(CONFIG_REPLICATION)
>                 QLIT_QSTR("replication"),
>     #endif /* defined(CONFIG_REPLICATION) */
>                 [...]
>                 {}
>             })), },
>             {}
>         })),
>
> because that would defeat introspection.
>
> I smell a swamp.
>
> I'd rather not complicate the generator to support not including a
> header I feel we *should* include.  #ifdef CONFIG_FOO can occur not just
> in QAPI-generated code, and neglecting to include the relevant header
> can cause *nasty* problems not just in QAPI-generated code.  Like
> inconsistent struct definitions in separate compilation units.  Been
> there, debugged that, wasn't fun, do not want to go there again.
>
>

--000000000000958e78059cac78f9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">Il mar 21 gen 2020, 15:22 Markus Armbruster &lt;<a href=3D"mai=
lto:armbru@redhat.com">armbru@redhat.com</a>&gt; ha scritto:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">&gt; To see it a different way, these are the &qu=
ot;C bindings&quot; to QMP, just that<br>
&gt; the implementation is an in-process call rather than RPC.=C2=A0 If the=
 QAPI<br>
&gt; code generator was also able to generate Python bindings and the like,=
<br>
&gt; they would have to be the same for all QEMU binaries, wouldn&#39;t the=
y?<br>
<br>
Ommitting the kind of #if we&#39;ve been discussing is relatively harmless =
but=C2=A0what about this one, in qapi-types-block-core.h:<br>
<br>
=C2=A0 =C2=A0 typedef enum BlockdevDriver {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 BLOCKDEV_DRIVER_BLKDEBUG,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [...]<br>
=C2=A0 =C2=A0 #if defined(CONFIG_REPLICATION)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 BLOCKDEV_DRIVER_REPLICATION,<br>
=C2=A0 =C2=A0 #endif /* defined(CONFIG_REPLICATION) */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [...]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 BLOCKDEV_DRIVER__MAX,<br>
=C2=A0 =C2=A0 } BlockdevDriver;<br></blockquote></div></div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">Well, I don&#39;t think this should be condi=
tional at all. Introspection is a tool to detect unsupported features, not =
working features. KVM will be present in introspection data even if /dev/kv=
m doesn&#39;t exist on your machine or you don&#39;t have permission to acc=
ess it. I would restrict very much #if usage in QAPI to the very minimum ne=
cessary.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><div =
class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
If I omit it in the header, I then have to omit it in<br>
qapi-types-block-core.c&#39;s<br>
<br>
=C2=A0 =C2=A0 const QEnumLookup BlockdevDriver_lookup =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .array =3D (const char *const[]) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [BLOCKDEV_DRIVER_BLKDEBUG] =3D &q=
uot;blkdebug&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [...]<br>
=C2=A0 =C2=A0 #if defined(CONFIG_REPLICATION)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [BLOCKDEV_DRIVER_REPLICATION] =3D=
 &quot;replication&quot;,<br>
=C2=A0 =C2=A0 #endif /* defined(CONFIG_REPLICATION) */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [...]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .size =3D BLOCKDEV_DRIVER__MAX<br>
=C2=A0 =C2=A0 };<br>
<br>
and God knows what else.=C2=A0 But I must not omit it in qapi-introspect.c&=
#39;s<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 QLIT_QDICT(((QLitDictEntry[]) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { &quot;meta-type&quot;, QLIT_QST=
R(&quot;enum&quot;), },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { &quot;name&quot;, QLIT_QSTR(&qu=
ot;245&quot;), },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { &quot;values&quot;, QLIT_QLIST(=
((QLitObject[]) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QLIT_QSTR(&quot;blk=
debug&quot;),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [...]<br>
=C2=A0 =C2=A0 #if defined(CONFIG_REPLICATION)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QLIT_QSTR(&quot;rep=
lication&quot;),<br>
=C2=A0 =C2=A0 #endif /* defined(CONFIG_REPLICATION) */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [...]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 })), },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 })),<br>
<br>
because that would defeat introspection.<br>
<br>
I smell a swamp.<br>
<br>
I&#39;d rather not complicate the generator to support not including a<br>
header I feel we *should* include.=C2=A0 #ifdef CONFIG_FOO can occur not ju=
st<br>
in QAPI-generated code, and neglecting to include the relevant header<br>
can cause *nasty* problems not just in QAPI-generated code.=C2=A0 Like<br>
inconsistent struct definitions in separate compilation units.=C2=A0 Been<b=
r>
there, debugged that, wasn&#39;t fun, do not want to go there again.<br>
<br>
</blockquote></div></div></div>

--000000000000958e78059cac78f9--


