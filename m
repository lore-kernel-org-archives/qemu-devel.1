Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A401C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 09:17:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0193C218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 09:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fGA5+F20"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0193C218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6WLa-00029W-4E
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 04:17:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1j6WKH-0001NF-DE
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:16:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1j6WKF-0003d8-FI
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:16:24 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30369
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1j6WKF-0003cl-9z
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:16:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582622182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BzD+Ed0wtNrwv4nNWW/7jcUHVb/XdPkOFyMTny7i9rg=;
 b=fGA5+F20OktxszVTa36HZXFtp3kJMwmNGGa3qlhwUQuO1gE9csOzdI6eBrlLymePd936un
 oY2RD3YdhMOkaRo7UrRhakAmTVK7LOJXiCRzScJ7jnFdjrc/IzvVQjqAU1hQBwoRYLyOzZ
 Z1YRcs4GH43hBkJuEvlGkg0XQCfdN9E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-oPC5FVDKMAS-206B4lJ2xQ-1; Tue, 25 Feb 2020 04:16:15 -0500
X-MC-Unique: oPC5FVDKMAS-206B4lJ2xQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 270D6107ACC5;
 Tue, 25 Feb 2020 09:16:14 +0000 (UTC)
Received: from paraplu.localdomain (unknown [10.36.118.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AAF9F8C069;
 Tue, 25 Feb 2020 09:16:13 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id A2F463E04FA; Tue, 25 Feb 2020 10:16:11 +0100 (CET)
Date: Tue, 25 Feb 2020 10:16:11 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 1/2] docs: Convert qemu-cpu-models.texi to rST
Message-ID: <20200225091611.GF24572@paraplu>
References: <20200220142001.20774-1-kchamart@redhat.com>
 <20200220142001.20774-2-kchamart@redhat.com>
 <CAFEAcA9_tDWLxBrsw42uxs7E_QmA5XzsMs6zwmzpckv=B0ksuw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9_tDWLxBrsw42uxs7E_QmA5XzsMs6zwmzpckv=B0ksuw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 21, 2020 at 03:16:29PM +0000, Peter Maydell wrote:
> On Thu, 20 Feb 2020 at 14:20, Kashyap Chamarthy <kchamart@redhat.com> wro=
te:

[...]

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

Ah, will fix.

[...]

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

Yeah, I first felt strange adding "Fabrice and the QEMU Project
developers".  But as you've guessed I just picked what you used for
'qemu-block-drivers.7'.  That's why I mentioned Dan and his original
commit ID in my commit message, for clear posterity.

As Dan says in his follow-up, a file indeed usually gets modified over
time.  And given the follow-up interaction between you and Dan, in the
next iteration, I'll change it to: "The QEMU Project developers".

(While I agree that we should be careful to not mix attribution changes
with the noise of rST conversion, maybe in this case a seperate commit
is an overkill; hope it is okay if I call it out in the commit message.)

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

Yeah, as you guessed, I was trying to wrangle with rST syntax.

> > +* AMD EPYC Processor (2017)
> > +
> > +  * ``EPYC``
> > +  * ``EPYC-IBPB``
> > +
> > +* ``Opteron_G5`` =E2=80=93 AMD Opteron 63xx class CPU (2012)
> > +
> > +* ``Opteron_G4`` =E2=80=93 AMD Opteron 62xx class CPU (2011)
> > +
> > +* ``Opteron_G3`` =E2=80=93 AMD Opteron 23xx (Gen 3 Class Opteron, 2009=
)
> > +
> > +* ``Opteron_G2`` =E2=80=93 AMD Opteron 22xx (Gen 2 Class Opteron, 2006=
)
> > +
> > +* ``Opteron_G1`` =E2=80=93 AMD Opteron 240 (Gen 1 Class Opteron, 2004)
>=20
> ...but here we become inconsistent, switching back to
> term first and explanation second. I think the
> term-first approach of the original texi makes more sense,
> as we're trying to document the behaviour of the various
> CPU models QEMU supports.

True, I'll stick with the term-first approach, and get rid of the
inconsistency.

> rST is not a fan of having multiple definition list items
> sharing a definition, which is probably why you ended up with
> the list approach you did, but we can do:
>=20
> ``Skylake-Server``, ``Skylake-Server-IBRS``
>     Intel Xeon Processor (Skylake, 2016)
>=20
> ``Skylake-Client``, ``Skylake-Client-IBRS``
>     Intel Core Processor (Skylake, 2015)
>=20
> Or we can actually document what the difference is between
> a "Skylake-Server" and a "Skylake-Server-IBRS", rather than
> leaving the user to guess :-), in which case we could write

> ``Skylake-Server``
>     Intel Xeon Processor (Skylake, 2016)
> ``Skylake-Server-IBRS``
>     Like ``Skylake-Server`` but with extra magic
>=20
> (or whatever the difference is...)

(The difference is the -IBRS models have 'spec-ctrl' CPU flag baked in.)

And yes, I like the latter approach =E2=80=94 explicitly spelling it out re=
duces
cogntive load for the readers.

> Regardless of how we format this, we should be consistent
> in using the same format throughout the document.

Agree, will fix.  Thanks for the eagle eyes, as usual. :-)

[...]


--=20
/kashyap


