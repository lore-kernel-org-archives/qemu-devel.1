Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5727C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:09:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 190AF207C3
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E29O/DWn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 190AF207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKlmq-0004HX-5B
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 13:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kKlGn-0002zj-Uy
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 12:36:00 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:39159)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kKlGj-0002m9-18
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 12:35:56 -0400
Received: by mail-ed1-x544.google.com with SMTP id e22so16812509edq.6
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 09:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WrO3oRoVgF1YYmLUjSH7jIk+mv9M/TBqteyo3UOHRCU=;
 b=E29O/DWntvtw4m3o83PVRu7uIrjBFpCIimNhED61grpwlrjoQ+1Uz+wR55gpLUpBpy
 GmZo2yibJmdWEnqk8QOcpguL8VRgAjAQLGKGdaKHq+swFilqRRYpRr/gdjP1cxR2crbX
 /rcWvaLODrGaRb9ZerEgbRQHyfCxZ3fPf3G2U+24zwG1XgCuL49vO5JKisJOz871BFci
 lUFjpfVgw8DmmAMyH6l86ni8Fa7YfP+N+XerUfMK5iwwfa+uTpe8MUkU5zmNbVV7cMVZ
 roEYGHS83RFEyBWX1vSdRRwTasDvLjFgCkDsHx2Cc78IeIKghyFTGnp0tS/LZoeBwGIA
 PqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WrO3oRoVgF1YYmLUjSH7jIk+mv9M/TBqteyo3UOHRCU=;
 b=KJNb38RIoan7lWtXScd2ts2zXoqFwufZPCegIOO0LQ6gP4m+xXUHIgKOHZ3Ky9AF5h
 FlysliNNNnS6ju7Kry6qFMSWwFk1kBkaCKbZIrwBa+cETAZbissMx35fZLWrrjfAzX5k
 UI+o+Ixp+mHDc6+5RgWPcUnFmbjcU63CoisCv8LAXeKCuW6xq3mva8zsihJ4ZIUjijXo
 Nt4f1BTDPCLc8UBfnIbS2WfH9imrPlkCvWeiR0tJ/GVAOL4a6Vt0mfMmfsw3mu+wPyp0
 Twt5dN3pd+wllQuYFibeHJ+9jaWO17hxVw/LHhqsKmvKaYF432Z6fQMW3aJ8hb49RCVH
 vuMw==
X-Gm-Message-State: AOAM530mA25DYrgYDkehAdLQnQ5WXMWlbYE9kE7VmfD/UvaY0aDjqWXN
 fFqhbg33ncNoZykUA4JfeGuTgBp0AuhGk4Sdi9E=
X-Google-Smtp-Source: ABdhPJxzGBNKqaUJr/QoBJRYIMs//D1b+jbc1pLVmxsQoioeHiU/cHTfwR00FhMDbOixTpvqNXR2BtD8wcUKtNVm8Xc=
X-Received: by 2002:aa7:dd0d:: with SMTP id i13mr4842451edv.314.1600792550558; 
 Tue, 22 Sep 2020 09:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200910174850.716104-1-marcandre.lureau@redhat.com>
 <87mu1j8p7p.fsf@dusky.pond.sub.org>
 <CAMxuvayvRfjUMYDiB5fm5QBD76kfD8-G1wTEucQTBbZUtnwXrA@mail.gmail.com>
 <874knpluez.fsf@dusky.pond.sub.org>
In-Reply-To: <874knpluez.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 22 Sep 2020 20:35:38 +0400
Message-ID: <CAJ+F1CLCT3RpZF8JDYayqkKxFu76vy+q6GUjofZV3JF_YDvxng@mail.gmail.com>
Subject: Re: [PATCH] PoC: Rust binding for QAPI (qemu-ga only, for now)
To: Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000055cef305afe98fb9"
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x544.google.com
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

--00000000000055cef305afe98fb9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Sep 22, 2020 at 8:11 PM Markus Armbruster <armbru@redhat.com> wrote=
:

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> >> * Adding results
> >
> > Also change the signature of the function.
> >
> > However, since messages have boundaries, it is easy to ignore return
> values.
>
> I'm not sure I understand this.
>
> The compatible change I have in mind is adding members to the complex
> type returned by a command.
>


There are certain things you can do in D-Bus, just like we do with JSON.
You could ignore the signature checking, you could ignore some extra
message fields... That's not what people usually expect. D-Bus is a machine
and bindings friendly. It's not meant to be so lazy.



> >> We've made use of this extensively.  See also
> >> docs/devel/qapi-code-gen.txt section "Compatibility considerations."
> >>
> >> How do such changes affect clients of the proposed D-Bus interface?
> >
> > The introspection XML will always reflect the expected signature. You
> > should bump your interface version whenever you make incompatible
> > changes.
>
> How do "interface versions" work?  Client's and server's version need to
> match, or else no go?
>
>
The D-Bus specification doesn't detail versioning much. What is recommended
is to have the version number as part of the interface name (kinda like
soname): http://0pointer.de/blog/projects/versioning-dbus.html (this is
documented in several places iirc)

So a QEMU D-Bus interface could have a name like org.qemu.Qemu51,
org.qemu.Qemu52.. for example, if we can't provide better API stability...

--=20
Marc-Andr=C3=A9 Lureau

--00000000000055cef305afe98fb9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 22, 2020 at 8:11 PM Mar=
kus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Ma=
rc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com" tar=
get=3D"_blank">marcandre.lureau@redhat.com</a>&gt; writes:<br>
<br>
&gt;&gt; * Adding results<br>
&gt;<br>
&gt; Also change the signature of the function.<br>
&gt;<br>
&gt; However, since messages have boundaries, it is easy to ignore return v=
alues.<br>
<br>
I&#39;m not sure I understand this.<br>
<br>
The compatible change I have in mind is adding members to the complex<br>
type returned by a command.<br></blockquote><div><br></div><div><br></div><=
div>There are certain things you can do in D-Bus, just like we do with JSON=
. You could ignore the signature checking, you could ignore some extra mess=
age fields... That&#39;s not what people usually expect. D-Bus is a machine=
 and bindings friendly. It&#39;s not meant to be so lazy.<br></div><div>=C2=
=A0</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
&gt;&gt; We&#39;ve made use of this extensively.=C2=A0 See also<br>
&gt;&gt; docs/devel/qapi-code-gen.txt section &quot;Compatibility considera=
tions.&quot;<br>
&gt;&gt;<br>
&gt;&gt; How do such changes affect clients of the proposed D-Bus interface=
?<br>
&gt;<br>
&gt; The introspection XML will always reflect the expected signature. You<=
br>
&gt; should bump your interface version whenever you make incompatible<br>
&gt; changes.<br>
<br>
How do &quot;interface versions&quot; work?=C2=A0 Client&#39;s and server&#=
39;s version need to<br>
match, or else no go?<br>
<br clear=3D"all"></blockquote><div><br></div><div>The D-Bus specification =
doesn&#39;t detail versioning much. What is recommended is to have the vers=
ion number as part of the interface name (kinda like soname): <a href=3D"ht=
tp://0pointer.de/blog/projects/versioning-dbus.html">http://0pointer.de/blo=
g/projects/versioning-dbus.html</a> (this is documented in several places i=
irc)</div><div><br></div><div>So a QEMU D-Bus interface could have a name l=
ike org.qemu.Qemu51, org.qemu.Qemu52.. for example, if we can&#39;t provide=
 better API stability...<br></div></div><br>-- <br><div dir=3D"ltr" class=
=3D"gmail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--00000000000055cef305afe98fb9--

