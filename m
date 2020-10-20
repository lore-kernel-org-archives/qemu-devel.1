Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3D5C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 06:47:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77C6B2225F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 06:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMU2sa9g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C6B2225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUlQk-0007AF-Eo
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 02:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kUlPi-000681-UH
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 02:46:31 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f]:45780)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kUlPd-0004Wp-St
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 02:46:30 -0400
Received: by mail-ej1-x62f.google.com with SMTP id dt13so1008882ejb.12
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 23:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=x8zUfY3zp2uscxpTHSFldLTQ5pWByIrPAvK2g6lQWao=;
 b=NMU2sa9g0z6vddk3LXluquB+acLqMnU/6HYBphZDKGnpgXgnjtVf4N9nhIGGQ4YvbX
 ln0emQsTqqb7aJgCQOq7Q7pxnDjYZOKMxfKTzoIogWUvFWWdDOxtJRlTqzO87gc80oeC
 r3KTN4jWX78jiOLkcu7iBDSqQeGwG2tJpbFeETz94UJtkuh6DkLOk5uZv7Dw9gOkOlyL
 +GPyACABvWOaJjHDfUFp9AoXiY+FXbTH7mIU7iO1p3Jdh+vvv6q1/hNqudqDH+4BDjWX
 FqEvqGsk094A+FlqDSzCO1wwenxPXpnYl4lQZOXs51cGlu1icnJ0U5my1a1Jqz/LwNOw
 dAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=x8zUfY3zp2uscxpTHSFldLTQ5pWByIrPAvK2g6lQWao=;
 b=GpkJ1ED2SHIEfw8G1oCRidiZ0fLgQC/7fxqe2QuH0Xjsb4SVvL7+TNMEvEYmUT3PtF
 ePPNuJ7XcSlC8LKePdCR50Z9+or4NT371NOBHcFqWZG+5agsNyVsVlro0BeLpidlVg3D
 oQwZQdG8gSTc6B5Q6PYCrw5Y2J+JCrJ/h6dn32u6eJSGIhBzBeQfdTqLyGdZxEjMmNit
 T4sO4II3lOjlmME8mTX/Zf8RO8Borq2nzrWzQZWWOtBHGkNW56HBtr/TwjpjKFMN0Uos
 4nVxLEpKCFlyQwLUNK54OpQWHOZn+Q5U5wod2foQn8TFm6dmr9HvnaDnXv30RtmtszjC
 YWnQ==
X-Gm-Message-State: AOAM530ZlgPR6KvoSpOkF3u8hNPf2B/A2U3rQbj7I/zi9d3Wl92pDA7l
 WQJDdmWjIext98Z17HqLmE2MoSm8MghuKApR/Jn7VWjhXVQ=
X-Google-Smtp-Source: ABdhPJzVW7UjO0qveXwBsVyBqBIWQTRGG0SfUIhrNhGi7lsjqzqDBgj7faDn7/E6+sBbwoGruO+g/+spHf/ZjUnY0rU=
X-Received: by 2002:a17:906:4e16:: with SMTP id
 z22mr1574876eju.527.1603176376999; 
 Mon, 19 Oct 2020 23:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201013202502.335336-1-marcandre.lureau@redhat.com>
 <20201013202502.335336-3-marcandre.lureau@redhat.com>
 <d0f6e513-d890-5759-0a1e-de37a5ee241a@redhat.com>
In-Reply-To: <d0f6e513-d890-5759-0a1e-de37a5ee241a@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 20 Oct 2020 10:46:04 +0400
Message-ID: <CAJ+F1C+6hOa_n3KGw=xnNwE-oBGc6jOnpt-JWm7Y3x7i9BF_XA@mail.gmail.com>
Subject: Re: [PATCH 2/2] qga: add ssh-{add,remove}-authorized-keys
To: Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000076a57305b2149615"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x62f.google.com
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000076a57305b2149615
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, Oct 19, 2020 at 11:09 PM Eric Blake <eblake@redhat.com> wrote:

> On 10/13/20 3:25 PM, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Add new commands to add and remove SSH public keys from
> > ~/.ssh/authorized_keys.
> >
>
> > +++ b/qga/qapi-schema.json
> > @@ -1306,3 +1306,35 @@
> >   ##
> >   { 'command': 'guest-get-devices',
> >     'returns': ['GuestDeviceInfo'] }
> > +
> > +##
> > +# @guest-ssh-add-authorized-keys:
> > +#
> > +# @username: the user account to add the authorized key
> > +# @keys: the public keys to add (in OpenSSH format)
> > +#
> > +# Append a public key to user $HOME/.ssh/authorized_keys on Unix
> systems (not
>
> How is $HOME related to @username?
>

If it's not obvious, I could use help on how to formulate this. Would you
rather use the ~username/ syntax? Or just ~/ ?


> > +# implemented for other systems).
> > +#
> > +# Returns: Nothing on success.
>
> Do we really need this line?
>

For consistency, at least.


> > +#
> > +# Since: 5.2
> > +##
> > +{ 'command': 'guest-ssh-add-authorized-keys',
> > +  'data': { 'username': 'str', 'keys': ['str'] } }
>
> Should we use QAPI 'if' to avoid even having to compile a stub on
> Windows, and for better introspection (well, if we ever add a way to do
> qga introspection that parallels QMP's query-qmp-schema)?
>

There is no 'if' usage in QGA schema. As you point out, there is no
introspection command atm. But we can start using it here, I guess.



> > +
> > +##
> > +# @guest-ssh-remove-authorized-keys:
> > +#
> > +# @username: the user account to add the authorized key
> > +# @keys: the public keys to remove (in OpenSSH format)
> > +#
> > +# Remove public keys from the user $HOME/.ssh/authorized_keys on Unix
> systems
> > +# (not implemented for other systems).
> > +#
> > +# Returns: Nothing on success.
> > +#
> > +# Since: 5.2
> > +##
> > +{ 'command': 'guest-ssh-remove-authorized-keys',
> > +  'data': { 'username': 'str', 'keys': ['str'] } }
> >
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>
>
>
thanks

--=20
Marc-Andr=C3=A9 Lureau

--00000000000076a57305b2149615
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 19, 2020 at 11:09 =
PM Eric Blake &lt;<a href=3D"mailto:eblake@redhat.com">eblake@redhat.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On =
10/13/20 3:25 PM, <a href=3D"mailto:marcandre.lureau@redhat.com" target=3D"=
_blank">marcandre.lureau@redhat.com</a> wrote:<br>
&gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
&gt; <br>
&gt; Add new commands to add and remove SSH public keys from<br>
&gt; ~/.ssh/authorized_keys.<br>
&gt; <br>
<br>
&gt; +++ b/qga/qapi-schema.json<br>
&gt; @@ -1306,3 +1306,35 @@<br>
&gt;=C2=A0 =C2=A0##<br>
&gt;=C2=A0 =C2=A0{ &#39;command&#39;: &#39;guest-get-devices&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&#39;returns&#39;: [&#39;GuestDeviceInfo&#39;] }<br=
>
&gt; +<br>
&gt; +##<br>
&gt; +# @guest-ssh-add-authorized-keys:<br>
&gt; +#<br>
&gt; +# @username: the user account to add the authorized key<br>
&gt; +# @keys: the public keys to add (in OpenSSH format)<br>
&gt; +#<br>
&gt; +# Append a public key to user $HOME/.ssh/authorized_keys on Unix syst=
ems (not<br>
<br>
How is $HOME related to @username?<br></blockquote><div><br></div><div>If i=
t&#39;s not obvious, I could use help on how to formulate this. Would you r=
ather use the ~username/ syntax? Or just ~/ ?<br></div><div> <br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +# implemented for other systems).<br>
&gt; +#<br>
&gt; +# Returns: Nothing on success.<br>
<br>
Do we really need this line?<br></blockquote><div><br></div><div>For consis=
tency, at least.</div><div> <br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
<br>
&gt; +#<br>
&gt; +# Since: 5.2<br>
&gt; +##<br>
&gt; +{ &#39;command&#39;: &#39;guest-ssh-add-authorized-keys&#39;,<br>
&gt; +=C2=A0 &#39;data&#39;: { &#39;username&#39;: &#39;str&#39;, &#39;keys=
&#39;: [&#39;str&#39;] } }<br>
<br>
Should we use QAPI &#39;if&#39; to avoid even having to compile a stub on <=
br>
Windows, and for better introspection (well, if we ever add a way to do <br=
>
qga introspection that parallels QMP&#39;s query-qmp-schema)?<br></blockquo=
te><div><br></div><div>There is no &#39;if&#39; usage in QGA schema. As you=
 point out, there is no introspection command atm. But we can start using i=
t here, I guess.<br></div><div><br></div><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
&gt; +<br>
&gt; +##<br>
&gt; +# @guest-ssh-remove-authorized-keys:<br>
&gt; +#<br>
&gt; +# @username: the user account to add the authorized key<br>
&gt; +# @keys: the public keys to remove (in OpenSSH format)<br>
&gt; +#<br>
&gt; +# Remove public keys from the user $HOME/.ssh/authorized_keys on Unix=
 systems<br>
&gt; +# (not implemented for other systems).<br>
&gt; +#<br>
&gt; +# Returns: Nothing on success.<br>
&gt; +#<br>
&gt; +# Since: 5.2<br>
&gt; +##<br>
&gt; +{ &#39;command&#39;: &#39;guest-ssh-remove-authorized-keys&#39;,<br>
&gt; +=C2=A0 &#39;data&#39;: { &#39;username&#39;: &#39;str&#39;, &#39;keys=
&#39;: [&#39;str&#39;] } }<br>
&gt; <br>
<br>
-- <br>
Eric Blake, Principal Software Engineer<br>
Red Hat, Inc.=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+1-919-301-3226<br>
Virtualization:=C2=A0 <a href=3D"http://qemu.org" rel=3D"noreferrer" target=
=3D"_blank">qemu.org</a> | <a href=3D"http://libvirt.org" rel=3D"noreferrer=
" target=3D"_blank">libvirt.org</a><br>
<br>
<br>
</blockquote></div><br clear=3D"all"></div><div>thanks</div><div><br></div>=
<div>-- <br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=A9 Lure=
au<br></div></div></div>

--00000000000076a57305b2149615--

