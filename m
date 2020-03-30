Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AB5C2D0EF
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:41:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D840220781
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Do2sh3TO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D840220781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIyPT-0003PZ-2N
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 13:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35126)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jIyKs-0005rk-Pl
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:36:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jIyKr-0005NH-BW
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:36:30 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:54152)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jIyKr-0005Kx-6P
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585589788;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uEh8nTech1DbIs3CNP81d8RCDrSjhYU860QFo41l7EE=;
 b=Do2sh3TOruYxRUmydpSCgmhzstLx0rZRbRdR5HzlngBlU56NaJpT5SYsN/SgMsqogDzY0X
 4VenU6c8xdhHCBGaaYTubWzTLX517CJgDVJ+TJAeyZWYvm066rSfPJXhuxjj/gbOpxgrk8
 XaL48XmkT+YvyLo49b1W66gfB/Eadcw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-_QILv7ReOtSiRaKmYi3kzA-1; Mon, 30 Mar 2020 13:36:24 -0400
X-MC-Unique: _QILv7ReOtSiRaKmYi3kzA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F40E18AB2C0;
 Mon, 30 Mar 2020 17:36:23 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 762706EF9A;
 Mon, 30 Mar 2020 17:36:20 +0000 (UTC)
Date: Mon, 30 Mar 2020 18:36:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Subject: Re: deprecation of in-tree builds
Message-ID: <20200330173617.GV236854@redhat.com>
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <87v9mmug73.fsf@dusky.pond.sub.org>
 <CAFEAcA-9U=EAXAtPDh_AnO3eUbM_jcRBuf4x=0Rec0EC-v2mNA@mail.gmail.com>
 <20200330134212.GO236854@redhat.com>
 <20200330143759.GD6139@linux.fritz.box>
 <20200330172955.GQ25468@kitsune.suse.cz>
MIME-Version: 1.0
In-Reply-To: <20200330172955.GQ25468@kitsune.suse.cz>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 30, 2020 at 07:29:55PM +0200, Michal Such=C3=A1nek wrote:
> On Mon, Mar 30, 2020 at 04:37:59PM +0200, Kevin Wolf wrote:
> > Am 30.03.2020 um 15:42 hat Daniel P. Berrang=C3=A9 geschrieben:
> > > On Mon, Mar 30, 2020 at 02:31:52PM +0100, Peter Maydell wrote:
> > > > On Mon, 30 Mar 2020 at 14:26, Markus Armbruster <armbru@redhat.com>=
 wrote:
> > > > >
> > > > > Peter Maydell <peter.maydell@linaro.org> writes:
> > > > >
> > > > > > AIUI from Paolo, the intention is to deprecate and eventually
> > > > > > stop supporting "in-tree" builds, so that the only option is
> > > > > > building in a separate build directory. I thought we should
> > > > > > probably mention that in the 5.0 changelog, so I wrote up some
> > > > > > text:
> > > > > >
> > > > > > https://wiki.qemu.org/ChangeLog/5.0#Build_Information
> > > > >
> > > > > Overdue.  Thanks for doing this!
> > > > >
> > > > > > Suggestions for changes/comments etc welcome.
> > > > >
> > > > > Looks fine to me.
> > > >=20
> > > > Consensus in the thread seemed to lean towards having
> > > > the 'configure/make' runes auto-create a build directory;
> > > > if we want to do that we should probably not say anything in
> > > > the release notes, because we'll cause people to change
> > > > unnecessarily. Or at least have them say "We recommend
> > > > out-of-tree builds. In future we might make the commands
> > > > that currently do an in-tree build automatically create
> > > > and use a build directory for you." rather than a blanket
> > > > "we're going to drop this and you should change what you
> > > > do now".
> > > >=20
> > > > Thoughts?
> > >=20
> > > When the time comes to switch to Meson, we'll be forcing a
> > > separate build directory & that will also potentially involve
> > > a change in build instructions for users.
> > >=20
> > > So if we expect Meson will arrive in QEMU soon (say before end
> > > of this year), then I'd try to keep changes related to make to
> > > the bare minimum, and have Meson switch as the "flag day" when
> > > developers are forced to adapt their build process.=20
> > >=20
> > > IOW, merely warn people that in-tree builds are deprecated and
> > > not tested by the project and enourage switching to out of tree
> > > builds. Dont try to magically create a separate build dir now.
> >=20
> > If manually dealing with separate build directories is inconvenient
> > today, it will still be inconvenient with Meson, so this would mean
> > introducing the automatic directly creation together with the other
> > changes to enable Meson. Which is fine by me, as long as it is really
> > done when the external directory becomes mandatory, so that people won'=
t
> > have to switch back and forth between directories.
>=20
> From packaging point of view if something has auto* files the default is
> IIRC to do in-tree build with most package managers. You have to adjust
> manually for out-of-tree build. I am not sure what is state of Meson
> support in packaging scripts across distributions. Most likely it will
> not be picked automagically so you have to provide a custom build script
> anyway. Then it is the time to look up the canonical build instructions.

Many big projects already use Meson, including SystemD and GNOME for
example. So I'd expect all modern distros would have standard
"best practices" defined for building projects using Meson by now.

Doing an out of tree build for autotools based projects doesn't take
much adaption by distros either from what we got in terms of feedback
when libvirt made the switch to force out-of-tree.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


