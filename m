Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0E9C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 14:05:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8618420724
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 14:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i36o6/gA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8618420724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1sdT-0003Mt-Om
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 09:05:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1j1scp-0002lt-G5
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 09:04:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1j1scn-0006YO-1j
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 09:04:22 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40927
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1j1scm-0006XU-LV
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 09:04:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581516259;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HaFkpOgF3bOIdg32DdRjM5fPSOiyLYZHxLe/MZo1SrU=;
 b=i36o6/gA5r9Ccfmit/ejo1pV3l8euOwUDUywrnlypeHq9m97v6EDP2FlhWNHCGsUkrA2cm
 gUxhRp1yRPLOb+rdkMVNxUJjd7J72f46ZB4ZuPtOR9mNuPbEAlmlZAIfM+wbgIap+90Ok6
 SevCi0r2d3tvxYpNhUfKmaQUFOVCPsg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-IBclvqRzOt-zJQWFOScBbA-1; Wed, 12 Feb 2020 09:04:08 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68B79A09A2;
 Wed, 12 Feb 2020 14:04:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F7888AC29;
 Wed, 12 Feb 2020 14:03:59 +0000 (UTC)
Date: Wed, 12 Feb 2020 14:03:57 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: Summary of Re: Making QEMU easier for management tools and
 applications
Message-ID: <20200212140357.GB434563@redhat.com>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <875zgm2vqv.fsf@dusky.pond.sub.org>
 <CAJSP0QWCn_vv2Vs-UWc9nPHjdBQq9KMkiQ7D91+RwHM_okTzZw@mail.gmail.com>
 <87ftfio0ke.fsf@dusky.pond.sub.org>
 <20200212135442.GB432724@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200212135442.GB432724@stefanha-x1.localdomain>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: IBclvqRzOt-zJQWFOScBbA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-devel <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 12, 2020 at 01:54:42PM +0000, Stefan Hajnoczi wrote:
> On Mon, Feb 10, 2020 at 05:43:13PM +0100, Markus Armbruster wrote:
> > Stefan Hajnoczi <stefanha@gmail.com> writes:
> >=20
> > > On Tue, Feb 4, 2020 at 3:54 PM Markus Armbruster <armbru@redhat.com> =
wrote:
> > >> =3D Ways to provide machine-friendly initial configuration =3D
> > >>
> > >> Two ways to provide machine-friendly initial configuration on par wi=
th
> > >> QMP have been proposed:
> > >>
> > >> 1. Extend QMP
> > >>
> > >>    Machines use the CLI only to configure a QMP socket.  The remaind=
er
> > >>    of the CLI becomes human-only, with much relaxed compatibility ru=
les.
> > >>
> > >> 2. QAPIfy the CLI
> > >>
> > >>    Provide a machine-friendly CLI based on QAPI and JSON.  The curre=
nt
> > >>    CLI becomes human-only, with much relaxed compatibility rules.
> > >
> > > Do we keep the existing CLI around in both cases?  I'm concerned that
> > > we're still following the HMP/QMP approach, which has left QEMU with
> > > the legacy HMP monitor that we still haven't removed.
> >=20
> > The "HMP is legacy" idea is relatively recent.
> >=20
> > I think having separate interfaces for humans and machines makes sense,
> > we just need to give both the attention and care they need and deserve.
> >=20
> > I think a human-friendly monitor is has its use, but it should ideally
> > be done differently than we do HMP now.
> >=20
> > Likewise, human-friendly initial configuration should exist, but it
> > should ideally be done differently than we do HMP now.
> >=20
> > > I'm in favor of simplifying QEMU at the expense of an incompatible CL=
I
> > > change in QEMU 6.0.
> >=20
> > I'm convinced the current CLI needs cleanup badly, and that means
> > incompatible change.  The question is how and when to change it.
> >=20
> > Here's how I'd like us to do it:
> >=20
> > 1. Create machine-friendly initial configuration interface separate fro=
m
> >    the existing CLI
> >=20
> >    Doesn't mean it cannot be a CLI.
> >=20
> > 2. Develop it step by step to feature parity with existing CLI
> >=20
> >    If we identify misfeatures we don't want anymore, we should
> >    immediately deprecate them in the existing CLI instead.
> >=20
> > 2. Transition machine users to this new interface
> >=20
> > 3. Declare the existing CLI to be like HMP: for humans, may change
> >    incompatibly
> >=20
> > 4. Clean up existing CLI step by step to wrap around the
> >    machine-friendly interface
> >=20
> >    Whatever we deprecated in step 2 goes to the bit bucket instead.
> >=20
> >    I'm open to replacing the existing CLI by a separate wrapper process
> >    instead.
> >=20
> >    Capability to translate to the machine-friendly interface is
> >    desirable, so human users can easily transition to the
> >    machine-friendly interface when they run into a need to automate.
> >=20
> > The risk is of course that we fail at step 4 and remain stuck with the
> > CLI mess we've made.
>=20
> Yes, QEMU does not have a good track record of successfully converting
> to new APIs and then removing old code.
>=20
> My worry is that this effort will result in the addition of even more
> code but we'll still be stuck with the old cruft (both in the user
> visible interface and in the implementation).

This is why I think any new CLI ought to be done in a new binary,
not qemu-system-XXXX. I think it is an easier proposition to
sell to people that this is a clean break if we make it a new
binary. The mere fact the binary exists will make people curious
about it. If we add new stuff to existing binaries, it is
essentially invisible unless you look for it.  Separate binaries
would also make life better for documentation IMHO, as we can
clearly distinguish legacy and modern in the docs. Indeed the
new binary doc shoudl be completely separate, so when people
learn about it, they're not distracted by legacy.

This way, even if we don't delete qemu-system-XXXX for a long time,
the new binary would not be polluted by the legacy cruft, even if
it still exists in some internal places.

Ideally the goal would be that QemuOpts be entirely missing from
any code linked into the new binary. This will be challenging given
some of the places QemuOpts embeds itself. Perhaps we can split some
of the source files to isolate the QemuOpts usage. The block layer
is the biggest challenge here.

> But we won't get anywhere if we don't try :).  This sounds like a
> significant project and I wonder if others would be willing to help if
> you can break down the tasks for them.



Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


