Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006FEC10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 15:07:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 077B1206C0
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 15:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J9KRItaf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 077B1206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC2wo-00047A-Vq
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 11:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jC2wA-0003gn-Ek
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 11:06:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jC2w8-0001Lr-GC
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 11:06:21 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45276
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jC2w8-0001Ks-5y
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 11:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583939178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gWo4bbY1JhIe+osJhgXfC1+IqOH1Iig9dRC6HoZa1kE=;
 b=J9KRItafhvvHkj4ikMKd5cTPvjsbwXWs4kR+UDA+GlETYE/6gUIaSFsbb8Y//4IqxwArC9
 L0n4zAA/MItNrsiJNYvb0tm6ji95G4tLAK0haoi/cStp5V/bVD/m9phwx8AxMSigktsjyE
 u4G4M0khQSRfOvOXMhrgU6EU000YFrQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-cvfKZNJ0PXaOARTD2CXlvA-1; Wed, 11 Mar 2020 11:06:15 -0400
X-MC-Unique: cvfKZNJ0PXaOARTD2CXlvA-1
Received: by mail-ed1-f69.google.com with SMTP id d12so2063203edq.16
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 08:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e0CwzYllO0O8mu/87AftUlsPdqj8vGf/r08V6Wj7UN4=;
 b=giosH/oUNJ4bkfyEEPODg6BPr0+I6RHZOXu5YdZnQ/7RbD+NWrdxSEpw/AVfCG6LPe
 /rhbnwOd6PfU9clnkdJDRuUmoJMJ2BHAsxanVs9HkuoCGbLY1VIq6tA5R60+K5tVnJJw
 1b/AW2jOwmsIl7kEo4gCtiKsw90bM7evF/Rg+GctNDW0JJXtn7ecnuQr1P6lmqpXovN6
 mkbHdGoRcO6kCHTIImGMbdBXSQVurEJ4L+eiTBenOP7jHZA8k4R+AgdK5ZlGTJoSqXr9
 6wOJz5+XZ5xcrtK9l4by4GCI3/hx1OhuwKtLuc+XyyDiPjCR//R65gqU0imFdsOsOcBi
 wAdg==
X-Gm-Message-State: ANhLgQ1zd/587vOqgoo0sijT45WwTULG8fzZEGNwNhpO2TSu7/iM7mOg
 cS6ix+e+CI6uEveqNIl1LGV2w/lkJSiawVDbebHX/JjrqhbBxZfhoiO4zNaWRsl9239KZafWNrr
 miF/qpy2rThwVrENqwscDuRLyH+nIzdM=
X-Received: by 2002:aa7:cfcc:: with SMTP id r12mr3368489edy.57.1583939174619; 
 Wed, 11 Mar 2020 08:06:14 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtWxZWEBb4z3NqDmic6tG6z4NBlW3Aa4wGZlJTJi2FapxUbALC+5fhwfPv90RDk1+AokS76Bvv7dfQqhnfgIDU=
X-Received: by 2002:aa7:cfcc:: with SMTP id r12mr3368460edy.57.1583939174449; 
 Wed, 11 Mar 2020 08:06:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200311123624.277221-1-stefanha@redhat.com>
 <87d09jx7wm.fsf@dusky.pond.sub.org>
In-Reply-To: <87d09jx7wm.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Mar 2020 16:06:02 +0100
Message-ID: <CABgObfaYwZmokcQHF7Hdr-1v4r1jT4cxF0WiHw_Fob-A1AOXkQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] thread: add lock guard macros
To: Markus Armbruster <armbru@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000d6de5305a09593e2"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d6de5305a09593e2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mer 11 mar 2020, 15:50 Markus Armbruster <armbru@redhat.com> ha scritto:

> Stefan Hajnoczi <stefanha@redhat.com> writes:
>
> > Lock guards automatically call qemu_(rec_)mutex_unlock() when returning
> from a
> > function or leaving leaving a lexical scope.  This simplifies code and
> > eliminates leaks (especially in error code paths).
> >
> > This series adds lock guards for QemuMutex and QemuRecMutex.  It does n=
ot
> > convert the entire tree but includes example conversions.
>
> I support the move towards automatic cleanup, but I'm wary of
> incremental conversion.  Experience tells that outdated examples
> invariably get copied / imitated, with incremental conversion struggling
> to keep up.
>
> Are we resigned to having both kinds of mutex cleanup forever?
>

There are cases where the legibility benefits of guards are debatable, or
they require more complex functionality in the guards (see my other answer
to Stefan). So, yes. We don't have that many mutexes so incremental
conversion should be doable without taking forever.

Paolo


> If not, what's the plan to get the job finished, and until when?
>
>

--000000000000d6de5305a09593e2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 11 mar 2020, 15:50 Markus Armbruster &lt;<a hre=
f=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; ha scritto:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">Stefan Hajnoczi &lt;<a href=3D"mailto:ste=
fanha@redhat.com" target=3D"_blank" rel=3D"noreferrer">stefanha@redhat.com<=
/a>&gt; writes:<br>
<br>
&gt; Lock guards automatically call qemu_(rec_)mutex_unlock() when returnin=
g from a<br>
&gt; function or leaving leaving a lexical scope.=C2=A0 This simplifies cod=
e and<br>
&gt; eliminates leaks (especially in error code paths).<br>
&gt;<br>
&gt; This series adds lock guards for QemuMutex and QemuRecMutex.=C2=A0 It =
does not<br>
&gt; convert the entire tree but includes example conversions.<br>
<br>
I support the move towards automatic cleanup, but I&#39;m wary of<br>
incremental conversion.=C2=A0 Experience tells that outdated examples<br>
invariably get copied / imitated, with incremental conversion struggling<br=
>
to keep up.<br>
<br>
Are we resigned to having both kinds of mutex cleanup forever?<br></blockqu=
ote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">There are cas=
es where the legibility benefits of guards are debatable, or they require m=
ore complex functionality in the guards (see my other answer to Stefan). So=
, yes. We don&#39;t have that many mutexes so incremental conversion should=
 be doable without taking forever.</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cl=
ass=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
If not, what&#39;s the plan to get the job finished, and until when?<br>
<br>
</blockquote></div></div></div>

--000000000000d6de5305a09593e2--


