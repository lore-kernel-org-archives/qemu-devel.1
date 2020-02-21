Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66032C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 15:33:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 315712073A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 15:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ABDIYDAJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315712073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5AIl-0003M3-Ak
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 10:33:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1j5AH5-00021z-2u
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:31:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1j5AH3-0003Mv-F8
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:31:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37217
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1j5AH3-0003Mb-9H
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:31:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582299088;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=20R+WSR0ZYgu7ZUAmP/0knWdgPrRar0bFbexZBMj4kc=;
 b=ABDIYDAJXAr8TLceupsSwhsxlyXIF47EOqLex+GHqHu3Ez8vdBLsy6QebMvDFwlyWyO1Ci
 kMeKiSGeNmbfWO4tPrGnVEnMY6QoZZYCjYIfrFeBY3xgMztopz5c8rHT3deXcOkrKOiiRz
 N5KSuVA151UzQcHxSXtVllZuwXPtJ9s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-nsrA7cX8PqSsWyO5WMcQXA-1; Fri, 21 Feb 2020 10:31:22 -0500
X-MC-Unique: nsrA7cX8PqSsWyO5WMcQXA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC258800D5C;
 Fri, 21 Feb 2020 15:31:20 +0000 (UTC)
Received: from redhat.com (ovpn-112-58.ams2.redhat.com [10.36.112.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0AF4C790CF;
 Fri, 21 Feb 2020 15:31:18 +0000 (UTC)
Date: Fri, 21 Feb 2020 15:31:15 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 1/2] docs: Convert qemu-cpu-models.texi to rST
Message-ID: <20200221153115.GG628613@redhat.com>
References: <20200220142001.20774-1-kchamart@redhat.com>
 <20200220142001.20774-2-kchamart@redhat.com>
 <CAFEAcA9_tDWLxBrsw42uxs7E_QmA5XzsMs6zwmzpckv=B0ksuw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9_tDWLxBrsw42uxs7E_QmA5XzsMs6zwmzpckv=B0ksuw@mail.gmail.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 21, 2020 at 03:16:29PM +0000, Peter Maydell wrote:
> On Thu, 20 Feb 2020 at 14:20, Kashyap Chamarthy <kchamart@redhat.com> wro=
te:
> >
> > This doc was originally written by Daniel P. Berrang=C3=A9
> > <berrange@redhat.com>, introduced via commit[1]: 2544e9e4aa (docs: add
> > guidance on configuring CPU models for x86, 2018-06-27).
> >
> > In this patch:
> >
> >   - 1-1 conversion of Texinfo to rST, besides a couple of minor
> >     tweaks that are too trivial to mention.   (Thanks to Stephen
> >     Finucane on IRC for the suggestion to use rST "definition lists"
> >     instead of bullets in some places.)
> >
> >     Further modifications will be done via a separate patch.
> >
> >   - rST and related infra changes: for building the manual page,
> >     Makefile fixes, clean up references to qemu-cpu-models.texi, etc.
> >
> > [1] https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D2544e9e4aa
> >
> > Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> > ---
> > v2: Fix rST conversion, man page creation, Makefile changes, et al
> >     (thanks, Peter Maydell)
> > ---
> >  MAINTAINERS                     |   2 +-
> >  Makefile                        |  10 +-
> >  docs/qemu-cpu-models.texi       | 677 --------------------------------
> >  docs/system/conf.py             |   3 +
> >  docs/system/index.rst           |   1 +
> >  docs/system/qemu-cpu-models.rst | 514 ++++++++++++++++++++++++
> >  qemu-doc.texi                   |   5 -
> >  7 files changed, 524 insertions(+), 688 deletions(-)
> >  delete mode 100644 docs/qemu-cpu-models.texi
> >  create mode 100644 docs/system/qemu-cpu-models.rst
>=20
> > @@ -1056,6 +1055,8 @@ $(call define-manpage-rule,interop,\
> >
> >  $(call define-manpage-rule,system,qemu-block-drivers.7)
> >
> > +$(call define-manpage-rule,system,qemu-cpu-models.7)
>=20
> The new manpage should be added to the existing define-manpage-rule
> invocation for the system manual: the last argument is a space
> separated list of all the manpages in the manual, like this:
>=20
> $(call define-manpage-rule,system,qemu-block-drivers.7 qemu-cpu-models.7)
>=20
> > +
> >  $(MANUAL_BUILDDIR)/index.html: $(SRC_PATH)/docs/index.html.in qemu-ver=
sion.h
> >         @mkdir -p "$(MANUAL_BUILDDIR)"
> >         $(call quiet-command, sed "s|@@VERSION@@|${VERSION}|g" $< >$@, =
\
>=20
>=20
>=20
> > -@c man begin AUTHOR
> > -Daniel P. Berrange
> > -@c man end
>=20
> > diff --git a/docs/system/conf.py b/docs/system/conf.py
> > index 7ca115f5e0..7cc9da9508 100644
> > --- a/docs/system/conf.py
> > +++ b/docs/system/conf.py
> > @@ -18,5 +18,8 @@ html_theme_options['description'] =3D u'System Emulat=
ion User''s Guide'
> >  man_pages =3D [
> >      ('qemu-block-drivers', 'qemu-block-drivers',
> >       u'QEMU block drivers reference',
> > +     ['Fabrice Bellard and the QEMU Project developers'], 7),
> > +    ('qemu-cpu-models', 'qemu-cpu-models',
> > +     u'QEMU CPU Models',
> >       ['Fabrice Bellard and the QEMU Project developers'], 7)
> >  ]
>=20
> The old manpage/documentation credits Dan as the author,
> so that's what we should specify in the conf.py line,
> rather than 'Fabrice and the project devs' (which we
> use for qemu-block-drivers.7 because that's what the
> old texi version of that file specified as the authors).

I agree that listing Fabrice explicitly here is wrong
since he didn't write any of it.

As the author, I don't feel a need for my name to be
explicitly credited here. QEMU is a collaborative project
and other people add text to this over time. Indeed IME
explicitly listing an individual  encourages users to
directly email the individual person with questions,
instead of using the mailing list / irc / forums.

Thus I would personally prefer if we just used

  "The QEMU Project maintainers"

as the author credit

> > +Preferred CPU models for Intel x86 hosts
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +The following CPU models are preferred for use on Intel hosts.
> > +Administrators / applications are recommended to use the CPU model tha=
t
> > +matches the generation of the host CPUs in use. In a deployment with a
> > +mixture of host CPU models between machines, if live migration
> > +compatibility is required, use the newest CPU model that is compatible
> > +across all desired hosts.
> > +
> > +* Intel Xeon Processor (Skylake, 2016)
> > +
> > +  * ``Skylake-Server``
> > +  * ``Skylake-Server-IBRS``
>=20
> This reverses the old ordering of these lists, which consistently
> had the QEMU CPU model names as the 'term' and the explanations
> as the 'definition' of a definition-list. Now we have the
> 'explanation' first and the 'terms' second...

Yep, the model name used for the "-cpu NAME" arg is the most
important piece of information IMHO. The human description is
just a side note.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


