Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6EBC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:39:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF9D32073B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9D32073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIyNH-0000Qv-S5
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 13:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <msuchanek@suse.de>) id 1jIyEb-0002t4-Uz
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:30:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <msuchanek@suse.de>) id 1jIyEa-0003cq-8J
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:30:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:43550)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <msuchanek@suse.de>) id 1jIyEZ-0003YQ-Us
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:30:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 19997AC53;
 Mon, 30 Mar 2020 17:29:57 +0000 (UTC)
Date: Mon, 30 Mar 2020 19:29:55 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: deprecation of in-tree builds
Message-ID: <20200330172955.GQ25468@kitsune.suse.cz>
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <87v9mmug73.fsf@dusky.pond.sub.org>
 <CAFEAcA-9U=EAXAtPDh_AnO3eUbM_jcRBuf4x=0Rec0EC-v2mNA@mail.gmail.com>
 <20200330134212.GO236854@redhat.com>
 <20200330143759.GD6139@linux.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20200330143759.GD6139@linux.fritz.box>
User-Agent: Mutt/1.10.1 (2018-07-13)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic]
X-Received-From: 195.135.220.15
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
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 30, 2020 at 04:37:59PM +0200, Kevin Wolf wrote:
> Am 30.03.2020 um 15:42 hat Daniel P. Berrang=E9 geschrieben:
> > On Mon, Mar 30, 2020 at 02:31:52PM +0100, Peter Maydell wrote:
> > > On Mon, 30 Mar 2020 at 14:26, Markus Armbruster <armbru@redhat.com>=
 wrote:
> > > >
> > > > Peter Maydell <peter.maydell@linaro.org> writes:
> > > >
> > > > > AIUI from Paolo, the intention is to deprecate and eventually
> > > > > stop supporting "in-tree" builds, so that the only option is
> > > > > building in a separate build directory. I thought we should
> > > > > probably mention that in the 5.0 changelog, so I wrote up some
> > > > > text:
> > > > >
> > > > > https://wiki.qemu.org/ChangeLog/5.0#Build_Information
> > > >
> > > > Overdue.  Thanks for doing this!
> > > >
> > > > > Suggestions for changes/comments etc welcome.
> > > >
> > > > Looks fine to me.
> > >=20
> > > Consensus in the thread seemed to lean towards having
> > > the 'configure/make' runes auto-create a build directory;
> > > if we want to do that we should probably not say anything in
> > > the release notes, because we'll cause people to change
> > > unnecessarily. Or at least have them say "We recommend
> > > out-of-tree builds. In future we might make the commands
> > > that currently do an in-tree build automatically create
> > > and use a build directory for you." rather than a blanket
> > > "we're going to drop this and you should change what you
> > > do now".
> > >=20
> > > Thoughts?
> >=20
> > When the time comes to switch to Meson, we'll be forcing a
> > separate build directory & that will also potentially involve
> > a change in build instructions for users.
> >=20
> > So if we expect Meson will arrive in QEMU soon (say before end
> > of this year), then I'd try to keep changes related to make to
> > the bare minimum, and have Meson switch as the "flag day" when
> > developers are forced to adapt their build process.=20
> >=20
> > IOW, merely warn people that in-tree builds are deprecated and
> > not tested by the project and enourage switching to out of tree
> > builds. Dont try to magically create a separate build dir now.
>=20
> If manually dealing with separate build directories is inconvenient
> today, it will still be inconvenient with Meson, so this would mean
> introducing the automatic directly creation together with the other
> changes to enable Meson. Which is fine by me, as long as it is really
> done when the external directory becomes mandatory, so that people won'=
t
> have to switch back and forth between directories.

From packaging point of view if something has auto* files the default is
IIRC to do in-tree build with most package managers. You have to adjust
manually for out-of-tree build. I am not sure what is state of Meson
support in packaging scripts across distributions. Most likely it will
not be picked automagically so you have to provide a custom build script
anyway. Then it is the time to look up the canonical build instructions.

In other words dealing with Meson is inconvenient either way. Building
in-tree or out-of-tree becomes a non-issue whan you switch to exotic
build system anyway.

That's not to say that auto* tools are great. It's just the replacements
have issues that are not well understood by average Joe Packager while
the auto* tools have good old issues people know how to deal with.

Thanks

Michal

