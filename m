Received: from eggs.gnu.org ([2001:4830:134:3::10]:53143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ewOoZ-0003T4-7t
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 05:04:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ewOoT-0002ZL-0x
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 05:04:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48322 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ewOoS-0002Y8-HP
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 05:04:40 -0400
Date: Thu, 15 Mar 2018 17:04:26 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180315090426.GJ2733@lemon.usersys.redhat.com>
References: <20180309091535.13315-1-peterx@redhat.com>
	<808d1efc-2db7-01a2-23ba-3af108d9d1e7@redhat.com>
	<235748d9-3bc2-637b-f926-6436d11f4f61@redhat.com>
	<20180312044504.GF5234@xz-mi>
	<20180315081937.GI2733@lemon.usersys.redhat.com>
	<20180315084132.GA2783@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180315084132.GA2783@xz-mi>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 00/23] Migration: postcopy failure
 recovery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Andrea Arcangeli <aarcange@redhat.com>, Juan Quintela <quintela@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, 03/15 16:41, Peter Xu wrote:
> On Thu, Mar 15, 2018 at 04:19:37PM +0800, Fam Zheng wrote:
> > On Mon, 03/12 12:45, Peter Xu wrote:
> > > On Fri, Mar 09, 2018 at 10:59:03AM -0600, Eric Blake wrote:
> > > > On 03/09/2018 10:54 AM, Eric Blake wrote:
> > > > > On 03/09/2018 03:15 AM, Peter Xu wrote:
> > > > > > Based-on: <20180309090006.10018-1-peterx@redhat.com>
> > > > > >=20
> > > > > > This series is based on the series:
> > > > > >=20
> > > > > > =A0=A0 [PATCH v8 00/23] QMP: out-of-band (OOB) execution supp=
ort
> > > > >=20
> > > > > Let's spell that in a way patchew understands:
> > > > >=20
> > > > > Based-on: <20180309090006.10018-1-peterx@redhat.com>
> > > > >=20
> > > >=20
> > > > Never mind - I missed that you snuck that in on the very first li=
ne (which
> > > > I'm used to overlooking because it's often a 'From:' author attri=
bution,
> > > > instead of a patchew directive).  I saw the patchew failure messa=
ges, but
> > > > didn't read them closely to see why it is failing, and merely ass=
umed it was
> > > > because of the missing dependency...
> > >=20
> > > Yeh, but there still seems to be something wrong elsewhere since th=
e
> > > series can pass compilation and docker tests on my host...
> > >=20
> > > Fam, what would happen if I firstly post OOB series, then postcopy
> > > series (which will have "based-on" on OOB series) right away?  Coul=
d
> > > Patchew just ignore the "based-on" if I post the 2nd series too fas=
t
> > > since Patchew may have not yet went through the first one?
> >=20
> > Could be. Git apply of the first one races with the appearance of the=
 second one
> > in patchew's database. Or if the emails arrive in patchew's INBOX out=
-of-order,
> > the based-on tag will not work as expected.
>=20
> Thanks for confirming.  Based-on is not frequently used, so I think
> what I need to do next time is I manually query and only send the 2nd
> series after patchew.org reported okay on the first one.
>=20
> It'll be good too if patchew can stop running tests if there is
> unknown based-on tag (either fully unknown, or work-in-progress), and
> report that "unknown tag found" message directly instead of test
> failures (since if there is a based-on, it's very possible that it'll
> fail).
>=20
> Further - I'm not sure whether serializing the work will be hard or
> not. Say, if series B has a based-on of A that is known but during
> processing, then postpone processing B until A finished.  I won't ask
> for that though especially if it's not trivial.

Nice suggestions. Added to my TODO list now. Thanks,

Fam
