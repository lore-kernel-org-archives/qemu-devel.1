Received: from eggs.gnu.org ([2001:4830:134:3::10]:56598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1faHIN-0005Qa-Fn
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:08:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1faHIH-0000Nj-EA
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:08:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52040 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1faHIH-0000NK-8P
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:08:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 60EC9402346D
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 09:08:16 +0000 (UTC)
Date: Tue, 3 Jul 2018 10:08:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180703090808.GA11434@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180702162218.13678-1-armbru@redhat.com>
	<20180702162218.13678-8-armbru@redhat.com>
	<20180703033625.GP2455@xz-mi> <874lhg7sms.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874lhg7sms.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/32] qmp: Make "id" optional again even
 in "oob" monitors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com, dgilbert@redhat.com

On Tue, Jul 03, 2018 at 08:14:35AM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
>=20
> > On Mon, Jul 02, 2018 at 06:21:53PM +0200, Markus Armbruster wrote:
> >> Commit cf869d53172 "qmp: support out-of-band (oob) execution" made
> >> "id" mandatory for all commands when the client accepted capability
> >> "oob".  This is rather onerous when you play with QMP by hand, and
> >> unnecessarily so: only out-of-band commands need an ID for reliable
> >> matching of response to command.
> >>=20
> >> Revert that part of commit cf869d53172 for now.  We may still make
> >> "id" mandatory for out-of-band commands.
> >
> > This change should be okay with current implementation when
> > out-of-band commands are still in order themselves, though I'm still
> > not that confident on whether we really want this change if only for
> > the sake of easier usage for human beings.
> >
> > If we see Libvirt, the real player for QMP - it has the "id" field
> > even for in-band commands always.  I'd say the "id" field is really
> > helpful for machines, though not that friendly to us.
> >
> > Basically I'll read it as: machines like "id"s, humans hate "id"s.
> > And QMP is Qemu Machine Protocol after all... so not sure whether
> > it'll be good we change that for us humans.
>=20
> "id" being optional doesn't hurt libvirt in any way.  Thus, I see no
> need to inconvenience humans.
>=20
> Daniel has argued[*] for making "id" mandatory with OOB commands.  I'm
> not rejecting that argument.  But I needed to get this out in a hurry,
> and simply reverting something is quicker than debating and implementin=
g
> an improvement.  There's still time to tweak this before the release.

I'm fine with this - I agree that it is more important to avoid creating
a regression, than to enforce "id" for OOB. We've still documented that
OOB will require "id", so it would not be a surprise once we enforce it
later.=20

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
