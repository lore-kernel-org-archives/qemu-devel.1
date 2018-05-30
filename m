Received: from eggs.gnu.org ([2001:4830:134:3::10]:44042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fO0m6-0000vg-6h
	for qemu-devel@nongnu.org; Wed, 30 May 2018 09:04:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fO0m0-0003df-AO
	for qemu-devel@nongnu.org; Wed, 30 May 2018 09:04:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51510 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fO0m0-0003bz-67
	for qemu-devel@nongnu.org; Wed, 30 May 2018 09:04:16 -0400
Date: Wed, 30 May 2018 21:04:12 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180530130412.GA11841@lemon.usersys.redhat.com>
References: <20180529193730.9204-1-crosa@redhat.com>
	<20180529193730.9204-4-crosa@redhat.com>
	<20180530125705.GL14623@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530125705.GL14623@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v3 3/5] Acceptance tests: add quick VNC
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Amador Pahim <amador@pahim.org>

On Wed, 05/30 13:57, Stefan Hajnoczi wrote:
> On Tue, May 29, 2018 at 03:37:28PM -0400, Cleber Rosa wrote:
> > This patch adds a few simple behavior tests for VNC.
> > 
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > ---
> >  tests/acceptance/vnc.py | 60 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 60 insertions(+)
> >  create mode 100644 tests/acceptance/vnc.py
> > 
> > diff --git a/tests/acceptance/vnc.py b/tests/acceptance/vnc.py
> > new file mode 100644
> > index 0000000000..b1ef9d71b1
> > --- /dev/null
> > +++ b/tests/acceptance/vnc.py
> > @@ -0,0 +1,60 @@
> > +# Simple functional tests for VNC functionality
> > +#
> > +# Copyright (c) 2018 Red Hat, Inc.
> > +#
> > +# Author:
> > +#  Cleber Rosa <crosa@redhat.com>
> > +#
> > +# This work is licensed under the terms of the GNU GPL, version 2 or
> > +# later.  See the COPYING file in the top-level directory.
> > +
> > +from avocado_qemu import Test
> > +
> > +
> > +class Vnc(Test):
> > +    """
> > +    :avocado: enable
> > +    :avocado: tags=vnc,quick
> > +    """
> > +    def test_no_vnc(self):
> > +        self.vm.add_args('-nodefaults', '-S')
> > +        self.vm.launch()
> 
> If this pattern becomes very common maybe vm.launch() should become
> vm.launch(*extra_args) to make this a one-liner:
> 
>   self.vm.launch('-nodefaults', '-S')

+1. It will be a nice extension to the launch method.

Fam
