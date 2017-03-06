Received: from eggs.gnu.org ([2001:4830:134:3::10]:51082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cky4w-0005Ug-Vg
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 14:13:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cky4s-0000cn-8a
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 14:13:54 -0500
Received: from mail.kernel.org ([198.145.29.136]:43648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cky4r-0000cW-UJ
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 14:13:50 -0500
Date: Mon, 6 Mar 2017 11:13:43 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <31427779196840b3b31171ec9deda91f@AMSPEX02CL03.citrite.net>
Message-ID: <alpine.DEB.2.10.1703061101050.17906@sstabellini-ThinkPad-X260>
References: <1488452986-24501-1-git-send-email-paul.durrant@citrix.com>
	<1488452986-24501-6-git-send-email-paul.durrant@citrix.com>
	<alpine.DEB.2.10.1703021426050.17906@sstabellini-ThinkPad-X260>
	<05365905529b4fd78ff67989743a8dfb@AMSPEX02CL03.citrite.net>
	<alpine.DEB.2.10.1703031209090.17906@sstabellini-ThinkPad-X260>
	<alpine.DEB.2.10.1703031243050.17906@sstabellini-ThinkPad-X260>
	<1636138fa3a948229a4630fe48d5a079@AMSPEX02CL03.citrite.net>
	<31427779196840b3b31171ec9deda91f@AMSPEX02CL03.citrite.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v2 5/5] xen: use libxendevicemodel when
 available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <Paul.Durrant@citrix.com>
Cc: 'Stefano Stabellini' <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Mon, 6 Mar 2017, Paul Durrant wrote:
> > -----Original Message-----
> > From: Qemu-devel [mailto:qemu-devel-
> > bounces+paul.durrant=citrix.com@nongnu.org] On Behalf Of Paul Durrant
> > Sent: 06 March 2017 09:15
> > To: 'Stefano Stabellini' <sstabellini@kernel.org>
> > Cc: Anthony Perard <anthony.perard@citrix.com>; xen-
> > devel@lists.xenproject.org; qemu-devel@nongnu.org
> > Subject: Re: [Qemu-devel] [PATCH v2 5/5] xen: use libxendevicemodel when
> > available
> > 
> > > -----Original Message-----
> > > From: Stefano Stabellini [mailto:sstabellini@kernel.org]
> > > Sent: 03 March 2017 20:43
> > > To: Stefano Stabellini <sstabellini@kernel.org>
> > > Cc: Paul Durrant <Paul.Durrant@citrix.com>; xen-
> > devel@lists.xenproject.org;
> > > qemu-devel@nongnu.org; Anthony Perard <anthony.perard@citrix.com>
> > > Subject: RE: [PATCH v2 5/5] xen: use libxendevicemodel when available
> > >
> > > On Fri, 3 Mar 2017, Stefano Stabellini wrote:
> > > > On Fri, 3 Mar 2017, Paul Durrant wrote:
> > > > > > -----Original Message-----
> > > > > > From: Stefano Stabellini [mailto:sstabellini@kernel.org]
> > > > > > Sent: 02 March 2017 22:50
> > > > > > To: Paul Durrant <Paul.Durrant@citrix.com>
> > > > > > Cc: xen-devel@lists.xenproject.org; qemu-devel@nongnu.org;
> > Stefano
> > > > > > Stabellini <sstabellini@kernel.org>; Anthony Perard
> > > > > > <anthony.perard@citrix.com>
> > > > > > Subject: Re: [PATCH v2 5/5] xen: use libxendevicemodel when
> > available
> > > > > >
> > > > > > On Thu, 2 Mar 2017, Paul Durrant wrote:
> > > > > > > This patch modifies the wrapper functions in xen_common.h to use
> > > the
> > > > > > > new xendevicemodel interface if it is available along with
> > > compatibility
> > > > > > > code to use the old libxenctrl interface if it is not.
> > > > > > >
> > > > > > > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > > > > > > ---
> > > > > > > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > > > > > > Cc: Anthony Perard <anthony.perard@citrix.com>
> > > > > > >
> > > > > > > v2:
> > > > > > > - Add a compat define for xenforeignmemory_close() since this is
> > > now
> > > > > > >   used.
> > > > > > > ---
> > > > > > >  include/hw/xen/xen_common.h | 115
> > > > > > +++++++++++++++++++++++++++++++-------------
> > > > > > >  xen-common.c                |   8 +++
> > > > > > >  2 files changed, 90 insertions(+), 33 deletions(-)
> > > > > > >
> > > > > > > diff --git a/include/hw/xen/xen_common.h
> > > > > > b/include/hw/xen/xen_common.h
> > > > > > > index 31cf25f..48444e5 100644
> > > > > > > --- a/include/hw/xen/xen_common.h
> > > > > > > +++ b/include/hw/xen/xen_common.h
> > > > > > > @@ -9,6 +9,7 @@
> > > > > > >  #undef XC_WANT_COMPAT_EVTCHN_API
> > > > > > >  #undef XC_WANT_COMPAT_GNTTAB_API
> > > > > > >  #undef XC_WANT_COMPAT_MAP_FOREIGN_API
> > > > > > > +#undef XC_WANT_COMPAT_DEVICEMODEL_API
> > > > > > >
> > > > > > >  #include <xenctrl.h>
> > > > > > >  #include <xenstore.h>
> > > > > > > @@ -26,48 +27,95 @@ extern xc_interface *xen_xc;
> > > > > > >   * We don't support Xen prior to 4.2.0.
> > > > > > >   */
> > > > > > >
> > > > > > > +#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 490
> > > > > > > +
> > > > > > > +typedef xc_interface xendevicemodel_handle;
> > > > > > > +
> > > > > > > +#define xendevicemodel_open(l, f) xen_xc
> > > > > > > +
> > > > > > > +#define xendevicemodel_map_io_range_to_ioreq_server \
> > > > > > > +    xc_hvm_map_io_range_to_ioreq_server
> > > > > > > +#define xendevicemodel_unmap_io_range_from_ioreq_server \
> > > > > > > +    xc_hvm_unmap_io_range_from_ioreq_server
> > > > > > > +#define xendevicemodel_map_pcidev_to_ioreq_server \
> > > > > > > +    xc_hvm_map_pcidev_to_ioreq_server
> > > > > > > +#define xendevicemodel_unmap_pcidev_from_ioreq_server \
> > > > > > > +    xc_hvm_unmap_pcidev_from_ioreq_server
> > > > > > > +#define xendevicemodel_create_ioreq_server \
> > > > > > > +    xc_hvm_create_ioreq_server
> > > > > > > +#define xendevicemodel_destroy_ioreq_server \
> > > > > > > +    xc_hvm_destroy_ioreq_server
> > > > > > > +#define xendevicemodel_get_ioreq_server_info \
> > > > > > > +    xc_hvm_get_ioreq_server_info
> > > > > > > +#define xendevicemodel_set_ioreq_server_state \
> > > > > > > +    xc_hvm_set_ioreq_server_state
> > > > > > > +#define xendevicemodel_set_pci_intx_level \
> > > > > > > +    xc_hvm_set_pci_intx_level
> > > > > > > +#define xendevicemodel_set_pci_link_route \
> > > > > > > +    xc_hvm_set_pci_link_route
> > > > > > > +#define xendevicemodel_set_isa_irq_level \
> > > > > > > +    xc_hvm_set_isa_irq_level
> > > > > > > +#define xendevicemodel_inject_msi \
> > > > > > > +    xc_hvm_inject_msi
> > > > > > > +#define xendevicemodel_set_mem_type \
> > > > > > > +    xc_hvm_set_mem_type
> > > > > > > +#define xendevicemodel_track_dirty_vram \
> > > > > > > +    xc_hvm_track_dirty_vram
> > > > > > > +#define xendevicemodel_modified_memory \
> > > > > > > +    xc_hvm_modified_memory
> > > > > >
> > > > > > It does build correctly now for Xen < 4.9, however it breaks against
> > > > > > xen-unstable:
> > > > > >
> > > > > >   ERROR: configure test passed without -Werror but failed with -
> > Werror.
> > > > > >          This is probably a bug in the configure script. The failing command
> > > > > >          will be at the bottom of config.log.
> > > > > >          You can run configure with --disable-werror to bypass this check.
> > > > > >
> > > > > > and config.log says:
> > > > > >
> > > > > >   config-temp/qemu-conf.c: In function 'main':
> > > > > >   config-temp/qemu-conf.c:32:3: error: implicit declaration of function
> > > > > > 'xc_hvm_set_mem_type' [-Werror=implicit-function-declaration]
> > > > > >   config-temp/qemu-conf.c:32:3: error: nested extern declaration of
> > > > > > 'xc_hvm_set_mem_type' [-Werror=nested-externs]
> > > > > >   config-temp/qemu-conf.c:34:3: error: implicit declaration of function
> > > > > > 'xc_hvm_inject_msi' [-Werror=implicit-function-declaration]
> > > > > >   config-temp/qemu-conf.c:34:3: error: nested extern declaration of
> > > > > > 'xc_hvm_inject_msi' [-Werror=nested-externs]
> > > > > >   config-temp/qemu-conf.c:35:3: error: implicit declaration of function
> > > > > > 'xc_hvm_create_ioreq_server' [-Werror=implicit-function-
> > declaration]
> > > > > >   config-temp/qemu-conf.c:35:3: error: nested extern declaration of
> > > > > > 'xc_hvm_create_ioreq_server' [-Werror=nested-externs]
> > > > > >
> > > > > >
> > > > > > With -DXC_WANT_COMPAT_DEVICEMODEL_API=1:
> > > > > >
> > > > > >   In file included from /local/qemu-
> > > > > > upstream/include/hw/xen/xen_backend.h:4:0,
> > > > > >                    from hw/block/xen_disk.c:27:
> > > > > >   /local/qemu-upstream/include/hw/xen/xen_common.h: In function
> > > > > > 'xen_set_mem_type':
> > > > > >   /local/qemu-upstream/include/hw/xen/xen_common.h:78:5: error:
> > > implicit
> > > > > > declaration of function 'xc_hvm_set_mem_type' [-Werror=implicit-
> > > function-
> > > > > > declaration]
> > > > > >
> > > > >
> > > > > Ah... Do you have Anthony's patch?
> > > > >
> > > > >
> > >
> > http://xenbits.xen.org/gitweb/?p=xen.git;a=commit;h=9970e98ace48574701
> > > f7e2286fb67090481a3fec
> > > > >
> > > > > I suspect that may be the problem you're seeing above.
> > > >
> > > > Yes, I do have it. I am still having build troubles with v5 too. I am
> > >
> > > I meant v3
> > >
> > >
> > > > attaching my build test script: feel free to use it to test the build of
> > > > a single QEMU branch against multiple Xen versions. It requires one Xen
> > > > repository checked out and built for each Xen version. I have just
> > > > added the Xen 4.9 tests, so they might be wrong somehow, but the
> > others
> > > > are known to work.
> > 
> > Your script is lacking Anthony's fix. You need to patch your 4.9 configure
> > clause accordingly. I.e. you need -
> > I$(XEN_ROOT)/tools/libs/devicemodel/include and -
> > L$(XEN_ROOT)/tools/libs/devicemodel in the --extra-cflags.
> 
> Sorry, I meant the latter in --extra-ldflags and I notice you do actually have that. It's just the -I that's missing.

Thank you, you are right, that fixes the build against 4.9, but there
are problems with all other versions:

[4.3, 4.4]

In file included from /local/qemu-upstream/include/hw/xen/xen_backend.h:4:0,
                 from hw/block/xen_disk.c:27:
/local/qemu-upstream/include/hw/xen/xen_common.h:42:5: error: unknown type name 'ioservid_t'
/local/qemu-upstream/include/hw/xen/xen_common.h:49:49: error: unknown type name 'ioservid_t'
/local/qemu-upstream/include/hw/xen/xen_common.h:58:49: error: unknown type name 'ioservid_t'
/local/qemu-upstream/include/hw/xen/xen_common.h:66:49: error: unknown type name 'ioservid_t'
/local/qemu-upstream/include/hw/xen/xen_common.h:74:49: error: unknown type name 'ioservid_t'
/local/qemu-upstream/include/hw/xen/xen_common.h:82:49: error: unknown type name 'ioservid_t'
/local/qemu-upstream/include/hw/xen/xen_common.h:90:49: error: unknown type name 'ioservid_t'
/local/qemu-upstream/include/hw/xen/xen_common.h:96:49: error: unknown type name 'ioservid_t'
make: *** [hw/block/xen_disk.o] Error 1


[4.5, 4.6, 4.7, 4.8]

In file included from /local/qemu-upstream/include/hw/xen/xen_backend.h:4:0,
                 from hw/block/xen_disk.c:27:
/local/qemu-upstream/include/hw/xen/xen_common.h: In function 'xendevicemodel_destroy_ioreq_server':
/local/qemu-upstream/include/hw/xen/xen_common.h:92:5: error: implicit declaration of function 'xc_hvm__destroy_ioreq_server' [-Werror=implicit-function-declaration]
/local/qemu-upstream/include/hw/xen/xen_common.h:92:5: error: nested extern declaration of 'xc_hvm__destroy_ioreq_server' [-Werror=nested-externs]
cc1: all warnings being treated as errors
