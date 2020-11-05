Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8FFC4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 14:42:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7B302087D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 14:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KOJckEf4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7B302087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kagSc-0006Z3-F2
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 09:41:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1kagRe-0005ui-V5
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 09:40:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52237)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1kagRZ-0000BH-HI
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 09:40:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604587251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zgr6N+Qy64/8pFojpu7sXzOW5cC06g5me+gwKoUnLr0=;
 b=KOJckEf4+5GhWvk5uQIUEK4xwYcZaomouyOIOdM7aKd/mt8aUYaTKb0g3cRmr3m3z9iSpH
 4ooCl1/7EnAzw320FGu8b29BYHEnecD9v0Hcre3KSnBxDAYBjaUtDd22+bus92OyCXPI9B
 pbtUIEpBLzh/ZLKJfJWWJBfd5txPYQc=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-WTIaO3nJO766hI1uwPIM0Q-1; Thu, 05 Nov 2020 09:40:47 -0500
X-MC-Unique: WTIaO3nJO766hI1uwPIM0Q-1
Received: by mail-io1-f72.google.com with SMTP id s10so1208001iot.21
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 06:40:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zgr6N+Qy64/8pFojpu7sXzOW5cC06g5me+gwKoUnLr0=;
 b=os/J0HyjXE4MgmhejQHO4cpi4YPfo3UfD/9iAc/00MrrzVhmRUdsp9baSVD2+cA7bf
 m35QFeEYAOGkXsZtojCjlj2l99F6vto3XDV256SKlrlrjXy20teYXkFTRp8OLmt8ny+l
 uBZdFEnVgfeSSNlbzeBdQ+bzTaWeb82PceeKe0ZFZjr2QSdK/xKtszaNNegrXT6lqyl0
 XFhk3udyc56SifRgfb/fq+9QdxN3AH1T+XNnzlerpHUsq+uHMFGVdU2gJ4DDBvidtr/H
 1Tk9QLzyf3pt0TlBNKWkQ9P7RpT4OaWYiDR11SUvecStbLFvpbRUaRBjqlBCXw8ykrVc
 XhFQ==
X-Gm-Message-State: AOAM532YchnEzsy7EdXWoZX3fohiayPUWrU0+sF3mebcQHiJJRUQlzVT
 zuKSWW37cclsec5w6R3nhpsXUsdrVN0CmOKITH0xpg7iDZbznDmN1bytv9ZNiQWxTeSflTF+kCm
 g1xCdk/sOITT0fIhwmbu7X0XibiBPY5w=
X-Received: by 2002:a92:d6cf:: with SMTP id z15mr2154814ilp.82.1604587245632; 
 Thu, 05 Nov 2020 06:40:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJylVCBmPGq4TcH+j2lMnxJa99kGlTK3T6XLdKeRLlEpnEntUkDk/18CuyliP/GwgzyheQydJEEeWhS7TGyJyOg=
X-Received: by 2002:a92:d6cf:: with SMTP id z15mr2154789ilp.82.1604587245456; 
 Thu, 05 Nov 2020 06:40:45 -0800 (PST)
MIME-Version: 1.0
References: <20201105122808.1182973-1-marcandre.lureau@redhat.com>
 <20201105122808.1182973-10-marcandre.lureau@redhat.com>
 <28f4b64e-346d-b987-a43d-04a895c5da90@redhat.com>
In-Reply-To: <28f4b64e-346d-b987-a43d-04a895c5da90@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 5 Nov 2020 18:40:34 +0400
Message-ID: <CAMxuvaz61dFxgRfDVttW+vU+crbBHGHWxdPkrB-sC7jW9FV19w@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] docs: update the documentation about schema
 configuration
To: Eric Blake <eblake@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 01:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Thu, Nov 5, 2020 at 5:43 PM Eric Blake <eblake@redhat.com> wrote:
>
> On 11/5/20 6:28 AM, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  docs/devel/qapi-code-gen.txt | 26 +++++++++++++++-----------
> >  1 file changed, 15 insertions(+), 11 deletions(-)
> >
> > diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.tx=
t
> > index 3d22a7ae21..c499352a74 100644
> > --- a/docs/devel/qapi-code-gen.txt
> > +++ b/docs/devel/qapi-code-gen.txt
> > @@ -772,26 +772,30 @@ downstream command __com.redhat_drive-mirror.
> >  =3D=3D=3D Configuring the schema =3D=3D=3D
> >
> >  Syntax:
> > -    COND =3D STRING
> > -         | [ STRING, ... ]
> > +    COND =3D CFG-ID
> > +         | [ COND, ... ]
>
> As written, you allow recursion of [] such as:
>
> [ [ ] ]
>
> I think you meant: [ CFG-ID, ...]

It's not just a CFG-ID list that is accepted though. [ {"not": COND1},
COND2 ] is accepted, and should mean All(Not(COND1), COND2).

I am not sure how to improve the documentation to really mean
non-empty list though.

>
>
> > +         | { 'all: [ COND, ... ] }
> > +         | { 'any: [ COND, ... ] }
> > +         | { 'not': COND }
>
> Here, the recursion makes sense: it looks like you want to permit all of
> these:
>
> 'if': { 'not': { 'any': [ 'COND1', 'COND2' ] } }
> 'if': { 'not': [ 'COND3' ] }
> 'if': { 'not': 'COND4' }
>

right

> >
> > -All definitions take an optional 'if' member.  Its value must be a
> > -string or a list of strings.  A string is shorthand for a list
> > -containing just that string.  The code generated for the definition
> > -will then be guarded by #if STRING for each STRING in the COND list.
> > +    CFG-ID =3D STRING
>
> Does CFG-ID need its own rule?  Should this rule be listed before COND?

We have a couple of prior documentation with forward references like
this (ENUM-VALUE, MEMBER, BRANCH, ALTERNATIVE, FEATURE..)

>
> > +
> > +All definitions take an optional 'if' member. Its value must be a stri=
ng, a list
> > +of strings or an object with a single member 'all', 'any' or 'not'. A =
string is
> > +shorthand for a list containing just that string. A list is a shorthan=
d for a
> > +'all'-member object. The C code generated for the definition will then=
 be guarded
> > +by an #if precessor expression.
> >
> >  Example: a conditional struct
> >
> >   { 'struct': 'IfStruct', 'data': { 'foo': 'int' },
> > -   'if': ['CONFIG_FOO', 'HAVE_BAR'] }
> > +   'if': { 'all': [ 'CONFIG_FOO', 'HAVE_BAR' ] } }
> >
> >  gets its generated code guarded like this:
> >
> > - #if defined(CONFIG_FOO)
> > - #if defined(HAVE_BAR)
> > + #if defined(CONFIG_FOO) && defined(HAVE_BAR)
> >   ... generated code ...
> > - #endif /* defined(HAVE_BAR) */
> > - #endif /* defined(CONFIG_FOO) */
> > + #endif /* defined(HAVE_BAR) && defined(CONFIG_FOO) */
> >
> >  Individual members of complex types, commands arguments, and
> >  event-specific data can also be made conditional.  This requires the
> >
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>

thanks


