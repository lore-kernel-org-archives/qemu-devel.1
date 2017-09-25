Received: from eggs.gnu.org ([2001:4830:134:3::10]:58662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=434883a06=anthony.perard@citrix.com>)
	id 1dwV0L-0001VP-1q
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 11:09:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=434883a06=anthony.perard@citrix.com>)
	id 1dwV0H-0003F0-1W
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 11:09:05 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:64012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=434883a06=anthony.perard@citrix.com>)
	id 1dwV0G-0003Do-Re
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 11:09:00 -0400
Date: Mon, 25 Sep 2017 16:08:58 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170925150858.GB25986@perard.uk.xensource.com>
References: <1505498999-17427-1-git-send-email-ian.jackson@eu.citrix.com>
	<1505498999-17427-2-git-send-email-ian.jackson@eu.citrix.com>
	<a5d319a8-627b-a0c5-8642-8c6d5f400213@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a5d319a8-627b-a0c5-8642-8c6d5f400213@suse.com>
Subject: Re: [Qemu-devel] [PATCH RFC 1/6] xen: link against xentoolcore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juergen Gross <jgross@suse.com>
Cc: Ian Jackson <ian.jackson@eu.citrix.com>, qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>

On Fri, Sep 22, 2017 at 02:14:16PM +0200, Juergen Gross wrote:
> On 15/09/17 20:09, Ian Jackson wrote:
> > Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
> > ---
> >  configure | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/configure b/configure
> > index fd7e3a5..c59a0c0 100755
> > --- a/configure
> > +++ b/configure
> > @@ -2072,14 +2072,14 @@ if test "$xen" != "no" ; then
> >        $($pkg_config --modversion xencontrol | sed 's/\./ /g') )"
> >      xen=yes
> >      xen_pc="xencontrol xenstore xenguest xenforeignmemory xengnttab"
> > -    xen_pc="$xen_pc xenevtchn xendevicemodel"
> > +    xen_pc="$xen_pc xenevtchn xendevicemodel xentoolcore"
> >      QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags $xen_pc)"
> >      libs_softmmu="$($pkg_config --libs $xen_pc) $libs_softmmu"
> >      LDFLAGS="$($pkg_config --libs $xen_pc) $LDFLAGS"
> >    else
> >  
> >      xen_libs="-lxenstore -lxenctrl -lxenguest"
> > -    xen_stable_libs="-lxenforeignmemory -lxengnttab -lxenevtchn"
> > +    xen_stable_libs="-lxenforeignmemory -lxengnttab -lxenevtchn -lxentoolcore"
> 
> I don't think this is necessary. libxentoolcore is only available with
> a new Xen, which will always have the xentoolcore.pc file installed.

Only if ! echo $EXTRA_LDFLAGS | grep tools/libxc;

So building qemu via xen.git Makefiles, the pkg-config files are not
taken into account.

-- 
Anthony PERARD
