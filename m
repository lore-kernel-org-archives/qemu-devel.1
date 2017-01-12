Received: from eggs.gnu.org ([2001:4830:134:3::10]:45385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cRgP6-0002Ku-03
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:31:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cRgP1-0000jm-56
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:31:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cRgP0-0000j7-Vn
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:30:55 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 346097DCEC
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 14:30:55 +0000 (UTC)
Date: Thu, 12 Jan 2017 14:30:49 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170112143049.GA993@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170106155543.12827-3-berrange@redhat.com>
	<20170110163713.GA19869@stefanha-x1.localdomain>
	<eabc1ecd-439c-69cc-facb-281699a4d26e@redhat.com>
	<20170111171202.GG9269@stefanha-x1.localdomain>
	<20170111171646.GR12072@redhat.com>
	<6d64c194-bb64-9ac2-3281-9a9329f6a52b@redhat.com>
	<20170111174045.GT12072@redhat.com>
	<6ff77c17-5516-e967-27ec-6fb3bf2160d4@redhat.com>
	<87fukpf5ub.fsf@ac.upc.edu>
	<9456f50a-811a-03a7-2bf7-0533dabb0650@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9456f50a-811a-03a7-2bf7-0533dabb0650@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/47] trace: switch io/ directory to
 modular trace.h file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, Jan 12, 2017 at 09:48:20AM +0100, Paolo Bonzini wrote:
>=20
>=20
> On 12/01/2017 02:02, Llu=C3=ADs Vilanova wrote:
> > Paolo Bonzini writes:
> > [...]
> >> A weird idea: what about doing
> >=20
> >>     -DGENERATED_TRACERS_H=3D\"hw/scsi/generated-tracers.h\"
> >=20
> >> and then having
> >=20
> >>      #ifdef GENERATED_TRACE_H
> >>      #include GENERATED_TRACE_H
> >>      #endif
> >=20
> >> in include/trace.h?
> >=20
> >> Then you can use full include path for special cases such as
> >> include/hw/xen/xen_common.h, but the common case is handled directly
> >> with just
> >=20
> >>      #include "trace.h"
> >=20
> >> which refers to $(srcdir)/include/trace.h? (Take the above with a gr=
ain
> >> of salt because I haven't reviewed the patches closely).
> >=20
> > Feels like too much black magic to me for the benefit of a bit less t=
yping.
>=20
> It's not less typing, it's about consistency.   Includes from the
> current directory are currently included with no path.

I think I am able to workaround the problems by just renaming the
top level file to trace-root.h to avoid ambiguity. Just testing
builds now...

Regards,
Daniel
--=20
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange=
/ :|
|: http://libvirt.org              -o-             http://virt-manager.or=
g :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr=
/ :|
