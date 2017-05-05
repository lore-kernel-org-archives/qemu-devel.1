Received: from eggs.gnu.org ([2001:4830:134:3::10]:58698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6Z1J-0000lr-Cv
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6Z1G-0002pD-46
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:55:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1d6Z1F-0002p3-TR
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:55:22 -0400
Date: Fri, 5 May 2017 16:55:18 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170505085518.GE21435@lemon.lan>
References: <20170505032340.26467-1-famz@redhat.com>
	<20170505032340.26467-6-famz@redhat.com>
	<87ziern1we.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87ziern1we.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/5] docker: Add test-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

On Fri, 05/05 09:28, Alex Benn=E9e wrote:
>=20
> Fam Zheng <famz@redhat.com> writes:
>=20
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  tests/docker/test-block | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >  create mode 100755 tests/docker/test-block
> >
> > diff --git a/tests/docker/test-block b/tests/docker/test-block
> > new file mode 100755
> > index 0000000..20ef705
> > --- /dev/null
> > +++ b/tests/docker/test-block
> > @@ -0,0 +1,21 @@
> > +#!/bin/bash -e
> > +#
> > +# Run block test cases
> > +#
> > +# Copyright (c) 2017 Red Hat Inc.
> > +#
> > +# Authors:
> > +#  Fam Zheng <famz@redhat.com>
> > +#
> > +# This work is licensed under the terms of the GNU GPL, version 2
> > +# or (at your option) any later version. See the COPYING file in
> > +# the top-level directory.
> > +
> > +. common.rc
> > +
> > +cd "$BUILD_DIR"
> > +
> > +build_qemu --target-list=3Dx86_64-softmmu
>=20
> Shouldn't we allow for non-default targets like the other tests?

Sure, I'll add it.

>=20
> > +cd tests/qemu-iotests
> > +./check -raw
> > +./check -qcow2
>=20
>=20
> --
> Alex Benn=E9e
