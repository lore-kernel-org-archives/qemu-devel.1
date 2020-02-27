Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0C2C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 12:38:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A0A424695
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 12:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KnwIZfFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A0A424695
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7IQo-0002cu-HJ
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 07:38:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1j7IQ5-00029L-FV
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:37:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1j7IQ3-0003DW-Dz
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:37:36 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45554
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1j7IQ3-0003Ad-7T
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:37:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582807054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QBnv079Sl3q4YllPlsEhNMJkumdaxYhLR7f9IPp2GGk=;
 b=KnwIZfFT+nrs2TDZpki12zmZKP1KttbFX3L+kiyMNqq81G0wVyP9SLINJXp93w6KBAhs7t
 DPuVHJoxHZ0zlAW9YQVkozDsMeyi3Nta+6tHP+z87v/Qc8z7YURY0eWjbqgWbHMGSAxCG4
 J30HJVRKIkU92+HtthpriBytlFNcMaI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-d8WTTVgCPdaog82P8f507A-1; Thu, 27 Feb 2020 07:37:25 -0500
X-MC-Unique: d8WTTVgCPdaog82P8f507A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8235C13E6;
 Thu, 27 Feb 2020 12:37:24 +0000 (UTC)
Received: from paraplu.localdomain (unknown [10.36.118.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 21FD860BE2;
 Thu, 27 Feb 2020 12:37:24 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id 6549B3E04B9; Thu, 27 Feb 2020 13:37:22 +0100 (CET)
Date: Thu, 27 Feb 2020 13:37:22 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 14/18] docs/system: Convert qemu-cpu-models.texi to rST
Message-ID: <20200227123722.GN24572@paraplu>
References: <20200226113034.6741-1-pbonzini@redhat.com>
 <20200226113034.6741-15-pbonzini@redhat.com>
 <CAFEAcA-ps7dmo_7Lgf2kTsy0nvFgU6qopS8HvZMu3DY81VvE_g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-ps7dmo_7Lgf2kTsy0nvFgU6qopS8HvZMu3DY81VvE_g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 27, 2020 at 12:10:02PM +0000, Peter Maydell wrote:
> On Wed, 26 Feb 2020 at 11:30, Paolo Bonzini <pbonzini@redhat.com> wrote:

[...]

> >  delete mode 100644 docs/system/qemu-cpu-models.texi
>=20
> Why don't we also delete cpu-models-x86.texi and
> cpu-models-mips.texi ?

We can; will do.

> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 0d3ee8bdc6..01d1ee4b50 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -320,7 +320,7 @@ F: tests/tcg/i386/
> >  F: tests/tcg/x86_64/
> >  F: hw/i386/
> >  F: disas/i386.c
> > -F: docs/system/cpu-models-x86.texi
> > +F: docs/system/cpu-models-x86.rst
>=20
> This isn't the filename the patch actually uses.

Originally, I used:=20

    -F: docs/qemu-cpu-models.texi
    +F: docs/system/qemu-cpu-models.rst

as part of my v4, here:
https://lists.nongnu.org/archive/html/qemu-devel/2020-02/msg07165.html

But got "obsoleted" with Paolo's split of x86 & MIPS change.

> There should be a corresponding new F: line for the mips version too.

Correct; will add.

> >  qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor=
-info.texi
> >  qemu.1: docs/system/qemu-option-trace.texi
> > -docs/system/qemu-cpu-models.7: docs/system/qemu-cpu-models.texi docs/s=
ystem/cpu-models-x86.texi docs/system/cpu-models-mips.texi
> >
> >  html: qemu-doc.html docs/interop/qemu-qmp-ref.html docs/interop/qemu-g=
a-ref.html sphinxdocs
> >  info: qemu-doc.info docs/interop/qemu-qmp-ref.info docs/interop/qemu-g=
a-ref.info
>=20
> The install line for qemu-cpu-models.7 also needs updating to
> include $(MANUAL_BUILDDIR).
>=20
> The distclean line that removes qemu-cpu-models.7 can be removed.

Noted, will do.

[...]

> >  # General information about the project.
> >  project =3D u'QEMU'
> > -copyright =3D u'2019, The QEMU Project Developers'
> > +copyright =3D u'2020, The QEMU Project Developers'
> >  author =3D u'The QEMU Project Developers'
> >
> >  # The version info for the project you're documenting, acts as replace=
ment for
>=20
> We should indeed fix the copyright date, but not in the middle
> of this texi->rst series, and we should update the QEMU_COPYRIGHT
> macro in qemu-common.h at the same time.

Indeed.  A voice at the back of my head _did_ nag, "you're mashing this
unrelated change into the middle of .texi --> .rst series..."

Will make it a separate patch.

> > +
> > +rst_prolog =3D '''
> > +.. include:: defs.rst.inc
> > +'''
> > +
>=20
> Maybe we should do this in docs/conf.py where we update
> rst_epilog with the CONFDIR replacement ?

I'm ambivalent about it; can do it in docs/conf.py if you that is more
appropriate.

> Doing the "put these replacements into a generic defs.rst.inc"
> would also be clearer in its own patch, I think.

Fair enough. =20

> >  # One entry per manual page. List of tuples
> >  # (source start file, name, description, authors, manual section).
> >  man_pages =3D [
> >      ('qemu-block-drivers', 'qemu-block-drivers',
> >       u'QEMU block drivers reference',
> > -     ['Fabrice Bellard and the QEMU Project developers'], 7)
> > +     ['Fabrice Bellard and the QEMU Project Developers'], 7),
>=20
> If we want to capitalize the 'D' in Developers, we should
> make that fix in its own commit, and we should update
> the QEMU_COPYRIGHT macro too, for consistency.

I did wonder about that too; fair enough.  Will not mix it here.

> > +    ('qemu-cpu-models', 'qemu-cpu-models',
> > +     u'QEMU CPU Models',
> > +     ['The QEMU Project Developers'], 7)
> >  ]
>=20
> I would mention explicitly in the commit message that Dan agreed
> to the updating of the manpage's Author information to
> the more generic string.

Can do; I actually mentioned it in my v4 revision history, below the
"---" line
(https://lists.nongnu.org/archive/html/qemu-devel/2020-02/msg07165.html):

   - Fix author attribution as per the thread:
     Message-ID:
     <CAFEAcA8dTR6xkQnsf32HAo6aDXf5Z0UmkhL3+257KWLj1ES6Sw@mail.gmail.com>
     [danpb, pm215]
 =20
Can spell it out as part of the commit message.


In summary, to-do for v5:

  - Fix the things you pointed out in this patch here.

  - Don't mix unrelated changes with .texi --> rst conversion (undo the
    copyright year and the capitalization changes; make them separate
    patches).

  - Do the split of x86 | MIPS in a separate patch, including the change
    of moving the macros to 'defs.rst.inc'.


--=20
/kashyap


