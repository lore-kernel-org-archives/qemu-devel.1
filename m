Received: from eggs.gnu.org ([2001:4830:134:3::10]:53195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eGXBi-0002km-Cr
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 16:31:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eGXBf-0007JT-5s
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 16:31:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eGXBe-0007Id-VA
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 16:31:35 -0500
Date: Sun, 19 Nov 2017 19:31:30 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171119213130.GI3037@localhost.localdomain>
References: <1510815025-27857-1-git-send-email-yu.ning@linux.intel.com>
	<aa8a18bf-e4ac-830f-94c1-a86a612e2ebd@weilnetz.de>
	<20171116180003.GO3111@localhost.localdomain>
	<ed07d728-dc3d-3f45-23de-f4058aaf8f38@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ed07d728-dc3d-3f45-23de-f4058aaf8f38@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hax-interface: Add BSD license
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yu Ning <yu.ning@linux.intel.com>
Cc: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Yu Ning <yu.ning@intel.com>, Richard Henderson <rth@twiddle.net>, Vincent Palatin <vpalatin@chromium.org>

On Fri, Nov 17, 2017 at 05:03:27PM +0800, Yu Ning wrote:
> On 11/17/2017 2:00, Eduardo Habkost wrote:
> > On Thu, Nov 16, 2017 at 07:47:44AM +0100, Stefan Weil wrote:
> > > Am 16.11.2017 um 07:50 schrieb yu.ning@linux.intel.com:
> > > > From: Yu Ning <yu.ning@intel.com>
> > > >=20
> > > > hax-interface.h defines the interface between the HAXM kernel
> > > > module and the HAXM QEMU accelerator. The same code can be found =
in
> > > > the following files of the HAXM kernel module:
> > > >=20
> > > >   include/hax_interface.h
> > > >   include/vcpu_state.h
> > > >   core/include/vm.h
> > > >=20
> > > > These files are now open source under the 3-clause BSD license,
> > > > whereas hax-interface.h in QEMU uses GPLv2.
> > Why is this a problem?
>=20
> I know very little about licenses.=A0 If this is not a problem, I'm hap=
py to
> just abandon this patch.

As far as I can see, this is not a problem for the QEMU project
at all, as QEMU as a whole is GPLv2.

It would make sense to update the license if we wanted to keep
our header file in sync with some other source tree (e.g. the one
from Intel), but this doesn't seem to be the case here (yet?).


> >=20
> > > > Address this inconsistency by adding the BSD license to the QEMU
> > > > file, per Stefan Weil's comment on this HAXM pull request:
> > > >=20
> > > >   https://github.com/intel/haxm/pull/2
> > The existing code on qemu.git don't match the code on the GitHub
> > repository above exactly, and its copyright history looks hard to
> > track[1].
>=20
> Right. I don't know when the QEMU header (hax-interface.h) first appear=
ed,
> but I think it's probably a derivative of the HAXM ones, which date bac=
k to
> no later than June 2011.
>=20
> > If we really care about consistency between the two
> > projects, shouldn't we just delete the existing file and copy the
> > headers from github.com/intel/haxm directly?
>=20
> That's a good solution, but not feasible at the moment, because in the =
HAXM
> kernel module, a small piece of the interface code currently resides in=
 an
> internal header (core/include/vm.h). Probably we should clean up the
> interface headers on the HAXM side, and then push the change to QEMU.

This would be nice, so we wouldn't need to maintain a different
header file in QEMU.  Should we open an issue at
https://github.com/intel/haxm?

--=20
Eduardo
