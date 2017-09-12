Received: from eggs.gnu.org ([2001:4830:134:3::10]:44082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drmCf-00037W-Ok
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:30:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drmCc-0006Oc-El
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:30:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1drmCc-0006Nx-9O
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:30:14 -0400
Date: Tue, 12 Sep 2017 15:30:07 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170912143007.GK17633@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170912123744.14730-1-berrange@redhat.com>
	<1505223994.31639.20.camel@redhat.com>
	<20170912141910.GJ17633@redhat.com>
	<CAFEAcA-tdbzXBkyxXW_e15hVcbcfqSfKqke0PX6y-Cg6A62DzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-tdbzXBkyxXW_e15hVcbcfqSfKqke0PX6y-Cg6A62DzQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v5 00/12] Convert over to use keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, Sep 12, 2017 at 03:24:22PM +0100, Peter Maydell wrote:
> On 12 September 2017 at 15:19, Daniel P. Berrange <berrange@redhat.com> wrote:
> > My POV is that we should a) never check generated files into GIT, and
> > we should use the submodule in such a way that it is indistinguish
> > from the content of the submodule being part of the main GIT repo.
> 
> AFAICT this is impossible in that git submodules are broken
> (checking out a different commit in the top level repo doesn't
> check out the correct version of the submodule to go with it).
> We put up with it for our current uses of submodules because
> the submodule contents don't change very often...

Yep, you need to have something in your build system which does
a checkout of the git submodule at the "right" time.

In autoconf world you can set things up so that 'autoreconf'
gets retriggered when submodule hash changes, but that doesn't
apply to qemu.

I tried to put some magic in configure in v4 but that was
flawed because I didn't take acount of people building
from dist.

I think a better approach is to have something in rules.mak
that ensures the submodule is checked out correctly (only
when building from GIT, not dist), and then have the rules
which generate the keymap files depend on this.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
