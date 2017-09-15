Received: from eggs.gnu.org ([2001:4830:134:3::10]:56865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dsjtQ-0003pK-KZ
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 02:14:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dsjtN-00025O-G5
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 02:14:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dsjtN-00025F-9Q
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 02:14:21 -0400
Date: Fri, 15 Sep 2017 14:14:15 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170915061415.GC17199@lemon>
References: <20170913030119.3957-1-famz@redhat.com>
	<20170913030119.3957-4-famz@redhat.com>
	<CAFEAcA_BfVKDOs3R6hv+-VY5MUcfi97g0RuLwNL2-Zxb+0yK6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_BfVKDOs3R6hv+-VY5MUcfi97g0RuLwNL2-Zxb+0yK6Q@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v7 03/13] scripts: Add archive-source.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Eric Blake <eblake@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>

On Wed, 09/13 11:55, Peter Maydell wrote:
> On 13 September 2017 at 04:01, Fam Zheng <famz@redhat.com> wrote:
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  scripts/archive-source.sh | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >  create mode 100755 scripts/archive-source.sh
> >
> > diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
> > new file mode 100755
> > index 0000000000..8b373e3090
> > --- /dev/null
> > +++ b/scripts/archive-source.sh
> > @@ -0,0 +1,33 @@
> > +#!/bin/sh
> > +#
> > +# Author: Fam Zheng <famz@redhat.com>
> > +#
> > +# Archive source tree, including submodules. This is created for test code to
> > +# export the source files, in order to be built in a different enviornment,
> 
> "environment"

Fixed, thanks.

Fam
