Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227E5C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:36:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E23D72082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/hwUPgf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23D72082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iydmF-0007Gv-4M
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 10:36:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iydlF-0006FE-0o
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:35:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iydlD-0007Y7-Ik
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:35:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21737
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iydlD-0007XW-Dl
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:35:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580744139;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FCrSyAhnuqqQGKyXRNhmX6Y75icbCOIAQotR7K1jyd4=;
 b=e/hwUPgfns1Sr/4tOGGREcTayQs5FQIhiyEpuXJA82ctWbcGm9YdMY1gZyvBnRXNygudu4
 OQCahy9SW+8LmdPvb6Ce915mJSqiROgVKij82YMbGMlyqd3YodVYxcZG4ihzTOmWSCvA9r
 I6KhTW7y4AP6QOYmUCtg9hafLyKQpTI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-acgi9qQUOzel5v3HmVmGaA-1; Mon, 03 Feb 2020 10:35:13 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DEF5113786F;
 Mon,  3 Feb 2020 15:35:12 +0000 (UTC)
Received: from redhat.com (ovpn-112-57.ams2.redhat.com [10.36.112.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B4CE110018FF;
 Mon,  3 Feb 2020 15:35:10 +0000 (UTC)
Date: Mon, 3 Feb 2020 15:35:07 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/13] qtests, kconfig and misc patches
Message-ID: <20200203153507.GJ1922177@redhat.com>
References: <20200203123811.8651-1-thuth@redhat.com>
 <CAFEAcA_1KYRA=87k34zCRLqCf1tWHrULGZPcHeKwJZhDUx0=kw@mail.gmail.com>
 <2fd63018-b9f9-ab88-2d65-009c54bb6cf2@redhat.com>
 <CAFEAcA_XKAeT10p+XNRjQeOjoGYX1Q-D+kj9E0kFx2AxtktACg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_XKAeT10p+XNRjQeOjoGYX1Q-D+kj9E0kFx2AxtktACg@mail.gmail.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: acgi9qQUOzel5v3HmVmGaA-1
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 03, 2020 at 02:50:07PM +0000, Peter Maydell wrote:
> On Mon, 3 Feb 2020 at 14:30, Thomas Huth <thuth@redhat.com> wrote:
> >
> > On 03/02/2020 15.04, Peter Maydell wrote:
> > > On Mon, 3 Feb 2020 at 12:38, Thomas Huth <thuth@redhat.com> wrote:
> > >>
> > >>  Hi Peter,
> > >>
> > >> the following changes since commit 28db64fce555a03b4ca256d5b6f4290ab=
dfbd9e8:
> > >>
> > >>   Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-r=
equest' into staging (2020-01-31 17:37:00 +0000)
> > >>
> > >> are available in the Git repository at:
> > >>
> > >>   https://gitlab.com/huth/qemu.git tags/pull-request-2020-02-03
> > >>
> > >> for you to fetch changes up to 585c138628bbf22ea8e740b2f4f1a3ed0274e=
be8:
> > >>
> > >>   trivial: Remove xenfb_enabled from sysemu.h (2020-02-03 10:33:57 +=
0100)
> > >>
> > >> ----------------------------------------------------------------
> > >> * Current qtests queue
> > >> * Some Kconfig updates
> > >> * Some trivial clean-ups here and there
> > >> ----------------------------------------------------------------
> > >
> > > All the incremental rebuilds failed:
> > >
> > > Linux cam-vm-266 4.15.0-70-generic x86_64
> > > From git://git-us.linaro.org/people/pmaydell/qemu-arm
> > >    f31160c7d1..f9e931a1d9  staging    -> pmaydell/staging
> > > make: Entering directory '/home/petmay01/qemu-for-merges/build/w64'
> > > make[1]: Entering directory '/home/petmay01/qemu-for-merges/slirp'
> > > make[1]: Nothing to be done for 'all'.
> > > make[1]: Leaving directory '/home/petmay01/qemu-for-merges/slirp'
> > >   CC      qga/main.o
> > >   CC      stubs/machine-init-done.o
> > >   CC      stubs/replay-user.o
> > >   CC      stubs/semihost.o
> > >   CC      qemu-img.o
> > >   CC      qemu-io.o
> > >   CC      chardev/char.o
> > > make: *** No rule to make target
> > > '/home/petmay01/qemu-for-merges/hw/bt/Kconfig', needed by
> > > 'aarch64-softmmu/config-devices.mak'.  Stop.
> > > make: *** Waiting for unfinished jobs....
> > >   CC      chardev/char-mux.o
> > > make: Leaving directory '/home/petmay01/qemu-for-merges/build/w64'
> >
> > Oh, they are still failing??? Why are there still references to
> > hw/bt/Kconfig in these config-devices.mak files, I'd expect that they
> > would have been regenerated at least once during the past week?
>=20
> build/all/aarch64-softmmu/config-devices.mak.d was most recently
> touched this morning, and it still includes hw/bt/Kconfig in its
> dependency list. I think this is because minikconf will still put
> a Kconfig file into the .d file it generates even if the Kconfig
> file happens to be empty.
>=20
> And make doesn't have any rules that tell it that config-devices.mak.d
> need to be updated either:
> $ make -C build/all -n aarch64-softmmu/config-devices.mak.d
> make: Entering directory '/home/petmay01/linaro/qemu-for-merges/build/all=
'
> make[1]: Entering directory '/home/petmay01/linaro/qemu-for-merges/slirp'
> make[1]: Nothing to be done for 'all'.
> make[1]: Leaving directory '/home/petmay01/linaro/qemu-for-merges/slirp'
> make: Nothing to be done for 'aarch64-softmmu/config-devices.mak.d'.
> make: Leaving directory '/home/petmay01/linaro/qemu-for-merges/build/all'
>=20
> or that it needs to rerun minikconf, which would update the .mak.d.
>=20
> An extremely cheesy workaround would be if the commit which
> removes the hw/bt/Kconfig also touches configure; then Make
> will know it needs to rerun configure, which will (among
> other things) blow away all the config-devices.mak.d and
> force rerunning of minikconf.
>=20
> I don't know what the correct additional makefile magic
> would be that would cause us to automatically get deletion
> of a Kconfig file right; maybe Paolo does?

I guess this would need some munging of config-host.mak rule in the
Makefile. config-host.mak would need to depend on something which
scan for references to deleted Kconfig files, and then forces a re-run
of config.status in some manner. Don't know how we'd write such a
beast off hand though.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


