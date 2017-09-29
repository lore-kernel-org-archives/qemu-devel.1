Received: from eggs.gnu.org ([2001:4830:134:3::10]:54129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxrIh-0001Xf-2M
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 05:09:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxrId-0007W0-3L
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 05:09:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dxrIc-0007VF-SZ
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 05:09:35 -0400
Date: Fri, 29 Sep 2017 10:09:25 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170929090925.GF6803@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170928120621.30288-1-berrange@redhat.com>
	<20170928120621.30288-2-berrange@redhat.com>
	<e4db5995-1e8e-b422-f401-3a295ccc7f64@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e4db5995-1e8e-b422-f401-3a295ccc7f64@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 1/6] build: automatically handle GIT
 submodule checkout for dtc
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <qemu-devel.nongnu.org>

On Thu, Sep 28, 2017 at 12:59:56PM -0500, Eric Blake wrote:
> On 09/28/2017 07:06 AM, Daniel P. Berrange wrote:
> > Currently if DTC is required by configure and not available in the host
> > OS install, we exit with an error message telling the user to checkout a
> > git submodule or install the library.
> > 
> > This introduces automatic handling of the git submodule checkout process
> > and enables it for dtc. This only runs if building from GIT, so users of
> > release tarballs still need the system library install. The current state
> > of the git checkout is stashed in .git-submodule-status, and a helper
> > program is used to determine if this state matches the desired submodule
> > state. A dependency against 'Makefile' ensures that the submodule state
> > is refreshed at the start of the build process
> > 
> 
> > +++ b/scripts/git-submodule.sh
> > @@ -0,0 +1,31 @@
> > +#!/bin/bash
> > +
> > +set -e
> 
> New file, but appears not to be covered by MAINTAINERS; that should be
> fixed.  Also, an explicit copyright/license might be needed.

Yes to both.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
