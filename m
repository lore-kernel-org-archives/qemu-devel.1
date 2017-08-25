Received: from eggs.gnu.org ([2001:4830:134:3::10]:60640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dlAO1-0001ge-Sm
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 04:54:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dlAO0-000636-JI
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 04:54:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dlAO0-00062v-DG
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 04:54:40 -0400
Date: Fri, 25 Aug 2017 16:54:34 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170825085434.GG11465@lemon.lan>
References: <20170822044155.2451-1-famz@redhat.com>
	<20170822044155.2451-7-famz@redhat.com>
	<7f5841bd-fcc9-636b-6a82-00f1ad2852aa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f5841bd-fcc9-636b-6a82-00f1ad2852aa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 06/10] tests: Add NetBSD image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Kamil Rytarowski <kamil@netbsd.org>, stefanha@redhat.com, pbonzini@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Thu, 08/24 11:37, Cleber Rosa wrote:
> 
> 
> On 08/22/2017 12:41 AM, Fam Zheng wrote:
> > The image is prepared following instructions as in:
> > 
> > https://wiki.qemu.org/Hosts/BSD
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > Reviewed-by: Kamil Rytarowski <n54@gmx.com>
> > ---
> >  tests/vm/netbsd | 45 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >  create mode 100755 tests/vm/netbsd
> > 
> > diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> > new file mode 100755
> > index 0000000000..7d7dfe6586
> > --- /dev/null
> > +++ b/tests/vm/netbsd
> > @@ -0,0 +1,45 @@
> > +#!/usr/bin/env python
> > +#
> > +# NetBSD VM image
> > +#
> > +# Copyright (C) 2017 Red Hat Inc.
> > +#
> > +# Authors:
> > +#  Fam Zheng <famz@redhat.com>
> > +#
> > +# This work is licensed under the terms of the GNU GPL, version 2.  See
> > +# the COPYING file in the top-level directory.
> > +#
> > +
> > +import os
> > +import sys
> > +import logging
> 
> logging is not used in this module.
> 
> > +import subprocess
> > +import tempfile
> > +import time
> 
> tempfile and time imports can also be removed.
> 
> > +import basevm
> > +
> > +class NetBSDVM(basevm.BaseVM):
> > +    name = "netbsd"
> > +    BUILD_SCRIPT = """
> > +        set -e;
> > +        cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
> > +        tar -xf /dev/ld1a;
> > +        ./configure --python=python2.7 {configure_opts};
> > +        gmake -j{jobs};
> > +        gmake check;
> > +    """
> > +
> > +    def build_image(self, img, rebuild=False):
> 
> Same comment as in the FreeBSDVM class: I don't see how "rebuild" will
> ever get set by using "basevm.main()".
> 

Will drop all of them.

Fam
