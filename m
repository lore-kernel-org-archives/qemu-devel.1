Received: from eggs.gnu.org ([2001:4830:134:3::10]:46502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dkoO9-0007xp-4j
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 05:25:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dkoO4-00052H-RO
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 05:25:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dkoO4-00051y-LQ
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 05:25:16 -0400
Date: Thu, 24 Aug 2017 17:25:11 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170824092511.GC1866@lemon>
References: <20170822044155.2451-1-famz@redhat.com>
	<20170822044155.2451-7-famz@redhat.com>
	<fa516204-de03-abe0-6618-d8437a6d559c@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa516204-de03-abe0-6618-d8437a6d559c@gmx.com>
Subject: Re: [Qemu-devel] [PATCH v3 06/10] tests: Add NetBSD image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com

On Wed, 08/23 17:15, Kamil Rytarowski wrote:
> On 22.08.2017 06:41, Fam Zheng wrote:
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
> 
> I've rechecked a similar setup, and I think that there might be needed
> /dev/rld1a (initial r stands for raw device).

Sure, I'll have a test and update it.

Fam
