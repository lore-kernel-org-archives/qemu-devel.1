Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC785C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:51:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B54F620848
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+pS1U55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54F620848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJGMt-0003pl-TH
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 08:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jJGLx-00037g-00
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:50:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jJGLv-0006Ic-7n
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:50:48 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56090)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jJGLv-0006GK-3A
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585659046;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y+zUShfY8sm7nh64iY4wbXGsp0+5zUI0w/JJ+ivrcVQ=;
 b=R+pS1U553p7IeGjDlhIIRdYXRuhvqTHdAxQLDYA98KxvT141h7QD7Op1zDSmjSiVDXQCVF
 c0mQbkW8SqUI4qHGeDtT9dN6V0uFWTSwftymZWsGzt5fnjcgS0Txfr8MfXjt+eyi6HpM/9
 NuKQSAMJ0kZetAn+mkYsahghj96qsXQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-9EUYSD-jMzagA6NVwN8_3Q-1; Tue, 31 Mar 2020 08:50:44 -0400
X-MC-Unique: 9EUYSD-jMzagA6NVwN8_3Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0054DBF1;
 Tue, 31 Mar 2020 12:50:35 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BA45E96B72;
 Tue, 31 Mar 2020 12:50:33 +0000 (UTC)
Date: Tue, 31 Mar 2020 13:50:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: deprecation of in-tree builds
Message-ID: <20200331125030.GG353752@redhat.com>
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <87v9mmug73.fsf@dusky.pond.sub.org>
 <CAFEAcA-9U=EAXAtPDh_AnO3eUbM_jcRBuf4x=0Rec0EC-v2mNA@mail.gmail.com>
 <875zel5722.fsf@dusky.pond.sub.org>
 <alpine.BSF.2.22.395.2003311417190.73689@zero.eik.bme.hu>
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2003311417190.73689@zero.eik.bme.hu>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 31, 2020 at 02:33:46PM +0200, BALATON Zoltan wrote:
> > We will have to ask developers to change habits anyway when we switch t=
o
> > Meson.  I agree with Daniel's recommendation to delay changes requiring
> > habit-changes until then.  However, telling people to stay clear of the
> > unloved and brittle in-tree build is simply good advice we should not
> > withhold.
>=20
> Can someone please explain why is it brittle and cannot be supported? It =
has
> worked well so far apart from some breakage due to being untested which i=
s
> also not a techincal necessity just a decision by some maintiners to not
> test it. Adding a CI job to keep it working would also not be difficult o=
r
> much complexity.

Writing make rules to correctly handle both src-dir and build-dir scenarios
is a non-negligible maint burden. If you look back through QEMU's history
we have a steady stream of patches which have broken one or the other
build scenarios.

Developers will often not test both scenarios, just the one they prefer
to use. This results in a maint burden on the subsystem maintainers who
merge patches and then find they break & have to back them out. Sometimes
even the subsystem maintainer gets it wrong and burden falls on Peter to
find & reject it.

Even if we have CI to test both, it is still a burden on developers to
debug failures reported by the CI and figure out what needs fixing. With
the number of builds we do & the time for a single CI cycle it gets very
time consuming. I've personally wasted many many hours debugging src-dir
vs build-dir problems in QEMU's makefiles - probably more than an entire
day was lost when I did the patches to split the trace.h header file.

This all serves to divert time away from useful work on QEMU. If there
was some critically important functional thing that src-dir builds offer
that can't be achieved by build-dir builds, then the extra maint work
could be justified. I don't think that's the case though.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


