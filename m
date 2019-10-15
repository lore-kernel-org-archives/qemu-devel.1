Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A00FC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 09:15:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF67D20659
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 09:15:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF67D20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKIve-0005rh-1W
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 05:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35849)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iKIut-0005Jy-0w
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 05:14:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iKIup-0006xL-M8
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 05:14:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56950)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iKIup-0006wk-DH
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 05:14:51 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9B52F308212D;
 Tue, 15 Oct 2019 09:14:49 +0000 (UTC)
Received: from redhat.com (ovpn-112-30.ams2.redhat.com [10.36.112.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C4CC419C68;
 Tue, 15 Oct 2019 09:14:47 +0000 (UTC)
Date: Tue, 15 Oct 2019 10:14:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: RFC: Why dont we move to newer capstone?
Message-ID: <20191015091444.GE22859@redhat.com>
References: <CALvKS=E-t1c+BVDn=0RbM8nBry8GcYOXh-PrziQO7XhS7W2NUw@mail.gmail.com>
 <CALvKS=GB1-zDnkKxei6Dn5MNyr5kwj+vEtD_3MZyVNfzqQuRZg@mail.gmail.com>
 <CAFEAcA-gLHm0D6vR0Rvpbi_bbVWpKspvm8YLSVPHpCVP6HmDUg@mail.gmail.com>
 <20191015082708.GB22859@redhat.com>
 <0a4262f8-df07-e83e-0928-b6cf4e12800d@redhat.com>
 <20191015084722.GD22859@redhat.com>
 <CAJ+F1CJACARosH6agtDQoyo6VoubYfrRm5z6DpiiV+fdw0U8aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJACARosH6agtDQoyo6VoubYfrRm5z6DpiiV+fdw0U8aQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 15 Oct 2019 09:14:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 15, 2019 at 11:02:43AM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Tue, Oct 15, 2019 at 10:48 AM Daniel P. Berrang=C3=A9 <berrange@redh=
at.com> wrote:
> >
> > On Tue, Oct 15, 2019 at 10:36:40AM +0200, Thomas Huth wrote:
> > > On 15/10/2019 10.27, Daniel P. Berrang=C3=A9 wrote:
> > > > On Sat, Oct 05, 2019 at 02:33:34PM +0100, Peter Maydell wrote:
> > > >> On Sat, 5 Oct 2019 at 11:21, Lucien Murray-Pitts
> > > >> <lucienmp.qemu@gmail.com> wrote:
> > > >>> Whilst working on a m68k patch I noticed that the capstone in u=
se
> > > >>> today (3.0) doesnt support the M68K and thus a hand turned disa=
sm
> > > >>> function is used.
> > > >>>
> > > >>> The newer capstone (5.0) appears to support a few more CPU, inc=
. m68k.
> > > >>>
> > > >>> Why we move to this newer capstone?
> > > >>
> > > >> Moving to a newer capstone sounds like a good idea. The only
> > > >> reason we haven't moved forward as far as I'm aware is that
> > > >> nobody has done the work to send a patch to do that move
> > > >> forward to the newer version. Richard Henderson would
> > > >> probably know if there was any other blocker.
> > > >
> > > > Bearing in mind our distro support policy, we need to continue to
> > > > support 3.0 series of capstone for a while yet based on what I
> > > > see in various distros. eg Ubuntu 18.04 LTS has 3.0.4, as does
> > > > Fedora 29.  Version 4.0 is only in a few very new distros:
> > > >
> > > >    https://repology.org/project/capstone/versions
> > > >
> > > > We can of course use features from newer capstone, *provided* we =
correctly
> > > > do conditional compilation so that we can still build against 3.0=
 series
> > > > on distros that have that version.
> > >
> > > We're embedding the capstone submodule in the release tarballs, so =
I
> > > think we're independent from the distro release, aren't we? So this
> > > should not be an issue, as far as I can see.
> >
> > It is an issue for people/distros who don't want to building with bun=
dled
> > 3rd party code.
> >
> > I'd suggest it is probably time we could drop the capstone git submod=
ule.
> > We originally added it because capstone wasn't widely present in dist=
ros
> > we care about. AFAICT, it is now present in all the distros, so could=
 be
> > treated the same way as any other 3rd party library dep we have.
>=20
> I suppose the same applies to dtc (1.4.2 required by qemu, but xenial
> has 1.4.0... so we have to wait until April 26, 2020? 18.04 LTS
> release date + 2y).

Possibly - depends on scope of changes between 1.4.0 & 1.4.2 - maybe it
is easy to conditionally support 1.4.0 too.

> libslirp will take even longer.

This is reasonable as a git submodule for a while yet, since it only
existed as a separate project very recently, so isn't widely available
across distros / OS.

IMHO the key point is that submodules bundling 3rd party libraries [1]
should be viewed as something with a limited lifetime. A temporary
hack until distros have the library widely available, rather than
something which continues forever.

Regards,
Daniel

[1] We have other types of submodule.

    The keycodemapdb which is not a library, rather a static database
    from which we auto-generate code to statically link in.

    The firmware submodules which developers don't actually build from
    normally. Ideally these would go into a separate dist tarball but
    we seem stalled on this idea despite discussing it many times.
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

