Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1166CC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 19:56:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91AFD21556
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 19:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8WeS3hE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91AFD21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka2Pa-0000TX-M7
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 14:56:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ka2O7-0007F3-IY
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 14:54:39 -0500
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:43565)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ka2O5-0001TB-Hb
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 14:54:39 -0500
Received: by mail-ed1-x544.google.com with SMTP id b9so9527568edu.10
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 11:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lONBOVJhECPXIwdmERHjW8dVnU0cyFVIUWsiU0o3HZk=;
 b=a8WeS3hE3xEMKNdQq9tWczqPtoE2x8YQ1ChacbLiNgP0dQfVj45wlmrgyYAfsCV0Is
 rcO1+LaKWrAi+SgECtyonTbStfQU8sSSEppFyTTML663H+yz0y30W0T9df561mH/9l5a
 Knb1wODqMuBhdLqSZd+/NVSK8hr5Td7kbk8DZs8YxSzSpZpmbh+o9P/bJnB3YJEDk3LD
 f+s+HDVr55Dg5Fp14vpMQKMbVoe9uLvP0P6vDvkQx4pXNBbX3z+a9Vfw4oud+9JRQfTs
 Q7rOfo5F6qaYXSQr/yWSM02KWj9j3el6Fa0acg+5mz745eom3+UssP8fqC8tXD3Y1Rjl
 teEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lONBOVJhECPXIwdmERHjW8dVnU0cyFVIUWsiU0o3HZk=;
 b=uHfMgDll4fgJ78sT3WXXInQD/GX/BmMv3zPejOk5WdkIAhAd/MXMRdTNQm1LYA1zsl
 PHNQ4UHNWqrAjHnnEH6kSw0d3J3zJtDaVB7LeJXKr+0LggXhCg/f9zODdRXdR6xG3HhQ
 Nkh5Sy8fB0KHr4bPMT8lMJG0X2sSzZNBe4+8XVWiGRlFneIPyavOJs8wc5Ms25mPrV8M
 6rJFTc75Ki4761PE8BHm+55zWYIpRDcIHtj351MZHZV4CxZLLqxv2EUNzhJqKGkB0Yx7
 GKShcsTMrofRoXFuV3mV+leV/m3Zdz9kiCb70ZgCG5Js5MoRn5fvHG+Qux36bOyrdZd3
 mO9g==
X-Gm-Message-State: AOAM533HhTMNqDCb3Th5xar0anOVvBhmVaeZkSGkqfFUDNL7XyBi+iNM
 w4XYIOP/hnC0f5WpNrmRSZZSxpM5Buwkpb6utEY=
X-Google-Smtp-Source: ABdhPJwXacoHswwTbuxlZDha6SI7MgHPeCN7+R9ybGRg0u3s2RehRhj6VR91FojPkWWX7r9FXtk8uu/REciN7g6/Pqo=
X-Received: by 2002:a05:6402:1615:: with SMTP id
 f21mr24378630edv.257.1604433275434; 
 Tue, 03 Nov 2020 11:54:35 -0800 (PST)
MIME-Version: 1.0
References: <20201015165255.1573897-1-marcandre.lureau@redhat.com>
 <20201015165255.1573897-3-marcandre.lureau@redhat.com>
 <dc5f64c4-7945-dc13-69d6-858c43dd479b@redhat.com>
In-Reply-To: <dc5f64c4-7945-dc13-69d6-858c43dd479b@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 3 Nov 2020 23:54:22 +0400
Message-ID: <CAJ+F1CKTqZ1urnH0sTQ+JPE5DaByytErN8yEe345+aNs3f467A@mail.gmail.com>
Subject: Re: [PATCH 2/9] qapi: move gen_if/gen_endif to IfCond
To: John Snow <jsnow@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000072c00305b3393bd1"
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, QEMU <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000072c00305b3393bd1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Oct 28, 2020 at 1:32 AM John Snow <jsnow@redhat.com> wrote:

> On 10/15/20 12:52 PM, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Move the generating function to the IfCond class.
> > (avoid cluttering and potential missuse of global functions, allow
> > access to private members etc)
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   scripts/qapi/common.py     | 22 ++++++++++------------
> >   scripts/qapi/gen.py        |  6 ++----
> >   scripts/qapi/introspect.py |  6 ++----
> >   scripts/qapi/types.py      | 22 ++++++++++------------
> >   scripts/qapi/visit.py      | 14 ++++++--------
> >   5 files changed, 30 insertions(+), 40 deletions(-)
> >
>
> Seems straightforward enough, though I guess your 'Ifcond' object
> becomes something more of a code generator class than a pure abstract
> representation by absorbing C generation functions, yeah?
>

Right, in its current form (
https://github.com/elmarco/qemu/blob/qapi-rs/scripts/qapi/common.py#L283),
it has  "def gen_if(self) -> str" & "def gen_endif(self) -> str" (for C),
as well as "def gen_rs_cfg(self) -> str" (for Rust).

I didn't bother doing a visitor or other fancy design, as it's easy to
iterate later if needed, imho.

--=20
Marc-Andr=C3=A9 Lureau

--00000000000072c00305b3393bd1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, Oct 28, 2020 at 1:32 AM John Snow &lt=
;<a href=3D"mailto:jsnow@redhat.com">jsnow@redhat.com</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">On 10/15/20 12:52 PM, =
<a href=3D"mailto:marcandre.lureau@redhat.com" target=3D"_blank">marcandre.=
lureau@redhat.com</a> wrote:<br>
&gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
&gt; <br>
&gt; Move the generating function to the IfCond class.<br>
&gt; (avoid cluttering and potential missuse of global functions, allow<br>
&gt; access to private members etc)<br>
&gt; <br>
&gt; Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.=
lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br=
>
&gt; ---<br>
&gt;=C2=A0 =C2=A0scripts/qapi/common.py=C2=A0 =C2=A0 =C2=A0| 22 ++++++++++-=
-----------<br>
&gt;=C2=A0 =C2=A0scripts/qapi/gen.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 6 +=
+----<br>
&gt;=C2=A0 =C2=A0scripts/qapi/introspect.py |=C2=A0 6 ++----<br>
&gt;=C2=A0 =C2=A0scripts/qapi/types.py=C2=A0 =C2=A0 =C2=A0 | 22 ++++++++++-=
-----------<br>
&gt;=C2=A0 =C2=A0scripts/qapi/visit.py=C2=A0 =C2=A0 =C2=A0 | 14 ++++++-----=
---<br>
&gt;=C2=A0 =C2=A05 files changed, 30 insertions(+), 40 deletions(-)<br>
&gt; <br>
<br>
Seems straightforward enough, though I guess your &#39;Ifcond&#39; object <=
br>
becomes something more of a code generator class than a pure abstract <br>
representation by absorbing C generation functions, yeah?<br>
</blockquote><div><br></div><div>Right, in its current form (<a href=3D"htt=
ps://github.com/elmarco/qemu/blob/qapi-rs/scripts/qapi/common.py#L283">http=
s://github.com/elmarco/qemu/blob/qapi-rs/scripts/qapi/common.py#L283</a>), =
it has=C2=A0 &quot;def gen_if(self) -&gt; str&quot; &amp; &quot;def gen_end=
if(self) -&gt; str&quot; (for C), as well as &quot;def gen_rs_cfg(self) -&g=
t; str&quot; (for Rust).</div><div><br></div><div>I didn&#39;t bother doing=
 a visitor or other fancy design, as it&#39;s easy to iterate later if need=
ed, imho.<br></div></div><br>-- <br><div dir=3D"ltr" class=3D"gmail_signatu=
re">Marc-Andr=C3=A9 Lureau<br></div></div>

--00000000000072c00305b3393bd1--

