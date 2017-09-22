Received: from eggs.gnu.org ([2001:4830:134:3::10]:49000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvDvQ-0000nY-D6
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 22:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvDvN-0000hx-2I
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 22:42:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dvDvM-0000gw-SN
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 22:42:40 -0400
Date: Fri, 22 Sep 2017 10:42:35 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170922024235.GC1397@lemon.lan>
References: <20170921150755.19914-1-famz@redhat.com>
	<20170921150755.19914-4-famz@redhat.com>
	<dfa1fda4-78d2-664a-1fb4-eb46b9c74dba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfa1fda4-78d2-664a-1fb4-eb46b9c74dba@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v11 03/13] scripts: Add archive-source.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

On Thu, 09/21 10:22, Eric Blake wrote:
> On 09/21/2017 10:07 AM, Fam Zheng wrote:
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  scripts/archive-source.sh | 51 +++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >  create mode 100755 scripts/archive-source.sh
> > 
> > diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
> > new file mode 100755
> > index 0000000000..8aa363d3a0
> > --- /dev/null
> > +++ b/scripts/archive-source.sh
> > @@ -0,0 +1,51 @@
> > +#!/bin/bash
> > +#
> > +# Author: Fam Zheng <famz@redhat.com>
> > +#
> > +# Archive source tree, including submodules. This is created for test code to
> > +# export the source files, in order to be built in a different enviornment,
> 
> s/enviornment/environment/
> 
> > +# such as in a docker instance or VM.
> > +#
> > +# This code is licensed under the GPL version 2 or later.  See
> > +# the COPYING file in the top-level directory.
> > +
> > +error() {
> > +    echo "$@" >&2
> 
> slightly risky if $@ contains \ - using 'printf %s\\n "$*"' is nicer.
> But this particular script can get away with it, as I don't see use of \
> (other than if you have a weird $0).
> 
> > +
> > +if test -n "$submodules"; then
> > +    {
> > +        git ls-files || error "git ls-files failed"
> > +        for sm in $submodules; do
> > +            (cd $sm; git ls-files) | sed "s:^:$sm/:"
> > +            if test "${PIPESTATUS[0]} ${PIPESTATUS[1]}" != "0 0"; then
> 
> Could shorten to "${PIPESTATUS[*]}", as discussed in another mail, but
> this works too.
> 
> With the typo fixed, and your choice of how to handle my other two nits
> (including doing nothing),
> Reviewed-by: Eric Blake <eblake@redhat.com>

Fixing all of them and adding your r-b line.

> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 

Fam
