Received: from eggs.gnu.org ([2001:4830:134:3::10]:58910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqSSi-0000wq-97
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 19:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqSSh-0006Dr-CX
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 19:13:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqSSh-0006D0-6C
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 19:13:23 -0400
Date: Sat, 9 Sep 2017 07:13:18 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170908231318.GB18677@lemon.lan>
References: <20170905021201.25684-1-famz@redhat.com>
	<20170905021201.25684-4-famz@redhat.com>
	<CAFEAcA9mFqWntuM3=vGQKv-rLjRpRnBLhXomJNTHH9U6+zhTLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9mFqWntuM3=vGQKv-rLjRpRnBLhXomJNTHH9U6+zhTLQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v6 03/12] scripts: Add archive-source.sh
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

On Fri, 09/08 15:56, Peter Maydell wrote:
> On 5 September 2017 at 03:11, Fam Zheng <famz@redhat.com> wrote:
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  scripts/archive-source.sh | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >  create mode 100755 scripts/archive-source.sh
> >
> > diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
> > new file mode 100755
> > index 0000000000..3cae7f34d3
> > --- /dev/null
> > +++ b/scripts/archive-source.sh
> > @@ -0,0 +1,31 @@
> > +#!/bin/sh
> > +#
> > +# Author: Fam Zheng <famz@redhat.com>
> > +#
> > +# Create archive of source tree, including submodules
> > +#
> > +# This work is licensed under the terms of the GNU GPL, version 2.
> > +# See the COPYING file in the top-level directory.
> 
> Why GPL-2-only? We generally prefer GPL-2-or-later for new
> files, or something more permissive.

Copied from some other script/* files, apparently. :)

Will make it GPL-2-or-later.

Fam
