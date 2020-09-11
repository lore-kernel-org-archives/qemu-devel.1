Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E315C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 20:11:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 807CB2083E
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 20:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bsdimp-com.20150623.gappssmtp.com header.i=@bsdimp-com.20150623.gappssmtp.com header.b="YpxlNuLk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 807CB2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bsdimp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGpOS-0003wS-HR
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 16:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1kGpNA-0003MZ-7l
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 16:10:16 -0400
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733]:45353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1kGpN8-0005aE-6b
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 16:10:15 -0400
Received: by mail-qk1-x733.google.com with SMTP id o5so11093028qke.12
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 13:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bScOZt1Un1PwDDx5duOUqem/941s+ryFbq6zBniDcr0=;
 b=YpxlNuLk0akpKdSoJz66MOMPtmB+6GhJWdvoW75l4pFai/8ue9zUsMj0BanNWnvU3M
 2nWDDUoTU3VdWVeAJtnWOboCtKxFrrqetIKacvxXoYt6yyYpqCm5tUOLbcY29kBQUVeo
 LsYw177Fw+ahceIQwpqMHZ2nvybVXj9S5KTznZn4TmiBdCEKtjeWSHsqkupD0uuQrr3R
 SZk4ucLKdMB1q7sB4QsrMkaJUXjfm7b02H7h6fBwqZLhxbBEd11WUvYfOGRPtjQM+SJQ
 DmiqIqjxSJ8tYrHJwQ+yKsLCOBIPgx5QKXJbnRhHdQL2qBIJ1afElAwlolAwsIKT6wQr
 bgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bScOZt1Un1PwDDx5duOUqem/941s+ryFbq6zBniDcr0=;
 b=uMtKjxFyuYAZE3+FBZfVqeyO9vtsgEEoaIBQEqyFTQqB/hxLWgvJQT4/EGZqND4tjI
 UxH/f+tDhwH+kg1EQrll1rjXsGFA+J1ZpyQ7XkYYcgH5o8nmO/f+VVIVACNmB3fDAoJa
 h9X2WociyoOO8R1j3KRudiXSDlUQSu94HP3P65ZowR3mZMkpwF8Q6ZyR55nEcoEgIJXs
 iZzuwoviIeZyslaAK756E2PEwHxDkR+MGzaglKPi+uFk2BtWGA4VB54sl1SuuyBcyhcw
 i7JM5oam8ZgSCp2uW5ZmdTwNkMz0U257Ailo9+j/k2qKbe1ZhChtExI3xFXh/4bmI4+M
 5S8w==
X-Gm-Message-State: AOAM530j8Sh5kuboNSrv1MWDBqyYjYkoDVofX8sqg+SDxUqjsLNZPQC+
 Ake2zYQzanqBxZtW8ChMlSQgN6LfiTO839VYpxunhA==
X-Google-Smtp-Source: ABdhPJz0FmdeDvE7LW2a5Sh4b7EUxo/tv517u8c92O/2+w+9K0lEOEzWndd6P9mP29H6Os5AIpgpuTYHMcJdALt7RIA=
X-Received: by 2002:a37:e508:: with SMTP id e8mr3049409qkg.380.1599855012456; 
 Fri, 11 Sep 2020 13:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200911184919.GV1618070@habkost.net>
 <CAFEAcA-dnKVyUQ3_ZifdDvrpCbKB1zciuu224BbB1WRV0npxzw@mail.gmail.com>
 <20200911200649.GW1618070@habkost.net>
In-Reply-To: <20200911200649.GW1618070@habkost.net>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 11 Sep 2020 14:10:01 -0600
Message-ID: <CANCZdfq0CXqrLJgXQPi+eiDx+qmkNng7agQ40CyE9pH=z9g41g@mail.gmail.com>
Subject: Re: Moving to C11? (was Re: Redefinition of typedefs (C11 feature))
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b5c1ec05af0f457e"
Received-SPF: none client-ip=2607:f8b0:4864:20::733;
 envelope-from=wlosh@bsdimp.com; helo=mail-qk1-x733.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b5c1ec05af0f457e
Content-Type: text/plain; charset="UTF-8"

On Fri, Sep 11, 2020 at 2:07 PM Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Fri, Sep 11, 2020 at 08:06:10PM +0100, Peter Maydell wrote:
> > On Fri, 11 Sep 2020 at 19:49, Eduardo Habkost <ehabkost@redhat.com>
> wrote:
> > >
> > > I'm wondering: do our supported build host platforms all include
> > > compilers that are new enough to let us redefine typedefs?
> > >
> > > The ability to redefine typedefs is a C11 feature which would be
> > > very useful for simplifying our QOM boilerplate code.  The
> > > feature is supported by GCC since 2011 (v4.6.0)[1], and by clang
> > > since 2012 (v3.1)[2].
> >
> > In configure we mandate either GCC v4.8 or better, or
> > clang v3.4 or better, or XCode Clang v5.1 or better
> > (Apple uses a different version numbering setup to upstream).
> > So you should probably double-check that that xcode clang has
> > what you want, but it looks like we're good to go otherwise.
>
> Can anybody confirm if the following is accurate?
>
> https://gist.github.com/yamaya/2924292#file-xcode-clang-vers-L67
> # Xcode 5.1 (5B130a)
> Apple LLVM version 5.1 (clang-503.0.38) (based on LLVM 3.4svn)
> Target: x86_64-apple-darwin13.1.0
> Thread model: posix
>
> If we know we have GCC 4.8+ or clang 3.4+, can we move to C11 and
> start using -std=gnu11?
>

All supported branches of FreeBSD tier 1 platforms would be fine since they
all use clang. Most of the tier 2 ones do too, but the ports/pkg system we
have will install a newer compiler if need be (the ones that don't are
still stuck at gcc 4.2.1 for GPLv3 reasons).

Warner

--000000000000b5c1ec05af0f457e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 11, 2020 at 2:07 PM Eduar=
do Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com">ehabkost@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On=
 Fri, Sep 11, 2020 at 08:06:10PM +0100, Peter Maydell wrote:<br>
&gt; On Fri, 11 Sep 2020 at 19:49, Eduardo Habkost &lt;<a href=3D"mailto:eh=
abkost@redhat.com" target=3D"_blank">ehabkost@redhat.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; I&#39;m wondering: do our supported build host platforms all incl=
ude<br>
&gt; &gt; compilers that are new enough to let us redefine typedefs?<br>
&gt; &gt;<br>
&gt; &gt; The ability to redefine typedefs is a C11 feature which would be<=
br>
&gt; &gt; very useful for simplifying our QOM boilerplate code.=C2=A0 The<b=
r>
&gt; &gt; feature is supported by GCC since 2011 (v4.6.0)[1], and by clang<=
br>
&gt; &gt; since 2012 (v3.1)[2].<br>
&gt; <br>
&gt; In configure we mandate either GCC v4.8 or better, or<br>
&gt; clang v3.4 or better, or XCode Clang v5.1 or better<br>
&gt; (Apple uses a different version numbering setup to upstream).<br>
&gt; So you should probably double-check that that xcode clang has<br>
&gt; what you want, but it looks like we&#39;re good to go otherwise.<br>
<br>
Can anybody confirm if the following is accurate?<br>
<br>
<a href=3D"https://gist.github.com/yamaya/2924292#file-xcode-clang-vers-L67=
" rel=3D"noreferrer" target=3D"_blank">https://gist.github.com/yamaya/29242=
92#file-xcode-clang-vers-L67</a><br>
# Xcode 5.1 (5B130a)<br>
Apple LLVM version 5.1 (clang-503.0.38) (based on LLVM 3.4svn)<br>
Target: x86_64-apple-darwin13.1.0<br>
Thread model: posix<br>
<br>
If we know we have GCC 4.8+ or clang 3.4+, can we move to C11 and<br>
start using -std=3Dgnu11?<br></blockquote><div><br></div><div>All supported=
 branches of FreeBSD tier 1 platforms would be fine since they all use clan=
g. Most of the tier 2 ones do too, but the ports/pkg system we have will in=
stall a newer compiler if need be (the ones that don&#39;t are still stuck =
at gcc 4.2.1 for GPLv3 reasons).</div><div><br></div><div>Warner</div></div=
></div>

--000000000000b5c1ec05af0f457e--

