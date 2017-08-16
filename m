Received: from eggs.gnu.org ([2001:4830:134:3::10]:58868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhvFJ-00052C-RC
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 06:08:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhvFG-0001sG-MA
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 06:08:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dhvFG-0001rf-Ca
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 06:08:14 -0400
Date: Wed, 16 Aug 2017 18:08:09 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170816100809.GA8396@lemon>
References: <20170816072104.24420-1-famz@redhat.com>
	<20170816072104.24420-8-famz@redhat.com>
	<1278039f-cf0c-ae69-7bc0-2fc45fdf98c4@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1278039f-cf0c-ae69-7bc0-2fc45fdf98c4@gmx.com>
Subject: Re: [Qemu-devel] [PATCH RFC 7/9] tests: Add NetBSD image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Kamil Rytarowski <kamil@netbsd.org>, stefanha@redhat.com, pbonzini@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Wed, 08/16 11:31, Kamil Rytarowski wrote:
> On 16.08.2017 09:21, Fam Zheng wrote:
> > The image is prepared following instructions as in:
> > 
> > https://wiki.qemu.org/Hosts/BSD
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  tests/vm/netbsd | 44 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >  create mode 100755 tests/vm/netbsd
> > 
> > diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> > new file mode 100755
> > index 0000000000..4cd07d3b1b
> > --- /dev/null
> > +++ b/tests/vm/netbsd
> > @@ -0,0 +1,44 @@
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
> > +import subprocess
> > +import tempfile
> > +import time
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
> > +        if os.path.exists(img) and not rebuild:
> > +            return
> > +        cimg = self._download_with_cache("http://localhost:8000/netbsd.img.xz")
> 
> http://download.patchew.org/netbsd.img.xz

Yes, weird this is left over. Will fix.

Fam
