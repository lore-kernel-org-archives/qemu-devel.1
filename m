Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4904C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 20:47:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B6A520737
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 20:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHHcpzfV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B6A520737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBOns-0006Jb-R9
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 16:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kBOn0-0005Rz-IU
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 16:46:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50056
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kBOmy-0002nK-C8
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 16:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598561187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YzgEn+rRY84elfJQsmmqWdDleXMyV/iOLtwxM+C/dCY=;
 b=DHHcpzfVxnGICt+uCzTP7F6mTD60aVnVXghJakjFPfOtvhii0j4BmxvM/bwth9RdfKdwBr
 bRw/XSLYr4m7BGQ8FgWBjZRUNElwYGaClP+7PA25hw8JHTyf5esKoE4nvZjhh8ndRAtADl
 YSraa8WM1Y9YaOe2ueUMgM0jds6D8qg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-cvmnGLAzNxKZzKH9RWmEEA-1; Thu, 27 Aug 2020 16:46:22 -0400
X-MC-Unique: cvmnGLAzNxKZzKH9RWmEEA-1
Received: by mail-ej1-f70.google.com with SMTP id l7so3138469ejr.7
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 13:46:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YzgEn+rRY84elfJQsmmqWdDleXMyV/iOLtwxM+C/dCY=;
 b=dbvvYNMPFjWLF6sppSx7AtUI1SzTkBPZ4p/miQhpZ9+dj0qylepuySPBnqz4WLnZxc
 U1pO4SipsebHTm+tIhiMsrYmzdtv7uEsD85ufZE/9VoTh3ACR1KU4voY9O/g8xMTn5TH
 JnQGn6YFiqwStv/cY5jMywqY5VUAYgVENlmnuhCfPQGg1aDz/1iQuUMsTURHJCtVMlK/
 EGMI4hCdJhl1ssBXftt6BxecABkMQ1LES+0C+JdH0i2IxGEcTlfLxkjHElee1cMCkbGf
 JStp7borvCnZefO3Xo2sI84WOtS5HiAaeVxS3vtfx5ut2RCnxFTiA3otdLAP7TGqBaLr
 JtDA==
X-Gm-Message-State: AOAM5310PR+GGhiqzMb1wSW5sHs685qwHMlKqwkOjLQJdOTj5tN/PhY4
 VgRgIRvTht1Z440GvVFDY7X8wP5SJHu8NaWafMnHBS7NuQDFYSjf2zPxtJPKygFXkvVivz5vGUo
 X+5M4vsSASNc9AV0e69HfvU2jWnVfhVc=
X-Received: by 2002:a17:906:328d:: with SMTP id
 13mr23595166ejw.71.1598561181153; 
 Thu, 27 Aug 2020 13:46:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSnLUD1thqAsSmaJXv8wtdad4tfx187r9QiHCnS8b/0Vibbsh9NP8pRbfQm/2SGUeZEedSUfj/usqLER+jDR0=
X-Received: by 2002:a17:906:328d:: with SMTP id
 13mr23595144ejw.71.1598561180930; 
 Thu, 27 Aug 2020 13:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200827165956.12925-1-pbonzini@redhat.com>
 <20200827165956.12925-3-pbonzini@redhat.com>
 <8daf0562-3a9d-e9db-44ce-d95352ff2328@redhat.com>
 <8444fee6-4bd9-5585-5175-55f2a02ade00@redhat.com>
In-Reply-To: <8444fee6-4bd9-5585-5175-55f2a02ade00@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 27 Aug 2020 22:46:09 +0200
Message-ID: <CABgObfbkty2pnfJXT=K-0veXJa16gvU2Q1_LQpVjBfgcTcpZ-Q@mail.gmail.com>
Subject: Re: [PULL 02/17] meson: Build qemu-nbd on macOS again
To: Eric Blake <eblake@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000576eee05ade207ad"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:56:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000576eee05ade207ad
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Even though I did include some patches for other subsystems, I would rather
avoid doing that unless they only touch meson.build files. So I went with
the minimal regression fix.

Paolo

Il gio 27 ago 2020, 22:00 Eric Blake <eblake@redhat.com> ha scritto:

> On 8/27/20 1:06 PM, Thomas Huth wrote:
> > On 27/08/2020 18.59, Paolo Bonzini wrote:
> >> From: Thomas Huth <thuth@redhat.com>
> >>
> >> Before switching to the meson build system, we used to compile qemu-nb=
d
> >> for macOS, too, which is especially important for running the iotests
> >> there. Commit b7c70bf2c5 disabled it by accident, since it did not tak=
e
> >> into consideration that the $bsd variable in the configure script was
> >> also set to "yes" on macOS. Fix it by enabling qemu-nbd on all systems
> >> but Windows now instead (which was likely the original intention of th=
e
> >> old code in the configure script).
> >>
> >> Fixes: b7c70bf2c5 ("meson: qemu-{img,io,nbd}")
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> Acked-by: Eric Blake <eblake@redhat.com>
> >> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >> ---
> >>   meson.build | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
>
> >> -  if targetos =3D=3D 'linux' or targetos =3D=3D 'sunos' or
> targetos.endswith('bsd')
> >> +  if targetos !=3D 'windows'
> >>       qemu_nbd =3D executable('qemu-nbd', files('qemu-nbd.c'),
> >>                  dependencies: [block, qemuutil], install: true)
> >>       qemu_block_tools +=3D [qemu_nbd]
> >>
> >
> >   Hi Paolo!
> >
> > Daniel posted some better patches that even enable qemu-nbd on Windows
> > (see the "nbd: build qemu-nbd on Windows" v2 patch series)... in case
> > you have to respin this pull request, please use his patches instead!
>
> And if not, I'll get them in through my NBD queue; it's not too hard to
> rebase them.
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>
>

--000000000000576eee05ade207ad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Even though I did include some patches for other subsyste=
ms, I would rather avoid doing that unless they only touch meson.build file=
s. So I went with the minimal regression fix.<div dir=3D"auto"><br></div><d=
iv dir=3D"auto">Paolo</div></div><br><div class=3D"gmail_quote"><div dir=3D=
"ltr" class=3D"gmail_attr">Il gio 27 ago 2020, 22:00 Eric Blake &lt;<a href=
=3D"mailto:eblake@redhat.com">eblake@redhat.com</a>&gt; ha scritto:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">On 8/27/20 1:06 PM, Thomas Huth wrote:<br>
&gt; On 27/08/2020 18.59, Paolo Bonzini wrote:<br>
&gt;&gt; From: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=
=3D"_blank" rel=3D"noreferrer">thuth@redhat.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; Before switching to the meson build system, we used to compile qem=
u-nbd<br>
&gt;&gt; for macOS, too, which is especially important for running the iote=
sts<br>
&gt;&gt; there. Commit b7c70bf2c5 disabled it by accident, since it did not=
 take<br>
&gt;&gt; into consideration that the $bsd variable in the configure script =
was<br>
&gt;&gt; also set to &quot;yes&quot; on macOS. Fix it by enabling qemu-nbd =
on all systems<br>
&gt;&gt; but Windows now instead (which was likely the original intention o=
f the<br>
&gt;&gt; old code in the configure script).<br>
&gt;&gt;<br>
&gt;&gt; Fixes: b7c70bf2c5 (&quot;meson: qemu-{img,io,nbd}&quot;)<br>
&gt;&gt; Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com"=
 target=3D"_blank" rel=3D"noreferrer">thuth@redhat.com</a>&gt;<br>
&gt;&gt; Acked-by: Eric Blake &lt;<a href=3D"mailto:eblake@redhat.com" targ=
et=3D"_blank" rel=3D"noreferrer">eblake@redhat.com</a>&gt;<br>
&gt;&gt; Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandr=
e.lureau@redhat.com" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@=
redhat.com</a>&gt;<br>
&gt;&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat=
.com" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 =C2=A0meson.build | 2 +-<br>
&gt;&gt;=C2=A0 =C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;&gt;<br>
<br>
&gt;&gt; -=C2=A0 if targetos =3D=3D &#39;linux&#39; or targetos =3D=3D &#39=
;sunos&#39; or targetos.endswith(&#39;bsd&#39;)<br>
&gt;&gt; +=C2=A0 if targetos !=3D &#39;windows&#39;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_nbd =3D executable(&#39;qemu-nbd&#3=
9;, files(&#39;qemu-nbd.c&#39;),<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 depe=
ndencies: [block, qemuutil], install: true)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_block_tools +=3D [qemu_nbd]<br>
&gt;&gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0Hi Paolo!<br>
&gt; <br>
&gt; Daniel posted some better patches that even enable qemu-nbd on Windows=
<br>
&gt; (see the &quot;nbd: build qemu-nbd on Windows&quot; v2 patch series)..=
. in case<br>
&gt; you have to respin this pull request, please use his patches instead!<=
br>
<br>
And if not, I&#39;ll get them in through my NBD queue; it&#39;s not too har=
d to <br>
rebase them.<br>
<br>
-- <br>
Eric Blake, Principal Software Engineer<br>
Red Hat, Inc.=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+1-919-301-3226<br>
Virtualization:=C2=A0 <a href=3D"http://qemu.org" rel=3D"noreferrer norefer=
rer" target=3D"_blank">qemu.org</a> | <a href=3D"http://libvirt.org" rel=3D=
"noreferrer noreferrer" target=3D"_blank">libvirt.org</a><br>
<br>
</blockquote></div>

--000000000000576eee05ade207ad--


