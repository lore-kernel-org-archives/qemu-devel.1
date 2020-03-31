Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD8DC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:25:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE0E720786
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ea/WlqND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0E720786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJIm2-0006qa-4b
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 11:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jJIjp-0002ys-Ap
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:23:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jJIjn-0000Ha-O1
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:23:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23846
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jJIjn-0000HC-JJ
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585668214;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VglqoRtGPR0weetMfVtNTnlZvDLhaBfnL0EacWzlFcE=;
 b=Ea/WlqNDBzjlhB6vl2vWOg0U2dDtfb8fG1vJcYaAvSiSytA/fpLPfdsV4OIRIZMD+YCUY6
 BM7zXSb3SppwQRGC/ACUTWk0sSCwufyVlUrWl2WQ+BVGoJh7Vrn/eqacQRBg093y8Juqbc
 neFbm4Aa8e3g5Dtq9fVVVQIobiINW+4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-DuObAZinNDax4JcWBlyY5Q-1; Tue, 31 Mar 2020 11:23:23 -0400
X-MC-Unique: DuObAZinNDax4JcWBlyY5Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7403013F7;
 Tue, 31 Mar 2020 15:23:22 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B33593534;
 Tue, 31 Mar 2020 15:23:20 +0000 (UTC)
Date: Tue, 31 Mar 2020 16:23:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: deprecation of in-tree builds
Message-ID: <20200331152317.GL353752@redhat.com>
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <87v9mmug73.fsf@dusky.pond.sub.org>
 <CAFEAcA-9U=EAXAtPDh_AnO3eUbM_jcRBuf4x=0Rec0EC-v2mNA@mail.gmail.com>
 <875zel5722.fsf@dusky.pond.sub.org>
 <alpine.BSF.2.22.395.2003311417190.73689@zero.eik.bme.hu>
 <20200331125030.GG353752@redhat.com>
 <alpine.BSF.2.22.395.2003311632270.73689@zero.eik.bme.hu>
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2003311632270.73689@zero.eik.bme.hu>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 31, 2020 at 05:04:16PM +0200, BALATON Zoltan wrote:
> On Tue, 31 Mar 2020, Daniel P. Berrang=C3=A9 wrote:
> > On Tue, Mar 31, 2020 at 02:33:46PM +0200, BALATON Zoltan wrote:
> > > > We will have to ask developers to change habits anyway when we swit=
ch to
> > > > Meson.  I agree with Daniel's recommendation to delay changes requi=
ring
> > > > habit-changes until then.  However, telling people to stay clear of=
 the
> > > > unloved and brittle in-tree build is simply good advice we should n=
ot
> > > > withhold.
> > >=20
> > > Can someone please explain why is it brittle and cannot be supported?=
 It has
> > > worked well so far apart from some breakage due to being untested whi=
ch is
> > > also not a techincal necessity just a decision by some maintiners to =
not
> > > test it. Adding a CI job to keep it working would also not be difficu=
lt or
> > > much complexity.
> >=20
> > Writing make rules to correctly handle both src-dir and build-dir scena=
rios
> > is a non-negligible maint burden. If you look back through QEMU's histo=
ry
> > we have a steady stream of patches which have broken one or the other
> > build scenarios.
>=20
> That's probably becuase there are no clear rules (such as always prefix
> files in source dir with $(SRC_PATH), generated files with some BUILDDIR,
> etc.) and these are not documented so every time someone touches it has t=
o
> explore and debug it again. This could be avoided if these were written d=
own
> once but instead of trying to document and clean up the build system the
> chosen direction is to just throw it out and replace it with something mo=
re
> complex and with more dependencies (Meson) and then to save "additional
> complexity" it also breaks people's workflow and demand them to adapt
> themselves. I'm not saying there should be no changes but if there's a wa=
y
> to make them less painful it could be considered if it's not much extra w=
ork
> and in this case it does not seem to be.

I did indeed write the docs on QEMU's build system found in
docs/devel/build-system.txt  but it is not enough to eliminate
the maint burden of supporting both. QEMU's makefiles are just
too complex and full of unexpected effects to make it easy to
support both srcdir & builddir IMHO.

> > Developers will often not test both scenarios, just the one they prefer
> > to use. This results in a maint burden on the subsystem maintainers who
> > merge patches and then find they break & have to back them out. Sometim=
es
> > even the subsystem maintainer gets it wrong and burden falls on Peter t=
o
> > find & reject it.
> >=20
> > Even if we have CI to test both, it is still a burden on developers to
> > debug failures reported by the CI and figure out what needs fixing. Wit=
h
> > the number of builds we do & the time for a single CI cycle it gets ver=
y
> > time consuming. I've personally wasted many many hours debugging src-di=
r
> > vs build-dir problems in QEMU's makefiles - probably more than an entir=
e
> > day was lost when I did the patches to split the trace.h header file.
> >=20
> > This all serves to divert time away from useful work on QEMU. If there
> > was some critically important functional thing that src-dir builds offe=
r
> > that can't be achieved by build-dir builds, then the extra maint work
> > could be justified. I don't think that's the case though.
>=20
> OK, so then only supporting out-of-tree builds but adding convenience
> function and Makefile to still allow people to run configure; make from
> source dir would solve this without also needing people to change what th=
ey
> always did so why is that solution not acceptable?

There's several scenarios discussed. Currently we don't do anything to
prevent src-dir builds, so there's no need to extra make magic described
I proposed a patch to add a warning, but it still allows src-dir builds,
so nothing functional has changed.

We could forbid src-dir builds now and add the magic to redirct to a
build-dir. That would work, but I don't think we should block src-dir
builds in make, assuming we have a switch to meson arriving in the
near-ish future.

Once we switch to Meson there will inevitably be some disruption in
build system ussage as it is a completely new tool. That makes it a
good flag day for forbidding src-dir builds. Given that it is a flag
day, I don't think there's any need to create makefile magic at that
time.


IMHO we shouldn't be so afraid of change that we need to try to preserve
every precise way of working we've had in the past. In the long term this
frame of mind holds back the project and promotes a negative impression
of QEMU as an old, outdated project resistant to any kind of change.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


